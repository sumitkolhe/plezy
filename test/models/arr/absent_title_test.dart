import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/models/arr/absent_title.dart';

AbsentTitle? _parse(Map<String, dynamic> json) =>
    AbsentTitle.fromJson(json, sourceId: 'radarr@host', sourceName: 'Radarr');

void main() {
  group('AbsentTitle', () {
    test('reads the film and prefers the public poster URL', () {
      final title = _parse({
        'id': 41,
        'title': 'Dune: Part Two',
        'year': 2024,
        'tmdbId': 693134,
        'monitored': true,
        'hasFile': false,
        'images': [
          {'coverType': 'fanart', 'remoteUrl': 'https://image.tmdb.org/fanart.jpg'},
          {'coverType': 'poster', 'url': '/MediaCover/41/poster.jpg', 'remoteUrl': 'https://image.tmdb.org/poster.jpg'},
        ],
      });

      expect(title?.mediaId, 41);
      expect(title?.tmdbId, 693134);
      expect(title?.year, 2024);
      // The local url needs the instance's host and key; the remote one does not.
      expect(title?.posterUrl, 'https://image.tmdb.org/poster.jpg');
    });

    test('a film with a file is not absent, whatever list it came in', () {
      expect(_parse({'id': 1, 'title': 'Already Here', 'hasFile': true}), isNull);
    });

    test('drops a record with nothing to identify or show', () {
      expect(_parse({'title': 'No id'}), isNull);
      expect(_parse({'id': 2, 'title': '   '}), isNull);
    });

    test('survives a film with no poster or year at all', () {
      final title = _parse({'id': 7, 'title': 'Untitled', 'monitored': false});
      expect(title?.posterUrl, isNull);
      expect(title?.year, isNull);
      expect(title?.monitored, isFalse);
    });

    test('ignores a local-only poster rather than building an unloadable URL', () {
      final title = _parse({
        'id': 8,
        'title': 'Local Art',
        'images': [
          {'coverType': 'poster', 'url': '/MediaCover/8/poster.jpg'},
        ],
      });

      expect(title?.posterUrl, isNull);
    });
  });
}
