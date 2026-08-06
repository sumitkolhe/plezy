import 'package:flutter/painting.dart';

/// The brand palette, and the only place in the app that is allowed one.
///
/// Everything past `Continue` draws from [MonoTokens], which is greyscale until
/// Material You supplies an accent from the wallpaper. Onboarding is the
/// exception on purpose: it runs before there is a server, a profile or a theme
/// to inherit, and it is the one surface whose job is to say which app this is.
/// Values come from the design, not from taste.
///
/// Nothing outside `lib/screens/onboarding/` may import this.
abstract final class OnboardingPalette {
  static const Color ink = Color(0xFF0A0A0B);

  /// The mark, and nothing else. Actions are white — the blue is the brand's,
  /// not the interface's.
  static const Color blue = Color(0xFF2CA8E0);

  static const Color text = Color(0xFFFFFFFF);

  /// Body copy against [ink].
  static const Color textMuted = Color(0xFF8B8B93);

  /// Labels and captions — a step quieter than [textMuted].
  static const Color textFaint = Color(0xFF7C7C85);

  /// Hints and placeholders, at the floor of legibility.
  static const Color textFainter = Color(0xFF5E5E66);

  /// Values inside chips and rows, where the surface has already lifted.
  static const Color textOnFill = Color(0xFFC6C6CC);

  /// The helper line under the address field.
  static const Color textHelper = Color(0xFF63636B);

  static const Color danger = Color(0xFFE0685F);
  static const Color caution = Color(0xFFF0C86A);
  static const Color success = Color(0xFF5FC38A);

  static const Color fieldFill = Color(0x12FFFFFF);

  /// Secondary actions and chips.
  static const Color raised = Color(0x17FFFFFF);

  static const Color hairline = Color(0x14FFFFFF);
  static const Color outline = Color(0x1FFFFFFF);
}

/// Shared geometry, so the steps cannot drift apart.
abstract final class OnboardingMetrics {
  static const double gutter = 28;

  /// Primary and secondary actions are pills of the same height.
  static const double controlHeight = 48;
  static const double fieldHeight = 52;
  static const double fieldRadius = 14;

  /// The frame the design lays its vertical rhythm out in. Offsets taken from
  /// it are scaled by the real screen height so the composition holds on a
  /// shorter phone instead of overflowing.
  static const double referenceHeight = 844;
}
