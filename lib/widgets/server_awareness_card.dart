import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../i18n/app_locale_utils.dart';
import '../i18n/strings.g.dart';
import '../models/arr/server_transfer.dart';
import '../providers/server_activity_provider.dart';
import '../services/arr/arr_item_lookup.dart';
import '../theme/mono_tokens.dart';
import '../utils/external_ids.dart';

/// Awareness, not administration: what is arriving for this title, while you
/// are deciding whether to watch it.
///
/// Collapses to nothing when no instance tracks the item or nothing is queued,
/// so a page with no *arr behind it is unchanged.
class ServerAwarenessCard extends StatefulWidget {
  final ExternalIds ids;
  final bool isSeries;

  const ServerAwarenessCard({super.key, required this.ids, required this.isSeries});

  @override
  State<ServerAwarenessCard> createState() => _ServerAwarenessCardState();
}

class _ServerAwarenessCardState extends State<ServerAwarenessCard> {
  VoidCallback? _release;

  @override
  void initState() {
    super.initState();
    final provider = context.read<ServerActivityProvider>();
    _release = provider.addWatcher();
    unawaited(provider.resolveItem(widget.ids, isSeries: widget.isSeries));
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
        final states = provider.itemState(widget.ids, isSeries: widget.isSeries);
        if (states == null || states.isEmpty) return const SizedBox.shrink();

        final transfers = provider.transfersFor(states);
        if (transfers.isEmpty) return const SizedBox.shrink();

        // The one furthest along is the one worth reporting; the rest become a
        // count, since a card listing six release names is a queue, not a hint.
        final lead = transfers.reduce((a, b) => a.stage.index >= b.stage.index ? a : b);
        return Padding(
          padding: const EdgeInsets.only(top: 14),
          child: _Card(transfer: lead, alsoQueued: transfers.length - 1),
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  final ServerTransfer transfer;
  final int alsoQueued;

  const _Card({required this.transfer, required this.alsoQueued});

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    final progress = transfer.progress;
    final accent = _accent(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
      decoration: BoxDecoration(
        color: tokensRef.surface,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        border: Border.all(color: tokensRef.outline),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  _headline(),
                  style: TextStyle(fontSize: 13, fontWeight: .w600, color: tokensRef.text),
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _trailing(),
                style: TextStyle(
                  fontSize: 12,
                  color: accent,
                  fontWeight: .w600,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          if (progress != null && transfer.stage != TransferStage.done) ...[
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(MonoTokens.radiusFull)),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 3,
                backgroundColor: tokensRef.text.withValues(alpha: 0.10),
                valueColor: AlwaysStoppedAnimation(accent),
              ),
            ),
          ],
          if (_detail() case final detail when detail.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(detail, style: TextStyle(fontSize: 11.5, color: tokensRef.textMuted, height: 1.35)),
          ],
        ],
      ),
    );
  }

  /// Names the episode when Sonarr said which, rather than showing the release
  /// string — "the.bear.s03e04.1080p.web" is not what you came to read.
  String _headline() {
    final season = transfer.queued?.seasonNumber;
    final episode = transfer.queued?.episodeNumber;
    if (season != null && episode != null) {
      return t.serverActivity.arrivingEpisode(season: season, episode: episode);
    }
    return t.serverActivity.arriving;
  }

  String _trailing() {
    if (transfer.stage == TransferStage.failed) return t.serverActivity.stages.failed;
    if (transfer.isStalled) return t.serverActivity.stalled;
    final progress = transfer.progress;
    if (transfer.stage == TransferStage.downloading && progress != null) {
      final percent = '${(progress * 100).round()}%';
      final eta = transfer.etaSeconds;
      return eta == null ? percent : '$percent · ${_shortEta(eta)}';
    }
    return switch (transfer.stage) {
      TransferStage.importing => t.serverActivity.stages.importing,
      TransferStage.done => t.serverActivity.stages.done,
      _ => t.serverActivity.stages.queued,
    };
  }

  String _detail() {
    final error = transfer.errorMessage;
    if (error.isNotEmpty) return error;
    final parts = <String>[
      if (transfer.sourceName.isNotEmpty) transfer.sourceName,
      if (alsoQueued > 0) t.serverActivity.alsoQueued(count: alsoQueued),
    ];
    return parts.join('  ·  ');
  }

  /// Minutes and hours only: a card is a glance, and "12 min" beats "12m 04s".
  String _shortEta(int seconds) {
    if (seconds < 60) return t.serverActivity.etaRemaining(time: '<1 min');
    final minutes = seconds ~/ 60;
    if (minutes < 60) return t.serverActivity.etaRemaining(time: '$minutes min');
    final hours = minutes ~/ 60;
    return t.serverActivity.etaRemaining(time: '${hours}h ${minutes % 60}m');
  }

  Color _accent(BuildContext context) {
    if (transfer.stage == TransferStage.failed) return Theme.of(context).colorScheme.error;
    if (transfer.isStalled) return Colors.amber;
    return switch (transfer.stage) {
      TransferStage.done => Colors.green,
      TransferStage.importing => Colors.amber,
      _ => Theme.of(context).colorScheme.primary,
    };
  }
}

/// Empty for films, ended series, and until the lookup lands.
String nextAiringLabel(List<ArrItemState>? states) {
  if (states == null || states.isEmpty) return '';
  final state = states.firstWhere((s) => s.monitored, orElse: () => states.first);
  final next = state.nextAiring;
  if (next == null) return '';
  final days = next.difference(DateTime.now()).inDays;
  final date = DateFormat.MMMEd(LocaleSettings.currentLocale.intlLocaleName).format(next);
  return days > 6 ? date : t.serverActivity.nextAiring(when: date);
}

/// Monitoring and completeness as rows for the detail page's info table.
List<({String label, String value})> serverInfoRows(List<ArrItemState>? states, {required bool isSeries}) {
  if (states == null || states.isEmpty) return const [];
  // With the same title in two instances, the monitored one is the one worth
  // reporting: a 4K copy left unmonitored does not mean the title is ignored.
  final state = states.firstWhere((s) => s.monitored, orElse: () => states.first);

  return [
    (
      label: t.serverActivity.monitored,
      value: state.monitored
          ? [
              t.serverActivity.monitored,
              if (state.qualityProfile.isNotEmpty) state.qualityProfile,
            ].join('  ·  ')
          : t.serverActivity.notMonitored,
    ),
    if (nextAiringLabel(states) case final next when next.isNotEmpty)
      (label: t.explore.detail.schedule, value: next),
    if (isSeries && state.totalCount > 0)
      (
        label: t.serverActivity.stages.done,
        value: state.missingCount == 0
            ? t.serverActivity.allPresent
            : t.serverActivity.missingEpisodes(count: state.missingCount),
      )
    else if (!isSeries)
      (
        label: t.serverActivity.stages.done,
        value: state.fileCount > 0 ? t.serverActivity.onDisk : t.serverActivity.notOnDisk,
      ),
  ];
}
