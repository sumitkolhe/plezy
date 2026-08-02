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
    return PhosphorIconsDuotone.playCircle;
  }
  for (final (keywords, icon) in _titleKeywordIcons) {
    if (keywords.any(title.contains)) return icon;
  }
  return _defaultHubIcon;
}

const _defaultHubIcon = PhosphorIconsDuotone.sparkle;

/// Title keywords in match order — see [hubIconFor].
const _titleKeywordIcons = <(List<String>, IconData)>[
  // Trending/Popular
  (['trending'], PhosphorIconsDuotone.trendUp),
  (['popular', 'imdb'], PhosphorIconsDuotone.fire),
  // Seasonal/Time-based
  (['seasonal'], PhosphorIconsDuotone.calendarBlank),
  (['newly', 'new release'], PhosphorIconsDuotone.sparkle),
  (['recently released', 'recent'], PhosphorIconsDuotone.clock),
  // Top/Rated
  (['top rated', 'highest rated'], PhosphorIconsDuotone.star),
  (['top '], PhosphorIconsDuotone.medal),
  // Genre-specific
  (['thriller'], PhosphorIconsDuotone.warning),
  (['comedy', 'comedier'], PhosphorIconsDuotone.smiley),
  (['action'], PhosphorIconsDuotone.lightning),
  (['drama'], PhosphorIconsDuotone.maskHappy),
  (['fantasy'], PhosphorIconsDuotone.magicWand),
  (['science', 'sci-fi'], PhosphorIconsDuotone.rocketLaunch),
  (['horror', 'skräck'], PhosphorIconsDuotone.moonStars),
  (['romance', 'romantic'], PhosphorIconsDuotone.heart),
  (['adventure', 'äventyr'], PhosphorIconsDuotone.compass),
  // Watchlist/Playlists
  (['playlist', 'watchlist'], PhosphorIconsDuotone.playlist),
  (['unwatched', 'unplayed'], PhosphorIconsDuotone.eyeSlash),
  (['watched', 'played'], PhosphorIconsDuotone.eye),
  // Network/Studio
  (['network', 'more from'], PhosphorIconsDuotone.television),
  // Actor/Director
  (['actor', 'director'], PhosphorIconsDuotone.person),
  // Decades (80s, 90s, etc.)
  (['80', '90', '00'], PhosphorIconsDuotone.clockCounterClockwise),
  // Rediscover/Start Watching
  (['rediscover', 'start watching'], PhosphorIconsDuotone.play),
  // Broad library-hub keywords, last so the specific rows above keep their icons.
  (['rated'], PhosphorIconsDuotone.star),
  (['recommended'], PhosphorIconsDuotone.thumbsUp),
  (['genre'], PhosphorIconsDuotone.squaresFour),
];
