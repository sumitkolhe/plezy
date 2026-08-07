import 'package:flutter/material.dart';
import 'mono_palette.dart';
import 'haptic_ink_factory.dart';
import 'gapped_track_shape.dart';
import 'mono_tokens.dart';

/// Build the app's theme from a [MonoPalette].
///
/// The palette arrives with a complete Material 3 [ColorScheme], so this
/// function never decides a colour — it names the app's own vocabulary in terms
/// of that scheme, then styles the components Material would otherwise draw its
/// own way. Which scheme is [ThemeProvider]'s decision.
ThemeData monoTheme(MonoPalette palette) {
  final scheme = palette.scheme;
  final materialYou = palette.expressive;

  // The app's shorthand, mapped onto M3's roles once, here. `bg` is the page
  // and `surface` is what lifts off it — which are M3's `surface` and
  // `surfaceContainer`, not the pair its names suggest. `outline` is a
  // hairline, so it takes `outlineVariant` rather than the heavier `outline`.
  final c = (
    bg: scheme.surface,
    surface: scheme.surfaceContainer,
    outline: scheme.outlineVariant,
    text: scheme.onSurface,
    textMuted: scheme.onSurfaceVariant,
    accent: scheme.primary,
  );

  final clickableCursor = WidgetStateProperty.resolveWith<MouseCursor>(
    (states) => states.contains(WidgetState.disabled) ? MouseCursor.defer : SystemMouseCursors.click,
  );

  final buttonStyle = ButtonStyle(
    mouseCursor: clickableCursor,
    padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 18, vertical: 14)),
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor: WidgetStatePropertyAll(scheme.primary),
    foregroundColor: WidgetStatePropertyAll(scheme.onPrimary),
    shape: const WidgetStatePropertyAll(StadiumBorder()),
  );

  final base = ThemeData(
    useMaterial3: true,
    fontFamily: MonoFonts.sans,
    brightness: scheme.brightness,
    colorScheme: scheme,
    // The mono themes deliberately have no ink; Material You is Material, and
    // the sparkle is half of what people recognise it by.
    splashFactory: materialYou ? hapticSparkle : hapticNoSplash,
    splashColor: materialYou ? c.accent.withValues(alpha: 0.14) : null,
    highlightColor: materialYou ? c.accent.withValues(alpha: 0.08) : Colors.transparent,
    // Explicit mono-derived tile highlights: ListTile's native focus/hover
    // fill is the dpad focus visual inside M3E grouped-list cards.
    focusColor: c.accent.withValues(alpha: 0.12),
    hoverColor: c.text.withValues(alpha: 0.05),
    dividerColor: c.outline,
    scaffoldBackgroundColor: c.bg,
    appBarTheme: AppBarTheme(
      backgroundColor: c.bg,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      foregroundColor: c.text,
      titleTextStyle: TextStyle(
        color: c.text,
        fontFamily: MonoFonts.sans,
        fontSize: 18,
        fontWeight: .w700,
        letterSpacing: -0.2,
      ),
    ),
    textTheme: Typography.englishLike2021
        .apply(bodyColor: c.text, displayColor: c.text, fontFamily: MonoFonts.sans)
        .copyWith(
          displayLarge: const TextStyle(fontWeight: .w700, letterSpacing: -0.5),
          titleMedium: const TextStyle(fontWeight: .w600),
          bodyMedium: TextStyle(color: c.text),
          bodySmall: TextStyle(color: c.textMuted),
        ),
    cardTheme: CardThemeData(
      color: c.surface,
      elevation: 0,
      margin: .zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
    ),
    inputDecorationTheme: _inputDecorationTheme(c.textMuted, c.outline, scheme.primary, scheme.error),
    elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
    filledButtonTheme: FilledButtonThemeData(style: buttonStyle),
    textButtonTheme: TextButtonThemeData(style: ButtonStyle(mouseCursor: clickableCursor)),
    outlinedButtonTheme: OutlinedButtonThemeData(style: ButtonStyle(mouseCursor: clickableCursor)),
    iconButtonTheme: IconButtonThemeData(style: ButtonStyle(mouseCursor: clickableCursor)),
    sliderTheme: SliderThemeData(
      // The mono scheme maps surfaceContainerHighest (the M3 default inactive
      // track) to the same color as surface cards, which makes the inactive
      // track invisible inside grouped-list items.
      inactiveTrackColor: c.text.withValues(alpha: 0.12),
      trackHeight: 16,
      trackGap: 6,
      thumbSize: const WidgetStatePropertyAll(Size(4, 20)),
      thumbShape: const HandleThumbShape(),
      trackShape: const GappedTrackShape(),
      tickMarkShape: const RoundSliderTickMarkShape(tickMarkRadius: 2),
      // ignore: deprecated_member_use — opting into the 2024 slider appearance until the default flips
      year2023: false,
    ),
    dividerTheme: DividerThemeData(space: 0, thickness: 1, color: c.outline),
    listTileTheme: ListTileThemeData(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      iconColor: c.text,
      textColor: c.text,
    ),
    navigationBarTheme: NavigationBarThemeData(
      // Transparent so content passes under it; MainScreen lays a scrim behind
      // the bar to keep the icons legible over whatever scrolls past.
      backgroundColor: Colors.transparent,
      elevation: 0,
      indicatorColor: Colors.transparent,
      labelTextStyle: WidgetStatePropertyAll(TextStyle(color: c.textMuted, fontFamily: MonoFonts.sans, fontSize: 11)),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        final active = states.contains(WidgetState.selected);
        // 24 is both what M3 asks of a navigation icon and the grid Tabler is
        // drawn on, so strokes land on whole pixels instead of between them.
        return IconThemeData(opacity: active ? 1 : 0.6, size: 24, color: c.text);
      }),
    ),
    // Floating snackbars auto-offset above the Scaffold's bottom NavigationBar,
    // so they don't cover it on mobile. Background color tracks the theme to
    // avoid jarring brightness on HDR playback / dark mode.
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: c.surface,
      contentTextStyle: TextStyle(color: c.text, fontFamily: MonoFonts.sans),
      actionTextColor: c.text,
      elevation: 6,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      insetPadding: const EdgeInsets.all(16),
    ),
  );

  return base.copyWith(
    extensions: [
      MonoTokens(
        radiusSm: 8,
        radiusMd: 12,
        radiusLg: 20,
        radiusXs: 5,
        groupGap: 2,
        space: 12,
        fast: const Duration(milliseconds: 120),
        normal: const Duration(milliseconds: 200),
        slow: const Duration(milliseconds: 300),
        expressive: const Duration(milliseconds: 350),
        bg: c.bg,
        surface: c.surface,
        outline: c.outline,
        text: c.text,
        textMuted: c.textMuted,
        accent: c.accent,
        success: scheme.brightness == Brightness.dark ? _successDark : _successLight,
        splashFactory: materialYou ? hapticSparkle : hapticNoSplash,
      ),
    ],
  );
}

