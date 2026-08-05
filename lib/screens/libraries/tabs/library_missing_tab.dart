import 'dart:async';

import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:provider/provider.dart';

import '../../../i18n/app_locale_utils.dart';
import '../../../i18n/strings.g.dart';
import '../../../media/media_kind.dart';
import '../../../media/media_library.dart';
import '../../../models/arr/absent_title.dart';
import '../../../models/arr/managed_service.dart';
import '../../../models/arr/server_transfer.dart';
import '../../../providers/server_activity_provider.dart';
import '../../../services/arr/arr_item_lookup.dart';
import '../../../services/arr/arr_search_service.dart';
import '../../../theme/mono_tokens.dart';
import '../../../utils/rating_spans.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/arr_search_sheet.dart';
import '../../../widgets/loading_indicator_box.dart';
import '../../../widgets/optimized_media_image.dart';
import '../../../widgets/placeholder_container.dart';

/// What the *arr tracking this library wants and has no file for.
///
/// Its own tab rather than a shelf above the grid: the grid is one paged, sorted
/// query against the media server, and these titles are not in it at all — the
/// server has never heard of them.
class LibraryMissingTab extends StatefulWidget {
  const LibraryMissingTab({super.key, required this.library});

  final MediaLibrary library;

  /// Which instance answers for a library of this kind.
  static ManagedServiceKind? kindFor(MediaKind libraryKind) => switch (libraryKind) {
    MediaKind.movie => ManagedServiceKind.radarr,
    MediaKind.show => ManagedServiceKind.sonarr,
    _ => null,
  };

  @override
  State<LibraryMissingTab> createState() => _LibraryMissingTabState();
}

class _LibraryMissingTabState extends State<LibraryMissingTab> {
  VoidCallback? _release;

  ManagedServiceKind get _kind => LibraryMissingTab.kindFor(widget.library.kind)!;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ServerActivityProvider>();
    // Watching keeps the queue polled, which is what gives these rows progress.
    _release = provider.addWatcher();
    unawaited(provider.resolveAbsent(_kind));
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
        final titles = provider.absent(_kind);
        if (titles == null) {
          return const Center(child: LoadingIndicatorBox(size: 24));
        }
        if (titles.isEmpty) return _Empty(kind: _kind);

        return ListView.builder(
          padding: const EdgeInsets.only(top: 8, bottom: 24),
          itemCount: titles.length,
          itemBuilder: (context, index) {
            final title = titles[index];
            return _MissingRow(title: title, transfer: provider.transferFor(title));
          },
        );
      },
    );
  }
}

class _Empty extends StatelessWidget {
  const _Empty({required this.kind});

  final ManagedServiceKind kind;

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(PhosphorIcons.check, size: 28, color: tokensRef.textMuted),
            const SizedBox(height: 12),
            Text(
              t.serverActivity.nothingMissing,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: tokensRef.text),
            ),
            const SizedBox(height: 6),
            Text(
              t.serverActivity.nothingMissingDescription(service: kind.name),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: tokensRef.textMuted, height: 1.3),
            ),
          ],
        ),
      ),
    );
  }
}

class _MissingRow extends StatelessWidget {
  const _MissingRow({required this.title, this.transfer});

  final AbsentTitle title;
  final ServerTransfer? transfer;

  static const double _posterWidth = 44;

  Future<void> _search(BuildContext context) async {
    final state = ArrItemState(
      sourceId: title.sourceId,
      sourceName: title.sourceName,
      mediaId: title.mediaId,
      monitored: title.monitored,
    );
    final episodeId = title.episodeId;
    final target = title.isEpisode && episodeId != null ? EpisodeSearch(episodeId) : MovieSearch(title.mediaId);
    await showArrSearchSheet(context, state: state, target: target, scopeLabel: _label);
  }

  /// A film is its title; an episode is which show, which slot, and which one.
  String get _label {
    if (!title.isEpisode) return title.title;
    final slot = t.serverActivity.episodeSlot(season: title.seasonNumber ?? 0, episode: title.episodeNumber!);
    final parts = [?title.seriesTitle, slot, if (title.title.isNotEmpty) title.title];
    return parts.join(dotSeparator);
  }

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    final progress = transfer?.progress;

    return InkWell(
      onTap: () => unawaited(_search(context)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              child: SizedBox(width: _posterWidth, height: _posterWidth * 3 / 2, child: _poster(context)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _label,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: tokensRef.text, height: 1.3),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    _facts(),
                    style: TextStyle(fontSize: 12, color: tokensRef.textMuted, height: 1.3),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (progress != null) ...[
                    const SizedBox(height: 7),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(2)),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 3,
                        backgroundColor: tokensRef.text.withValues(alpha: 0.1),
                        valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Which instance said so, then when it aired or what year it is, then how far
  /// a download has got — the parts that exist, in that order.
  String _facts() {
    final transferItem = transfer;
    return [
      title.sourceName,
      if (title.airDate case final aired?)
        t.serverActivity.airedOn(date: DateFormat.MMMd(LocaleSettings.currentLocale.intlLocaleName).format(aired))
      else if (title.year case final year?)
        '$year',
      if (transferItem?.stage case final stage?) stage.label,
    ].join(dotSeparator);
  }

  Widget _poster(BuildContext context) {
    final fallback = PlaceholderContainer(
      color: tokens(context).text.withValues(alpha: 0.05),
      child: AppIcon(
        title.isEpisode ? PhosphorIcons.television : PhosphorIcons.filmSlate,
        size: 16,
        color: tokens(context).textMuted,
      ),
    );
    final url = title.posterUrl;
    if (url == null) return fallback;
    return OptimizedMediaImage.poster(
      client: null,
      imagePath: url,
      width: _posterWidth,
      height: _posterWidth * 3 / 2,
      errorWidget: (context, _, _) => fallback,
    );
  }
}
