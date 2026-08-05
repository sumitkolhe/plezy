import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/models/arr/season_completeness.dart';
import 'package:harbor/services/arr/arr_item_lookup.dart';

ArrEpisode _ep(int number, {int season = 1, bool hasFile = false, String? air, bool monitored = true}) {
  return ArrEpisode.fromJson({
    'seasonNumber': season,
    'episodeNumber': number,
    'title': 'Episode $number',
    'hasFile': hasFile,
    'monitored': monitored,
    'airDateUtc': ?air,
  })!;
}

String _daysFromNow(int days) => DateTime.now().toUtc().add(Duration(days: days)).toIso8601String();

void main() {
  group('seasonGap', () {
    test('an unaired episode is upcoming, not missing', () {
      final gap = seasonGap(
        known: [
          _ep(1, air: _daysFromNow(-14)),
          _ep(2, air: _daysFromNow(7)),
        ],
        presentEpisodeNumbers: const {},
        season: 1,
      );

      expect(gap.missing.map((e) => e.episodeNumber), [1]);
      expect(gap.upcoming.map((e) => e.episodeNumber), [2]);
    });

    test('either side claiming the file is enough', () {
      // Sonarr not having rescanned must not report a gap the library can fill.
      final gap = seasonGap(
        known: [
          _ep(1, hasFile: true, air: _daysFromNow(-30)),
          _ep(2, air: _daysFromNow(-20)),
        ],
        presentEpisodeNumbers: const {2},
        season: 1,
      );

      expect(gap.missing, isEmpty);
      expect(gap.upcoming, isEmpty);
    });

    test('ignores other seasons', () {
      final gap = seasonGap(
        known: [
          _ep(1, season: 1, air: _daysFromNow(-9)),
          _ep(1, season: 2, air: _daysFromNow(-2)),
        ],
        presentEpisodeNumbers: const {},
        season: 2,
      );

      expect(gap.missing.single.seasonNumber, 2);
    });

    test('an episode with no announced date counts as upcoming', () {
      // A season Sonarr knows the length of but not the schedule: reporting
      // those as missing would demand a file that cannot exist yet.
      final gap = seasonGap(known: [_ep(5)], presentEpisodeNumbers: const {}, season: 1);

      expect(gap.missing, isEmpty);
      expect(gap.upcoming.single.episodeNumber, 5);
    });

    test('a complete season reports no gap at all', () {
      final gap = seasonGap(
        known: [for (var i = 1; i <= 10; i++) _ep(i, hasFile: true, air: _daysFromNow(-i - 1))],
        presentEpisodeNumbers: {for (var i = 1; i <= 10; i++) i},
        season: 1,
      );

      expect(gap.missing, isEmpty);
      expect(gap.upcoming, isEmpty);
    });

    test('specials are season zero, not an absent season', () {
      final gap = seasonGap(
        known: [_ep(1, season: 0, air: _daysFromNow(-100))],
        presentEpisodeNumbers: const {},
        season: 0,
      );
      expect(gap.missing.single.seasonNumber, 0);
    });
  });
}
