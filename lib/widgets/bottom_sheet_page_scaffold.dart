import 'package:flutter/material.dart';

import '../focus/dpad_navigator.dart';
import '../focus/key_event_utils.dart';
import 'bottom_sheet_header.dart';

/// Shared page layout for bottom sheets with a stable header and content area.
class BottomSheetPageScaffold extends StatelessWidget {
  /// Omitted where the rows already say what the sheet is.
  final String? title;
  final Widget child;
  final Widget? leading;
  final Widget? action;
  final IconData? icon;
  final Color? iconColor;
  final VoidCallback? onBack;
  final bool shrinkWrap;

  const BottomSheetPageScaffold({
    super.key,
    this.title,
    required this.child,
    this.leading,
    this.action,
    this.icon,
    this.iconColor,
    this.onBack,
    this.shrinkWrap = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      mainAxisSize: shrinkWrap ? MainAxisSize.min : MainAxisSize.max,
      children: [
        if (title != null || action != null || onBack != null)
          BottomSheetHeader(
            title: title,
            leading: leading,
            action: action,
            icon: icon,
            iconColor: iconColor,
            onBack: onBack,
          ),
        if (shrinkWrap) child else Expanded(child: child),
      ],
    );

    // Let sub-pages consume Back and return to their parent instead of closing
    // the whole sheet via the overlay host.
    final back = onBack;
    if (back != null) {
      content = Focus(
        canRequestFocus: false,
        skipTraversal: true,
        onKeyEvent: (node, event) {
          if (event.logicalKey.isBackKey) {
            return handleBackKeyAction(event, back);
          }
          return KeyEventResult.ignored;
        },
        child: content,
      );
    }

    return content;
  }
}
