import 'dart:async';
import 'dart:io';
import '../media/ids.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';
import 'plex_metadata_recovery.dart';
import '../models/download_models.dart';
import '../utils/app_logger.dart';
import '../utils/global_key_utils.dart';
import '../utils/content_utils.dart';

part 'app_database.g.dart';

/// Action queued in the offline watch-progress sync table. The serialized
/// form ([id]) is what gets persisted in [OfflineWatchProgress.actionType];
/// keep these strings stable across renames so existing rows resolve.
enum OfflineActionType {
  progress,
  watched,
  unwatched;

  /// Stable string id used for persistence. Survives an enum-name rename
  /// (e.g. `progress` → `inProgress`) — `.name` would corrupt every row.
  String get id => switch (this) {
    OfflineActionType.progress => 'progress',
    OfflineActionType.watched => 'watched',
    OfflineActionType.unwatched => 'unwatched',
  };

  /// Inverse of [id]. Throws on unknown so a typo in production doesn't
  /// silently fall back to the wrong action.
  static OfflineActionType fromId(String id) => switch (id) {
    'progress' => OfflineActionType.progress,
    'watched' => OfflineActionType.watched,
    'unwatched' => OfflineActionType.unwatched,
    _ => throw ArgumentError('Unknown OfflineActionType id: $id'),
  };
}

