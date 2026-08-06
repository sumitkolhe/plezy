import 'dart:async';

import 'package:flutter/material.dart';

import '../../../i18n/strings.g.dart';
import '../onboarding_palette.dart';
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
  const IntroSurface({super.key, required this.progress, this.formOpen = false, this.form, this.action, this.footer});

  final double progress;

  /// Pulls the composition further up the screen to make room for the field.
  final bool formOpen;

  final Widget? form;
  final Widget? action;
  final Widget? footer;

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

        return Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(OnboardingMetrics.gutter, topPad, OnboardingMetrics.gutter, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Transform.scale(scale: 1 - 0.35 * progress, child: const HarborMark(size: 104, bob: true)),
                  ),
                  SizedBox(height: 26 - 8 * progress),
                  _CrossfadedTitles(progress: progress),
                  if (form case final form?) ...[const SizedBox(height: 22), form],
                  if (action case final action?) ...[const SizedBox(height: 22), action],
                ],
              ),
            ),
            if (footer case final footer?)
              Positioned(
                left: OnboardingMetrics.gutter,
                right: OnboardingMetrics.gutter,
                bottom: 34,
                child: Opacity(opacity: progress, child: footer),
              ),
          ],
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
                  const Text(
                    'Harbor',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: OnboardingPalette.text,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.onboarding.tagline.toUpperCase(),
                    style: const TextStyle(fontSize: 13, letterSpacing: 1.8, color: OnboardingPalette.textFaint),
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
                  Text(
                    t.onboarding.connectTitle,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      color: OnboardingPalette.text,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    t.onboarding.connectBody,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14, height: 1.5, color: OnboardingPalette.textMuted),
                  ),
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
    required this.onOpenForm,
    required this.onConnect,
    required this.onPaste,
    required this.startAtSplash,
  });

  final TextEditingController controller;
  final bool formOpen;
  final String? error;

  /// An address already on the clipboard, offered as a one-tap fill.
  final String? clipboardOffer;

  final VoidCallback onOpenForm;
  final VoidCallback onConnect;
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
                form: settled && widget.formOpen ? _buildForm() : null,
                action: settled ? _buildAction() : null,
                footer: _PrivacyNote(),
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
                    child: Text(
                      t.onboarding.skip,
                      style: const TextStyle(fontSize: 13, color: OnboardingPalette.textFaint),
                    ),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildAction() {
    if (widget.formOpen) {
      return OnboardingButton(
        label: t.auth.connectToJellyfin,
        onPressed: widget.onConnect,
        icon: const _JellyfinGlyph(),
      );
    }
    return RiseIn(
      child: OnboardingButton(
        label: t.onboarding.addServer,
        onPressed: widget.onOpenForm,
        icon: const Icon(Icons.add, size: 17, color: OnboardingPalette.ink),
      ),
    );
  }

  Widget _buildForm() {
    final offer = widget.clipboardOffer;
    return RiseIn(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OnboardingFieldLabel(t.onboarding.serverAddress),
          const SizedBox(height: 9),
          OnboardingField(
            controller: widget.controller,
            // An address, not prose — never localised.
            hintText: '192.168.1.10',
            invalid: widget.error != null,
            autofocus: true,
            keyboardType: TextInputType.url,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => widget.onConnect(),
          ),
          const SizedBox(height: 9),
          if (offer != null)
            Align(
              alignment: Alignment.centerLeft,
              child: OnboardingChip(
                label: t.onboarding.pasteAddress(address: offer),
                leading: const Icon(Icons.content_paste, size: 13, color: OnboardingPalette.textOnFill),
                onTap: widget.onPaste,
              ),
            )
          else if (widget.error case final error?)
            OnboardingErrorText(error)
          else
            Text(
              t.onboarding.addressDefaultsHint,
              style: const TextStyle(fontSize: 12.5, color: OnboardingPalette.textHelper),
            ),
        ],
      ),
    );
  }
}

/// The reassurance the screen is asking someone to act on: this is their
/// server, and the password they are about to type is not going anywhere.
class _PrivacyNote extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.lock_outline, size: 14, color: OnboardingPalette.textFaint),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            t.onboarding.credentialsStayOnDevice,
            style: const TextStyle(fontSize: 13, color: OnboardingPalette.textFaint),
          ),
        ),
      ],
    );
  }
}

/// Jellyfin's mark, drawn rather than shipped as an asset: three bars and an
/// arch, and the only place the flow needs it.
class _JellyfinGlyph extends StatelessWidget {
  const _JellyfinGlyph();

  @override
  Widget build(BuildContext context) =>
      const SizedBox(width: 17, height: 17, child: CustomPaint(painter: _JellyfinPainter()));
}

class _JellyfinPainter extends CustomPainter {
  const _JellyfinPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 64);
    final paint = Paint()..color = OnboardingPalette.ink;
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
  bool shouldRepaint(_JellyfinPainter oldDelegate) => false;
}
