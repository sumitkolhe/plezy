import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';

import '../focus/input_mode_tracker.dart';
import '../theme/mono_tokens.dart';
import '../utils/layout_constants.dart';
import '../utils/platform_detector.dart';
import 'app_icon.dart';

/// The header every shelf wears: an icon, a title, and — when the shelf opens
/// in full — a caret that says so.
///
/// Shared because the spacing is the part that drifts. It reaches its figures
/// through a nested pair of paddings (the outer one sets the rail, the inner one
/// gives the tap target its own room), which is easy to read off wrongly when
/// copied by eye.
class ShelfHeader extends StatelessWidget {
  const ShelfHeader({super.key, required this.icon, required this.title, this.suffix, this.onOpen, this.inset = false});

  final IconData icon;
  final String title;

  /// Which server the shelf came from, when more than one can supply it.
  final String? suffix;

  /// Set when the shelf has a page of its own; also what draws the caret.
  final VoidCallback? onOpen;

  /// Inside a surface that already pads horizontally, so the rail is its own.
  final bool inset;

  /// Where a shelf's header and its cards both start.
  static double railInsetFor({required bool inset, required bool isTv}) => inset
      ? 0.0
      : isTv
      ? TvLayoutConstants.shelfHorizontalInset
      : 12.0;

  @override
  Widget build(BuildContext context) {
    final isTv = PlatformDetector.isTV();
    final rail = railInsetFor(inset: inset, isTv: isTv);
    final suffixStyle = Theme.of(
      context,
    ).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.7));

    return Padding(
      padding: inset
          ? EdgeInsets.symmetric(vertical: isTv ? 6 : 2)
          : EdgeInsets.fromLTRB(rail - 4, isTv ? 6 : 2, 8, isTv ? 8 : HubLayoutConstants.headerGap),
      // A title is not a focus stop; the shelf's cards are.
      child: ExcludeFocus(
        child: InkWell(
          mouseCursor: onOpen != null ? SystemMouseCursors.click : MouseCursor.defer,
          onTap: onOpen,
          borderRadius: BorderRadius.circular(tokens(context).radiusSm),
          child: Padding(
            padding: inset
                ? const EdgeInsets.symmetric(vertical: 2)
                : const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              children: [
                AppIcon(icon, size: isTv ? 28 : 16),
                SizedBox(width: isTv ? 12 : 6),
                // Flexible would share flex with a Spacer, stranding the caret.
                Expanded(
                  child: Text(
                    title,
                    style: HubLayoutConstants.sectionHeading(isTv: isTv),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                if (suffix != null) ...[
                  const SizedBox(width: 8),
                  Text('•', style: suffixStyle),
                  const SizedBox(width: 8),
                  Text(suffix!, style: suffixStyle),
                ],
                if (onOpen != null && !InputModeTracker.isKeyboardMode(context))
                  AppIcon(PhosphorIcons.caretRight, size: isTv ? 26 : 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
