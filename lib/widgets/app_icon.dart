import 'package:flutter/material.dart';

import '../theme/phosphor_icons.dart';

/// Wrapper around [Icon] that centralizes our Material Symbols defaults.
/// Defaults: fill=1 (filled) and weight=700 (bold). Update [AppIconDefaults]
/// to tweak app-wide icon appearance from one place.
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.icon, {
    super.key,
    this.size,
    this.color,
    this.fill,
    this.weight,
    this.grade,
    this.opticalSize,
    this.shadows,
    this.semanticLabel,
    this.textDirection,
  });

  final IconData? icon;
  final double? size;
  final Color? color;
  final double? fill;
  final double? weight;
  final double? grade;
  final double? opticalSize;
  final List<Shadow>? shadows;
  final String? semanticLabel;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final glyph = icon;
    if (glyph == null) return const SizedBox.shrink();

    final secondary = phosphorDuotoneSecondary[glyph.codePoint];
    if (secondary == null) return _layer(glyph, color);

    // A duotone glyph is two: the tinted shape and the stroke over it. The tint
    // rides on the colour rather than an Opacity layer, which would cost a
    // saveLayer on every icon and put a second Opacity in subtrees that already
    // animate one.
    final base = color ?? IconTheme.of(context).color ?? const Color(0xFFFFFFFF);
    return Stack(
      alignment: Alignment.center,
      children: [
        _layer(secondary, base.withValues(alpha: base.a * AppIconDefaults.duotoneOpacity), labelled: false),
        _layer(glyph, color),
      ],
    );
  }

  Widget _layer(IconData data, Color? layerColor, {bool labelled = true}) => Icon(
    data,
    size: size,
    color: layerColor,
    fill: fill ?? AppIconDefaults.fill,
    weight: weight ?? AppIconDefaults.weight,
    grade: grade ?? AppIconDefaults.grade,
    opticalSize: opticalSize ?? AppIconDefaults.opticalSize,
    shadows: shadows ?? AppIconDefaults.shadows,
    semanticLabel: labelled ? semanticLabel : null,
    textDirection: textDirection,
  );
}

/// Central place to adjust default Material Symbol variations.
class AppIconDefaults {
  static double duotoneOpacity = 0.24;
  static double fill = 1;
  static double weight = 700;
  static double? grade;
  static double? opticalSize;
  static Color? color;
  static List<Shadow>? shadows;

  static void update({
    double? fill,
    double? weight,
    double? grade,
    double? opticalSize,
    Color? color,
    List<Shadow>? shadows,
  }) {
    if (fill != null) AppIconDefaults.fill = fill;
    if (weight != null) AppIconDefaults.weight = weight;
    if (grade != null) AppIconDefaults.grade = grade;
    if (opticalSize != null) AppIconDefaults.opticalSize = opticalSize;
    if (color != null) AppIconDefaults.color = color;
    if (shadows != null) AppIconDefaults.shadows = shadows;
  }
}
