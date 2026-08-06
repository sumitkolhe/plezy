import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../onboarding_palette.dart';

/// Three swell layers along the bottom of the flow.
///
/// The phase comes from a clock that outlives any one instance, so the swell is
/// continuous everywhere it appears — across the steps of the onboarding flow,
/// and across the route change from the splash into it. A per-widget controller
/// would restart from flat water at each boundary, which is the one thing the
/// water is here to avoid.
class HarborWater extends StatefulWidget {
  const HarborWater({super.key});

  static const double height = 190;

  /// Shared by every instance, started on first use and never stopped. The
  /// swell is ambient, so its phase belongs to the app rather than to whichever
  /// screen happens to be showing it.
  static final Stopwatch _tide = Stopwatch()..start();

  @visibleForTesting
  static double get phaseSeconds => _tide.elapsedMicroseconds / Duration.microsecondsPerSecond;

  @override
  State<HarborWater> createState() => _HarborWaterState();
}

class _HarborWaterState extends State<HarborWater> with SingleTickerProviderStateMixin {
  /// Only drives repaints. What to paint comes from the shared clock.
  late final Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((_) => setState(() {}))..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        height: HarborWater.height,
        child: CustomPaint(painter: _SwellPainter(HarborWater.phaseSeconds)),
      ),
    );
  }
}

class _SwellPainter extends CustomPainter {
  const _SwellPainter(this.seconds);

  final double seconds;

  /// Amplitude, wavelength, seconds per cycle, bottom offset, colour, opacity.
  static const List<({double amp, double wave, double period, double bottom, Color color, double opacity})> _layers = [
    (amp: 11, wave: 130, period: 9, bottom: 52, color: OnboardingPalette.blue, opacity: 0.16),
    (amp: 11, wave: 130, period: 6.5, bottom: 30, color: OnboardingPalette.blue, opacity: 0.30),
    (amp: 9, wave: 130, period: 4.4, bottom: 0, color: OnboardingPalette.blueDeep, opacity: 0.55),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    for (var index = 0; index < _layers.length; index++) {
      final layer = _layers[index];
      // The middle layer runs the other way, so the three never lock into one
      // apparent sheet sliding sideways.
      final direction = index == 1 ? -1 : 1;
      final shift = (seconds % layer.period) / layer.period * layer.wave * direction;
      final crest = size.height - layer.bottom - layer.amp;

      final path = Path()..moveTo(-layer.wave + shift, crest);
      for (var x = -layer.wave + shift; x < size.width + layer.wave; x += layer.wave) {
        path.relativeQuadraticBezierTo(layer.wave / 4, -layer.amp, layer.wave / 2, 0);
        path.relativeQuadraticBezierTo(layer.wave / 4, layer.amp, layer.wave / 2, 0);
      }
      path
        ..lineTo(size.width + layer.wave, size.height)
        ..lineTo(-layer.wave, size.height)
        ..close();

      canvas.drawPath(path, Paint()..color = layer.color.withValues(alpha: layer.opacity));
    }
  }

  @override
  bool shouldRepaint(_SwellPainter old) => old.seconds != seconds;
}
