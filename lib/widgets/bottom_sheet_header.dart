import 'package:flutter/material.dart';
import 'package:harbor/widgets/app_icon.dart';
import 'package:harbor/theme/phosphor_icons.dart';

/// The header every sheet uses, on the same metrics as the rows beneath it.
///
/// There is no close button: the drag handle, the scrim and the back key all
/// already dismiss a sheet. [onBack] is navigation to a parent page within one
/// sheet, which is a different thing from getting out of it.
class BottomSheetHeader extends StatelessWidget {
  /// Omitted where the rows already say what the sheet is; the bar still draws
  /// for an [action] or [onBack].
  final String? title;

  /// Takes precedence over [icon] and [onBack].
  final Widget? leading;

  final Widget? action;
  final IconData? icon;
  final Color? iconColor;

  /// Renders a back arrow as the leading widget, ahead of [icon].
  final VoidCallback? onBack;

  const BottomSheetHeader({
    super.key,
    this.title,
    this.leading,
    this.action,
    this.icon,
    this.iconColor,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final usesBackButton = leading == null && onBack != null;

    Widget? resolvedLeading;
    if (leading != null) {
      resolvedLeading = leading;
    } else if (usesBackButton) {
      resolvedLeading = ExcludeSemantics(child: AppIcon(PhosphorIcons.arrowLeft, color: iconColor));
    } else if (icon != null) {
      resolvedLeading = AppIcon(icon!, color: iconColor);
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: Stack(
        children: [
          Row(
            children: [
              if (resolvedLeading != null) ...[resolvedLeading, const SizedBox(width: 8)],
              Expanded(
                child: title == null
                    ? const SizedBox.shrink()
                    : Text(
                        title!,
                        style: Theme.of(context).textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
              ?action,
            ],
          ),
          // A tap target wider and taller than the 24dp arrow, without letting
          // it set the header's height.
          if (usesBackButton)
            PositionedDirectional(
              start: 0,
              top: 0,
              bottom: 0,
              width: kMinInteractiveDimension,
              child: ExcludeFocusTraversal(
                child: Semantics(
                  label: MaterialLocalizations.of(context).backButtonTooltip,
                  button: true,
                  child: InkResponse(
                    onTap: onBack,
                    radius: kMinInteractiveDimension / 2,
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
