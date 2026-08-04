import '../../models/arr/managed_service.dart';
import '../../providers/managed_services_provider.dart';
import '../../utils/app_logger.dart';
import '../../utils/external_ids.dart';
import '../trackers/future_coalescer.dart';

/// One episode as Sonarr knows it — including the ones no file exists for,
/// which is the whole point: Jellyfin cannot report an episode it has never
/// seen.
class ArrEpisode {
  final int seasonNumber;
  final int episodeNumber;
  final String title;
  final bool hasFile;
  final bool monitored;

  /// Null for an episode with no announced date.
  final DateTime? airDate;

  const ArrEpisode({
    required this.seasonNumber,
    required this.episodeNumber,
    required this.title,
    required this.hasFile,
    required this.monitored,
    this.airDate,
  });

  bool get hasAired => airDate != null && airDate!.isBefore(DateTime.now());

  static ArrEpisode? fromJson(Map<String, dynamic> json) {
    final season = (json['seasonNumber'] as num?)?.toInt();
    final number = (json['episodeNumber'] as num?)?.toInt();
    if (season == null || number == null) return null;
    final air = json['airDateUtc'] as String?;
    return ArrEpisode(
      seasonNumber: season,
      episodeNumber: number,
      title: (json['title'] as String?)?.trim() ?? '',
      hasFile: json['hasFile'] == true,
      monitored: json['monitored'] == true,
      airDate: air == null ? null : DateTime.tryParse(air)?.toLocal(),
    );
  }
}

/// What one instance knows about a library item.
class ArrItemState {
  /// The instance's connection id, so the caller can tell one Radarr's movie 41
  /// from another's.
  final String sourceId;
  final String sourceName;

  /// The instance's own id for the film or series — the key its queue records
  /// carry.
  final int mediaId;

  final bool monitored;

  /// Files present and expected. For a film that is 0 or 1 of 1; for a series
  /// it is the episode count, which is what "4 missing" comes from.
  final int fileCount;
  final int totalCount;

  final String qualityProfile;

  /// When the next episode airs, as Sonarr computed it. Null for films and for
  /// series with nothing scheduled.
  final DateTime? nextAiring;

  const ArrItemState({
    required this.sourceId,
    required this.sourceName,
    required this.mediaId,
    required this.monitored,
    this.fileCount = 0,
    this.totalCount = 0,
    this.qualityProfile = '',
    this.nextAiring,
  });

  int get missingCount => totalCount <= 0 ? 0 : (totalCount - fileCount).clamp(0, totalCount);
}

/// Resolves a library item to the *arr instances tracking it.
///
/// Radarr is keyed by TMDB id and Sonarr by TVDB id — the ids are not
/// interchangeable, and asking one with the other's id quietly returns nothing.
///
/// Every instance of the right kind is asked, because which one holds a title is
/// not knowable up front: people split by resolution, language or anime, and a
/// title can legitimately sit in two.
class ArrItemLookup {
  ArrItemLookup(this._services);

  final ManagedServicesProvider _services;

  final Map<String, List<ArrItemState>> _cache = {};
  final KeyedFutureCache<String, List<ArrItemState>> _loads = KeyedFutureCache();

  /// Quality profile names per instance: ids alone are meaningless on screen,
  /// and the list changes about once a year.
  final Map<String, Map<int, String>> _profileNames = {};

  final Map<String, List<ArrEpisode>> _episodeCache = {};
  final KeyedFutureCache<String, List<ArrEpisode>> _episodeLoads = KeyedFutureCache();

  void clear() {
    _cache.clear();
    _loads.clear();
    _profileNames.clear();
    _episodeCache.clear();
    _episodeLoads.clear();
  }

  /// Cached states, or null when this item has not been looked up yet.
  List<ArrItemState>? cached(ExternalIds ids, {required bool isSeries}) => _cache[_key(ids, isSeries: isSeries)];

  /// Looks the item up across every instance of the matching kind. Coalesced,
  /// so several widgets asking at once cost one round of requests.
  Future<List<ArrItemState>> resolve(ExternalIds ids, {required bool isSeries}) {
    final key = _key(ids, isSeries: isSeries);
    final cached = _cache[key];
    if (cached != null) return Future.value(cached);
    if (key.isEmpty) return Future.value(const []);
    return _loads.run(key, () async {
      final states = await _resolveUncached(ids, isSeries: isSeries);
      _cache[key] = states;
      return states;
    });
  }

