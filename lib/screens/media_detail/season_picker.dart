import 'dart:async';

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../i18n/strings.g.dart';
import '../../media/media_item.dart';
import '../../theme/mono_tokens.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/focusable_list_tile.dart';
import '../../widgets/overlay_sheet.dart';
import 'detail_design.dart';

const double _pillHorizontalPadding = 13;
const double _pillGap = 7;
const double _pillHeight = 34;
const double _overflowPillWidth = 40;

class SeasonSelector extends StatefulWidget {
  final List<MediaItem> seasons;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const SeasonSelector({super.key, required this.seasons, required this.selectedIndex, required this.onSelected});

  /// Index 0 is conventionally Specials, where `S0` would read as meaningless.
  static String compactLabel(MediaItem season, int position) {
    final index = season.index;
    if (index != null && index > 0) return 'S$index';
    return season.title ?? t.common.seasonNumber(number: '${position + 1}');
  }

  static String fullLabel(MediaItem season, int position) =>
      season.title ?? t.common.seasonNumber(number: '${season.index ?? position + 1}');

  static String? seasonMeta(MediaItem season) {
    final total = season.leafCount;
    if (total == null || total <= 0) return null;
    return t.explore.episodeCount(n: total);
  }

  @override
  State<SeasonSelector> createState() => _SeasonSelectorState();
}

class _SeasonSelectorState extends State<SeasonSelector> {
  final ScrollController _controller = ScrollController();
  List<double>? _pillWidths;
  double _viewport = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _revealSelected(animate: false));
  }

  @override
  void didUpdateWidget(SeasonSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.seasons, widget.seasons)) _pillWidths = null;
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _revealSelected());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Widths depend only on the labels, so a resize must not re-measure.
  List<double> _measurePills(TextStyle style) {
    final cached = _pillWidths;
    if (cached != null) return cached;
    final widths = <double>[];
    for (var i = 0; i < widget.seasons.length; i++) {
      final painter = TextPainter(
        text: TextSpan(text: SeasonSelector.compactLabel(widget.seasons[i], i), style: style),
        maxLines: 1,
        textDirection: Directionality.of(context),
      )..layout();
      widths.add(painter.width + _pillHorizontalPadding * 2);
      painter.dispose();
    }
    return _pillWidths = widths;
  }

  /// Derived from the measured widths, not the built pills: a season far enough
  /// down the row has no element to scroll to until it is already on screen.
  void _revealSelected({bool animate = true}) {
    final widths = _pillWidths;
    if (!mounted || !_controller.hasClients || widths == null) return;
    if (widget.selectedIndex < 0 || widget.selectedIndex >= widths.length) return;

    var start = 0.0;
    for (var i = 0; i < widget.selectedIndex; i++) {
      start += widths[i] + _pillGap;
    }
    final target = (start + widths[widget.selectedIndex] / 2 - _viewport / 2).clamp(
      0.0,
      _controller.position.maxScrollExtent,
    );
    if (animate) {
      unawaited(_controller.animateTo(target, duration: const Duration(milliseconds: 200), curve: Curves.easeOut));
    } else {
      _controller.jumpTo(target);
    }
  }

  void _openSheet() {
    unawaited(
      OverlaySheetController.showAdaptive<int>(
        context,
        showDragHandle: true,
        builder: (_) => _SeasonSheet(seasons: widget.seasons, selectedIndex: widget.selectedIndex),
      ).then((picked) {
        if (picked != null && picked != widget.selectedIndex) widget.onSelected(picked);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.seasons.length < 2) return const SizedBox.shrink();

    final tokensRef = tokens(context);
    final labelStyle = TextStyle(fontSize: 13.5, fontWeight: .w600, color: tokensRef.text);
    final widths = _measurePills(labelStyle);
    final rowWidth = widths.reduce((a, b) => a + b) + _pillGap * (widths.length - 1);

    return LayoutBuilder(
      builder: (context, constraints) {
        // A row that scrolls cannot be scanned, so overflow moves the full list
        // into a sheet and leaves the row as a shortcut to nearby seasons.
        final overflows = rowWidth > constraints.maxWidth;
        _viewport = overflows ? constraints.maxWidth - _overflowPillWidth - _pillGap : constraints.maxWidth;
        return SizedBox(
          height: _pillHeight,
          child: Row(
            children: [
              Expanded(
                child: ListView.separated(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  physics: overflows ? null : const NeverScrollableScrollPhysics(),
                  padding: .zero,
                  itemCount: widget.seasons.length,
                  separatorBuilder: (_, _) => const SizedBox(width: _pillGap),
                  itemBuilder: (context, index) => _SeasonPill(
                    label: SeasonSelector.compactLabel(widget.seasons[index], index),
                    semanticLabel: SeasonSelector.fullLabel(widget.seasons[index], index),
                    selected: index == widget.selectedIndex,
                    onTap: () => widget.onSelected(index),
                  ),
                ),
              ),
              if (overflows) ...[const SizedBox(width: _pillGap), _OverflowPill(onTap: _openSheet)],
            ],
          ),
        );
      },
    );
  }
}

class _SeasonPill extends StatelessWidget {
  final String label;
  final String semanticLabel;
  final bool selected;
  final VoidCallback onTap;

  const _SeasonPill({
    required this.label,
    required this.semanticLabel,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    return Semantics(
      button: true,
      selected: selected,
      label: semanticLabel,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
        child: AnimatedContainer(
          duration: tokensRef.fast,
          curve: Curves.easeOutCubic,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: _pillHorizontalPadding),
          decoration: BoxDecoration(
            color: selected ? tokensRef.text : tokensRef.text.withValues(alpha: 0.09),
            borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
          ),
          child: Text(
            label,
            style: TextStyle(fontSize: 13.5, fontWeight: .w600, color: selected ? tokensRef.bg : tokensRef.text),
          ),
        ),
      ),
    );
  }
}

