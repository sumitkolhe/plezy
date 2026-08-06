import 'package:flutter/material.dart';

import '../onboarding_palette.dart';

/// Whether the platform has been asked to keep still.
///
/// The flow leans on motion — a rocking mark, a sweeping bar, a morph between
/// two screens — so honouring this is not cosmetic. Checked at each animating
/// widget rather than centrally, because each one stills itself differently.
bool prefersReducedMotion(BuildContext context) => MediaQuery.disableAnimationsOf(context);

/// The flow's primary action: a white pill, on every screen that has one.
class OnboardingButton extends StatelessWidget {
  const OnboardingButton({super.key, required this.label, required this.onPressed, this.icon});

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: Material(
        color: OnboardingPalette.text,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(999),
          child: Opacity(
            opacity: onPressed == null ? 0.55 : 1,
            child: SizedBox(
              height: OnboardingMetrics.controlHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon case final icon?) ...[icon, const SizedBox(width: 9)],
                  Text(
                    label,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: OnboardingPalette.ink),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// The way back or sideways: a filled pill that never competes with the white
/// one above it.
class OnboardingSecondaryButton extends StatelessWidget {
  const OnboardingSecondaryButton({super.key, required this.label, required this.onPressed, this.icon});

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: Material(
        color: OnboardingPalette.raised,
        borderRadius: BorderRadius.circular(999),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(999),
          child: SizedBox(
            height: OnboardingMetrics.controlHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon case final icon?) ...[icon, const SizedBox(width: 9)],
                Text(
                  label,
                  style: const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w500, color: OnboardingPalette.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A field label: small, spaced, and shouting quietly.
class OnboardingFieldLabel extends StatelessWidget {
  const OnboardingFieldLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(fontSize: 12, letterSpacing: 1.2, color: OnboardingPalette.textFaint),
    );
  }
}

/// A text field on the flow's ink background.
class OnboardingField extends StatelessWidget {
  const OnboardingField({
    super.key,
    required this.controller,
    this.hintText,
    this.invalid = false,
    this.obscureText = false,
    this.keyboardType,
    this.autofocus = false,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.trailing,
  });

  final TextEditingController controller;
  final String? hintText;
  final bool invalid;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;

  /// The Show/Hide affordance on the password field.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: OnboardingMetrics.fieldHeight,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: OnboardingPalette.fieldFill,
        borderRadius: BorderRadius.circular(OnboardingMetrics.fieldRadius),
        border: Border.all(color: invalid ? OnboardingPalette.danger : OnboardingPalette.hairline),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              autofocus: autofocus,
              textInputAction: textInputAction,
              onSubmitted: onSubmitted,
              onChanged: onChanged,
              autocorrect: false,
              enableSuggestions: false,
              textCapitalization: TextCapitalization.none,
              style: const TextStyle(fontSize: 15, color: OnboardingPalette.text),
              cursorColor: OnboardingPalette.blue,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: const TextStyle(color: OnboardingPalette.textFainter, fontSize: 15),
              ),
            ),
          ),
          if (trailing case final trailing?) ...[const SizedBox(width: 10), trailing],
        ],
      ),
    );
  }
}

/// The one way this flow reports a failure inline.
class OnboardingErrorText extends StatelessWidget {
  const OnboardingErrorText(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 1),
          child: Icon(Icons.error_outline, size: 15, color: OnboardingPalette.danger),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: Text(message, style: const TextStyle(fontSize: 13, height: 1.4, color: OnboardingPalette.danger)),
        ),
      ],
    );
  }
}

/// A small filled pill used for status rather than action — the reachable
/// server on the sign-in step, and the clipboard offer under the address field.
class OnboardingChip extends StatelessWidget {
  const OnboardingChip({super.key, required this.label, this.leading, this.onTap});

  final String label;
  final Widget? leading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading case final leading?) ...[leading, const SizedBox(width: 8)],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12.5, color: OnboardingPalette.textOnFill),
            ),
          ),
        ],
      ),
    );
    return Material(
      color: onTap == null ? OnboardingPalette.success.withValues(alpha: 0.12) : OnboardingPalette.raised,
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: SizedBox(height: 32, child: content),
      ),
    );
  }
}
