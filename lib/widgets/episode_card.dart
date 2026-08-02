import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plezy/widgets/app_icon.dart';
import 'package:material_symbols_icons/symbols.dart';
import '../focus/focusable_wrapper.dart';
import '../mixins/context_menu_tap_mixin.dart';
import '../models/download_models.dart';
import '../providers/download_provider.dart';
import '../providers/watch_state_store.dart';
import 'package:provider/provider.dart';

import '../services/settings_service.dart';
import 'settings_builder.dart';
import '../media/media_item.dart';
import '../media/media_item_types.dart';
import '../widgets/download_status_icon.dart';
import '../widgets/watched_indicator.dart';
import '../widgets/optimized_media_image.dart';
import '../utils/formatters.dart';
import '../utils/rating_spans.dart';
import '../utils/media_quality_labels.dart';
import '../widgets/media_context_menu.dart';
import '../widgets/placeholder_container.dart';
import '../theme/mono_tokens.dart';
import '../media/media_server_client.dart';

/// Episode card widget with D-pad long-press support
class EpisodeCard extends StatefulWidget {
  final MediaItem episode;
  final MediaServerClient? client;
  final VoidCallback onTap;
  final Future<void> Function(MediaItem source)? onRefresh;
  final Future<void> Function()? onListRefresh;
  final bool autofocus;
  final bool isOffline;
  final String? localPosterPath;
  final FocusNode? focusNode;
  final VoidCallback? onNavigateUp;

  const EpisodeCard({
    super.key,
    required this.episode,
    this.client,
    required this.onTap,
    this.onRefresh,
    this.onListRefresh,
    this.autofocus = false,
    this.isOffline = false,
    this.localPosterPath,
    this.focusNode,
    this.onNavigateUp,
  });

  @override
  State<EpisodeCard> createState() => _EpisodeCardState();
}

class _EpisodeCardState extends State<EpisodeCard> with ContextMenuTapMixin<EpisodeCard> {
  MediaItem _effectiveEpisode(BuildContext context) => context.withFreshWatchState(widget.episode);

