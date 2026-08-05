import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_server_client.dart';
import 'package:harbor/services/trackers/tracker_id_resolver.dart';
import 'package:harbor/utils/external_ids.dart';

import '../../test_helpers/media_items.dart';

class _FakeMediaServerClient implements MediaServerClient {
  final Map<String, ExternalIds> externalIdsByItem;
  final List<String> externalIdCalls = [];

  _FakeMediaServerClient(this.externalIdsByItem);

  @override
  Future<ExternalIds> fetchExternalIds(String itemId) async {
    externalIdCalls.add(itemId);
    return externalIdsByItem[itemId] ?? const ExternalIds();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const showIds = ExternalIds(tvdb: 121361, imdb: 'tt0944947');

  test('a movie resolves to its own external ids', () async {
    final client = _FakeMediaServerClient({'movie-1': const ExternalIds(tmdb: 27205)});
    final ids = await TrackerIdResolver(client).resolveForMovie('movie-1');

    expect(ids?.external.tmdb, 27205);
  });

  test('an item the server has no ids for resolves to nothing', () async {
    final client = _FakeMediaServerClient({});
    expect(await TrackerIdResolver(client).resolveForMovie('unknown'), isNull);
  });

  test('an episode resolves against its show, which is what trackers key on', () async {
    final client = _FakeMediaServerClient({'show-1': showIds});
    final episode = testMediaItem(
      id: 'episode-9',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      grandparentId: 'show-1',
      parentIndex: 1,
      index: 9,
    );

    final ids = await TrackerIdResolver(client).resolveShowForEpisode(episode);

    expect(ids?.external.tvdb, 121361);
    expect(client.externalIdCalls, ['show-1'], reason: 'the episode itself is never fetched');
  });

  test('an episode with no show cannot resolve', () async {
    final client = _FakeMediaServerClient({'show-1': showIds});
    final orphan = testMediaItem(id: 'episode-9', kind: MediaKind.episode, parentIndex: 1, index: 9);

    expect(await TrackerIdResolver(client).resolveShowForEpisode(orphan), isNull);
    expect(client.externalIdCalls, isEmpty);
  });

  test('repeat lookups are served from cache, including the misses', () async {
    final client = _FakeMediaServerClient({'movie-1': const ExternalIds(tmdb: 27205)});
    final resolver = TrackerIdResolver(client);

    await resolver.resolveForMovie('movie-1');
    await resolver.resolveForMovie('movie-1');
    await resolver.resolveForMovie('nothing');
    await resolver.resolveForMovie('nothing');

    expect(client.externalIdCalls, ['movie-1', 'nothing']);

    resolver.clearCache();
    await resolver.resolveForMovie('movie-1');
    expect(client.externalIdCalls, ['movie-1', 'nothing', 'movie-1']);
  });

  group('rating context', () {
    test('a season carries its number alongside the show ids', () async {
      final client = _FakeMediaServerClient({'show-1': showIds});
      final season = testMediaItem(id: 'season-2', kind: MediaKind.season, parentId: 'show-1', index: 2);

      final ctx = await TrackerIdResolver(client).resolveForRating(season);

      expect(ctx?.kind, MediaKind.season);
      expect(ctx?.season, 2);
      expect(ctx?.episodeNumber, isNull);
      expect(ctx?.ids.external.tvdb, 121361);
    });

    test('an episode carries both coordinates', () async {
      final client = _FakeMediaServerClient({'show-1': showIds});
      final episode = testMediaItem(
        id: 'episode-9',
        kind: MediaKind.episode,
        grandparentId: 'show-1',
        parentIndex: 1,
        index: 9,
      );

      final ctx = await TrackerIdResolver(client).resolveForRating(episode);

      expect(ctx?.kind, MediaKind.episode);
      expect(ctx?.season, 1);
      expect(ctx?.episodeNumber, 9);
    });

    test('an episode missing its coordinates cannot be rated', () async {
      final client = _FakeMediaServerClient({'show-1': showIds});
      final episode = testMediaItem(id: 'episode-9', kind: MediaKind.episode, grandparentId: 'show-1');

      expect(await TrackerIdResolver(client).resolveForRating(episode), isNull);
    });

    test('a movie is reported as one', () async {
      final client = _FakeMediaServerClient({'movie-1': const ExternalIds(tmdb: 27205)});
      final ctx = await TrackerIdResolver(client).resolveForRating(testMediaItem(id: 'movie-1', kind: MediaKind.movie));

      expect(ctx?.isMovie, isTrue);
    });
  });
}
