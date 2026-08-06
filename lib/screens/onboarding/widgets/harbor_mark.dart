import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../onboarding_palette.dart';

/// The Harbor mark: a mainsail, a jib, and the waterline they sit on.
///
/// Drawn rather than loaded from `assets/harbor_mark.svg` because the flow
/// animates two of the three parts independently. The geometry is copied from
/// the same export the asset is cut from, so the painted mark and the static
/// one are the same shape.
///
/// Below 32dp the jib is dropped — the brand sheet's rule, and at that size the
/// two sails read as one smudge anyway.
class HarborMark extends StatefulWidget {
  const HarborMark({super.key, required this.size, this.bob = false, this.onLight = false});

  final double size;

  /// Ride the swell. For the two screens where the mark is the only thing on
  /// the page; elsewhere it would pull the eye off the copy.
  final bool bob;

  final bool onLight;

  /// The brand sheet's threshold for showing the jib.
  static const double jibThreshold = 32;

  @override
  State<HarborMark> createState() => _HarborMarkState();
}

class _HarborMarkState extends State<HarborMark> with TickerProviderStateMixin {
  late final AnimationController _bob = AnimationController(vsync: this, duration: const Duration(milliseconds: 3600))
    ..repeat(reverse: true);

  /// The jib is present for roughly two seconds in eleven. One long cycle, not
  /// a blink: the mark should look like it is breathing, not faulty.
  late final AnimationController _jib = AnimationController(vsync: this, duration: const Duration(seconds: 11))
    ..repeat();

  @override
  void dispose() {
    _bob.dispose();
    _jib.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final withJib = widget.size >= HarborMark.jibThreshold;
    return AnimatedBuilder(
      animation: Listenable.merge([_bob, if (withJib) _jib]),
      builder: (context, _) {
        final swell = widget.bob ? math.sin(_bob.value * math.pi) : 0.0;
        return Transform.translate(
          offset: Offset(0, -9 * swell),
          child: Transform.rotate(
            angle: (-2.5 + 5 * swell) * math.pi / 180,
            alignment: const Alignment(0, 0.6),
            child: CustomPaint(
              size: Size.square(widget.size),
              painter: _MarkPainter(jibOpacity: withJib ? _jibOpacity(_jib.value) : 0, onLight: widget.onLight),
            ),
          ),
        );
      },
    );
  }

  /// Absent, a half-second fade up, two seconds held, a fade back down.
  static double _jibOpacity(double t) {
    if (t < 0.62 || t >= 1) return 0;
    if (t < 0.70) return (t - 0.62) / 0.08;
    if (t < 0.88) return 1;
    return 1 - (t - 0.88) / 0.12;
  }
}

class _MarkPainter extends CustomPainter {
  const _MarkPainter({required this.jibOpacity, required this.onLight});

  final double jibOpacity;
  final bool onLight;

  @override
  void paint(Canvas canvas, Size size) {
    final scale = size.width / 64;
    canvas.scale(scale);

    final sailColor = onLight ? OnboardingPalette.ink : OnboardingPalette.text;
    final jibColor = OnboardingPalette.blue;

    if (jibOpacity > 0) {
      canvas.drawPath(
        Path()
          ..moveTo(35, 20)
          ..relativeLineTo(0, 24)
          ..lineTo(52, 44)
          ..relativeCubicTo(-3, -9, -9, -17, -17, -24)
          ..close(),
        Paint()..color = jibColor.withValues(alpha: jibOpacity),
      );
    }

    canvas.drawPath(
      Path()
        ..moveTo(29, 10)
        ..relativeLineTo(0, 34)
        ..lineTo(11, 44)
        ..relativeCubicTo(4, -14, 10, -25, 18, -34)
        ..close(),
      Paint()..color = sailColor,
    );

    canvas.drawLine(
      const Offset(10, 52),
      const Offset(54, 52),
      Paint()
        ..color = sailColor
        ..strokeWidth = 4.5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_MarkPainter old) => old.jibOpacity != jibOpacity || old.onLight != onLight;
}
