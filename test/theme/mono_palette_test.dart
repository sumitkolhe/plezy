import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/theme/dynamic_palette.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/theme/mono_tokens.dart';

/// What each scheme resolves to, written out rather than computed, so a change
/// to any colour has to be made here as well as in the palette. These are the
/// values the branch chain inside monoTheme produced before the schemes became
/// data; the point of the test is that moving them did not move them.
void main() {
  MonoTokens tokensOf(MonoPalette palette) => monoTheme(palette).extension<MonoTokens>()!;

  test('the light scheme is the one the app shipped', () {
    final t = tokensOf(MonoPalette.light);
    expect(t.bg, const Color(0xFFF7F7F8));
    expect(t.surface, const Color(0xFFFFFFFF));
    expect(t.outline, const Color(0x19000000));
    expect(t.text, const Color(0xFF111111));
    expect(t.textMuted, const Color(0x99111111));
    expect(t.accent, const Color(0xFF111111));
  });

  test('the dark scheme is the one the app shipped', () {
    final t = tokensOf(MonoPalette.dark);
    expect(t.bg, const Color(0xFF0E0F12));
    expect(t.surface, const Color(0xFF15171C));
    expect(t.outline, const Color(0x1FFFFFFF));
    expect(t.text, const Color(0xFFEDEDED));
    expect(t.textMuted, const Color(0x99EDEDED));
    expect(t.accent, const Color(0xFFEDEDED));
  });

  test('OLED differs from dark only in how far down it goes', () {
    final oled = tokensOf(MonoPalette.oled);
    final dark = tokensOf(MonoPalette.dark);
    expect(oled.bg, const Color(0xFF000000));
    expect(oled.surface, const Color(0xFF0A0A0A));
    expect(oled.text, dark.text);
    expect(oled.textMuted, dark.textMuted);
    expect(oled.accent, dark.accent);
    expect(oled.outline, dark.outline);
  });

  test('the static schemes hold ink in the accent slot, which is what makes them mono', () {
    for (final palette in [MonoPalette.light, MonoPalette.dark, MonoPalette.oled]) {
      final t = tokensOf(palette);
      expect(t.accent, t.text, reason: 'a static scheme must not introduce a colour');
    }
  });

  group('Material You', () {
    const wallpaper = DynamicPalette(
      neutralDark: Color(0xFF1A1C1E),
      neutralLight: Color(0xFFE2E2E6),
      neutralWhite: Color(0xFFFFFFFF),
      accentDark: Color(0xFF9ECAFF),
      accentLight: Color(0xFF00639B),
    );

    test('dark pulls the wallpaper neutral toward black rather than using it raw', () {
      final palette = MonoPalette.fromDynamic(wallpaper, dark: true);
      expect(palette.bg, Color.lerp(wallpaper.neutralDark, const Color(0xFF000000), 0.55));
      expect(palette.surface, Color.lerp(wallpaper.neutralDark, const Color(0xFF000000), 0.25));
      expect(palette.bg, isNot(wallpaper.neutralDark), reason: 'tone 10 sits lighter than this app does');
      expect(palette.accent, wallpaper.accentDark);
    });

    test('light takes the neutrals as published', () {
      final palette = MonoPalette.fromDynamic(wallpaper, dark: false);
      expect(palette.bg, wallpaper.neutralLight);
      expect(palette.surface, wallpaper.neutralWhite);
      expect(palette.text, wallpaper.neutralDark);
      expect(palette.accent, wallpaper.accentLight);
    });

    test('is the only scheme whose accent is not its text, and the only one with ink', () {
      for (final dark in [true, false]) {
        final palette = MonoPalette.fromDynamic(wallpaper, dark: dark);
        expect(palette.accent, isNot(palette.text));
        expect(palette.expressive, isTrue);
      }
      for (final palette in [MonoPalette.light, MonoPalette.dark, MonoPalette.oled]) {
        expect(palette.expressive, isFalse);
      }
    });

    test('the hairline is never tinted by the wallpaper', () {
      expect(MonoPalette.fromDynamic(wallpaper, dark: true).outline, MonoPalette.dark.outline);
      expect(MonoPalette.fromDynamic(wallpaper, dark: false).outline, MonoPalette.light.outline);
    });
  });

  test('brightness is carried by the scheme, not inferred', () {
    expect(monoTheme(MonoPalette.light).brightness, Brightness.light);
    expect(monoTheme(MonoPalette.dark).brightness, Brightness.dark);
    expect(monoTheme(MonoPalette.oled).brightness, Brightness.dark);
  });
}
