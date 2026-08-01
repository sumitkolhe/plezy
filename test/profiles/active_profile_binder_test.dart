import 'dart:async';
import 'package:plezy/media/ids.dart';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plezy/connection/connection.dart';
import 'package:plezy/connection/connection_registry.dart';
import 'package:plezy/database/app_database.dart';
import 'package:plezy/profiles/active_profile_binder.dart';
import 'package:plezy/profiles/active_profile_provider.dart';
import 'package:plezy/profiles/profile.dart';
import 'package:plezy/profiles/profile_connection.dart';
import 'package:plezy/profiles/profile_connection_registry.dart';
import 'package:plezy/profiles/profile_registry.dart';
import 'package:plezy/providers/multi_server_provider.dart';
import 'package:plezy/services/multi_server_manager.dart';
import 'package:plezy/services/storage_service.dart';

import '../test_helpers/multi_server_fixtures.dart';
import '../test_helpers/prefs.dart';

/// Poll [condition] until it holds, failing after [timeout]. Used to observe
/// the binder's unawaited background reconcile settling.
Future<void> pumpUntil(Future<bool> Function() condition, {Duration timeout = const Duration(seconds: 2)}) async {
  final deadline = DateTime.now().add(timeout);
  while (!await condition()) {
    if (DateTime.now().isAfter(deadline)) {
      fail('condition not met within $timeout');
    }
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
}

void main() {
  late AppDatabase db;
  late ConnectionRegistry connections;
  late ProfileConnectionRegistry profileConnections;
  late ProfileRegistry profiles;
  late ActiveProfileProvider activeProfile;
  late MultiServerManager manager;
  late MultiServerProvider multiServerProvider;
  late ActiveProfileBinder binder;
  late StorageService storage;
  late bool shouldDeferInitialBind;

  setUp(() async {
    resetSharedPreferencesForTest();
    db = AppDatabase.forTesting(NativeDatabase.memory());
    connections = ConnectionRegistry(db);
    profileConnections = ProfileConnectionRegistry(db);
    profiles = ProfileRegistry(db);
    storage = await StorageService.getInstance();
    activeProfile = ActiveProfileProvider(registry: profiles, connections: connections, storage: storage);
    manager = MultiServerManager();
    multiServerProvider = testMultiServerProvider(manager);
    shouldDeferInitialBind = false;
    binder = ActiveProfileBinder(
      activeProfile: activeProfile,
      connections: connections,
      profileConnections: profileConnections,
      serverManager: manager,
      multiServerProvider: multiServerProvider,
      shouldDeferInitialBind: (_) async => shouldDeferInitialBind,
    );
  });

  tearDown(() async {
    binder.dispose();
    multiServerProvider.dispose();
    await activeProfile.resetForTesting();
    activeProfile.dispose();
    await db.close();
  });

  Future<Profile> createActiveLocalProfile(String id) async {
    final profile = Profile.local(id: id, displayName: 'Owner', createdAt: DateTime(2026, 1, 1));
    await profiles.upsert(profile);
    await storage.setActiveProfileId(profile.id);
    await activeProfile.initialize();
    return profile;
  }

  test('local profile with no connections binds successfully with empty visibility', () async {
    final profile = Profile.local(id: 'local-owner', displayName: 'Owner', createdAt: DateTime(2026, 1, 1));
    await profiles.upsert(profile);
    await storage.setActiveProfileId(profile.id);
    await activeProfile.initialize();

    await binder.rebindActive();

    expect(activeProfile.lastBindingSucceeded, isTrue);
    expect(binder.debugLastBoundProfileId, profile.id);
    expect(multiServerProvider.serverIds, isEmpty);
  });

  test('started binder does not loop forever after empty local bind', () async {
    final profile = Profile.local(id: 'local-empty', displayName: 'Empty', createdAt: DateTime(2026, 1, 1));
    await profiles.upsert(profile);
    await storage.setActiveProfileId(profile.id);
    await activeProfile.initialize();

    var notifications = 0;
    activeProfile.addListener(() => notifications++);
    binder.start();

    await Future<void>.delayed(const Duration(milliseconds: 50));

    expect(activeProfile.isBinding, isFalse);
    expect(activeProfile.lastBindingSucceeded, isTrue);
    expect(binder.debugLastBoundProfileId, profile.id);
    expect(notifications, lessThan(8));
  });

  test('start() marks binding synchronously so first-frame readers see it', () async {
    await createActiveLocalProfile('local-sync-start');

    binder.start();

    // Read with no await in between — mirrors DiscoverScreen's no-servers
    // gate running during the first build right after a fresh login.
    expect(activeProfile.isBinding, isTrue);

    final succeeded = await activeProfile.awaitBindingSettle();
    expect(succeeded, isTrue);
    expect(activeProfile.isBinding, isFalse);
    expect(binder.debugLastBoundProfileId, 'local-sync-start');
  });

  test('disposing before the initial rebind microtask clears the binding flag', () async {
    await createActiveLocalProfile('local-dispose-early');

    binder.start();
    expect(activeProfile.isBinding, isTrue);
    binder.dispose();

    // Let the scheduled microtask observe the disposal.
    await Future<void>.delayed(Duration.zero);
    expect(activeProfile.isBinding, isFalse);
  });

  test('initial bind can be deferred until profile selection', () async {
    final profile = await createActiveLocalProfile('local-deferred');
    shouldDeferInitialBind = true;

    await binder.rebindActive();

    expect(activeProfile.lastBindingSucceeded, isTrue);
    expect(activeProfile.isBinding, isFalse);
    expect(binder.debugLastBoundProfileId, isNull);
    expect(binder.consumeUserInitiatedActivation(profile.id), isFalse);
    expect(multiServerProvider.serverIds, isEmpty);
  });

  test('user initiated activation bypasses initial bind defer', () async {
    final profile = await createActiveLocalProfile('local-user-initiated');
    shouldDeferInitialBind = true;
    binder.markUserInitiatedActivation(profile.id);

    await binder.rebindActive();

    expect(activeProfile.lastBindingSucceeded, isTrue);
    expect(binder.debugLastBoundProfileId, profile.id);
    expect(binder.consumeUserInitiatedActivation(profile.id), isFalse);
  });

  group('rebind cycle semantics', () {
    test('queued same-id rebind settles once, after the last pass', () async {
      binder.dispose();
      multiServerProvider.dispose();

      final gated = _GatedJellyfinManager();
      manager = gated;
      multiServerProvider = testMultiServerProvider(manager);
      binder = ActiveProfileBinder(
        activeProfile: activeProfile,
        connections: connections,
        profileConnections: profileConnections,
        serverManager: manager,
        multiServerProvider: multiServerProvider,
        shouldDeferInitialBind: (_) async => false,
      );

      final profile = await createActiveLocalProfile('local-queued');
      final jellyfin = _jellyfinConnection();
      await connections.upsert(jellyfin);
      await profileConnections.upsert(
        ProfileConnection(profileId: profile.id, connectionId: jellyfin.id, userIdentifier: jellyfin.userId),
      );

      final cycle = binder.rebindActive();
      await pumpUntil(() async => gated.calls == 1);

      int? callsAtSettle;
      unawaited(activeProfile.awaitBindingSettle().then((_) => callsAtSettle = gated.calls));
      unawaited(binder.rebindActive()); // queues a same-id follow-up pass
      gated.gate.complete();
      await cycle;
      await Future<void>.delayed(Duration.zero);

      expect(gated.calls, 2);
      // Waiters must observe the whole cycle, not the first pass's outcome.
      expect(callsAtSettle, 2);
      expect(activeProfile.isBinding, isFalse);
    });

    test('A to B to A during one pass forces a complete final A bind', () async {
      binder.dispose();
      multiServerProvider.dispose();

      final gated = _GatedJellyfinManager();
      manager = gated;
      multiServerProvider = testMultiServerProvider(manager);
      binder = ActiveProfileBinder(
        activeProfile: activeProfile,
        connections: connections,
        profileConnections: profileConnections,
        serverManager: manager,
        multiServerProvider: multiServerProvider,
        shouldDeferInitialBind: (_) async => false,
      );

      final profileA = await createActiveLocalProfile('local-a');
      final profileB = Profile.local(id: 'local-b', displayName: 'B', createdAt: DateTime(2026, 1, 2));
      await profiles.upsert(profileB);
      await pumpUntil(() async => activeProfile.profiles.any((profile) => profile.id == profileB.id));

      final jellyfin = _jellyfinConnection();
      await connections.upsert(jellyfin);
      await profileConnections.upsert(
        ProfileConnection(profileId: profileA.id, connectionId: jellyfin.id, userIdentifier: jellyfin.userId),
      );

      binder.start();
      await pumpUntil(() async => gated.calls == 1);

      expect(await activeProfile.activate(profileB), isTrue);
      expect(await activeProfile.activate(profileA), isTrue);
      gated.gate.complete();
      await activeProfile.awaitBindingSettle();

      expect(gated.calls, 2);
      expect(binder.debugLastBoundProfileId, profileA.id);
      expect(multiServerProvider.onlineServerIds, ['jf-machine']);
      expect(activeProfile.lastBindingSucceeded, isTrue);
    });
    test('passive notifications do not retry a failed profile; explicit rebind does', () async {
      binder.dispose();
      multiServerProvider.dispose();

      final failing = _CountingFailingJellyfinManager();
      manager = failing;
      multiServerProvider = testMultiServerProvider(manager);
      binder = ActiveProfileBinder(
        activeProfile: activeProfile,
        connections: connections,
        profileConnections: profileConnections,
        serverManager: manager,
        multiServerProvider: multiServerProvider,
        shouldDeferInitialBind: (_) async => false,
      );

      final profile = await createActiveLocalProfile('local-failing');
      final jellyfin = _jellyfinConnection();
      await connections.upsert(jellyfin);
      await profileConnections.upsert(
        ProfileConnection(profileId: profile.id, connectionId: jellyfin.id, userIdentifier: jellyfin.userId),
      );

      binder.start();
      await pumpUntil(() async => failing.calls == 1 && !activeProfile.isBinding);
      expect(activeProfile.lastBindingSucceeded, isFalse);

      // A passive data change (an unrelated connection appearing) must not
      // re-run the failed bind — mid-session retries can pop PIN prompts.
      await connections.upsert(_jellyfinConnection2());
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(failing.calls, 1);

      // An explicit rebind clears the marker and retries.
      await binder.rebindActive();
      expect(failing.calls, greaterThan(1));
    });
  });
}

JellyfinConnection _jellyfinConnection() {
  return JellyfinConnection(
    id: 'jf-machine/user-a',
    baseUrl: 'https://jellyfin.example',
    serverName: 'Jellyfin',
    serverMachineId: 'jf-machine',
    userId: 'user-a',
    userName: 'User A',
    accessToken: 'token',
    deviceId: 'device',
    createdAt: DateTime(2026, 1, 1),
  );
}

JellyfinConnection _jellyfinConnection2() {
  return JellyfinConnection(
    id: 'jf-other/user-b',
    baseUrl: 'https://other.example',
    serverName: 'Other',
    serverMachineId: 'jf-other',
    userId: 'user-b',
    userName: 'User B',
    accessToken: 'token-b',
    deviceId: 'device',
    createdAt: DateTime(2026, 1, 2),
  );
}

class _GatedJellyfinManager extends MultiServerManager {
  final Completer<void> gate = Completer<void>();
  int calls = 0;

  @override
  Future<bool> addJellyfinConnection(JellyfinConnection connection) async {
    calls++;
    if (calls == 1) await gate.future;
    updateServerStatus(ServerId(connection.serverMachineId), true);
    return true;
  }
}

class _CountingFailingJellyfinManager extends MultiServerManager {
  int calls = 0;

  @override
  Future<bool> addJellyfinConnection(JellyfinConnection connection) async {
    calls++;
    updateServerStatus(ServerId(connection.serverMachineId), false);
    return false;
  }
}
