import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'onboarding_controls.dart';

/// The mark's colours, per ground.
///
/// Brand, not theme: these are the brand sheet's own two lockups, matching
/// `harbor_mark.svg` and `harbor_mark_light.svg` value for value, and they do
/// not follow MonoTokens or the wallpaper. The mainsail inverts because a white
/// sail on a white page is not the logo either, and the blue steps down on
/// light to hold its contrast against it.
const Color _sailOnDark = Color(0xFFFFFFFF);
const Color _riggingOnDark = Color(0xFF2CA8E0);
const Color _sailOnLight = Color(0xFF0A0A0B);
const Color _riggingOnLight = Color(0xFF1B8EC2);

/// The Harbor mark: a mainsail, a jib, and the waterline they sit on.
///
/// The sails never move. The waterline rests flat — pixel-identical to the
/// launcher icon and the SVG exports — for most of its cycle, then lifts into
/// two crests that travel right to left before easing flat again. Ambient
/// rather than a fidget: the mark sits above a form someone is typing into.
///
/// Painted rather than loaded as an SVG: the water has to move, the splash's
/// first frame is no place for an SVG parse, and one painter serves both
/// grounds where the assets needed a file each. The geometry is copied from
/// the same export those files were cut from.
///
/// Below 32dp the jib is dropped — the brand sheet's rule, and at that size the
/// two sails read as one smudge anyway.
class HarborMark extends StatefulWidget {
  const HarborMark({super.key, required this.size});

  final double size;

  /// The brand sheet's threshold for showing the jib.
  static const double jibThreshold = 32;

  /// One rest-then-swell-then-rest cycle.
  static const Duration period = Duration(seconds: 9);

  @override
  State<HarborMark> createState() => _HarborMarkState();
}

class _HarborMarkState extends State<HarborMark> with SingleTickerProviderStateMixin {
  late final AnimationController _cycle = AnimationController(vsync: this, duration: HarborMark.period);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Held at zero under reduced motion, which paints the flat waterline the
    // static exports use. Checked here rather than once at init so the setting
    // can be turned on mid-session and take effect.
    if (prefersReducedMotion(context)) {
      if (_cycle.isAnimating) {
        _cycle.stop();
        _cycle.value = 0;
      }
    } else if (!_cycle.isAnimating) {
      _cycle.repeat();
    }
  }

  @override
  void dispose() {
    _cycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The water repaints for nine seconds at a time; the boundary keeps that
    // off whatever the mark happens to be sitting on.
    return RepaintBoundary(
      child: CustomPaint(
        size: Size.square(widget.size),
        painter: _MarkPainter(
          cycle: _cycle,
          withJib: widget.size >= HarborMark.jibThreshold,
          onLight: Theme.of(context).brightness == Brightness.light,
        ),
      ),
    );
  }
}

class _MarkPainter extends CustomPainter {
  /// Driven by the controller directly, so a tick repaints without rebuilding
  /// the widget above it.
  _MarkPainter({required this.cycle, required this.withJib, required this.onLight}) : super(repaint: cycle);

  final Animation<double> cycle;
  final bool withJib;
  final bool onLight;

  Color get _sail => onLight ? _sailOnLight : _sailOnDark;
  Color get _rigging => onLight ? _riggingOnLight : _riggingOnDark;

  /// The waterline's span in the mark's 64-unit design space.
  static const double _x0 = 10, _x1 = 54, _y = 52;
  static const double _stroke = 4.5;

  /// Two crests across the span. Whole wavelengths put both ends at the same
  /// phase, so the line rises and falls as one instead of see-sawing about a
  /// corner.
  static const double _wavelength = (_x1 - _x0) / 2;
  static const double _amplitude = 2.1;

  /// Share of the moving window spent easing the swell up and back down.
  static const double _ramp = 0.22;

  /// Share of the cycle the water is still.
  static const double _restFraction = 0.55;

  /// Cubic spans used to approximate the sine. Four per wavelength, fitted to
  /// the exact slope at each end, which is indistinguishable from the curve at
  /// this amplitude.
  static const int _segments = 8;

  /// 0 at rest, then up and down across the moving window.
  double get _swell {
    final t = cycle.value;
    if (t <= _restFraction) return 0;
    final u = (t - _restFraction) / (1 - _restFraction);
    final envelope = u < _ramp
        ? u / _ramp
        : u > 1 - _ramp
        ? (1 - u) / _ramp
        : 1.0;
    return _amplitude * Curves.easeInOut.transform(envelope.clamp(0.0, 1.0));
  }

  /// One full wavelength of travel, right to left, across the moving window.
  double get _phase {
    final t = cycle.value;
    if (t <= _restFraction) return 0;
    return -(t - _restFraction) / (1 - _restFraction) * 2 * math.pi;
  }

  Path _waterline() {
    final swell = _swell;
    if (swell == 0) {
      return Path()
        ..moveTo(_x0, _y)
        ..lineTo(_x1, _y);
    }

    const step = (_x1 - _x0) / _segments;
    const rate = 2 * math.pi / _wavelength;
    final phase = _phase;
    double height(double x) => _y + swell * math.sin(rate * (x - _x0) + phase);
    double slope(double x) => swell * rate * math.cos(rate * (x - _x0) + phase);

    final path = Path()..moveTo(_x0, height(_x0));
    for (var i = 0; i < _segments; i++) {
      final xa = _x0 + i * step;
      final xb = xa + step;
      path.cubicTo(
        xa + step / 3,
        height(xa) + slope(xa) * step / 3,
        xb - step / 3,
        height(xb) - slope(xb) * step / 3,
        xb,
        height(xb),
      );
    }
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.scale(size.width / 64);

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

    canvas.drawPath(
      _waterline(),
      Paint()
        ..color = _rigging
        ..style = PaintingStyle.stroke
        ..strokeWidth = _stroke
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(_MarkPainter old) => old.withJib != withJib || old.onLight != onLight;
}
