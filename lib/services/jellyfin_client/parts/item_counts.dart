part of '../../jellyfin_client.dart';

/// What a server holds, as it reports it.
///
/// Jellyfin publishes counts but no total size, so there is deliberately no
/// storage figure here — the number would have to be invented.
class JellyfinItemCounts {
  const JellyfinItemCounts({required this.movies, required this.series, required this.episodes});

  final int movies;
  final int series;
  final int episodes;

  bool get isEmpty => movies == 0 && series == 0 && episodes == 0;
}

mixin _JellyfinItemCountMethods on _JellyfinClientInternals {
  /// `/Items/Counts` — one call, used to confirm a fresh connection actually
  /// reached a library rather than just a login screen.
  Future<JellyfinItemCounts> fetchItemCounts({AbortController? abort}) async {
    final response = await _http.get('/Items/Counts', queryParameters: {'userId': connection.userId}, abort: abort);
    final json = response.data;
    int count(String key) => json is Map ? (json[key] as num?)?.toInt() ?? 0 : 0;
    return JellyfinItemCounts(
      movies: count('MovieCount'),
      series: count('SeriesCount'),
      episodes: count('EpisodeCount'),
    );
  }
}
