import 'package:flutter/material.dart';

/// The two colours of the mark.
///
/// Brand, not theme. The rest of onboarding follows MonoTokens and whatever the
/// user has chosen, but a logo that changes colour with the theme is not the
/// logo — these match the app icon and the brand export sheet.
const Color _sail = Color(0xFFFFFFFF);
const Color _rigging = Color(0xFF2CA8E0);

/// The Harbor mark: a mainsail, a jib, and the waterline they sit on.
///
/// Painted rather than loaded from `assets/harbor_mark.svg`, which
/// [harborMarkAsset] picks by platform brightness — the mark must hold its
/// brand colours whatever the theme. Painting also keeps the splash's first
/// frame free of an SVG parse. The geometry is copied from the same export the
/// asset is cut from, so the two are one shape.
///
/// Below 32dp the jib is dropped — the brand sheet's rule, and at that size the
/// two sails read as one smudge anyway.
class HarborMark extends StatelessWidget {
  const HarborMark({super.key, required this.size});

  final double size;

  /// The brand sheet's threshold for showing the jib.
  static const double jibThreshold = 32;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _MarkPainter(withJib: size >= jibThreshold),
    );
  }
}

class _MarkPainter extends CustomPainter {
  const _MarkPainter({required this.withJib});

  final bool withJib;

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