  /// Runtime, air date, your rating and quality labels as one dim mono line —
  /// reported values, not prose, and a fixed height so a long list of rows
  /// stays scannable.
  Widget _buildEpisodeMetaLine(BuildContext context, MediaItem episode, List<String> qualityLabels) {
    final tokensRef = tokens(context);
    final rating = episode.userRating;
    final spans = dotSeparatedSpans([
      if (episode.index != null) TextSpan(text: 'E${episode.index}'),
      if (episode.durationMs != null)
        TextSpan(text: formatDurationTimestamp(Duration(milliseconds: episode.durationMs!))),
      if (episode.originallyAvailableAt != null) TextSpan(text: formatAbbreviatedDate(episode.originallyAvailableAt!)),
      if (rating != null && rating > 0) ratingSpan(rating / 2, iconSize: 11),
      for (final label in qualityLabels) TextSpan(text: label),
    ]);
    if (spans.isEmpty) return const SizedBox.shrink();

    return Text.rich(
      TextSpan(children: spans),
      style: TextStyle(fontFamily: MonoFonts.mono, fontSize: 11, color: tokensRef.textMuted, height: 1.35),
      maxLines: 1,
      overflow: .ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SettingValueBuilder<bool>(
      pref: SettingsService.hideSpoilers,
      builder: (context, hideSpoilers, _) => _buildContent(context, hideSpoilers: hideSpoilers),
    );
  }

  Widget _buildContent(BuildContext context, {required bool hideSpoilers}) {
    final episode = _effectiveEpisode(context);
    final shouldBlur = hideSpoilers && episode.shouldHideSpoiler;
    final qualityLabels = [...buildMediaQualityLabels(episode), ?buildMediaSizeLabel(episode)];
    final tokensRef = tokens(context);
    const thumbWidth = 116.0;

    // MergeSemantics: one node per card instead of one per text/progress —
    // the per-frame semantics pass scales with node count (see MediaCard).
    // The card has a single action, so merging is safe.
    return MergeSemantics(
      child: FocusableWrapper(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        enableLongPress: true,
        onNavigateUp: widget.onNavigateUp,
        onSelect: widget.onTap,
        onLongPress: showContextMenuFromTap,
        disableScale: true,
        child: MediaContextMenu(
          key: contextMenuKey,
          item: episode,
          onRefresh: widget.onRefresh,
          onListRefresh: widget.onListRefresh,
          onTap: widget.onTap,
          child: InkWell(
            key: Key(episode.id),
            mouseCursor: SystemMouseCursors.click,
            onTap: widget.onTap,
            canRequestFocus: false,
            onTapDown: storeTapPosition,
            onLongPress: showContextMenuFromTap,
            onSecondaryTapDown: storeTapPosition,
            onSecondaryTap: showContextMenuFromTap,
            hoverColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.05),
            child: Padding(
              // Separated by space alone. A filled surface per row made the
              // list read as a stack of tiles and put a second background
              // behind every thumbnail; a rule between them read as borrowed
              // from an app that structures everything that way, which this
              // one does not.
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(
                    width: thumbWidth,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: shouldBlur
                                ? ClipRect(
                                    child: ImageFiltered(
                                      imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                                      child: _buildEpisodeThumbnail(context, episode),
                                    ),
                                  )
                                : _buildEpisodeThumbnail(context, episode),
                          ),
                        ),

                        Positioned.fill(
                          child: Center(
                            child: Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                              child: const AppIcon(Symbols.play_arrow_rounded, fill: 1, color: Colors.white, size: 15),
                            ),
                          ),
                        ),

                        Positioned.fill(
                          child: WatchedIndicator(
                            item: episode,
                            size: WatchedIndicatorSize.compact,
                            // Progress isn't tracked offline.
                            progressAvailable: !widget.isOffline,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 13),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Selector<DownloadProvider, _DownloadSlice>(
                          selector: (_, p) =>
                              _DownloadSlice.from(p.getProgress(episode.globalKey), p.isQueueing(episode.globalKey)),
                          builder: (context, slice, _) {
                            Widget? downloadStatusIcon;

                            // Only show download status in online mode
                            if (!widget.isOffline && episode.serverId != null) {
                              final status = slice.status;
                              final mutedBase = tokensRef.textMuted;

                              if (slice.isQueueing) {
                                downloadStatusIcon = DownloadQueueingSpinner(size: 12, color: mutedBase);
                              } else if (status != null) {
                                final iconSize = status == DownloadStatus.downloading ? 14.0 : 12.0;
                                downloadStatusIcon = DownloadStatusIcon(
                                  status: status,
                                  size: iconSize,
                                  variant: DownloadStatusIconVariant.muted,
                                  mutedBase: mutedBase,
                                  progress: slice.progressPercent,
                                );
                              }
                              // Note: No icon shown if not downloaded (null)
                            }

                            // Title, summary and meta all start at the column's
                            // left edge so the block reads straight down. The
                            // episode number sits with the other reported
                            // figures on the mono line rather than indenting
                            // the title away from the two lines under it.
                            return Row(
                              crossAxisAlignment: .start,
                              children: [
                                Expanded(
                                  child: Text(
                                    episode.title!,
                                    style: TextStyle(fontSize: 14.5, fontWeight: .w600, height: 1.3),
                                    maxLines: 2,
                                    overflow: .ellipsis,
                                  ),
                                ),
                                if (downloadStatusIcon != null) ...[
                                  const SizedBox(width: 8),
                                  Padding(padding: const EdgeInsets.only(top: 3), child: downloadStatusIcon),
                                ],
                              ],
                            );
                          },
                        ),

                        if (!shouldBlur && episode.summary != null && episode.summary!.isNotEmpty) ...[
                          const SizedBox(height: 3),
                          // Clamped rather than expandable: uniform row heights
                          // are what make a 20-episode season scannable, and
                          // the full summary is one tap away on the episode.
                          Text(
                            episode.summary!,
                            style: TextStyle(fontSize: 13, color: tokensRef.textMuted, height: 1.4),
                            maxLines: 2,
                            overflow: .ellipsis,
                          ),
                        ],

                        const SizedBox(height: 4),
                        _buildEpisodeMetaLine(context, episode, qualityLabels),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Quiet stand-in for episodes whose art the server has not produced.
  ///
  /// A season of freshly-added episodes has no images until Jellyfin's
  /// metadata refresh fetches them, and a filled box with a large glyph
  /// repeated down the whole list reads as breakage rather than absence.
  Widget _missingThumbnail(BuildContext context) {
    return PlaceholderContainer(
      color: tokens(context).text.withValues(alpha: 0.04),
      child: AppIcon(Symbols.movie_rounded, fill: 1, size: 18, color: tokens(context).textMuted.withValues(alpha: 0.5)),
    );
  }

  Widget _buildEpisodeThumbnail(BuildContext context, MediaItem episode) {
    if (widget.isOffline && widget.localPosterPath != null) {
      return OptimizedMediaImage.thumb(
        client: null,
        imagePath: null,
        localFilePath: widget.localPosterPath,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => _missingThumbnail(context),
      );
    }
    if (episode.thumbPath != null) {
      return OptimizedMediaImage.thumb(
        client: widget.client,
        imagePath: episode.thumbPath,
        filterQuality: FilterQuality.medium,
        fit: BoxFit.cover,
        placeholder: (context, url) => PlaceholderContainer(color: tokens(context).text.withValues(alpha: 0.04)),
        errorWidget: (context, url, error) => _missingThumbnail(context),
      );
    }
    return _missingThumbnail(context);
  }
}

/// Captures only primitives so Selector equality avoids rebuilds on unrelated
/// download ticks (e.g. other episodes, unused `DownloadProgress` fields).
class _DownloadSlice {
  final DownloadStatus? status;
  final double? progressPercent;
  final bool isQueueing;

  const _DownloadSlice({required this.status, required this.progressPercent, required this.isQueueing});

  factory _DownloadSlice.from(DownloadProgress? p, bool isQueueing) =>
      _DownloadSlice(status: p?.status, progressPercent: p?.progressPercent, isQueueing: isQueueing);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _DownloadSlice &&
        other.status == status &&
        other.progressPercent == progressPercent &&
        other.isQueueing == isQueueing;
  }

  @override
  int get hashCode => Object.hash(status, progressPercent, isQueueing);
}
