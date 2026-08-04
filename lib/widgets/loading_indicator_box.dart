import 'package:flutter/material.dart';

/// Square `CircularProgressIndicator(strokeWidth: 2)` sized to fit inside a
/// button or status row. The default 18×18 matches the
/// [FilledButton.icon] / [OutlinedButton.icon] icon slot; bump [size] for
/// list-row or app-bar contexts.
class LoadingIndicatorBox extends StatelessWidget {
  final double size;
  const LoadingIndicatorBox({super.key, this.size = 18});

  /// Full-screen centered spinner sized to fill the remaining space inside a
  /// [CustomScrollView]. Replaces inline
  /// `SliverFillRemaining(child: Center(child: CircularProgressIndicator()))`.
  /// `hasScrollBody: false` so the spinner reports its own extent. The default
  /// reports the whole viewport (sliver_fill.dart:153) regardless of preceding
  /// slivers, which leaves an app bar's worth of phantom scroll on a
  /// non-scrolling screen.
  static const Widget sliver = SliverFillRemaining(
    hasScrollBody: false,
    child: Center(child: CircularProgressIndicator()),
  );

  @override
  Widget build(BuildContext context) =>
      SizedBox(width: size, height: size, child: const CircularProgressIndicator(strokeWidth: 2));
}
