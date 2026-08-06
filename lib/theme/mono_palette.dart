import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'dynamic_palette.dart';

/// A resolved colour scheme, ready for [monoTheme] to build a theme around.
///
/// The distinction from [DynamicPalette] is the point of this type:
/// [DynamicPalette] is raw input from Android, whose tones need deriving before
/// they mean anything here. This is the answer — the six colours the app
/// actually paints with, however they were arrived at. Every theme is one of
/// these, so the theme function has a single code path and adding a scheme is
/// adding a constant rather than a branch.
@immutable
class MonoPalette {
  const MonoPalette({
    required this.bg,
    required this.surface,
    required this.outline,
    required this.text,
    required this.textMuted,
    required this.accent,
    required this.isDark,
    this.expressive = false,
  });

  final Color bg;
  final Color surface;
  final Color outline;
  final Color text;
  final Color textMuted;

  /// The one colour that is not greyscale in the schemes that have one. In the
  /// static palettes it is deliberately equal to [text]: the slot exists, and
  /// holding ink in it is what makes the app monochrome.
  final Color accent;

  /// Carried rather than derived from luminance, which would be clever and
  /// fragile.
  final bool isDark;

  /// Whether the scheme wants Material's ink — ripples and a sparkle on tap.
  ///
  /// Separate from where the colours came from. The two coincide today, but a
  /// flag that says "has a wallpaper palette" while being read as "show
  /// ripples" is one refactor away from lying.
  final bool expressive;

  static const light = MonoPalette(
    bg: Color(0xFFF7F7F8),
    surface: Color(0xFFFFFFFF),
    outline: Color(0x19000000),
    text: Color(0xFF111111),
    textMuted: Color(0x99111111),
    accent: Color(0xFF111111),
    isDark: false,
  );

  static const dark = MonoPalette(
    bg: Color(0xFF0E0F12),
    surface: Color(0xFF15171C),
    outline: Color(0x1FFFFFFF),
    text: Color(0xFFEDEDED),
    textMuted: Color(0x99EDEDED),
    accent: Color(0xFFEDEDED),
    isDark: true,
  );

  static const oled = MonoPalette(
    // Pure black so unlit pixels stay off; surface still lifts off it.
    bg: Color(0xFF000000),
    surface: Color(0xFF0A0A0A),
    outline: Color(0x1FFFFFFF),
    text: Color(0xFFEDEDED),
    textMuted: Color(0x99EDEDED),
    accent: Color(0xFFEDEDED),
    isDark: true,
  );

  /// Derive a scheme from Android's wallpaper tones.
  ///
  /// The outline is not taken from the wallpaper in either brightness — it is
  /// a hairline, and tinting it makes edges read as coloured rather than as
  /// structure.
  factory MonoPalette.fromDynamic(DynamicPalette palette, {required bool dark}) {
    if (dark) {
      return MonoPalette(
        // Android publishes tone 10 as its darkest tinted neutral, which is
        // lighter than this app sits. Pulling it toward black keeps the
        // wallpaper's hue at the depth the other dark themes use.
        bg: Color.lerp(palette.neutralDark, const Color(0xFF000000), 0.55)!,
        surface: Color.lerp(palette.neutralDark, const Color(0xFF000000), 0.25)!,
        outline: const Color(0x1FFFFFFF),
        text: palette.neutralLight,
        textMuted: palette.neutralLight.withValues(alpha: 0.6),
        accent: palette.accentDark,
        isDark: true,
        expressive: true,
      );
    }
    return MonoPalette(
      bg: palette.neutralLight,
      surface: palette.neutralWhite,
      outline: const Color(0x19000000),
      text: palette.neutralDark,
      textMuted: palette.neutralDark.withValues(alpha: 0.6),
      accent: palette.accentLight,
      isDark: false,
      expressive: true,
    );
  }
}
