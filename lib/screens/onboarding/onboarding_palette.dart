import 'package:flutter/painting.dart';

/// The brand palette, and the only place in the app that is allowed one.
///
/// Everything past `Open library` draws from [MonoTokens], which is greyscale
/// until Material You supplies an accent from the wallpaper. Onboarding is the
/// exception on purpose: it runs before there is a server, a profile or a
/// theme to inherit, and it is the one surface whose job is to say which app
/// this is. Values come from the brand export sheet, not from taste — keep
/// them in step with `exports/README.md` in the design project.
///
/// Nothing outside `lib/screens/onboarding/` may import this.
abstract final class OnboardingPalette {
  static const Color ink = Color(0xFF0A0A0B);
  static const Color blue = Color(0xFF2CA8E0);

  /// Pressed states, and the mark on light backgrounds.
  static const Color blueDeep = Color(0xFF1B8EC2);

  static const Color text = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFF8B8B93);

  /// Hints and captions — a step quieter than [textMuted].
  static const Color textFaint = Color(0xFF7C7C85);
  static const Color textFainter = Color(0xFF5E5E66);

  static const Color danger = Color(0xFFE0685F);
  static const Color success = Color(0xFF5FC38A);

  static const Color fieldFill = Color(0x12FFFFFF);
  static const Color hairline = Color(0x14FFFFFF);
  static const Color outline = Color(0x29FFFFFF);
}

/// Shared geometry, so the five steps cannot drift apart.
abstract final class OnboardingMetrics {
  static const double gutter = 28;
  static const double controlHeight = 54;
  static const double radius = 14;
}
