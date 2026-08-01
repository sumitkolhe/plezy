import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plezy/database/app_database.dart';
import 'package:plezy/media/ids.dart';
import 'package:plezy/services/api_cache.dart';
import 'package:plezy/services/jellyfin_api_cache.dart';

import '../test_helpers/media_items.dart';

void main() {
  late AppDatabase db;
  late JellyfinApiCache cache;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    JellyfinApiCache.initialize(db);
    cache = JellyfinApiCache.instance;
  });

  tearDown(() async {
    await db.close();
  });

  group('singleton', () {
    test('initialize swaps the underlying database', () async {
      final newDb = AppDatabase.forTesting(NativeDatabase.memory());
      JellyfinApiCache.initialize(newDb);
      expect(identical(JellyfinApiCache.instance.database, newDb), isTrue);
      await newDb.close();
    });

    test('registered cleanup preserves pinned rows', () async {
      await cache.put(ServerId('srv'), '/volatile', {'value': 1});
      await cache.put(ServerId('srv'), '/pinned', {'value': 2});
      await cache.pin(ServerId('srv'), '/pinned');

      await ApiCache.clearRegisteredVolatile();

      expect(await cache.get(ServerId('srv'), '/volatile'), isNull);
      expect(await cache.get(ServerId('srv'), '/pinned'), {'value': 2});
    });

    test('registering a new database repoints backend dispatch', () async {
      final newDb = AppDatabase.forTesting(NativeDatabase.memory());
      JellyfinApiCache.initialize(newDb);

      expect(identical(ApiCache.forBackend(null).database, newDb), isTrue);

      await newDb.close();
    });
  });

  group('shared row decoding', () {
    test('drops malformed rows without discarding valid siblings', () {
      final decoded = decodeCachedMediaRows(
        ['{"id":"first"}', 'not json', '[]', '{"id":"last"}'],
        serializedData: (row) => row,
        decode: (_, json) {
          final id = json['id'] as String;
          return MapEntry(id, testMediaItem(id: id));
        },
      );

      expect(decoded.keys, ['first', 'last']);
      expect(decoded['first']?.id, 'first');
      expect(decoded['last']?.id, 'last');
    });
  });
}
