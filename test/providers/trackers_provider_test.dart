import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/providers/trackers_provider.dart';
import 'package:harbor/services/base_shared_preferences_service.dart';
import 'package:harbor/services/trackers/tracker_account_store.dart';
import 'package:harbor/services/trackers/tracker_constants.dart';
import 'package:harbor/services/trackers/tracker_coordinator.dart';
import 'package:harbor/services/trackers/tracker_session.dart';
import 'package:harbor/services/trackers/simkl/simkl_tracker.dart';
import 'package:harbor/services/trackers/trakt/trakt_tracker.dart';

import '../test_helpers/io_fakes.dart';
import '../test_helpers/prefs.dart';

final _simklStore = trackerAccountStore(TrackerService.simkl);
final _traktStore = trackerAccountStore(TrackerService.trakt);

TrackerSession _simkl({String? username}) => TrackerSession(
  accessToken: 'simkl-at',
  createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
  username: username,
);

TrackerSession _trakt({String? username}) => TrackerSession(
  accessToken: 'trakt-at',
  refreshToken: 'trakt-rt',
  expiresAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 3600,
  createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
  username: username,
);

Future<void> _bindProfile(TrackersProvider provider, String? userUuid) async {
  await provider.onActiveProfileChanged(userUuid);
  await TrackerCoordinator.instance.flushWriteQueue();
}

