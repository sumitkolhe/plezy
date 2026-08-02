import 'package:flutter/material.dart';

import '../../theme/mono_tokens.dart';
import '../../utils/layout_constants.dart';
import '../../utils/rating_spans.dart';

const double _fontSize = 13.5;

class DetailFactLine extends StatelessWidget {
  final double? rating;
  final String? contentRating;

  /// Ordered by what should survive truncation.
  final List<String> facts;

  const DetailFactLine({super.key, this.rating, this.contentRating, required this.facts});

  @override
  Widget build(BuildContext context) {
    final t = tokens(context);
    final cert = contentRating;
    if (rating == null && facts.isEmpty && (cert == null || cert.isEmpty)) return const SizedBox.shrink();

    return Text.rich(
      TextSpan(
        children: dotSeparatedSpans([
          if (rating != null)
            TextSpan(
              children: [ratingSpan(rating!, iconSize: _fontSize)],
              style: TextStyle(color: t.text, fontWeight: .w600),
            ),
          for (final fact in facts) TextSpan(text: fact),
          if (cert != null && cert.isNotEmpty) WidgetSpan(alignment: .middle, child: _CertificateMark(cert)),
        ]),
      ),
      style: TextStyle(fontSize: _fontSize, color: t.text.withValues(alpha: 0.78), height: 1.3),
      maxLines: 2,
      overflow: .ellipsis,
    );
  }
}

/// Squared rather than a pill: certificates are squared marks in the wild.
class _CertificateMark extends StatelessWidget {
  final String label;

  const _CertificateMark(this.label);

  @override
  Widget build(BuildContext context) {
    final t = tokens(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        border: Border.all(color: t.outline),
        borderRadius: BorderRadius.all(Radius.circular(t.radiusXs)),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 11, fontWeight: .w600, color: t.text.withValues(alpha: 0.78), height: 1.2, letterSpacing: 0.3),
      ),
    );
  }
}

/// Prose, not chips: genres are description here, and nothing navigates.
class DetailGenreLine extends StatelessWidget {
  final List<String> genres;

  const DetailGenreLine({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) return const SizedBox.shrink();
    return Text(
      genres.join(' · '),
      style: TextStyle(fontSize: _fontSize, color: tokens(context).textMuted, height: 1.3),
      maxLines: 1,
      overflow: .ellipsis,
    );
  }
}

class DetailSectionHeader extends StatelessWidget {
  final String title;
  final String? trailing;
  final Widget? action;

  const DetailSectionHeader({super.key, required this.title, this.trailing, this.action});

  @override
  Widget build(BuildContext context) {
    final t = tokens(context);
    // Matches HubSection: its rails render on this same page.
    final heading = Text(
      title,
      style: TextStyle(
        fontSize: HubLayoutConstants.sectionHeadingSize,
        fontWeight: .w700,
        letterSpacing: -0.2,
        color: t.text,
      ),
    );
    if (action == null && (trailing == null || trailing!.isEmpty)) return heading;

    return Row(
      crossAxisAlignment: action != null ? .center : .baseline,
      textBaseline: action != null ? null : TextBaseline.alphabetic,
      children: [
        Expanded(child: heading),
        if (action != null)
          action!
        else
          Text(trailing!, style: TextStyle(fontSize: 13, color: t.textMuted)),
      ],
    );
  }
}

class DetailInfoEntry {
  final String label;
  final String value;

  const DetailInfoEntry(this.label, this.value);
}

/// Unruled by choice: this app separates content with surfaces, not hairlines.
class DetailInfoTable extends StatelessWidget {
  final List<DetailInfoEntry> entries;
  static const double _labelWidth = 72;

  const DetailInfoTable({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();
    final t = tokens(context);

    return Column(
      crossAxisAlignment: .start,
      children: [
        for (var i = 0; i < entries.length; i++)
          Padding(
            padding: EdgeInsets.only(top: i == 0 ? 0 : 10),
            child: Row(
              crossAxisAlignment: .start,
              children: [
                SizedBox(
                  width: _labelWidth,
                  child: Text(entries[i].label, style: TextStyle(fontSize: 13, color: t.textMuted)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    entries[i].value,
                    style: TextStyle(fontSize: 14.5, fontWeight: .w500, color: t.text),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
