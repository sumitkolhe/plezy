import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/media/library_view.dart';

void main() {
  group('LibraryView', () {
    test('round-trips through a list, omitting what is at its default', () {
      const views = [
        LibraryView(
          name: 'Unwatched 4K',
          grouping: 'movies',
          filters: {'unwatched': '1'},
          sortKey: 'addedAt',
          descending: true,
        ),
        LibraryView(name: 'Everything', grouping: 'all'),
      ];

      final decoded = LibraryView.decodeList(LibraryView.encodeList(views));

      expect(decoded.map((v) => v.name), ['Unwatched 4K', 'Everything']);
      expect(decoded.first.filters, {'unwatched': '1'});
      expect(decoded.first.sortKey, 'addedAt');
      expect(decoded.first.descending, isTrue);
      // A default carries no key, and reads back as the default.
      expect(LibraryView.encodeList([views.last]).contains('descending'), isFalse);
      expect(decoded.last.sortKey, isNull);
      expect(decoded.last.filters, isEmpty);
    });

    test('one unreadable entry costs only itself', () {
      final decoded = LibraryView.decodeList(
        '[{"name":"Good","grouping":"movies"},{"grouping":"movies"},{"name":"No grouping"}]',
      );
      expect(decoded.map((v) => v.name), ['Good']);
    });

    test('a non-list, empty or absent payload is no views rather than a throw', () {
      expect(LibraryView.decodeList(null), isEmpty);
      expect(LibraryView.decodeList(''), isEmpty);
      expect(LibraryView.decodeList('{"name":"not a list"}'), isEmpty);
    });

    test('matches only when every part of the shape agrees', () {
      const view = LibraryView(name: 'V', grouping: 'movies', filters: {'genre': '18'}, sortKey: 'titleSort');

      expect(
        view.matches(grouping: 'movies', sortKey: 'titleSort', descending: false, filters: {'genre': '18'}),
        isTrue,
      );
      expect(
        view.matches(grouping: 'movies', sortKey: 'titleSort', descending: true, filters: {'genre': '18'}),
        isFalse,
        reason: 'direction is part of the order',
      );
      expect(
        view.matches(grouping: 'movies', sortKey: 'titleSort', descending: false, filters: {'genre': '99'}),
        isFalse,
      );
      expect(
        view.matches(grouping: 'folders', sortKey: 'titleSort', descending: false, filters: {'genre': '18'}),
        isFalse,
      );
    });
  });
}
