import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../../../theme/mono_tokens.dart';
import '../onboarding_style.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/rise_in.dart';

/// Which way the user is proving who they are.
enum SignInMode { password, quickConnect }

/// Sign in to the server that answered.
///
/// The design does not have this step in its happy path drawing, but Jellyfin
/// does: reaching a server tells you nothing about who you are on it. Password
/// leads because every server supports it; Quick Connect sits one tap below and
/// only when the server offers it.
class SignInStep extends StatelessWidget {
  const SignInStep({
    super.key,
    required this.serverName,
    required this.mode,
    required this.username,
    required this.password,
    required this.obscurePassword,
    required this.error,
    required this.quickConnectEnabled,
    required this.quickConnectCode,
    required this.busy,
    required this.onSignIn,
    required this.onToggleObscure,
    required this.onUseQuickConnect,
    required this.onUsePassword,
  });

  final String serverName;
  final SignInMode mode;
  final TextEditingController username;
  final TextEditingController password;
  final bool obscurePassword;
  final String? error;
  final bool quickConnectEnabled;

  /// Null until the server has issued one.
  final String? quickConnectCode;

  /// Authenticating. Carried by the button, like the connect step's wait.
  final bool busy;

  final VoidCallback onSignIn;
  final VoidCallback onToggleObscure;
  final VoidCallback onUseQuickConnect;
  final VoidCallback onUsePassword;

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    final quick = mode == SignInMode.quickConnect;
    return RiseIn(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(OnboardingMetrics.gutter, 56, OnboardingMetrics.gutter, 34),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: OnboardingChip(
                label: t.onboarding.serverReachable(server: serverName),
                tone: c.surface,
                // Green, not the accent: this reports a state rather than
                // offering an action, and on the mono themes the accent is
                // the same white as the label beside it.
                leading: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(color: c.success, shape: BoxShape.circle),
                ),
              ),
            ),
            const SizedBox(height: 26),
            Text(t.onboarding.signInTitle, style: OnboardingType.headline),
            const SizedBox(height: 9),
            Text(quick ? t.onboarding.signInQuickBody : t.onboarding.signInPasswordBody, style: OnboardingType.body),
            Expanded(child: quick ? _buildQuickConnect(context) : _buildPassword(context)),
            if (quick)
              OnboardingTonalButton(label: t.onboarding.usePassword, onPressed: onUsePassword)
            else if (quickConnectEnabled)
              OnboardingTonalButton(label: t.onboarding.useQuickConnect, onPressed: onUseQuickConnect),
          ],
        ),
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    final c = tokens(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
            obscureText: obscurePassword,
            invalid: error != null,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => onSignIn(),
            trailing: TextButton(
              onPressed: onToggleObscure,
              style: TextButton.styleFrom(
                foregroundColor: c.textMuted,
                textStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const StadiumBorder(),
              ),
              child: Text(obscurePassword ? t.onboarding.show : t.onboarding.hide),
            ),
          ),
          if (error case final error?) ...[const SizedBox(height: 12), OnboardingSupportingText(error, invalid: true)],
          const SizedBox(height: 22),
          OnboardingButton(
            label: t.addServer.signIn,
            busyLabel: t.onboarding.signingIn,
            busy: busy,
            onPressed: onSignIn,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickConnect(BuildContext context) {
    final c = tokens(context);
    final code = quickConnectCode;
    return Column(
      children: [
        const SizedBox(height: 32),
        if (code == null)
          const OnboardingSpinner()
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (final character in code.split('')) _CodeBox(character)],
          ),
        const SizedBox(height: 26),
        if (code != null) ...[
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [OnboardingSpinner(), SizedBox(width: 9), _WaitingLabel()],
          ),
          const SizedBox(height: 12),
          Text(
            t.onboarding.quickConnectHowTo,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 13.5, height: 1.55, color: c.textMuted),
          ),
        ],
        if (error case final error?) ...[const SizedBox(height: 16), OnboardingSupportingText(error, invalid: true)],
      ],
    );
  }
}

class _WaitingLabel extends StatelessWidget {
  const _WaitingLabel();

  @override
  Widget build(BuildContext context) =>
      Text(t.onboarding.waitingForApproval, style: TextStyle(fontSize: 14, color: tokens(context).text));
}

/// One character of the Quick Connect code, boxed so it can be read aloud and
/// typed somewhere else without losing your place.
class _CodeBox extends StatelessWidget {
  const _CodeBox(this.character);

  final String character;

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    return Container(
      width: 42,
      height: 52,
      margin: const EdgeInsets.symmetric(horizontal: 4.5),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: c.surface, borderRadius: BorderRadius.circular(12)),
      child: Text(
        character,
        style: TextStyle(fontFamily: 'GoogleSansCode', fontSize: 21, fontWeight: FontWeight.w500, color: c.text),
      ),
    );
  }
}
