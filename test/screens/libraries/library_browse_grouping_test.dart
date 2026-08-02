import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_library.dart';
import 'package:harbor/screens/libraries/library_browse_grouping.dart';

MediaLibrary _library({required MediaKind kind}) {
  return MediaLibrary(id: '1', backend: MediaBackend.jellyfin, title: 'Library', kind: kind, serverId: 'server-1');
}

void main() {
  group('libraryBrowseGroupingOptions', () {
    test('movie libraries optionally include folders', () {
      final library = _library(kind: MediaKind.movie);

      expect(libraryBrowseGroupingOptions(library, canGroupByFolders: false), const [browseGroupingMovies]);
      expect(libraryBrowseGroupingOptions(library, canGroupByFolders: true), const [
        browseGroupingMovies,
        browseGroupingFolders,
      ]);
    });

    test('show libraries include show hierarchy before folders', () {
      final library = _library(kind: MediaKind.show);

      expect(libraryBrowseGroupingOptions(library, canGroupByFolders: true), const [
        browseGroupingShows,
        browseGroupingSeasons,
        browseGroupingEpisodes,
        browseGroupingFolders,
      ]);
    });

    test('music libraries group by artists, albums, and tracks', () {
      final library = _library(kind: MediaKind.artist);

      expect(libraryBrowseGroupingOptions(library, canGroupByFolders: false), const [
        browseGroupingArtists,
        browseGroupingAlbums,
        browseGroupingTracks,
      ]);
      expect(libraryBrowseGroupingOptions(library, canGroupByFolders: true), const [
        browseGroupingArtists,
        browseGroupingAlbums,
        browseGroupingTracks,
        browseGroupingFolders,
      ]);
    });
  });

  group('normalizeLibraryBrowseGrouping', () {
    test('keeps a valid saved grouping', () {
      final library = _library(kind: MediaKind.show);

      expect(
        normalizeLibraryBrowseGrouping(library, browseGroupingEpisodes, canGroupByFolders: false),
        browseGroupingEpisodes,
      );
    });

    test('falls back when saved folder grouping is no longer available', () {
      final library = _library(kind: MediaKind.movie);

      expect(
        normalizeLibraryBrowseGrouping(library, browseGroupingFolders, canGroupByFolders: false),
        browseGroupingMovies,
      );
    });

    test('music libraries default to artists and keep a saved music grouping', () {
      final library = _library(kind: MediaKind.artist);

      expect(normalizeLibraryBrowseGrouping(library, null, canGroupByFolders: false), browseGroupingArtists);
      expect(
        normalizeLibraryBrowseGrouping(library, browseGroupingTracks, canGroupByFolders: false),
        browseGroupingTracks,
      );
    });

    test('clip libraries default to folders when available (#966)', () {
      final library = _library(kind: MediaKind.clip);

      expect(normalizeLibraryBrowseGrouping(library, null, canGroupByFolders: true), browseGroupingFolders);
      expect(normalizeLibraryBrowseGrouping(library, null, canGroupByFolders: false), browseGroupingAll);
    });

    test('clip libraries keep an explicitly saved flat grouping', () {
      final library = _library(kind: MediaKind.clip);

      expect(normalizeLibraryBrowseGrouping(library, browseGroupingAll, canGroupByFolders: true), browseGroupingAll);
    });
  });
}
