import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';

import '../i18n/strings.g.dart';
import '../media/media_item.dart';
import '../media/media_server_client.dart';
import '../theme/mono_tokens.dart';
import '../utils/formatters.dart';
import '../utils/media_quality_labels.dart';
import '../utils/rating_spans.dart';
import 'app_icon.dart';
import 'media_context_menu.dart';
import 'optimized_media_image.dart';
import 'overlay_sheet.dart';
import 'placeholder_container.dart';
import 'watched_indicator.dart';

typedef EpisodeFact = ({String? label, String value});

/// Labelled so a bare figure like `52:00` is not left to be guessed at.
List<EpisodeFact> episodeFacts(MediaItem episode) {
  final duration = episode.durationMs;
  final aired = episode.originallyAvailableAt;
  final video = buildVideoQualityLabels(episode);
  final audio = buildAudioQualityLabel(episode);
  final size = buildMediaSizeLabel(episode);

  return [
    if (duration != null)
      (label: t.fileInfo.duration, value: formatDurationTimestamp(Duration(milliseconds: duration))),
    if (aired != null) (label: t.metadataEdit.releaseDate, value: formatAbbreviatedDate(aired)),
    if (video.isNotEmpty) (label: t.fileInfo.video, value: video.join(dotSeparator)),
    if (audio != null) (label: t.fileInfo.audio, value: audio),
    if (size != null) (label: t.fileInfo.size, value: size),
  ];
}

String episodeHeadline(MediaItem episode) =>
    episode.index == null ? episode.title ?? '' : 'E${episode.index}$dotSeparator${episode.title ?? ''}';

/// Everything the row has to clamp, at full length.
class EpisodeDetailSheet extends StatelessWidget {
  final MediaItem episode;
  final MediaServerClient? client;
  final String? localPosterPath;
  final VoidCallback onPlay;

  /// The long-press menu's set for this episode. Closing with an action's
  /// value is how it gets dispatched.
  final List<MediaMenuAction> actions;

  const EpisodeDetailSheet({
    super.key,
    required this.episode,
    required this.client,
    required this.localPosterPath,
    required this.onPlay,
    this.actions = const [],
  });

  /// Left-to-right order for the circles. Anything absent from this list stays
  /// long-press-only: an unlabelled circle has to be guessable from its glyph,
  /// which rules out the rarer actions and every destructive one.
  static const _primaryActions = ['play_from_beginning', 'watch', 'unwatch', 'download', 'delete_download', 'rate'];

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    // Menu order is the menu's business; the circles have their own.
    final primary = [for (final value in _primaryActions) ...actions.where((a) => a.value == value)].take(5);
    final facts = episodeFacts(episode);
    final rating = episode.userRating;
    final summary = episode.summary;
    final directors = episode.directors;
    const inset = EdgeInsets.symmetric(horizontal: 20);

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Flexible(
          child: SingleChildScrollView(
            padding: inset.add(const EdgeInsets.only(top: 16, bottom: 28)),
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(14)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Stack(
                      children: [
                        Positioned.fill(child: _still(context)),
                        Positioned.fill(
                          child: WatchedIndicator(item: episode, size: WatchedIndicatorSize.compact),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  episodeHeadline(episode),
                  style: TextStyle(fontSize: 17, fontWeight: .w600, color: tokensRef.text, height: 1.3),
                ),
                if (facts.isNotEmpty || (rating != null && rating > 0)) ...[
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      if (rating != null && rating > 0)
                        _FactChip(value: formatRating(rating / 2), icon: PhosphorIcons.star),
                      for (final fact in facts) _FactChip(label: fact.label, value: fact.value),
                    ],
                  ),
                ],
                if (summary != null && summary.isNotEmpty) ...[
                  const SizedBox(height: 18),
                  Text(summary, style: TextStyle(fontSize: 14, color: tokensRef.textMuted, height: 1.55)),
                ],
                if (directors != null && directors.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    '${directors.length == 1 ? t.discover.director : t.discover.directors}  ${directors.join(', ')}',
                    style: TextStyle(fontSize: 13, color: tokensRef.textMuted, height: 1.4),
                  ),
                ],
              ],
            ),
          ),
        ),
        Padding(
          padding: inset.add(const EdgeInsets.only(bottom: 20)),
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              SizedBox(
                height: 48,
                child: FilledButton.icon(
                  onPressed: () {
                    OverlaySheetController.closeAdaptive(context, null);
                    onPlay();
                  },
                  icon: const AppIcon(PhosphorIcons.play, size: 20),
                  label: Text(t.common.play),
                ),
              ),
              if (primary.isNotEmpty) ...[
                const SizedBox(height: 14),
                Wrap(
                  alignment: .center,
                  spacing: 14,
                  runSpacing: 12,
                  children: [for (final action in primary) _ActionCircle(action: action)],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _still(BuildContext context) {
    final fallback = PlaceholderContainer(
      color: tokens(context).text.withValues(alpha: 0.04),
      child: AppIcon(PhosphorIcons.filmSlate, size: 24, color: tokens(context).textMuted.withValues(alpha: 0.5)),
    );

    if (localPosterPath != null) {
      return OptimizedMediaImage.thumb(
        client: null,
        imagePath: null,
        localFilePath: localPosterPath,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => fallback,
      );
    }
    if (episode.thumbPath == null) return fallback;
    return OptimizedMediaImage.thumb(
      client: client,
      imagePath: episode.thumbPath,
      fit: BoxFit.cover,
      placeholder: (context, url) => PlaceholderContainer(color: tokens(context).text.withValues(alpha: 0.04)),
      errorWidget: (context, url, error) => fallback,
    );
  }
}

/// The label carries on doing its work as the tooltip and the semantic name,
/// since the glyph alone is what is on screen.
class _ActionCircle extends StatelessWidget {
  final MediaMenuAction action;

  const _ActionCircle({required this.action});

  @override
  Widget build(BuildContext context) {
    final foreground = tokens(context).text;

    return Tooltip(
      message: action.label,
      child: Material(
        color: foreground.withValues(alpha: 0.08),
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => OverlaySheetController.closeAdaptive(context, action.value),
          child: SizedBox.square(
            dimension: 48,
            child: AppIcon(action.icon, size: 20, color: foreground, semanticLabel: action.label),
          ),
        ),
      ),
    );
  }
}

class _FactChip extends StatelessWidget {
  final String? label;
  final String value;
  final IconData? icon;

  const _FactChip({required this.value, this.label, this.icon});

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 6),
      decoration: BoxDecoration(
        color: tokensRef.text.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
      ),
      child: Row(
        mainAxisSize: .min,
        children: [
          if (icon != null) ...[
            AppIcon(icon!, size: 13, color: tokensRef.text.withValues(alpha: 0.7)),
            const SizedBox(width: 5),
          ],
          if (label != null) ...[
            Text(
              label!,
              style: TextStyle(fontSize: 11.5, fontWeight: .w500, color: tokensRef.text.withValues(alpha: 0.5)),
            ),
            const SizedBox(width: 6),
          ],
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: .w600,
              color: tokensRef.text.withValues(alpha: 0.88),
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
