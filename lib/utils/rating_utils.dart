/// Resolves the brand badge shown beside a score, from the attributed source
/// keys the Explore catalog publishes.
library;

class RatingInfo {
  final String assetPath;
  final String formattedValue;

  const RatingInfo(this.assetPath, this.formattedValue);
}

/// The badge for a [CatalogRatingSource]-style source key.
///
/// Catalog providers attribute their scores by name (`imdb`, `tmdb`,
/// `rottenTomatoesCritic`, …), so the icon is chosen from the key. Rotten
/// Tomatoes picks fresh/rotten and upright/spilled by the 60% threshold the
/// tomatometer itself uses.
///
/// Returns null for keys with no brand badge (`critic`, `audience`, `simkl`,
/// `mal`, `anilist`, `trakt`); those stay labelled with their source name.
RatingInfo? catalogRatingInfo(String source, double value) => switch (source) {
  'imdb' => RatingInfo(_imdbAsset, value.toStringAsFixed(1)),
  'tmdb' => RatingInfo(_tmdbAsset, _percent(value)),
  'rottenTomatoes' ||
  'rottenTomatoesCritic' => RatingInfo(value >= _rottenTomatoesFresh ? _rtFreshAsset : _rtRottenAsset, _percent(value)),
  'rottenTomatoesAudience' => RatingInfo(
    value >= _rottenTomatoesFresh ? _rtUprightAsset : _rtSpilledAsset,
    _percent(value),
  ),
  _ => null,
};

const String _imdbAsset = 'assets/rating_icons/imdb.svg';
const String _tmdbAsset = 'assets/rating_icons/tmdb.svg';
const String _rtFreshAsset = 'assets/rating_icons/rt_fresh.svg';
const String _rtRottenAsset = 'assets/rating_icons/rt_rotten.svg';
const String _rtUprightAsset = 'assets/rating_icons/rt_upright.svg';
const String _rtSpilledAsset = 'assets/rating_icons/rt_spilled.svg';

/// Ratings are normalized to a 0-10 scale; Rotten Tomatoes is a percentage.
const double _rottenTomatoesFresh = 6.0;

String _percent(double value) => '${(value * 10).toStringAsFixed(0)}%';
