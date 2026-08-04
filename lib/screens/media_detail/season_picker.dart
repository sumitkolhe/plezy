import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';

import '../../i18n/strings.g.dart';
import '../../media/media_item.dart';
import '../../theme/mono_tokens.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_menu.dart';
import '../../widgets/bottom_sheet_header.dart';
import '../../widgets/overlay_sheet.dart';

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

  static String label(MediaItem season, int position) =>
      season.title ?? t.common.seasonNumber(number: '${season.index ?? position + 1}');

  static String? seasonMeta(MediaItem season) {
    final total = season.leafCount;
    if (total == null || total <= 0) return null;
    return t.explore.episodeCount(n: total);
  }

  void _showSheet(BuildContext context) {
    unawaited(
      OverlaySheetController.showAdaptive<int>(
        context,
        builder: (_) => _SeasonSheet(seasons: seasons, selectedIndex: selectedIndex),
      ).then((picked) {
        if (picked != null && picked != selectedIndex) onSelected(picked);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (seasons.isEmpty) return const SizedBox.shrink();
    final tokensRef = tokens(context);
    final index = selectedIndex.clamp(0, seasons.length - 1);
    final choosable = seasons.length > 1;

    return Semantics(
      button: choosable,
      child: InkWell(
        focusNode: focusNode,
        borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
        onTap: choosable ? () => _showSheet(context) : null,
        child: Container(
          padding: EdgeInsets.fromLTRB(14, 7, choosable ? 10 : 14, 7),
          decoration: BoxDecoration(
            color: tokensRef.text.withValues(alpha: 0.09),
            borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
          ),
          child: Row(
            mainAxisSize: .min,
            children: [
              Text(
                label(seasons[index], index),
                style: TextStyle(fontSize: 13.5, fontWeight: .w500, color: tokensRef.text),
              ),
              if (choosable) ...[
                const SizedBox(width: 4),
                AppIcon(PhosphorIcons.caretDown, size: 16, color: tokensRef.text),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SeasonSheet extends StatelessWidget {
  final List<MediaItem> seasons;
  final int selectedIndex;

  const _SeasonSheet({required this.seasons, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final totalEpisodes = seasons.fold<int>(0, (sum, season) => sum + (season.leafCount ?? 0));

    return Column(
      mainAxisSize: .min,
      children: [
        BottomSheetHeader(
          title: t.libraries.groupings.seasons,
          action: totalEpisodes > 0 ? Text(t.explore.episodeCount(n: totalEpisodes)) : null,
        ),
        Flexible(
          child: SingleChildScrollView(
            child: AppMenuList<int>(
              padding: const EdgeInsets.only(bottom: 16),
              focusSelectedItem: true,
              entries: [
                for (var index = 0; index < seasons.length; index++)
                  AppMenuItem<int>(
                    value: index,
                    label: SeasonPickerChip.label(seasons[index], index),
                    subtitle: SeasonPickerChip.seasonMeta(seasons[index]),
                    selected: index == selectedIndex,
                  ),
              ],
              onSelected: (index) => OverlaySheetController.closeAdaptive(context, index),
            ),
          ),
        ),
      ],
    );
  }
}