void main() {
  setUp(() {
    resetSharedPreferencesForTest();
    _resetTrackerBindings();
  });
  tearDown(_resetTrackerBindings);

  group('TrackersProvider', () {
    test('starts with all trackers disconnected', () {
      final p = TrackersProvider();
      expect(p.simkl, isNull);
      expect(p.trakt, isNull);
      expect(p.isSimklConnected, isFalse);
      expect(p.isTraktConnected, isFalse);
      expect(p.simklUsername, isNull);
      expect(p.traktUsername, isNull);
      expect(p.isConnecting(TrackerService.simkl), isFalse);
      expect(p.isConnecting(TrackerService.trakt), isFalse);
      p.dispose();
    });

    test('forTesting owns one fresh client per eager auth owner', () {
      final clients = <FakeHttpClient>[];
      final p = TrackersProvider.forTesting(
        connectPipeline: _ControlledConnectPipeline(_trakt()).call,
        httpClientFactory: () {
          final client = FakeHttpClient(200, const <int>[]);
          clients.add(client);
          return client;
        },
      );

      expect(clients, hasLength(2));
      expect(clients.toSet(), hasLength(2));
      for (final client in clients) {
        expect(client.closeCount, 0);
      }

      p.dispose();

      for (final client in clients) {
        expect(client.closeCount, 1);
        expect(client.isClosed, isTrue);
      }
    });

    test('onActiveProfileChanged loads sessions from per-profile stores', () async {
      const uuid = 'profile-1';
      await _simklStore.save(uuid, _simkl(username: 'carol'));
      await _traktStore.save(uuid, _trakt(username: 'dave'));

      // Reset cached singletons so the provider reads fresh prefs state.
      BaseSharedPreferencesService.resetForTesting();

      final p = TrackersProvider();
      var notified = 0;
      p.addListener(() => notified++);

      await _bindProfile(p, uuid);
      expect(p.isSimklConnected, isTrue);
      expect(p.isTraktConnected, isTrue);
      expect(p.simklUsername, 'carol');
      expect(p.traktUsername, 'dave');
      expect(notified, greaterThanOrEqualTo(1));

      p.dispose();
    });

    test('onActiveProfileChanged switching to empty profile clears all sessions', () async {
      const uuid = 'profile-1';
      await _simklStore.save(uuid, _simkl(username: 'carol'));
      await _traktStore.save(uuid, _trakt(username: 'dave'));
      BaseSharedPreferencesService.resetForTesting();

      final p = TrackersProvider();
      await _bindProfile(p, uuid);
      expect(p.isSimklConnected, isTrue);

      await _bindProfile(p, 'other-profile');
      expect(p.isSimklConnected, isFalse);
      expect(p.isTraktConnected, isFalse);

      p.dispose();
    });

    test('onActiveProfileChanged loads only the populated stores', () async {
      const uuid = 'profile-2';
      // Only Simkl is set up — Trakt remains absent.
      await _simklStore.save(uuid, _simkl(username: 'bob'));
      BaseSharedPreferencesService.resetForTesting();

      final p = TrackersProvider();
      await _bindProfile(p, uuid);
      expect(p.isSimklConnected, isTrue);
      expect(p.simklUsername, 'bob');
      expect(p.isTraktConnected, isFalse);
      p.dispose();
    });

    test('disconnect during an in-flight profile load keeps the other trackers loaded', () async {
      const uuid = 'profile-race';
      await _simklStore.save(uuid, _simkl(username: 'carol'));
      await _traktStore.save(uuid, _trakt(username: 'dave'));
      BaseSharedPreferencesService.resetForTesting();

      final p = TrackersProvider();
      // Start the load, then disconnect Simkl before it resolves.
      final load = _bindProfile(p, uuid);
      await p.disconnectSimkl();
      await load;

      // Simkl stays disconnected (and cleared) — the racing load must not
      // resurrect it — but it also must not drop Trakt.
      expect(p.isSimklConnected, isFalse);
      expect(await _simklStore.load(uuid), isNull);
      expect(p.isTraktConnected, isTrue);
      expect(p.traktUsername, 'dave');

      p.dispose();
    });

    test('disconnectSimkl on a profile with no session is safe', () async {
      final p = TrackersProvider();
      // No `onActiveProfileChanged` — uuid is empty (global slot).
      // disconnectSimkl just clears the (already absent) entry and rebinds.
      await p.disconnectSimkl();
      expect(p.isSimklConnected, isFalse);
      p.dispose();
    });

    test('cancelConnect is a no-op when not connecting', () {
      final p = TrackersProvider();
      expect(() => p.cancelConnect(), returnsNormally);
      expect(p.isConnecting(TrackerService.trakt), isFalse);
      p.dispose();
    });

    test('safeNotifyListeners after dispose is a no-op', () async {
      final p = TrackersProvider();
      p.dispose();
      // Post-dispose rebind should not throw.
      await _bindProfile(p, 'any-uuid');
    });
    for (final service in [TrackerService.simkl, TrackerService.trakt]) {
      test('$service stale connect cannot save or replace a newer binding after dispose', () async {
        const oldUuid = 'profile-old';
        const newUuid = 'profile-new';
        final oldSession = _session(service, 'old');
        final newSession = _session(service, 'new');
        await _store(service).save(newUuid, newSession);
        BaseSharedPreferencesService.resetForTesting();

        final pipeline = _ControlledConnectPipeline(oldSession);
        final oldProvider = TrackersProvider.forTesting(connectPipeline: pipeline.call);
        await _bindProfile(oldProvider, oldUuid);
        final connect = _connect(oldProvider, service);
        await pipeline.beforeSave.future;

        oldProvider.dispose();
        final newProvider = TrackersProvider();
        await _bindProfile(newProvider, newUuid);
        final newBinding = _boundClient(service);
        expect(newBinding, isNotNull);
        expect(_providerSession(newProvider, service)?.accessToken, newSession.accessToken);

        pipeline.releaseBeforeSave.complete();
        expect(await connect, isFalse);
        expect(await _store(service).load(oldUuid), isNull);
        expect((await _store(service).load(newUuid))?.accessToken, newSession.accessToken);
        expect(_boundClient(service), same(newBinding));
        expect(_boundSession(service)?.accessToken, newSession.accessToken);
        expect(_providerSession(oldProvider, service), isNull);

        newProvider.dispose();
      });
    }

    test('cancel invalidates a connect after authorization and before save', () async {
      const uuid = 'profile-cancel';
      final pipeline = _ControlledConnectPipeline(_session(TrackerService.trakt, 'cancelled'));
      final p = TrackersProvider.forTesting(connectPipeline: pipeline.call);
      await _bindProfile(p, uuid);

      final connect = _connect(p, TrackerService.trakt);
      await pipeline.beforeSave.future;
      p.cancelConnect();
      pipeline.releaseBeforeSave.complete();

      expect(await connect, isFalse);
      expect(p.isConnecting(TrackerService.trakt), isFalse);
      expect(p.trakt, isNull);
      expect(await _traktStore.load(uuid), isNull);
      expect(TraktTracker.instance.client, isNull);
      p.dispose();
    });

    test('profile change invalidates the old connect and preserves the new binding', () async {
      const oldUuid = 'profile-change-old';
      const newUuid = 'profile-change-new';
      final oldSession = _session(TrackerService.simkl, 'old');
      final newSession = _session(TrackerService.simkl, 'new');
      await _simklStore.save(newUuid, newSession);
      BaseSharedPreferencesService.resetForTesting();

      final pipeline = _ControlledConnectPipeline(oldSession);
      final p = TrackersProvider.forTesting(connectPipeline: pipeline.call);
      await _bindProfile(p, oldUuid);
      final connect = _connect(p, TrackerService.simkl);
      await pipeline.beforeSave.future;

      await _bindProfile(p, newUuid);
      final newBinding = SimklTracker.instance.client;
      pipeline.releaseBeforeSave.complete();

      expect(await connect, isFalse);
      expect(await _simklStore.load(oldUuid), isNull);
      expect((await _simklStore.load(newUuid))?.accessToken, newSession.accessToken);
      expect(p.simkl?.accessToken, newSession.accessToken);
      expect(SimklTracker.instance.client, same(newBinding));
      expect(SimklTracker.instance.client?.session.accessToken, newSession.accessToken);
      p.dispose();
    });

    test('same-service disconnect invalidates an in-flight connect', () async {
      const uuid = 'profile-same-disconnect';
      final pipeline = _ControlledConnectPipeline(_session(TrackerService.simkl, 'late'));
      final p = TrackersProvider.forTesting(connectPipeline: pipeline.call);
      await _bindProfile(p, uuid);
      final connect = _connect(p, TrackerService.simkl);
      await pipeline.beforeSave.future;

      await p.disconnectSimkl();
      pipeline.releaseBeforeSave.complete();

      expect(await connect, isFalse);
      expect(p.simkl, isNull);
      expect(await _simklStore.load(uuid), isNull);
      expect(SimklTracker.instance.client, isNull);
      p.dispose();
    });

    test('unrelated disconnect leaves an allowed connect current', () async {
      const uuid = 'profile-unrelated-disconnect';
      final linkedAnilist = _session(TrackerService.simkl, 'linked');
      final connectedMal = _session(TrackerService.trakt, 'connected');
      await _simklStore.save(uuid, linkedAnilist);
      BaseSharedPreferencesService.resetForTesting();

      final pipeline = _ControlledConnectPipeline(connectedMal);
      final p = TrackersProvider.forTesting(connectPipeline: pipeline.call);
      await _bindProfile(p, uuid);
      final connect = _connect(p, TrackerService.trakt);
      await pipeline.beforeSave.future;

      await p.disconnectSimkl();
      pipeline.releaseBeforeSave.complete();

      expect(await connect, isTrue);
      await TrackerCoordinator.instance.flushWriteQueue();
      expect(p.simkl, isNull);
      expect(p.trakt?.accessToken, connectedMal.accessToken);
      expect((await _traktStore.load(uuid))?.accessToken, connectedMal.accessToken);
      expect(TraktTracker.instance.client?.session.accessToken, connectedMal.accessToken);
      p.dispose();
    });

    test('dispose after save cannot assign or erase a newer same-profile binding', () async {
      const uuid = 'profile-save-race';
      final staleSession = _session(TrackerService.trakt, 'stale');
      final freshSession = _session(TrackerService.trakt, 'fresh');
      final pipeline = _ControlledConnectPipeline(staleSession, pauseAfterSave: true);
      final staleProvider = TrackersProvider.forTesting(connectPipeline: pipeline.call);
      await _bindProfile(staleProvider, uuid);
      final connect = _connect(staleProvider, TrackerService.trakt);
      await pipeline.beforeSave.future;
      pipeline.releaseBeforeSave.complete();
      await pipeline.afterSave.future;

      staleProvider.dispose();
      await _traktStore.save(uuid, freshSession);
      BaseSharedPreferencesService.resetForTesting();
      final freshProvider = TrackersProvider();
      await _bindProfile(freshProvider, uuid);
      final freshBinding = TraktTracker.instance.client;
      pipeline.releaseAfterSave.complete();

      expect(await connect, isFalse);
      expect((await _traktStore.load(uuid))?.accessToken, freshSession.accessToken);
      expect(TraktTracker.instance.client, same(freshBinding));
      expect(TraktTracker.instance.client?.session.accessToken, freshSession.accessToken);
      expect(staleProvider.trakt, isNull);
      freshProvider.dispose();
    });
  });
}

