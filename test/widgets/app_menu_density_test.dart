import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_library.dart';
import 'package:harbor/screens/libraries/library_quick_picker_sheet.dart';
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
  entries: [AppMenuItem<String>(value: 'a', label: label, icon: PhosphorIcons.play)],
  onSelected: (_) {},
);

double _rowHeight(WidgetTester tester, String label) =>
    tester.getRect(find.ancestor(of: find.text(label), matching: find.byType(InkWell)).first).height;

void main() {
  testWidgets('a sheet row is the same height as the list row it sits beside', (tester) async {
    await _pump(
      tester,
      Column(
        children: [
          _menu(AppMenuDensity.touch, 'Play'),
          const FocusableListTile(listItemMetrics: true, title: Text('List row')),
        ],
      ),
    );

    final listRow = tester.getRect(find.ancestor(of: find.text('List row'), matching: find.byType(ListTile)).first);
    expect(_rowHeight(tester, 'Play'), listRow.height);
    expect(_rowHeight(tester, 'Play'), greaterThanOrEqualTo(48));
  });

  testWidgets('a pointer row stays denser, since a cursor needs no finger target', (tester) async {
    await _pump(tester, _menu(AppMenuDensity.pointer, 'Play'));

    expect(_rowHeight(tester, 'Play'), 40);
    expect(_rowHeight(tester, 'Play'), lessThan(56));
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

  testWidgets('a menu sheet titles and opens its list on the same metrics as a picker drawer', (tester) async {
    await _pump(
      tester,
      AppMenuSheet<String>(
        title: 'Sheet title',
        entries: [AppMenuItem<String>(value: 'a', label: 'First', icon: PhosphorIcons.play)],
        onSelected: (_) {},
      ),
    );

    final title = tester.getRect(find.text('Sheet title'));
    final firstRow = tester.getRect(find.ancestor(of: find.text('First'), matching: find.byType(InkWell)).first);

    // What library_quick_picker_sheet uses: a 16dp title inset, 8dp to the list.
    expect(title.left, 16);
    expect(firstRow.top - title.bottom, 8);
  });

  testWidgets('a switch row matches the plain one, so a settings list can mix them', (tester) async {
    await _pump(
      tester,
      Column(
        children: [
          const FocusableListTile(listItemMetrics: true, title: Text('Plain')),
          FocusableSwitchListTile(listItemMetrics: true, value: false, onChanged: (_) {}, title: const Text('Switch')),
        ],
      ),
    );

    double height(String label) =>
        tester.getRect(find.ancestor(of: find.text(label), matching: find.byType(ListTile)).first).height;

    expect(height('Switch'), height('Plain'));
  });

  testWidgets('a drawer row is the menu row, not a lookalike at the same height', (tester) async {
    await _pump(tester, _menu(AppMenuDensity.touch, 'Menu row'));
    final menu = tester.renderObject<RenderParagraph>(find.text('Menu row')).text.style;

    await _pump(
      tester,
      LibraryQuickPickerSheet(
        libraries: const [MediaLibrary(id: '1', backend: MediaBackend.jellyfin, title: 'Movies', kind: MediaKind.movie)],
        selectedLibraryKey: null,
        isLoading: false,
        groupByServer: false,
        emptyMessage: 'none',
        onSelected: (_) {},
      ),
    );
    final drawer = tester.renderObject<RenderParagraph>(find.text('Movies')).text.style;

    // ListTile resolves its title to bodyLarge, which read as magnified beside
    // the menu's bodyMedium.
    expect(drawer?.fontSize, menu?.fontSize);
    expect(find.byType(AppMenuItemTile<String>), findsOneWidget);
  });

  testWidgets('the current row is marked by its check, not by a fill behind it', (tester) async {
    await _pump(
      tester,
      AppMenuList<String>(
        entries: [
          AppMenuItem<String>(value: 'a', label: 'Plain', icon: PhosphorIcons.play),
          AppMenuItem<String>(value: 'b', label: 'Current', icon: PhosphorIcons.play, selected: true),
        ],
        onSelected: (_) {},
      ),
    );

    Color? fill(String label) {
      final container = tester.widget<AnimatedContainer>(
        find.descendant(
          of: find.ancestor(of: find.text(label), matching: find.byType(AppMenuItemTile<String>)),
          matching: find.byType(AnimatedContainer),
        ),
      );
      return (container.decoration as BoxDecoration?)?.color;
    }

    expect(fill('Current'), fill('Plain'));
    expect(find.byWidgetPredicate((w) => w is Icon && w.icon == PhosphorIcons.check), findsOneWidget);
  });

  testWidgets('a row with secondary text is no taller than one without', (tester) async {
    await _pump(
      tester,
      AppMenuList<String>(
        entries: [
          AppMenuItem<String>(value: 'a', label: 'Plain', icon: PhosphorIcons.play),
          AppMenuItem<String>(value: 'b', label: 'Detailed', subtitle: 'secondary', icon: PhosphorIcons.play),
        ],
        onSelected: (_) {},
      ),
    );

    // Label plus secondary line measure 36dp together, so both fit one height.
    expect(_rowHeight(tester, 'Detailed'), _rowHeight(tester, 'Plain'));
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
                for (final l in labels) AppMenuItem<String>(value: l, label: l, icon: PhosphorIcons.play),
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
