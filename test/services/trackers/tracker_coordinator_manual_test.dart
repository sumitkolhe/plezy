import 'dart:convert';
import 'package:harbor/media/ids.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_item.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_server_client.dart';
import 'package:harbor/services/trackers/tracker_coordinator.dart';
import 'package:harbor/services/trackers/tracker_session.dart';
import 'package:harbor/services/trackers/trakt/trakt_tracker.dart';
import 'package:harbor/utils/external_ids.dart';
import '../../test_helpers/media_items.dart';

class _FakeMediaServerClient implements MediaServerClient {
  @override
  final ServerId serverId;
  @override
  String? get serverName => null;

  final Map<String, ExternalIds> externalIdsByItem;
  final Map<String, List<MediaItem>> descendantsByParent;
  final List<String> externalIdCalls = [];
  final List<String> descendantCalls = [];

  @override
  final double watchedThreshold;

  _FakeMediaServerClient({
    ServerId? serverId,
    required this.externalIdsByItem,
    required this.descendantsByParent,
    this.watchedThreshold = 0.9,
  }) : serverId = serverId ?? ServerId('server-1');

  @override
  MediaBackend get backend => MediaBackend.jellyfin;

  @override
  Future<ExternalIds> fetchExternalIds(String itemId) async {
    externalIdCalls.add(itemId);
    return externalIdsByItem[itemId] ?? const ExternalIds();
  }

  @override
  Future<List<MediaItem>> fetchPlayableDescendants(String parentId) async {
    descendantCalls.add(parentId);
    return descendantsByParent[parentId] ?? const [];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

MediaItem _season() => testMediaItem(
  id: 'season-1',
  backend: MediaBackend.jellyfin,
  kind: MediaKind.season,
  title: 'Season 1',
  serverId: ServerId('server-1'),
  libraryId: 'lib-1',
  index: 1,
  parentId: 'show-1',
);

MediaItem _episode(int number, {int season = 1}) => testMediaItem(
  id: 'episode-$season-$number',
  backend: MediaBackend.jellyfin,
  kind: MediaKind.episode,
  title: 'Episode $number',
  serverId: ServerId('server-1'),
  libraryId: 'lib-1',
  parentIndex: season,
  index: number,
);

MediaItem _movie() => testMediaItem(
  id: 'movie-1',
  backend: MediaBackend.jellyfin,
  kind: MediaKind.movie,
  title: 'Movie 1',
  serverId: ServerId('server-1'),
  libraryId: 'lib-1',
);

TrackerSession _traktSession() {
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  return TrackerSession(
    accessToken: 'token',
    refreshToken: 'refresh',
    expiresAt: now + 86400,
    scope: 'public',
    createdAt: now,
  );
}

void main() {
  group('TrackerCoordinator manual watched sync', () {
    final coordinator = TrackerCoordinator.instance;
    final trakt = TraktTracker.instance;

    setUp(() async {
      await trakt.setEnabled(true);
      await trakt.setWatchedSyncEnabled(true);
    });

    tearDown(() async {
      coordinator.cancelInFlight();
      trakt.rebindSession(null, onSessionInvalidated: () {});
      await trakt.setEnabled(false);
      await trakt.setWatchedSyncEnabled(false);
    });

    test('expands a manually watched season and fills missing episode show context', () async {
      final bodies = <Map<String, dynamic>>[];
      final httpClient = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/sync/history');
        bodies.add((json.decode(request.body) as Map).cast<String, dynamic>());
        return http.Response('{}', 200);
      });
      trakt.rebindSession(_traktSession(), onSessionInvalidated: () {}, httpClient: httpClient);

      final client = _FakeMediaServerClient(
        externalIdsByItem: {'show-1': const ExternalIds(tvdb: 12345)},
        descendantsByParent: {
          'season-1': [_episode(1), _episode(2)],
        },
      );

      await coordinator.markWatched(_season(), client);

      expect(client.descendantCalls, ['season-1']);
      expect(client.externalIdCalls, ['show-1']);
      expect(bodies, hasLength(2));
      expect(bodies[0]['shows'], [
        {
          'ids': {'tvdb': 12345},
          'seasons': [
            {
              'number': 1,
              'episodes': [
                {'number': 1},
              ],
            },
          ],
        },
      ]);
      expect(bodies[1]['shows'], [
        {
          'ids': {'tvdb': 12345},
          'seasons': [
            {
              'number': 1,
              'episodes': [
                {'number': 2},
              ],
            },
          ],
        },
      ]);
    });

    test('removes manually unwatched season episodes from Trakt history', () async {
      final bodies = <Map<String, dynamic>>[];
      final httpClient = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/sync/history/remove');
        bodies.add((json.decode(request.body) as Map).cast<String, dynamic>());
        return http.Response('{}', 200);
      });
      trakt.rebindSession(_traktSession(), onSessionInvalidated: () {}, httpClient: httpClient);

      final client = _FakeMediaServerClient(
        externalIdsByItem: {'show-1': const ExternalIds(tvdb: 12345)},
        descendantsByParent: {
          'season-1': [_episode(1), _episode(2)],
        },
      );

      await coordinator.markUnwatched(_season(), client);

      expect(client.descendantCalls, ['season-1']);
      expect(bodies, hasLength(2));
      expect(bodies.first['shows'], [
        {
          'ids': {'tvdb': 12345},
          'seasons': [
            {
              'number': 1,
              'episodes': [
                {'number': 1},
              ],
            },
          ],
        },
      ]);
    });

