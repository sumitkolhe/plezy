import 'package:flutter/material.dart';

/// Shared geometry, so the steps cannot drift apart.
///
/// Shapes and sizes only. Colour comes from [MonoTokens] and the theme's
/// [ColorScheme] like everywhere else in the app — onboarding has no palette of
/// its own, so it follows whatever the user has chosen, Material You included.
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
/// one step cannot quietly differ from the same heading on another. Colourless
/// — the call site supplies that from the theme.
abstract final class OnboardingType {
  /// Headline small — every step title.
  static const TextStyle headline = TextStyle(fontSize: 24, fontWeight: FontWeight.w400);

  /// Body medium — the supporting line under a heading.
  static const TextStyle body = TextStyle(fontSize: 14, height: 1.5);

  /// Label large — every button.
  static const TextStyle label = TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1);

  /// Body large — what a field contains.
  static const TextStyle field = TextStyle(fontSize: 16);

  /// Body small — the supporting text beneath a field.
  static const TextStyle supporting = TextStyle(fontSize: 12, height: 1.33, letterSpacing: 0.4);
}
