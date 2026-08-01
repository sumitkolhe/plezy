import 'package:flutter_test/flutter_test.dart';
import 'package:plezy/connection/connection.dart';
import 'package:plezy/profiles/profile.dart';
import 'package:plezy/profiles/profile_connection.dart';
import 'package:plezy/providers/user_profile_provider.dart';
import 'package:plezy/services/multi_server_manager.dart';

import '../test_helpers/prefs.dart';
import '../test_helpers/profile_stack.dart';

void main() {
  setUp(resetSharedPreferencesForTest);

  group('UserProfileProvider (settings-only)', () {
    test('starts with null settings', () {
      final p = UserProfileProvider();
      expect(p.profileSettings, isNull);
      p.dispose();
    });

    test('refreshProfileSettings without a stored token is a no-op', () async {
      final p = UserProfileProvider();
      var notified = 0;
      p.addListener(() => notified++);
      await p.refreshProfileSettings();
      // No token → no API call → no notify, no error.
      expect(notified, 0);
      expect(p.profileSettings, isNull);
      p.dispose();
    });

    test('logout without initialization is safe', () async {
      final p = UserProfileProvider();
      await p.logout();
      expect(p.profileSettings, isNull);
      p.dispose();
    });

    test('safeNotifyListeners after dispose does not throw', () async {
      final p = UserProfileProvider();
      p.dispose();
      await p.logout();
    });

    test('settings connection follows the profile default row', () async {
      final stack = await ProfileStack.create();
      final manager = MultiServerManager();
      addTearDown(() async {
        manager.dispose();
        await stack.dispose();
      });

      final profile = Profile.local(id: 'local-owner', displayName: 'Owner', createdAt: DateTime(2026, 1, 1));
      final first = JellyfinConnection(
        id: 'jf-first/user-a',
        baseUrl: 'https://first.example.com',
        serverName: 'First',
        serverMachineId: 'jf-first',
        userId: 'user-a',
        userName: 'User A',
        accessToken: 'first-token',
        deviceId: 'device-a',
        createdAt: DateTime(2026, 1, 1),
      );
      final jellyfin = JellyfinConnection(
        id: 'jf-machine/user-a',
        baseUrl: 'https://jf.example.com',
        serverName: 'Jellyfin',
        serverMachineId: 'jf-machine',
        userId: 'user-a',
        userName: 'User A',
        accessToken: 'jf-token',
        deviceId: 'device-a',
        createdAt: DateTime(2026, 1, 1),
      );
      await stack.profiles.upsert(profile);
      await stack.connections.upsert(first);
      await stack.connections.upsert(jellyfin);
      await stack.profileConnections.upsert(
        ProfileConnection(
          profileId: profile.id,
          connectionId: first.id,
          userToken: 'first-user-token',
          userIdentifier: 'user-a',
          isDefault: true,
        ),
        makeDefault: true,
      );
      await stack.profileConnections.upsert(
        ProfileConnection(profileId: profile.id, connectionId: jellyfin.id, userIdentifier: jellyfin.userId),
      );
      await stack.storage.setActiveProfileId(profile.id);
      await stack.active.initialize();

      final p = UserProfileProvider()
        ..attach(
          connections: stack.connections,
          activeProfile: stack.active,
          profileConnections: stack.profileConnections,
          serverManager: manager,
        );
      addTearDown(p.dispose);

      expect((await p.debugResolveActiveSettingsConnectionForTesting())?.id, first.id);

      await stack.profileConnections.setDefault(profile.id, jellyfin.id);

      expect((await p.debugResolveActiveSettingsConnectionForTesting())?.id, jellyfin.id);
    });
  });
}
