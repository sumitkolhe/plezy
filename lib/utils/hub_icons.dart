import 'package:flutter/widgets.dart';
import 'package:harbor/theme/phosphor_icons.dart';

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
    return PhosphorIconsFill.playCircle;
  }
  for (final (keywords, icon) in _titleKeywordIcons) {
    if (keywords.any(title.contains)) return icon;
  }
  return _defaultHubIcon;
}

const _defaultHubIcon = PhosphorIconsFill.sparkle;

/// Title keywords in match order — see [hubIconFor].
const _titleKeywordIcons = <(List<String>, IconData)>[
  // Trending/Popular
  (['trending'], PhosphorIconsFill.trendUp),
  (['popular', 'imdb'], PhosphorIconsFill.fire),
  // Seasonal/Time-based
  (['seasonal'], PhosphorIconsFill.calendarBlank),
  (['newly', 'new release'], PhosphorIconsFill.sparkle),
  (['recently released', 'recent'], PhosphorIconsFill.clock),
  // Top/Rated
  (['top rated', 'highest rated'], PhosphorIconsFill.star),
  (['top '], PhosphorIconsFill.medal),
  // Genre-specific
  (['thriller'], PhosphorIconsFill.warning),
  (['comedy', 'comedier'], PhosphorIconsFill.smiley),
  (['action'], PhosphorIconsFill.lightning),
  (['drama'], PhosphorIconsFill.maskHappy),
  (['fantasy'], PhosphorIconsFill.magicWand),
  (['science', 'sci-fi'], PhosphorIconsFill.rocketLaunch),
  (['horror', 'skräck'], PhosphorIconsFill.moonStars),
  (['romance', 'romantic'], PhosphorIconsFill.heart),
  (['adventure', 'äventyr'], PhosphorIconsFill.compass),
  // Watchlist/Playlists
  (['playlist', 'watchlist'], PhosphorIconsFill.playlist),
  (['unwatched', 'unplayed'], PhosphorIconsFill.eyeSlash),
  (['watched', 'played'], PhosphorIconsFill.eye),
  // Network/Studio
  (['network', 'more from'], PhosphorIconsFill.television),
  // Actor/Director
  (['actor', 'director'], PhosphorIconsFill.person),
  // Decades (80s, 90s, etc.)
  (['80', '90', '00'], PhosphorIconsFill.clockCounterClockwise),
  // Rediscover/Start Watching
  (['rediscover', 'start watching'], PhosphorIconsFill.play),
  // Broad library-hub keywords, last so the specific rows above keep their icons.
  (['rated'], PhosphorIconsFill.star),
  (['recommended'], PhosphorIconsFill.thumbsUp),
  (['genre'], PhosphorIconsFill.squaresFour),
];
