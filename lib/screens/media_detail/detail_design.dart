import 'package:flutter/material.dart';

import '../../theme/mono_tokens.dart';
import '../../utils/layout_constants.dart';
import '../../utils/rating_spans.dart';
import '../../widgets/stat_chip.dart';

/// Facts as pills, the same idiom the episode sheet uses. They sit on the
/// scrim's solid end rather than over the backdrop, so they take the page's own
/// surface treatment instead of a glass one.
class DetailFactStrip extends StatelessWidget {
  final double? rating;
  final String? contentRating;

  /// Ordered by what should survive truncation.
  final List<String> facts;

  /// Opens the item's IMDb page. Null when the server reported no IMDb id, so
  /// the pill never offers a link it cannot follow.
  final VoidCallback? onRatingTap;

  const DetailFactStrip({super.key, this.rating, this.contentRating, required this.facts, this.onRatingTap});

  static const double height = MetaPill.minHeight;

  @override
  Widget build(BuildContext context) {
    final t = tokens(context);
    final cert = contentRating;
    final hasCert = cert != null && cert.isNotEmpty;
    if (rating == null && facts.isEmpty && !hasCert) return const SizedBox.shrink();

    final valueStyle = MetaPill.label(context);

    // Scales down rather than wrapping: the hero budgets one row, and a clipped
    // second row is worse than a slightly smaller first one.
    return FittedBox(
      fit: .scaleDown,
      alignment: .centerLeft,
      child: Row(
        spacing: MetaPill.gap,
        children: [
          if (rating != null)
            _FactPill(
              onTap: onRatingTap,
              child: Text.rich(
                TextSpan(children: [ratingSpan(rating!, iconSize: MetaPill.iconSize)]),
                style: valueStyle.copyWith(color: t.text),
              ),
            ),
          for (final fact in facts) _FactPill(child: Text(fact, style: valueStyle)),
          // One pill like the rest: a squared outline made the certificate shout
          // over facts that matter more.
          if (hasCert) _FactPill(child: Text(cert, style: valueStyle.copyWith(letterSpacing: 0.4))),
        ],
      ),
    );
  }
}

class _FactPill extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _FactPill({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    final decoration = MetaPill.decoration(context);
    final body = Container(height: DetailFactStrip.height, padding: MetaPill.padding, alignment: .center, child: child);

    return Material(
      color: decoration.color,
      borderRadius: decoration.borderRadius,
      child: onTap == null
          ? body
          : InkWell(borderRadius: decoration.borderRadius as BorderRadius, onTap: onTap, child: body),
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
    final heading = Text(title, style: HubLayoutConstants.sectionHeading(isTv: false, color: t.text));
    if (action == null && (trailing == null || trailing!.isEmpty)) return heading;

    return Row(
      crossAxisAlignment: action != null ? .center : .baseline,
      textBaseline: action != null ? null : TextBaseline.alphabetic,
      children: [
        Expanded(child: heading),
        if (action != null) action! else Text(trailing!, style: TextStyle(fontSize: 13, color: t.textMuted)),
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

  const DetailInfoTable({super.key, required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();
    final t = tokens(context);

    // The label column hugs its widest label instead of a fixed 72: "Studio" in
    // a column sized for something longer left a gap the eye had to cross.
    return Table(
      columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
      defaultVerticalAlignment: .top,
      children: [
        for (var i = 0; i < entries.length; i++)
          TableRow(
            children: [
              Padding(
                padding: EdgeInsets.only(top: i == 0 ? 0 : 10, right: 16),
                child: Text(entries[i].label, style: TextStyle(fontSize: 13, color: t.textMuted)),
              ),
              Padding(
                padding: EdgeInsets.only(top: i == 0 ? 0 : 10),
                child: Text(
                  entries[i].value,
                  style: TextStyle(fontSize: 14, fontWeight: .w500, color: t.text),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
