/// Something an *arr is tracking that has no file yet — requested, or monitored
/// and still being hunted.
///
/// The library cannot know about these: Jellyfin has never seen them. So the
/// poster and title come from the *arr, which took them from TMDB or TVDB.
///
/// A film and an episode differ only in what identifies them on screen, so both
/// live here: an episode fills [seriesTitle], [seasonNumber], [episodeNumber]
/// and [airDate], and carries its *series* id in [mediaId] because that is what
/// a Sonarr queue record names.
class AbsentTitle {
  final String sourceId;
  final String sourceName;

  /// Radarr's own id, and the key its queue records carry.
  final int mediaId;

  final String title;
  final int? year;
  final int? tmdbId;

  /// The episode's own id, which is what a search is issued against — [mediaId]
  /// is the series, because that is what a queue record names.
  final int? episodeId;

  /// Set for an episode; null for a film.
  final String? seriesTitle;
  final int? seasonNumber;
  final int? episodeNumber;

  /// When the episode aired. Sonarr's missing list is already limited to what
  /// has been broadcast, so this dates the gap rather than predicting it.
  final DateTime? airDate;

  /// A public TMDB URL, so it needs no *arr credentials to load.
  final String? posterUrl;

  final bool monitored;

  const AbsentTitle({
    required this.sourceId,
    required this.sourceName,
    required this.mediaId,
    required this.title,
    this.year,
    this.tmdbId,
    this.episodeId,
    this.seriesTitle,
    this.seasonNumber,
    this.episodeNumber,
    this.airDate,
    this.posterUrl,
    this.monitored = true,
  });

  bool get isEpisode => episodeNumber != null;

  /// One Sonarr `/wanted/missing` record. The series payload rides along only
  /// when the caller asked for it, and without it there is no poster and no
  /// series name worth showing.
  static AbsentTitle? fromEpisodeJson(
    Map<String, dynamic> json, {
    required String sourceId,
    required String sourceName,
  }) {
    final seriesId = (json['seriesId'] as num?)?.toInt();
    final episodeNumber = (json['episodeNumber'] as num?)?.toInt();
    if (seriesId == null || episodeNumber == null) return null;
    if (json['hasFile'] == true) return null;

    final series = json['series'] as Map<String, dynamic>?;
    final episodeTitle = (json['title'] as String?)?.trim() ?? '';
    final seriesTitle = (series?['title'] as String?)?.trim();
    if (episodeTitle.isEmpty && (seriesTitle == null || seriesTitle.isEmpty)) return null;

    return AbsentTitle(
      sourceId: sourceId,
      sourceName: sourceName,
      mediaId: seriesId,
      episodeId: (json['id'] as num?)?.toInt(),
      title: episodeTitle,
      seriesTitle: seriesTitle,
      seasonNumber: (json['seasonNumber'] as num?)?.toInt(),
      episodeNumber: episodeNumber,
      airDate: DateTime.tryParse(json['airDateUtc'] as String? ?? '')?.toLocal(),
      posterUrl: _poster(series?['images']),
      monitored: json['monitored'] == true,
    );
  }

  static AbsentTitle? fromJson(Map<String, dynamic> json, {required String sourceId, required String sourceName}) {
    final mediaId = (json['id'] as num?)?.toInt();
    final title = (json['title'] as String?)?.trim() ?? '';
    if (mediaId == null || title.isEmpty) return null;
    // A film with a file is not absent, whatever list it arrived in.
    if (json['hasFile'] == true) return null;

    return AbsentTitle(
      sourceId: sourceId,
      sourceName: sourceName,
      mediaId: mediaId,
      title: title,
      year: (json['year'] as num?)?.toInt(),
      tmdbId: (json['tmdbId'] as num?)?.toInt(),
      posterUrl: _poster(json['images']),
      monitored: json['monitored'] == true,
    );
  }

  /// Prefers `remoteUrl`: the local `url` needs the instance's own host and key,
  /// while the remote one is a plain TMDB image.
  static String? _poster(Object? images) {
    if (images is! List) return null;
    for (final image in images) {
      if (image is! Map<String, dynamic>) continue;
      if (image['coverType'] != 'poster') continue;
      final remote = image['remoteUrl'] as String?;
      if (remote != null && remote.isNotEmpty) return remote;
    }
    return null;
  }
}
