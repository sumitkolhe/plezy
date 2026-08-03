import 'package:flutter/material.dart';

/// Wrapper around [Icon] for the app's Phosphor set, so a null glyph collapses
/// rather than needing a guard at every call site.
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
    return Icon(
      glyph,
      size: size,
      color: color,
      shadows: shadows,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}
