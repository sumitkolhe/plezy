import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';
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

Future<void> pump(
  WidgetTester tester,
  List<MediaItem> list, {
  int selected = 0,
  ValueChanged<int>? onSelected,
}) {
  return tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: monoTheme(dark: true),
        home: Scaffold(
          body: Center(
            child: SeasonPickerChip(seasons: list, selectedIndex: selected, onSelected: onSelected ?? (_) {}),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('states which season is showing without needing a tap', (tester) async {
    await pump(tester, seasons(6), selected: 3);
    expect(find.text('Season 4'), findsOneWidget);
  });

  testWidgets('a single season is labelled but not offered as a choice', (tester) async {
    await pump(tester, seasons(1));

    expect(find.text('Season 1'), findsOneWidget);
    expect(tester.widget<InkWell>(find.byType(InkWell)).onTap, isNull);
    expect(find.byIcon(PhosphorIconsDuotone.caretDown), findsNothing);
  });

  testWidgets('collapses when the show reports no seasons at all', (tester) async {
    await pump(tester, const []);
    expect(find.byType(InkWell), findsNothing);
  });

  testWidgets('opens the full list in a sheet and reports the pick', (tester) async {
    int? picked;
    await pump(tester, seasons(24), onSelected: (index) => picked = index);

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();

    expect(find.byType(FocusableListTile), findsWidgets);
    // The sheet counts what the chip cannot: 24 seasons of 10 episodes.
    expect(find.text(t.explore.episodeCount(n: 240)), findsOneWidget);

    await tester.tap(find.text('Season 3'));
    await tester.pumpAndSettle();
    expect(picked, 2);
  });

  testWidgets('re-picking the season already showing reports nothing', (tester) async {
    var calls = 0;
    await pump(tester, seasons(4), selected: 1, onSelected: (_) => calls++);

    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Season 2').last);
    await tester.pumpAndSettle();

    expect(calls, 0);
  });

  testWidgets('numbering follows the server, not the position in the list', (tester) async {
    await pump(tester, seasons(3, from: 7), selected: 0);
    expect(find.text('Season 7'), findsOneWidget);
  });

  testWidgets('a season with no title of its own falls back to its number', (tester) async {
    final untitled = [
      testMediaItem(id: 's-2', kind: MediaKind.season, index: 2),
      testMediaItem(id: 's-3', kind: MediaKind.season, index: 3),
    ];
    await pump(tester, untitled, selected: 1);
    expect(find.text(t.common.seasonNumber(number: '3')), findsOneWidget);
  });

  testWidgets('a selected index past the end of the list still renders', (tester) async {
    await pump(tester, seasons(2), selected: 9);
    expect(find.text('Season 2'), findsOneWidget);
  });
}
