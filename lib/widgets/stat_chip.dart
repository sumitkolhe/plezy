import 'package:flutter/material.dart';

import '../theme/mono_tokens.dart';
import 'app_icon.dart';

/// The app's small metadata pill, shared so pages cannot drift apart on it.
class MetaPill {
  MetaPill._();

  static const double minHeight = 26;
  static const double gap = 7;
  static const double iconSize = 12;
  static const double iconGap = 4;
  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 11, vertical: 4);

  static BoxDecoration decoration(BuildContext context, {Color? color}) => BoxDecoration(
    color: color ?? tokens(context).text.withValues(alpha: 0.13),
    borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
  );

  static TextStyle label(BuildContext context) => TextStyle(
    fontSize: 11.5,
    fontWeight: FontWeight.w600,
    color: tokens(context).text.withValues(alpha: 0.88),
    height: 1.2,
    fontFeatures: const [FontFeature.tabularFigures()],
  );
}

/// Small labeled pill (optionally with a leading icon): detail-screen stat
/// chips, request-sheet season status labels.
class StatChip extends StatelessWidget {
  final IconData? icon;
  final Color? iconColor;
  final String label;

  /// Leading artwork for chips whose source has a brand mark (rating badges).
  /// Takes precedence over [icon].
  final Widget? leading;

  /// Overrides the default fill. Needed where the chip sits on a surface that
  /// already uses `surfaceContainerHigh` — the mono theme collapses several
  /// container roles onto one colour, so the default would be invisible.
  final Color? backgroundColor;

  const StatChip({super.key, this.icon, this.iconColor, required this.label, this.leading, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: MetaPill.minHeight),
      padding: MetaPill.padding,
      decoration: MetaPill.decoration(context, color: backgroundColor),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading case final leading?) ...[
            leading,
            const SizedBox(width: MetaPill.iconGap),
          ] else if (icon != null) ...[
            AppIcon(icon!, size: MetaPill.iconSize, color: iconColor),
            const SizedBox(width: MetaPill.iconGap),
          ],
          Text(label, style: MetaPill.label(context)),
        ],
      ),
    );
  }
}
