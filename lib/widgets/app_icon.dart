import 'package:flutter/material.dart';

import '../theme/phosphor_icons.dart';

/// How far the tinted layer of a duotone glyph sits behind its stroke.
const double _duotoneTint = 0.24;

/// Wrapper around [Icon] for the app's Phosphor set.
///
/// Duotone glyphs are two glyphs, not one, so they cannot be handed straight to
/// [Icon]; everything renders through here so no call site has to know that.
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.shadows,
    this.semanticLabel,
    this.textDirection,
  });

  final IconData? icon;
  final double? size;
  final Color? color;
  final List<Shadow>? shadows;
  final String? semanticLabel;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final glyph = icon;
    if (glyph == null) return const SizedBox.shrink();

    final secondary = phosphorDuotoneSecondary[glyph.codePoint];
    if (secondary == null) return _layer(glyph, color);

    // The tint rides on the colour rather than an Opacity layer, which would
    // cost a saveLayer on every icon and put a second Opacity into subtrees
    // that already animate one of their own.
    final base = color ?? IconTheme.of(context).color ?? const Color(0xFFFFFFFF);
    return Stack(
      alignment: Alignment.center,
      children: [
        _layer(secondary, base.withValues(alpha: base.a * _duotoneTint), labelled: false),
        _layer(glyph, color),
      ],
    );
  }

  Widget _layer(IconData data, Color? layerColor, {bool labelled = true}) => Icon(
    data,
    size: size,
    color: layerColor,
    shadows: shadows,
    semanticLabel: labelled ? semanticLabel : null,
    textDirection: textDirection,
  );
}