/// One field shape for the whole app: an outlined pill that thickens to the
/// accent on focus.
///
/// It used to be a filled box that signalled focus by brightening its own fill.
/// That is invisible on a surface the same colour as the fill, and it left
/// anything drawing its own outline — the onboarding fields did — with no focus
/// state at all, because opting out of the fill opted out of the only signal
/// there was.
InputDecorationTheme _inputDecorationTheme(Color textMuted, Color outline, Color primary, Color error) {
  OutlineInputBorder pill(Color color, double width) => OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(999)),
    borderSide: BorderSide(color: color, width: width),
    // Room around the label where it notches into the outline.
    gapPadding: 6,
  );
  return InputDecorationTheme(
    filled: false,
    isDense: true,
    // Wide enough that text clears the pill's own curve at either end.
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    border: pill(outline, 1),
    enabledBorder: pill(outline, 1),
    focusedBorder: pill(primary, 2),
    errorBorder: pill(error, 1),
    focusedErrorBorder: pill(error, 2),
    hintStyle: TextStyle(color: textMuted, fontFamily: MonoFonts.sans),
  );
}

/// Green at the tones M3 gives `error` — 40 on light, 80 on dark — so a
/// success reads with the same weight as a failure rather than shouting over
/// it. Fixed rather than generated: the greyscale schemes have no hue to
/// derive one from, and it must not drift with the wallpaper either.
const Color _successLight = Color(0xFF1A6C31);
const Color _successDark = Color(0xFF88D990);
