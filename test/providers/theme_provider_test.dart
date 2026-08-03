import 'package:flutter/material.dart' as material;
import 'package:flutter_test/flutter_test.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/providers/theme_provider.dart';
import 'package:harbor/screens/settings/settings_utils.dart';
import 'package:harbor/services/base_shared_preferences_service.dart';
import 'package:harbor/services/settings_service.dart' as settings;

import 'package:harbor/theme/haptic_ink_factory.dart';
import 'package:harbor/theme/mono_tokens.dart';

import '../test_helpers/prefs.dart';

MonoTokens monoTokensOf(material.ThemeData theme) => theme.extension<MonoTokens>()!;

void main() {
  setUp(resetSharedPreferencesForTest);
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  group('ThemeProvider', () {
    test('exposes a non-null themeMode immediately and flips after init', () async {
      final p = ThemeProvider();
      // The constructor synchronously sets _themeMode to system.
      expect(p.themeMode, settings.ThemeMode.system);

      // After init the value reflects what's persisted (default).
      // First-run default is computed by the EnumPref; it is one of the four
      // ThemeMode values regardless of whether we're on TV or not.
      // Wait a microtask for _initializeSettings() to finish.
      await Future.delayed(Duration.zero);
      expect(settings.ThemeMode.values, contains(p.themeMode));

      p.dispose();
    });

    test('setThemeMode persists, notifies, and is a no-op for same value', () async {
      final p = ThemeProvider();
      await Future.delayed(Duration.zero);

      var notified = 0;
      p.addListener(() => notified++);

      // Pick a mode that is guaranteed different from default `system`/`oled`
      // on either pathway: cycle through values until we hit one that differs.
      final initial = p.themeMode;
      final next = settings.ThemeMode.values.firstWhere((m) => m != initial);
      await p.setThemeMode(next);
      expect(p.themeMode, next);
      expect(notified, 1);

      // Same value → no notify.
      await p.setThemeMode(next);
      expect(notified, 1);

      // Verify persisted via SettingsService.
      final svc = await settings.SettingsService.getInstance();
      expect(svc.read(settings.SettingsService.themeMode), next);

      p.dispose();
    });

    test('materialThemeMode maps each ThemeMode value correctly', () async {
      final p = ThemeProvider();
      await Future.delayed(Duration.zero);

      await p.setThemeMode(settings.ThemeMode.light);
      expect(p.materialThemeMode, material.ThemeMode.light);

      await p.setThemeMode(settings.ThemeMode.dark);
      expect(p.materialThemeMode, material.ThemeMode.dark);

      await p.setThemeMode(settings.ThemeMode.oled);
      expect(p.materialThemeMode, material.ThemeMode.dark);

      await p.setThemeMode(settings.ThemeMode.system);
      expect(p.materialThemeMode, material.ThemeMode.system);

      await p.setThemeMode(settings.ThemeMode.materialYou);
      expect(p.materialThemeMode, material.ThemeMode.system);

      p.dispose();
    });

    test('isDarkMode reflects mode for explicit settings', () async {
      final p = ThemeProvider();
      await Future.delayed(Duration.zero);

      await p.setThemeMode(settings.ThemeMode.light);
      expect(p.isDarkMode, isFalse);

      await p.setThemeMode(settings.ThemeMode.dark);
      expect(p.isDarkMode, isTrue);

      await p.setThemeMode(settings.ThemeMode.oled);
      expect(p.isDarkMode, isTrue);

      p.dispose();
    });

    test('darkTheme variants differ between dark and oled', () async {
      final p = ThemeProvider();
      await Future.delayed(Duration.zero);

      await p.setThemeMode(settings.ThemeMode.dark);
      final dark = p.darkTheme;
      await p.setThemeMode(settings.ThemeMode.oled);
      final oled = p.darkTheme;

      // OLED must be a true black canvas; regular dark uses a non-black surface.
      expect(oled.scaffoldBackgroundColor, const material.Color(0xFF000000));
      expect(dark.scaffoldBackgroundColor, isNot(const material.Color(0xFF000000)));

      p.dispose();
    });

    test('themeModeLabel and themeModeIcon match the active mode', () async {
      final p = ThemeProvider();
      await Future.delayed(Duration.zero);

      await p.setThemeMode(settings.ThemeMode.light);
      expect(themeModeLabel(p.themeMode), t.settings.lightTheme);
      expect(p.themeModeIcon, TablerIcons.sun);

      await p.setThemeMode(settings.ThemeMode.dark);
      expect(themeModeLabel(p.themeMode), t.settings.darkTheme);
      expect(p.themeModeIcon, TablerIcons.moon);

      await p.setThemeMode(settings.ThemeMode.oled);
      expect(themeModeLabel(p.themeMode), t.settings.oledTheme);
      expect(p.themeModeIcon, TablerIcons.contrast);

      await p.setThemeMode(settings.ThemeMode.system);
      expect(themeModeLabel(p.themeMode), t.settings.systemTheme);
      expect(p.themeModeIcon, TablerIcons.sun);

      await p.setThemeMode(settings.ThemeMode.materialYou);
      expect(themeModeLabel(p.themeMode), t.settings.materialYouTheme);
      expect(p.themeModeIcon, TablerIcons.palette);

      p.dispose();
    });

    test('themeModeLabel follows a non-English locale for every mode', () async {
      await LocaleSettings.setLocale(AppLocale.de);
      try {
        expect(themeModeLabel(settings.ThemeMode.system), 'System');
        expect(themeModeLabel(settings.ThemeMode.light), 'Hell');
        expect(themeModeLabel(settings.ThemeMode.dark), 'Dunkel');
        expect(themeModeLabel(settings.ThemeMode.oled), 'OLED');
      } finally {
        LocaleSettings.setLocaleSync(AppLocale.en);
      }
    });

    test('material you falls back to the mono theme when the platform has no palette', () async {
      final p = ThemeProvider();
      await Future.delayed(Duration.zero);
      await p.setThemeMode(settings.ThemeMode.materialYou);

      // No channel answers in tests, so the palette stays null and the theme
      // must be identical to plain system rather than half-applied.
      expect(p.darkTheme.colorScheme.primary, ThemeProvider().darkTheme.colorScheme.primary);
      expect(p.materialThemeMode, material.ThemeMode.system);

      p.dispose();
    });

    test('a cached palette paints wallpaper colours without waiting on the channel', () async {
      final service = await settings.SettingsService.getInstance();
      await service.write(settings.SettingsService.themeMode, settings.ThemeMode.materialYou);
      await service.write(settings.SettingsService.dynamicPalette, const {
        'neutralDark': 0xFF1B1B2F,
        'neutralLight': 0xFFF2EFF7,
        'neutralWhite': 0xFFFFFFFF,
        'accentDark': 0xFFB9C3FF,
        'accentLight': 0xFF4355B9,
      });

      final p = ThemeProvider();
      expect(p.themeMode, settings.ThemeMode.materialYou);
      expect(p.darkTheme.colorScheme.primary, const material.Color(0xFFB9C3FF));
      expect(p.lightTheme.colorScheme.primary, const material.Color(0xFF4355B9));

      // The tinted neutrals sit behind everything, and dark stays darker than
      // the tone Android publishes.
      final darkTokens = monoTokensOf(p.darkTheme);
      expect(darkTokens.bg.toARGB32(), lessThan(0xFF1B1B2F));
      expect(darkTokens.accent, const material.Color(0xFFB9C3FF));
      expect(monoTokensOf(p.lightTheme).surface, const material.Color(0xFFFFFFFF));

      p.dispose();
    });

    test('material you inks, and the mono themes still do not', () async {
      final service = await settings.SettingsService.getInstance();
      await service.write(settings.SettingsService.themeMode, settings.ThemeMode.materialYou);
      await service.write(settings.SettingsService.dynamicPalette, const {
        'neutralDark': 0xFF1B1B2F,
        'neutralLight': 0xFFF2EFF7,
        'neutralWhite': 0xFFFFFFFF,
        'accentDark': 0xFFB9C3FF,
        'accentLight': 0xFF4355B9,
      });

      final p = ThemeProvider();
      expect(p.darkTheme.splashFactory, hapticSparkle);
      expect(p.darkTheme.highlightColor, isNot(material.Colors.transparent));

      await p.setThemeMode(settings.ThemeMode.dark);
      expect(p.darkTheme.splashFactory, hapticNoSplash);
      expect(p.darkTheme.highlightColor, material.Colors.transparent);

      p.dispose();
    });

    test('oled ignores the palette so pure black stays pure black', () async {
      final service = await settings.SettingsService.getInstance();
      await service.write(settings.SettingsService.dynamicPalette, const {
        'neutralDark': 0xFF1B1B2F,
        'neutralLight': 0xFFF2EFF7,
        'neutralWhite': 0xFFFFFFFF,
        'accentDark': 0xFFB9C3FF,
        'accentLight': 0xFF4355B9,
      });
      final p = ThemeProvider();
      await Future.delayed(Duration.zero);
      await p.setThemeMode(settings.ThemeMode.oled);

      expect(monoTokensOf(p.darkTheme).bg, const material.Color(0xFF000000));
      expect(monoTokensOf(p.darkTheme).accent, const material.Color(0xFFEDEDED));

      p.dispose();
    });

    test('reload re-reads after external mutation', () async {
      final p = ThemeProvider();
      await Future.delayed(Duration.zero);

      // Mutate the persisted theme out-of-band.
      final svc = await settings.SettingsService.getInstance();
      await svc.write(settings.SettingsService.themeMode, settings.ThemeMode.light);

      var notified = 0;
      p.addListener(() => notified++);

      await p.reload();
      expect(p.themeMode, settings.ThemeMode.light);
      expect(notified, 1);

      p.dispose();
    });

    test('persists across provider instances via SharedPreferences', () async {
      final first = ThemeProvider();
      await Future.delayed(Duration.zero);
      await first.setThemeMode(settings.ThemeMode.dark);
      first.dispose();

      // Reset only the cached singleton — backing store is preserved.
      BaseSharedPreferencesService.resetForTesting();

      final second = ThemeProvider();
      await Future.delayed(Duration.zero);
      expect(second.themeMode, settings.ThemeMode.dark);
      second.dispose();
    });

    test('safeNotifyListeners no-ops after dispose', () async {
      final p = ThemeProvider();
      await Future.delayed(Duration.zero);
      p.dispose();
      // Should not throw — reload calls safeNotifyListeners under the hood.
      await p.reload();
    });
  });

  testWidgets('regex dialog localizes its field label and validation error', (tester) async {
    await LocaleSettings.setLocale(AppLocale.de);
    addTearDown(() => LocaleSettings.setLocaleSync(AppLocale.en));

    await tester.pumpWidget(
      material.MaterialApp(
        home: material.Scaffold(
          body: material.Builder(
            builder: (context) => material.TextButton(
              onPressed: () => showRegexInputDialog(
                context: context,
                title: 'Muster',
                currentValue: '^intro',
                defaultValue: '',
                onSave: (_) async {},
              ),
              child: const material.Text('Öffnen'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Öffnen'));
    await tester.pumpAndSettle();
    expect(find.text('Regulärer Ausdruck'), findsOneWidget);

    await tester.enterText(find.byType(material.TextField), '[');
    await tester.pump();
    expect(find.text('Ungültiger regulärer Ausdruck'), findsOneWidget);
  });
}
