import 'package:flutter/widgets.dart';

/// The static mark, for the surfaces that only need to draw it once.
///
/// The animated [HarborMark] paints the same geometry; this is the asset form
/// for everything outside the onboarding flow. Light and dark are separate
/// files rather than a tint because the mark is two colours, and only one of
/// them flips.
String harborMarkAsset(BuildContext context) => MediaQuery.platformBrightnessOf(context) == Brightness.light
    ? 'assets/harbor_mark_light.svg'
    : 'assets/harbor_mark.svg';
