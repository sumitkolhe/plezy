import 'package:freezed_annotation/freezed_annotation.dart';

import 'media_item.dart';

part 'play_queue.freezed.dart';

/// A flat ordered list of items with a current cursor.
@freezed
sealed class PlayQueue with _$PlayQueue {
  const PlayQueue._();

  /// Each queue is anchored by a client-generated UUID so callers can
  /// address it for the life of the session.
  const factory PlayQueue.local({
    /// Client-generated UUID identifying this queue for the session.
    required String id,
    required List<MediaItem> items,

    /// Server kind that owns this queue's items (typically `"jellyfin"`).
    required String backendId,
    int? currentIndex,
    @Default(false) bool shuffled,
  }) = LocalPlayQueue;

  MediaItem? get current => switch (this) {
    LocalPlayQueue(:final items, :final currentIndex) =>
      currentIndex != null && currentIndex >= 0 && currentIndex < items.length ? items[currentIndex] : null,
  };

  bool get hasNext => switch (this) {
    LocalPlayQueue(:final items, :final currentIndex) => currentIndex != null && currentIndex + 1 < items.length,
  };

  bool get hasPrevious => switch (this) {
    LocalPlayQueue(:final currentIndex) => currentIndex != null && currentIndex > 0,
  };
}
