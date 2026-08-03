import 'package:flutter/material.dart';

import '../utils/haptics.dart';

/// Adds the tactile half of a press response to the visual one.
///
/// Every Material press in the app — buttons, cards, list rows, chips — asks
/// the theme's factory for its splash, so this is the one place that sees them
/// all. Hover and focus build highlights instead and do not come through here.
class HapticInkFactory extends InteractiveInkFeatureFactory {
  const HapticInkFactory(this._inner);

  final InteractiveInkFeatureFactory _inner;

  @override
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    Haptics.selection();
    return _inner.create(
      controller: controller,
      referenceBox: referenceBox,
      position: position,
      color: color,
      textDirection: textDirection,
      containedInkWell: containedInkWell,
      rectCallback: rectCallback,
      borderRadius: borderRadius,
      customBorder: customBorder,
      radius: radius,
      onRemoved: onRemoved,
    );
  }
}

/// Held as constants so a rebuild does not hand [ThemeData] an unequal factory
/// and invalidate every theme-dependent widget.
const hapticNoSplash = HapticInkFactory(NoSplash.splashFactory);
const hapticSparkle = HapticInkFactory(InkSparkle.splashFactory);
