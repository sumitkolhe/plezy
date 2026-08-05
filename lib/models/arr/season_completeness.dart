import '../../services/arr/arr_item_lookup.dart';

/// Episodes Sonarr knows about that the library has no file for, split by
/// whether they have aired.
///
/// Unaired episodes are not a gap — a currently-airing series would otherwise
/// look permanently broken — so they are reported separately and can be shown
/// as "upcoming" rather than "missing".
typedef SeasonGap = ({List<ArrEpisode> missing, List<ArrEpisode> upcoming});

/// Which episodes of [season] are absent from [presentEpisodeNumbers].
///
/// Matched on episode number within the season, because that is the only key
/// both sides agree on: Jellyfin item ids mean nothing to Sonarr, and titles
/// differ by provider and language.
SeasonGap seasonGap({required List<ArrEpisode> known, required Set<int> presentEpisodeNumbers, required int season}) {
  final missing = <ArrEpisode>[];
  final upcoming = <ArrEpisode>[];

  for (final episode in known) {
    if (episode.seasonNumber != season) continue;
    if (episode.hasFile || presentEpisodeNumbers.contains(episode.episodeNumber)) continue;
    // hasFile is Sonarr's own view and the library is the app's; an episode
    // counts as present if either says so, so a file Sonarr has not rescanned
    // does not show up as a gap.
    (episode.hasAired ? missing : upcoming).add(episode);
  }

  return (missing: missing, upcoming: upcoming);
}
