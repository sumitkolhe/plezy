import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/providers/trackers_provider.dart';
import 'package:harbor/services/base_shared_preferences_service.dart';
import 'package:harbor/services/trackers/tracker_account_store.dart';
import 'package:harbor/services/trackers/tracker_constants.dart';
import 'package:harbor/services/trackers/tracker_coordinator.dart';
import 'package:harbor/services/trackers/tracker_session.dart';
import 'package:harbor/services/trackers/trakt/trakt_tracker.dart';

import '../test_helpers/io_fakes.dart';
import '../test_helpers/prefs.dart';

final _traktStore = trackerAccountStore(TrackerService.trakt);

TrackerSession _trakt({String? username}) => TrackerSession(
  accessToken: 'trakt-at',
  refreshToken: 'trakt-rt',
  expiresAt: DateTime.now().millisecondsSinceEpoch ~/ 1000 + 3600,
  createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
  username: username,
);

TrackerSession _session(String owner) => TrackerSession(
  accessToken: '$owner-trakt-at',
  refreshToken: '$owner-trakt-rt',
  expiresAt: 2000000000,
  createdAt: 1900000000,
  username: owner,
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
      expect(p.trakt, isNull);
      expect(p.isTraktConnected, isFalse);
      expect(p.traktUsername, isNull);
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

      expect(clients, hasLength(1));
      expect(clients.single.closeCount, 0);

      p.dispose();

      expect(clients.single.closeCount, 1);
      expect(clients.single.isClosed, isTrue);
    });

    test('onActiveProfileChanged loads sessions from per-profile stores', () async {
      const uuid = 'profile-1';
      await _traktStore.save(uuid, _trakt(username: 'dave'));

      // Reset cached singletons so the provider reads fresh prefs state.
      BaseSharedPreferencesService.resetForTesting();

      final p = TrackersProvider();
      var notified = 0;
      p.addListener(() => notified++);

      await _bindProfile(p, uuid);
      expect(p.isTraktConnected, isTrue);
      expect(p.traktUsername, 'dave');
      expect(notified, greaterThanOrEqualTo(1));

      p.dispose();
    });

    test('onActiveProfileChanged switching to empty profile clears all sessions', () async {
      const uuid = 'profile-1';
      await _traktStore.save(uuid, _trakt(username: 'dave'));
      BaseSharedPreferencesService.resetForTesting();

      final p = TrackersProvider();
      await _bindProfile(p, uuid);
      expect(p.isTraktConnected, isTrue);

      await _bindProfile(p, 'other-profile');
      expect(p.isTraktConnected, isFalse);

      p.dispose();
    });

    test('disconnectTrakt on a profile with no session is safe', () async {
      final p = TrackersProvider();
      // No `onActiveProfileChanged` — uuid is empty (global slot).
      // disconnectTrakt just clears the (already absent) entry and rebinds.
      await p.disconnectTrakt();
      expect(p.isTraktConnected, isFalse);
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

    test('stale connect cannot save or replace a newer binding after dispose', () async {
      const oldUuid = 'profile-old';
      const newUuid = 'profile-new';
      final newSession = _session('new');
      await _traktStore.save(newUuid, newSession);
      BaseSharedPreferencesService.resetForTesting();

      final pipeline = _ControlledConnectPipeline(_session('old'));
      final oldProvider = TrackersProvider.forTesting(connectPipeline: pipeline.call);
      await _bindProfile(oldProvider, oldUuid);
      final connect = oldProvider.connectTrakt(onCodeReady: (_) {});
      await pipeline.beforeSave.future;

      oldProvider.dispose();
      final newProvider = TrackersProvider();
      await _bindProfile(newProvider, newUuid);
      final newBinding = TraktTracker.instance.client;
      expect(newBinding, isNotNull);
      expect(newProvider.trakt?.accessToken, newSession.accessToken);

      pipeline.releaseBeforeSave.complete();
      expect(await connect, isFalse);
      expect(await _traktStore.load(oldUuid), isNull);
      expect((await _traktStore.load(newUuid))?.accessToken, newSession.accessToken);
      expect(TraktTracker.instance.client, same(newBinding));
      expect(TraktTracker.instance.client?.session.accessToken, newSession.accessToken);
      expect(oldProvider.trakt, isNull);

      newProvider.dispose();
    });

    test('cancel invalidates a connect after authorization and before save', () async {
      const uuid = 'profile-cancel';
      final pipeline = _ControlledConnectPipeline(_session('cancelled'));
      final p = TrackersProvider.forTesting(connectPipeline: pipeline.call);
      await _bindProfile(p, uuid);

      final connect = p.connectTrakt(onCodeReady: (_) {});
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
      final newSession = _session('new');
      await _traktStore.save(newUuid, newSession);
      BaseSharedPreferencesService.resetForTesting();

      final pipeline = _ControlledConnectPipeline(_session('old'));
      final p = TrackersProvider.forTesting(connectPipeline: pipeline.call);
      await _bindProfile(p, oldUuid);
      final connect = p.connectTrakt(onCodeReady: (_) {});
      await pipeline.beforeSave.future;

      await _bindProfile(p, newUuid);
      final newBinding = TraktTracker.instance.client;
      pipeline.releaseBeforeSave.complete();

      expect(await connect, isFalse);
      expect(await _traktStore.load(oldUuid), isNull);
      expect((await _traktStore.load(newUuid))?.accessToken, newSession.accessToken);
      expect(p.trakt?.accessToken, newSession.accessToken);
      expect(TraktTracker.instance.client, same(newBinding));
      expect(TraktTracker.instance.client?.session.accessToken, newSession.accessToken);
      p.dispose();
    });

    test('same-service disconnect invalidates an in-flight connect', () async {
      const uuid = 'profile-same-disconnect';
      final pipeline = _ControlledConnectPipeline(_session('late'));
      final p = TrackersProvider.forTesting(connectPipeline: pipeline.call);
      await _bindProfile(p, uuid);
      final connect = p.connectTrakt(onCodeReady: (_) {});
      await pipeline.beforeSave.future;

      await p.disconnectTrakt();
      pipeline.releaseBeforeSave.complete();

      expect(await connect, isFalse);
      expect(p.trakt, isNull);
      expect(await _traktStore.load(uuid), isNull);
      expect(TraktTracker.instance.client, isNull);
      p.dispose();
    });

    test('dispose after save cannot assign or erase a newer same-profile binding', () async {
      const uuid = 'profile-save-race';
      final freshSession = _session('fresh');
      final pipeline = _ControlledConnectPipeline(_session('stale'), pauseAfterSave: true);
      final staleProvider = TrackersProvider.forTesting(connectPipeline: pipeline.call);
      await _bindProfile(staleProvider, uuid);
      final connect = staleProvider.connectTrakt(onCodeReady: (_) {});
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
  TraktTracker.instance.rebindSession(null, onSessionInvalidated: () {});
}

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
