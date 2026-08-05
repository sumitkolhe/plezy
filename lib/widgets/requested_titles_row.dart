import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:provider/provider.dart';

import '../i18n/strings.g.dart';
import '../models/arr/absent_title.dart';
import '../models/arr/server_transfer.dart';
import '../providers/server_activity_provider.dart';
import '../theme/mono_tokens.dart';
import '../utils/grid_size_calculator.dart';
import '../services/settings_service.dart';
import '../utils/layout_constants.dart';
import 'app_icon.dart';
import 'media_card_grid_layout.dart';
import 'optimized_media_image.dart';
import 'placeholder_container.dart';

/// Films Radarr is tracking that the library has no file for.
///
/// A row above the grid rather than cards inside it: the grid is one paged,
/// sorted query against the media server, and titles it has never heard of
/// cannot be paged or sorted alongside the ones it has.
/// Where a shelf's heading and its cards both start.
const double _railInset = 12;

/// Caption geometry comes from the grid, so a requested card reads as the same
/// kind of card as the ones in the grid below it.
const MediaCardGridLayout _layout = MediaCardGridLayout.touch;

/// Caption gap, one title line and one year line under the poster.
const double _captionHeight = 42;

class RequestedTitlesRow extends StatefulWidget {
  const RequestedTitlesRow({super.key});

  @override
  State<RequestedTitlesRow> createState() => _RequestedTitlesRowState();
}

class _RequestedTitlesRowState extends State<RequestedTitlesRow> {
  VoidCallback? _release;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ServerActivityProvider>();
    // Watching keeps the queue polled, which is what gives these cards their
    // progress.
    _release = provider.addWatcher();
    unawaited(provider.resolveAbsentMovies());
  }

  @override
  void dispose() {
    _release?.call();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServerActivityProvider>(
      builder: (context, provider, _) {
        final titles = provider.absentMovies ?? const <AbsentTitle>[];
        if (titles.isEmpty) return const SizedBox.shrink();

        final density = SettingsService.instance.read(SettingsService.libraryDensity);
        final cardWidth = GridSizeCalculator.getCellWidth(MediaQuery.sizeOf(context).width, context, density);
        final tokensRef = tokens(context);

        return Padding(
          padding: const EdgeInsets.only(bottom: HubLayoutConstants.shelfVerticalGap),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              // The header a shelf wears everywhere else: icon, then the title
              // on the same rail the cards start from.
              Padding(
                padding: const EdgeInsets.fromLTRB(_railInset, 2, 8, HubLayoutConstants.headerGap),
                child: Row(
                  children: [
                    const AppIcon(PhosphorIcons.paperPlaneTilt, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      t.serverActivity.requestedCount(count: titles.length),
                      style: HubLayoutConstants.sectionHeading(isTv: false, color: tokensRef.text),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: cardWidth * 3 / 2 + _captionHeight,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: _railInset),
                  itemCount: titles.length,
                  separatorBuilder: (_, _) => const SizedBox(width: _railInset),
                  itemBuilder: (context, index) {
                    final title = titles[index];
                    return _RequestedCard(
                      title: title,
                      width: cardWidth,
                      transfer: provider.transferForMedia(title.sourceId, title.mediaId),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RequestedCard extends StatelessWidget {
  final AbsentTitle title;
  final double width;
  final ServerTransfer? transfer;

  const _RequestedCard({required this.title, required this.width, this.transfer});

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    final progress = transfer?.progress;

    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: .start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            child: SizedBox(
              width: width,
              height: width * 3 / 2,
              child: Stack(
                fit: .expand,
                children: [
                  // Dimmed rather than full strength: it is not watchable yet,
                  // and a card that looks ready to play would lie.
                  Opacity(opacity: 0.5, child: _poster(context)),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 5),
                      color: Colors.black.withValues(alpha: 0.62),
                      child: Row(
                        children: [
                          AppIcon(
                            progress == null ? PhosphorIcons.clock : PhosphorIcons.download,
                            size: 11,
                            color: progress == null ? Colors.white70 : Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              progress == null ? t.serverActivity.notInLibrary : '${(progress * 100).round()}%',
                              style: const TextStyle(fontSize: 10.5, fontWeight: .w600, color: Colors.white),
                              maxLines: 1,
                              overflow: .ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (progress != null)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 2,
                        backgroundColor: Colors.transparent,
                        valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: _layout.captionGap),
          Text(
            title.title,
            style: _layout.titleStyle.copyWith(color: tokensRef.text.withValues(alpha: 0.75)),
            maxLines: 1,
            overflow: .ellipsis,
          ),
          if (title.year case final year?) ...[
            SizedBox(height: _layout.titleSubtitleGap),
            Text(
              '$year',
              style: TextStyle(
                fontSize: _layout.subtitleFontSize,
                height: _layout.subtitleHeight,
                color: tokensRef.textMuted,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _poster(BuildContext context) {
    final fallback = PlaceholderContainer(
      color: tokens(context).text.withValues(alpha: 0.05),
      child: AppIcon(PhosphorIcons.filmSlate, size: 22, color: tokens(context).textMuted),
    );
    final url = title.posterUrl;
    if (url == null) return fallback;
    return OptimizedMediaImage.poster(
      client: null,
      imagePath: url,
      width: width,
      height: width * 3 / 2,
      errorWidget: (context, _, _) => fallback,
    );
  }
}