@DriftDatabase(
  tables: [
    DownloadedMedia,
    DownloadOwners,
    DownloadQueue,
    ApiCache,
    OfflineWatchProgress,
    SyncRules,
    SyncRuleDownloads,
    Connections,
    Profiles,
    ProfileConnections,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._(super.e);

  /// Test-only constructor — inject an in-memory [QueryExecutor]
  /// (e.g. `NativeDatabase.memory()`) so tests don't touch real disk.
  @visibleForTesting
  AppDatabase.forTesting(super.e);

  /// Resolves and opens the production database, eagerly completing Drift
  /// setup and migrations before returning.
  static Future<AppDatabase> open({File? databaseFile, QueryExecutor Function(File file)? executorFactory}) async {
    final file = databaseFile ?? await _resolveProductionDatabaseFile();
    if (!await file.parent.exists()) {
      await file.parent.create(recursive: true);
    }

    final database = AppDatabase._((executorFactory ?? _createNativeDatabase)(file));
    try {
      // Drift executors open lazily. Force the connection through setup and
      // migrations while failures are still covered by this close/rethrow
      // boundary and the caller's startup download-recovery decision.
      await database.customSelect('SELECT 1').get();
      return database;
    } catch (_) {
      await database.close();
      rethrow;
    }
  }

  /// Wraps one complete registry identity mutation. Retained as the seam the
  /// registries call; the durability protocol behind it was tvOS-only.
  Future<T> runIdentityMutation<T>(Future<T> Function() mutation) => mutation();

  Future<T> _runPendingMutation<T>(Future<T> Function() mutation) => mutation();

  @override
  int get schemaVersion => 20;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      // Enforce ProfileConnections → Profiles/Connections cascades.
      // Drift turns FKs *off* during migrations, so the per-connection
      // pragma we set in `_openConnection` is wiped on first open. This
      // hook runs after migrations and re-enables it for subsequent
      // queries — also applies to in-memory test databases that don't go
      // through `_openConnection`.
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 7) {
          appLogger.i('Adding OfflineWatchProgress table (v7 migration)');
          await m.createTable(offlineWatchProgress);
        }
        if (from < 8) {
          appLogger.i('Adding bgTaskId column to DownloadedMedia (v8 migration)');
          await _ignoreAlreadyExists(
            'DownloadedMedia.bgTaskId column',
            () => m.addColumn(downloadedMedia, downloadedMedia.bgTaskId),
          );
        }
        if (from < 9) {
          appLogger.i('Adding mediaIndex column to DownloadedMedia (v9 migration)');
          await _ignoreAlreadyExists(
            'DownloadedMedia.mediaIndex column',
            () => m.addColumn(downloadedMedia, downloadedMedia.mediaIndex),
          );
        }
        if (from < 10) {
          appLogger.i('Adding SyncRules table (v10 migration)');
          await m.createTable(syncRules);
        }
        if (from < 11) {
          appLogger.i('Adding enabled column to SyncRules (v11 migration)');
          await _ignoreAlreadyExists('SyncRules.enabled column', () => m.addColumn(syncRules, syncRules.enabled));
        }
        if (from < 12) {
          appLogger.i('Adding downloadFilter column to SyncRules (v12 migration)');
          await _ignoreAlreadyExists(
            'SyncRules.downloadFilter column',
            () => m.addColumn(syncRules, syncRules.downloadFilter),
          );
        }
        if (from < 13) {
          appLogger.i('Adding indexes on DownloadedMedia hot-queried columns (v13 migration)');
          final indexes = {
            'idx_downloaded_media_status': idxDownloadedMediaStatus,
            'idx_downloaded_media_server': idxDownloadedMediaServer,
            'idx_downloaded_media_parent': idxDownloadedMediaParent,
            'idx_downloaded_media_grandparent': idxDownloadedMediaGrandparent,
          };
          for (final entry in indexes.entries) {
            await _ignoreAlreadyExists('Index ${entry.key}', () => m.create(entry.value));
          }
        }
        if (from < 14) {
          appLogger.i(
            'Adding Connections, Profiles, ProfileConnections, DownloadOwners + scope/profile columns (v14 migration)',
          );

          await m.createTable(connections);
          await _ignoreAlreadyExists('Index idx_connections_kind', () => m.create(idxConnectionsKind));

          await m.createTable(profiles);
          await _ignoreAlreadyExists('Index idx_profiles_kind', () => m.create(idxProfilesKind));

          await m.createTable(profileConnections);
          await _ignoreAlreadyExists(
            'Index idx_profile_connections_connection_id',
            () => m.create(idxProfileConnectionsConnectionId),
          );
          await _ignoreAlreadyExists(
            'Index idx_profile_connections_profile_id',
            () => m.create(idxProfileConnectionsProfileId),
          );

          await _ignoreAlreadyExists('DownloadOwners table', () => m.createTable(downloadOwners));
          await _ignoreAlreadyExists('Index idx_download_owners_profile', () => m.create(idxDownloadOwnersProfile));
          await _ignoreAlreadyExists(
            'Index idx_download_owners_global_key',
            () => m.create(idxDownloadOwnersGlobalKey),
          );

          await _ignoreAlreadyExists(
            'DownloadedMedia.clientScopeId column',
            () => m.addColumn(downloadedMedia, downloadedMedia.clientScopeId),
          );
          await _ignoreAlreadyExists(
            'OfflineWatchProgress.clientScopeId column',
            () => m.addColumn(offlineWatchProgress, offlineWatchProgress.clientScopeId),
          );
          await _ignoreAlreadyExists('SyncRules.profileId column', () => m.addColumn(syncRules, syncRules.profileId));
          await _ignoreAlreadyExists(
            'OfflineWatchProgress.profileId column',
            () => m.addColumn(offlineWatchProgress, offlineWatchProgress.profileId),
          );

          await customStatement('''
            UPDATE downloaded_media
            SET client_scope_id = (
              SELECT id FROM connections
              WHERE kind = 'jellyfin'
                AND substr(id, 1, length(downloaded_media.server_id) + 1) = downloaded_media.server_id || '/'
              LIMIT 1
            )
            WHERE client_scope_id IS NULL
              AND EXISTS (
                SELECT 1 FROM connections
                WHERE kind = 'jellyfin'
                  AND substr(id, 1, length(downloaded_media.server_id) + 1) = downloaded_media.server_id || '/'
              )
          ''');
          await customStatement('''
            UPDATE offline_watch_progress
            SET client_scope_id = (
              SELECT id FROM connections
              WHERE kind = 'jellyfin'
                AND substr(id, 1, length(offline_watch_progress.server_id) + 1) = offline_watch_progress.server_id || '/'
              LIMIT 1
            )
            WHERE client_scope_id IS NULL
              AND EXISTS (
                SELECT 1 FROM connections
                WHERE kind = 'jellyfin'
                  AND substr(id, 1, length(offline_watch_progress.server_id) + 1) = offline_watch_progress.server_id || '/'
              )
          ''');

          await _ignoreAlreadyExists(
            'Index idx_offline_watch_progress_server',
            () => m.create(idxOfflineWatchProgressServer),
          );
          await _ignoreAlreadyExists('Index idx_sync_rules_profile', () => m.create(idxSyncRulesProfile));
          await _ignoreAlreadyExists(
            'Index idx_offline_watch_progress_profile',
            () => m.create(idxOfflineWatchProgressProfile),
          );
        }
        if (from < 15) {
          appLogger.i('Adding mediaSourceId column to DownloadedMedia (v15 migration)');
          await _ignoreAlreadyExists(
            'DownloadedMedia.mediaSourceId column',
            () => m.addColumn(downloadedMedia, downloadedMedia.mediaSourceId),
          );
        }
        if (from < 16) {
          appLogger.i('Adding includeSpecials column to SyncRules (v16 migration)');
          await _ignoreAlreadyExists(
            'SyncRules.includeSpecials column',
            () => m.addColumn(syncRules, syncRules.includeSpecials),
          );
        }
        if (from < 17) {
          appLogger.i('Scoping pinned legacy Plex metadata before removing bare cache rows (v17 migration)');
          await customStatement(
            _rescopePinnedPlexMetadataStatement(
              namespaceExpression: "'/~plex-profile/' || owner.profile_id || ':'",
              ownerJoin: '''JOIN download_owners AS owner
                ON owner.global_key = metadata.global_key''',
            ),
          );
          // A direct pre-v14 upgrade has no owners yet: profiles and owner
          // adoption are bootstrapped only after the database opens. Preserve
          // those downloads in the neutral Plex transfer namespace so the
          // first profile can adopt them without inheriting legacy watch data.
          await customStatement(
            _rescopePinnedPlexMetadataStatement(
              namespaceExpression: "'/~plex-transfer:'",
              ownerFilter: '''AND NOT EXISTS (
                  SELECT 1
                  FROM download_owners AS owner
                  WHERE owner.global_key = metadata.global_key
                )''',
            ),
          );

          final transferRows = await customSelect('''
            SELECT cache_key, data
            FROM api_cache
            WHERE instr(
              substr(cache_key, 1, instr(cache_key, ':') - 1),
              '/~plex-transfer'
            ) > 0
              AND instr(cache_key, ':/library/metadata/') > 0
          ''').get();
          for (final row in transferRows) {
            final cacheKey = row.read<String>('cache_key');
            try {
              final sanitized = sanitizePlexMetadataForOwnerlessTransfer(row.read<String>('data'));
              await customStatement('UPDATE api_cache SET data = ? WHERE cache_key = ?', [sanitized, cacheKey]);
            } on FormatException catch (error, stackTrace) {
              appLogger.w(
                'Discarding invalid legacy Plex transfer metadata for $cacheKey',
                error: error,
                stackTrace: stackTrace,
              );
              await customStatement('DELETE FROM api_cache WHERE cache_key = ?', [cacheKey]);
            }
          }

          // Only mark a physical row as transferable when its sanitized leaf
          // exists. Parent-only cache remnants cannot hydrate an offline item.
          await customStatement('''
            UPDATE downloaded_media
            SET client_scope_id = server_id || '/~plex-transfer'
            WHERE NOT EXISTS (
                SELECT 1
                FROM download_owners AS owner
                WHERE owner.global_key = downloaded_media.global_key
              )
              AND EXISTS (
                SELECT 1
                FROM api_cache AS transfer
                WHERE transfer.cache_key =
                    downloaded_media.server_id
                      || '/~plex-transfer:/library/metadata/'
                      || downloaded_media.rating_key
                  AND transfer.pinned = 1
              )
          ''');
          await customStatement('''
            WITH legacy_plex_metadata AS (
              SELECT
                cache_key,
                substr(cache_key, instr(cache_key, ':') + 1) AS endpoint
              FROM api_cache
              WHERE instr(cache_key, ':/library/metadata/') > 0
                AND instr(
                  substr(cache_key, 1, instr(cache_key, ':') - 1),
                  '/~plex-profile/'
                ) = 0
                AND instr(
                  substr(cache_key, 1, instr(cache_key, ':') - 1),
                  '/~plex-transfer'
                ) = 0
            )
            DELETE FROM api_cache
            WHERE cache_key IN (
              SELECT cache_key
              FROM legacy_plex_metadata
              WHERE (
                endpoint GLOB '/library/metadata/?*'
                AND endpoint NOT GLOB '/library/metadata/*/*'
              ) OR (
                endpoint GLOB '/library/metadata/?*/children'
                AND endpoint NOT GLOB '/library/metadata/*/*/*'
              )
            )
          ''');
        }
        if (from < 18) {
          appLogger.i('Adding safRootUri column to DownloadedMedia (v18 migration)');
          await _ignoreAlreadyExists(
            'DownloadedMedia.safRootUri column',
            () => m.addColumn(downloadedMedia, downloadedMedia.safRootUri),
          );
        }
        if (from < 19) {
          appLogger.i('Adding backend metadata scope columns to DownloadOwners (v19 migration)');
          await _ignoreAlreadyExists(
            'DownloadOwners.backend column',
            () => m.addColumn(downloadOwners, downloadOwners.backend),
          );
          await _ignoreAlreadyExists(
            'DownloadOwners.clientScopeId column',
            () => m.addColumn(downloadOwners, downloadOwners.clientScopeId),
          );
          await customStatement('''
            UPDATE download_owners
            SET client_scope_id = CASE
              WHEN EXISTS (
                SELECT 1
                FROM downloaded_media
                WHERE downloaded_media.global_key = download_owners.global_key
                  AND downloaded_media.client_scope_id LIKE '%/~plex-profile/%'
              ) THEN (
                SELECT downloaded_media.server_id || '/~plex-profile/' || download_owners.profile_id
                FROM downloaded_media
                WHERE downloaded_media.global_key = download_owners.global_key
              )
              WHEN EXISTS (
                SELECT 1
                FROM downloaded_media
                JOIN profile_connections
                  ON profile_connections.profile_id = download_owners.profile_id
                JOIN connections
                  ON connections.id = profile_connections.connection_id
                WHERE downloaded_media.global_key = download_owners.global_key
                  AND connections.kind = 'jellyfin'
                  AND profile_connections.user_identifier != ''
                  AND (
                    connections.id = downloaded_media.server_id
                    OR substr(connections.id, 1, length(downloaded_media.server_id) + 1)
                      = downloaded_media.server_id || '/'
                  )
              ) THEN (
                SELECT CASE
                  WHEN connections.id = downloaded_media.server_id
                    THEN downloaded_media.server_id || '/' || profile_connections.user_identifier
                  ELSE connections.id
                END
                FROM downloaded_media
                JOIN profile_connections
                  ON profile_connections.profile_id = download_owners.profile_id
                JOIN connections
                  ON connections.id = profile_connections.connection_id
                WHERE downloaded_media.global_key = download_owners.global_key
                  AND connections.kind = 'jellyfin'
                  AND profile_connections.user_identifier != ''
                  AND (
                    connections.id = downloaded_media.server_id
                    OR substr(connections.id, 1, length(downloaded_media.server_id) + 1)
                      = downloaded_media.server_id || '/'
                  )
                ORDER BY profile_connections.is_default DESC,
                  profile_connections.last_used_at DESC,
                  connections.id
                LIMIT 1
              )
              ELSE NULL
            END
            WHERE client_scope_id IS NULL
          ''');
          await customStatement('''
            UPDATE download_owners
            SET backend = CASE
              WHEN client_scope_id LIKE '%/~plex-profile/%' THEN 'plex'
              WHEN client_scope_id IS NOT NULL AND EXISTS (
                SELECT 1
                FROM downloaded_media
                JOIN profile_connections
                  ON profile_connections.profile_id = download_owners.profile_id
                JOIN connections
                  ON connections.id = profile_connections.connection_id
                WHERE downloaded_media.global_key = download_owners.global_key
                  AND connections.kind = 'jellyfin'
                  AND (
                    connections.id = downloaded_media.server_id
                    OR substr(connections.id, 1, length(downloaded_media.server_id) + 1)
                      = downloaded_media.server_id || '/'
                  )
              ) THEN 'jellyfin'
            END
            WHERE backend IS NULL
          ''');
        }
        if (from < 20) {
          appLogger.i('Adding sync rule download associations (v20 migration)');
          await _ignoreAlreadyExists(
            'SyncRules.downloadLinksInitialized column',
            () => m.addColumn(syncRules, syncRules.downloadLinksInitialized),
          );
          await _ignoreAlreadyExists('SyncRuleDownloads table', () => m.createTable(syncRuleDownloads));
          await _ignoreAlreadyExists(
            'Index idx_sync_rule_downloads_profile_key',
            () => m.create(idxSyncRuleDownloadsProfileKey),
          );
        }
      },
    );
  }

  Future<void> _ignoreAlreadyExists(String label, Future<void> Function() operation) async {
    try {
      await operation();
    } catch (e) {
      final message = e.toString().toLowerCase();
      if (message.contains('already exists') || message.contains('duplicate column name')) {
        appLogger.w('$label already exists during migration: $e');
        return;
      }
      rethrow;
    }
  }

  Expression<bool> _nullableTextPredicate(GeneratedColumn<String> column, String? value) {
    return value == null ? column.isNull() : column.equals(value);
  }

  /// Get all pending offline watch actions for sync
  Future<List<OfflineWatchProgressItem>> getPendingWatchActions({String? profileId}) {
    final query = select(offlineWatchProgress)..orderBy([(t) => OrderingTerm.asc(t.createdAt)]);
    if (profileId != null) {
      query.where((t) => t.profileId.equals(profileId));
    }
    return query.get();
  }

  /// Claim pre-v18 offline watch actions for [profileId]. Those rows predate
  /// profile ownership and have `NULL profile_id`; the first active profile
  /// inherits them so already-watched offline progress is not stranded.
  Future<void> adoptLegacyOfflineWatchActionsForProfile(String profileId) async {
    if (profileId.isEmpty) return;
    await _runPendingMutation(
      () => (update(
        offlineWatchProgress,
      )..where((t) => t.profileId.isNull())).write(OfflineWatchProgressCompanion(profileId: Value(profileId))),
    );
  }

  /// Get pending watch actions for a specific server
  @visibleForTesting
  Future<List<OfflineWatchProgressItem>> getPendingWatchActionsForServer(ServerId serverId, {String? profileId}) {
    return (select(offlineWatchProgress)
          ..where(
            (t) =>
                t.serverId.equals(serverId) &
                (profileId == null ? const Constant(true) : t.profileId.equals(profileId)),
          )
          ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
        .get();
  }

  SimpleSelectStatement<$OfflineWatchProgressTable, OfflineWatchProgressItem> _watchActionsQuery(
    Expression<bool> Function($OfflineWatchProgressTable table) matchesKey, {
    String? profileId,
    bool filterProfile = false,
    String? clientScopeId,
    bool filterClientScope = false,
  }) {
    return select(offlineWatchProgress)
      ..where(
        (t) =>
            matchesKey(t) &
            (filterProfile ? _nullableTextPredicate(t.profileId, profileId) : const Constant(true)) &
            (filterClientScope ? _nullableTextPredicate(t.clientScopeId, clientScopeId) : const Constant(true)),
      )
      ..orderBy([(t) => OrderingTerm.desc(t.updatedAt), (t) => OrderingTerm.desc(t.id)]);
  }

  /// Get the latest action for a specific item
  @visibleForTesting
  Future<OfflineWatchProgressItem?> getLatestWatchAction(
    String globalKey, {
    String? profileId,
    bool filterProfile = false,
    String? clientScopeId,
    bool filterClientScope = false,
  }) {
    return (_watchActionsQuery(
      (t) => t.globalKey.equals(globalKey),
      profileId: profileId,
      filterProfile: filterProfile,
      clientScopeId: clientScopeId,
      filterClientScope: filterClientScope,
    )..limit(1)).getSingleOrNull();
  }

  Future<List<OfflineWatchProgressItem>> getWatchActionsForKey(
    String globalKey, {
    String? profileId,
    bool filterProfile = false,
    String? clientScopeId,
    bool filterClientScope = false,
  }) {
    return _watchActionsQuery(
      (t) => t.globalKey.equals(globalKey),
      profileId: profileId,
      filterProfile: filterProfile,
      clientScopeId: clientScopeId,
      filterClientScope: filterClientScope,
    ).get();
  }

  Future<Map<String, List<OfflineWatchProgressItem>>> getWatchActionsForKeys(
    Set<String> globalKeys, {
    String? profileId,
    bool filterProfile = false,
    Map<String, String?>? clientScopeIdsByGlobalKey,
  }) async {
    if (globalKeys.isEmpty) return const {};
    final rows = await _watchActionsQuery(
      (t) => t.globalKey.isIn(globalKeys),
      profileId: profileId,
      filterProfile: filterProfile,
    ).get();

    final result = <String, List<OfflineWatchProgressItem>>{};
    for (final action in rows) {
      if (clientScopeIdsByGlobalKey != null && clientScopeIdsByGlobalKey.containsKey(action.globalKey)) {
        final expectedScope = clientScopeIdsByGlobalKey[action.globalKey];
        if (!_clientScopeValuesMatch(action.clientScopeId, expectedScope)) continue;
      }
      result.putIfAbsent(action.globalKey, () => <OfflineWatchProgressItem>[]).add(action);
    }
    return result;
  }

  /// Get the latest actions for multiple items in a single query
  ///
  /// Returns a map of globalKey -> latest action for each key.
  /// Keys with no actions will not be present in the returned map.
  Future<Map<String, OfflineWatchProgressItem>> getLatestWatchActionsForKeys(
    Set<String> globalKeys, {
    String? profileId,
    bool filterProfile = false,
    Map<String, String?>? clientScopeIdsByGlobalKey,
  }) async {
    final actionsByKey = await getWatchActionsForKeys(
      globalKeys,
      profileId: profileId,
      filterProfile: filterProfile,
      clientScopeIdsByGlobalKey: clientScopeIdsByGlobalKey,
    );
    return {for (final entry in actionsByKey.entries) entry.key: entry.value.first};
  }

  bool _clientScopeValuesMatch(String? actual, String? expected) {
    final normalizedActual = actual == null || actual.isEmpty ? null : actual;
    final normalizedExpected = expected == null || expected.isEmpty ? null : expected;
    return normalizedActual == normalizedExpected;
  }

  /// Insert or update a progress action (merges with existing).
  Future<void> upsertProgressAction({
    String? profileId,
    required ServerId serverId,
    String? clientScopeId,
    required String ratingKey,
    required int viewOffset,
    required int? duration,
    required bool shouldMarkWatched,
  }) async {
    return _runPendingMutation(() async {
      final globalKey = buildGlobalKey(ServerId(serverId), ratingKey);
      final now = DateTime.now().millisecondsSinceEpoch;

      await transaction(() async {
        final existing =
            await (select(offlineWatchProgress)
                  ..where(
                    (t) =>
                        t.globalKey.equals(globalKey) &
                        _nullableTextPredicate(t.profileId, profileId) &
                        _nullableTextPredicate(t.clientScopeId, clientScopeId) &
                        t.actionType.equals(OfflineActionType.progress.id),
                  )
                  ..orderBy([(t) => OrderingTerm.asc(t.id)]))
                .get();

        final keep = existing.isEmpty ? null : existing.first;
        if (keep != null) {
          await (update(offlineWatchProgress)..where((t) => t.id.equals(keep.id))).write(
            OfflineWatchProgressCompanion(
              viewOffset: Value(viewOffset),
              duration: Value(duration),
              shouldMarkWatched: Value(shouldMarkWatched),
              profileId: Value(profileId),
              clientScopeId: Value(clientScopeId),
              updatedAt: Value(now),
            ),
          );
          final duplicateIds = existing.skip(1).map((row) => row.id).toList(growable: false);
          if (duplicateIds.isNotEmpty) {
            await (delete(offlineWatchProgress)..where((t) => t.id.isIn(duplicateIds))).go();
          }
        } else {
          await into(offlineWatchProgress).insert(
            OfflineWatchProgressCompanion.insert(
              serverId: serverId,
              profileId: Value(profileId),
              clientScopeId: Value(clientScopeId),
              ratingKey: ratingKey,
              globalKey: globalKey,
              actionType: OfflineActionType.progress.id,
              viewOffset: Value(viewOffset),
              duration: Value(duration),
              shouldMarkWatched: Value(shouldMarkWatched),
              createdAt: now,
              updatedAt: now,
            ),
          );
        }
      });
    });
  }

  /// Insert a manual watch action (watched or unwatched).
  /// Removes conflicting actions for the same item.
  Future<void> insertWatchAction({
    String? profileId,
    required ServerId serverId,
    String? clientScopeId,
    required String ratingKey,
    required String actionType, // 'watched' or 'unwatched'
  }) async {
    return _runPendingMutation(() async {
      final globalKey = buildGlobalKey(ServerId(serverId), ratingKey);
      final now = DateTime.now().millisecondsSinceEpoch;

      await transaction(() async {
        // Remove conflicting actions (opposite action type and progress).
        await (delete(offlineWatchProgress)..where(
              (t) =>
                  t.globalKey.equals(globalKey) &
                  _nullableTextPredicate(t.profileId, profileId) &
                  _nullableTextPredicate(t.clientScopeId, clientScopeId),
            ))
            .go();

        await into(offlineWatchProgress).insert(
          OfflineWatchProgressCompanion.insert(
            serverId: serverId,
            profileId: Value(profileId),
            clientScopeId: Value(clientScopeId),
            ratingKey: ratingKey,
            globalKey: globalKey,
            actionType: actionType,
            createdAt: now,
            updatedAt: now,
          ),
        );
      });
    });
  }

  /// Delete a specific watch action after successful sync
  Future<void> deleteWatchAction(int id) {
    return _runPendingMutation(() async {
      await (delete(offlineWatchProgress)..where((t) => t.id.equals(id))).go();
    });
  }

  /// Update sync attempt count and error message
  Future<void> updateSyncAttempt(int id, String? errorMessage) async {
    return _runPendingMutation(() async {
      final existing = await (select(offlineWatchProgress)..where((t) => t.id.equals(id))).getSingleOrNull();

      if (existing != null) {
        await (update(offlineWatchProgress)..where((t) => t.id.equals(id))).write(
          OfflineWatchProgressCompanion(syncAttempts: Value(existing.syncAttempts + 1), lastError: Value(errorMessage)),
        );
      }
    });
  }

  /// Get count of pending sync items
  Future<int> getPendingSyncCount({String? profileId, int? maxSyncAttempts}) async {
    final query = selectOnly(offlineWatchProgress)..addColumns([offlineWatchProgress.id.count()]);
    if (profileId != null) {
      query.where(offlineWatchProgress.profileId.equals(profileId));
    }
    if (maxSyncAttempts != null) {
      query.where(offlineWatchProgress.syncAttempts.isSmallerThanValue(maxSyncAttempts));
    }
    final count = await query.map((row) => row.read(offlineWatchProgress.id.count())).getSingle();
    return count ?? 0;
  }

  /// Clear all pending watch actions (e.g., after logout)
  Future<void> clearAllWatchActions() {
    return _runPendingMutation(() async {
      await delete(offlineWatchProgress).go();
    });
  }

  /// Drop a removed profile's queued watch actions (profile teardown).
  Future<void> deleteWatchActionsForProfile(String profileId) async {
    await _runPendingMutation(() async {
      await (delete(offlineWatchProgress)..where((t) => t.profileId.equals(profileId))).go();
    });
  }

  Future<List<SyncRuleItem>> getSyncRules({String? profileId}) {
    final query = select(syncRules);
    if (profileId != null) {
      query.where((t) => t.profileId.equals(profileId));
    }
    return query.get();
  }

  Future<SyncRuleItem?> getSyncRule(String globalKey) {
    return (select(syncRules)..where((t) => t.globalKey.equals(globalKey))).getSingleOrNull();
  }

  Future<void> associateSyncRuleDownload(SyncRuleItem rule, String downloadGlobalKey) {
    return into(syncRuleDownloads).insertOnConflictUpdate(
      SyncRuleDownloadsCompanion.insert(
        syncRuleId: rule.id,
        profileId: rule.profileId,
        downloadGlobalKey: downloadGlobalKey,
      ),
    );
  }

  Future<void> markSyncRuleDownloadLinksInitialized(String globalKey) {
    return (update(syncRules)..where((t) => t.globalKey.equals(globalKey))).write(
      const SyncRulesCompanion(downloadLinksInitialized: Value(true)),
    );
  }

  /// Returns uninitialized collection/playlist rules and every show/season
  /// rule whose local ancestry-derived links must be refreshed before cleanup.
  Future<List<SyncRuleItem>> getUninitializedSyncRulesForServer({
    required String profileId,
    required ServerId serverId,
  }) {
    return (select(syncRules)..where(
          (t) =>
              t.profileId.equals(profileId) &
              t.serverId.equals(serverId) &
              (t.downloadLinksInitialized.equals(false) |
                  t.targetType.isIn(const [ContentTypes.show, ContentTypes.season])),
        ))
        .get();
  }

  Future<List<SyncRuleDownloadItem>> getSyncRuleDownloadLinks(int syncRuleId) {
    return (select(syncRuleDownloads)..where((t) => t.syncRuleId.equals(syncRuleId))).get();
  }

  Future<List<String>> getOwnedDownloadKeysForAncestorRule({
    required String profileId,
    required ServerId serverId,
    required String ratingKey,
    required bool matchGrandparent,
  }) async {
    final query = select(
      downloadedMedia,
    ).join([innerJoin(downloadOwners, downloadOwners.globalKey.equalsExp(downloadedMedia.globalKey))]);
    final ancestorMatches = matchGrandparent
        ? downloadedMedia.grandparentRatingKey.equals(ratingKey) | downloadedMedia.parentRatingKey.equals(ratingKey)
        : downloadedMedia.parentRatingKey.equals(ratingKey);
    query.where(
      downloadOwners.profileId.equals(profileId) &
          downloadedMedia.serverId.equals(serverId) &
          downloadedMedia.status.isIn([
            DownloadStatus.queued.index,
            DownloadStatus.downloading.index,
            DownloadStatus.completed.index,
            DownloadStatus.paused.index,
          ]) &
          ancestorMatches,
    );
    final rows = await query.get();
    return rows.map((row) => row.readTable(downloadedMedia).globalKey).toList(growable: false);
  }

  Future<List<String>> getExclusiveSyncRuleDownloadKeys(SyncRuleItem rule) async {
    final links = await getSyncRuleDownloadLinks(rule.id);
    if (links.isEmpty) return const [];

    final keys = links.map((link) => link.downloadGlobalKey).toSet();
    final allLinks = await (select(
      syncRuleDownloads,
    )..where((t) => t.profileId.equals(rule.profileId) & t.downloadGlobalKey.isIn(keys))).get();
    final linkedRuleCounts = <String, int>{};
    for (final link in allLinks) {
      linkedRuleCounts.update(link.downloadGlobalKey, (count) => count + 1, ifAbsent: () => 1);
    }
    return [
      for (final key in keys)
        if (linkedRuleCounts[key] == 1) key,
    ];
  }

  Future<void> insertSyncRule({
    String profileId = '',
    required ServerId serverId,
    required String ratingKey,
    required String globalKey,
    required String targetType,
    required int episodeCount,
    int mediaIndex = 0,
    String downloadFilter = 'unwatched',
    bool includeSpecials = true,
  }) async {
    // [insertOnConflictUpdate] defaults the conflict target to the primary
    // key (`id`), which is auto-incremented — the conflict never triggers
    // and the row's UNIQUE [globalKey] constraint blows up instead. Drive
    // the upsert off the public [globalKey] so re-creating a rule for the same
    // shared target updates the existing row.
    await into(syncRules).insert(
      SyncRulesCompanion.insert(
        serverId: serverId,
        profileId: Value(profileId),
        ratingKey: ratingKey,
        globalKey: globalKey,
        targetType: targetType,
        episodeCount: episodeCount,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        mediaIndex: Value(mediaIndex),
        downloadFilter: Value(downloadFilter),
        includeSpecials: Value(includeSpecials),
      ),
      onConflict: DoUpdate(
        (_) => SyncRulesCompanion(
          serverId: Value(serverId),
          profileId: Value(profileId),
          ratingKey: Value(ratingKey),
          targetType: Value(targetType),
          episodeCount: Value(episodeCount),
          mediaIndex: Value(mediaIndex),
          downloadFilter: Value(downloadFilter),
          includeSpecials: Value(includeSpecials),
        ),
        target: [syncRules.globalKey],
      ),
    );
  }

  /// Claim pre-v16 public sync rules for [profileId]. Rules created before
  /// profile ownership have an empty profile id and a public global key.
  Future<void> adoptLegacySyncRulesForProfile(String profileId) async {
    if (profileId.isEmpty) return;
    final legacyRules = await (select(syncRules)..where((t) => t.profileId.equals(''))).get();
    for (final rule in legacyRules) {
      final scopedKey = buildProfileScopedGlobalKey(profileId, ServerId(rule.serverId), rule.ratingKey);
      final duplicate = await getSyncRule(scopedKey);
      if (duplicate != null) {
        await (delete(syncRules)..where((t) => t.id.equals(rule.id))).go();
        continue;
      }
      await (update(syncRules)..where((t) => t.id.equals(rule.id))).write(
        SyncRulesCompanion(profileId: Value(profileId), globalKey: Value(scopedKey)),
      );
      await (update(
        syncRuleDownloads,
      )..where((t) => t.syncRuleId.equals(rule.id))).write(SyncRuleDownloadsCompanion(profileId: Value(profileId)));
    }
  }

  Future<void> _writeSyncRule(String globalKey, SyncRulesCompanion values) async {
    await (update(syncRules)..where((t) => t.globalKey.equals(globalKey))).write(values);
  }

  Future<void> updateSyncRuleCount(String globalKey, int episodeCount) =>
      _writeSyncRule(globalKey, SyncRulesCompanion(episodeCount: Value(episodeCount)));

  Future<void> updateSyncRuleFilter(String globalKey, String downloadFilter) =>
      _writeSyncRule(globalKey, SyncRulesCompanion(downloadFilter: Value(downloadFilter)));

  Future<void> updateSyncRuleEnabled(String globalKey, bool enabled) =>
      _writeSyncRule(globalKey, SyncRulesCompanion(enabled: Value(enabled)));

  Future<void> updateSyncRuleLastExecuted(String globalKey) =>
      _writeSyncRule(globalKey, SyncRulesCompanion(lastExecutedAt: Value(DateTime.now().millisecondsSinceEpoch)));

  Future<void> completeSyncRuleExecution(String globalKey) {
    return (update(syncRules)..where((t) => t.globalKey.equals(globalKey))).write(
      SyncRulesCompanion(
        lastExecutedAt: Value(DateTime.now().millisecondsSinceEpoch),
        downloadLinksInitialized: const Value(true),
      ),
    );
  }

  Future<void> deleteSyncRule(String globalKey) async {
    await (delete(syncRules)..where((t) => t.globalKey.equals(globalKey))).go();
  }

  /// Drop a removed profile's sync rules (profile teardown).
  Future<void> deleteSyncRulesForProfile(String profileId) async {
    await (delete(syncRules)..where((t) => t.profileId.equals(profileId))).go();
  }

  /// Drop every sync rule (full logout).
  Future<void> clearAllSyncRules() async {
    await delete(syncRules).go();
  }

  /// Get all downloaded media items (for syncing watch states)
  Future<List<DownloadedMediaItem>> getAllDownloadedMetadata() {
    return (select(downloadedMedia)..where((t) => t.status.equals(DownloadStatus.completed.index))).get();
  }
}

