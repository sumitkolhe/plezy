import 'dart:convert';
import 'dart:io';
import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/database/app_database.dart';
import 'package:harbor/database/download_operations.dart';
import 'package:harbor/media/ids.dart';
import 'package:harbor/models/download_models.dart';

import '../test_helpers/download_fixtures.dart';

final class _EnsureOpenTrackingInterceptor extends QueryInterceptor {
  var calls = 0;
  var completed = false;

  @override
  Future<bool> ensureOpen(QueryExecutor executor, QueryExecutorUser user) async {
    calls++;
    final result = await executor.ensureOpen(user);
    completed = true;
    return result;
  }
}

void main() {
  final suite = _AppDatabaseTestSuite();
  suite.registerTests();
}

class _AppDatabaseTestSuite {
  late AppDatabase db;

  void registerTests() {
    setUp(() {
      db = AppDatabase.forTesting(NativeDatabase.memory());
    });

    tearDown(() async {
      await db.close();
    });

    _registerSchemaTests();
    _registerApiCacheTests();
    _registerDownloadedMediaTests();
    _registerOfflineWatchProgressTests();
    _registerSyncRulesTests();
  }

  void _registerSchemaTests() {
    // ============================================================
    // Schema sanity
    // ============================================================

    group('schema', () {
      test('all tables are accessible and start empty', () async {
        expect(await db.select(db.downloadedMedia).get(), isEmpty);
        expect(await db.select(db.downloadOwners).get(), isEmpty);
        expect(await db.select(db.downloadQueue).get(), isEmpty);
        expect(await db.select(db.apiCache).get(), isEmpty);
        expect(await db.select(db.offlineWatchProgress).get(), isEmpty);
        expect(await db.select(db.syncRules).get(), isEmpty);
        expect(await db.select(db.connections).get(), isEmpty);
        expect(await db.select(db.profiles).get(), isEmpty);
        expect(await db.select(db.profileConnections).get(), isEmpty);
      });

      test('ProfileConnections has no profile_id FK (virtual plex_home profiles)', () async {
        // v20 dropped the profile_id FK so virtual Plex Home profiles can
        // persist join rows without a parent `profiles` row. Profile deletion
        // instead cleans up join rows explicitly (via the teardown flow's
        // ProfileConnectionCleanup.removeAllProfileConnections) before deleting
        // the profile, so the cascade isn't needed.
        final now = DateTime.now().millisecondsSinceEpoch;
        await db
            .into(db.connections)
            .insert(
              ConnectionsCompanion.insert(id: 'c1', kind: 'plex', displayName: 'C1', configJson: '{}', createdAt: now),
            );
        // No `profiles` row inserted — this would have failed pre-v20.
        await db
            .into(db.profileConnections)
            .insert(
              ProfileConnectionsCompanion.insert(
                profileId: 'plex-home-c1-uuid',
                connectionId: 'c1',
                userIdentifier: 'uuid',
              ),
            );
        expect(await db.select(db.profileConnections).get(), hasLength(1));
      });

      test('ProfileConnections FK cascades when a Connection is deleted', () async {
        final now = DateTime.now().millisecondsSinceEpoch;
        await db
            .into(db.connections)
            .insert(
              ConnectionsCompanion.insert(id: 'c2', kind: 'plex', displayName: 'C2', configJson: '{}', createdAt: now),
            );
        await db
            .into(db.profiles)
            .insert(
              ProfilesCompanion.insert(id: 'p2', kind: 'local', displayName: 'P2', configJson: '{}', createdAt: now),
            );
        await db
            .into(db.profileConnections)
            .insert(ProfileConnectionsCompanion.insert(profileId: 'p2', connectionId: 'c2', userIdentifier: 'u2'));

        await (db.delete(db.connections)..where((t) => t.id.equals('c2'))).go();
        expect(await db.select(db.profileConnections).get(), isEmpty);
      });

      test('hot-query indices exist in sqlite_master', () async {
        // sqlite_master rows let us assert the indices physically exist
        // without depending on Drift's `Migrator` having run them.
        final rows = await db.customSelect("SELECT name FROM sqlite_master WHERE type = 'index'").get();
        final names = rows.map((r) => r.read<String>('name')).toSet();
        expect(
          names,
          containsAll(['idx_profiles_kind', 'idx_profile_connections_profile_id', 'idx_offline_watch_progress_server']),
        );
      });

      test('retried v14 migration tolerates existing indices', () async {
        await db.close();
        final tempDir = await Directory.systemTemp.createTemp('plezy_db_migration_test_');
        final file = File('${tempDir.path}/plezy_downloads.db');
        AppDatabase? seeded;
        AppDatabase? reopened;

        try {
          seeded = AppDatabase.forTesting(NativeDatabase(file));
          await seeded.select(seeded.connections).get();
          await seeded.customStatement('PRAGMA user_version = 13');
          await seeded.close();
          seeded = null;

          reopened = AppDatabase.forTesting(NativeDatabase(file));
          expect(await reopened.select(reopened.connections).get(), isEmpty);
          final rows = await reopened
              .customSelect("SELECT name FROM sqlite_master WHERE type = 'index' AND name = 'idx_connections_kind'")
              .get();
          expect(rows, hasLength(1));
        } finally {
          await reopened?.close();
          await seeded?.close();
          await tempDir.delete(recursive: true);
          db = AppDatabase.forTesting(NativeDatabase.memory());
        }
      });
      test('v18 migration preserves v17 downloads and adds nullable SAF roots', () async {
        await db.close();
        final tempDir = await Directory.systemTemp.createTemp('plezy_db_v18_migration_test_');
        final file = File('${tempDir.path}/plezy_downloads.db');
        AppDatabase? seeded;
        AppDatabase? reopened;

        try {
          seeded = AppDatabase.forTesting(NativeDatabase(file));
          await seeded.select(seeded.downloadedMedia).get();
          await seeded
              .into(seeded.downloadedMedia)
              .insert(
                DownloadedMediaCompanion.insert(
                  id: const Value(42),
                  serverId: 'server',
                  clientScopeId: const Value('scope'),
                  ratingKey: 'rating',
                  globalKey: 'server:rating',
                  type: 'episode',
                  parentRatingKey: const Value('season'),
                  grandparentRatingKey: const Value('show'),
                  status: DownloadStatus.paused.index,
                  progress: const Value(37),
                  totalBytes: const Value(900),
                  downloadedBytes: const Value(333),
                  videoFilePath: const Value('content://video'),
                  thumbPath: const Value('artwork-key'),
                  downloadedAt: const Value(123456),
                  errorMessage: const Value('retryable'),
                  retryCount: const Value(2),
                  bgTaskId: const Value('task'),
                  mediaIndex: const Value(3),
                  mediaSourceId: const Value('source'),
                ),
              );
          await seeded.customStatement('ALTER TABLE downloaded_media DROP COLUMN saf_root_uri');
          await seeded.customStatement('PRAGMA user_version = 17');
          await seeded.close();
          seeded = null;

          reopened = AppDatabase.forTesting(NativeDatabase(file));
          final row = await reopened.select(reopened.downloadedMedia).getSingle();
          expect(row.id, 42);
          expect(row.serverId, 'server');
          expect(row.clientScopeId, 'scope');
          expect(row.ratingKey, 'rating');
          expect(row.globalKey, 'server:rating');
          expect(row.type, 'episode');
          expect(row.parentRatingKey, 'season');
          expect(row.grandparentRatingKey, 'show');
          expect(row.status, DownloadStatus.paused.index);
          expect(row.progress, 37);
          expect(row.totalBytes, 900);
          expect(row.downloadedBytes, 333);
          expect(row.videoFilePath, 'content://video');
          expect(row.safRootUri, isNull);
          expect(row.thumbPath, 'artwork-key');
          expect(row.downloadedAt, 123456);
          expect(row.errorMessage, 'retryable');
          expect(row.retryCount, 2);
          expect(row.bgTaskId, 'task');
          expect(row.mediaIndex, 3);
          expect(row.mediaSourceId, 'source');
        } finally {
          await reopened?.close();
          await seeded?.close();
          await tempDir.delete(recursive: true);
          db = AppDatabase.forTesting(NativeDatabase.memory());
        }
      });

      test('v19 migration derives cache scope independently for every download owner', () async {
        await db.close();
        final tempDir = await Directory.systemTemp.createTemp('plezy_db_v19_migration_test_');
        final file = File('${tempDir.path}/plezy_downloads.db');
        AppDatabase? seeded;
        AppDatabase? reopened;

        try {
          seeded = AppDatabase.forTesting(NativeDatabase(file));
          await seeded.select(seeded.downloadOwners).get();
          final now = DateTime.now().millisecondsSinceEpoch;
          for (final id in const [
            'jf-machine/user-a',
            'jf-machine/user-b',
            'jf-machine/user-z',
            'jf-machine',
            'jf%_machine/user-exact',
            'jf-wildXmachine/user-wrong',
          ]) {
            await seeded
                .into(seeded.connections)
                .insert(
                  ConnectionsCompanion.insert(
                    id: id,
                    kind: 'jellyfin',
                    displayName: id,
                    configJson: '{}',
                    createdAt: now,
                  ),
                );
          }
          await seeded
              .into(seeded.profileConnections)
              .insert(
                ProfileConnectionsCompanion.insert(
                  profileId: 'profile-a',
                  connectionId: 'jf-machine/user-a',
                  userIdentifier: 'user-a',
                ),
              );
          await seeded
              .into(seeded.profileConnections)
              .insert(
                ProfileConnectionsCompanion.insert(
                  profileId: 'profile-a',
                  connectionId: 'jf-machine/user-z',
                  userIdentifier: 'user-z',
                  isDefault: const Value(true),
                  lastUsedAt: Value(now),
                ),
              );
          await seeded
              .into(seeded.profileConnections)
              .insert(
                ProfileConnectionsCompanion.insert(
                  profileId: 'profile-b',
                  connectionId: 'jf-machine/user-b',
                  userIdentifier: 'user-b',
                ),
              );
          await seeded
              .into(seeded.profileConnections)
              .insert(
                ProfileConnectionsCompanion.insert(
                  profileId: 'profile-c',
                  connectionId: 'jf-machine',
                  userIdentifier: 'user-c',
                ),
              );
          await seeded
              .into(seeded.profileConnections)
              .insert(
                ProfileConnectionsCompanion.insert(
                  profileId: 'profile-literal',
                  connectionId: 'jf%_machine/user-exact',
                  userIdentifier: 'user-exact',
                ),
              );
          await seeded
              .into(seeded.profileConnections)
              .insert(
                ProfileConnectionsCompanion.insert(
                  profileId: 'profile-unrelated',
                  connectionId: 'jf-wildXmachine/user-wrong',
                  userIdentifier: 'user-wrong',
                ),
              );
          await seeded
              .into(seeded.downloadedMedia)
              .insert(
                DownloadedMediaCompanion.insert(
                  serverId: 'plex-server',
                  clientScopeId: const Value('plex-server/~plex-profile/profile-a'),
                  ratingKey: 'plex-item',
                  globalKey: 'plex-server:plex-item',
                  type: 'movie',
                  status: DownloadStatus.completed.index,
                ),
              );
          await seeded
              .into(seeded.downloadedMedia)
              .insert(
                DownloadedMediaCompanion.insert(
                  serverId: 'jf-machine',
                  clientScopeId: const Value('jf-machine/user-a'),
                  ratingKey: 'jf-item',
                  globalKey: 'jf-machine:jf-item',
                  type: 'movie',
                  status: DownloadStatus.completed.index,
                ),
              );
          await seeded
              .into(seeded.downloadedMedia)
              .insert(
                DownloadedMediaCompanion.insert(
                  serverId: 'jf%_machine',
                  clientScopeId: const Value('jf%_machine/legacy-user'),
                  ratingKey: 'literal-item',
                  globalKey: 'jf%_machine:literal-item',
                  type: 'movie',
                  status: DownloadStatus.completed.index,
                ),
              );
          for (final profileId in const ['profile-a', 'profile-b', 'profile-c']) {
            await seeded.addDownloadOwner(profileId: profileId, globalKey: 'plex-server:plex-item');
            await seeded.addDownloadOwner(profileId: profileId, globalKey: 'jf-machine:jf-item');
          }
          await seeded.addDownloadOwner(profileId: 'profile-literal', globalKey: 'jf%_machine:literal-item');
          await seeded.addDownloadOwner(profileId: 'profile-unrelated', globalKey: 'jf%_machine:literal-item');
          await seeded.customStatement('ALTER TABLE download_owners DROP COLUMN backend');
          await seeded.customStatement('ALTER TABLE download_owners DROP COLUMN client_scope_id');
          await seeded.customStatement('PRAGMA user_version = 18');
          await seeded.close();
          seeded = null;

          final openTracker = _EnsureOpenTrackingInterceptor();
          reopened = await AppDatabase.open(
            databaseFile: file,
            executorFactory: (databaseFile) => NativeDatabase(databaseFile).interceptWith(openTracker),
          );
          expect(openTracker.calls, greaterThanOrEqualTo(1));
          expect(openTracker.completed, isTrue);
          final owners = await reopened.select(reopened.downloadOwners).get();
          DownloadOwnerItem owner(String profileId, String globalKey) =>
              owners.singleWhere((row) => row.profileId == profileId && row.globalKey == globalKey);

          expect(owner('profile-a', 'plex-server:plex-item').backend, 'plex');
          expect(owner('profile-a', 'plex-server:plex-item').clientScopeId, 'plex-server/~plex-profile/profile-a');
          expect(owner('profile-b', 'plex-server:plex-item').backend, 'plex');
          expect(owner('profile-b', 'plex-server:plex-item').clientScopeId, 'plex-server/~plex-profile/profile-b');
          expect(owner('profile-a', 'jf-machine:jf-item').backend, 'jellyfin');
          expect(owner('profile-a', 'jf-machine:jf-item').clientScopeId, 'jf-machine/user-z');
          expect(owner('profile-b', 'jf-machine:jf-item').backend, 'jellyfin');
          expect(owner('profile-b', 'jf-machine:jf-item').clientScopeId, 'jf-machine/user-b');
          expect(owner('profile-c', 'jf-machine:jf-item').backend, 'jellyfin');
          expect(owner('profile-c', 'jf-machine:jf-item').clientScopeId, 'jf-machine/user-c');
          expect(owner('profile-literal', 'jf%_machine:literal-item').backend, 'jellyfin');
          expect(owner('profile-literal', 'jf%_machine:literal-item').clientScopeId, 'jf%_machine/user-exact');
          expect(owner('profile-unrelated', 'jf%_machine:literal-item').backend, isNull);
          expect(owner('profile-unrelated', 'jf%_machine:literal-item').clientScopeId, isNull);
        } finally {
          await reopened?.close();
          await seeded?.close();
          await tempDir.delete(recursive: true);
          db = AppDatabase.forTesting(NativeDatabase.memory());
        }
      });
      test('v20 migration creates sync download associations without claiming legacy rules', () async {
        await db.close();
        final tempDir = await Directory.systemTemp.createTemp('plezy_db_v20_migration_test_');
        final file = File('${tempDir.path}/plezy_downloads.db');
        AppDatabase? seeded;
        AppDatabase? reopened;

        try {
          seeded = AppDatabase.forTesting(NativeDatabase(file));
          await seeded.select(seeded.syncRuleDownloads).get();
          await seeded.insertSyncRule(
            profileId: 'profile-a',
            serverId: ServerId('server'),
            ratingKey: 'playlist',
            globalKey: 'profile-a|server:playlist',
            targetType: 'playlist',
            episodeCount: 0,
          );
          await seeded.customStatement('DROP TABLE sync_rule_downloads');
          await seeded.customStatement('ALTER TABLE sync_rules DROP COLUMN download_links_initialized');
          await seeded.customStatement('PRAGMA user_version = 19');
          await seeded.close();
          seeded = null;

          reopened = AppDatabase.forTesting(NativeDatabase(file));
          final legacyRule = await reopened.getSyncRule('profile-a|server:playlist');
          expect(legacyRule, isNotNull);
          expect(legacyRule!.downloadLinksInitialized, isFalse);
          expect(await reopened.select(reopened.syncRuleDownloads).get(), isEmpty);

          await reopened.insertDownload(
            serverId: ServerId('server'),
            ratingKey: 'episode',
            globalKey: 'server:episode',
            type: 'episode',
            status: DownloadStatus.completed.index,
          );
          await reopened.associateSyncRuleDownload(legacyRule, 'server:episode');
          expect(await reopened.getSyncRuleDownloadLinks(legacyRule.id), hasLength(1));

          await reopened.deleteSyncRule(legacyRule.globalKey);
          expect(await reopened.getSyncRuleDownloadLinks(legacyRule.id), isEmpty);
        } finally {
          await reopened?.close();
          await seeded?.close();
          await tempDir.delete(recursive: true);
          db = AppDatabase.forTesting(NativeDatabase.memory());
        }
      });
    });

    _registerLegacyDesktopMigrationTests();
  }

