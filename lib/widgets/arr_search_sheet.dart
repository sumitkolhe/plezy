import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:provider/provider.dart';

import '../i18n/strings.g.dart';
import '../models/arr/arr_release.dart';
import '../providers/managed_services_provider.dart';
import '../services/arr/arr_item_lookup.dart';
import '../services/arr/arr_search_service.dart';
import '../theme/mono_tokens.dart';
import '../utils/formatters.dart';
import '../utils/rating_spans.dart';
import '../utils/snackbar_helper.dart';
import 'app_icon.dart';
import 'app_menu.dart';
import 'bottom_sheet_header.dart';
import 'loading_indicator_box.dart';
import 'overlay_sheet.dart';

/// Offers the two searches *arr can do for one target, and lists candidate
/// releases when you want to pick yourself.
Future<void> showArrSearchSheet(
  BuildContext context, {
  required ArrItemState state,
  required ArrSearchTarget target,
  required String scopeLabel,
}) {
  return OverlaySheetController.showAdaptive<void>(
    context,
    isScrollControlled: true,
    builder: (_) => _ArrSearchSheet(state: state, target: target, scopeLabel: scopeLabel),
  );
}

class _ArrSearchSheet extends StatefulWidget {
  final ArrItemState state;
  final ArrSearchTarget target;
  final String scopeLabel;

  const _ArrSearchSheet({required this.state, required this.target, required this.scopeLabel});

  @override
  State<_ArrSearchSheet> createState() => _ArrSearchSheetState();
}

class _ArrSearchSheetState extends State<_ArrSearchSheet> {
  bool _searching = false;
  bool _failed = false;
  List<ArrRelease>? _releases;
  String? _grabbing;

  ArrSearchService get _service => ArrSearchService(context.read<ManagedServicesProvider>());
  String get _serviceName => widget.state.sourceName;

