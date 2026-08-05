import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../../../services/jellyfin_auth_service.dart';
import '../onboarding_palette.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/rise_in.dart';

/// Sign in to the server that answered.
///
/// The design does not have this step — it goes straight from an address to a
/// connected library. Jellyfin does not: reaching a server tells you nothing
/// about who you are on it. Rather than bolt a form onto another step, it gets
/// its own, built from the same parts, and leads with the server it found so
/// the address you typed is visibly confirmed before you type a password.
class SignInStep extends StatelessWidget {
  const SignInStep({
    super.key,
    required this.serverName,
    required this.serverAddress,
    required this.username,
    required this.password,
    required this.error,
    required this.quickConnectEnabled,
    required this.quickConnect,
    required this.onSignIn,
    required this.onQuickConnect,
    required this.onCancelQuickConnect,
    required this.onChangeServer,
  });

  final String serverName;
  final String serverAddress;
  final TextEditingController username;
  final TextEditingController password;
  final String? error;
  final bool quickConnectEnabled;
  final JellyfinQuickConnectInitiation? quickConnect;
  final VoidCallback onSignIn;
  final VoidCallback onQuickConnect;
  final VoidCallback onCancelQuickConnect;
  final VoidCallback onChangeServer;

  @override
  Widget build(BuildContext context) {
    if (quickConnect case final initiation?) {
      return _QuickConnectPanel(code: initiation.code, onCancel: onCancelQuickConnect);
    }
    return RiseIn(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          OnboardingMetrics.gutter,
          56,
          OnboardingMetrics.gutter,
          OnboardingMetrics.gutter,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OnboardingHeading(title: t.onboarding.signInTitle, centered: false, titleSize: 25),
            const SizedBox(height: 18),
            _ServerCard(name: serverName, address: serverAddress, onChange: onChangeServer),
            const SizedBox(height: 26),
            OnboardingField(
              label: t.addServer.username,
              controller: username,
              autofocus: true,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            OnboardingField(
              label: t.addServer.password,
              controller: password,
              obscureText: true,
              textInputAction: TextInputAction.go,
              onSubmitted: (_) => onSignIn(),
              error: error,
            ),
            const SizedBox(height: 24),
            OnboardingButton(label: t.addServer.signIn, onPressed: onSignIn),
            if (quickConnectEnabled) ...[
              const SizedBox(height: 11),
              OnboardingSecondaryButton(label: t.auth.useQuickConnect, onPressed: onQuickConnect),
            ],
          ],
        ),
      ),
    );
  }
}

/// What answered, and the way back if it is not the right one.
class _ServerCard extends StatelessWidget {
  const _ServerCard({required this.name, required this.address, required this.onChange});

  final String name;
  final String address;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: OnboardingPalette.fieldFill,
        borderRadius: BorderRadius.circular(OnboardingMetrics.radius),
        border: Border.all(color: OnboardingPalette.hairline),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, size: 20, color: OnboardingPalette.success),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: OnboardingPalette.text),
                ),
                const SizedBox(height: 2),
                Text(
                  address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12.5, color: OnboardingPalette.textFaint),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: onChange,
            child: Text(t.addServer.change, style: const TextStyle(fontSize: 13.5, color: OnboardingPalette.blue)),
          ),
        ],
      ),
    );
  }
}

/// Waiting for the code to be approved elsewhere. No spinner: there is nothing
/// happening on this device, and the only thing that matters is the code.
class _QuickConnectPanel extends StatelessWidget {
  const _QuickConnectPanel({required this.code, required this.onCancel});

  final String code;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return RiseIn(
      child: Padding(
        padding: const EdgeInsets.all(OnboardingMetrics.gutter),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnboardingHeading(title: t.auth.useQuickConnect, subtitle: t.auth.quickConnectInstructions),
            const SizedBox(height: 28),
            Text(
              code,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w600,
                letterSpacing: 8,
                color: OnboardingPalette.blue,
              ),
            ),
            const SizedBox(height: 24),
            Text(t.auth.quickConnectWaiting, style: const TextStyle(fontSize: 13, color: OnboardingPalette.textFaint)),
            const SizedBox(height: 32),
            OnboardingSecondaryButton(label: t.auth.quickConnectCancel, onPressed: onCancel),
          ],
        ),
      ),
    );
  }
}
