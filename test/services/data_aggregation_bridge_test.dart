import 'dart:convert';
import 'package:plezy/media/ids.dart';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:plezy/connection/connection.dart';
import 'package:plezy/database/app_database.dart';
import 'package:plezy/exceptions/media_server_exceptions.dart';
import 'package:plezy/media/media_backend.dart';
import 'package:plezy/media/media_kind.dart';
import 'package:plezy/media/media_library.dart';
import 'package:plezy/media/media_server_client.dart';
import 'package:plezy/media/media_item.dart';
import 'package:plezy/services/data_aggregation_service.dart';
import 'package:plezy/services/jellyfin_client.dart';
import 'package:plezy/services/multi_server_manager.dart';
import 'package:plezy/services/settings_service.dart';
import 'package:plezy/utils/media_server_http_client.dart';

import '../test_helpers/backend_client_fixtures.dart';
import '../test_helpers/media_items.dart';
import '../test_helpers/prefs.dart';

JellyfinConnection _conn() => testJellyfinConnection(
  userName: 'edde',
  accessToken: 'tok-abc',
  deviceId: 'dev-xyz',
  createdAt: DateTime.fromMillisecondsSinceEpoch(0),
);

http.Response _json(Object body) => http.Response(jsonEncode(body), 200, headers: {'content-type': 'application/json'});

/// Minimal client with independently configurable library and search outcomes.
class _LibrariesClient implements MediaServerClient {
  _LibrariesClient(
    this.serverId, {
    this.error,
    this.libraries = const [],
    this.searchError,
    this.searchResults = const [],
  });

  @override
  final ServerId serverId;

  @override
  final String serverName = 'Server';

  final Object? error;
  final List<MediaLibrary> libraries;
  final Object? searchError;
  final List<MediaItem> searchResults;

  @override
  Future<List<MediaLibrary>> fetchLibraries() async {
    if (error != null) throw error!;
    return libraries;
  }

  @override
  Future<List<MediaItem>> searchItems(String query, {int limit = 100, AbortController? abort}) async {
    abort?.throwIfAborted();
    if (searchError != null) throw searchError!;
    return searchResults;
  }