  Future<void> _auto() async {
    final messenger = ScaffoldMessenger.of(context);
    OverlaySheetController.closeAdaptive(context, null);
    try {
      await _service.searchAutomatically(widget.state, widget.target);
      messenger.showSnackBar(SnackBar(content: Text(t.arrSearch.handedOver(service: _serviceName))));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text(t.arrSearch.failed)));
    }
  }

  Future<void> _manual() async {
    setState(() {
      _searching = true;
      _failed = false;
    });
    try {
      final releases = await _service.releases(widget.state, widget.target);
      if (!mounted) return;
      setState(() {
        _releases = releases;
        _searching = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _searching = false;
        _failed = true;
      });
    }
  }

  Future<void> _grab(ArrRelease release) async {
    if (release.rejected && !await _confirmRejected(release)) return;
    if (!mounted) return;
    setState(() => _grabbing = release.guid);
    try {
      await _service.grab(widget.state, release);
      if (!mounted) return;
      OverlaySheetController.closeAdaptive(context, null);
      showSuccessSnackBar(context, t.arrSearch.grabbed(service: _serviceName));
    } catch (e) {
      if (!mounted) return;
      setState(() => _grabbing = null);
      showErrorSnackBar(context, t.arrSearch.grabFailed(service: _serviceName));
    }
  }

  /// *arr's rejections are advice, not a lock — but grabbing past them should be
  /// deliberate, so the reasons are shown before it happens.
  Future<bool> _confirmRejected(ArrRelease release) async {
    final choice = await showAdaptiveAppMenu<bool>(
      context,
      title: t.arrSearch.rejectedTitle(service: _serviceName),
      entries: [
        for (final reason in release.rejections)
          AppMenuItem<bool>(value: false, icon: PhosphorIcons.warningCircle, label: reason, enabled: false),
        AppMenuItem<bool>(value: true, icon: PhosphorIcons.download, label: t.arrSearch.grabAnyway),
      ],
    );
    return choice ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    return Column(
      mainAxisSize: .min,
      children: [
        BottomSheetHeader(title: t.arrSearch.title),
        Flexible(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                Text(
                  widget.scopeLabel,
                  style: TextStyle(fontSize: 15, fontWeight: .w600, color: tokensRef.text, height: 1.3),
                ),
                const SizedBox(height: 16),
                if (_releases == null) ..._buildChoices(context) else ..._buildResults(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildChoices(BuildContext context) {
    if (_searching) {
      return [
        const Padding(padding: EdgeInsets.symmetric(vertical: 26), child: Center(child: LoadingIndicatorBox(size: 24))),
        Text(
          t.arrSearch.searching,
          textAlign: .center,
          style: TextStyle(fontSize: 13, color: tokens(context).text),
        ),
        const SizedBox(height: 4),
        Text(
          t.arrSearch.searchingSlow,
          textAlign: .center,
          style: TextStyle(fontSize: 12, color: tokens(context).textMuted),
        ),
      ];
    }
    return [
      _Choice(
        icon: PhosphorIcons.lightning,
        title: t.arrSearch.auto,
        subtitle: t.arrSearch.autoDescription(service: _serviceName),
        onTap: () => unawaited(_auto()),
      ),
      const SizedBox(height: 8),
      _Choice(
        icon: PhosphorIcons.magnifyingGlass,
        title: t.arrSearch.manual,
        subtitle: t.arrSearch.manualDescription,
        onTap: () => unawaited(_manual()),
      ),
      if (_failed) ...[
        const SizedBox(height: 14),
        Text(
          t.arrSearch.failed,
          style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.error),
        ),
      ],
    ];
  }

  List<Widget> _buildResults(BuildContext context) {
    final releases = _releases!;
    if (releases.isEmpty) {
      return [
        const SizedBox(height: 20),
        Text(
          t.arrSearch.noReleases,
          textAlign: .center,
          style: TextStyle(fontSize: 15, fontWeight: .w600, color: tokens(context).text),
        ),
        const SizedBox(height: 6),
        Text(
          t.arrSearch.noReleasesDescription,
          textAlign: .center,
          style: TextStyle(fontSize: 13, color: tokens(context).textMuted),
        ),
      ];
    }
    // The indexer only earns a place when the results come from more than one.
    final showIndexer = releases.map((r) => r.indexer).toSet().length > 1;
    return [
      for (final release in releases)
        _ReleaseRow(
          release: release,
          busy: _grabbing == release.guid,
          enabled: _grabbing == null,
          showIndexer: showIndexer,
          onTap: () => unawaited(_grab(release)),
        ),
    ];
  }
}

class _Choice extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _Choice({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    const shape = BorderRadius.all(Radius.circular(12));
    return Material(
      color: tokensRef.text.withValues(alpha: 0.06),
      borderRadius: shape,
      child: InkWell(
        borderRadius: shape,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Row(
            children: [
              AppIcon(icon, size: 20, color: tokensRef.text),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(title, style: TextStyle(fontSize: 14, fontWeight: .w600, color: tokensRef.text)),
                    const SizedBox(height: 2),
                    Text(subtitle, style: TextStyle(fontSize: 12, color: tokensRef.textMuted, height: 1.3)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReleaseRow extends StatelessWidget {
  final ArrRelease release;
  final bool busy;
  final bool enabled;
  final bool showIndexer;
  final VoidCallback onTap;

  const _ReleaseRow({
    required this.release,
    required this.busy,
    required this.enabled,
    required this.showIndexer,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    final rejected = release.rejected;

    return InkWell(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 11),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              crossAxisAlignment: .start,
              children: [
                Expanded(
                  child: Text(
                    release.title,
                    style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: .w500,
                      height: 1.35,
                      color: tokensRef.text.withValues(alpha: rejected ? 0.55 : 0.95),
                    ),
                    maxLines: 2,
                    overflow: .ellipsis,
                  ),
                ),
                if (busy) ...[const SizedBox(width: 10), const LoadingIndicatorBox(size: 14)],
              ],
            ),
            const SizedBox(height: 5),
            Text(
              _facts(),
              style: TextStyle(
                fontSize: 12,
                color: tokensRef.textMuted,
                height: 1.3,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
            // The reason is the whole value of showing a rejected release: it
            // says what to pick instead.
            if (rejected && release.rejections.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                release.rejections.first,
                style: TextStyle(fontSize: 11.5, color: Colors.amber, height: 1.3),
                maxLines: 2,
                overflow: .ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// One line: what it is, how big, how healthy. Health is seeders for a torrent
  /// and age for usenet, so only the meaningful one appears.
  String _facts() {
    final hours = release.ageHours;
    return [
      if (release.quality.isNotEmpty) release.quality,
      if (release.size > 0) ByteFormatter.formatBytes(release.size),
      if (release.seeders case final seeders?)
        t.arrSearch.seeders(count: seeders)
      else if (hours > 0)
        hours < 48 ? t.arrSearch.ageHours(count: hours) : t.arrSearch.ageDays(count: hours ~/ 24),
      if (showIndexer && release.indexer.isNotEmpty) release.indexer,
    ].join(dotSeparator);
  }
}
