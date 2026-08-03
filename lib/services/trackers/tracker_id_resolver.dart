import '../../media/media_item.dart';
import '../../media/media_kind.dart';
import '../../media/media_server_client.dart';
import '../../utils/external_ids.dart';
import 'future_coalescer.dart';

class TrackerIds {
  final ExternalIds external;

  const TrackerIds({required this.external});
}

/// Resolved IDs for manually rating a media item on external trackers.
///
/// For TV items, [ids] is the show-level ID set; the season and episode
/// numbers beside it are how a tracker addresses anything below the show.
class TrackerRatingContext {
  final TrackerIds ids;
  final MediaKind kind;
  final int? season;
  final int? episodeNumber;

  const TrackerRatingContext({required this.ids, required this.kind, this.season, this.episodeNumber});

  bool get isMovie => kind == MediaKind.movie;
}

/// Resolves item ids to the external IDs (tvdb/tmdb/imdb) a tracker addresses
/// them by. Episodes resolve against their show, which is the level trackers
/// key on.
class TrackerIdResolver {
  final MediaServerClient _client;

  /// Null entries mean "the server had no IDs" — cached so scrubbing on an
  /// un-matched item doesn't re-hit the server every position update.
  final Map<String, TrackerIds?> _cache = {};
  final KeyedFutureCache<String, ExternalIds> _externalIdLoads = KeyedFutureCache();

  TrackerIdResolver(MediaServerClient client) : _client = client;

  Future<TrackerIds?> resolveForMovie(String itemId) => _resolve(itemId);

  Future<TrackerIds?> resolveShowForEpisode(MediaItem episode) async {
    final showId = episode.grandparentId;
    if (showId == null || showId.isEmpty) return null;
    return _resolve(showId);
  }

  /// Ratings can be attached to a movie, show, season, or episode from the
  /// detail screen and the context menu.
  Future<TrackerRatingContext?> resolveForRating(MediaItem item) async {
    switch (item.kind) {
      case MediaKind.movie:
        final ids = await _resolve(item.id);
        return ids == null ? null : TrackerRatingContext(ids: ids, kind: MediaKind.movie);
      case MediaKind.show:
        final ids = await _resolve(item.id);
        return ids == null ? null : TrackerRatingContext(ids: ids, kind: MediaKind.show);
      case MediaKind.season:
        final showId = item.parentId;
        final season = item.index ?? item.parentIndex;
        if (showId == null || showId.isEmpty || season == null) return null;
        final ids = await _resolve(showId);
        return ids == null ? null : TrackerRatingContext(ids: ids, kind: MediaKind.season, season: season);
      case MediaKind.episode:
        final season = item.parentIndex;
        final number = item.index;
        if (season == null || number == null) return null;
        final ids = await resolveShowForEpisode(item);
        return ids == null
            ? null
            : TrackerRatingContext(ids: ids, kind: MediaKind.episode, season: season, episodeNumber: number);
      default:
        return null;
    }
  }

  void clearCache() {
    _cache.clear();
    _externalIdLoads.clear();
  }

  Future<TrackerIds?> _resolve(String itemId) async {
    if (_cache.containsKey(itemId)) return _cache[itemId];
    final external = await _externalIdLoads.run(itemId, () => _client.fetchExternalIds(itemId));
    final ids = external.hasAny ? TrackerIds(external: external) : null;
    _cache[itemId] = ids;
    return ids;
  }
}
