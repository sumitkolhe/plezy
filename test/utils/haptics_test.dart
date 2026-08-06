import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/services/settings_service.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/widgets/app_menu.dart';
import 'package:harbor/utils/haptics.dart';
import 'package:harbor/widgets/media_card.dart';

import '../test_helpers/media_items.dart';
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
        theme: monoTheme(MonoPalette.dark),
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
        theme: monoTheme(MonoPalette.dark),
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

  testWidgets('a media card ticks even though it draws no ink', (tester) async {
    await SettingsService.instance.write(SettingsService.hapticFeedback, true);
    var taps = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: monoTheme(MonoPalette.dark),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 120,
              height: 180,
              child: MediaCard(
                item: testMediaItem(id: 'm1', title: 'Poster'),
                onTap: () => taps++,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byType(MediaCard));
    await tester.pump();

    expect(taps, 1);
    expect(calls, ['HapticFeedbackType.selectionClick'], reason: 'the card has no InkWell to route through');
  });

  testWidgets('a long press asks for the platform effect, not the tick', (tester) async {
    await SettingsService.instance.write(SettingsService.hapticFeedback, true);
    var menus = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: monoTheme(MonoPalette.dark),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 120,
              height: 180,
              child: MediaCard(
                item: testMediaItem(id: 'm1', title: 'Poster'),
                onTap: () {},
                onLongPress: () => menus++,
              ),
            ),
          ),
        ),
      ),
    );

    await tester.longPress(find.byType(MediaCard));
    await tester.pump();

    expect(menus, 1, reason: 'the menu still opens');
    // vibrate is Android's LONG_PRESS constant — firmer than a selection tick.
    expect(calls, contains('vibrate'));
    expect(calls, isNot(contains('HapticFeedbackType.selectionClick')));
  });

  testWidgets('a menu row draws ink, so it ripples and ticks like every other row', (tester) async {
    await SettingsService.instance.write(SettingsService.hapticFeedback, true);
    var picked = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: monoTheme(MonoPalette.dark),
        home: Scaffold(
          body: AppMenuList<String>(
            entries: [AppMenuItem<String>(value: 'play', label: 'Play')],
            onSelected: (_) => picked++,
          ),
        ),
      ),
    );

    // The row was a bare GestureDetector; without an ink surface neither the
    // ripple nor the theme-level haptic could reach it.
    expect(find.byType(InkWell), findsOneWidget);

    await tester.tap(find.text('Play'));
    await tester.pump();

    expect(picked, 1);
    expect(calls, ['HapticFeedbackType.selectionClick']);
  });

  test('the platform is never asked while the setting is off', () async {
    await SettingsService.instance.write(SettingsService.hapticFeedback, false);

    Haptics.selection();
    await Future<void>.delayed(Duration.zero);

    expect(calls, isEmpty);
  });
}
