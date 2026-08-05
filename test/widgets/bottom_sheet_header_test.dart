import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:harbor/widgets/bottom_sheet_header.dart';

void main() {
  testWidgets('a header with no title still draws its action', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: BottomSheetHeader(action: Text('3 tracks'))),
      ),
    );

    expect(find.text('3 tracks'), findsOneWidget);
  });

  testWidgets('back arrow aligns with regular leading icons', (tester) async {
    var backPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              BottomSheetHeader(title: 'Back', onBack: () => backPressed = true),
              const BottomSheetHeader(title: 'Icon', icon: PhosphorIcons.funnel),
            ],
          ),
        ),
      ),
    );

    final backArrow = find.byWidgetPredicate((widget) => widget is Icon && widget.icon == PhosphorIcons.arrowLeft);
    final regularIcon = find.byWidgetPredicate((widget) => widget is Icon && widget.icon == PhosphorIcons.funnel);

    expect(backArrow, findsOneWidget);
    expect(regularIcon, findsOneWidget);
    expect(tester.getTopLeft(backArrow).dx, tester.getTopLeft(regularIcon).dx);
    expect(tester.getTopLeft(find.text('Back')).dx, tester.getTopLeft(find.text('Icon')).dx);

    await tester.tapAt(tester.getCenter(backArrow) + const Offset(28, 0));
    expect(backPressed, isTrue);
  });

  testWidgets('a header offers no close button, whatever else it carries', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              const BottomSheetHeader(title: 'Plain'),
              const BottomSheetHeader(title: 'Icon', icon: PhosphorIcons.funnel),
              BottomSheetHeader(title: 'Back', onBack: () {}),
              const BottomSheetHeader(title: 'Action', action: Text('Clear')),
            ],
          ),
        ),
      ),
    );

    // The drag handle, the scrim and Back already dismiss a sheet.
    expect(find.byWidgetPredicate((w) => w is Icon && w.icon == PhosphorIcons.x), findsNothing);
  });

  testWidgets('every header is the same height and puts its title on one inset', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              const BottomSheetHeader(title: 'Plain'),
              const BottomSheetHeader(title: 'Icon', icon: PhosphorIcons.funnel),
              BottomSheetHeader(title: 'Back', onBack: () {}),
              const BottomSheetHeader(title: 'Action', action: Text('Clear')),
            ],
          ),
        ),
      ),
    );

    double height(String title) =>
        tester.getRect(find.ancestor(of: find.text(title), matching: find.byType(Padding)).first).height;

    for (final title in ['Icon', 'Back', 'Action']) {
      expect(height(title), height('Plain'), reason: '$title header should not be taller');
    }
    // A leading icon shifts the title, but only ever by the same icon and gap.
    expect(tester.getTopLeft(find.text('Plain')).dx, 16);
    expect(tester.getTopLeft(find.text('Back')).dx, tester.getTopLeft(find.text('Icon')).dx);
  });
}
