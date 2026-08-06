import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../../../services/jellyfin_lan_discovery_service.dart';
import '../onboarding_palette.dart';
import '../widgets/harbor_mark.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/rise_in.dart';

/// The first thing a new install shows: what Harbor needs, and one way to give
/// it. The address field and its action stay folded away until asked for.
///
/// Any server that answered the discovery broadcast is listed above the fold.
/// That scan runs on its own in the background and is never mentioned: a
/// broadcast cannot reach a server behind Docker's bridge or on another subnet,
/// which is most of them, and an offer that usually fails is worse than no
/// offer. When it does work the servers are simply there.
class ConnectStep extends StatelessWidget {
  const ConnectStep({
    super.key,
    required this.controller,
    required this.expanded,
    required this.error,
    required this.discovered,
    required this.onExpand,
    required this.onConnect,
    required this.onPick,
  });

  final TextEditingController controller;
  final bool expanded;
  final String? error;
  final List<DiscoveredJellyfinServer> discovered;
  final VoidCallback onExpand;
  final VoidCallback onConnect;
  final ValueChanged<DiscoveredJellyfinServer> onPick;

  @override
  Widget build(BuildContext context) {
    final found = discovered.isNotEmpty;
    return RiseIn(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          OnboardingMetrics.gutter,
          72,
          OnboardingMetrics.gutter,
          OnboardingMetrics.gutter,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(child: HarborMark(size: 68)),
            const SizedBox(height: 20),
            OnboardingHeading(title: t.onboarding.connectTitle, subtitle: t.onboarding.connectBody),
            if (found) ...[const SizedBox(height: 30), _DiscoveredServers(servers: discovered, onPick: onPick)],
            const SizedBox(height: 30),
            if (!expanded) ...[
              // Picking a server that already answered beats typing an address,
              // so manual entry steps down to the secondary action when there is
              // something to pick.
              if (found)
                OnboardingSecondaryButton(label: t.onboarding.addServer, onPressed: onExpand)
              else ...[
                OnboardingButton(
                  label: t.onboarding.addServer,
                  onPressed: onExpand,
                  icon: const Icon(Icons.add, size: 18, color: OnboardingPalette.text),
                ),
                const SizedBox(height: 13),
                Text(
                  t.onboarding.addServerHint,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 13, color: OnboardingPalette.textFaint),
                ),
              ],
            ] else
              RiseIn(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    OnboardingField(
                      label: t.onboarding.serverAddress,
                      controller: controller,
                      // An address, not prose — never localised.
                      hintText: 'http://192.168.1.10:8096',
                      error: error,
                      autofocus: true,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.go,
                      onSubmitted: (_) => onConnect(),
                    ),
                    const SizedBox(height: 22),
                    OnboardingButton(label: t.auth.connectToJellyfin, onPressed: onConnect),
                  ],
                ),
              ),
            if (!expanded && error != null) ...[const SizedBox(height: 16), OnboardingErrorText(error!)],
            const SizedBox(height: 40),
            const _PrivacyNote(),
          ],
        ),
      ),
    );
  }
}

class _DiscoveredServers extends StatelessWidget {
  const _DiscoveredServers({required this.servers, required this.onPick});

  final List<DiscoveredJellyfinServer> servers;
  final ValueChanged<DiscoveredJellyfinServer> onPick;

  @override
  Widget build(BuildContext context) {
    return RiseIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            t.addServer.localServers.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w500,
              color: OnboardingPalette.textFaint,
            ),
          ),
          const SizedBox(height: 6),
          for (final server in servers) _ServerRow(server: server, onTap: () => onPick(server)),
          const Divider(height: 1, color: OnboardingPalette.hairline),
        ],
      ),
    );
  }
}

class _ServerRow extends StatelessWidget {
  const _ServerRow({required this.server, required this.onTap});

  final DiscoveredJellyfinServer server;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 2),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: OnboardingPalette.hairline)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: OnboardingPalette.blue.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.dns_outlined, size: 19, color: OnboardingPalette.blue),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    server.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600, color: OnboardingPalette.text),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    server.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13, color: OnboardingPalette.textFaint),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 18, color: OnboardingPalette.textFainter),
          ],
        ),
      ),
    );
  }
}

/// The reassurance the screen is asking someone to act on: this is their
/// server, and the password they are about to type is not going anywhere.
class _PrivacyNote extends StatelessWidget {
  const _PrivacyNote();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_outline, size: 14, color: OnboardingPalette.textFaint),
        const SizedBox(width: 8),
        Text(
          t.onboarding.credentialsStayOnDevice,
          style: const TextStyle(fontSize: 13, color: OnboardingPalette.textFaint),
        ),
      ],
    );
  }
}
