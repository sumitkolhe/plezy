import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/focus/dpad_navigator.dart';
import 'package:harbor/focus/input_mode_tracker.dart';
import 'package:harbor/database/app_database.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_library.dart';
import 'package:harbor/providers/hidden_libraries_provider.dart';
import 'package:harbor/providers/libraries_provider.dart';
import 'package:harbor/providers/multi_server_provider.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/services/multi_server_manager.dart';
import 'package:harbor/utils/platform_detector.dart';
import 'package:harbor/widgets/library_management_sheet.dart';
import 'package:harbor/widgets/overlay_sheet.dart';
import 'package:provider/provider.dart';

import '../test_helpers/multi_server_fixtures.dart';

import '../test_helpers/prefs.dart';

const _qualifiedLibrary = MediaLibrary(
  id: 'shared-section',
  backend: MediaBackend.jellyfin,
  title: 'Movies',
  kind: MediaKind.movie,
  serverId: 'server-a',
);

Future<({int Function() selects, int Function() backs})> _pumpLibraryManagementLauncher(
  WidgetTester tester, {
  MediaLibrary library = _qualifiedLibrary,
  MultiServerProvider? multiServerProvider,
}) async {
  final librariesProvider = LibrariesProvider();
  await librariesProvider.updateLibraryOrder([library]);
  addTearDown(librariesProvider.dispose);

  final hiddenLibrariesProvider = HiddenLibrariesProvider();
  await hiddenLibrariesProvider.ensureInitialized();
  addTearDown(hiddenLibrariesProvider.dispose);

  final fallbackManager = multiServerProvider == null ? MultiServerManager() : null;
  final effectiveMultiServerProvider = multiServerProvider ?? testMultiServerProvider(fallbackManager!);
  if (fallbackManager != null) {
    addTearDown(() {
      effectiveMultiServerProvider.dispose();
      fallbackManager.dispose();
    });
  }

  var underlyingSelects = 0;
  var underlyingBacks = 0;

  await tester.pumpWidget(
    TranslationProvider(
      child: InputModeTracker(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<LibrariesProvider>.value(value: librariesProvider),
            ChangeNotifierProvider<HiddenLibrariesProvider>.value(value: hiddenLibrariesProvider),
            ChangeNotifierProvider<MultiServerProvider>.value(value: effectiveMultiServerProvider),
          ],
          child: MaterialApp(
            theme: monoTheme(dark: true),
            home: Focus(
              onKeyEvent: (_, event) {
                if (event is KeyDownEvent && event.logicalKey.isSelectKey) underlyingSelects++;
                if (event is KeyDownEvent && event.logicalKey.isBackKey) underlyingBacks++;
                return KeyEventResult.ignored;
              },
              child: OverlaySheetHost(
                child: Scaffold(
                  body: Center(
                    child: Builder(
                      builder: (context) => ElevatedButton(
                        autofocus: true,
                        onPressed: () => showLibraryManagementSheet(context),
                        child: const Text('Open library management'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();

  return (selects: () => underlyingSelects, backs: () => underlyingBacks);
}

Future<void> _openRefreshConfirmation(WidgetTester tester) async {
  // Switch from the desktop pointer default to keyboard mode, then activate the
  // focused launcher using the same key path as a keyboard/remote user.
  await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
  await tester.pump();
  await tester.sendKeyEvent(LogicalKeyboardKey.enter);
  await tester.pumpAndSettle();

  expect(find.text(t.libraries.manageLibraries), findsOneWidget);

  // The sheet owns one focus node for its virtual row/column navigation. Move
  // from the row to its options column and open the real AppMenuSheet.
  await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
  await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
  await tester.sendKeyEvent(LogicalKeyboardKey.enter);
  await tester.pumpAndSettle();

  expect(find.text(t.libraries.refreshMetadata), findsOneWidget);

  // The hosted menu focuses its first entry in keyboard mode. Selecting it
  // must close the whole hosted sheet before presenting the confirmation.
  await tester.sendKeyEvent(LogicalKeyboardKey.enter);
  await tester.pumpAndSettle();

  expect(find.byType(AlertDialog), findsOneWidget);
  expect(find.text(t.libraries.manageLibraries), findsNothing);
  // The confirmation reuses the action's own label as its title, so the label
  // being on screen no longer distinguishes menu from dialog — sheet closure
  // is asserted by the launcher title above and the open-sheet count below.
  expect(OverlaySheetController.openSheetCount.value, 0);

  final dialogElement = tester.element(find.byType(AlertDialog));
  final primaryFocusContext = FocusManager.instance.primaryFocus?.context;
  var dialogOwnsPrimaryFocus = false;
  primaryFocusContext?.visitAncestorElements((element) {
    if (identical(element, dialogElement)) {
      dialogOwnsPrimaryFocus = true;
      return false;
    }
    return true;
  });
  expect(dialogOwnsPrimaryFocus, isTrue);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AppDatabase database;

  setUp(() {
    resetSharedPreferencesForTest();
    LocaleSettings.setLocaleSync(AppLocale.en);
    TvDetectionService.debugSetAppleTVOverride(false);
    TvDetectionService.setForceTVSync(false);
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() {
    TvDetectionService.debugSetAppleTVOverride(null);
    TvDetectionService.setForceTVSync(false);
    FocusManager.instance.highlightStrategy = FocusHighlightStrategy.automatic;
  });
  tearDown(() => database.close());

  for (final interaction in [
    (name: 'Enter', key: LogicalKeyboardKey.enter),
    (name: 'Back', key: LogicalKeyboardKey.escape),
  ]) {
    testWidgets('${interaction.name} is handled by confirmation after the hosted action sheet closes', (tester) async {
      final underlyingActions = await _pumpLibraryManagementLauncher(tester);
      await _openRefreshConfirmation(tester);

      // Ignore launcher/menu navigation. From this point onward, neither key
      // may reach the underlying page while the modal confirmation has focus.
      final selectsBeforeDialogAction = underlyingActions.selects();
      final backsBeforeDialogAction = underlyingActions.backs();

      await tester.sendKeyEvent(interaction.key);
      await tester.pumpAndSettle();

      expect(find.byType(AlertDialog), findsNothing);
      expect(find.text('Open library management'), findsOneWidget);
      expect(underlyingActions.selects(), selectsBeforeDialogAction);
      expect(underlyingActions.backs(), backsBeforeDialogAction);
      expect(OverlaySheetController.openSheetCount.value, 0);
    });
  }
}
