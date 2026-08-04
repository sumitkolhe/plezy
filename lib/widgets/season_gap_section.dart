import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:intl/intl.dart';

import '../i18n/app_locale_utils.dart';
import '../i18n/strings.g.dart';
import '../models/arr/season_completeness.dart';
import '../services/arr/arr_item_lookup.dart';
import '../theme/mono_tokens.dart';
import '../utils/rating_spans.dart';
import 'app_icon.dart';

/// Below the real episodes, not interleaved: that list keys its focus nodes by
/// position, and unplayable rows inside it would break D-pad navigation past
/// the first gap.
class SeasonGapSection extends StatelessWidget {
  final SeasonGap gap;

  const SeasonGapSection({super.key, required this.gap});

  @override
  Widget build(BuildContext context) {
    if (gap.missing.isEmpty && gap.upcoming.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: .start,
      children: [
        if (gap.missing.isNotEmpty) ...[
          const SizedBox(height: 18),
          _Heading(text: t.serverActivity.notDownloaded(count: gap.missing.length), tone: _Tone.missing),
          for (final episode in gap.missing) _GapRow(episode: episode, tone: _Tone.missing),
        ],
        if (gap.upcoming.isNotEmpty) ...[
          const SizedBox(height: 18),
          _Heading(text: t.serverActivity.upcomingEpisodes(count: gap.upcoming.length), tone: _Tone.upcoming),
          for (final episode in gap.upcoming) _GapRow(episode: episode, tone: _Tone.upcoming),
        ],
      ],
    );
  }
}

enum _Tone { missing, upcoming }

class _Heading extends StatelessWidget {
  final String text;
  final _Tone tone;

  const _Heading({required this.text, required this.tone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          fontWeight: .w700,
          letterSpacing: -0.1,
          color: tone == _Tone.missing ? Colors.amber : tokens(context).textMuted,
        ),
      ),
    );
  }
}

class _GapRow extends StatelessWidget {
  final ArrEpisode episode;
  final _Tone tone;

  const _GapRow({required this.episode, required this.tone});

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    // No tap target: a row that looks playable but is not is worse than none.
    final foreground = tokensRef.text.withValues(alpha: 0.45);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          AppIcon(
            tone == _Tone.missing ? PhosphorIcons.warningCircle : PhosphorIcons.clock,
            size: 14,
            color: tone == _Tone.missing ? Colors.amber.withValues(alpha: 0.8) : foreground,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'E${episode.episodeNumber}${episode.title.isEmpty ? '' : '$dotSeparator${episode.title}'}',
              style: TextStyle(fontSize: 13, color: foreground, height: 1.3),
              maxLines: 1,
              overflow: .ellipsis,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            _trailing(),
            style: TextStyle(
              fontSize: 11.5,
              color: tokensRef.text.withValues(alpha: 0.38),
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  String _trailing() {
    if (!episode.monitored) return t.serverActivity.unmonitored;
    final air = episode.airDate;
    if (air == null) return '';
    final date = DateFormat.MMMd(LocaleSettings.currentLocale.intlLocaleName).format(air);
    return tone == _Tone.missing ? t.serverActivity.airedOn(date: date) : t.serverActivity.airsOn(date: date);
  }
}
