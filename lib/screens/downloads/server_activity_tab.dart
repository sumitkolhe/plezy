import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:provider/provider.dart';

import '../../i18n/strings.g.dart';
import '../../models/arr/server_transfer.dart';
import '../../providers/server_activity_provider.dart';
import '../../theme/mono_tokens.dart';
import '../../utils/formatters.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/loading_indicator_box.dart';
import '../libraries/state_messages.dart';
import '../settings/services_settings_screen.dart';

/// What is arriving on the server: one row per download, folding each *arr
/// queue record together with the client torrent behind it.
class ServerActivityTab extends StatefulWidget {
  const ServerActivityTab({super.key});

  @override
  State<ServerActivityTab> createState() => _ServerActivityTabState();
}

class _ServerActivityTabState extends State<ServerActivityTab> {
  VoidCallback? _release;

  @override
  void initState() {
    super.initState();
    // Polling only runs while this tab is mounted.
    _release = context.read<ServerActivityProvider>().addWatcher();
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
        if (!provider.hasServices) return const _NoServices();
        if (!provider.loadedOnce) {
          return const Center(child: Padding(padding: EdgeInsets.all(32), child: LoadingIndicatorBox()));
        }

        final ongoing = [
          for (final transfer in provider.transfers)
            if (transfer.stage != TransferStage.done) transfer,
        ];
        final completed = [
          for (final transfer in provider.transfers)
            if (transfer.stage == TransferStage.done) transfer,
        ];

        if (ongoing.isEmpty && completed.isEmpty && provider.unreachable.isEmpty) {
          return EmptyStateWidget(
            message: t.serverActivity.nothingQueued,
            subtitle: t.serverActivity.nothingQueuedDescription,
            icon: PhosphorIcons.download,
            iconSize: 80,
          );
        }

        return RefreshIndicator(
          onRefresh: provider.refresh,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
            children: [
              if (provider.unreachable.isNotEmpty) _UnreachableNotice(names: provider.unreachable),
              for (final transfer in ongoing) _TransferRow(key: ValueKey(transfer.id), transfer: transfer),
              if (completed.isNotEmpty) ...[
                const SizedBox(height: 18),
                Text(
                  t.serverActivity.completedHeading,
                  style: TextStyle(fontSize: 15, fontWeight: .w700, color: tokens(context).text),
                ),
                for (final transfer in completed) _TransferRow(key: ValueKey(transfer.id), transfer: transfer),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _NoServices extends StatelessWidget {
  const _NoServices();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: .min,
          children: [
            AppIcon(PhosphorIcons.hardDrives, size: 56, color: tokens(context).textMuted),
            const SizedBox(height: 18),
            Text(
              t.serverActivity.noServices,
              style: TextStyle(fontSize: 16, fontWeight: .w600, color: tokens(context).text),
              textAlign: .center,
            ),
            const SizedBox(height: 8),
            Text(
              t.serverActivity.noServicesDescription,
              style: TextStyle(fontSize: 13, color: tokens(context).textMuted, height: 1.4),
              textAlign: .center,
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(builder: (_) => const ServicesSettingsScreen()),
              ),
              child: Text(t.serverActivity.openServices),
            ),
          ],
        ),
      ),
    );
  }
}

/// Names the instances that failed this poll, so a short list is not read as
/// an empty queue.
class _UnreachableNotice extends StatelessWidget {
  final List<String> names;

  const _UnreachableNotice({required this.names});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.error;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          AppIcon(PhosphorIcons.warningCircle, size: 15, color: color),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              t.serverActivity.unreachable(names: names.join(', ')),
              style: TextStyle(fontSize: 12.5, color: color),
            ),
          ),
        ],
      ),
    );
  }
}

class _TransferRow extends StatelessWidget {
  final ServerTransfer transfer;

