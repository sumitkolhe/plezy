import 'package:flutter/material.dart';

import '../onboarding_palette.dart';

/// Three swell layers along the bottom of the flow.
///
/// Mounted once by the flow shell and never rebuilt as the steps change, so
/// crossing from one step to the next does not restart the animation — the
/// water is the thing that says it is all one screen.
class HarborWater extends StatefulWidget {
  const HarborWater({super.key});

  static const double height = 190;

  @override
  State<HarborWater> createState() => _HarborWaterState();
}

class _HarborWaterState extends State<HarborWater> with SingleTickerProviderStateMixin {
  /// One clock for all three layers; each reads it at its own rate rather than
  /// carrying a controller of its own.
  late final AnimationController _clock = AnimationController(vsync: this, duration: const Duration(seconds: 60))
    ..repeat();

  @override
  void dispose() {
    _clock.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SizedBox(
        height: HarborWater.height,
        child: AnimatedBuilder(
          animation: _clock,
          builder: (context, _) {
            final seconds = _clock.value * 60;
            return CustomPaint(painter: _SwellPainter(seconds));
          },
        ),
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
