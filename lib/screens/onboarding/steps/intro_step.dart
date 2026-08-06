import 'dart:async';

import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../../../theme/mono_tokens.dart';
import '../onboarding_style.dart';
import '../widgets/harbor_mark.dart';
import '../widgets/onboarding_controls.dart';
import '../widgets/rise_in.dart';

/// The splash and the connect screen, which are the same screen.
///
/// Rather than cut from one to the other, the mark shrinks, the wordmark
/// crossfades into the heading, and the action rises up underneath — so the app
/// introduces itself and then asks for something without ever appearing to
/// navigate. [progress] drives all of it: 0 is the splash, 1 is connect.
///
/// The startup screen renders this frozen at 0 so the hand-over into the flow
/// lands on identical pixels; the flow then animates it to 1.
class IntroSurface extends StatelessWidget {
  const IntroSurface({super.key, required this.progress, this.formOpen = false, this.form, this.action});

  final double progress;

  /// Pulls the composition further up the screen to make room for the field.
  final bool formOpen;

  final Widget? form;
  final Widget? action;

  static const double _splashTopPad = 198;
  static const double _connectTopPad = 252;
  static const double _formTopPad = 152;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // The design's offsets are for an 844-tall frame; hold the proportion
        // rather than the pixel count so a shorter phone does not overflow.
        final scale = constraints.maxHeight / OnboardingMetrics.referenceHeight;
        final target = formOpen ? _formTopPad : _connectTopPad;
        final topPad = (_splashTopPad + (target - _splashTopPad) * progress) * scale;

        return SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(OnboardingMetrics.gutter, topPad, OnboardingMetrics.gutter, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Transform.scale(scale: 1 - 0.35 * progress, child: const HarborMark(size: 104)),
              ),
              SizedBox(height: 26 - 8 * progress),
              _CrossfadedTitles(progress: progress),
              if (form case final form?) ...[const SizedBox(height: 22), form],
              if (action case final action?) ...[const SizedBox(height: 22), action],
            ],
          ),
        );
      },
    );
  }
}

