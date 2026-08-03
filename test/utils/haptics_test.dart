import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/services/settings_service.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/utils/haptics.dart';

import '../test_helpers/prefs.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final calls = <String>[];

  setUp(() async {
    calls.clear();
    resetSharedPreferencesForTest();
    SettingsService.resetForTesting();
    await SettingsService.getInstance();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      (call) async {
        if (call.method == 'HapticFeedback.vibrate') calls.add(call.arguments as String? ?? 'vibrate');
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      SystemChannels.platform,
      null,
    );
  });

  test('a selection asks the platform for the light tick', () async {
    await SettingsService.instance.write(SettingsService.hapticFeedback, true);

    Haptics.selection();
    await Future<void>.delayed(Duration.zero);

    expect(calls, ['HapticFeedbackType.selectionClick']);
  });

  testWidgets('any Material press ticks, through the theme rather than a call site', (tester) async {
    await SettingsService.instance.write(SettingsService.hapticFeedback, true);

    await tester.pumpWidget(
      MaterialApp(
        theme: monoTheme(dark: true),
        home: Scaffold(
          body: Center(
            child: FilledButton(onPressed: () {}, child: const Text('Play')),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Play'));
    await tester.pump();

    expect(calls, ['HapticFeedbackType.selectionClick']);
  });

  testWidgets('a press stays silent while the setting is off', (tester) async {
    await SettingsService.instance.write(SettingsService.hapticFeedback, false);

    await tester.pumpWidget(
      MaterialApp(
        theme: monoTheme(dark: true),
        home: Scaffold(
          body: Center(
            child: FilledButton(onPressed: () {}, child: const Text('Play')),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Play'));
    await tester.pump();

    expect(calls, isEmpty);
  });

  test('the platform is never asked while the setting is off', () async {
    await SettingsService.instance.write(SettingsService.hapticFeedback, false);

    Haptics.selection();
    await Future<void>.delayed(Duration.zero);

    expect(calls, isEmpty);
  });
}
