import 'package:flutter/material.dart';

import '../../theme/mono_tokens.dart';
import '../../utils/layout_constants.dart';
import '../../utils/rating_spans.dart';

/// One grouped surface rather than separate pills. Discrete rounded shapes
/// here read as a second row of the action buttons below; a single bar with
/// divided cells says these are readings, not controls.
class DetailFactStrip extends StatelessWidget {
  final double? rating;
  final String? contentRating;

  /// Ordered by what should survive truncation.
  final List<String> facts;

  /// Opens the item's IMDb page. Null when the server reported no IMDb id, so
  /// the cell never offers a link it cannot follow.
  final VoidCallback? onRatingTap;

  const DetailFactStrip({super.key, this.rating, this.contentRating, required this.facts, this.onRatingTap});

  static const double height = 34;

  @override
  Widget build(BuildContext context) {
    final t = tokens(context);
    final cert = contentRating;
    final hasCert = cert != null && cert.isNotEmpty;
    if (rating == null && facts.isEmpty && !hasCert) return const SizedBox.shrink();

    final valueStyle = TextStyle(
      fontSize: 12.5,
      fontWeight: .w600,
      color: t.text.withValues(alpha: 0.88),
      height: 1.2,
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    final cells = <Widget>[
      if (rating != null)
        _FactCell(
          onTap: onRatingTap,
          child: Text.rich(
            TextSpan(children: [ratingSpan(rating!, iconSize: 13)]),
            style: valueStyle.copyWith(color: t.text),
          ),
        ),
      for (final fact in facts) _FactCell(child: Text(fact, style: valueStyle)),
      if (hasCert) _FactCell(child: Text(cert, style: valueStyle.copyWith(letterSpacing: 0.4))),
    ];

    // Scales down rather than wrapping: the hero budgets one row, and a clipped
    // second row is worse than a slightly smaller first one.
    return FittedBox(
      fit: .scaleDown,
      alignment: .centerLeft,
      child: SizedBox(
        height: height,
        child: Material(
          color: t.text.withValues(alpha: 0.07),
          // Softly rectangular, so it cannot be mistaken for the round controls.
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          clipBehavior: .antiAlias,
          child: Row(
            mainAxisSize: .min,
            children: [
              for (var i = 0; i < cells.length; i++) ...[
                if (i > 0) VerticalDivider(width: 1, thickness: 1, color: t.text.withValues(alpha: 0.10)),
                cells[i],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _FactCell extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _FactCell({required this.child, this.onTap});

  @override
  Widget build(BuildContext context) {
    final body = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Center(widthFactor: 1, child: child),
    );
    return onTap == null ? body : InkWell(onTap: onTap, child: body);
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
                  style: TextStyle(fontSize: 14.5, fontWeight: .w500, color: t.text),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
