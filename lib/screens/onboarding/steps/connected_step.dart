import 'package:flutter/material.dart';

import '../../../connection/connection.dart';
import '../../../i18n/strings.g.dart';
import '../../../services/jellyfin_client.dart';
import '../onboarding_palette.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/rise_in.dart';

/// Confirm the connection with what was actually found on the other end.
///
/// A tick alone says the request succeeded; counts say the library is really
/// there, which is the thing someone setting this up wants to know. There is no
/// storage figure because Jellyfin does not report one.
class ConnectedStep extends StatefulWidget {
  const ConnectedStep({super.key, required this.connection, required this.onEnter});

  final JellyfinConnection connection;
  final VoidCallback onEnter;

  @override
  State<ConnectedStep> createState() => _ConnectedStepState();
}

class _ConnectedStepState extends State<ConnectedStep> {
  /// Null until the call lands, and left null if it fails — the counts are
  /// confirmation, never a gate on getting into the app.
  JellyfinItemCounts? _counts;

  @override
  void initState() {
    super.initState();
    _loadCounts();
  }

  Future<void> _loadCounts() async {
    JellyfinClient? client;
    try {
      client = await JellyfinClient.create(widget.connection);
      final counts = await client.fetchItemCounts();
      if (mounted) setState(() => _counts = counts);
    } catch (_) {
      // Nothing to say: the connection is already proven by getting here.
    } finally {
      client?.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final counts = _counts;
    return RiseIn(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          OnboardingMetrics.gutter,
          0,
          OnboardingMetrics.gutter,
          OnboardingMetrics.gutter,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 70,
                height: 70,
                decoration: const BoxDecoration(color: OnboardingPalette.successContainer, shape: BoxShape.circle),
                child: const Icon(Icons.check, size: 32, color: OnboardingPalette.onSuccessContainer),
              ),
            ),
            const SizedBox(height: 26),
            Text(widget.connection.serverName, textAlign: TextAlign.center, style: OnboardingType.headline),
            const SizedBox(height: 9),
            Text(
              t.onboarding.signedInAs(user: widget.connection.userName),
              textAlign: TextAlign.center,
              style: OnboardingType.body,
            ),
            if (counts != null && !counts.isEmpty) ...[
              const SizedBox(height: 32),
              _CountRow(label: t.onboarding.moviesLabel, value: '${counts.movies}'),
              _CountRow(label: t.onboarding.seriesLabel, value: '${counts.series}'),
              _CountRow(label: t.onboarding.episodesLabel, value: '${counts.episodes}', last: true),
            ],
            const SizedBox(height: 32),
            OnboardingButton(label: t.onboarding.continueAction, onPressed: widget.onEnter),
          ],
        ),
      ),
    );
  }
}

class _CountRow extends StatelessWidget {
  const _CountRow({required this.label, required this.value, this.last = false});

  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 11),
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(color: OnboardingPalette.outlineVariant),
          bottom: last ? const BorderSide(color: OnboardingPalette.outlineVariant) : BorderSide.none,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Text(label, style: const TextStyle(fontSize: 13, color: OnboardingPalette.onSurfaceVariant)),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, color: OnboardingPalette.onSurface),
          ),
        ],
      ),
    );
  }
}