    test('playback resolver is recreated when the server client changes', () async {
      trakt.rebindSession(
        _traktSession(),
        onSessionInvalidated: () {},
        httpClient: MockClient((_) async => http.Response('{}', 200)),
      );

      final firstClient = _FakeMediaServerClient(
        serverId: ServerId('server-a'),
        externalIdsByItem: {'show-a': const ExternalIds(tvdb: 111)},
        descendantsByParent: const {},
      );
      final secondClient = _FakeMediaServerClient(
        serverId: ServerId('server-b'),
        externalIdsByItem: {'show-b': const ExternalIds(tvdb: 222)},
        descendantsByParent: const {},
      );
      final firstEpisode = _episode(
        1,
      ).copyWith(id: 'episode-a', serverId: ServerId('server-a'), grandparentId: 'show-a');
      final secondEpisode = _episode(
        1,
      ).copyWith(id: 'episode-b', serverId: ServerId('server-b'), grandparentId: 'show-b');

      await coordinator.startPlayback(firstEpisode, firstClient);
      await coordinator.startPlayback(secondEpisode, secondClient);

      expect(firstClient.externalIdCalls, ['show-a']);
      expect(secondClient.externalIdCalls, ['show-b']);
    });
  });

  group('TrackerCoordinator playback threshold', () {
    final coordinator = TrackerCoordinator.instance;
    final trakt = TraktTracker.instance;

    setUp(() async {
      // A threshold tracker's crossing owns its watched write. Trakt is excluded
      // from that fan-out because it reports playback in real time, so it stays
      // off here — see trakt_scrobble_test.dart.
      await trakt.setEnabled(false);
    });

    tearDown(() async {
      coordinator.cancelInFlight();
    });

    test('leaves real-time trackers out of the threshold watched write', () async {
      final requests = <String>[];
      final httpClient = MockClient((request) async {
        requests.add(request.url.path);
        return http.Response('{}', 200);
      });
      await trakt.setEnabled(true);
      trakt.rebindSession(_traktSession(), onSessionInvalidated: () {}, httpClient: httpClient);
      addTearDown(() async {
        trakt.rebindSession(null, onSessionInvalidated: () {});
        await trakt.setEnabled(false);
      });

      final client = _FakeMediaServerClient(
        externalIdsByItem: {'movie-1': const ExternalIds(tmdb: 603)},
        descendantsByParent: const {},
        watchedThreshold: 0.9,
      );

      await coordinator.startPlayback(_movie(), client);
      coordinator.updateDuration(const Duration(seconds: 100));
      coordinator.updatePosition(const Duration(seconds: 95));
      await pumpEventQueue();

      expect(requests, isNot(contains('/sync/history')));
    });
  });
}
