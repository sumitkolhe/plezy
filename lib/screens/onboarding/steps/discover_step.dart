import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../../../services/jellyfin_lan_discovery_service.dart';
import '../onboarding_palette.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/rise_in.dart';

/// Ask the network who is listening, then show what answered.
///
/// Typing an address stays one tap away underneath, because discovery is a
/// convenience and a server on another subnet will never appear here.
class DiscoverStep extends StatelessWidget {
  const DiscoverStep({
    super.key,
    required this.scanning,
    required this.servers,
    required this.onBack,
    required this.onRetry,
    required this.onPick,
  });

  final bool scanning;
  final List<DiscoveredJellyfinServer> servers;
  final VoidCallback onBack;
  final VoidCallback onRetry;
  final ValueChanged<DiscoveredJellyfinServer> onPick;

  @override
  Widget build(BuildContext context) {
    return RiseIn(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Semantics(
                button: true,
                label: t.common.back,
                child: Material(
                  color: OnboardingPalette.fieldFill,
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: onBack,
                    customBorder: const CircleBorder(),
                    child: const SizedBox(
                      width: 38,
                      height: 38,
                      child: Icon(Icons.arrow_back, size: 18, color: OnboardingPalette.text),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 26),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: OnboardingHeading(title: _title, subtitle: _subtitle, centered: false, titleSize: 25),
            ),
            Expanded(
              child: scanning ? const _Sonar() : _Results(servers: servers, onPick: onPick, onBack: onBack),
            ),
            if (!scanning && servers.isEmpty) OnboardingSecondaryButton(label: t.common.retry, onPressed: onRetry),
          ],
        ),
      ),
    );
  }

  String get _title {
    if (scanning) return t.onboarding.scanning;
    if (servers.isEmpty) return t.onboarding.noServersFound;
    return t.onboarding.serversFound(n: servers.length);
  }

  String get _subtitle {
    if (scanning) return t.onboarding.scanningBody;
    if (servers.isEmpty) return t.onboarding.noServersFoundBody;
    return t.onboarding.serversFoundBody;
  }
}

/// Two rings going out, a beat apart. The only honest thing to show while a
/// UDP broadcast either gets answered or does not.
class _Sonar extends StatefulWidget {
  const _Sonar();

  @override
  State<_Sonar> createState() => _SonarState();
}

class _SonarState extends State<_Sonar> with SingleTickerProviderStateMixin {
  late final AnimationController _pulse = AnimationController(vsync: this, duration: const Duration(seconds: 2))
    ..repeat();

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 70),
        AnimatedBuilder(
          animation: _pulse,
          builder: (context, child) => SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              alignment: Alignment.center,
              children: [_ring(_pulse.value), _ring((_pulse.value + 0.5) % 1), child!],
            ),
          ),
          child: const Icon(Icons.wifi_tethering, size: 26, color: OnboardingPalette.blue),
        ),
        const SizedBox(height: 22),
        _BreathingText(t.onboarding.scanningDetail),
      ],
    );
  }

  Widget _ring(double t) => Transform.scale(
    scale: 0.7 + t * 1.1,
    child: Opacity(
      opacity: (0.6 * (1 - t)).clamp(0, 1),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: OnboardingPalette.blue, width: 2),
        ),
      ),
    ),
  );
}

class _BreathingText extends StatefulWidget {
  const _BreathingText(this.text);

  final String text;

  @override
  State<_BreathingText> createState() => _BreathingTextState();
}

class _BreathingTextState extends State<_BreathingText> with SingleTickerProviderStateMixin {
  late final AnimationController _breathe = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _breathe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _breathe,
      builder: (context, child) => Opacity(opacity: 0.45 + 0.55 * math.sin(_breathe.value * math.pi / 2), child: child),
      child: Text(widget.text, style: const TextStyle(fontSize: 13, color: OnboardingPalette.textFaint)),
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({required this.servers, required this.onPick, required this.onBack});

  final List<DiscoveredJellyfinServer> servers;
  final ValueChanged<DiscoveredJellyfinServer> onPick;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 20),
      children: [
        for (final server in servers) _ServerRow(server: server, onTap: () => onPick(server)),
        if (servers.isNotEmpty) const Divider(height: 1, color: OnboardingPalette.hairline),
        const SizedBox(height: 20),
        OnboardingSecondaryButton(label: t.onboarding.enterAddressInstead, onPressed: onBack),
      ],
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
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 4),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: OnboardingPalette.hairline)),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: OnboardingPalette.blue.withValues(alpha: 0.14),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.dns_outlined, size: 20, color: OnboardingPalette.blue),
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
