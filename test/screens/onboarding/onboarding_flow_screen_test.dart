import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/screens/onboarding/onboarding_flow_screen.dart';
import 'package:harbor/screens/onboarding/steps/connect_step.dart';
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

Future<void> _pump(WidgetTester tester, {required Future<List<DiscoveredJellyfinServer>> Function() discovery}) async {
  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: monoTheme(dark: true),
        home: OnboardingFlowScreen(lanDiscoveryFactory: discovery),
      ),
    ),
  );
  await _settle(tester);
}

final _servers = [
  DiscoveredJellyfinServer(address: 'http://192.168.1.10:8096', id: 'a', name: 'Living room NAS'),
  DiscoveredJellyfinServer(address: 'http://192.168.1.42:8096', id: 'b', name: 'Study'),
];

void main() {
  testWidgets('opens folded to a single action, and expands in place', (tester) async {
    await _pump(tester, discovery: () async => const []);

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
  });

  testWidgets('an empty address is refused without leaving the step', (tester) async {
    await _pump(tester, discovery: () async => const []);
    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);

    await tester.tap(find.text(t.auth.connectToJellyfin));
    await _settle(tester);

    expect(find.text(t.onboarding.addressRequired), findsOneWidget);
    expect(find.byType(ConnectStep), findsOneWidget);
  });

  testWidgets('a network that answers puts its servers on the first screen', (tester) async {
    await _pump(tester, discovery: () async => _servers);

    // No button was pressed and no wait was shown to get here.
    expect(find.text('Living room NAS'), findsOneWidget);
    expect(find.text('Study'), findsOneWidget);
    expect(find.text(t.addServer.localServers.toUpperCase()), findsOneWidget);

    // Manual entry is still offered, one step down.
    expect(find.text(t.onboarding.addServer), findsOneWidget);
  });

  testWidgets('a silent network is never mentioned', (tester) async {
    await _pump(tester, discovery: () async => const []);

    // The step is exactly what it would be with no discovery at all: no empty
    // state, no retry, nothing saying a scan happened.
    expect(find.byType(ConnectStep), findsOneWidget);
    expect(find.text(t.onboarding.addServerHint), findsOneWidget);
    expect(find.byIcon(Icons.dns_outlined), findsNothing);
  });

  testWidgets('discovery failing is as quiet as discovery finding nothing', (tester) async {
    await _pump(tester, discovery: () async => throw const SocketException('no route to host'));

    expect(find.byType(ConnectStep), findsOneWidget);
    expect(find.text(t.onboarding.addServerHint), findsOneWidget);
  });

  testWidgets('the water is mounted once and survives expanding the form', (tester) async {
    await _pump(tester, discovery: () async => const []);
    final water = find.byType(HarborWater);
    expect(water, findsOneWidget);
    final before = tester.state(water);

    await tester.tap(find.text(t.onboarding.addServer));
    await _settle(tester);

    // Same State object, so the swell never restarted.
    expect(tester.state(water), same(before));
  });
}
