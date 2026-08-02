import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/database/app_database.dart';
import 'package:harbor/media/ids.dart';
import 'package:harbor/services/jellyfin_api_cache.dart';

/// Pins the per-backend `applyWatchState` cache mutations. The two
/// implementations are duplicated by design (see ApiCache.applyWatchState's
/// drift-discipline note) — these tests are the enforcement arm: unit
/// conversions (ms ↔ 100-ns ticks, epoch-seconds ↔ ISO-8601) and the
/// intentional asymmetries fail here instead of drifting silently.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    JellyfinApiCache.initialize(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('JellyfinApiCache.applyWatchState', () {
    final serverId = ServerId('jf-srv');

    Map<String, dynamic> dto({int playCount = 0}) => {
      'Id': 'item-1',
      'Type': 'Movie',
      'Name': 'Movie',
      'UserData': {'Played': false, 'PlayCount': playCount, 'PlaybackPositionTicks': 990000},
    };

    Future<Map<String, dynamic>> readBack(String userId) async {
      final cached = await JellyfinApiCache.instance.get(serverId, '/Users/$userId/Items/item-1');
      return cached!['UserData'] as Map<String, dynamic>;
    }

    test('skips ambiguous bare scope when multiple users cache the same item', () async {
      await JellyfinApiCache.instance.put(serverId, '/Users/user-a/Items/item-1', dto());
      await JellyfinApiCache.instance.put(serverId, '/Users/user-b/Items/item-1', dto());

      await JellyfinApiCache.instance.applyWatchState(serverId: serverId, itemId: 'item-1', isWatched: true);

      expect((await readBack('user-a'))['Played'], isFalse);
      expect((await readBack('user-b'))['Played'], isFalse);
    });

    test('converts viewOffsetMs to 100-ns ticks', () async {
      await JellyfinApiCache.instance.put(serverId, '/Users/user-a/Items/item-1', dto());

      await JellyfinApiCache.instance.applyWatchState(
        serverId: serverId,
        itemId: 'item-1',
        isWatched: true,
        viewOffsetMs: 5000,
      );

      expect((await readBack('user-a'))['PlaybackPositionTicks'], 5000 * 10000);
    });

    test('converts epoch-seconds lastViewedAt to ISO-8601 LastPlayedDate', () async {
      await JellyfinApiCache.instance.put(serverId, '/Users/user-a/Items/item-1', dto());

      await JellyfinApiCache.instance.applyWatchState(
        serverId: serverId,
        itemId: 'item-1',
        isWatched: true,
        lastViewedAt: 1700000000,
      );

      final lastPlayed = (await readBack('user-a'))['LastPlayedDate'] as String;
      expect(DateTime.parse(lastPlayed), DateTime.fromMillisecondsSinceEpoch(1700000000 * 1000, isUtc: true));
    });

    test('watched flip preserves an existing PlayCount; unwatched zeroes it', () async {
      await JellyfinApiCache.instance.put(serverId, '/Users/user-a/Items/item-1', dto(playCount: 4));

      await JellyfinApiCache.instance.applyWatchState(serverId: serverId, itemId: 'item-1', isWatched: true);
      expect((await readBack('user-a'))['PlayCount'], 4);

      await JellyfinApiCache.instance.applyWatchState(serverId: serverId, itemId: 'item-1', isWatched: false);
      final userData = await readBack('user-a');
      expect(userData['PlayCount'], 0);
      expect(userData['Played'], isFalse);
    });

    test('viewedLeafCount is intentionally ignored (UnplayedItemCount stays server-computed)', () async {
      await JellyfinApiCache.instance.put(serverId, '/Users/user-a/Items/item-1', dto());

      await JellyfinApiCache.instance.applyWatchState(
        serverId: serverId,
        itemId: 'item-1',
        isWatched: true,
        viewedLeafCount: 9,
      );

      final userData = await readBack('user-a');
      expect(userData.containsKey('UnplayedItemCount'), isFalse);
      expect(userData.values, isNot(contains(9)));
    });

    test('malformed cached rows are skipped without throwing', () async {
      await db
          .into(db.apiCache)
          .insertOnConflictUpdate(
            ApiCacheCompanion(
              cacheKey: const Value('jf-srv:/Users/user-a/Items/item-1'),
              data: const Value('not json'),
              cachedAt: Value(DateTime.now()),
            ),
          );

      await JellyfinApiCache.instance.applyWatchState(serverId: serverId, itemId: 'item-1', isWatched: true);
    });
  });
}
