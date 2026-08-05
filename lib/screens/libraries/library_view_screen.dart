import 'package:flutter/material.dart';

import '../../i18n/strings.g.dart';
import '../../media/media_library.dart';
import '../../widgets/bottom_sheet_header.dart';
import 'tabs/library_collections_tab.dart';
import 'tabs/library_playlists_tab.dart';
import 'tabs/library_recommended_tab.dart';

/// A library view you reach deliberately rather than one you pass through.
///
/// Recommended, Collections and Playlists were pills beside Browse, which put
/// four ways of looking at a library in front of you every time you opened one —
/// and clipped the row on a phone. They are pushed from Library options now, and
/// gain the title bar a pill never gave them.
enum LibraryViewKind {
  recommended,
  collections,
  playlists;

  String get label => switch (this) {
    LibraryViewKind.recommended => t.libraries.tabs.recommended,
    LibraryViewKind.collections => t.libraries.tabs.collections,
    LibraryViewKind.playlists => t.libraries.tabs.playlists,
  };
}

class LibraryViewScreen extends StatelessWidget {
  const LibraryViewScreen({super.key, required this.library, required this.kind});

  final MediaLibrary library;
  final LibraryViewKind kind;

  static Future<void> push(BuildContext context, {required MediaLibrary library, required LibraryViewKind kind}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LibraryViewScreen(library: library, kind: kind),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // The same header a sheet wears, so a pushed view is not a third
            // kind of title bar.
            BottomSheetHeader(
              title: kind.label,
              onBack: () => Navigator.of(context).maybePop(),
              action: Text(library.title, style: Theme.of(context).textTheme.labelMedium),
            ),
            Expanded(child: _view()),
          ],
        ),
      ),
    );
  }

  Widget _view() => switch (kind) {
    LibraryViewKind.recommended => LibraryRecommendedTab(library: library, isActive: true),
    LibraryViewKind.collections => LibraryCollectionsTab(library: library, isActive: true),
    LibraryViewKind.playlists => LibraryPlaylistsTab(library: library, isActive: true),
  };
}
