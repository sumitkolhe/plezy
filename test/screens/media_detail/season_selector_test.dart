import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/media/media_item.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/screens/media_detail/season_picker.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/widgets/focusable_list_tile.dart';

import '../../test_helpers/media_items.dart';

List<MediaItem> seasons(int count, {int from = 1}) => [
  for (var i = 0; i < count; i++)
    testMediaItem(
      id: 'season-${from + i}',
      kind: MediaKind.season,
      title: 'Season ${from + i}',
      index: from + i,
      leafCount: 10,
    ),
];

Future<void> pump(WidgetTester tester, List<MediaItem> list, {int selected = 0, double width = 390}) {
  return tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: monoTheme(dark: true),
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: width,
              child: SeasonSelector(seasons: list, selectedIndex: selected, onSelected: (_) {}),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('a single season gets no control — there is nothing to choose', (tester) async {
    await pump(tester, seasons(1));
    expect(find.byType(InkWell), findsNothing);
    expect(find.text('S1'), findsNothing);
  });

  testWidgets('a handful of seasons all fit, so the row does not scroll', (tester) async {
    await pump(tester, seasons(4));

    for (final label in ['S1', 'S2', 'S3', 'S4']) {
      expect(find.text(label), findsOneWidget);
    }
    final list = tester.widget<ListView>(find.byType(ListView));
    expect(list.physics, isA<NeverScrollableScrollPhysics>());
    // No escape hatch is offered when everything is already visible.
    expect(find.byIcon(Icons.list), findsNothing);
  });

  testWidgets('a long run scrolls and offers the full list as a sheet', (tester) async {
    await pump(tester, seasons(24));

    final list = tester.widget<ListView>(find.byType(ListView));
    expect(list.physics, isNot(isA<NeverScrollableScrollPhysics>()));

    // The trailing button is the only extra tap target beyond the pills.
    final buttons = find.byType(InkWell);
    expect(buttons, findsWidgets);
    await tester.tap(buttons.last);
    await tester.pumpAndSettle();
    // The sheet lists them vertically; only the first screenful is built.
    expect(find.byType(FocusableListTile), findsWidgets);
    expect(find.text('Season 1'), findsOneWidget);
  });

  testWidgets('a selected season far down the row is scrolled into view', (tester) async {
    await pump(tester, seasons(24), selected: 20);
    await tester.pumpAndSettle();

    final offset = tester.widget<ListView>(find.byType(ListView)).controller!.offset;
    expect(offset, greaterThan(0));
    expect(find.text('S21'), findsOneWidget);
  });

  testWidgets('numbering follows the server, not the position in the list', (tester) async {
    await pump(tester, seasons(3, from: 7));

    expect(find.text('S7'), findsOneWidget);
    expect(find.text('S9'), findsOneWidget);
    expect(find.text('S1'), findsNothing);
  });

  testWidgets('specials keep their name rather than becoming S0', (tester) async {
    final list = [
      testMediaItem(id: 'sp', kind: MediaKind.season, title: 'Specials', index: 0, leafCount: 3),
      ...seasons(2),
    ];
    await pump(tester, list);

    expect(find.text('Specials'), findsOneWidget);
    expect(find.text('S0'), findsNothing);
  });

  testWidgets('the selected season is reported to assistive tech', (tester) async {
    final handle = tester.ensureSemantics();
    await pump(tester, seasons(3), selected: 1);

    // Tristate, not bool: `none` would mean the pill never declared itself
    // selectable at all, which is a different failure from "not selected".
    expect(tester.getSemantics(find.text('S2')).flagsCollection.isSelected, Tristate.isTrue);
    expect(tester.getSemantics(find.text('S1')).flagsCollection.isSelected, Tristate.isFalse);
    handle.dispose();
  });

  testWidgets('tapping a pill reports its index', (tester) async {
    final picked = <int>[];
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: monoTheme(dark: true),
          home: Scaffold(
            body: SeasonSelector(seasons: seasons(3), selectedIndex: 0, onSelected: picked.add),
          ),
        ),
      ),
    );

    await tester.tap(find.text('S3'));
    await tester.pumpAndSettle();
    expect(picked, [2]);
  });
}
