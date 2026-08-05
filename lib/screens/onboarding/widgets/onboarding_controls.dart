import 'package:flutter/material.dart';

import '../onboarding_palette.dart';

/// The flow's primary action. Filled Harbor blue, or white when it hands over
/// to the app at the end.
class OnboardingButton extends StatelessWidget {
  const OnboardingButton({super.key, required this.label, required this.onPressed, this.icon, this.light = false});

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;

  /// White on ink, for the one button that leaves onboarding.
  final bool light;

  @override
  Widget build(BuildContext context) {
    final foreground = light ? OnboardingPalette.ink : OnboardingPalette.text;
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: Material(
        color: light ? OnboardingPalette.text : OnboardingPalette.blue,
        borderRadius: BorderRadius.circular(OnboardingMetrics.radius),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(OnboardingMetrics.radius),
          child: Opacity(
            opacity: onPressed == null ? 0.55 : 1,
            child: SizedBox(
              height: OnboardingMetrics.controlHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon case final icon?) ...[icon, const SizedBox(width: 10)],
                  Text(
                    label,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: foreground),
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

/// The flow's secondary action: outlined, never filled, so the primary one is
/// unambiguous on every step.
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
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(OnboardingMetrics.radius),
          side: const BorderSide(color: OnboardingPalette.outline),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(OnboardingMetrics.radius),
          child: SizedBox(
            height: OnboardingMetrics.controlHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon case final icon?) ...[icon, const SizedBox(width: 9)],
                Text(
                  label,
                  style: const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w500, color: OnboardingPalette.text),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A labelled field on the flow's ink background.
class OnboardingField extends StatelessWidget {
  const OnboardingField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.error,
    this.obscureText = false,
    this.keyboardType,
    this.autofocus = false,
    this.textInputAction,
    this.onSubmitted,
    this.enabled = true,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final String? error;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final invalid = error != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 12,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w500,
            color: OnboardingPalette.textFaint,
          ),
        ),
        const SizedBox(height: 9),
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: OnboardingPalette.fieldFill,
            borderRadius: BorderRadius.circular(OnboardingMetrics.radius),
            border: Border.all(color: invalid ? OnboardingPalette.danger : OnboardingPalette.hairline),
          ),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            autofocus: autofocus,
            enabled: enabled,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            autocorrect: false,
            enableSuggestions: false,
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
        if (error case final error?) ...[const SizedBox(height: 9), OnboardingErrorText(error)],
      ],
    );
  }
}

/// The one way this flow reports a failure.
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

/// Step heading and its supporting line.
class OnboardingHeading extends StatelessWidget {
  const OnboardingHeading({super.key, required this.title, this.subtitle, this.centered = true, this.titleSize = 27});

  final String title;
  final String? subtitle;
  final bool centered;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    final align = centered ? TextAlign.center : TextAlign.start;
    return Column(
      crossAxisAlignment: centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: align,
          style: TextStyle(
            fontSize: titleSize,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.6,
            color: OnboardingPalette.text,
          ),
        ),
        if (subtitle case final subtitle?) ...[
          const SizedBox(height: 10),
          Text(
            subtitle,
            textAlign: align,
            style: const TextStyle(fontSize: 14.5, height: 1.5, color: OnboardingPalette.textMuted),
          ),
        ],
      ],
    );
  }
}
