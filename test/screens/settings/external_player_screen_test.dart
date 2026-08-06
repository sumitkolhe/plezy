import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/focus/focusable_button.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/models/external_player_models.dart';
import 'package:harbor/screens/settings/external_player_screen.dart';
import 'package:harbor/services/settings_service.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/widgets/focusable_list_tile.dart';

import '../../test_helpers/prefs.dart';
import 'package:harbor/utils/platform_detector.dart';

void main() {
  late SettingsService settings;

  setUp(() async {
    resetSharedPreferencesForTest();
    SettingsService.resetForTesting();
    KnownPlayers.resetForTesting();
    KnownPlayers.probe = const _AllPlayersInstalled();
    PlatformDetector.debugSetSupportsExternalPlayersOverride(true);
    settings = await SettingsService.getInstance();
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  tearDown(() {
    SettingsService.resetForTesting();
    KnownPlayers.resetForTesting();
    PlatformDetector.debugSetSupportsExternalPlayersOverride(null);
  });

  testWidgets('only custom players expose a focusable delete action', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(1000, 1400);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);

    final customPlayer = ExternalPlayer.custom(
      id: 'custom-test-player',
      name: 'Custom Test Player',
      value: 'custom-player',
      type: CustomPlayerType.command,
    );
    await settings.write(SettingsService.useExternalPlayer, true);
    await settings.write(SettingsService.customExternalPlayers, [customPlayer]);
    await settings.write(SettingsService.selectedExternalPlayer, customPlayer);

    await tester.pumpWidget(MaterialApp(theme: monoTheme(MonoPalette.dark), home: const ExternalPlayerScreen()));
    await tester.pumpAndSettle();

    for (final player in await KnownPlayers.getForCurrentPlatform()) {
      final title = player.id == KnownPlayers.systemDefault.id ? 'System Default' : player.name;
      final row = find.widgetWithText(FocusableListTile, title);
      expect(row, findsOneWidget);
      expect(find.descendant(of: row, matching: find.byType(FocusableButton)), findsNothing);
      expect(find.descendant(of: row, matching: find.byType(IconButton)), findsNothing);
    }

    final customRow = find.widgetWithText(FocusableListTile, customPlayer.name);
    expect(customRow, findsOneWidget);
    final focusableDelete = find.descendant(of: customRow, matching: find.byType(FocusableButton));
    final deleteControl = find.descendant(of: customRow, matching: find.byType(IconButton));
    expect(focusableDelete, findsOneWidget);
    expect(deleteControl, findsOneWidget);
    expect(tester.widget<FocusableButton>(focusableDelete).onPressed, isNotNull);

    await tester.tap(deleteControl);
    await tester.pumpAndSettle();

    expect(settings.read(SettingsService.customExternalPlayers), isEmpty);
    expect(settings.read(SettingsService.selectedExternalPlayer), KnownPlayers.systemDefault);
    expect(find.text(customPlayer.name), findsNothing);
  });
}

/// Reports every player as installed so the screen renders the full platform
/// list regardless of what the host running the suite happens to have.
class _AllPlayersInstalled extends PlayerInstallProbe {
  const _AllPlayersInstalled();

  @override
  Future<ProcessResult> run(String executable, List<String> arguments) async => ProcessResult(0, 0, '', '');

  @override
  Future<bool> applicationInstalled(String bundleId) async => true;

  @override
  Future<bool> fileExists(String path) async => true;

  @override
  Future<bool> schemeHasHandler(String scheme) async => true;
}