/// Both texts occupy one box so neither reflows the mark above them as they
/// trade places.
class _CrossfadedTitles extends StatelessWidget {
  const _CrossfadedTitles({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    return SizedBox(
      height: 92,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Opacity(
              opacity: 1 - progress,
              child: Column(
                children: [
                  Text(
                    'Harbor',
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600, letterSpacing: -1, color: c.text),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.onboarding.tagline.toUpperCase(),
                    style: TextStyle(fontSize: 13, letterSpacing: 1.8, color: c.textMuted),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Opacity(
              opacity: progress,
              child: Column(
                children: [
                  Text(t.onboarding.connectTitle, textAlign: TextAlign.center, style: OnboardingType.headline),
                  const SizedBox(height: 10),
                  Text(t.onboarding.connectBody, textAlign: TextAlign.center, style: OnboardingType.body),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// The live intro: holds on the splash, then morphs to connect and takes an
/// address.
class IntroStep extends StatefulWidget {
  const IntroStep({
    super.key,
    required this.controller,
    required this.formOpen,
    required this.error,
    required this.clipboardOffer,
    required this.busy,
    required this.showCancel,
    required this.onOpenForm,
    required this.onConnect,
    required this.onCancel,
    required this.onPaste,
    required this.startAtSplash,
  });

  final TextEditingController controller;
  final bool formOpen;
  final String? error;

  /// An address already on the clipboard, offered as a one-tap fill.
  final String? clipboardOffer;

  /// Reaching the server. The button carries this rather than a separate
  /// screen, so the address stays on show and editable.
  final bool busy;

  /// A wait long enough to be worth offering a way out of.
  final bool showCancel;

  final VoidCallback onOpenForm;
  final VoidCallback onConnect;
  final VoidCallback onCancel;
  final VoidCallback onPaste;

  final bool startAtSplash;

  /// How long the mark and wordmark hold before the morph begins.
  static const Duration splashHold = Duration(milliseconds: 2200);

  @override
  State<IntroStep> createState() => _IntroStepState();
}

class _IntroStepState extends State<IntroStep> with SingleTickerProviderStateMixin {
  late final AnimationController _morph = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 700),
    value: widget.startAtSplash ? 0 : 1,
  );

  /// Cancellable, because skipping the splash has to stop it rather than let a
  /// stray callback fire into a disposed widget.
  Timer? _hold;

  bool get _onSplash => _morph.value == 0 && !_morph.isAnimating;

  @override
  void initState() {
    super.initState();
    if (widget.startAtSplash) _hold = Timer(IntroStep.splashHold, _advance);
  }

  @override
  void dispose() {
    _hold?.cancel();
    _morph.dispose();
    super.dispose();
  }

  void _advance() {
    _hold?.cancel();
    if (_morph.value == 1 || _morph.isAnimating) return;
    if (prefersReducedMotion(context)) {
      _morph.value = 1;
    } else {
      _morph.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    return AnimatedBuilder(
      animation: CurvedAnimation(parent: _morph, curve: const Cubic(0.32, 0.72, 0, 1)),
      builder: (context, _) {
        final progress = const Cubic(0.32, 0.72, 0, 1).transform(_morph.value);
        final settled = _morph.value == 1;
        return Stack(
          children: [
            Positioned.fill(
              child: IntroSurface(
                progress: progress,
                formOpen: widget.formOpen,
                form: settled && widget.formOpen ? _buildForm(context) : null,
                action: settled ? _buildAction(context) : null,
              ),
            ),
            // Nobody should have to wait out a logo. The whole splash is a tap
            // target, with a visible label so the affordance is not a secret.
            if (_onSplash) ...[
              Positioned.fill(
                child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: _advance),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 40,
                child: Center(
                  child: TextButton(
                    onPressed: _advance,
                    child: Text(t.onboarding.skip, style: TextStyle(fontSize: 13, color: c.textMuted)),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildAction(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    if (!widget.formOpen) {
      return RiseIn(
        child: OnboardingButton(
          label: t.onboarding.addServer,
          onPressed: widget.onOpenForm,
          icon: Icon(Icons.add, size: 17, color: scheme.onPrimary),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OnboardingButton(
          label: t.auth.connectToJellyfin,
          busyLabel: t.onboarding.reaching,
          busy: widget.busy,
          onPressed: widget.onConnect,
          icon: _JellyfinGlyph(color: scheme.onPrimary),
        ),
        // Held back until the wait has gone on long enough to acknowledge:
        // offered immediately it would read as an expectation of failure.
        if (widget.showCancel) ...[
          const SizedBox(height: 8),
          RiseIn(
            child: OnboardingTextButton(label: t.common.cancel, onPressed: widget.onCancel),
          ),
        ],
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    final c = tokens(context);
    final offer = widget.clipboardOffer;
    return RiseIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OnboardingField(
            label: t.onboarding.serverAddress,
            controller: widget.controller,
            // An address, not prose — never localised.
            hintText: '192.168.1.10',
            invalid: widget.error != null,
            autofocus: true,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => widget.onConnect(),
            leading: Icon(Icons.dns_outlined, size: 19, color: c.textMuted),
          ),
          const SizedBox(height: 9),
          if (widget.error case final error?)
            OnboardingSupportingText(error, invalid: true)
          else if (offer != null)
            Align(
              alignment: Alignment.centerLeft,
              child: OnboardingChip(
                label: t.onboarding.pasteAddress(address: offer),
                leading: Icon(Icons.content_paste, size: 13, color: c.text),
                onTap: widget.onPaste,
              ),
            )
          else
            OnboardingSupportingText(t.onboarding.addressDefaultsHint),
        ],
      ),
    );
  }
}

/// Jellyfin's mark, drawn rather than shipped as an asset: three bars and an
/// arch, and the only place the flow needs it.
class _JellyfinGlyph extends StatelessWidget {
  const _JellyfinGlyph({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: 17, height: 17, child: CustomPaint(painter: _JellyfinPainter(color)));
}

class _JellyfinPainter extends CustomPainter {
  const _JellyfinPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 64);
    final paint = Paint()..color = color;
    canvas.drawPath(
      Path()
        ..moveTo(11, 32)
        ..arcToPoint(const Offset(53, 32), radius: const Radius.circular(21))
        ..close(),
      paint,
    );
    for (final (x, height) in [(19.0, 9.0), (27.0, 16.0), (35.0, 12.0), (43.0, 8.0)]) {
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x, 38, 5, height), const Radius.circular(2.5)), paint);
    }
  }

  @override
  bool shouldRepaint(_JellyfinPainter oldDelegate) => oldDelegate.color != color;
}
