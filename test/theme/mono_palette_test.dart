import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/theme/dynamic_palette.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';

/// Every scheme is generated now, so pinning hex values would only assert that
/// Material 3 has not changed its mind. What is worth holding is the properties
/// the app depends on: that the grey themes are actually grey, that OLED
/// reaches true black, that Material You is the only coloured one, and that no
/// scheme ships an error colour nobody can read.
double _luminance(Color c) {
  double channel(double v) => v <= 0.03928 ? v / 12.92 : math.pow((v + 0.055) / 1.055, 2.4).toDouble();
  return 0.2126 * channel(c.r) + 0.7152 * channel(c.g) + 0.0722 * channel(c.b);
}

double contrast(Color a, Color b) {
  final la = _luminance(a);
  final lb = _luminance(b);
  final hi = la > lb ? la : lb;
  final lo = la > lb ? lb : la;
  return (hi + 0.05) / (lo + 0.05);
}

const _wallpaper = DynamicPalette(
  neutralDark: Color(0xFF1A1C1E),
  neutralLight: Color(0xFFE2E2E6),
  neutralWhite: Color(0xFFFFFFFF),
  accentDark: Color(0xFF9ECAFF),
  accentLight: Color(0xFF00639B),
);

bool _isGrey(Color c) => c.r == c.g && c.g == c.b;

void main() {
  final greyPalettes = {'light': MonoPalette.light, 'dark': MonoPalette.dark, 'oled': MonoPalette.oled};

  group('the grey themes are grey', () {
    greyPalettes.forEach((name, palette) {
      test('$name carries no hue', () {
        final s = palette.scheme;
        for (final (role, colour) in [
          ('surface', s.surface),
          ('surfaceContainer', s.surfaceContainer),
          ('onSurface', s.onSurface),
          ('onSurfaceVariant', s.onSurfaceVariant),
          ('primary', s.primary),
          ('outlineVariant', s.outlineVariant),
        ]) {
          expect(_isGrey(colour), isTrue, reason: '$name.$role is $colour, which is not greyscale');
        }
      });

      test('$name is not expressive, so it gets no ripples', () {
        expect(palette.expressive, isFalse);
      });
    });
  });

  test('OLED reaches true black, and keeps its containers lifted off it', () {
    final oled = MonoPalette.oled.scheme;
    expect(oled.surface, const Color(0xFF000000), reason: 'the point of OLED is unlit pixels');
    expect(oled.surfaceContainerLowest, const Color(0xFF000000));
    expect(
      oled.surfaceContainer,
      isNot(const Color(0xFF000000)),
      reason: 'a card that is also pure black cannot be seen against the page',
    );
    // Only the page was pinned; everything else is the generated dark scheme.
    expect(oled.onSurface, MonoPalette.dark.scheme.onSurface);
    expect(oled.primary, MonoPalette.dark.scheme.primary);
  });

  test('brightness is carried through to the theme', () {
    expect(monoTheme(MonoPalette.light).brightness, Brightness.light);
    expect(monoTheme(MonoPalette.dark).brightness, Brightness.dark);
    expect(monoTheme(MonoPalette.oled).brightness, Brightness.dark);
  });

  group('Material You', () {
    test('is the only scheme that carries colour, and the only one with ink', () {
      for (final dark in [true, false]) {
        final palette = MonoPalette.fromDynamic(_wallpaper, dark: dark);
        expect(palette.expressive, isTrue);
        expect(_isGrey(palette.scheme.primary), isFalse, reason: 'the wallpaper hue should survive');
      }
    });

    test('follows the brightness it was asked for', () {
      expect(MonoPalette.fromDynamic(_wallpaper, dark: true).isDark, isTrue);
      expect(MonoPalette.fromDynamic(_wallpaper, dark: false).isDark, isFalse);
    });
  });

  group('every scheme is legible', () {
    final all = {
      ...greyPalettes,
      'materialYou dark': MonoPalette.fromDynamic(_wallpaper, dark: true),
      'materialYou light': MonoPalette.fromDynamic(_wallpaper, dark: false),
    };

    all.forEach((name, palette) {
      test('$name clears WCAG AA on its own background', () {
        final s = palette.scheme;
        // The error colour is the one this app got wrong for a long time: a
        // fixed maroon that measured 2.6:1 on a dark background.
        expect(contrast(s.error, s.surface), greaterThanOrEqualTo(4.5), reason: '$name error text on its own surface');
        expect(contrast(s.onSurface, s.surface), greaterThanOrEqualTo(4.5), reason: '$name body text');
        expect(contrast(s.onPrimary, s.primary), greaterThanOrEqualTo(4.5), reason: '$name text on a filled button');
        expect(contrast(s.onSurfaceVariant, s.surface), greaterThanOrEqualTo(4.5), reason: '$name secondary text');
      });
    });
  });
}
