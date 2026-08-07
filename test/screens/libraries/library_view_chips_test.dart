import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/media/library_view.dart';
import 'package:harbor/screens/libraries/library_selection.dart';
import 'package:harbor/screens/libraries/library_view_chips.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';

const _key = 'srv:lib';
const _unwatched = LibraryView(name: 'Unwatched', filters: {'unwatched': '1'});
const _kids = LibraryView(name: 'Kids', filters: {'genre': '10751'});

void main() {
  setUpAll(() => LocaleSettings.setLocaleSync(AppLocale.en));

  late List<LibrarySelection> selected;
  late List<LibraryView> edited;
  late int created;

  Future<void> pump(
    WidgetTester tester, {
    required LibrarySelection? selection,
    List<LibraryView> views = const [],
    bool offersMissing = false,
  }) async {
    selected = [];
    edited = [];
    created = 0;
    await tester.pumpWidget(
      MaterialApp(
        theme: monoTheme(MonoPalette.dark),
        home: Scaffold(
          body: LibraryViewChips(
            libraryGlobalKey: _key,
            selection: selection,
            views: views,
            offersMissing: offersMissing,
            onSelect: selected.add,
            onEdit: edited.add,
            onCreate: () => created++,
          ),
        ),
      ),
    );
  }

  testWidgets('Media is always offered and Missing only when an *arr tracks the library', (tester) async {
    await pump(tester, selection: LibrarySelection.library(_key));
    expect(find.text(t.libraries.views.allMedia), findsOneWidget);
    expect(find.text(t.libraries.tabs.missing), findsNothing);

    await pump(tester, selection: LibrarySelection.library(_key), offersMissing: true);
    expect(find.text(t.libraries.tabs.missing), findsOneWidget);
  });

  testWidgets('every saved view gets a chip, and choosing one reports it', (tester) async {
    await pump(tester, selection: LibrarySelection.library(_key), views: const [_unwatched, _kids]);
    expect(find.text('Unwatched'), findsOneWidget);
    expect(find.text('Kids'), findsOneWidget);

    await tester.tap(find.text('Kids'));
    expect(selected.single, LibrarySelection.view(_key, _kids));
    expect(edited, isEmpty, reason: 'a chip that is not showing switches to it rather than editing it');
  });

  testWidgets('the chip already showing opens for editing instead of reselecting', (tester) async {
    await pump(tester, selection: LibrarySelection.view(_key, _unwatched), views: const [_unwatched]);

    await tester.tap(find.text('Unwatched'));
    expect(edited.single.name, 'Unwatched');
    expect(selected, isEmpty);
  });

  testWidgets('New asks for a view rather than selecting one', (tester) async {
    await pump(tester, selection: LibrarySelection.library(_key));

    await tester.tap(find.text(t.libraries.views.newView));
    expect(created, 1);
    expect(selected, isEmpty);
  });

  testWidgets('nothing is marked selected before a selection resolves', (tester) async {
    await pump(tester, selection: null, views: const [_unwatched], offersMissing: true);
    for (final chip in tester.widgetList<FilterChip>(find.byType(FilterChip))) {
      expect(chip.selected, isFalse);
    }
  });

  testWidgets('the selected view chip says it can be opened', (tester) async {
    await pump(tester, selection: LibrarySelection.view(_key, _unwatched), views: const [_unwatched, _kids]);

    // Without the caret, the second tap that opens the editor is a secret.
    expect(
      find.descendant(of: find.widgetWithText(FilterChip, 'Unwatched'), matching: find.byType(Icon)),
      findsOneWidget,
    );
    expect(find.descendant(of: find.widgetWithText(FilterChip, 'Kids'), matching: find.byType(Icon)), findsNothing);
  });
}
