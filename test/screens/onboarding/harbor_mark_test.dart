import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/screens/onboarding/steps/intro_step.dart';
import 'package:harbor/screens/onboarding/widgets/harbor_mark.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';

/// Built once. A fresh ThemeData per pump makes MaterialApp animate the change,
/// which keeps a frame callback scheduled and hides whether the mark's own
/// ticker stopped.
final _theme = monoTheme(MonoPalette.dark);
final _lightTheme = monoTheme(MonoPalette.light);

Future<void> _pumpMark(WidgetTester tester, {required bool reducedMotion, double size = 104, bool light = false}) =>
    tester.pumpWidget(
      MediaQuery(
        data: MediaQueryData(disableAnimations: reducedMotion),
        child: MaterialApp(
          // Otherwise a theme swap spends 200ms lerping and the frame after the
          // pump still reports the old brightness.
          themeAnimationDuration: Duration.zero,
          theme: light ? _lightTheme : _theme,
          home: Scaffold(
            body: Center(child: HarborMark(size: size)),
          ),
        ),
      ),
    );

void main() {
  testWidgets('the water runs by default', (tester) async {
    await _pumpMark(tester, reducedMotion: false);
    expect(tester.binding.transientCallbackCount, greaterThan(0));

    // Nine seconds is a long cycle; make sure it is still going after one.
    await tester.pump(HarborMark.period);
    expect(tester.binding.transientCallbackCount, greaterThan(0));
  });

  testWidgets('the water is still under reduced motion', (tester) async {
    await _pumpMark(tester, reducedMotion: true);
    expect(tester.binding.transientCallbackCount, 0, reason: 'no ticker should be scheduled');
  });

  testWidgets('turning reduced motion on mid-session stops it', (tester) async {
    await _pumpMark(tester, reducedMotion: false);
    expect(tester.binding.transientCallbackCount, greaterThan(0));

    await _pumpMark(tester, reducedMotion: true);
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('the jib is dropped below the brand threshold', (tester) async {
    // Both sizes have to paint without throwing; the jib itself is a painter
    // decision that only the canvas sees.
    for (final size in [HarborMark.jibThreshold - 1, HarborMark.jibThreshold, 104.0]) {
      await _pumpMark(tester, reducedMotion: true, size: size);
      expect(tester.takeException(), isNull, reason: 'size $size');
      expect(tester.getSize(find.byType(HarborMark)), Size.square(size));
    }
  });

  testWidgets('the mainsail inverts on a light ground', (tester) async {
    // White on #F9F9F9 is not a logo, it is nothing. The painter has to know
    // which lockup it is drawing, so both grounds must paint without throwing
    // and the light one must ask for a repaint when the ground changes.
    // Material puts its own painter-less CustomPaints in the tree, so reach
    // for the mark's rather than the first one found.
    CustomPainter markPainter() => tester
        .widgetList<CustomPaint>(find.descendant(of: find.byType(HarborMark), matching: find.byType(CustomPaint)))
        .map((paint) => paint.painter)
        .whereType<CustomPainter>()
        .first;

    await _pumpMark(tester, reducedMotion: true);
    final onDark = markPainter();

    await _pumpMark(tester, reducedMotion: true, light: true);
    final onLight = markPainter();

    expect(tester.takeException(), isNull);
    expect(onLight.shouldRepaint(onDark), isTrue, reason: 'a changed ground has to repaint');
  });

  test('the first swell arrives within a splash, and later ones keep the full rest', () {
    expect(HarborMark.initialCycle, inInclusiveRange(0, HarborMark.restFraction));

    final restLeft = (HarborMark.restFraction - HarborMark.initialCycle) * HarborMark.period.inMilliseconds;
    expect(restLeft, closeTo(HarborMark.firstSwell.inMilliseconds, 1));
    expect(HarborMark.firstSwell, lessThan(IntroStep.splashHold), reason: 'or the splash ends before the water moves');
  });
}
