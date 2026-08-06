import 'package:flutter/material.dart';

import 'dynamic_palette.dart';

/// A complete colour scheme, however it was arrived at.
///
/// Material needs about thirty named colours to draw everything. Rather than
/// hand-pick a handful and fill the rest in by repeating them, every theme here
/// is generated: Material 3 derives all thirty from a variant and a brightness,
/// with the tone differences between them chosen so contrast is guaranteed
/// rather than checked afterwards.
///
/// The greyscale themes use the `monochrome` variant, which forces chroma to
/// zero — the seed is ignored entirely, so there is no colour to choose. The
/// wallpaper theme uses Android's own, which is the point of it.
@immutable
class MonoPalette {
  const MonoPalette._(this.scheme, {this.expressive = false});

  final ColorScheme scheme;

  /// Whether the scheme wants Material's ink — ripples and a sparkle on tap.
  ///
  /// Kept separate from where the colours came from, so neither can start
  /// quietly meaning the other.
  final bool expressive;

  bool get isDark => scheme.brightness == Brightness.dark;

  /// Ignored under [DynamicSchemeVariant.monochrome], which zeroes chroma. Fed
  /// in only because the API demands one.
  static const _unusedSeed = Color(0xFF808080);

  static ColorScheme _grey(Brightness brightness) => ColorScheme.fromSeed(
    seedColor: _unusedSeed,
    brightness: brightness,
    dynamicSchemeVariant: DynamicSchemeVariant.monochrome,
  );

  static final light = MonoPalette._(_grey(Brightness.light));
  static final dark = MonoPalette._(_grey(Brightness.dark));

  /// The dark scheme with its backgrounds taken to true black.
  ///
  /// The only place a generated colour is overridden, and not a matter of
  /// taste: on OLED an unlit pixel draws no power, which a generator will never
  /// produce because it reasons about contrast rather than hardware. Only the
  /// page recedes — containers keep their tones, so cards still lift off it.
  static final oled = MonoPalette._(
    _grey(Brightness.dark).copyWith(
      surface: const Color(0xFF000000),
      surfaceDim: const Color(0xFF000000),
      surfaceContainerLowest: const Color(0xFF000000),
    ),
  );

  /// Android's wallpaper colours, run through the same Material 3 generator the
  /// system uses.
  ///
  /// Seeded from the accent tone Android publishes for this brightness, so the
  /// hue follows the wallpaper. The generator re-derives the tonal ramp, which
  /// means the result tracks the system closely without being guaranteed
  /// identical to it — reading Android's full set of published tones would
  /// close that gap, at the cost of maintaining the role table by hand.
  factory MonoPalette.fromDynamic(DynamicPalette palette, {required bool dark}) => MonoPalette._(
    ColorScheme.fromSeed(
      seedColor: dark ? palette.accentDark : palette.accentLight,
      brightness: dark ? Brightness.dark : Brightness.light,
    ),
    expressive: true,
  );
}