  void _registerLegacyDesktopMigrationTests() {
    // ============================================================
    // Legacy desktop DB-file relocation (Documents → AppSupport).
    // Regression coverage for #1022: cross-drive rename (e.g. OneDrive
    // Documents on X:, AppData on C:) used to throw an uncaught
    // FileSystemException out of _openConnection and strand the splash.
    // ============================================================

  }

  void _registerApiCacheTests() {
    group('ApiCache', () {
      test('default pinned=false, custom pinned=true is honored', () async {
        await db.into(db.apiCache).insert(ApiCacheCompanion.insert(cacheKey: 'k1', data: 'a'));
        await db
            .into(db.apiCache)
            .insert(ApiCacheCompanion.insert(cacheKey: 'k2', data: 'b', pinned: const Value(true)));

        final rows = await (db.select(db.apiCache)..orderBy([(t) => OrderingTerm.asc(t.cacheKey)])).get();
        expect(rows.map((r) => r.pinned).toList(), [false, true]);
      });

      test('cacheKey is the primary key (duplicate insert without replace fails)', () async {
        await db.into(db.apiCache).insert(ApiCacheCompanion.insert(cacheKey: 'dup', data: 'first'));
        expect(
          () => db.into(db.apiCache).insert(ApiCacheCompanion.insert(cacheKey: 'dup', data: 'second')),
          throwsA(isA<Exception>()),
        );
      });
    });
  }

