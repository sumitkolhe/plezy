import '../../models/arr/arr_release.dart';
import '../../providers/managed_services_provider.dart';
import 'arr_item_lookup.dart';

/// What to search for. A series can be searched whole, by season, or by one
/// episode, and each is a different *arr command.
sealed class ArrSearchTarget {
  const ArrSearchTarget();
}

class MovieSearch extends ArrSearchTarget {
  final int movieId;
  const MovieSearch(this.movieId);
}

class SeriesSearch extends ArrSearchTarget {
  final int seriesId;
  const SeriesSearch(this.seriesId);
}

class SeasonSearch extends ArrSearchTarget {
  final int seriesId;
  final int seasonNumber;
  const SeasonSearch(this.seriesId, this.seasonNumber);
}

class EpisodeSearch extends ArrSearchTarget {
  final int episodeId;
  const EpisodeSearch(this.episodeId);
}

/// Triggers *arr's own searches and fetches candidate releases.
///
/// Seerr cannot do either: it creates requests, and has no endpoint to search
/// for something already tracked or to list releases. So this talks to Radarr
/// and Sonarr directly.
class ArrSearchService {
  const ArrSearchService(this._services);

  final ManagedServicesProvider _services;

  /// Hands the search to *arr and returns once it has accepted the command —
  /// not once it finds anything. Results surface in the queue, which the
  /// Activity tab is already polling.
  Future<void> searchAutomatically(ArrItemState state, ArrSearchTarget target) async {
    final client = _services.arrClient(state.sourceId);
    if (client == null) return;
    await client.post('/command', switch (target) {
      MovieSearch(:final movieId) => {
        'name': 'MoviesSearch',
        'movieIds': [movieId],
      },
      SeriesSearch(:final seriesId) => {'name': 'SeriesSearch', 'seriesId': seriesId},
      SeasonSearch(:final seriesId, :final seasonNumber) => {
        'name': 'SeasonSearch',
        'seriesId': seriesId,
        'seasonNumber': seasonNumber,
      },
      EpisodeSearch(:final episodeId) => {
        'name': 'EpisodeSearch',
        'episodeIds': [episodeId],
      },
    });
  }

  /// Candidate releases, ordered by [sortReleases].
  ///
  /// This is a live indexer query on the server's side and routinely takes
  /// tens of seconds, so callers must show it as work in progress.
  Future<List<ArrRelease>> releases(ArrItemState state, ArrSearchTarget target) async {
    final client = _services.arrClient(state.sourceId);
    if (client == null) return const [];
    final query = switch (target) {
      MovieSearch(:final movieId) => {'movieId': '$movieId'},
      EpisodeSearch(:final episodeId) => {'episodeId': '$episodeId'},
      SeriesSearch(:final seriesId) => {'seriesId': '$seriesId'},
      SeasonSearch(:final seriesId, :final seasonNumber) => {'seriesId': '$seriesId', 'seasonNumber': '$seasonNumber'},
    };
    final data = await client.get('/release', query: query);
    if (data is! List) return const [];
    return sortReleases([
      for (final entry in data)
        if (entry is Map<String, dynamic>) ?ArrRelease.fromJson(entry),
    ]);
  }

  /// Grabs one release. *arr answers as soon as it has handed the release to
  /// the download client, so success here means "accepted", not "downloaded".
  Future<void> grab(ArrItemState state, ArrRelease release) async {
    final client = _services.arrClient(state.sourceId);
    if (client == null) return;
    await client.post('/release', {'guid': release.guid, 'indexerId': release.indexerId});
  }
}
