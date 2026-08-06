import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'onboarding_controls.dart';

/// The two colours of the mark.
///
/// Brand, not theme. The rest of onboarding follows MonoTokens and whatever the
/// user has chosen, but a logo that changes colour with the theme is not the
/// logo — these match the app icon and the brand export sheet.
const Color _sail = Color(0xFFFFFFFF);
const Color _rigging = Color(0xFF2CA8E0);

/// The Harbor mark: a mainsail, a jib, and the waterline they sit on.
///
/// Drawn rather than loaded from `assets/harbor_mark.svg` because the boat
/// moves and the water does not. The geometry is copied from the same export
/// the asset is cut from, so the painted mark and the static one are one shape.
///
/// Below 32dp the jib is dropped — the brand sheet's rule, and at that size the
/// two sails read as one smudge anyway.
class HarborMark extends StatefulWidget {
  const HarborMark({super.key, required this.size});

  final double size;

  /// The brand sheet's threshold for showing the jib.
  static const double jibThreshold = 32;

  @override
  State<HarborMark> createState() => _HarborMarkState();
}

class _HarborMarkState extends State<HarborMark> with SingleTickerProviderStateMixin {
  /// Seconds since the mark appeared. A free-running clock rather than a
  /// looping controller, because the motion is built from periods that
  /// deliberately do not divide into each other.
  final _clock = ValueNotifier<double>(0);
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) => _clock.value = elapsed.inMicroseconds / Duration.microsecondsPerSecond);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Left at zero under reduced motion, which paints the boat sitting level.
    if (!prefersReducedMotion(context) && !_ticker.isActive) _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(widget.size),
      painter: _MarkPainter(clock: _clock, withJib: widget.size >= HarborMark.jibThreshold),
    );
  }
}

class _MarkPainter extends CustomPainter {
  _MarkPainter({required this.clock, required this.withJib}) : super(repaint: clock);

  final ValueNotifier<double> clock;
  final bool withJib;

  /// Where the boat pivots: on the water, so it rolls against the line rather
  /// than turning about its own middle.
  static const Offset _pivot = Offset(32, 52);

  /// A hull on open water is never doing one thing at one rate. These periods
  /// do not divide into each other, so the loop never shows itself — the
  /// alternative is a single rise and fall, which reads as a ball bouncing
  /// rather than a boat sailing.
  static const double _heavePeriod = 4.3;
  static const double _rollPeriod = 6.1;
  static const double _chopPeriod = 2.9;
  static const double _surgePeriod = 7.7;

  static double _wave(double seconds, double period, [double phase = 0]) =>
      math.sin(seconds * 2 * math.pi / period + phase);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 64);
    final seconds = clock.value;

    // Rises and falls about where it rests, rather than lifting off and
    // dropping back to the same place.
    final heave = 2.8 * _wave(seconds, _heavePeriod);
    // Roll leads: it is the tilt, not the lift, that says water.
    final roll = 3.1 * _wave(seconds, _rollPeriod, 1.1) + 0.9 * _wave(seconds, _chopPeriod);
    final surge = 1.1 * _wave(seconds, _surgePeriod, 0.4);

    canvas.save();
    canvas.translate(_pivot.dx + surge, _pivot.dy + heave);
    canvas.rotate(roll * math.pi / 180);
    canvas.translate(-_pivot.dx, -_pivot.dy);

    if (withJib) {
      canvas.drawPath(
        Path()
          ..moveTo(35, 20)
          ..relativeLineTo(0, 24)
          ..lineTo(52, 44)
          ..relativeCubicTo(-3, -9, -9, -17, -17, -24)
          ..close(),
        Paint()..color = _rigging,
      );
    }

    canvas.drawPath(
      Path()
        ..moveTo(29, 10)
        ..relativeLineTo(0, 34)
        ..lineTo(11, 44)
        ..relativeCubicTo(4, -14, 10, -25, 18, -34)
        ..close(),
      Paint()..color = _sail,
    );
    canvas.restore();

    // Blue, matching the jib. The water stays level while the boat moves on it.
    canvas.drawLine(
      const Offset(10, 52),
      const Offset(54, 52),
      Paint()
        ..color = _rigging
        ..strokeWidth = 4.5
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(_MarkPainter old) => old.withJib != withJib;
}
