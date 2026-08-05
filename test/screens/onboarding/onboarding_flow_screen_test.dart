import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/screens/onboarding/onboarding_flow_screen.dart';
import 'package:harbor/screens/onboarding/steps/connect_step.dart';
import 'package:harbor/screens/onboarding/steps/discover_step.dart';
import 'package:harbor/screens/onboarding/widgets/harbor_water.dart';
import 'package:harbor/services/jellyfin_lan_discovery_service.dart';
import 'package:harbor/theme/mono_theme.dart';

/// The water and the mark animate for as long as the flow is on screen, so
/// nothing here can ever settle — every wait is an explicit pump past the
/// 450ms entrance instead.
Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 600));
}

Future<void> _pump(WidgetTester tester, {Future<List<DiscoveredJellyfinServer>> Function()? discovery}) async {
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: monoTheme(dark: true),
        home: OnboardingFlowScreen(lanDiscoveryFactory: discovery),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('opens folded to a single action, and expands in place', (tester) async {
    await _pump(tester);

    expect(find.text(t.onboarding.addServer), findsOneWidget);
    expect(find.byType(TextField), findsNothing);
    expect(find.text(t.auth.connectToJellyfin), findsNothing);

    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);

    // Same step, not a new page: the heading never left.
    expect(find.byType(ConnectStep), findsOneWidget);
    expect(find.text(t.onboarding.connectTitle), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text(t.auth.connectToJellyfin), findsOneWidget);
    expect(find.text(t.onboarding.findServers), findsOneWidget);
  });

  testWidgets('an empty address is refused without leaving the step', (tester) async {
    await _pump(tester);
    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);

    await tester.tap(find.text(t.auth.connectToJellyfin));
    await _settle(tester);

    expect(find.text(t.onboarding.addressRequired), findsOneWidget);
    expect(find.byType(ConnectStep), findsOneWidget);
  });

  testWidgets('discovery lists what answered and can hand back to manual entry', (tester) async {
    await _pump(
      tester,
      discovery: () async => [
        DiscoveredJellyfinServer(address: 'http://192.168.1.10:8096', id: 'a', name: 'Living room NAS'),
        DiscoveredJellyfinServer(address: 'http://192.168.1.42:8096', id: 'b', name: 'Study'),
      ],
    );
    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);
    await tester.tap(find.text(t.onboarding.findServers));
    await _settle(tester);

    expect(find.byType(DiscoverStep), findsOneWidget);
    expect(find.text('Living room NAS'), findsOneWidget);
    expect(find.text('Study'), findsOneWidget);
    expect(find.text(t.onboarding.serversFound(n: 2)), findsOneWidget);

    await tester.tap(find.text(t.onboarding.enterAddressInstead));
    await _settle(tester);
    expect(find.byType(ConnectStep), findsOneWidget);
  });

  testWidgets('a silent network says so and offers a retry', (tester) async {
    await _pump(tester, discovery: () async => const []);
    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);
    await tester.tap(find.text(t.onboarding.findServers));
    await _settle(tester);

    expect(find.text(t.onboarding.noServersFound), findsOneWidget);
    expect(find.text(t.common.retry), findsOneWidget);
  });

  testWidgets('the water is mounted once and survives moving between steps', (tester) async {
    await _pump(tester, discovery: () async => const []);
    final water = find.byType(HarborWater);
    expect(water, findsOneWidget);
    final before = tester.state(water);

    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);
    await tester.tap(find.text(t.onboarding.findServers));
    await _settle(tester);

    // Same State object, so the swell never restarted.
    expect(tester.state(water), same(before));
  });
}
