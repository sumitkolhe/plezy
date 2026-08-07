import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/screens/onboarding/widgets/harbor_mark.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';

/// Built once. A fresh ThemeData per pump makes MaterialApp animate the change,
/// which keeps a frame callback scheduled and hides whether the mark's own
/// ticker stopped.
final _theme = monoTheme(MonoPalette.dark);

Future<void> _pumpMark(WidgetTester tester, {required bool reducedMotion, double size = 104}) => tester.pumpWidget(
  MediaQuery(
    data: MediaQueryData(disableAnimations: reducedMotion),
    child: MaterialApp(
      theme: _theme,
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
}
