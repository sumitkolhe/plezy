import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../onboarding_palette.dart';
import '../widgets/harbor_mark.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/rise_in.dart';

/// The first thing a new install shows: what Harbor needs, and one way to give
/// it. The address field and its two actions stay folded away until asked for.
class ConnectStep extends StatelessWidget {
  const ConnectStep({
    super.key,
    required this.controller,
    required this.expanded,
    required this.error,
    required this.onExpand,
    required this.onConnect,
    required this.onDiscover,
  });

  final TextEditingController controller;
  final bool expanded;
  final String? error;
  final VoidCallback onExpand;
  final VoidCallback onConnect;
  final VoidCallback onDiscover;

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 34),
            if (!expanded) ...[
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
                    const SizedBox(height: 11),
                    OnboardingSecondaryButton(
                      label: t.onboarding.findServers,
                      onPressed: onDiscover,
                      icon: const Icon(Icons.wifi_tethering, size: 18, color: OnboardingPalette.text),
                    ),
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
