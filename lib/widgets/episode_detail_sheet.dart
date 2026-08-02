import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../i18n/strings.g.dart';
import '../media/media_item.dart';
import '../media/media_server_client.dart';
import '../theme/mono_tokens.dart';
import '../utils/formatters.dart';
import '../utils/media_quality_labels.dart';
import '../utils/rating_spans.dart';
import 'app_icon.dart';
import 'optimized_media_image.dart';
import 'overlay_sheet.dart';
import 'placeholder_container.dart';
import 'watched_indicator.dart';

/// Shared by the row and the sheet so the two cannot report different facts.
List<InlineSpan> episodeFactSpans(MediaItem episode) {
  final rating = episode.userRating;
  final size = buildMediaSizeLabel(episode);
  return dotSeparatedSpans([
    if (episode.durationMs != null)
      TextSpan(text: formatDurationTimestamp(Duration(milliseconds: episode.durationMs!))),
    if (episode.originallyAvailableAt != null) TextSpan(text: formatAbbreviatedDate(episode.originallyAvailableAt!)),
    if (rating != null && rating > 0) ratingSpan(rating / 2, iconSize: 11),
    for (final label in buildMediaQualityLabels(episode)) TextSpan(text: label),
    if (size != null) TextSpan(text: size),
  ]);
}

TextStyle episodeFactStyle(BuildContext context) => TextStyle(
  fontSize: 11.5,
  fontWeight: .w600,
  color: tokens(context).text.withValues(alpha: 0.78),
  height: 1.4,
  letterSpacing: 0.35,
  fontFeatures: const [FontFeature.tabularFigures()],
);

String episodeHeadline(MediaItem episode) =>
    episode.index == null ? episode.title ?? '' : 'E${episode.index}$dotSeparator${episode.title ?? ''}';

/// Everything the row has to clamp, at full length.
class EpisodeDetailSheet extends StatelessWidget {
  final MediaItem episode;
  final MediaServerClient? client;
  final String? localPosterPath;
  final VoidCallback onPlay;

  const EpisodeDetailSheet({
    super.key,
    required this.episode,
    required this.client,
    required this.localPosterPath,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    final facts = episodeFactSpans(episode);
    final summary = episode.summary;
    final directors = episode.directors;
    const inset = EdgeInsets.symmetric(horizontal: 20);

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Flexible(
          child: SingleChildScrollView(
            padding: inset,
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
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
                const SizedBox(height: 14),
                Text(
                  episodeHeadline(episode),
                  style: TextStyle(fontSize: 17, fontWeight: .w600, color: tokensRef.text, height: 1.3),
                ),
                if (facts.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Text.rich(TextSpan(children: facts), style: episodeFactStyle(context)),
                ],
                if (summary != null && summary.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Text(
                    summary,
                    style: TextStyle(fontSize: 14, color: tokensRef.textMuted, height: 1.55),
                  ),
                ],
                if (directors != null && directors.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Text(
                    '${directors.length == 1 ? t.discover.director : t.discover.directors}  ${directors.join(', ')}',
                    style: TextStyle(fontSize: 13, color: tokensRef.textMuted, height: 1.4),
                  ),
                ],
                const SizedBox(height: 18),
              ],
            ),
          ),
        ),
        Padding(
          padding: inset.add(const EdgeInsets.only(bottom: 4)),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                OverlaySheetController.closeAdaptive(context, null);
                onPlay();
              },
              icon: const AppIcon(Symbols.play_arrow_rounded, fill: 1, size: 20),
              label: Text(t.common.play),
            ),
          ),
        ),
      ],
    );
  }

  Widget _still(BuildContext context) {
    final fallback = PlaceholderContainer(
      color: tokens(context).text.withValues(alpha: 0.04),
      child: AppIcon(
        Symbols.movie_rounded,
        fill: 1,
        size: 24,
        color: tokens(context).textMuted.withValues(alpha: 0.5),
      ),
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
