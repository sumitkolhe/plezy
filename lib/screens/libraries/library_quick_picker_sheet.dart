import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';
import '../../media/media_library.dart';
import '../../utils/content_utils.dart';
import '../../utils/library_grouping.dart';
import '../../widgets/app_menu.dart';
import '../../widgets/backend_badge.dart';
import '../../widgets/bottom_sheet_header.dart';

class LibraryQuickPickerSheet extends StatelessWidget {
  final List<MediaLibrary> libraries;
  final String? selectedLibraryKey;
  final bool isLoading;
  final bool groupByServer;
  final String emptyMessage;
  final ValueChanged<String> onSelected;

  const LibraryQuickPickerSheet({
    super.key,
    required this.libraries,
    required this.selectedLibraryKey,
    required this.isLoading,
    required this.groupByServer,
    required this.emptyMessage,
    required this.onSelected,
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

  List<AppMenuEntry<String>> _buildEntries() {
    if (!_showServerHeaders) {
      final nonUniqueNames = _getNonUniqueLibraryNames();
      return [
        for (final library in libraries)
          _libraryEntry(
            library,
            showServerName: library.serverName != null && nonUniqueNames.contains(library.title),
          ),
      ];
    }

    final grouped = groupLibrariesByFirstAppearance(libraries);
    final entries = <AppMenuEntry<String>>[];
    for (final serverKey in grouped.serverOrder) {
      final bucket = grouped.byServer[serverKey]!;
      if (serverKey.isNotEmpty) {
        entries.add(AppMenuHeader<String>(child: _serverLabel(bucket.first, serverKey)));
      }
      for (final library in bucket) {
        entries.add(_libraryEntry(library, showServerName: false));
      }
    }
    return entries;
  }

  AppMenuItem<String> _libraryEntry(MediaLibrary library, {required bool showServerName}) {
    return AppMenuItem<String>(
      value: library.globalKey,
      label: library.title,
      icon: ContentTypeHelper.getLibraryIcon(library.kind.id),
      subtitleWidget: showServerName ? _serverLabel(library, library.serverName!) : null,
      selected: library.globalKey == selectedLibraryKey,
    );
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
        BottomSheetHeader(title: t.libraries.selectLibrary),
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
              child: AppMenuList<String>(
                padding: const EdgeInsets.only(bottom: 8),
                entries: _buildEntries(),
                onSelected: onSelected,
              ),
            ),
          ),
      ],
    );
  }
}
