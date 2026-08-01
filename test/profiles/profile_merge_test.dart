import 'package:flutter_test/flutter_test.dart';
import 'package:plezy/profiles/profile.dart';
import 'package:plezy/profiles/profile_merge.dart';
import 'package:plezy/services/storage_service.dart';

import '../test_helpers/prefs.dart';

void main() {
  setUp(() {
    resetSharedPreferencesForTest();
  });

  group('hydrateProfiles', () {
    test('sorts by most recent usage', () async {
      final storage = await StorageService.getInstance();
      await storage.markProfileUsed('local-older', DateTime(2026, 1, 2));
      await storage.markProfileUsed('local-newer', DateTime(2026, 1, 3));

      final profiles = hydrateProfiles(
        locals: [
          Profile.local(id: 'local-older', displayName: 'Older', createdAt: DateTime(2026, 1, 1)),
          Profile.local(id: 'local-never', displayName: 'Never', createdAt: DateTime(2026, 1, 2)),
          Profile.local(id: 'local-newer', displayName: 'Newer', createdAt: DateTime(2026, 1, 3)),
        ],
        storage: storage,
      );

      expect(profiles.map((p) => p.id).toList(), ['local-newer', 'local-older', 'local-never']);
      expect(profiles.first.lastUsedAt, DateTime(2026, 1, 3));
    });

    test('keeps never-used profiles in fallback order', () {
      final profiles = hydrateProfiles(
        locals: [
          Profile.local(id: 'local-a', displayName: 'A', createdAt: DateTime(2026, 1, 1)),
          Profile.local(id: 'local-b', displayName: 'B', createdAt: DateTime(2026, 1, 2)),
        ],
      );

      expect(profiles.map((p) => p.id).toList(), ['local-a', 'local-b']);
    });

    test('uses the newest local timestamp from storage or the database row', () async {
      final storage = await StorageService.getInstance();
      await storage.markProfileUsed('local-storage-newer', DateTime(2026, 1, 4));
      await storage.markProfileUsed('local-db-newer', DateTime(2026, 1, 2));

      final profiles = hydrateProfiles(
        locals: [
          Profile.local(
            id: 'local-db-newer',
            displayName: 'DB newer',
            createdAt: DateTime(2026, 1, 1),
            lastUsedAt: DateTime(2026, 1, 3),
          ),
          Profile.local(id: 'local-storage-newer', displayName: 'Storage newer', createdAt: DateTime(2026, 1, 2)),
        ],
        storage: storage,
      );

      expect(profiles.map((p) => p.id).toList(), ['local-storage-newer', 'local-db-newer']);
      expect(profiles.first.lastUsedAt, DateTime(2026, 1, 4));
      expect(profiles.last.lastUsedAt, DateTime(2026, 1, 3));
    });
  });
}
