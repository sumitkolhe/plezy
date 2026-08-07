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
    final text = busy ? (busyLabel ?? label) : label;
    final leading = busy ? _Spinner(color: c.textMuted) : icon;

    // Busy resolves for every state, because the button is also disabled while
    // it works and Material would otherwise paint it as unavailable rather than
    // as working. Everything else comes from filledButtonTheme.
    final style = ButtonStyle(
      minimumSize: const WidgetStatePropertyAll(Size.fromHeight(OnboardingMetrics.buttonHeight)),
      textStyle: const WidgetStatePropertyAll(OnboardingType.label),
      backgroundColor: busy ? WidgetStatePropertyAll(c.surface) : null,
      foregroundColor: busy ? WidgetStatePropertyAll(c.textMuted) : null,
    );
    final onTap = busy ? null : onPressed;

    return leading == null
        ? FilledButton(onPressed: onTap, style: style, child: Text(text))
        : FilledButton.icon(onPressed: onTap, style: style, icon: leading, label: Text(text));
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
    // filledButtonTheme paints every filled button with the accent, tonal
    // included, so the tonal surface has to be asked for by name.
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        backgroundColor: c.surface,
        foregroundColor: c.text,
        minimumSize: const Size.fromHeight(OnboardingMetrics.buttonHeight),
        textStyle: OnboardingType.label,
      ),
      child: Text(label),
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
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: c.textMuted,
        minimumSize: const Size.fromHeight(42),
        shape: const StadiumBorder(),
        textStyle: OnboardingType.label,
      ),
      child: Text(label),
    );
  }
}

/// M3 outlined text field, pill-shaped, with its label notched into the border.
///
/// The label rests inside the field and floats into the outline once there is
/// focus or text, so two stacked fields keep their names when both are filled.
///
/// The shape, padding and focus outline are the app-wide
/// [InputDecorationTheme] now, so this is only a field with a notched label and
/// a bool for its error state.
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

  /// The theme's error borders key off `errorText`, and this field takes a
  /// bool, so the invalid case has to supply its own.
  static OutlineInputBorder _errorPill(Color color, double width) => OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(999)),
    borderSide: BorderSide(color: color, width: width),
    gapPadding: 6,
  );

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    final scheme = Theme.of(context).colorScheme;
    final labelColour = invalid ? scheme.error : c.textMuted;

    return TextField(
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
        labelText: label,
        hintText: hintText,
        prefixIcon: leading,
        suffixIcon: trailing,
        enabledBorder: invalid ? _errorPill(scheme.error, 1) : null,
        focusedBorder: invalid ? _errorPill(scheme.error, 2) : null,
        // Size and the 16-to-12 float are Material's, from the theme. Only the
        // colour is ours, because invalid has to reach the label as well as
        // the outline.
        labelStyle: TextStyle(color: labelColour),
        floatingLabelStyle: TextStyle(color: labelColour),
      ),
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
///
/// [Chip] when it only reports, [ActionChip] when it can be pressed: an
/// ActionChip with no callback renders as disabled, which is the wrong thing to
/// say about a server that is reachable.
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
    final text = Text(label, maxLines: 1, overflow: TextOverflow.ellipsis);
    final labelStyle = TextStyle(fontSize: 12.5, color: c.text);
    final background = tone ?? c.surface;

    return onTap == null
        ? Chip(
            avatar: leading,
            label: text,
            labelStyle: labelStyle,
            backgroundColor: background,
            side: BorderSide.none,
            shape: const StadiumBorder(),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          )
        : ActionChip(
            onPressed: onTap,
            avatar: leading,
            label: text,
            labelStyle: labelStyle,
            backgroundColor: background,
            side: BorderSide.none,
            shape: const StadiumBorder(),
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
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
