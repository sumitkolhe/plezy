import 'package:flutter/material.dart';

/// Marks that a side navigation is present in the widget tree, so app bars
/// nested under it can skip chrome the rail already provides.
class SideNavigationScope extends InheritedWidget {
  const SideNavigationScope({super.key, required super.child});

  static bool isPresent(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<SideNavigationScope>() != null;
  }

  @override
  bool updateShouldNotify(SideNavigationScope oldWidget) => false;
}

class AppBarPadding {
  /// Keeps trailing actions off the screen edge.
  static const double actionsRight = 6.0;
}

/// Helpers that keep app-bar edge padding consistent across screens.
class DesktopAppBarHelper {
  static List<Widget>? buildAdjustedActions(List<Widget>? actions) {
    const trailing = SizedBox(width: AppBarPadding.actionsRight);
    return actions != null ? [...actions, trailing] : const [trailing];
  }

  static Widget? buildAdjustedLeading(Widget? leading, {bool includeGestureDetector = false, BuildContext? context}) =>
      leading;

  static Widget? buildAdjustedFlexibleSpace(Widget? flexibleSpace) => flexibleSpace;

  static double? calculateLeadingWidth(Widget? leading, {BuildContext? context}) => null;

  static Widget wrapWithGestureDetector(Widget child, {bool opaque = false}) => child;
}

/// Pads its child away from the window edges. Retained so callers that
/// requested explicit insets keep them.
class DesktopTitleBarPadding extends StatelessWidget {
  final Widget child;
  final double? leftPadding;
  final double? rightPadding;

  const DesktopTitleBarPadding({super.key, required this.child, this.leftPadding, this.rightPadding});

  @override
  Widget build(BuildContext context) {
    final left = leftPadding ?? 0.0;
    final right = rightPadding ?? 0.0;
    if (left == 0.0 && right == 0.0) return child;
    return Padding(
      padding: EdgeInsets.only(left: left, right: right),
      child: child,
    );
  }
}
