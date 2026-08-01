import 'package:flutter/material.dart';

/// Owns a [ScrollController] for a horizontally scrolling row and hands it to
/// [builder], so callers that only need a controller for its lifetime do not
/// each have to manage one.
///
/// This used to overlay hover-activated navigation arrows, which needed a
/// mouse; on touch and TV there is none, so only the controller remains.
class ScrollControllerScope extends StatefulWidget {
  final Widget Function(ScrollController) builder;

  /// Supply one to keep ownership; otherwise this widget creates and disposes
  /// its own.
  final ScrollController? controller;

  const ScrollControllerScope({super.key, required this.builder, this.controller});

  @override
  State<ScrollControllerScope> createState() => _ScrollControllerScopeState();
}

class _ScrollControllerScopeState extends State<ScrollControllerScope> {
  late ScrollController _scrollController;
  late bool _ownsController;

  @override
  void initState() {
    super.initState();
    _ownsController = widget.controller == null;
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void didUpdateWidget(ScrollControllerScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == oldWidget.controller) return;
    if (_ownsController) _scrollController.dispose();
    _ownsController = widget.controller == null;
    _scrollController = widget.controller ?? ScrollController();
  }

  @override
  void dispose() {
    if (_ownsController) _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(_scrollController);
}
