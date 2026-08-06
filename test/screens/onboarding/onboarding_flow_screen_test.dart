import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/screens/onboarding/onboarding_flow_screen.dart';
import 'package:harbor/screens/onboarding/steps/intro_step.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';

/// The mark rocks for as long as the flow is on screen, so nothing here can
/// ever settle — every wait is an explicit pump instead.
Future<void> _settle(WidgetTester tester, [Duration by = const Duration(milliseconds: 900)]) async {
  await tester.pump();
  await tester.pump(by);
}

Future<void> _pump(WidgetTester tester, {bool startAtSplash = false, String? clipboard}) async {
  // The intro lays its vertical rhythm out for a phone; the default 800x600
  // test surface pushes the action below the fold and taps miss it.
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = const Size(390, 844);
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);

  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: monoTheme(MonoPalette.dark),
        home: OnboardingFlowScreen(startAtSplash: startAtSplash, clipboardReader: () async => clipboard),
      ),
    ),
  );
  await _settle(tester);
}

void main() {
  testWidgets('the splash holds, then becomes the connect screen without navigating', (tester) async {
    await _pump(tester, startAtSplash: true);

    expect(find.text('Harbor'), findsOneWidget);
    expect(find.text(t.onboarding.tagline.toUpperCase()), findsOneWidget);
    expect(find.text(t.onboarding.addServer), findsNothing);

    await tester.pump(IntroStep.splashHold);
    await _settle(tester);

    // Same widget throughout: the splash morphed rather than handing over.
    expect(find.byType(IntroStep), findsOneWidget);
    expect(find.text(t.onboarding.connectTitle), findsOneWidget);
    expect(find.text(t.onboarding.addServer), findsOneWidget);
  });

  testWidgets('the splash can be skipped rather than waited out', (tester) async {
    await _pump(tester, startAtSplash: true);
    // Both halves of the morph are in the tree throughout, cross-faded by
    // opacity, so the connect copy is findable even here. The action arrives
    // only once the morph settles, which makes it the honest probe.
    expect(find.text(t.onboarding.addServer), findsNothing);

    // The whole surface is the target; there is no labelled control to find.
    await tester.tapAt(tester.getCenter(find.byType(IntroStep)));
    await _settle(tester);

    expect(find.text(t.onboarding.addServer), findsOneWidget);
  });

  testWidgets('the address form opens in place and states its defaults', (tester) async {
    await _pump(tester);

    expect(find.byType(TextField), findsNothing);
    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text(t.onboarding.addressDefaultsHint), findsOneWidget);
    expect(find.text(t.auth.connectToJellyfin), findsOneWidget);
    // Still the same surface, not a pushed page.
    expect(find.byType(IntroStep), findsOneWidget);
  });

  testWidgets('an address on the clipboard is offered rather than typed again', (tester) async {
    await _pump(tester, clipboard: '192.168.1.77:8096');
    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);

    final offer = find.text(t.onboarding.pasteAddress(address: '192.168.1.77:8096'));
    expect(offer, findsOneWidget);

    await tester.tap(offer);
    await _settle(tester);

    expect(tester.widget<TextField>(find.byType(TextField)).controller?.text, '192.168.1.77:8096');
    expect(offer, findsNothing, reason: 'the offer has been taken, so it stops being offered');
  });

  testWidgets('clipboard junk is not offered as an address', (tester) async {
    await _pump(tester, clipboard: 'the quick brown fox jumped');
    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);

    expect(find.textContaining('quick brown fox'), findsNothing);
    expect(find.text(t.onboarding.addressDefaultsHint), findsOneWidget);
  });

  testWidgets('an empty address is refused without leaving the step', (tester) async {
    await _pump(tester);
    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);

    await tester.tap(find.text(t.auth.connectToJellyfin));
    await _settle(tester);

    expect(find.text(t.onboarding.addressRequired), findsOneWidget);
    expect(find.byType(IntroStep), findsOneWidget);
  });
}
