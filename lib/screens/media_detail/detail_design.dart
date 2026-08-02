import 'package:flutter/material.dart';

import '../../theme/mono_tokens.dart';
import '../../utils/layout_constants.dart';
import '../../utils/rating_spans.dart';

/// Shared presentation for the touch detail screen.
///
/// The screen used to describe a title with a cloud of filled pills — rating,
/// certificate, quality, year, runtime, then genres in the same pill shape one
/// row down. Every fact carried the same weight, and the genre pills read as
/// buttons that do nothing when tapped. These replace that with one typographic
/// hierarchy: a dot-separated fact line where only the score is emphasised, a
/// plain muted genre line that no longer invites a tap, and hairline-separated
/// rows for the long tail. Figures and codes set in the mono face so they read
/// as reported values rather than prose.

/// Dot-separated fact line: score first and emphasised, then the plain facts,
/// with the certificate last as a bordered mark.
class DetailFactLine extends StatelessWidget {
  final double? rating;
  final String? contentRating;

  /// Year, season/episode count, runtime — whatever the caller has, in the
  /// order it should survive truncation.
  final List<String> facts;
  final double fontSize;

  const DetailFactLine({
    super.key,
    this.rating,
    this.contentRating,
    this.facts = const [],
    this.fontSize = 13.5,
  });

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
              children: [ratingSpan(rating!, iconSize: fontSize)],
              style: TextStyle(color: t.text, fontWeight: .w600),
            ),
          for (final fact in facts) TextSpan(text: fact),
          if (cert != null && cert.isNotEmpty) WidgetSpan(alignment: .middle, child: _CertificateMark(cert)),
        ]),
      ),
      style: TextStyle(fontSize: fontSize, color: t.text.withValues(alpha: 0.78), height: 1.3),
      maxLines: 2,
      overflow: .ellipsis,
    );
  }
}

/// Squared bordered mark — certificates are squared in the wild, so the pill
/// radius the rest of the line avoids would read as less correct, not more.
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
        style: TextStyle(fontFamily: MonoFonts.mono, fontSize: 11, color: t.text.withValues(alpha: 0.78), height: 1.2),
      ),
    );
  }
}

/// Genres as prose. They are description, not navigation, and the pill shape
/// they used to wear promised a tap target the screen never wired up.
class DetailGenreLine extends StatelessWidget {
  final List<String> genres;
  final double fontSize;

  const DetailGenreLine({super.key, required this.genres, this.fontSize = 13.5});

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) return const SizedBox.shrink();
    return Text(
      genres.join(' · '),
      style: TextStyle(fontSize: fontSize, color: tokens(context).textMuted, height: 1.3),
      maxLines: 1,
      overflow: .ellipsis,
    );
  }
}

/// Section heading with an optional muted count on the baseline opposite it.
class DetailSectionHeader extends StatelessWidget {
  final String title;
  final String? trailing;
  final Widget? action;

  const DetailSectionHeader({super.key, required this.title, this.trailing, this.action});

  @override
  Widget build(BuildContext context) {
    final t = tokens(context);
    // Same scale as HubSection's rail header — the related-hub rails sit on
    // this page too, and two heading sizes on one screen reads as a mistake.
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

  /// Verbatim technical text — file names, containers, codecs.
  final bool mono;

  const DetailInfoEntry(this.label, this.value, {this.mono = false});
}

/// Label/value rows sharing a fixed label column, which is what turns a list of
/// facts into something you can scan down.
///
/// Deliberately unruled: the rest of the app separates content with surfaces
/// rather than hairlines — the hub rails further down this same screen do — so
/// ruled rows read as borrowed from another app rather than as structure.
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
                    style: entries[i].mono
                        ? TextStyle(fontFamily: MonoFonts.mono, fontSize: 12.5, color: t.text.withValues(alpha: 0.78))
                        : TextStyle(fontSize: 14.5, fontWeight: .w500, color: t.text),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