/// Builds the v17 statement that re-keys pinned legacy Plex metadata rows into
/// a scoped cache namespace.
///
/// The owned and the ownerless branch run the same operation over the same
/// `download_metadata_ids` set and differ only in three spots: the expression
/// spliced into the new `cache_key` ([namespaceExpression]), an optional join
/// that exposes the owning profile ([ownerJoin]), and an optional extra
/// predicate that keeps each branch to its own rows ([ownerFilter]).
String _rescopePinnedPlexMetadataStatement({
  required String namespaceExpression,
  String ownerJoin = '',
  String ownerFilter = '',
}) =>
    '''
  WITH download_metadata_ids AS (
    SELECT global_key, server_id, rating_key AS metadata_id
    FROM downloaded_media
    UNION
    SELECT global_key, server_id, parent_rating_key AS metadata_id
    FROM downloaded_media
    WHERE parent_rating_key IS NOT NULL
      AND parent_rating_key != ''
    UNION
    SELECT global_key, server_id, grandparent_rating_key AS metadata_id
    FROM downloaded_media
    WHERE grandparent_rating_key IS NOT NULL
      AND grandparent_rating_key != ''
  )
  INSERT INTO api_cache (cache_key, data, pinned, cached_at)
  SELECT DISTINCT
    metadata.server_id
      || $namespaceExpression
      || substr(source.cache_key, length(metadata.server_id) + 2),
    source.data,
    source.pinned,
    source.cached_at
  FROM download_metadata_ids AS metadata
  $ownerJoin
  JOIN api_cache AS source
    ON source.cache_key =
        metadata.server_id || ':/library/metadata/' || metadata.metadata_id
      OR source.cache_key =
        metadata.server_id || ':/library/metadata/' || metadata.metadata_id || '/children'
  WHERE source.pinned = 1
    $ownerFilter
  ON CONFLICT(cache_key) DO UPDATE SET
    data = excluded.data,
    pinned = excluded.pinned,
    cached_at = excluded.cached_at
''';

Future<File> _resolveProductionDatabaseFile() async {
  final dbFolder = (Platform.isAndroid || Platform.isIOS)
      ? await getApplicationDocumentsDirectory()
      : await getApplicationSupportDirectory();
  return File(p.join(dbFolder.path, 'harbor_downloads.db'));
}

QueryExecutor _createNativeDatabase(File file) {
  return NativeDatabase.createInBackground(
    file,
    setup: (db) {
      db.execute('PRAGMA journal_mode=WAL');
      db.execute('PRAGMA synchronous=NORMAL');
      // Enforce ProfileConnections → Connections cascades.
      // SQLite requires this on every connection — it is not persisted.
      db.execute('PRAGMA foreign_keys = ON');
    },
  );
}
