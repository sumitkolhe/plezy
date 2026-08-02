import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/connection/connection.dart';
import 'package:harbor/connection/connection_registry.dart';
import 'package:harbor/database/app_database.dart';
import 'package:harbor/profiles/profile.dart';
import 'package:harbor/profiles/profile_connection.dart';
import 'package:harbor/profiles/profile_connection_cleanup.dart';
import 'package:harbor/profiles/profile_connection_registry.dart';
import 'package:harbor/profiles/profile_registry.dart';
import 'package:harbor/services/storage_service.dart';

import '../test_helpers/prefs.dart';

JellyfinConnection _jellyfin({String machineId = 'jf-machine', String userId = 'user-a'}) {
  return JellyfinConnection(
    id: '$machineId/$userId',
    baseUrl: 'https://jellyfin.local',
    serverName: 'Jellyfin',
    serverMachineId: machineId,
    userId: userId,
    userName: userId,
    accessToken: 'token-$userId',
    deviceId: 'device-1',
    createdAt: DateTime.fromMillisecondsSinceEpoch(1_000_000),
    lastAuthenticatedAt: DateTime.fromMillisecondsSinceEpoch(1_000_000),
  );
}

ProfileConnection _row(String profileId, Connection conn, {String userIdentifier = 'user'}) {
  return ProfileConnection(profileId: profileId, connectionId: conn.id, userToken: 't', userIdentifier: userIdentifier);
}

void main() {
  late AppDatabase db;
  late ConnectionRegistry connections;
  late ProfileConnectionRegistry profileConnections;
  late StorageService storage;
  late ProfileConnectionCleanup cleanup;

  setUp(() async {
    resetSharedPreferencesForTest();
    db = AppDatabase.forTesting(NativeDatabase.memory());
    connections = ConnectionRegistry(db);
    profileConnections = ProfileConnectionRegistry(db);
    storage = await StorageService.getInstance();
    cleanup = ProfileConnectionCleanup(
      profileConnections: profileConnections,
      connections: connections,
      storage: storage,
    );
  });

  tearDown(() async {
    await db.close();
  });

  group('profile connection cleanup', () {
    test('removing the last Jellyfin profile link deletes the connection and profile prefs', () async {
      final conn = _jellyfin();
      await connections.upsert(conn);
      await profileConnections.upsert(
        ProfileConnection(
          profileId: 'p1',
          connectionId: conn.id,
          userToken: conn.accessToken,
          userIdentifier: conn.userId,
        ),
      );
      await storage.setActiveProfileId('p1');
      await storage.saveHiddenLibraries({'jf-machine:movies'});
      await storage.saveLibraryOrder(['jf-machine:movies']);

      await cleanup.removeProfileConnection(profileId: 'p1', connection: conn);

      expect(await profileConnections.listForConnection(conn.id), isEmpty);
      expect(await connections.get(conn.id), isNull);
      expect(storage.getHiddenLibraries(), isEmpty);
      expect(storage.getLibraryOrder(), isNull);
    });

    test('removing one profile link keeps a shared Jellyfin connection and other profile prefs', () async {
      final conn = _jellyfin();
      await connections.upsert(conn);
      await profileConnections.upsert(
        ProfileConnection(
          profileId: 'p1',
          connectionId: conn.id,
          userToken: conn.accessToken,
          userIdentifier: conn.userId,
        ),
      );
      await profileConnections.upsert(
        ProfileConnection(
          profileId: 'p2',
          connectionId: conn.id,
          userToken: conn.accessToken,
          userIdentifier: conn.userId,
        ),
      );

      await storage.setActiveProfileId('p1');
      await storage.saveHiddenLibraries({'jf-machine:movies'});
      await storage.setActiveProfileId('p2');
      await storage.saveHiddenLibraries({'jf-machine:movies'});

      await cleanup.removeProfileConnection(profileId: 'p1', connection: conn);

      expect(await connections.get(conn.id), isNotNull);
      final remaining = await profileConnections.listForConnection(conn.id);
      expect(remaining, hasLength(1));
      expect(remaining.single.profileId, 'p2');

      await storage.setActiveProfileId('p1');
      expect(storage.getHiddenLibraries(), isEmpty);
      await storage.setActiveProfileId('p2');
      expect(storage.getHiddenLibraries(), {'jf-machine:movies'});
    });

    test('startup prune removes unreferenced Jellyfin rows and stale prefs', () async {
      final conn = _jellyfin();
      await connections.upsert(conn);
      await storage.setActiveProfileId('p1');
      await storage.saveHiddenLibraries({'jf-machine:movies'});
      await storage.saveLibrarySort('jf-machine:movies', 'titleSort');

      final removed = await cleanup.pruneUnreferencedJellyfinConnections();

      expect(removed, 1);
      expect(await connections.get(conn.id), isNull);
      expect(storage.getHiddenLibraries(), isEmpty);
      expect(storage.getLibrarySort('jf-machine:movies'), isNull);
    });

    test('startup prune does not clear prefs when another user on the same server is still referenced', () async {
      final orphan = _jellyfin(userId: 'user-a');
      final sharedServer = _jellyfin(userId: 'user-b');
      await connections.upsert(orphan);
      await connections.upsert(sharedServer);
      await profileConnections.upsert(
        ProfileConnection(
          profileId: 'p2',
          connectionId: sharedServer.id,
          userToken: sharedServer.accessToken,
          userIdentifier: sharedServer.userId,
        ),
      );
      await storage.setActiveProfileId('p2');
      await storage.saveHiddenLibraries({'jf-machine:movies'});

      final removed = await cleanup.pruneUnreferencedJellyfinConnections();

      expect(removed, 1);
      expect(await connections.get(orphan.id), isNull);
      expect(await connections.get(sharedServer.id), isNotNull);
      expect(storage.getHiddenLibraries(), {'jf-machine:movies'});
    });
  });

  group('resolvePostRemovalState', () {
    late ProfileRegistry profileRegistry;

    setUp(() {
      profileRegistry = ProfileRegistry(db);
    });

    Future<({PostRemovalRoute route, List<Profile> profiles})> resolve() =>
        cleanup.resolvePostRemovalState(profileRegistry: profileRegistry);

    Profile local(String id) =>
        Profile.local(id: id, displayName: id, createdAt: DateTime.fromMillisecondsSinceEpoch(1_000_000));

    test('no connections → signed out', () async {
      final result = await resolve();
      expect(result.route, PostRemovalRoute.signedOut);
      expect(result.profiles, isEmpty);
    });

    test('only an orphaned Jellyfin connection → pruned, signed out (the #1423 wedge)', () async {
      final jf = _jellyfin();
      await connections.upsert(jf);

      final result = await resolve();

      expect(result.route, PostRemovalRoute.signedOut);
      expect(await connections.list(), isEmpty);
    });

    test('local profile survives alongside an orphaned Jellyfin connection → stay signed in, orphan pruned', () async {
      final jf = _jellyfin();
      final referencedJf = _jellyfin(userId: 'user-b');
      await connections.upsert(jf);
      await connections.upsert(referencedJf);
      await profileRegistry.upsert(local('local-1'));
      await profileConnections.upsert(_row('local-1', referencedJf));

      final result = await resolve();

      expect(result.route, PostRemovalRoute.staySignedIn);
      expect(result.profiles.single.id, 'local-1');
      expect(await connections.get(jf.id), isNull);
      expect(await connections.get(referencedJf.id), isNotNull);
    });
  });
}