class _OverflowPill extends StatelessWidget {
  final VoidCallback onTap;

  const _OverflowPill({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    return Semantics(
      button: true,
      label: t.libraries.groupings.seasons,
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
        child: Container(
          width: _overflowPillWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tokensRef.text.withValues(alpha: 0.09),
            borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
          ),
          child: AppIcon(Symbols.list_rounded, size: 18, color: tokensRef.text),
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
    final tokensRef = tokens(context);
    final totalEpisodes = seasons.fold<int>(0, (sum, season) => sum + (season.leafCount ?? 0));
    const inset = EdgeInsets.symmetric(horizontal: 20);

    return Column(
      mainAxisSize: .min,
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: inset.add(const EdgeInsets.only(bottom: 10)),
          child: DetailSectionHeader(
            title: t.libraries.groupings.seasons,
            trailing: totalEpisodes > 0 ? t.explore.episodeCount(n: totalEpisodes) : null,
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            padding: .zero,
            itemCount: seasons.length,
            itemBuilder: (context, index) {
              final season = seasons[index];
              final meta = SeasonSelector.seasonMeta(season);
              final selected = index == selectedIndex;
              return FocusableListTile(
                autofocus: selected,
                contentPadding: inset,
                title: Text(
                  SeasonSelector.fullLabel(season, index),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: selected ? .w600 : .w500,
                    color: tokensRef.text,
                    height: 1.3,
                  ),
                ),
                subtitle: meta == null
                    ? null
                    : Text(
                        meta,
                        style: TextStyle(
                          fontFamily: MonoFonts.mono,
                          fontSize: 11,
                          color: tokensRef.textMuted,
                          height: 1.3,
                        ),
                      ),
                trailing: selected ? AppIcon(Symbols.check_rounded, size: 18, color: tokensRef.text) : null,
                onTap: () => OverlaySheetController.closeAdaptive(context, index),
              );
            },
          ),
        ),
      ],
    );
  }
}
