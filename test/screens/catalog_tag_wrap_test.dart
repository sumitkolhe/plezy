import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/screens/catalog_item_detail_screen.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/widgets/stat_chip.dart';

void main() {
  Future<void> pump(WidgetTester tester, List<String> labels, {double width = 320}) {
    return tester.pumpWidget(
      MaterialApp(
        theme: monoTheme(dark: true),
        home: Scaffold(
          body: Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: width,
              child: CatalogTagWrap(labels: labels),
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('shows every tag when they fit in two rows', (tester) async {
    await pump(tester, ['Action', 'Drama', 'Sci-Fi']);

    expect(find.byType(StatChip), findsNWidgets(3));
    expect(find.textContaining('+'), findsNothing);
  });

  testWidgets('clamps to two rows and counts what it hid', (tester) async {
    final labels = [for (var i = 0; i < 40; i++) 'Tag number $i'];
    await pump(tester, labels);

    final shown = tester.widgetList<StatChip>(find.byType(StatChip)).length - 1;
    expect(shown, lessThan(labels.length));
    expect(find.text('+${labels.length - shown}'), findsOneWidget);

    // Two rows, so exactly two distinct vertical offsets.
    final tops = {
      for (final chip in find.byType(StatChip).evaluate()) tester.getTopLeft(find.byWidget(chip.widget)).dy,
    };
    expect(tops, hasLength(2));
  });

  testWidgets('the count pill reveals the rest', (tester) async {
    final labels = [for (var i = 0; i < 40; i++) 'Tag number $i'];
    await pump(tester, labels);

    await tester.tap(find.textContaining('+'));
    await tester.pumpAndSettle();

    expect(find.byType(StatChip), findsNWidgets(labels.length));
    expect(find.textContaining('+'), findsNothing);
  });
}
