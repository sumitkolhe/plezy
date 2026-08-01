import 'package:flutter/material.dart';

class ClickableCursor extends StatelessWidget {
  final Widget child;
  final bool enabled;

  const ClickableCursor({super.key, required this.child, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    // Cursor feedback only matters where a pointer exists; on touch and TV
    // there is none, so this is a pass-through.
    return child;
  }
}