  void _registerDownloadedMediaTests() {
    // ============================================================
    // DownloadedMedia: persistence, defaults, constraints, and helpers
    // ============================================================

    group('DownloadedMedia', () {
      Future<int> insertMovie({
        String serverId = 'srv1',
        String? clientScopeId,
        String ratingKey = '100',
        int status = 0, // queued
        int progress = 0,
      }) async {
        return db
            .into(db.downloadedMedia)
            .insert(
              DownloadedMediaCompanion.insert(
                serverId: serverId,
                clientScopeId: Value(clientScopeId),
                ratingKey: ratingKey,
                globalKey: '$serverId:$ratingKey',
                type: 'movie',
                status: status,
                progress: Value(progress),
              ),
            );
      }

      test('insert + select round-trip preserves fields', () async {
        await insertMovie();

        final rows = await db.select(db.downloadedMedia).get();
        expect(rows, hasLength(1));
        expect(rows.first.serverId, 'srv1');
        expect(rows.first.clientScopeId, isNull);
        expect(rows.first.ratingKey, '100');
        expect(rows.first.globalKey, 'srv1:100');
        expect(rows.first.type, 'movie');
        expect(rows.first.status, 0);
        expect(rows.first.progress, 0);
        expect(rows.first.downloadedBytes, 0); // default
        expect(rows.first.retryCount, 0); // default
        expect(rows.first.mediaIndex, 0); // default
        expect(rows.first.bgTaskId, isNull);
        expect(rows.first.totalBytes, isNull);
      });

      test('clientScopeId is persisted for user-scoped downloads', () async {
        await insertMovie(serverId: 'jf-machine', clientScopeId: 'jf-machine/user-a');

        final row = await db.select(db.downloadedMedia).getSingle();
        expect(row.serverId, 'jf-machine');
        expect(row.clientScopeId, 'jf-machine/user-a');
      });

      test('requeue preserves SAF ownership fields while resetting failed state', () async {
        await db
            .into(db.downloadedMedia)
            .insert(
              DownloadedMediaCompanion.insert(
                serverId: ServerId('srv1'),
                ratingKey: 'saf-retry',
                globalKey: 'srv1:saf-retry',
                type: 'movie',
                status: DownloadStatus.failed.index,
                progress: const Value(73),
                videoFilePath: const Value('content://downloads/video.mkv'),
                safRootUri: const Value('content://downloads'),
                errorMessage: const Value('stale failure'),
                retryCount: const Value(4),
                bgTaskId: const Value('stale-task'),
              ),
            );

        await db.insertDownload(
          serverId: ServerId('srv1'),
          ratingKey: 'saf-retry',
          globalKey: 'srv1:saf-retry',
          type: 'movie',
          status: DownloadStatus.queued.index,
        );

        final row = await db.getDownloadedMedia('srv1:saf-retry');
        expect(row?.videoFilePath, 'content://downloads/video.mkv');
        expect(row?.safRootUri, 'content://downloads');
        expect(row?.bgTaskId, 'stale-task');
        expect(row?.status, DownloadStatus.queued.index);
        expect(row?.progress, 0);
        expect(row?.errorMessage, isNull);
        expect(row?.retryCount, 0);
      });

      test('globalKey unique constraint blocks duplicate insert', () async {
        await insertMovie();
        expect(insertMovie(), throwsA(isA<Exception>()));
      });

      test('getAllDownloadedMetadata returns only completed items', () async {
        await insertMovie(ratingKey: '1', status: DownloadStatus.queued.index);
        await insertMovie(ratingKey: '2', status: DownloadStatus.completed.index);
        await insertMovie(ratingKey: '3', status: DownloadStatus.failed.index);
        await insertMovie(ratingKey: '4', status: DownloadStatus.completed.index);

        final completed = await db.getAllDownloadedMetadata();
        expect(completed.map((i) => i.ratingKey).toSet(), {'2', '4'});
      });

      test('download owners keep profile visibility separate for one physical row', () async {
        await insertMovie(ratingKey: '1', status: DownloadStatus.completed.index);

        await db.addDownloadOwner(profileId: 'profile-a', globalKey: 'srv1:1');
        await db.addDownloadOwner(profileId: 'profile-b', globalKey: 'srv1:1');

        expect(await db.getDownloadOwnerKeysForProfile('profile-a'), {'srv1:1'});
        expect(await db.getDownloadOwnerKeysForProfile('profile-b'), {'srv1:1'});
        expect(await db.getDownloadOwnerCount('srv1:1'), 2);

        await db.removeDownloadOwner(profileId: 'profile-a', globalKey: 'srv1:1');
        expect(await db.getDownloadOwnerKeysForProfile('profile-a'), isEmpty);
        expect(await db.hasDownloadOwner('srv1:1'), isTrue);
        expect(await db.hasDownloadOwner('srv1:1', excludingProfileId: 'profile-b'), isFalse);
      });

      test('shared owner release rebinds only incomplete media and retains the final owner', () async {
        final now = DateTime.now().millisecondsSinceEpoch;
        for (final profileId in const ['profile-a', 'profile-b']) {
          await db
              .into(db.profiles)
              .insert(
                ProfilesCompanion.insert(
                  id: profileId,
                  kind: 'local',
                  displayName: profileId,
                  configJson: '{}',
                  createdAt: now,
                ),
              );
        }

        Future<void> seedOwners(String globalKey) async {
          await db.addDownloadOwner(
            profileId: 'profile-a',
            globalKey: globalKey,
            backendId: 'plex',
            clientScopeId: 'srv1/plex-profile/profile-a',
          );
          await db.addDownloadOwner(
            profileId: 'profile-b',
            globalKey: globalKey,
            backendId: 'plex',
            clientScopeId: 'srv1/plex-profile/profile-b',
          );
        }

        await insertMovie(
          clientScopeId: 'srv1/plex-profile/profile-a',
          ratingKey: 'queued-shared',
          status: DownloadStatus.queued.index,
        );
        await seedOwners('srv1:queued-shared');

        final queuedResult = await db.removeSharedDownloadOwnerAndRebindIncompleteMedia(
          profileId: 'profile-a',
          globalKey: 'srv1:queued-shared',
        );

        expect(queuedResult.hasRemainingOwner, isTrue);
        expect(queuedResult.removedOwner?.profileId, 'profile-a');
        expect((await db.getDownloadedMedia('srv1:queued-shared'))?.clientScopeId, 'srv1/plex-profile/profile-b');
        expect(await db.getDownloadOwner(profileId: 'profile-a', globalKey: 'srv1:queued-shared'), isNull);
        expect(await db.getDownloadOwner(profileId: 'profile-b', globalKey: 'srv1:queued-shared'), isNotNull);

        final finalOwnerResult = await db.removeSharedDownloadOwnerAndRebindIncompleteMedia(
          profileId: 'profile-b',
          globalKey: 'srv1:queued-shared',
        );
        expect(finalOwnerResult.hasRemainingOwner, isFalse);
        expect(await db.getDownloadOwner(profileId: 'profile-b', globalKey: 'srv1:queued-shared'), isNotNull);

        await insertMovie(
          clientScopeId: 'srv1/plex-profile/profile-a',
          ratingKey: 'completed-shared',
          status: DownloadStatus.completed.index,
        );
        await seedOwners('srv1:completed-shared');

        final completedResult = await db.removeSharedDownloadOwnerAndRebindIncompleteMedia(
          profileId: 'profile-a',
          globalKey: 'srv1:completed-shared',
        );

        expect(completedResult.hasRemainingOwner, isTrue);
        expect((await db.getDownloadedMedia('srv1:completed-shared'))?.clientScopeId, 'srv1/plex-profile/profile-a');
      });

      test('adoptLegacyDownloadsForProfile claims only ownerless physical rows', () async {
        await insertMovie(ratingKey: '1', status: DownloadStatus.completed.index);
        await insertMovie(ratingKey: '2', status: DownloadStatus.completed.index);
        await db.addDownloadOwner(profileId: 'profile-existing', globalKey: 'srv1:2');

        await db.adoptLegacyDownloadsForProfile('profile-a');

        expect(await db.getDownloadOwnerKeysForProfile('profile-a'), {'srv1:1'});
        expect(await db.getDownloadOwnerKeysForProfile('profile-existing'), {'srv1:2'});
      });

      test(
        'ownerless Jellyfin download adopts the profile connection scope instead of the removed user scope',
        () async {
          final now = DateTime.now().millisecondsSinceEpoch;
          await db
              .into(db.profiles)
              .insert(
                ProfilesCompanion.insert(
                  id: 'profile-b',
                  kind: 'local',
                  displayName: 'Profile B',
                  configJson: '{}',
                  createdAt: now,
                ),
              );
          await db
              .into(db.connections)
              .insert(
                ConnectionsCompanion.insert(
                  id: 'jf-machine/user-b',
                  kind: 'jellyfin',
                  displayName: 'User B',
                  configJson: jsonEncode({'serverMachineId': 'jf-machine', 'userId': 'user-b'}),
                  createdAt: now,
                ),
              );
          await db
              .into(db.profileConnections)
              .insert(
                ProfileConnectionsCompanion.insert(
                  profileId: 'profile-b',
                  connectionId: 'jf-machine/user-b',
                  userIdentifier: 'user-b',
                ),
              );
          await insertMovie(
            serverId: 'jf-machine',
            clientScopeId: 'jf-machine/user-a',
            ratingKey: 'ownerless',
            status: DownloadStatus.completed.index,
          );

          await db.adoptLegacyDownloadsForProfile('profile-b');

          final row = await db.getDownloadedMedia('jf-machine:ownerless');
          final owner = await db.getDownloadOwner(profileId: 'profile-b', globalKey: 'jf-machine:ownerless');
          expect(row?.clientScopeId, 'jf-machine/user-b');
          expect(owner?.backend, 'jellyfin');
          expect(owner?.clientScopeId, 'jf-machine/user-b');
        },
      );

      test('ownerless Jellyfin download defers adoption when the profile has multiple user scopes', () async {
        final now = DateTime.now().millisecondsSinceEpoch;
        for (final userId in const ['user-b', 'user-c']) {
          await db
              .into(db.connections)
              .insert(
                ConnectionsCompanion.insert(
                  id: 'jf-machine/$userId',
                  kind: 'jellyfin',
                  displayName: userId,
                  configJson: '{}',
                  createdAt: now,
                ),
              );
          await db
              .into(db.profileConnections)
              .insert(
                ProfileConnectionsCompanion.insert(
                  profileId: 'profile-b',
                  connectionId: 'jf-machine/$userId',
                  userIdentifier: userId,
                ),
              );
        }
        await insertMovie(
          serverId: 'jf-machine',
          clientScopeId: 'jf-machine/user-a',
          ratingKey: 'ambiguous',
          status: DownloadStatus.completed.index,
        );

        await db.adoptLegacyDownloadsForProfile('profile-b');

        expect(await db.getDownloadOwnerKeysForProfile('profile-b'), isEmpty);
        expect((await db.getDownloadedMedia('jf-machine:ambiguous'))?.clientScopeId, 'jf-machine/user-a');
      });
    });
  }

