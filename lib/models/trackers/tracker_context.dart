import '../../utils/external_ids.dart';

/// Immutable per-playback context passed from the coordinator to each
/// tracker. Built once at `startPlayback`.
///
/// Carries the external IDs (tvdb/tmdb/imdb, present whenever the item has
/// any) that a tracker addresses the item by.
class TrackerContext {
  final ExternalIds external;

  final bool isMovie;
  final int? season;
  final int? episodeNumber;

  /// Id of the item being played. Used only for logging — not
  /// sent to any tracker.
  final String ratingKey;

  /// Library globalKey the item belongs to, or null when the metadata didn't
  /// carry library info.
  final String? libraryGlobalKey;

  const TrackerContext._({
    required this.external,
    required this.isMovie,
    required this.ratingKey,
    required this.libraryGlobalKey,
    this.season,
    this.episodeNumber,
  });

  factory TrackerContext.movie({
    required ExternalIds external,
    required String ratingKey,
    required String? libraryGlobalKey,
  }) {
    return TrackerContext._(
      external: external,
      isMovie: true,
      ratingKey: ratingKey,
      libraryGlobalKey: libraryGlobalKey,
    );
  }

  factory TrackerContext.episode({
    required ExternalIds external,
    required String ratingKey,
    required String? libraryGlobalKey,
    required int season,
    required int episodeNumber,
  }) {
    return TrackerContext._(
      external: external,
      isMovie: false,
      ratingKey: ratingKey,
      libraryGlobalKey: libraryGlobalKey,
      season: season,
      episodeNumber: episodeNumber,
    );
  }

  /// Serialized into the persisted tracker write queue so a failed watched
  /// write replays against exactly the item it was built for — no second
  /// metadata fetch, no re-resolution against a library that may have changed.
  Map<String, Object?> toJson() => {
    'external': external.toJson(),
    'isMovie': isMovie,
    'ratingKey': ratingKey,
    if (libraryGlobalKey != null) 'libraryGlobalKey': libraryGlobalKey,
    if (season != null) 'season': season,
    if (episodeNumber != null) 'episodeNumber': episodeNumber,
  };

  /// Throws on a malformed row; the queue archives and discards the batch.
  factory TrackerContext.fromJson(Map<String, Object?> json) {
    return TrackerContext._(
      external: ExternalIds.fromJson((json['external'] as Map).cast<String, Object?>()),
      isMovie: json['isMovie'] as bool,
      ratingKey: json['ratingKey'] as String,
      libraryGlobalKey: json['libraryGlobalKey'] as String?,
      season: (json['season'] as num?)?.toInt(),
      episodeNumber: (json['episodeNumber'] as num?)?.toInt(),
    );
  }
}
