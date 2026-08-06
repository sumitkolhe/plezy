import 'package:flutter/material.dart';

import '../../../theme/mono_tokens.dart';
import '../onboarding_style.dart';

/// Whether the platform has been asked to keep still.
///
/// The flow leans on motion — a rocking mark, a morph between two screens, a
/// spinner in a button — so honouring this is not cosmetic. Checked at each
/// animating widget rather than centrally, because each stills itself
/// differently.
bool prefersReducedMotion(BuildContext context) => MediaQuery.disableAnimationsOf(context);

/// M3 filled button: the one action a step is asking for.
///
/// It also carries that action's wait. Rather than replace the screen with a
/// spinner, the button becomes the progress — going tonal, swapping its icon
/// for a spinner and refusing further taps — so the form behind it stays
/// visible and, in the address field's case, still editable.
class OnboardingButton extends StatelessWidget {
  const OnboardingButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.busy = false,
    this.busyLabel,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final bool busy;

  /// What the button says while it works. Falls back to [label].
  final String? busyLabel;

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    final scheme = Theme.of(context).colorScheme;
    final background = busy ? c.surface : scheme.primary;
    final foreground = busy ? c.textMuted : scheme.onPrimary;
    final text = busy ? (busyLabel ?? label) : label;

    return Semantics(
      button: true,
      enabled: onPressed != null && !busy,
      label: text,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(999)),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: busy ? null : onPressed,
            child: Opacity(
              opacity: onPressed == null && !busy ? 0.55 : 1,
              child: SizedBox(
                height: OnboardingMetrics.buttonHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (busy) _Spinner(color: c.textMuted) else ?icon,
                    if (busy || icon != null) const SizedBox(width: 9),
                    Text(text, style: OnboardingType.label.copyWith(color: foreground)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// M3 tonal button: the other way on, never competing with the filled one.
class OnboardingTonalButton extends StatelessWidget {
  const OnboardingTonalButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: label,
      child: Material(
        color: c.surface,
        borderRadius: BorderRadius.circular(999),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            height: OnboardingMetrics.buttonHeight,
            child: Center(
              child: Text(label, style: OnboardingType.label.copyWith(color: c.text)),
            ),
          ),
        ),
      ),
    );
  }
}

/// M3 text button: for backing out, where a filled shape would give the escape
/// hatch more weight than the thing it escapes.
class OnboardingTextButton extends StatelessWidget {
  const OnboardingTextButton({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: SizedBox(
            height: 42,
            child: Center(
              child: Text(label, style: OnboardingType.label.copyWith(color: c.textMuted)),
            ),
          ),
        ),
      ),
    );
  }
}

/// M3 outlined text field, pill-shaped, with its label notched into the border.
///
/// The label sits in the outline rather than above it, so the field keeps its
/// name once there is text in it — which matters here, where two stacked fields
/// would otherwise be indistinguishable the moment they are filled.
class OnboardingField extends StatelessWidget {
  const OnboardingField({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.invalid = false,
    this.obscureText = false,
    this.keyboardType,
    this.autofocus = false,
    this.textInputAction,
    this.onSubmitted,
    this.leading,
    this.trailing,
  });

  final String label;
  final TextEditingController controller;
  final String? hintText;
  final bool invalid;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    final scheme = Theme.of(context).colorScheme;
    final tone = invalid ? scheme.error : c.outline;
    return Stack(
      // The label overhangs the border it is notched into.
      clipBehavior: Clip.none,
      children: [
        Container(
          height: OnboardingMetrics.fieldHeight,
          margin: const EdgeInsets.only(top: 6),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: tone),
          ),
          child: Row(
            children: [
              if (leading case final leading?) ...[leading, const SizedBox(width: 12)],
              Expanded(
                child: TextField(
                  controller: controller,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  autofocus: autofocus,
                  textInputAction: textInputAction,
                  onSubmitted: onSubmitted,
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  style: OnboardingType.field,
                  cursorColor: scheme.primary,
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: hintText,
                    hintStyle: TextStyle(color: c.outline, fontSize: 16),
                  ),
                ),
              ),
              if (trailing case final trailing?) ...[const SizedBox(width: 10), trailing],
            ],
          ),
        ),
        Positioned(
          left: 20,
          top: -2,
          child: ColoredBox(
            // Punches the outline so the label sits in it, not over it.
            color: c.bg,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Text(
                label,
                style: TextStyle(fontSize: 12, letterSpacing: 0.4, color: invalid ? scheme.error : c.textMuted),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// The line under a field: what it will assume, or what went wrong. Indented to
/// the field's own text, because it belongs to the field rather than the page.
class OnboardingSupportingText extends StatelessWidget {
  const OnboardingSupportingText(this.message, {super.key, this.invalid = false});

  final String message;
  final bool invalid;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (invalid) ...[
            Padding(
              padding: EdgeInsets.only(top: 1),
              child: Icon(Icons.error_outline, size: 14, color: scheme.error),
            ),
            const SizedBox(width: 7),
          ],
          Expanded(
            child: Text(
              message,
              style: invalid ? OnboardingType.supporting.copyWith(color: scheme.error) : OnboardingType.supporting,
            ),
          ),
        ],
      ),
    );
  }
}

/// A small filled pill used for status rather than action — the reachable
/// server on the sign-in step, and the clipboard offer under the address field.
class OnboardingChip extends StatelessWidget {
  const OnboardingChip({super.key, required this.label, this.leading, this.onTap, this.tone});

  final String label;
  final Widget? leading;
  final VoidCallback? onTap;

  /// Overrides the default surface, for the reachable-server pill.
  final Color? tone;

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    return Material(
      color: tone ?? c.surface,
      borderRadius: BorderRadius.circular(999),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 32,
          child: Padding(
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
                    style: TextStyle(fontSize: 12.5, color: c.text),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The indeterminate arc, in a button or beside the Quick Connect code.
class _Spinner extends StatefulWidget {
  const _Spinner({required this.color});

  final Color color;

  @override
  State<_Spinner> createState() => _SpinnerState();
}

class _SpinnerState extends State<_Spinner> with SingleTickerProviderStateMixin {
  late final AnimationController _spin = AnimationController(vsync: this, duration: const Duration(seconds: 1));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Still under reduced motion. The label beside it already says what is
    // happening, so the arc is decoration.
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
      child: SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2.4, color: widget.color)),
    );
  }
}

/// The wait beside the Quick Connect code, where there is no button to put it
/// in.
class OnboardingSpinner extends StatelessWidget {
  const OnboardingSpinner({super.key});

  @override
  Widget build(BuildContext context) => _Spinner(color: Theme.of(context).colorScheme.primary);
}
