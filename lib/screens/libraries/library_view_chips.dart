import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';
import '../../media/library_view.dart';
import '../../theme/mono_tokens.dart';
import '../../theme/phosphor_icons.dart';
import 'library_selection.dart';

/// The row that answers what the library is showing: its own contents, what an
/// *arr is still missing, or one of the saved filter sets.
///
/// Selecting, creating and deleting a view were three surfaces in three places.
/// They are one row now: tap to switch, tap the selected view again to edit it,
/// and `+` to build another.
class LibraryViewChips extends StatelessWidget implements PreferredSizeWidget {
  const LibraryViewChips({
    super.key,
    required this.libraryGlobalKey,
    required this.selection,
    required this.views,
    required this.offersMissing,
    required this.onSelect,
    required this.onEdit,
    required this.onCreate,
  });

  final String libraryGlobalKey;
  final LibrarySelection? selection;
  final List<LibraryView> views;

  /// False when no *arr tracks this library, or when its kind has no *arr to
  /// track it — the Missing tab cannot resolve a kind it has no service for.
  final bool offersMissing;

  final ValueChanged<LibrarySelection> onSelect;

  /// Reopens the filter drawer over an existing view.
  final ValueChanged<LibraryView> onEdit;
  final VoidCallback onCreate;

  static const double _height = 52;

  @override
  Size get preferredSize => const Size.fromHeight(_height);

  @override
  Widget build(BuildContext context) {
    final c = tokens(context);
    final active = selection;
    final onView = active?.view;

    return SizedBox(
      height: _height,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _chip(
            label: t.libraries.views.allMedia,
            selected: active != null && !active.missing && active.view == null,
            onTap: () => onSelect(LibrarySelection.library(libraryGlobalKey)),
          ),
          if (offersMissing)
            _chip(
              label: t.libraries.tabs.missing,
              selected: active?.missing ?? false,
              onTap: () => onSelect(LibrarySelection.missing(libraryGlobalKey)),
            ),
          for (final view in views)
            _chip(
              label: view.name,
              selected: onView?.name == view.name,
              // A second tap on the one already showing opens it for editing,
              // which is also the only route to deleting it. The caret is what
              // says so — without it the second tap is a secret.
              trailing: onView?.name == view.name ? PhosphorIcons.caretDown : null,
              onTap: () =>
                  onView?.name == view.name ? onEdit(view) : onSelect(LibrarySelection.view(libraryGlobalKey, view)),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ActionChip(
              onPressed: onCreate,
              avatar: Icon(PhosphorIcons.plus, size: 15, color: c.text),
              label: Text(t.libraries.views.newView),
              side: BorderSide(color: c.outline),
              backgroundColor: Colors.transparent,
              shape: const StadiumBorder(),
              visualDensity: VisualDensity.compact,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _chip({required String label, required bool selected, required VoidCallback onTap, IconData? trailing}) =>
      Padding(
        padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
        child: FilterChip(
          label: trailing == null
              ? Text(label)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(label), const SizedBox(width: 5), Icon(trailing, size: 13)],
                ),
          selected: selected,
          onSelected: (_) => onTap(),
          showCheckmark: false,
          shape: const StadiumBorder(),
          visualDensity: VisualDensity.compact,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      );
}
