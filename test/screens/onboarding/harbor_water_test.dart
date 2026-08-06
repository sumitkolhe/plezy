import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/screens/onboarding/widgets/harbor_water.dart';

void main() {
  testWidgets('the swell keeps its phase across a route change', (tester) async {
    // The splash and the onboarding flow are separate routes, so each mounts
    // its own HarborWater. The phase has to come from somewhere that outlives
    // both, or the water visibly restarts from flat at the hand-over — which is
    // the one thing it exists to avoid.
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: HarborWater())));
    await tester.pump(const Duration(milliseconds: 400));
    final beforeTeardown = HarborWater.phaseSeconds;

    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: SizedBox.shrink())));
    await tester.pump(const Duration(milliseconds: 400));

    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: HarborWater())));
    await tester.pump();

    expect(
      HarborWater.phaseSeconds,
      greaterThan(beforeTeardown),
      reason: 'a fresh instance must pick the tide up where the last one left it, not from zero',
    );
  });
}
