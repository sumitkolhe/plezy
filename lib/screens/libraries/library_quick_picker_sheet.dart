import 'package:flutter/material.dart';

import '../../media/media_library.dart';
import '../../utils/content_utils.dart';
import '../../utils/library_grouping.dart';
import '../../widgets/app_menu.dart';
import 'package:harbor/theme/phosphor_icons.dart';

import '../../i18n/strings.g.dart';
import '../../media/library_view.dart';
import '../../widgets/backend_badge.dart';
import 'library_selection.dart';

class LibraryQuickPickerSheet extends StatelessWidget {
  final List<MediaLibrary> libraries;
  final String? selectedLibraryKey;
  final bool isLoading;
  final bool groupByServer;
  final String emptyMessage;
  final ValueChanged<LibrarySelection> onSelected;

  /// The current selection, so the row in force can be marked.
  final LibrarySelection? selection;

  /// Saved views, keyed by library global key.
  final Map<String, List<LibraryView>> viewsByLibrary;

  /// Which libraries have an *arr that can answer for their kind.
  final Set<String> librariesWithMissing;

  const LibraryQuickPickerSheet({
    super.key,
    required this.libraries,
    required this.selectedLibraryKey,
    required this.isLoading,
    required this.groupByServer,
    required this.emptyMessage,
    required this.onSelected,
    this.selection,
    this.viewsByLibrary = const {},
    this.librariesWithMissing = const {},
  });

  bool get _showServerHeaders {
    final serverIds = libraries.where((library) => library.serverId != null).map((library) => library.serverId).toSet();
    return serverIds.length > 1 && groupByServer;
  }

  Set<String> _getNonUniqueLibraryNames() {
    final nameCounts = <String, int>{};
    for (final library in libraries) {
      nameCounts[library.title] = (nameCounts[library.title] ?? 0) + 1;
    }
    return nameCounts.entries.where((entry) => entry.value > 1).map((entry) => entry.key).toSet();
  }

  List<AppMenuEntry<LibrarySelection>> _buildEntries() {
    if (!_showServerHeaders) {
      final nonUniqueNames = _getNonUniqueLibraryNames();
      return [
        for (final library in libraries)
          _libraryEntry(library, showServerName: library.serverName != null && nonUniqueNames.contains(library.title)),
      ];
    }

    final grouped = groupLibrariesByFirstAppearance(libraries);
    final entries = <AppMenuEntry<LibrarySelection>>[];
    for (final serverKey in grouped.serverOrder) {
      final bucket = grouped.byServer[serverKey]!;
      if (serverKey.isNotEmpty) {
        entries.add(AppMenuHeader<LibrarySelection>(child: _serverLabel(bucket.first, serverKey)));
      }
      for (final library in bucket) {
        entries.add(_libraryEntry(library, showServerName: false));
      }
    }
    return [...entries, ..._beyondLibraries()];
  }

  AppMenuItem<LibrarySelection> _libraryEntry(MediaLibrary library, {required bool showServerName}) {
    final value = LibrarySelection.library(library.globalKey);
    return AppMenuItem<LibrarySelection>(
      value: value,
      label: library.title,
      icon: ContentTypeHelper.getLibraryIcon(library.kind.id),
      subtitleWidget: showServerName ? _serverLabel(library, library.serverName!) : null,
      selected: _isSelected(value),
    );
  }

  bool _isSelected(LibrarySelection candidate) => selection == null
      ? candidate.libraryGlobalKey == selectedLibraryKey && !candidate.missing
      : selection == candidate;

  /// Everything that is not the library's own contents: what an *arr is still
  /// missing, and the shapes saved over what is there.
  List<AppMenuEntry<LibrarySelection>> _beyondLibraries() {
    final missing = [
      for (final library in libraries)
        if (librariesWithMissing.contains(library.globalKey))
          AppMenuItem<LibrarySelection>(
            value: LibrarySelection.missing(library.globalKey),
            label: library.title,
            icon: PhosphorIcons.paperPlaneTilt,
            selected: _isSelected(LibrarySelection.missing(library.globalKey)),
          ),
    ];
    final views = [
      for (final library in libraries)
        for (final view in viewsByLibrary[library.globalKey] ?? const <LibraryView>[])
          AppMenuItem<LibrarySelection>(
            value: LibrarySelection.view(library.globalKey, view),
            label: view.name,
            subtitle: library.title,
            icon: PhosphorIcons.bookmarks,
            selected: _isSelected(LibrarySelection.view(library.globalKey, view)),
          ),
    ];

    return [
      if (missing.isNotEmpty) ...[AppMenuHeader<LibrarySelection>(label: t.libraries.tabs.missing), ...missing],
      if (views.isNotEmpty) ...[AppMenuHeader<LibrarySelection>(label: t.libraries.views.title), ...views],
    ];
  }

  /// Reads back the colour the surrounding row already resolved, so the badge
  /// matches the text beside it without restating either style.
  Widget _serverLabel(MediaLibrary library, String fallbackServerName) {
    return Builder(
      builder: (context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BackendBadge(backend: library.backend, size: 12, color: DefaultTextStyle.of(context).style.color),
          const SizedBox(width: 6),
          Flexible(child: Text(library.serverName ?? fallbackServerName)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isLoading && libraries.isEmpty)
          const Padding(padding: EdgeInsets.symmetric(vertical: 32), child: CircularProgressIndicator())
        else if (libraries.isEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
            child: Text(emptyMessage, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyMedium),
          )
        else
          Flexible(
            child: SingleChildScrollView(
              child: AppMenuList<LibrarySelection>(
                padding: const EdgeInsets.symmetric(vertical: 8),
                entries: _buildEntries(),
                onSelected: onSelected,
              ),
            ),
          ),
      ],
    );
  }
}
