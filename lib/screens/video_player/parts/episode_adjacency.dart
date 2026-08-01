part of '../../video_player_screen.dart';

extension _VideoPlayerEpisodeAdjacencyMethods on VideoPlayerScreenState {
  /// Resolve the previous/next episode around the current item.
  Future<AdjacentEpisodes> _loadAdjacentEpisodes({MediaItem? metadata, _PlaybackAttempt? attempt}) async {
    if (!mounted || widget.isLive) return const AdjacentEpisodes.unavailable();

    final targetMetadata = metadata ?? _currentMetadata;
    try {
      final adjacentEpisodes = _offlineLibraryMode
          ? _loadAdjacentEpisodesOffline(targetMetadata)
          : await _episodeNavigation.loadAdjacentEpisodes(
              context: context,
              metadata: targetMetadata,
              // The part actually being played, so the queue can skip sibling
              // entries of a Plex multi-episode file (#1500). MediaSourceInfo
              // carries the Plex numeric part id; MediaPart.id is its string form.
              playedPartId: _currentMediaInfo?.partId?.toString(),
            );
      _commitAdjacentEpisodes(targetMetadata, adjacentEpisodes, attempt);
      return adjacentEpisodes;
    } catch (e, st) {
      appLogger.w('Could not load adjacent episodes', error: e, stackTrace: st);
      const failed = AdjacentEpisodes.failed();
      _commitAdjacentEpisodes(targetMetadata, failed, attempt);
      return failed;
    }
  }

  /// Load next/previous episodes from locally downloaded content.
  AdjacentEpisodes _loadAdjacentEpisodesOffline(MediaItem metadata) {
    if (!metadata.isEpisode) return const AdjacentEpisodes.unavailable();

    final showKey = metadata.grandparentId;
    if (showKey == null) return const AdjacentEpisodes.unavailable();

    try {
      final downloadProvider = context.read<DownloadProvider>();
      final episodes = downloadProvider.getDownloadedEpisodesForShow(showKey);
      if (episodes.isEmpty) return const AdjacentEpisodes.failed();

      // Aired watch order (Specials interleaved by air date) — the shared
      // episode order, so offline next/prev matches streaming, what "download
      // next N" selects, and the offline OnDeck list (#1416/#1414). Copy first
      // so the provider's cached list isn't reordered.
      final sorted = List<MediaItem>.from(episodes)..sort(compareEpisodesByWatchOrder);
      final currentIdx = sorted.indexWhere((ep) => ep.id == metadata.id);
      if (currentIdx == -1) return const AdjacentEpisodes.failed();

      // Same-file siblings are skipped by file-path intersection of the
      // stored metadata (#1500) — offline media info doesn't carry the
      // server part id, so the helpers compare the items' own parts.
      final previous = previousEpisodeSkippingSameFile(sorted, currentIdx);
      final next = nextEpisodeSkippingSameFile(sorted, currentIdx);
      return AdjacentEpisodes(
        next: next,
        previous: previous,
        nextStatus: next == null ? QueueNavigationStatus.boundary : QueueNavigationStatus.found,
        previousStatus: previous == null ? QueueNavigationStatus.boundary : QueueNavigationStatus.found,
      );
    } catch (e, st) {
      appLogger.w('Could not load offline adjacent episodes', error: e, stackTrace: st);
      return const AdjacentEpisodes.failed();
    }
  }

  void _commitAdjacentEpisodes(MediaItem targetMetadata, AdjacentEpisodes adjacentEpisodes, _PlaybackAttempt? attempt) {
    if (!mounted || _currentMetadata.globalKey != targetMetadata.globalKey || (attempt != null && !attempt.isCurrent)) {
      return;
    }
    _setPlayerState(() {
      _nextEpisode = adjacentEpisodes.next;
      _previousEpisode = adjacentEpisodes.previous;
      _nextEpisodeStatus = adjacentEpisodes.nextStatus;
    });
  }
}
