import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/utils/rating_utils.dart';

void main() {
  group('catalogRatingInfo - branded sources', () {
    test('imdb keeps one decimal on the 0-10 scale', () {
      final info = catalogRatingInfo('imdb', 8.4)!;
      expect(info.assetPath, 'assets/rating_icons/imdb.svg');
      expect(info.formattedValue, '8.4');
      expect(catalogRatingInfo('imdb', 8)!.formattedValue, '8.0');
    });

    test('tmdb renders as a whole percent', () {
      final info = catalogRatingInfo('tmdb', 7.2)!;
      expect(info.assetPath, 'assets/rating_icons/tmdb.svg');
      expect(info.formattedValue, '72%');
    });
  });

  group('catalogRatingInfo - Rotten Tomatoes', () {
    // The tomatometer flips at 60%, which is 6.0 on the normalized scale the
    // catalog publishes. Both critic keys share the fresh/rotten pair; the
    // audience key uses upright/spilled.
    test('critic at or above the threshold is fresh', () {
      expect(catalogRatingInfo('rottenTomatoes', 6.0)!.assetPath, 'assets/rating_icons/rt_fresh.svg');
      expect(catalogRatingInfo('rottenTomatoesCritic', 9.1)!.assetPath, 'assets/rating_icons/rt_fresh.svg');
    });

    test('critic below the threshold is rotten', () {
      expect(catalogRatingInfo('rottenTomatoesCritic', 5.9)!.assetPath, 'assets/rating_icons/rt_rotten.svg');
    });

    test('audience uses the upright/spilled pair on the same threshold', () {
      expect(catalogRatingInfo('rottenTomatoesAudience', 6.0)!.assetPath, 'assets/rating_icons/rt_upright.svg');
      expect(catalogRatingInfo('rottenTomatoesAudience', 5.9)!.assetPath, 'assets/rating_icons/rt_spilled.svg');
    });

    test('formats as a whole percent', () {
      expect(catalogRatingInfo('rottenTomatoes', 8.5)!.formattedValue, '85%');
    });
  });

  group('catalogRatingInfo - unbranded sources', () {
    test('sources with no badge return null so the caller labels them by name', () {
      for (final source in ['critic', 'audience', 'mal', 'anilist', 'trakt', '']) {
        expect(catalogRatingInfo(source, 7.0), isNull, reason: source);
      }
    });
  });
}
