import 'package:flutter/widgets.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

import '../media/media_hub.dart';

/// Leading icon for a hub row, shared by every surface that renders hubs from
/// the same backend rows (Discover and a library's Recommended tab).
///
/// Continue Watching is matched on the hub key first so synthesized rows and
/// section-specific `*.inprogress.*` hubs are covered, then on title for
/// backends whose resume row is only recognizable by name (Plex "On Deck").
/// Everything else is keyword-matched on the title; the first match wins, so
/// the more specific keywords are checked before the broader ones.
IconData hubIconFor(MediaHub hub) {
  final title = hub.title.toLowerCase();

  if (hub.isContinueWatchingHub || title.contains('continue watching') || title.contains('on deck')) {
    return TablerIcons.playerPlay;
  }
  for (final (keywords, icon) in _titleKeywordIcons) {
    if (keywords.any(title.contains)) return icon;
  }
  return _defaultHubIcon;
}

const _defaultHubIcon = TablerIcons.sparkles;

/// Title keywords in match order — see [hubIconFor].
const _titleKeywordIcons = <(List<String>, IconData)>[
  // Trending/Popular
  (['trending'], TablerIcons.trendingUp),
  (['popular', 'imdb'], TablerIcons.flame),
  // Seasonal/Time-based
  (['seasonal'], TablerIcons.calendar),
  (['newly', 'new release'], TablerIcons.sparkles),
  (['recently released', 'recent'], TablerIcons.clock),
  (['top rated', 'highest rated'], TablerIcons.star),
  (['top '], TablerIcons.medal),
  // Genre-specific
  (['thriller'], TablerIcons.alertTriangle),
  (['comedy', 'comedier'], TablerIcons.moodSmile),
  (['action'], TablerIcons.bolt),
  (['drama'], TablerIcons.mask),
  (['fantasy'], TablerIcons.wand),
  (['science', 'sci-fi'], TablerIcons.rocket),
  (['horror', 'skräck'], TablerIcons.moonStars),
  (['romance', 'romantic'], TablerIcons.heart),
  (['adventure', 'äventyr'], TablerIcons.compass),
  // Watchlist/Playlists
  (['playlist', 'watchlist'], TablerIcons.playlist),
  (['unwatched', 'unplayed'], TablerIcons.eyeOff),
  (['watched', 'played'], TablerIcons.eye),
  // Network/Studio
  (['network', 'more from'], TablerIcons.deviceTv),
  (['actor', 'director'], TablerIcons.user),
  // Decades (80s, 90s, etc.)
  (['80', '90', '00'], TablerIcons.history),
  (['rediscover', 'start watching'], TablerIcons.playerPlay),
  // Broad library-hub keywords, last so the specific rows above keep their icons.
  (['rated'], TablerIcons.star),
  (['recommended'], TablerIcons.thumbUp),
  (['genre'], TablerIcons.layoutGrid),
];
