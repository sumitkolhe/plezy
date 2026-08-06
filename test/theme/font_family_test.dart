import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/theme/mono_tokens.dart';

/// Geometry themes such as [Typography.englishLike2021] declare their styles
/// `inherit: false`, and [TextStyle.merge] returns those verbatim — so a family
/// set via `ThemeData.fontFamily` is silently dropped for every style the theme
/// does not override. Component styles handed straight to a [DefaultTextStyle]
/// (the app bar title, snackbars) never see the ambient family either. Both
/// failures render as the platform font with no error.
void main() {
  for (final (name, theme) in [
    ('light', monoTheme(MonoPalette.light)),
    ('dark', monoTheme(MonoPalette.dark)),
    ('oled', monoTheme(MonoPalette.oled)),
  ]) {
    test('$name theme resolves every text style to the app font', () {
      final t = theme.textTheme;
      final styles = <String, TextStyle?>{
        'displayLarge': t.displayLarge,
        'displayMedium': t.displayMedium,
        'displaySmall': t.displaySmall,
        'headlineLarge': t.headlineLarge,
        'headlineMedium': t.headlineMedium,
        'headlineSmall': t.headlineSmall,
        'titleLarge': t.titleLarge,
        'titleMedium': t.titleMedium,
        'titleSmall': t.titleSmall,
        'bodyLarge': t.bodyLarge,
        'bodyMedium': t.bodyMedium,
        'bodySmall': t.bodySmall,
        'labelLarge': t.labelLarge,
        'labelMedium': t.labelMedium,
        'labelSmall': t.labelSmall,
        'appBarTheme.titleTextStyle': theme.appBarTheme.titleTextStyle,
        'snackBarTheme.contentTextStyle': theme.snackBarTheme.contentTextStyle,
        'inputDecorationTheme.hintStyle': theme.inputDecorationTheme.hintStyle,
        'navigationBarTheme.labelTextStyle': theme.navigationBarTheme.labelTextStyle?.resolve({}),
      };

      for (final entry in styles.entries) {
        expect(entry.value?.fontFamily, MonoFonts.sans, reason: '${entry.key} must use the app font');
      }
    });
  }
}