  void _registerOfflineWatchProgressTests() {
    // ============================================================
    // OfflineWatchProgress helpers
    // ============================================================

    group('OfflineWatchProgress', () {
      Future<int> insertAction({
        String serverId = 's',
        required String ratingKey,
        String? profileId,
        String? clientScopeId,
        required String actionType,
        required int updatedAt,
      }) {
        return db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: serverId,
                profileId: Value(profileId),
                clientScopeId: Value(clientScopeId),
                ratingKey: ratingKey,
                globalKey: '$serverId:$ratingKey',
                actionType: actionType,
                createdAt: updatedAt,
                updatedAt: updatedAt,
              ),
            );
      }

      test('upsertProgressAction inserts a new progress row', () async {
        await db.upsertProgressAction(
          serverId: ServerId('srv'),
          ratingKey: '42',
          viewOffset: 5000,
          duration: 10000,
          shouldMarkWatched: false,
        );

        final rows = await db.select(db.offlineWatchProgress).get();
        expect(rows, hasLength(1));
        expect(rows.first.globalKey, 'srv:42');
        expect(rows.first.clientScopeId, isNull);
        expect(rows.first.actionType, OfflineActionType.progress.id);
        expect(rows.first.viewOffset, 5000);
        expect(rows.first.duration, 10000);
        expect(rows.first.shouldMarkWatched, isFalse);
        expect(rows.first.syncAttempts, 0);
      });

      test('upsertProgressAction merges into the existing progress row', () async {
        await db.upsertProgressAction(
          serverId: ServerId('srv'),
          ratingKey: '42',
          viewOffset: 1000,
          duration: 10000,
          shouldMarkWatched: false,
        );
        await db.upsertProgressAction(
          serverId: ServerId('srv'),
          ratingKey: '42',
          viewOffset: 9500,
          duration: 10000,
          shouldMarkWatched: true,
        );

        final rows = await db.select(db.offlineWatchProgress).get();
        expect(rows, hasLength(1));
        expect(rows.first.viewOffset, 9500);
        expect(rows.first.shouldMarkWatched, isTrue);
      });

      test('upsertProgressAction keeps scoped Jellyfin users separate', () async {
        await db.upsertProgressAction(
          serverId: ServerId('srv'),
          clientScopeId: 'srv/user-a',
          ratingKey: '42',
          viewOffset: 1000,
          duration: 10000,
          shouldMarkWatched: false,
        );
        await db.upsertProgressAction(
          serverId: ServerId('srv'),
          clientScopeId: 'srv/user-b',
          ratingKey: '42',
          viewOffset: 9000,
          duration: 10000,
          shouldMarkWatched: true,
        );

        final rows = await (db.select(
          db.offlineWatchProgress,
        )..orderBy([(t) => OrderingTerm.asc(t.clientScopeId)])).get();
        expect(rows, hasLength(2));
        expect(rows.map((r) => r.clientScopeId), ['srv/user-a', 'srv/user-b']);
        expect(rows.map((r) => r.viewOffset), [1000, 9000]);
      });

      test('insertWatchAction (watched) clears prior progress + insert single row', () async {
        // Existing progress row for the same item
        await db.upsertProgressAction(
          serverId: ServerId('srv'),
          ratingKey: '42',
          viewOffset: 5000,
          duration: 10000,
          shouldMarkWatched: false,
        );

        await db.insertWatchAction(
          serverId: ServerId('srv'),
          ratingKey: '42',
          actionType: OfflineActionType.watched.id,
        );

        final rows = await db.select(db.offlineWatchProgress).get();
        expect(rows, hasLength(1));
        expect(rows.first.actionType, OfflineActionType.watched.id);
        expect(rows.first.viewOffset, isNull);
      });

      test('insertWatchAction clears only matching clientScopeId conflicts', () async {
        await db.upsertProgressAction(
          serverId: ServerId('srv'),
          clientScopeId: 'srv/user-a',
          ratingKey: '42',
          viewOffset: 1000,
          duration: 10000,
          shouldMarkWatched: false,
        );
        await db.upsertProgressAction(
          serverId: ServerId('srv'),
          clientScopeId: 'srv/user-b',
          ratingKey: '42',
          viewOffset: 2000,
          duration: 10000,
          shouldMarkWatched: false,
        );

        await db.insertWatchAction(
          serverId: ServerId('srv'),
          clientScopeId: 'srv/user-a',
          ratingKey: '42',
          actionType: OfflineActionType.watched.id,
        );

        final rows = await (db.select(
          db.offlineWatchProgress,
        )..orderBy([(t) => OrderingTerm.asc(t.clientScopeId), (t) => OrderingTerm.asc(t.actionType)])).get();
        expect(rows, hasLength(2));
        expect(rows.map((r) => (r.clientScopeId, r.actionType)).toList(), [
          ('srv/user-a', OfflineActionType.watched.id),
          ('srv/user-b', OfflineActionType.progress.id),
        ]);
      });

      test('getPendingWatchActions returns rows ordered by createdAt asc', () async {
        // Inject deterministic createdAt by raw inserts
        final now = DateTime.now().millisecondsSinceEpoch;
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 's',
                ratingKey: '1',
                globalKey: 's:1',
                actionType: OfflineActionType.watched.id,
                createdAt: now + 100,
                updatedAt: now + 100,
              ),
            );
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 's',
                ratingKey: '2',
                globalKey: 's:2',
                actionType: OfflineActionType.watched.id,
                createdAt: now + 50,
                updatedAt: now + 50,
              ),
            );

        final pending = await db.getPendingWatchActions();
        expect(pending.map((p) => p.ratingKey).toList(), ['2', '1']);
      });

      test('adoptLegacyOfflineWatchActionsForProfile claims null-profile rows', () async {
        await db.insertWatchAction(serverId: ServerId('s'), ratingKey: '1', actionType: OfflineActionType.watched.id);
        await db.insertWatchAction(
          profileId: 'profile-existing',
          serverId: ServerId('s'),
          ratingKey: '2',
          actionType: OfflineActionType.watched.id,
        );

        await db.adoptLegacyOfflineWatchActionsForProfile('profile-a');

        expect((await db.getPendingWatchActions(profileId: 'profile-a')).map((r) => r.ratingKey), ['1']);
        expect((await db.getPendingWatchActions(profileId: 'profile-existing')).map((r) => r.ratingKey), ['2']);
      });

      test('getPendingWatchActionsForServer filters by serverId', () async {
        await db.insertWatchAction(serverId: ServerId('a'), ratingKey: '1', actionType: OfflineActionType.watched.id);
        await db.insertWatchAction(serverId: ServerId('b'), ratingKey: '2', actionType: OfflineActionType.watched.id);
        await db.insertWatchAction(serverId: ServerId('a'), ratingKey: '3', actionType: OfflineActionType.unwatched.id);

        final aRows = await db.getPendingWatchActionsForServer(ServerId('a'));
        expect(aRows.map((r) => r.ratingKey).toSet(), {'1', '3'});

        final bRows = await db.getPendingWatchActionsForServer(ServerId('b'));
        expect(bRows.map((r) => r.ratingKey).toSet(), {'2'});
      });

      test('getLatestWatchAction picks the most recently updated row', () async {
        final now = DateTime.now().millisecondsSinceEpoch;
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 's',
                ratingKey: '1',
                globalKey: 's:1',
                actionType: OfflineActionType.progress.id,
                createdAt: now,
                updatedAt: now - 100,
              ),
            );
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 's',
                ratingKey: '1',
                globalKey: 's:1',
                actionType: OfflineActionType.watched.id,
                createdAt: now,
                updatedAt: now + 50,
              ),
            );

        final latest = await db.getLatestWatchAction('s:1');
        expect(latest, isNotNull);
        expect(latest!.actionType, OfflineActionType.watched.id);
      });

      test('getLatestWatchAction returns null when no rows', () async {
        expect(await db.getLatestWatchAction('nope:nope'), isNull);
      });

      test('single and batched watch-action reads preserve newest-first ordering', () async {
        final oldestId = await insertAction(
          ratingKey: 'ordered',
          actionType: OfflineActionType.progress.id,
          updatedAt: 100,
        );
        final olderTieId = await insertAction(
          ratingKey: 'ordered',
          actionType: OfflineActionType.watched.id,
          updatedAt: 200,
        );
        final newerTieId = await insertAction(
          ratingKey: 'ordered',
          actionType: OfflineActionType.unwatched.id,
          updatedAt: 200,
        );
        final expectedIds = [newerTieId, olderTieId, oldestId];

        final single = await db.getWatchActionsForKey('s:ordered');
        final batched = await db.getWatchActionsForKeys({'s:ordered'});

        expect(single.map((action) => action.id), expectedIds);
        expect(batched['s:ordered']!.map((action) => action.id), expectedIds);
        expect((await db.getLatestWatchAction('s:ordered'))!.id, newerTieId);
        expect((await db.getLatestWatchActionsForKeys({'s:ordered'}))['s:ordered']!.id, newerTieId);
      });

      test('single and batched watch-action reads distinguish null and compound scopes', () async {
        final nullScopeId = await insertAction(
          ratingKey: 'scoped',
          actionType: OfflineActionType.unwatched.id,
          updatedAt: 100,
        );
        final compoundScopeId = await insertAction(
          ratingKey: 'scoped',
          clientScopeId: 's/user-a',
          actionType: OfflineActionType.watched.id,
          updatedAt: 200,
        );

        final singleNull = await db.getWatchActionsForKey('s:scoped', filterClientScope: true);
        final singleCompound = await db.getWatchActionsForKey(
          's:scoped',
          clientScopeId: 's/user-a',
          filterClientScope: true,
        );
        final batchedNull = await db.getWatchActionsForKeys(
          {'s:scoped'},
          clientScopeIdsByGlobalKey: {'s:scoped': null},
        );
        final batchedCompound = await db.getWatchActionsForKeys(
          {'s:scoped'},
          clientScopeIdsByGlobalKey: {'s:scoped': 's/user-a'},
        );

        expect(singleNull.map((action) => action.id), [nullScopeId]);
        expect(singleCompound.map((action) => action.id), [compoundScopeId]);
        expect(batchedNull['s:scoped']!.map((action) => action.id), [nullScopeId]);
        expect(batchedCompound['s:scoped']!.map((action) => action.id), [compoundScopeId]);
        expect((await db.getLatestWatchAction('s:scoped', filterClientScope: true))!.id, nullScopeId);
        expect(
          (await db.getLatestWatchAction('s:scoped', clientScopeId: 's/user-a', filterClientScope: true))!.id,
          compoundScopeId,
        );
        expect(
          (await db.getLatestWatchActionsForKeys(
            {'s:scoped'},
            clientScopeIdsByGlobalKey: {'s:scoped': null},
          ))['s:scoped']!.id,
          nullScopeId,
        );
        expect(
          (await db.getLatestWatchActionsForKeys(
            {'s:scoped'},
            clientScopeIdsByGlobalKey: {'s:scoped': 's/user-a'},
          ))['s:scoped']!.id,
          compoundScopeId,
        );
      });

      test('single and batched watch-action reads isolate profiles', () async {
        final profileAId = await insertAction(
          ratingKey: 'profiled',
          profileId: 'profile-a',
          actionType: OfflineActionType.unwatched.id,
          updatedAt: 100,
        );
        await insertAction(
          ratingKey: 'profiled',
          profileId: 'profile-b',
          actionType: OfflineActionType.watched.id,
          updatedAt: 200,
        );

        final single = await db.getWatchActionsForKey('s:profiled', profileId: 'profile-a', filterProfile: true);
        final batched = await db.getWatchActionsForKeys({'s:profiled'}, profileId: 'profile-a', filterProfile: true);

        expect(single.map((action) => action.id), [profileAId]);
        expect(batched['s:profiled']!.map((action) => action.id), [profileAId]);
        expect(
          (await db.getLatestWatchAction('s:profiled', profileId: 'profile-a', filterProfile: true))!.id,
          profileAId,
        );
        expect(
          (await db.getLatestWatchActionsForKeys(
            {'s:profiled'},
            profileId: 'profile-a',
            filterProfile: true,
          ))['s:profiled']!.id,
          profileAId,
        );
      });

      test('watch-action query values treat wildcard characters literally', () async {
        final exactId = await insertAction(
          serverId: 'server_%',
          ratingKey: 'item%_',
          profileId: 'profile_%',
          clientScopeId: 'server_%/user_1',
          actionType: OfflineActionType.watched.id,
          updatedAt: 100,
        );
        await insertAction(
          serverId: 'server_%',
          ratingKey: 'item%_',
          profileId: 'profile_abc',
          clientScopeId: 'server_%/user_1',
          actionType: OfflineActionType.unwatched.id,
          updatedAt: 400,
        );
        await insertAction(
          serverId: 'server_%',
          ratingKey: 'item%_',
          profileId: 'profile_%',
          clientScopeId: 'server_abc/user_a',
          actionType: OfflineActionType.unwatched.id,
          updatedAt: 300,
        );
        await insertAction(
          serverId: 'server_abc',
          ratingKey: 'itemZZZx',
          profileId: 'profile_%',
          clientScopeId: 'server_%/user_1',
          actionType: OfflineActionType.unwatched.id,
          updatedAt: 200,
        );
        const globalKey = 'server_%:item%_';
        const scopes = {globalKey: 'server_%/user_1'};

        final single = await db.getWatchActionsForKey(
          globalKey,
          profileId: 'profile_%',
          filterProfile: true,
          clientScopeId: 'server_%/user_1',
          filterClientScope: true,
        );
        final batched = await db.getWatchActionsForKeys(
          {globalKey},
          profileId: 'profile_%',
          filterProfile: true,
          clientScopeIdsByGlobalKey: scopes,
        );

        expect(single.map((action) => action.id), [exactId]);
        expect(single.single.serverId, 'server_%');
        expect(single.single.ratingKey, 'item%_');
        expect(batched[globalKey]!.map((action) => action.id), [exactId]);
        expect(
          (await db.getLatestWatchAction(
            globalKey,
            profileId: 'profile_%',
            filterProfile: true,
            clientScopeId: 'server_%/user_1',
            filterClientScope: true,
          ))!.id,
          exactId,
        );
        expect(
          (await db.getLatestWatchActionsForKeys(
            {globalKey},
            profileId: 'profile_%',
            filterProfile: true,
            clientScopeIdsByGlobalKey: scopes,
          ))[globalKey]!.id,
          exactId,
        );
      });

      test('getLatestWatchActionsForKeys batches lookups, latest per key', () async {
        final now = DateTime.now().millisecondsSinceEpoch;
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 's',
                ratingKey: '1',
                globalKey: 's:1',
                actionType: OfflineActionType.progress.id,
                createdAt: now,
                updatedAt: now,
              ),
            );
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 's',
                ratingKey: '1',
                globalKey: 's:1',
                actionType: OfflineActionType.watched.id,
                createdAt: now,
                updatedAt: now + 100,
              ),
            );
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 's',
                ratingKey: '2',
                globalKey: 's:2',
                actionType: OfflineActionType.unwatched.id,
                createdAt: now,
                updatedAt: now,
              ),
            );

        final result = await db.getLatestWatchActionsForKeys({'s:1', 's:2', 's:3-missing'});
        expect(result.keys.toSet(), {'s:1', 's:2'});
        expect(result['s:1']!.actionType, OfflineActionType.watched.id);
        expect(result['s:2']!.actionType, OfflineActionType.unwatched.id);
      });

      test('getLatestWatchActionsForKeys filters by expected clientScopeId', () async {
        final now = DateTime.now().millisecondsSinceEpoch;
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 'jf',
                clientScopeId: const Value('jf/user-a'),
                ratingKey: '1',
                globalKey: 'jf:1',
                actionType: OfflineActionType.unwatched.id,
                createdAt: now,
                updatedAt: now,
              ),
            );
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 'jf',
                clientScopeId: const Value('jf/user-b'),
                ratingKey: '1',
                globalKey: 'jf:1',
                actionType: OfflineActionType.watched.id,
                createdAt: now,
                updatedAt: now + 100,
              ),
            );

        final userA = await db.getLatestWatchActionsForKeys({'jf:1'}, clientScopeIdsByGlobalKey: {'jf:1': 'jf/user-a'});
        final userB = await db.getLatestWatchActionsForKeys({'jf:1'}, clientScopeIdsByGlobalKey: {'jf:1': 'jf/user-b'});

        expect(userA['jf:1']!.actionType, OfflineActionType.unwatched.id);
        expect(userB['jf:1']!.actionType, OfflineActionType.watched.id);
      });

      test('getLatestWatchActionsForKeys filters by profile when requested', () async {
        final now = DateTime.now().millisecondsSinceEpoch;
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 's',
                profileId: const Value('profile-a'),
                ratingKey: '1',
                globalKey: 's:1',
                actionType: OfflineActionType.unwatched.id,
                createdAt: now,
                updatedAt: now,
              ),
            );
        await db
            .into(db.offlineWatchProgress)
            .insert(
              OfflineWatchProgressCompanion.insert(
                serverId: 's',
                profileId: const Value('profile-b'),
                ratingKey: '1',
                globalKey: 's:1',
                actionType: OfflineActionType.watched.id,
                createdAt: now,
                updatedAt: now + 100,
              ),
            );

        final profileA = await db.getLatestWatchActionsForKeys({'s:1'}, profileId: 'profile-a', filterProfile: true);
        final profileB = await db.getLatestWatchActionsForKeys({'s:1'}, profileId: 'profile-b', filterProfile: true);
        final globalLatest = await db.getLatestWatchActionsForKeys({'s:1'});

        expect(profileA['s:1']!.actionType, OfflineActionType.unwatched.id);
        expect(profileB['s:1']!.actionType, OfflineActionType.watched.id);
        expect(globalLatest['s:1']!.actionType, OfflineActionType.watched.id);
      });

      test('getLatestWatchActionsForKeys with empty input returns empty map (no query)', () async {
        expect(await db.getLatestWatchActionsForKeys({}), isEmpty);
      });

      test('updateSyncAttempt increments syncAttempts and stores lastError', () async {
        await db.insertWatchAction(serverId: ServerId('s'), ratingKey: '1', actionType: OfflineActionType.watched.id);
        final inserted = (await db.select(db.offlineWatchProgress).get()).single;

        await db.updateSyncAttempt(inserted.id, 'boom');
        var row = (await db.select(db.offlineWatchProgress).get()).single;
        expect(row.syncAttempts, 1);
        expect(row.lastError, 'boom');

        await db.updateSyncAttempt(inserted.id, null);
        row = (await db.select(db.offlineWatchProgress).get()).single;
        expect(row.syncAttempts, 2);
        expect(row.lastError, isNull);
      });

      test('updateSyncAttempt is a no-op when id does not exist', () async {
        await db.updateSyncAttempt(999, 'irrelevant');
        expect(await db.select(db.offlineWatchProgress).get(), isEmpty);
      });

      test('deleteWatchAction removes only the matching row', () async {
        await db.insertWatchAction(serverId: ServerId('s'), ratingKey: '1', actionType: OfflineActionType.watched.id);
        await db.insertWatchAction(serverId: ServerId('s'), ratingKey: '2', actionType: OfflineActionType.watched.id);
        final rows = await db.select(db.offlineWatchProgress).get();
        expect(rows, hasLength(2));

        await db.deleteWatchAction(rows.first.id);
        expect(await db.select(db.offlineWatchProgress).get(), hasLength(1));
      });

      test('getPendingSyncCount counts every row', () async {
        expect(await db.getPendingSyncCount(), 0);

        await db.insertWatchAction(serverId: ServerId('s'), ratingKey: '1', actionType: OfflineActionType.watched.id);
        await db.insertWatchAction(serverId: ServerId('s'), ratingKey: '2', actionType: OfflineActionType.unwatched.id);
        expect(await db.getPendingSyncCount(), 2);
      });

      test('clearAllWatchActions empties the table', () async {
        await db.insertWatchAction(serverId: ServerId('s'), ratingKey: '1', actionType: OfflineActionType.watched.id);
        await db.insertWatchAction(serverId: ServerId('s'), ratingKey: '2', actionType: OfflineActionType.unwatched.id);

        await db.clearAllWatchActions();
        expect(await db.select(db.offlineWatchProgress).get(), isEmpty);
      });
    });
  }

  void _registerSyncRulesTests() {
    // ============================================================
    // Sync Rules helpers
    // ============================================================

    group('SyncRules', () {
      test('insertSyncRule + getSyncRules round-trip with defaults', () async {
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'show',
          episodeCount: 5,
        );

        final rules = await db.getSyncRules();
        expect(rules, hasLength(1));
        expect(rules.first.targetType, 'show');
        expect(rules.first.profileId, '');
        expect(rules.first.episodeCount, 5);
        expect(rules.first.enabled, isTrue); // default
        expect(rules.first.downloadFilter, 'unwatched'); // default
        expect(rules.first.mediaIndex, 0); // default
        expect(rules.first.includeSpecials, isTrue); // default
        expect(rules.first.lastExecutedAt, isNull);
      });

      test('insertSyncRule upserts on the UNIQUE globalKey instead of crashing', () async {
        // The auto-incremented primary key never collides, so a duplicate
        // globalKey would fail the UNIQUE constraint with a vanilla
        // `insertOnConflictUpdate`. The helper drives the upsert off
        // [globalKey] so re-creating a rule for the same target updates the
        // existing row rather than throwing.
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'show',
          episodeCount: 5,
        );
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'season',
          episodeCount: 99,
          downloadFilter: 'all',
          includeSpecials: false,
        );

        final rules = await db.getSyncRules();
        expect(rules, hasLength(1));
        expect(rules.first.targetType, 'season');
        expect(rules.first.episodeCount, 99);
        expect(rules.first.downloadFilter, 'all');
        expect(rules.first.includeSpecials, isFalse);
      });

      test('insertSyncRule allows the same server item for different profiles', () async {
        await db.insertSyncRule(
          profileId: 'profile-a',
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'profile-a|srv:10',
          targetType: 'show',
          episodeCount: 5,
        );
        await db.insertSyncRule(
          profileId: 'profile-b',
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'profile-b|srv:10',
          targetType: 'show',
          episodeCount: 9,
        );

        expect(await db.getSyncRules(profileId: 'profile-a'), hasLength(1));
        expect((await db.getSyncRules(profileId: 'profile-a')).single.episodeCount, 5);
        expect(await db.getSyncRules(profileId: 'profile-b'), hasLength(1));
        expect((await db.getSyncRules(profileId: 'profile-b')).single.episodeCount, 9);
      });

      test('insertSyncRule preserves enabled + lastExecutedAt across upserts', () async {
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'show',
          episodeCount: 5,
        );
        await db.updateSyncRuleEnabled('srv:10', false);
        await db.updateSyncRuleLastExecuted('srv:10');
        final firstRun = (await db.getSyncRule('srv:10'))!;

        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'show',
          episodeCount: 8,
        );
        final afterUpsert = (await db.getSyncRule('srv:10'))!;
        expect(afterUpsert.episodeCount, 8);
        expect(afterUpsert.enabled, isFalse, reason: 'upsert should preserve disabled flag');
        expect(afterUpsert.lastExecutedAt, firstRun.lastExecutedAt);
      });

      test('getSyncRule returns the matching rule or null', () async {
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'show',
          episodeCount: 5,
        );
        expect(await db.getSyncRule('srv:10'), isNotNull);
        expect(await db.getSyncRule('srv:nope'), isNull);
      });

      test('updateSyncRuleCount mutates only the count', () async {
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'show',
          episodeCount: 5,
        );
        await db.updateSyncRuleCount('srv:10', 12);

        final rule = await db.getSyncRule('srv:10');
        expect(rule!.episodeCount, 12);
        expect(rule.targetType, 'show'); // unchanged
      });

      test('updateSyncRuleFilter mutates the filter', () async {
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'show',
          episodeCount: 5,
        );
        await db.updateSyncRuleFilter('srv:10', 'all');

        final rule = await db.getSyncRule('srv:10');
        expect(rule!.downloadFilter, 'all');
      });

      test('updateSyncRuleEnabled toggles enabled', () async {
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'show',
          episodeCount: 5,
        );
        await db.updateSyncRuleEnabled('srv:10', false);
        expect((await db.getSyncRule('srv:10'))!.enabled, isFalse);

        await db.updateSyncRuleEnabled('srv:10', true);
        expect((await db.getSyncRule('srv:10'))!.enabled, isTrue);
      });

      test('updateSyncRuleLastExecuted writes a timestamp', () async {
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'show',
          episodeCount: 5,
        );
        final before = DateTime.now().millisecondsSinceEpoch;
        await db.updateSyncRuleLastExecuted('srv:10');
        final after = DateTime.now().millisecondsSinceEpoch;

        final rule = await db.getSyncRule('srv:10');
        expect(rule!.lastExecutedAt, isNotNull);
        expect(rule.lastExecutedAt! >= before, isTrue);
        expect(rule.lastExecutedAt! <= after, isTrue);
      });

      test('deleteSyncRule removes the matching row', () async {
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '10',
          globalKey: 'srv:10',
          targetType: 'show',
          episodeCount: 5,
        );
        await db.insertSyncRule(
          serverId: ServerId('srv'),
          ratingKey: '11',
          globalKey: 'srv:11',
          targetType: 'show',
          episodeCount: 5,
        );

        await db.deleteSyncRule('srv:10');

        final remaining = await db.getSyncRules();
        expect(remaining, hasLength(1));
        expect(remaining.first.globalKey, 'srv:11');
      });
      test('exclusive sync download keys preserve downloads covered by another rule', () async {
        Future<SyncRuleItem> insertRule(String profileId, String id) async {
          final globalKey = '$profileId|srv:$id';
          await db.insertSyncRule(
            profileId: profileId,
            serverId: ServerId('srv'),
            ratingKey: id,
            globalKey: globalKey,
            targetType: 'playlist',
            episodeCount: 0,
          );
          return (await db.getSyncRule(globalKey))!;
        }

        Future<void> insertOwnedDownload(String id, List<String> profileIds) async {
          final globalKey = 'srv:$id';
          await db.insertDownload(
            serverId: ServerId('srv'),
            ratingKey: id,
            globalKey: globalKey,
            type: 'episode',
            status: DownloadStatus.completed.index,
          );
          for (final profileId in profileIds) {
            await db.addDownloadOwner(profileId: profileId, globalKey: globalKey);
          }
        }

        final target = await insertRule('profile-a', 'playlist-a');
        final sibling = await insertRule('profile-a', 'playlist-b');
        final otherProfile = await insertRule('profile-b', 'playlist-c');
        await insertOwnedDownload('exclusive', ['profile-a']);
        await insertOwnedDownload('sibling-shared', ['profile-a']);
        await insertOwnedDownload('profile-shared', ['profile-a', 'profile-b']);

        await db.associateSyncRuleDownload(target, 'srv:exclusive');
        await db.associateSyncRuleDownload(target, 'srv:sibling-shared');
        await db.associateSyncRuleDownload(target, 'srv:profile-shared');
        await db.associateSyncRuleDownload(sibling, 'srv:sibling-shared');
        await db.associateSyncRuleDownload(otherProfile, 'srv:profile-shared');

        expect(
          await db.getExclusiveSyncRuleDownloadKeys(target),
          unorderedEquals(['srv:exclusive', 'srv:profile-shared']),
        );

        await db.removeDownloadOwner(profileId: 'profile-a', globalKey: 'srv:profile-shared');
        expect(await db.getSyncRuleDownloadLinks(otherProfile.id), hasLength(1));
      });
    });
  }
}
