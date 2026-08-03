import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:harbor/widgets/app_menu.dart';
import 'package:harbor/widgets/focusable_list_tile.dart';
import 'package:harbor/widgets/overlay_sheet.dart';

Future<void> _pump(WidgetTester tester, Widget body) => tester.pumpWidget(
  MaterialApp(theme: monoTheme(dark: true), home: Scaffold(body: body)),
);

Widget _menu(AppMenuDensity density, String label) => AppMenuList<String>(
  density: density,
  entries: [AppMenuItem<String>(value: 'a', label: label, icon: PhosphorIconsDuotone.play)],
  onSelected: (_) {},
);

double _rowHeight(WidgetTester tester, String label) =>
    tester.getRect(find.ancestor(of: find.text(label), matching: find.byType(InkWell)).first).height;

void main() {
  testWidgets('a sheet row clears the 48dp touch target and reaches the list-item height', (tester) async {
    await _pump(tester, _menu(AppMenuDensity.touch, 'Play'));

    // 56 pill inside a 1pt margin either side.
    expect(_rowHeight(tester, 'Play'), 58);
    expect(_rowHeight(tester, 'Play'), greaterThanOrEqualTo(48));
  });

  testWidgets('a pointer row stays denser, since a cursor needs no finger target', (tester) async {
    await _pump(tester, _menu(AppMenuDensity.pointer, 'Play'));

    expect(_rowHeight(tester, 'Play'), 42);
    expect(_rowHeight(tester, 'Play'), lessThan(58));
  });

  testWidgets('a menu row and a list row put their text on the same inset', (tester) async {
    await _pump(
      tester,
      Column(
        children: [
          _menu(AppMenuDensity.touch, 'Menu row'),
          const FocusableListTile(
            listItemMetrics: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            leading: Icon(Icons.folder),
            title: Text('List row'),
          ),
        ],
      ),
    );

    // 16 to the leading icon, 24 of icon, 16 to the text.
    expect(tester.getRect(find.text('Menu row')).left, 56);
    expect(tester.getRect(find.text('List row')).left, 56);
  });

  testWidgets('listItemMetrics gives a one-line row the M3 list height', (tester) async {
    await _pump(
      tester,
      const Column(
        children: [
          FocusableListTile(listItemMetrics: true, title: Text('Roomy')),
          FocusableListTile(title: Text('Compact')),
        ],
      ),
    );

    final roomy = tester.getRect(find.ancestor(of: find.text('Roomy'), matching: find.byType(ListTile)).first);
    final compact = tester.getRect(find.ancestor(of: find.text('Compact'), matching: find.byType(ListTile)).first);

    expect(roomy.height, 56);
    expect(compact.height, lessThan(roomy.height), reason: 'the default stays dense for scanned lists');
  });

  testWidgets('a full media menu stands without scrolling on a phone', (tester) async {
    tester.view.physicalSize = const Size(1440, 3120);
    tester.view.devicePixelRatio = 3.75;
    addTearDown(tester.view.reset);

    // Every action the movie menu offers, which is the longest one in the app.
    const labels = [
      'Play from Beginning',
      'Mark as Watched',
      'Mark as Unwatched',
      'View details',
      'Rate',
      'Edit...',
      'Play Version...',
      'File Info',
      'Play in External Player',
      'Download',
      'Delete from server',
    ];

    late BoxConstraints menuLimit;
    await _pump(
      tester,
      Builder(
        builder: (context) {
          menuLimit = OverlaySheetController.sheetConstraints(context, heightFraction: 0.9);
          return SingleChildScrollView(
            child: AppMenuSheet<String>(
              title: 'A Film With Quite A Long Title',
              entries: [
                for (final l in labels) AppMenuItem<String>(value: l, label: l, icon: PhosphorIconsDuotone.play),
              ],
              onSelected: (_) {},
            ),
          );
        },
      ),
    );

    final content = tester.getRect(find.byType(AppMenuSheet<String>)).height;
    expect(content, lessThanOrEqualTo(menuLimit.maxHeight));
    // And it would not have, on the default cap every other sheet uses.
    expect(content, greaterThan(OverlaySheetController.sheetConstraints(tester.element(find.byType(Scaffold))).maxHeight));
  });
}
