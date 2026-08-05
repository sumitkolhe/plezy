import 'package:flutter/foundation.dart';

import '../../media/library_view.dart';

/// What the library screen is showing.
///
/// Choosing a library, choosing Missing and choosing a saved view were three
/// controls asking one question — what set of items am I looking at. They are one
/// selection now, so the selector is the only place that answers it.
@immutable
class LibrarySelection {
  const LibrarySelection.library(this.libraryGlobalKey) : missing = false, view = null;
  const LibrarySelection.missing(this.libraryGlobalKey) : missing = true, view = null;
  const LibrarySelection.view(this.libraryGlobalKey, LibraryView this.view) : missing = false;

  final String libraryGlobalKey;

  /// What the *arr tracking this library has no file for.
  final bool missing;

  /// A saved shape over the library's own contents.
  final LibraryView? view;

  /// What the last-selection preference stores. Distinct per selection within a
  /// library, and a name that no longer resolves simply falls back.
  String get storageName => switch (this) {
    _ when missing => 'missing',
    _ when view != null => 'view:${view!.name}',
    _ => 'browse',
  };

  static LibrarySelection resolve(String libraryGlobalKey, String? storageName, List<LibraryView> views) {
    if (storageName == 'missing') return LibrarySelection.missing(libraryGlobalKey);
    if (storageName != null && storageName.startsWith('view:')) {
      final name = storageName.substring('view:'.length);
      final match = views.where((view) => view.name == name).firstOrNull;
      if (match != null) return LibrarySelection.view(libraryGlobalKey, match);
    }
    return LibrarySelection.library(libraryGlobalKey);
  }

  @override
  bool operator ==(Object other) =>
      other is LibrarySelection &&
      other.libraryGlobalKey == libraryGlobalKey &&
      other.missing == missing &&
      other.view?.name == view?.name;

  @override
  int get hashCode => Object.hash(libraryGlobalKey, missing, view?.name);
}
