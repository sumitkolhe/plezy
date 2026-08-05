import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/models/arr/arr_release.dart';

ArrRelease _release({
  String guid = 'g1',
  String title = 'Some.Release.1080p',
  int size = 1000,
  int? seeders,
  String protocol = 'torrent',
  int age = 0,
  bool? rejected,
  List<String>? rejections,
}) {
  return ArrRelease.fromJson({
    'guid': guid,
    'indexerId': 3,
    'title': title,
    'indexer': 'Indexer',
    'size': size,
    'seeders': ?seeders,
    'protocol': protocol,
    'ageHours': age,
    'rejected': ?rejected,
    'rejections': ?rejections,
    'quality': {
      'quality': {'name': 'WEBDL-1080p'},
    },
  })!;
}

void main() {
  group('ArrRelease', () {
    test('reads the nested quality name and the flat fields', () {
      final release = _release(seeders: 42);
      expect(release.quality, 'WEBDL-1080p');
      expect(release.indexerId, 3);
      expect(release.seeders, 42);
      expect(release.isTorrent, isTrue);
    });

    test('rejection reasons alone mark a release rejected', () {
      // Some indexer responses omit the `rejected` flag entirely.
      final release = _release(rejections: ['Quality not wanted']);
      expect(release.rejected, isTrue);
      expect(release.rejections, ['Quality not wanted']);
    });

    test('drops a release with nothing to grab it by', () {
      expect(ArrRelease.fromJson({'title': 'No guid'}), isNull);
      expect(ArrRelease.fromJson({'guid': 'g', 'indexerId': 1}), isNull);
    });

    test('usenet has no seeders rather than zero', () {
      expect(_release(protocol: 'usenet').seeders, isNull);
    });
  });

  group('sortReleases', () {
    test('anything *arr would accept comes before anything it rejected', () {
      final sorted = sortReleases([
        _release(guid: 'bad', seeders: 900, rejections: ['Not a preferred word']),
        _release(guid: 'good', seeders: 2),
      ]);

      expect(sorted.map((r) => r.guid), ['good', 'bad']);
    });

    test('torrents rank by seeders, usenet by youth', () {
      final torrents = sortReleases([_release(guid: 'few', seeders: 3), _release(guid: 'many', seeders: 300)]);
      expect(torrents.first.guid, 'many');

      final usenet = sortReleases([
        _release(guid: 'old', protocol: 'usenet', age: 900),
        _release(guid: 'fresh', protocol: 'usenet', age: 12),
      ]);
      expect(usenet.first.guid, 'fresh');
    });

    test('a usenet release is not sorted below every torrent for lacking seeders', () {
      // Ranking both on one number would bury usenet under any seeded torrent.
      final sorted = sortReleases([
        _release(guid: 'torrent', seeders: 1, size: 100),
        _release(guid: 'usenet', protocol: 'usenet', size: 900),
      ]);

      expect(sorted.first.guid, 'usenet', reason: 'larger, and neither is rejected');
    });

    test('size breaks a tie', () {
      final sorted = sortReleases([
        _release(guid: 'small', seeders: 10, size: 100),
        _release(guid: 'big', seeders: 10, size: 900),
      ]);
      expect(sorted.map((r) => r.guid), ['big', 'small']);
    });

    test('leaves the input list alone', () {
      final input = [_release(guid: 'a', seeders: 1), _release(guid: 'b', seeders: 9)];
      sortReleases(input);
      expect(input.map((r) => r.guid), ['a', 'b']);
    });
  });
}
