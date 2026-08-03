import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:harbor/widgets/app_icon.dart';
import 'package:harbor/theme/phosphor_icons.dart';
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
import '../utils/platform_detector.dart';
import '../widgets/media_context_menu.dart';
import '../widgets/placeholder_container.dart';
import '../widgets/episode_detail_sheet.dart';
import '../widgets/overlay_sheet.dart';
import '../theme/mono_tokens.dart';
import '../media/media_server_client.dart';

const double _thumbWidth = 152;
const double _thumbHeight = _thumbWidth * 9 / 16;
const double _thumbGap = 14;
const double _summaryFontSize = 13;
const double _summaryLineHeight = 1.4;

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

  void _openDetails(BuildContext context, MediaItem episode) {
    unawaited(
      OverlaySheetController.showAdaptive<void>(
        context,
        showDragHandle: true,
        builder: (_) => EpisodeDetailSheet(
          episode: episode,
          client: widget.client,
          localPosterPath: widget.localPosterPath,
          onPlay: widget.onTap,
        ),
      ),
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
    // A remote cannot aim at a region, so D-pad keeps the whole row on play
    // and reaches the rest through the long-press menu.
    final splitTargets = !PlatformDetector.isTV();
    final summary = episode.summary;
    final showSummary = !shouldBlur && summary != null && summary.isNotEmpty;

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
        onLongPress: handleLongPress,
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
            onTap: splitTargets ? () => _openDetails(context, episode) : widget.onTap,
            canRequestFocus: false,
            onTapDown: storeTapPosition,
            onLongPress: handleLongPress,
            onSecondaryTapDown: storeTapPosition,
            onSecondaryTap: showContextMenuFromTap,
            hoverColor: Theme.of(context).colorScheme.surface.withValues(alpha: 0.05),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: .start,
                children: [
                  SizedBox(
                    width: _thumbWidth,
                    child: splitTargets
                        // The badge already drawn on the still is what marks
                        // this region as the one that plays.
                        ? GestureDetector(
                            onTap: widget.onTap,
                            child: _buildStill(context, episode, blurred: shouldBlur),
                          )
                        : _buildStill(context, episode, blurred: shouldBlur),
                  ),
                  const SizedBox(width: _thumbGap),
                  Expanded(
                    child: SizedBox(
                      height: _thumbHeight,
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          _buildTitleRow(context, episode),
                          if (showSummary) ...[
                            const SizedBox(height: 6),
                            Flexible(child: _buildSummary(context, summary)),
                          ],
                        ],
                      ),
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

  /// Takes as many lines as the still leaves after the title, so the row is
  /// always exactly the height of its own image.
  Widget _buildSummary(BuildContext context, String summary) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final lines = (constraints.maxHeight / (_summaryFontSize * _summaryLineHeight)).floor();
        if (lines < 1) return const SizedBox.shrink();
        return Text(
          summary,
          style: TextStyle(fontSize: _summaryFontSize, color: tokens(context).textMuted, height: _summaryLineHeight),
          maxLines: lines,
          overflow: .ellipsis,
        );
      },
    );
  }

  Widget _buildStill(BuildContext context, MediaItem episode, {required bool blurred}) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: blurred
                ? ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: _buildEpisodeThumbnail(context, episode),
                  )
                : _buildEpisodeThumbnail(context, episode),
          ),
        ),

        Positioned.fill(
          child: Center(
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.5), shape: BoxShape.circle),
              child: const AppIcon(PhosphorIconsDuotone.play, color: Colors.white, size: 18),
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
    );
  }

  Widget _buildTitleRow(BuildContext context, MediaItem episode) {
    return Selector<DownloadProvider, _DownloadSlice>(
      selector: (_, p) => _DownloadSlice.from(p.getProgress(episode.globalKey), p.isQueueing(episode.globalKey)),
      builder: (context, slice, _) {
        Widget? downloadStatusIcon;

        if (!widget.isOffline && episode.serverId != null) {
          final status = slice.status;
          final mutedBase = tokens(context).textMuted;

          if (slice.isQueueing) {
            downloadStatusIcon = DownloadQueueingSpinner(size: 12, color: mutedBase);
          } else if (status != null) {
            downloadStatusIcon = DownloadStatusIcon(
              status: status,
              size: status == DownloadStatus.downloading ? 14.0 : 12.0,
              variant: DownloadStatusIconVariant.muted,
              mutedBase: mutedBase,
              progress: slice.progressPercent,
            );
          }
        }

        return Row(
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Text(
                episodeHeadline(episode),
                style: TextStyle(fontSize: 14, fontWeight: .w600, height: 1.3),
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
    );
  }

  /// Deliberately faint: Jellyfin serves no image until its metadata refresh
  /// fetches one, so a whole season can legitimately land here.
  Widget _missingThumbnail(BuildContext context) {
    final tokensRef = tokens(context);
    return PlaceholderContainer(
      color: tokensRef.text.withValues(alpha: 0.04),
      child: AppIcon(PhosphorIconsDuotone.filmSlate, size: 18, color: tokensRef.textMuted.withValues(alpha: 0.5)),
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
