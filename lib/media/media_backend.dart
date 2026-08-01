import '../utils/app_logger.dart';

/// Backend identifier for a media item, library, or server. Persisted records
/// round-trip it so the source of an item stays explicit.
enum MediaBackend {
  jellyfin;

  String get id => switch (this) {
    MediaBackend.jellyfin => 'jellyfin',
  };

  static MediaBackend fromId(String id) => switch (id) {
    'jellyfin' => MediaBackend.jellyfin,
    _ => throw ArgumentError('Unknown MediaBackend id: $id'),
  };

  /// Like [fromId] but tolerates legacy/missing values. An unrecognized id
  /// logs a warning rather than throwing, so one corrupt cache row cannot
  /// take down deserialization of its siblings.
  static MediaBackend fromString(String? id) {
    if (id != null && id != 'jellyfin') {
      appLogger.w('Unknown MediaBackend id "$id"; defaulting to jellyfin');
    }
    return MediaBackend.jellyfin;
  }
}
