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
    return PhosphorIcons.playCircle;
  }
  for (final (keywords, icon) in _titleKeywordIcons) {
    if (keywords.any(title.contains)) return icon;
  }
  return _defaultHubIcon;
}

const _defaultHubIcon = PhosphorIcons.sparkle;

/// Title keywords in match order — see [hubIconFor].
const _titleKeywordIcons = <(List<String>, IconData)>[
  // Trending/Popular
  (['trending'], PhosphorIcons.trendUp),
  (['popular', 'imdb'], PhosphorIcons.fire),
  // Seasonal/Time-based
  (['seasonal'], PhosphorIcons.calendarBlank),
  (['newly', 'new release'], PhosphorIcons.sparkle),
  (['recently released', 'recent'], PhosphorIcons.clock),
  (['top rated', 'highest rated'], PhosphorIcons.star),
  (['top '], PhosphorIcons.medal),
  // Genre-specific
  (['thriller'], PhosphorIcons.warning),
  (['comedy', 'comedier'], PhosphorIcons.smiley),
  (['action'], PhosphorIcons.lightning),
  (['drama'], PhosphorIcons.maskHappy),
  (['fantasy'], PhosphorIcons.magicWand),
  (['science', 'sci-fi'], PhosphorIcons.rocketLaunch),
  (['horror', 'skräck'], PhosphorIcons.moonStars),
  (['romance', 'romantic'], PhosphorIcons.heart),
  (['adventure', 'äventyr'], PhosphorIcons.compass),
  // Watchlist/Playlists
  (['playlist', 'watchlist'], PhosphorIcons.playlist),
  (['unwatched', 'unplayed'], PhosphorIcons.eyeSlash),
  (['watched', 'played'], PhosphorIcons.eye),
  // Network/Studio
  (['network', 'more from'], PhosphorIcons.television),
  (['actor', 'director'], PhosphorIcons.person),
  // Decades (80s, 90s, etc.)
  (['80', '90', '00'], PhosphorIcons.clockCounterClockwise),
  (['rediscover', 'start watching'], PhosphorIcons.play),
  // Broad library-hub keywords, last so the specific rows above keep their icons.
  (['rated'], PhosphorIcons.star),
  (['recommended'], PhosphorIcons.thumbsUp),
  (['genre'], PhosphorIcons.squaresFour),
];
