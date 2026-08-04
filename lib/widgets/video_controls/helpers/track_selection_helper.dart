import 'package:flutter/material.dart';
import '../../../i18n/strings.g.dart';
import '../../../utils/track_label_builder.dart';
import '../../../widgets/app_menu.dart';

class TrackSelectionHelper {
  static Widget buildOffTile({
    required BuildContext context,
    required bool isSelected,
    required VoidCallback onTap,
    Key? key,
    FocusNode? focusNode,
    VoidCallback? onLongPress,
    VoidCallback? onSecondaryTap,
    Widget? badge,
  }) {
    return _buildSelectableTile(
      context: context,
      key: key,
      label: t.common.off,
      isSelected: isSelected,
      onTap: onTap,
      focusNode: focusNode,
      onLongPress: onLongPress,
      onSecondaryTap: onSecondaryTap,
      badge: badge,
    );
  }

  static Widget buildTrackTile({
    required BuildContext context,
    required TrackLabel label,
    required bool isSelected,
    required VoidCallback onTap,
    Key? key,
    FocusNode? focusNode,
    VoidCallback? onLongPress,
    VoidCallback? onSecondaryTap,
    Widget? badge,
  }) {
    return _buildSelectableTile(
      context: context,
      key: key,
      label: label.primary,
      secondaryLabel: label.secondary,
      isSelected: isSelected,
      onTap: onTap,
      focusNode: focusNode,
      onLongPress: onLongPress,
      onSecondaryTap: onSecondaryTap,
      badge: badge,
    );
  }

  /// Build a numbered badge for primary/secondary subtitle indicators.
  static Widget buildTrackBadge(BuildContext context, int number) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(color: colorScheme.primary, borderRadius: BorderRadius.circular(4)),
      alignment: .center,
      child: Text(
        number.toString(),
        style: TextStyle(color: colorScheme.onPrimary, fontSize: 11, fontWeight: .bold),
      ),
    );
  }

  static Widget _buildSelectableTile({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    String? secondaryLabel,
    Key? key,
    FocusNode? focusNode,
    VoidCallback? onLongPress,
    VoidCallback? onSecondaryTap,
    Widget? badge,
  }) {
    // A selected row draws its own check, and clips its own label, so the badge
    // is the only trailing this has to supply.
    Widget tile = AppMenuItemTile<void>(
      key: key,
      focusNode: focusNode,
      item: AppMenuItem<void>(
        value: null,
        label: label,
        subtitle: secondaryLabel,
        selected: isSelected,
        trailing: badge,
      ),
      onPressed: onTap,
    );

    if (onLongPress != null) {
      tile = GestureDetector(onLongPress: onLongPress, child: tile);
    }

    if (onSecondaryTap != null) {
      tile = GestureDetector(onSecondaryTap: onSecondaryTap, child: tile);
    }

    return tile;
  }
}
