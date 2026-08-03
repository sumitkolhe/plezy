import 'package:flutter/material.dart';

/// Trailing space so a list's last row clears the navigation bar it now scrolls
/// under.
///
/// A [CustomScrollView] does not read the media padding the way [ListView]
/// does, so tab-level scroll views ask for it explicitly.
class SliverNavigationInset extends StatelessWidget {
  const SliverNavigationInset({super.key});

  @override
  Widget build(BuildContext context) =>
      SliverToBoxAdapter(child: SizedBox(height: MediaQuery.paddingOf(context).bottom));
}
