/// A film Radarr is tracking that has no file yet — requested, or monitored and
/// still being hunted.
///
/// The library cannot know about these: Jellyfin has never seen them. So the
/// poster and title come from Radarr, which took them from TMDB.
class AbsentTitle {
  final String sourceId;
  final String sourceName;

  /// Radarr's own id, and the key its queue records carry.
  final int mediaId;

  final String title;
  final int? year;
  final int? tmdbId;

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
    this.posterUrl,
    this.monitored = true,
  });

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