  const _TransferRow({super.key, required this.transfer});

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    final progress = transfer.progress;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: Text(
                  transfer.title,
                  style: TextStyle(fontSize: 13.5, fontWeight: .w600, color: tokensRef.text, height: 1.3),
                  maxLines: 2,
                  overflow: .ellipsis,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                _trailing(context),
                style: TextStyle(
                  fontSize: 12,
                  color: tokensRef.textMuted,
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
                valueColor: AlwaysStoppedAnimation(_stageColor(context)),
              ),
            ),
          ],
          const SizedBox(height: 7),
          _StageStrip(transfer: transfer),
          if (_via(context) case final via when via.isNotEmpty) ...[
            const SizedBox(height: 5),
            Text(via, style: TextStyle(fontSize: 11.5, color: _detailColor(context), height: 1.35)),
          ],
        ],
      ),
    );
  }

  Color _stageColor(BuildContext context) {
    if (transfer.stage == TransferStage.failed) return Theme.of(context).colorScheme.error;
    if (transfer.isStalled) return Colors.amber;
    return switch (transfer.stage) {
      TransferStage.done => Colors.green,
      TransferStage.importing => Colors.amber,
      _ => Theme.of(context).colorScheme.primary,
    };
  }

  Color _detailColor(BuildContext context) =>
      transfer.stage == TransferStage.failed || transfer.isStalled ? _stageColor(context) : tokens(context).textMuted;

  /// Percentage while transferring, the stage's own word otherwise — a bare
  /// "100%" through a long import reads as finished when it is not.
  String _trailing(BuildContext context) {
    // Paused is not queued: one is about to start, the other will not.
    if (transfer.torrent?.isPaused ?? false) return t.serverActivity.paused;
    final progress = transfer.progress;
    if (transfer.stage == TransferStage.downloading && progress != null) {
      final percent = '${(progress * 100).round()}%';
      final eta = transfer.etaSeconds;
      if (transfer.isStalled) return '$percent · ${t.serverActivity.stalled}';
      if (eta == null) return percent;
      return '$percent · ${t.serverActivity.etaRemaining(time: formatDurationTextual(eta * 1000))}';
    }
    return _stageLabel(transfer.stage);
  }

  /// Where it is coming from, and what went wrong when something did. *arr's
  /// own message is kept verbatim: "Unpack failed" is the answer, and rewording
  /// it would lose it.
  String _via(BuildContext context) {
    final error = transfer.errorMessage;
    if (error.isNotEmpty) return error;

    final parts = <String>[
      if (transfer.sourceName.isNotEmpty) transfer.sourceName,
      if (transfer.size > 0)
        t.serverActivity.ofSize(
          done: ByteFormatter.formatBytes(transfer.bytesDone),
          total: ByteFormatter.formatBytes(transfer.size),
        ),
    ];
    return parts.join('  ·  ');
  }

  static String _stageLabel(TransferStage stage) => switch (stage) {
    TransferStage.queued => t.serverActivity.stages.queued,
    TransferStage.downloading => t.serverActivity.stages.downloading,
    TransferStage.importing => t.serverActivity.stages.importing,
    TransferStage.done => t.serverActivity.stages.done,
    TransferStage.failed => t.serverActivity.stages.failed,
  };
}

/// The join, made visible: which of the four stages this download has reached.
class _StageStrip extends StatelessWidget {
  final ServerTransfer transfer;

  const _StageStrip({required this.transfer});

  static const List<TransferStage> _pipeline = [
    TransferStage.queued,
    TransferStage.downloading,
    TransferStage.importing,
    TransferStage.done,
  ];

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    final current = transfer.stage;
    // A failure keeps the strip on the stage it died at rather than showing a
    // fifth cell nothing ever passes through.
    final reached = current == TransferStage.failed ? TransferStage.downloading.index : current.index;

    return Wrap(
      spacing: 5,
      runSpacing: 2,
      crossAxisAlignment: .center,
      children: [
        for (var i = 0; i < _pipeline.length; i++) ...[
          if (i > 0)
            Text('›', style: TextStyle(fontSize: 11, color: tokensRef.text.withValues(alpha: 0.24))),
          Text(
            _TransferRow._stageLabel(_pipeline[i]),
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: i == reached ? .w700 : .w500,
              letterSpacing: 0.2,
              color: i == reached
                  ? _current(context)
                  : tokensRef.text.withValues(alpha: i < reached ? 0.6 : 0.32),
            ),
          ),
        ],
      ],
    );
  }

  Color _current(BuildContext context) {
    if (transfer.stage == TransferStage.failed) return Theme.of(context).colorScheme.error;
    if (transfer.isStalled) return Colors.amber;
    return switch (transfer.stage) {
      TransferStage.done => Colors.green,
      TransferStage.importing => Colors.amber,
      _ => Theme.of(context).colorScheme.primary,
    };
  }
}