  Future<List<ArrItemState>> _resolveUncached(ExternalIds ids, {required bool isSeries}) async {
    final kind = isSeries ? ManagedServiceKind.sonarr : ManagedServiceKind.radarr;
    final states = <ArrItemState>[];

    for (final connection in _services.of(kind)) {
      final client = _services.arrClient(connection.id);
      if (client == null) continue;
      try {
        final path = isSeries ? '/series' : '/movie';
        final query = isSeries ? {'tvdbId': '${ids.tvdb}'} : {'tmdbId': '${ids.tmdb}'};
        final data = await client.get(path, query: query);
        if (data is! List) continue;
        for (final entry in data) {
          if (entry is! Map<String, dynamic>) continue;
          final mediaId = (entry['id'] as num?)?.toInt();
          if (mediaId == null) continue;
          states.add(
            ArrItemState(
              sourceId: connection.id,
              sourceName: connection.displayName,
              mediaId: mediaId,
              monitored: entry['monitored'] == true,
              fileCount: _fileCount(entry, isSeries: isSeries),
              totalCount: _totalCount(entry, isSeries: isSeries),
              qualityProfile: await _profileName(connection.id, (entry['qualityProfileId'] as num?)?.toInt()),
              nextAiring: DateTime.tryParse(entry['nextAiring'] as String? ?? '')?.toLocal(),
            ),
          );
        }
      } catch (e) {
        appLogger.d('${connection.kind.name}: item lookup failed', error: e);
      }
    }
    return states;
  }

  /// A film has no statistics block, so its file count comes from `hasFile`.
  int _fileCount(Map<String, dynamic> entry, {required bool isSeries}) {
    if (!isSeries) return entry['hasFile'] == true ? 1 : 0;
    final statistics = entry['statistics'];
    return statistics is Map<String, dynamic> ? ((statistics['episodeFileCount'] as num?) ?? 0).toInt() : 0;
  }

  int _totalCount(Map<String, dynamic> entry, {required bool isSeries}) {
    if (!isSeries) return 1;
    final statistics = entry['statistics'];
    if (statistics is! Map<String, dynamic>) return 0;
    // episodeCount counts only aired episodes, which is what "missing" should
    // mean — totalEpisodeCount includes unaired ones and would report a
    // currently-airing series as permanently incomplete.
    return ((statistics['episodeCount'] as num?) ?? 0).toInt();
  }

  /// Every episode Sonarr tracks for a series, cached per instance and series.
  Future<List<ArrEpisode>> episodes(String sourceId, int seriesId) {
    final key = 'episodes/$sourceId/$seriesId';
    final cached = _episodeCache[key];
    if (cached != null) return Future.value(cached);
    return _episodeLoads.run(key, () async {
      final client = _services.arrClient(sourceId);
      if (client == null) return const <ArrEpisode>[];
      try {
        final data = await client.get('/episode', query: {'seriesId': '$seriesId'});
        if (data is! List) return const <ArrEpisode>[];
        final episodes = [
          for (final entry in data)
            if (entry is Map<String, dynamic>) ?ArrEpisode.fromJson(entry),
        ]..sort((a, b) {
          final bySeason = a.seasonNumber.compareTo(b.seasonNumber);
          return bySeason != 0 ? bySeason : a.episodeNumber.compareTo(b.episodeNumber);
        });
        _episodeCache[key] = episodes;
        return episodes;
      } catch (e) {
        appLogger.d('episode lookup failed', error: e);
        return const <ArrEpisode>[];
      }
    });
  }

  List<ArrEpisode>? cachedEpisodes(String sourceId, int seriesId) => _episodeCache['episodes/$sourceId/$seriesId'];

  Future<String> _profileName(String sourceId, int? profileId) async {
    if (profileId == null) return '';
    final known = _profileNames[sourceId];
    if (known != null) return known[profileId] ?? '';
    final client = _services.arrClient(sourceId);
    if (client == null) return '';
    try {
      final data = await client.get('/qualityprofile');
      if (data is! List) return '';
      final names = <int, String>{};
      for (final entry in data) {
        if (entry is! Map<String, dynamic>) continue;
        final id = (entry['id'] as num?)?.toInt();
        final name = entry['name'] as String?;
        if (id != null && name != null) names[id] = name;
      }
      _profileNames[sourceId] = names;
      return names[profileId] ?? '';
    } catch (e) {
      appLogger.d('quality profile lookup failed', error: e);
      return '';
    }
  }

  String _key(ExternalIds ids, {required bool isSeries}) {
    final id = isSeries ? ids.tvdb : ids.tmdb;
    return id == null ? '' : '${isSeries ? 'series' : 'movie'}/$id';
  }
}
