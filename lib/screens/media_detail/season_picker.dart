import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../i18n/strings.g.dart';
import '../../media/media_item.dart';
import '../../theme/mono_tokens.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/focusable_list_tile.dart';
import '../../widgets/overlay_sheet.dart';
import 'detail_design.dart';

/// Season chooser for the touch detail screen.
///
/// The horizontal tab strip it replaces put every season on screen at once and
/// scrolled sideways to reach the rest, which made "which season am I on" a
/// question about scroll offset. A chip states the answer and a sheet holds the
/// list, so the episode list keeps the width the strip was borrowing.
class SeasonPickerChip extends StatelessWidget {
  final List<MediaItem> seasons;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final FocusNode? focusNode;

  const SeasonPickerChip({
    super.key,
    required this.seasons,
    required this.selectedIndex,
    required this.onSelected,
    this.focusNode,
  });

  static String? seasonMeta(MediaItem season) {
    final total = season.leafCount;
    if (total == null || total <= 0) return null;
    return t.explore.episodeCount(n: total);
  }

  @override
  Widget build(BuildContext context) {
    if (seasons.isEmpty) return const SizedBox.shrink();
    final tokensRef = tokens(context);
    final index = selectedIndex.clamp(0, seasons.length - 1);
    final label = seasons[index].title ?? t.common.seasonNumber(number: '${seasons[index].index ?? index + 1}');

    return Semantics(
      button: true,
      child: InkWell(
        focusNode: focusNode,
        borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
        onTap: seasons.length > 1 ? () => unawaitedShow(context) : null,
        child: Container(
          padding: const EdgeInsets.fromLTRB(14, 7, 10, 7),
          decoration: BoxDecoration(
            color: tokensRef.text.withValues(alpha: 0.09),
            borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              Text(label, style: TextStyle(fontSize: 13.5, fontWeight: .w500, color: tokensRef.text)),
              if (seasons.length > 1) ...[
                const SizedBox(width: 4),
                AppIcon(Symbols.expand_more_rounded, size: 16, color: tokensRef.text),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void unawaitedShow(BuildContext context) {
    OverlaySheetController.showAdaptive<int>(
      context,
      showDragHandle: true,
      builder: (sheetContext) => _SeasonSheet(seasons: seasons, selectedIndex: selectedIndex),
    ).then((picked) {
      if (picked != null && picked != selectedIndex) onSelected(picked);
    });
  }
}

class _SeasonSheet extends StatelessWidget {
  final List<MediaItem> seasons;
  final int selectedIndex;

  const _SeasonSheet({required this.seasons, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    final totalEpisodes = seasons.fold<int>(0, (sum, season) => sum + (season.leafCount ?? 0));

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 6, 20, 12),
          child: DetailSectionHeader(
            title: t.libraries.groupings.seasons,
            trailing: totalEpisodes > 0 ? t.explore.episodeCount(n: totalEpisodes) : null,
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: seasons.length,
            itemBuilder: (context, index) {
              final season = seasons[index];
              final meta = SeasonPickerChip.seasonMeta(season);
              return FocusableListTile(
                autofocus: index == selectedIndex,
                title: Text(
                  season.title ?? t.common.seasonNumber(number: '${season.index ?? index + 1}'),
                  style: TextStyle(fontSize: 15.5, fontWeight: .w600, color: tokensRef.text),
                ),
                subtitle: meta == null
                    ? null
                    : Text(
                        meta,
                        style: TextStyle(fontFamily: MonoFonts.mono, fontSize: 11, color: tokensRef.textMuted),
                      ),
                trailing: index == selectedIndex
                    ? AppIcon(Symbols.check_rounded, size: 18, color: tokensRef.text)
                    : null,
                onTap: () => OverlaySheetController.closeAdaptive(context, index),
                dense: false,
                visualDensity: VisualDensity.standard,
              );
            },
          ),
        ),
      ],
    );
  }
}