  @override
  void close() {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Smoke tests for the surviving cross-server aggregation surface on
/// [DataAggregationService]. Single-server passthroughs were removed in
/// favour of `context.tryGetMediaClientForServer(...).<method>()`; what's
/// left here is the multi-client fan-out, which is testable without a
/// real backend by simply asserting the empty-state behaviour.
void main() {
  late AppDatabase db;
  late MultiServerManager manager;
  late DataAggregationService service;

  setUp(() {
    resetSharedPreferencesForTest();
    SettingsService.resetForTesting();
    db = AppDatabase.forTesting(NativeDatabase.memory());
    manager = MultiServerManager();
    service = DataAggregationService(manager);
  });

  tearDown(() async {
    manager.dispose();
    await db.close();
  });

  group('DataAggregationService cross-server aggregation', () {
    test('getMediaLibrariesFromAllServers returns empty when no clients connected', () async {
      final result = await service.getMediaLibrariesFromAllServers();
      expect(result.libraries, isEmpty);
      expect(result.succeededServerIds, isEmpty);
    });

    test('searchAcrossServers and getOnDeckFromAllServers return empty when no clients', () async {
      final search = await service.searchAcrossServers('hello');
      expect(search.items, isEmpty);
      expect(search.succeededServerIds, isEmpty);
      expect(search.cancelledServerIds, isEmpty);
      expect(search.failedServerIds, isEmpty);
      final onDeck = await service.getOnDeckFromAllServers();
      expect(onDeck.items, isEmpty);
      expect(onDeck.succeededServerIds, isEmpty);
    });

    test('classifies cancelled per-server failures apart from settled ones', () async {
      // A cancelled fetch (our own client torn down mid-request) says nothing
      // about the server's content; consumers use cancelledServerIds to keep
      // a disrupted pass from being committed as authoritative. A settled
      // failure (server down) lands in neither set.
      manager.debugRegisterClientForTesting(
        _LibrariesClient(
          ServerId('ok'),
          libraries: [MediaLibrary(id: '1', backend: MediaBackend.jellyfin, title: 'Movies', serverId: ServerId('ok'))],
        ),
      );
      manager.debugRegisterClientForTesting(
        _LibrariesClient(
          ServerId('torn-down'),
          error: MediaServerHttpException(type: MediaServerHttpErrorType.cancelled, message: 'HTTP client is closing'),
        ),
      );
      manager.debugRegisterClientForTesting(
        _LibrariesClient(
          ServerId('down'),
          error: MediaServerHttpException(type: MediaServerHttpErrorType.connectionError, message: 'refused'),
        ),
      );

      final result = await service.getMediaLibrariesFromAllServers();

      expect(result.libraries.map((l) => l.title), ['Movies']);
      expect(result.succeededServerIds, {'ok'});
      expect(result.cancelledServerIds, {'torn-down'});
    });

    test('search classifies successful, cancelled, and failed servers independently', () async {
      final item = testMediaItem(
        id: 'show-1',
        backend: MediaBackend.jellyfin,
        kind: MediaKind.show,
        title: 'Target',
        serverId: 'ok',
      );
      manager.debugRegisterClientForTesting(_LibrariesClient(ServerId('ok'), searchResults: [item]));
      manager.debugRegisterClientForTesting(
        _LibrariesClient(
          ServerId('cancelled'),
          searchError: MediaServerHttpException(type: MediaServerHttpErrorType.cancelled, message: 'superseded search'),
        ),
      );
      manager.debugRegisterClientForTesting(
        _LibrariesClient(
          ServerId('failed'),
          searchError: MediaServerHttpException(type: MediaServerHttpErrorType.connectionError, message: 'refused'),
        ),
      );

      final result = await service.searchAcrossServers('Target');

      expect(result.items.map((item) => item.id), ['show-1']);
      expect(result.succeededServerIds, {'ok'});
      expect(result.cancelledServerIds, {'cancelled'});
      expect(result.failedServerIds, {'failed'});
    });

    test('per-library hubs skip playback rows and fetch in bounded batches', () async {
      final captured = <Uri>[];
      var activeLatest = 0;
      var maxActiveLatest = 0;

      final client = JellyfinClient.forTesting(
        connection: _conn(),
        httpClient: MockClient((req) async {
          captured.add(req.url);
          if (req.url.path == '/Users/user-1/Views') {
            return _json({
              'Items': [
                {'Id': 'lib-1', 'Name': 'Lib 1', 'CollectionType': 'movies'},
                {'Id': 'lib-2', 'Name': 'Lib 2', 'CollectionType': 'movies'},
                {'Id': 'lib-3', 'Name': 'Lib 3', 'CollectionType': 'tvshows'},
                {'Id': 'lib-4', 'Name': 'Lib 4', 'CollectionType': 'tvshows'},
              ],
            });
          }
          if (req.url.path == '/Users/user-1/Items/Latest') {
            activeLatest++;
            if (activeLatest > maxActiveLatest) maxActiveLatest = activeLatest;
            try {
              await Future<void>.delayed(const Duration(milliseconds: 10));
              final parentId = req.url.queryParameters['ParentId']!;
              return _json({
                'Items': [
                  {'Id': 'item-$parentId', 'Type': 'Movie', 'Name': 'Latest $parentId', 'ParentLibraryId': parentId},
                ],
              });
            } finally {
              activeLatest--;
            }
          }
          return http.Response('unexpected request', 500);
        }),
      );
      addTearDown(client.close);
      manager.debugRegisterJellyfinClientForTesting(client);

      final result = await service.getHubsFromAllServers(prefetchLibraries: false, includePlaybackHubs: false);
      final hubs = result.hubs;

      expect(result.succeededServerIds, {'srv-1'});
      expect(hubs.map((h) => h.identifier), [
        'library.lib-1.recent',
        'library.lib-2.recent',
        'library.lib-3.recent',
        'library.lib-4.recent',
      ]);
      expect(hubs.map((h) => h.items.single.id), ['item-lib-1', 'item-lib-2', 'item-lib-3', 'item-lib-4']);
      expect(maxActiveLatest, lessThanOrEqualTo(3));
      expect(captured.where((uri) => uri.path == '/UserItems/Resume' || uri.path == '/Shows/NextUp'), isEmpty);
      expect(
        captured.where((uri) => uri.path == '/Users/user-1/Items/Latest').map((uri) => uri.queryParameters['ParentId']),
        ['lib-1', 'lib-2', 'lib-3', 'lib-4'],
      );
      expect(
        captured.where((uri) => uri.path == '/Users/user-1/Items/Latest').map((uri) => uri.queryParameters['Limit']),
        everyElement(defaultHubPreviewLimit.toString()),
      );
    });

    test('global home layout falls back to per-library hubs for Jellyfin', () async {
      final captured = <Uri>[];

      final client = JellyfinClient.forTesting(
        connection: _conn(),
        httpClient: MockClient((req) async {
          captured.add(req.url);
          if (req.url.path == '/Users/user-1/Views') {
            return _json({
              'Items': [
                {'Id': 'movies', 'Name': 'Movies', 'CollectionType': 'movies'},
                {'Id': 'shows', 'Name': 'Shows', 'CollectionType': 'tvshows'},
              ],
            });
          }
          if (req.url.path == '/Users/user-1/Items/Latest') {
            final parentId = req.url.queryParameters['ParentId'];
            return switch (parentId) {
              'movies' => _json({
                'Items': [
                  {'Id': 'movie-1', 'Type': 'Movie', 'Name': 'Latest Movie', 'ParentLibraryId': 'movies'},
                ],
              }),
              'shows' => _json({
                'Items': [
                  {'Id': 'show-1', 'Type': 'Series', 'Name': 'Latest Show', 'ParentLibraryId': 'shows'},
                ],
              }),
              _ => http.Response('mixed latest should not be requested', 500),
            };
          }
          return http.Response('unexpected request', 500);
        }),
      );
      addTearDown(client.close);
      manager.debugRegisterJellyfinClientForTesting(client);

      final result = await service.getHubsFromAllServers(prefetchLibraries: true, includePlaybackHubs: false);
      final hubs = result.hubs;

      expect(result.succeededServerIds, {'srv-1'});
      expect(hubs.map((h) => h.identifier), ['library.movies.recent', 'library.shows.recent']);
      expect(hubs.map((h) => h.items.single.id), ['movie-1', 'show-1']);
      expect(captured.where((uri) => uri.path == '/Users/user-1/Views'), hasLength(1));
      expect(
        captured.where((uri) => uri.path == '/Users/user-1/Items/Latest').map((uri) => uri.queryParameters['ParentId']),
        ['movies', 'shows'],
      );
      expect(
        captured.where((uri) => uri.path == '/Users/user-1/Items/Latest').map((uri) => uri.queryParameters['Limit']),
        everyElement(defaultHubPreviewLimit.toString()),
      );
    });

    test('per-library home rows include clip and music libraries and skip photo (#1476)', () async {
      final captured = <Uri>[];

      final client = JellyfinClient.forTesting(
        connection: _conn(),
        httpClient: MockClient((req) async {
          captured.add(req.url);
          if (req.url.path == '/Users/user-1/Views') {
            return _json({
              'Items': [
                {'Id': 'movies', 'Name': 'Movies', 'CollectionType': 'movies'},
                {'Id': 'mv', 'Name': 'Music Videos', 'CollectionType': 'musicvideos'},
                {'Id': 'home-vids', 'Name': 'Home Videos', 'CollectionType': 'homevideos'},
                {'Id': 'music', 'Name': 'Music', 'CollectionType': 'music'},
                {'Id': 'photos', 'Name': 'Photos', 'CollectionType': 'photos'},
              ],
            });
          }
          if (req.url.path == '/Users/user-1/Items/Latest') {
            final parentId = req.url.queryParameters['ParentId'];
            return switch (parentId) {
              'movies' => _json({
                'Items': [
                  {'Id': 'movie-1', 'Type': 'Movie', 'Name': 'Latest Movie', 'ParentLibraryId': 'movies'},
                ],
              }),
              'mv' => _json({
                'Items': [
                  {'Id': 'mv-1', 'Type': 'MusicVideo', 'Name': 'Latest Music Video', 'ParentLibraryId': 'mv'},
                ],
              }),
              'home-vids' => _json({
                'Items': [
                  {'Id': 'vid-1', 'Type': 'Video', 'Name': 'Latest Home Video', 'ParentLibraryId': 'home-vids'},
                ],
              }),
              'music' => _json({
                'Items': [
                  {'Id': 'album-1', 'Type': 'MusicAlbum', 'Name': 'Latest Album', 'ParentLibraryId': 'music'},
                ],
              }),
              _ => http.Response('latest should not be requested for $parentId', 500),
            };
          }
          // Music library's played-track rows — empty so only the Latest
          // Albums hub survives.
          if (req.url.path == '/Items' && req.url.queryParameters['Filters'] == 'IsPlayed') {
            return _json({'Items': const <Object>[]});
          }
          return http.Response('unexpected request', 500);
        }),
      );
      addTearDown(client.close);
      manager.debugRegisterJellyfinClientForTesting(client);

      final result = await service.getHubsFromAllServers(prefetchLibraries: true, includePlaybackHubs: false);
      final hubs = result.hubs;

      expect(result.succeededServerIds, {'srv-1'});
      expect(hubs.map((h) => h.identifier), [
        'library.movies.recent',
        'library.mv.recent',
        'library.home-vids.recent',
        'library.music.latestalbums',
      ]);
      expect(hubs[1].items.single.kind, MediaKind.clip);
      expect(hubs[3].items.single.kind, MediaKind.album);
      expect(
        captured.where((uri) => uri.path == '/Users/user-1/Items/Latest').map((uri) => uri.queryParameters['ParentId']),
        ['movies', 'mv', 'home-vids', 'music'],
      );
      expect(
        captured.where((uri) => uri.path == '/Items' && uri.queryParameters['Filters'] == 'IsPlayed'),
        isEmpty,
        reason: 'the home screen excludes playback-derived music rows',
      );
      // Music Latest returns album FOLDER dtos — count/user-data fields would
      // each cost a recursive per-album COUNT query (#1552); video libraries
      // keep the full browse fields (series leaf counts).
      final musicLatest = captured.singleWhere(
        (uri) => uri.path == '/Users/user-1/Items/Latest' && uri.queryParameters['ParentId'] == 'music',
      );
      expect(musicLatest.queryParameters['Fields'], 'PremiereDate,OriginalTitle,SortName');
      expect(musicLatest.queryParameters['EnableUserData'], 'false');
      final movieLatest = captured.singleWhere(
        (uri) => uri.path == '/Users/user-1/Items/Latest' && uri.queryParameters['ParentId'] == 'movies',
      );
      expect(movieLatest.queryParameters['Fields'], contains('RecursiveItemCount'));
      expect(movieLatest.queryParameters.containsKey('EnableUserData'), isFalse);
    });

    test('music library recommendations retain recently and most-played rows', () async {
      final captured = <Uri>[];
      final client = JellyfinClient.forTesting(
        connection: _conn(),
        httpClient: MockClient((req) async {
          captured.add(req.url);
          if (req.url.path == '/Users/user-1/Items/Latest') {
            return _json([
              {'Id': 'album-1', 'Type': 'MusicAlbum', 'Name': 'Latest Album', 'ParentLibraryId': 'music'},
            ]);
          }
          if (req.url.path == '/Items' && req.url.queryParameters['Filters'] == 'IsPlayed') {
            final sortBy = req.url.queryParameters['SortBy'];
            return _json({
              'Items': [
                {
                  'Id': sortBy == 'DatePlayed' ? 'recent-track' : 'most-played-track',
                  'Type': 'Audio',
                  'Name': sortBy == 'DatePlayed' ? 'Recent Track' : 'Most Played Track',
                  'ParentLibraryId': 'music',
                },
              ],
            });
          }
          return http.Response('unexpected request', 500);
        }),
      );
      addTearDown(client.close);

      final hubs = await client.fetchLibraryHubs(
        'music',
        libraryName: 'Music',
        libraryKind: MediaKind.artist,
        includePlaybackHubs: true,
      );

      expect(hubs.map((hub) => hub.identifier), [
        'library.music.latestalbums',
        'library.music.recentlyplayed',
        'library.music.mostplayed',
      ]);
      final playedQueries = captured
          .where((uri) => uri.path == '/Items' && uri.queryParameters['Filters'] == 'IsPlayed')
          .toList();
      expect(playedQueries.map((uri) => uri.queryParameters['SortBy']), ['DatePlayed', 'PlayCount']);
      // Audio LEAF dtos: UserData stays (cheap, drives play state); the
      // folder count fields and Overview are dropped.
      expect(playedQueries.map((uri) => uri.queryParameters['Fields']).toSet(), {
        'UserData,PremiereDate,OriginalTitle,SortName',
      });
    });
  });
}
