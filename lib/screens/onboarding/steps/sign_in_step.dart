import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../onboarding_palette.dart';
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

  final VoidCallback onSignIn;
  final VoidCallback onToggleObscure;
  final VoidCallback onUseQuickConnect;
  final VoidCallback onUsePassword;

  @override
  Widget build(BuildContext context) {
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
                leading: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(color: OnboardingPalette.success, shape: BoxShape.circle),
                ),
              ),
            ),
            const SizedBox(height: 26),
            Text(
              t.onboarding.signInTitle,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                color: OnboardingPalette.text,
              ),
            ),
            const SizedBox(height: 9),
            Text(
              quick ? t.onboarding.signInQuickBody : t.onboarding.signInPasswordBody,
              style: const TextStyle(fontSize: 14, height: 1.5, color: OnboardingPalette.textMuted),
            ),
            Expanded(child: quick ? _buildQuickConnect() : _buildPassword()),
            if (quick)
              OnboardingSecondaryButton(label: t.onboarding.usePassword, onPressed: onUsePassword)
            else if (quickConnectEnabled)
              OnboardingSecondaryButton(label: t.onboarding.useQuickConnect, onPressed: onUseQuickConnect),
          ],
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 26),
          OnboardingFieldLabel(t.addServer.username),
          const SizedBox(height: 8),
          OnboardingField(controller: username, autofocus: true, textInputAction: TextInputAction.next),
          const SizedBox(height: 16),
          OnboardingFieldLabel(t.addServer.password),
          const SizedBox(height: 8),
          OnboardingField(
            controller: password,
            obscureText: obscurePassword,
            invalid: error != null,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => onSignIn(),
            trailing: GestureDetector(
              onTap: onToggleObscure,
              child: Text(
                obscurePassword ? t.onboarding.show : t.onboarding.hide,
                style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w500, color: OnboardingPalette.textFaint),
              ),
            ),
          ),
          if (error case final error?) ...[const SizedBox(height: 12), OnboardingErrorText(error)],
          const SizedBox(height: 22),
          OnboardingButton(label: t.addServer.signIn, onPressed: onSignIn),
        ],
      ),
    );
  }

  Widget _buildQuickConnect() {
    final code = quickConnectCode;
    return Column(
      children: [
        const SizedBox(height: 32),
        if (code == null)
          const _Spinner()
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [for (final character in code.split('')) _CodeBox(character)],
          ),
        const SizedBox(height: 26),
        if (code != null) ...[
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_Spinner(), SizedBox(width: 9), _WaitingLabel()],
          ),
          const SizedBox(height: 12),
          Text(
            t.onboarding.quickConnectHowTo,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13.5, height: 1.55, color: OnboardingPalette.textFaint),
          ),
        ],
        if (error case final error?) ...[const SizedBox(height: 16), OnboardingErrorText(error)],
      ],
    );
  }
}

class _WaitingLabel extends StatelessWidget {
  const _WaitingLabel();

  @override
  Widget build(BuildContext context) =>
      Text(t.onboarding.waitingForApproval, style: const TextStyle(fontSize: 14, color: OnboardingPalette.textOnFill));
}

/// One character of the Quick Connect code, boxed so it can be read aloud and
/// typed somewhere else without losing your place.
class _CodeBox extends StatelessWidget {
  const _CodeBox(this.character);

  final String character;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 52,
      margin: const EdgeInsets.symmetric(horizontal: 4.5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: OnboardingPalette.fieldFill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: OnboardingPalette.outline),
      ),
      child: Text(
        character,
        style: const TextStyle(
          fontFamily: 'GoogleSansCode',
          fontSize: 21,
          fontWeight: FontWeight.w500,
          color: OnboardingPalette.text,
        ),
      ),
    );
  }
}

class _Spinner extends StatefulWidget {
  const _Spinner();

  @override
  State<_Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<_Spinner> with SingleTickerProviderStateMixin {
  late final AnimationController _spin;

  @override
  void initState() {
    super.initState();
    _spin = AnimationController(vsync: this, duration: const Duration(milliseconds: 1100));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Still under reduced motion: an arc going nowhere is decoration, and the
    // words next to it already say what is happening.
    if (!prefersReducedMotion(context) && !_spin.isAnimating) _spin.repeat();
  }

  @override
  void dispose() {
    _spin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _spin,
      child: const SizedBox(
        width: 15,
        height: 15,
        child: CircularProgressIndicator(strokeWidth: 2.2, color: OnboardingPalette.blue),
      ),
    );
  }
}
