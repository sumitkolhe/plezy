import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/media/library_view.dart';

void main() {
  group('LibraryView', () {
    test('round-trips through a list, omitting what is at its default', () {
      const views = [
        LibraryView(name: 'Unwatched 4K', filters: {'unwatched': '1', 'resolution': '4k'}),
        LibraryView(name: 'Everything'),
      ];

      final decoded = LibraryView.decodeList(LibraryView.encodeList(views));

      expect(decoded.map((v) => v.name), ['Unwatched 4K', 'Everything']);
      expect(decoded.first.filters, {'unwatched': '1', 'resolution': '4k'});
      // No filters carries no key, and reads back empty.
      expect(LibraryView.encodeList([views.last]).contains('filters'), isFalse);
      expect(decoded.last.filters, isEmpty);
    });

    test('one unreadable entry costs only itself', () {
      final decoded = LibraryView.decodeList('[{"name":"Good"},{"filters":{"a":"1"}},{"name":"  "}]');
      expect(decoded.map((v) => v.name), ['Good']);
    });

    test('a non-list, empty or absent payload is no views rather than a throw', () {
      expect(LibraryView.decodeList(null), isEmpty);
      expect(LibraryView.decodeList(''), isEmpty);
      expect(LibraryView.decodeList('{"name":"not a list"}'), isEmpty);
    });

    test('a view is its filters, so sort and grouping cannot make it stop matching', () {
      const view = LibraryView(name: 'V', filters: {'genre': '18'});

      expect(view.matches({'genre': '18'}), isTrue);
      expect(view.matches({'genre': '99'}), isFalse);
      expect(view.matches(const {}), isFalse);
      expect(const LibraryView(name: 'Everything').matches(const {}), isTrue);
    });

    test('non-string filter values survive a round-trip as strings', () {
      final decoded = LibraryView.decodeList('[{"name":"N","filters":{"year":2024,"hd":true}}]');
      expect(decoded.single.filters, {'year': '2024', 'hd': 'true'});
    });
  });
}
