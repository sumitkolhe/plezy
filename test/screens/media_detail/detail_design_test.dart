import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/screens/media_detail/detail_design.dart';
import 'package:harbor/theme/mono_theme.dart';

void main() {
  Future<void> pump(WidgetTester tester, Widget child) {
    return tester.pumpWidget(
      MaterialApp(
        theme: monoTheme(dark: true),
        home: Scaffold(body: Center(child: child)),
      ),
    );
  }

  String renderedText(WidgetTester tester) {
    final buffer = StringBuffer();
    for (final text in tester.widgetList<Text>(find.byType(Text))) {
      buffer.write(text.data ?? text.textSpan?.toPlainText() ?? '');
    }
    return buffer.toString();
  }

  group('DetailFactLine', () {
    testWidgets('joins facts with a separator and keeps the certificate out of the run', (tester) async {
      await pump(tester, const DetailFactLine(rating: 8.4, contentRating: 'TV-MA', facts: ['2019', '3 seasons']));

      // The rating renders as an icon span, so only its value lands in the text.
      expect(renderedText(tester), contains('8.4 • 2019 • 3 seasons'));
      // The certificate is a bordered mark, not another dot-separated word.
      expect(find.text('TV-MA'), findsOneWidget);
    });

    testWidgets('collapses to nothing when the item carries none of them', (tester) async {
      await pump(tester, const DetailFactLine(facts: []));
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('drops an empty certificate rather than drawing an empty mark', (tester) async {
      await pump(tester, const DetailFactLine(contentRating: '', facts: ['2019']));
      expect(renderedText(tester), '2019');
    });
  });

  group('DetailGenreLine', () {
    testWidgets('reads as prose, with no tappable ancestor to promise otherwise', (tester) async {
      await pump(tester, const DetailGenreLine(genres: ['Drama', 'Sci-Fi']));

      expect(find.text('Drama · Sci-Fi'), findsOneWidget);
      expect(find.byType(InkWell), findsNothing);
      expect(find.byType(GestureDetector), findsNothing);
    });

    testWidgets('takes no height when the item has no genres', (tester) async {
      await pump(tester, const DetailGenreLine(genres: []));
      expect(find.byType(Text), findsNothing);
    });
  });

  group('DetailInfoTable', () {
    testWidgets('renders a label and value per entry', (tester) async {
      await pump(
        tester,
        const DetailInfoTable(entries: [DetailInfoEntry('Director', 'Someone'), DetailInfoEntry('Container', 'mkv')]),
      );

      expect(find.text('Director'), findsOneWidget);
      expect(find.text('Someone'), findsOneWidget);
      expect(find.text('Container'), findsOneWidget);
      expect(find.text('mkv'), findsOneWidget);
    });

    testWidgets('separates rows with space, not rules', (tester) async {
      await pump(
        tester,
        const DetailInfoTable(entries: [DetailInfoEntry('Studio', 'A24'), DetailInfoEntry('Director', 'Someone')]),
      );

      // The app structures content with surfaces, not hairlines; a ruled table
      // here read as borrowed from a different app.
      for (final container in tester.widgetList<Container>(find.byType(Container))) {
        expect((container.decoration as BoxDecoration?)?.border, isNull);
      }
    });

    testWidgets('collapses when there is nothing to tabulate', (tester) async {
      await pump(tester, const DetailInfoTable(entries: []));
      expect(find.byType(Container), findsNothing);
    });
  });

  group('DetailSectionHeader', () {
    testWidgets('shows a bare heading when it has neither count nor action', (tester) async {
      await pump(tester, const DetailSectionHeader(title: 'Episodes'));

      expect(find.text('Episodes'), findsOneWidget);
      expect(find.byType(Row), findsNothing);
    });

    testWidgets('sets the count beside the heading', (tester) async {
      await pump(tester, const DetailSectionHeader(title: 'Episodes', trailing: '12'));

      expect(find.text('Episodes'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
    });

    testWidgets('prefers the action over the count when given both', (tester) async {
      await pump(tester, const DetailSectionHeader(title: 'Episodes', trailing: '12', action: Text('Season 2')));

      expect(find.text('Season 2'), findsOneWidget);
      expect(find.text('12'), findsNothing);
    });
  });
}
