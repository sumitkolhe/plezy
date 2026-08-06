import 'package:flutter/painting.dart';

/// Onboarding's colour scheme, and the only place in the app that has one.
///
/// A Material 3 dark scheme, named by role rather than by shade so the design's
/// intent survives a retune. Everything past `Continue` draws from
/// [MonoTokens], which is greyscale until Material You supplies an accent;
/// onboarding is the exception on purpose, because it runs before there is a
/// server, a profile or a theme to inherit.
///
/// Nothing outside `lib/screens/onboarding/` may import this.
abstract final class OnboardingPalette {
  static const Color surface = Color(0xFF0F1417);

  /// Cards and code boxes, a step up from [surface].
  static const Color surfaceContainerLow = Color(0xFF1C2226);
  static const Color surfaceContainer = Color(0xFF262C31);

  /// Tonal buttons and chips.
  static const Color secondaryContainer = Color(0xFF2B3238);
  static const Color onSecondaryContainer = Color(0xFFCBE6F5);

  static const Color primary = Color(0xFF8ACFF2);
  static const Color onPrimary = Color(0xFF003549);

  static const Color onSurface = Color(0xFFDFE3E6);
  static const Color onSurfaceVariant = Color(0xFFBFC8CD);

  /// Captions and hints, quieter again than [onSurfaceVariant].
  static const Color onSurfaceFaint = Color(0xFFA8B2B8);

  static const Color outline = Color(0xFF89939A);
  static const Color outlineVariant = Color(0xFF40484C);

  static const Color error = Color(0xFFFFB4AB);

  static const Color successContainer = Color(0xFF1F3D2B);
  static const Color onSuccessContainer = Color(0xFF9BD5A7);

  /// A warning that is not a failure — the certificate screen.
  static const Color caution = Color(0xFFF0C86A);

  /// The mark's own blue. Brand, not interface: no control uses it.
  static const Color brand = Color(0xFF2CA8E0);
}

/// Shared geometry, so the steps cannot drift apart.
abstract final class OnboardingMetrics {
  static const double gutter = 28;

  /// M3 buttons are full-height pills.
  static const double buttonHeight = 48;
  static const double fieldHeight = 56;

  /// The frame the design lays its vertical rhythm out in. Offsets taken from
  /// it are scaled by the real screen height so the composition holds on a
  /// shorter phone instead of overflowing.
  static const double referenceHeight = 844;
}

/// The M3 type ramp, as far as this flow uses it. Kept together so a heading on
/// one step cannot quietly differ from the same heading on another.
abstract final class OnboardingType {
  /// Headline small — every step title.
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400,
    color: OnboardingPalette.onSurface,
  );

  /// Body medium — the supporting line under a heading.
  static const TextStyle body = TextStyle(fontSize: 14, height: 1.5, color: OnboardingPalette.onSurfaceVariant);

  /// Label large — every button.
  static const TextStyle label = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1);

  /// Body large — what a field contains.
  static const TextStyle field = TextStyle(fontSize: 16, color: OnboardingPalette.onSurface);

  /// Body small — the supporting text beneath a field.
  static const TextStyle supporting = TextStyle(
    fontSize: 12,
    height: 1.33,
    letterSpacing: 0.4,
    color: OnboardingPalette.onSurfaceVariant,
  );
}