void _resetTrackerBindings() {
  SimklTracker.instance.rebindSession(null, onSessionInvalidated: () {});
  TraktTracker.instance.rebindSession(null, onSessionInvalidated: () {});
}

TrackerAccountStore _store(TrackerService service) => switch (service) {
  TrackerService.simkl => _simklStore,
  TrackerService.trakt => _traktStore,
};

TrackerSession _session(TrackerService service, String owner) => switch (service) {
  TrackerService.simkl => TrackerSession(accessToken: '$owner-simkl-at', createdAt: 1900000000, username: owner),
  TrackerService.trakt => TrackerSession(
    accessToken: '$owner-trakt-at',
    refreshToken: '$owner-trakt-rt',
    expiresAt: 2000000000,
    createdAt: 1900000000,
    username: owner,
  ),
};

Future<bool> _connect(TrackersProvider provider, TrackerService service) => switch (service) {
  TrackerService.simkl => provider.connectSimkl(onCodeReady: (_) {}),
  TrackerService.trakt => provider.connectTrakt(onCodeReady: (_) {}),
};

TrackerSession? _providerSession(TrackersProvider provider, TrackerService service) => switch (service) {
  TrackerService.simkl => provider.simkl,
  TrackerService.trakt => provider.trakt,
};

Object? _boundClient(TrackerService service) => switch (service) {
  TrackerService.simkl => SimklTracker.instance.client,
  TrackerService.trakt => TraktTracker.instance.client,
};

TrackerSession? _boundSession(TrackerService service) => switch (service) {
  TrackerService.simkl => SimklTracker.instance.client?.session,
  TrackerService.trakt => TraktTracker.instance.client?.session,
};

class _ControlledConnectPipeline {
  _ControlledConnectPipeline(this.session, {this.pauseAfterSave = false});

  final TrackerSession session;
  final bool pauseAfterSave;
  final beforeSave = Completer<void>();
  final releaseBeforeSave = Completer<void>();
  final afterSave = Completer<void>();
  final releaseAfterSave = Completer<void>();

  Future<bool> call({
    required String logLabel,
    required Future<TrackerSession?> Function() authorize,
    required Future<TrackerSession> Function(TrackerSession raw) enrich,
    required Future<void> Function(TrackerSession enriched) save,
    required void Function(TrackerSession enriched) assign,
  }) async {
    beforeSave.complete();
    await releaseBeforeSave.future;
    await save(session);
    afterSave.complete();
    if (pauseAfterSave) await releaseAfterSave.future;
    assign(session);
    return true;
  }
}
