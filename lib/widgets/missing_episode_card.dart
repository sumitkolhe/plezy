import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:intl/intl.dart';

import '../i18n/app_locale_utils.dart';
import '../i18n/strings.g.dart';
import '../services/arr/arr_item_lookup.dart';
import '../theme/mono_tokens.dart';
import '../utils/rating_spans.dart';
import 'app_icon.dart';
import 'placeholder_container.dart';

/// An episode Sonarr tracks that the library has no file for, drawn to the same
/// geometry as a real episode row so the list reads as one list.
///
/// Dimmed and without a play badge, because there is nothing to play; the tap
/// searches for a file instead.
class MissingEpisodeCard extends StatelessWidget {
  static const double _thumbWidth = 152;
  static const double _thumbHeight = _thumbWidth * 9 / 16;
  static const double _thumbGap = 14;

  final ArrEpisode episode;
  final void Function(ArrEpisode episode)? onSearch;

  const MissingEpisodeCard({super.key, required this.episode, this.onSearch});

  bool get _upcoming => !episode.hasAired;

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    final search = onSearch;
    final accent = _upcoming ? tokensRef.textMuted : Colors.amber;

    final row = Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: .start,
        children: [
          SizedBox(
            width: _thumbWidth,
            height: _thumbHeight,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: PlaceholderContainer(
                color: tokensRef.text.withValues(alpha: 0.04),
                child: AppIcon(
                  _upcoming ? PhosphorIcons.clock : PhosphorIcons.warningCircle,
                  size: 20,
                  color: accent.withValues(alpha: 0.7),
                ),
              ),
            ),
          ),
          const SizedBox(width: _thumbGap),
          Expanded(
            child: SizedBox(
              height: _thumbHeight,
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    'E${episode.episodeNumber}${episode.title.isEmpty ? '' : '$dotSeparator${episode.title}'}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: .w600,
                      height: 1.3,
                      color: tokensRef.text.withValues(alpha: 0.5),
                    ),
                    maxLines: 2,
                    overflow: .ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _status(),
                    style: TextStyle(fontSize: 13, color: accent.withValues(alpha: 0.85), height: 1.4),
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                  if (search != null && !_upcoming) ...[
                    const Spacer(),
                    Row(
                      children: [
                        AppIcon(PhosphorIcons.magnifyingGlass, size: 13, color: tokensRef.textMuted),
                        const SizedBox(width: 6),
                        Text(
                          t.arrSearch.title,
                          style: TextStyle(fontSize: 12, fontWeight: .w600, color: tokensRef.textMuted),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if (search == null || episode.id == 0) return row;
    return InkWell(onTap: () => search(episode), child: row);
  }

  String _status() {
    if (!episode.monitored) return t.serverActivity.unmonitored;
    final air = episode.airDate;
    final label = _upcoming ? t.serverActivity.stages.queued : t.serverActivity.notDownloadedOne;
    if (air == null) return label;
    final date = DateFormat.MMMd(LocaleSettings.currentLocale.intlLocaleName).format(air);
    return '$label$dotSeparator${_upcoming ? t.serverActivity.airsOn(date: date) : t.serverActivity.airedOn(date: date)}';
  }
}
