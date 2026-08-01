// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'ids.dart';

import '../services/settings_service.dart' show CardOrientation, EpisodePosterMode;
import '../utils/global_key_utils.dart';
import '../utils/json_utils.dart';
import 'media_backend.dart';
import 'media_kind.dart';
import 'media_role.dart';
import 'media_version.dart';

part 'media_item.freezed.dart';
part 'media_item.g.dart';

/// Container aspect ratio below which a hero prefers square background art.
/// A 16:9 backdrop only cover-fits a taller box by discarding most of the
/// frame, so portrait phone/tablet heroes read better with the square image.
const double _squareHeroAspectRatio = 1.39;

/// Backend-neutral media item shape used by UI, providers, persistence, and
/// playback. Concrete variants retain backend-only fields without forcing the
/// rest of the app to traffic in Plex/Jellyfin DTOs.
@Freezed(unionKey: 'backend', unionValueCase: FreezedUnionCase.none, equal: false, makeCollectionsUnmodifiable: false)
sealed class MediaItem with _$MediaItem {
  const MediaItem._();

  /// Backend-dispatching compatibility factory used by existing call sites.
  factory MediaItem({
    required String id,
    required MediaBackend backend,
    required MediaKind kind,
    String? guid,
    String? title,
    String? titleSort,
    String? summary,
    String? tagline,
    String? originalTitle,
    String? studio,
    int? year,
    String? originallyAvailableAt,
    String? contentRating,
    String? parentId,
    String? parentTitle,
    String? parentThumbPath,
    int? parentIndex,
    int? index,
    String? grandparentId,
    String? grandparentTitle,
    String? grandparentThumbPath,
    String? grandparentArtPath,
    List<String>? grandparentBackdropPaths,
    String? thumbPath,
    String? artPath,
    List<String>? backdropPaths,
    String? clearLogoPath,
    String? backgroundSquarePath,
    int? durationMs,
    int? viewOffsetMs,
    int? viewCount,
    int? lastViewedAt,
    int? leafCount,
    int? viewedLeafCount,
    int? childCount,
    int? addedAt,
    int? updatedAt,
    double? rating,
    double? userRating,
    bool? isFavorite,
    List<String>? genres,
    List<String>? directors,
    List<String>? writers,
    List<String>? producers,
    List<String>? countries,
    List<String>? collections,
    List<String>? labels,
    List<String>? styles,
    List<String>? moods,
    List<MediaRole>? roles,
    List<MediaVersion>? mediaVersions,
    String? libraryId,
    String? libraryTitle,
    String? audioLanguage,
    String? subtitleLanguage,
    int? subtitleMode,
    String? serverId,
    String? serverName,
    String? backendFolderKey,
    Map<String, Object?>? raw,
  }) {
    return switch (backend) {
      MediaBackend.jellyfin => JellyfinMediaItem(
        id: id,
        kind: kind,
        guid: guid,
        title: title,
        titleSort: titleSort,
        summary: summary,
        tagline: tagline,
        originalTitle: originalTitle,
        studio: studio,
        year: year,
        originallyAvailableAt: originallyAvailableAt,
        contentRating: contentRating,
        parentId: parentId,
        parentTitle: parentTitle,
        parentThumbPath: parentThumbPath,
        parentIndex: parentIndex,
        index: index,
        grandparentId: grandparentId,
        grandparentTitle: grandparentTitle,
        grandparentThumbPath: grandparentThumbPath,
        grandparentArtPath: grandparentArtPath,
        grandparentBackdropPaths: grandparentBackdropPaths,
        thumbPath: thumbPath,
        artPath: artPath,
        backdropPaths: backdropPaths,
        clearLogoPath: clearLogoPath,
        backgroundSquarePath: backgroundSquarePath,
        durationMs: durationMs,
        viewOffsetMs: viewOffsetMs,
        viewCount: viewCount,
        lastViewedAt: lastViewedAt,
        leafCount: leafCount,
        viewedLeafCount: viewedLeafCount,
        childCount: childCount,
        addedAt: addedAt,
        updatedAt: updatedAt,
        rating: rating,
        userRating: userRating,
        isFavorite: isFavorite,
        genres: genres,
        directors: directors,
        writers: writers,
        producers: producers,
        countries: countries,
        collections: collections,
        labels: labels,
        styles: styles,
        moods: moods,
        roles: roles,
        mediaVersions: mediaVersions,
        libraryId: libraryId,
        libraryTitle: libraryTitle,
        audioLanguage: audioLanguage,
        serverId: serverId,
        serverName: serverName,
        backendFolderKey: backendFolderKey,
        raw: raw,
      ),
    };
  }

  /// Backend-tagged concrete subclass for items sourced from a Jellyfin server.
  @FreezedUnionValue('jellyfin')
  @JsonSerializable(includeIfNull: false, explicitToJson: true)
  const factory MediaItem.jellyfin({
    @JsonKey(readValue: readStringField, defaultValue: '') required String id,
    @JsonKey(fromJson: _mediaKindFromJson, toJson: _mediaKindToJson) required MediaKind kind,
    String? guid,
    String? title,
    String? titleSort,
    String? summary,
    String? tagline,
    String? originalTitle,
    String? studio,
    @JsonKey(fromJson: flexibleInt) int? year,
    String? originallyAvailableAt,
    String? contentRating,
    String? parentId,
    String? parentTitle,
    String? parentThumbPath,
    @JsonKey(fromJson: flexibleInt) int? parentIndex,
    @JsonKey(fromJson: flexibleInt) int? index,
    String? grandparentId,
    String? grandparentTitle,
    String? grandparentThumbPath,
    String? grandparentArtPath,
    List<String>? grandparentBackdropPaths,
    String? thumbPath,
    String? artPath,
    List<String>? backdropPaths,
    String? clearLogoPath,
    String? backgroundSquarePath,
    @JsonKey(fromJson: flexibleInt) int? durationMs,
    @JsonKey(fromJson: flexibleInt) int? viewOffsetMs,
    @JsonKey(fromJson: flexibleInt) int? viewCount,
    @JsonKey(fromJson: flexibleInt) int? lastViewedAt,
    @JsonKey(fromJson: flexibleInt) int? leafCount,
    @JsonKey(fromJson: flexibleInt) int? viewedLeafCount,
    @JsonKey(fromJson: flexibleInt) int? childCount,
    @JsonKey(fromJson: flexibleInt) int? addedAt,
    @JsonKey(fromJson: flexibleInt) int? updatedAt,
    @JsonKey(fromJson: flexibleDouble) double? rating,
    @JsonKey(fromJson: flexibleDouble) double? userRating,
    bool? isFavorite,
    @JsonKey(fromJson: _mediaItemStringList) List<String>? genres,
    @JsonKey(fromJson: _mediaItemStringList) List<String>? directors,
    @JsonKey(fromJson: _mediaItemStringList) List<String>? writers,
    @JsonKey(fromJson: _mediaItemStringList) List<String>? producers,
    @JsonKey(fromJson: _mediaItemStringList) List<String>? countries,
    @JsonKey(fromJson: _mediaItemStringList) List<String>? collections,
    @JsonKey(fromJson: _mediaItemStringList) List<String>? labels,
    @JsonKey(fromJson: _mediaItemStringList) List<String>? styles,
    @JsonKey(fromJson: _mediaItemStringList) List<String>? moods,
    @JsonKey(fromJson: _mediaItemRolesFromJson) List<MediaRole>? roles,
    @JsonKey(fromJson: _mediaItemVersionsFromJson) List<MediaVersion>? mediaVersions,
    String? libraryId,
    String? libraryTitle,
    String? audioLanguage,

    /// Jellyfin playlist entry id used by playlist write endpoints.
    String? playlistItemId,
    String? serverId,
    String? serverName,

    /// Always null on Jellyfin — folder children are fetched by [id]. Exists
    /// on both variants so the union exposes one neutral getter.
    String? backendFolderKey,
    @JsonKey(fromJson: _mediaItemRawFromJson) Map<String, Object?>? raw,
  }) = JellyfinMediaItem;

  MediaBackend get backend => MediaBackend.jellyfin;

  /// Restore a [MediaItem] from a [toJson] payload. Cache rows written before
  /// the Jellyfin-only collapse carry an extra `backend` key; it is ignored.
  factory MediaItem.fromJson(Map<String, dynamic> json) => _$JellyfinMediaItemFromJson(json);

  /// Global unique identifier across all servers (`serverId:id`). Falls back
  /// to bare [id] if [serverId] is missing.
  String get globalKey => serverId != null ? buildGlobalKey(ServerId(serverId!), id) : id;

  /// Global unique identifier of this item's library section.
  String? get libraryGlobalKey =>
      serverId != null && libraryId != null ? buildGlobalKey(ServerId(serverId!), libraryId!) : null;

  /// Global unique identifier of this item's series, for episodes/seasons.
  /// Null for movies and shows themselves — their own [globalKey] is already
  /// series-level.
  String? get seriesGlobalKey {
    final seriesId = switch (kind) {
      MediaKind.episode => grandparentId,
      MediaKind.season => grandparentId ?? parentId,
      _ => null,
    };
    if (seriesId == null) return null;
    return serverId != null ? buildGlobalKey(ServerId(serverId!), seriesId) : seriesId;
  }

  /// Parent rating keys for hierarchical invalidation. For an episode:
  /// `[seasonId, showId]`. For a season: `[showId]`. For a movie: `[]`.
  List<String> get parentChain => [?parentId, ?grandparentId];

  /// Server-side file paths across every version of this item. Plex
  /// represents a multi-episode file (`S02E24-E25.mkv`) as distinct episode
  /// items whose parts have *different* part ids but the same file, so the
  /// file path — not the part id — is the "same underlying file" signal
  /// (#1500).
  Set<String> get allPartFiles => {
    for (final version in mediaVersions ?? const <MediaVersion>[])
      for (final part in version.parts)
        if (part.file != null && part.file!.isNotEmpty) part.file!,
  };

  /// Whether [other] is backed by the same physical file as this item.
  /// [playedPartId] — the part actually being played, when known — pins the
  /// comparison to that part's file, so an episode with multiple versions
  /// only matches against the file on screen; otherwise any file overlap
  /// between the two items counts. Items without file metadata (Plex hides
  /// paths from restricted users) or from a different server never match.
  bool sharesFileWith(MediaItem other, {String? playedPartId}) {
    if (other.serverId != serverId) return false;
    final otherFiles = other.allPartFiles;
    if (otherFiles.isEmpty) return false;
    if (playedPartId != null) {
      final playedFile = _filePathForPart(playedPartId);
      if (playedFile != null) return otherFiles.contains(playedFile);
    }
    return allPartFiles.intersection(otherFiles).isNotEmpty;
  }

  /// The file path of this item's part with [partId], or null when unknown.
  String? _filePathForPart(String partId) {
    for (final version in mediaVersions ?? const <MediaVersion>[]) {
      for (final part in version.parts) {
        if (part.id == partId) return (part.file?.isEmpty ?? true) ? null : part.file;
      }
    }
    return null;
  }

  /// Recency used to order the Continue Watching / On Deck shelf: when the item
  /// was last watched, falling back to when it was added for never-watched rows.
  /// Shared by the per-client merge and the cross-server sort so they agree.
  int get recencySortKey => lastViewedAt ?? addedAt ?? 0;

  /// Whether this item has started but not finished playback.
  bool get hasActiveProgress {
    if (durationMs == null || viewOffsetMs == null) return false;
    return viewOffsetMs! > 0 && viewOffsetMs! < durationMs!;
  }

  /// Whether this item still counts toward an "unwatched only" selection:
  /// not fully watched, or watched-but-resumable (has active progress). The
  /// shared predicate behind every `unwatchedOnly` filter (downloads, sync
  /// rules, the unwatched-episode lookups in episode_collection.dart).
  bool get isUnwatchedOrInProgress => !isWatched || hasActiveProgress;

  /// Positive leaf total used for aggregate watch state, or null when this
  /// item is a leaf or has no authoritative total. A season's direct children
  /// are episodes, so [childCount] is a valid fallback there; it is not valid
  /// for shows, whose direct children are seasons.
  int? get leafWatchTotal {
    if (!kind.usesLeafWatchCounts) return null;
    final total = leafCount ?? (kind == MediaKind.season ? childCount : null);
    return total != null && total > 0 ? total : null;
  }

  /// Normalized aggregate completion in the inclusive range 0–1.
  double? get leafWatchFraction {
    final total = leafWatchTotal;
    final viewed = viewedLeafCount;
    if (total == null || viewed == null) return null;
    if (viewed <= 0) return 0;
    if (viewed >= total) return 1;
    return viewed / total;
  }

  /// Whether this container has some but not all leaves watched.
  bool get isPartiallyWatched {
    final fraction = leafWatchFraction;
    return fraction != null && fraction > 0 && fraction < 1;
  }

  /// Whether the item is fully watched. Container kinds use positive
  /// aggregate leaf totals; leaf kinds use their own [viewCount].
  bool get isWatched {
    final fraction = leafWatchFraction;
    if (fraction != null) return fraction >= 1;
    return viewCount != null && viewCount! > 0;
  }

  /// Unwatched leaf count for container badges. Falls back to Jellyfin's
  /// `UserData.UnplayedItemCount` when leaf totals weren't requested
  /// (e.g. the folder tree's slim field set).
  int? get unwatchedCount {
    if (!kind.usesLeafWatchCounts) return null;

    final total = leafWatchTotal;
    final viewed = viewedLeafCount;
    if (total != null && viewed != null) {
      if (viewed <= 0) return total;
      if (viewed >= total) return 0;
      return total - viewed;
    }

    final userData = raw?['UserData'];
    final unwatched = userData is Map<String, dynamic> ? flexibleInt(userData['UnplayedItemCount']) : null;
    return unwatched != null && unwatched >= 0 ? unwatched : null;
  }

  /// Copy with the watched flag applied so [isWatched] reflects it for every
  /// kind. This is the single mutation seam used by watch-state overlays.
  MediaItem withWatchedFlag(bool isWatched) {
    var updated = copyWith(viewCount: isWatched ? 1 : 0);
    final total = leafWatchTotal;
    if (total != null) {
      updated = updated.copyWith(viewedLeafCount: isWatched ? total : 0);
    } else if (!kind.usesLeafWatchCounts && viewedLeafCount != null) {
      updated = updated.copyWith(viewedLeafCount: null);
    }
    return updated;
  }

  /// Display-friendly title that prefers the show name for episodes/seasons.
  String get displayTitle {
    if ((kind == MediaKind.episode || kind == MediaKind.season) && grandparentTitle != null) {
      return grandparentTitle!;
    }
    if (kind == MediaKind.season && parentTitle != null) {
      return parentTitle!;
    }
    return title ?? '';
  }

  /// Subtitle line shown below [displayTitle] for episodes/seasons.
  String? get displaySubtitle {
    if (kind == MediaKind.episode || kind == MediaKind.season) {
      if (grandparentTitle != null || (kind == MediaKind.season && parentTitle != null)) {
        return title;
      }
    }
    return null;
  }

  /// Track number within its disc, for [MediaKind.track] items.
  int? get trackNumber => kind == MediaKind.track ? index : null;

  /// Disc number for [MediaKind.track] items (Plex `parentIndex`, Jellyfin
  /// `ParentIndexNumber`). Null/1 on single-disc albums.
  int? get discNumber => kind == MediaKind.track ? parentIndex : null;

  /// Album title for music items: a track's parent, an album's own title.
  String? get albumTitle => switch (kind) {
    MediaKind.track => parentTitle,
    MediaKind.album => title,
    _ => null,
  };

  /// Release year for music items. Track mappers normalize the containing
  /// album's year into [year] when the backend exposes it as parent metadata.
  int? get albumYear => kind == MediaKind.track || kind == MediaKind.album ? year : null;

  /// Album-artist name for music items: a track's grandparent, an album's
  /// parent.
  String? get albumArtistTitle => switch (kind) {
    MediaKind.track => grandparentTitle,
    MediaKind.album => parentTitle,
    _ => null,
  };

  /// Performing artist of a track. Falls back to [albumArtistTitle] — both
  /// backends only populate a separate value when it differs (Plex stores a
  /// compilation track's own artist in `originalTitle`; the Jellyfin mapper
  /// mirrors that convention from `Artists`).
  String? get trackArtistTitle => kind == MediaKind.track ? (originalTitle ?? albumArtistTitle) : null;

  /// Plex-only edition label. Jellyfin returns null.
  String? get editionTitle => null;

  /// The artwork this card shows. [mode] picks whose art an episode borrows;
  /// [orientation] picks which image of that subject — poster or backdrop.
  ///
  /// Two pairs collapse because the model carries no season backdrop and
  /// episodes carry no portrait art of their own: in landscape, season and
  /// series both resolve to the series backdrop; in portrait, thumbnail and
  /// series both resolve to the series poster. Folding beats cropping a 2:3
  /// poster into 16:9, which loses most of its height.
  String? posterThumb({
    EpisodePosterMode mode = EpisodePosterMode.seriesPoster,
    CardOrientation orientation = CardOrientation.portrait,
  }) {
    if (kind.isMusic) return thumbPath;
    if (kind == MediaKind.clip) return thumbPath ?? artPath;

    final wide = orientation == CardOrientation.landscape;

    if (kind == MediaKind.episode) {
      if (wide) {
        return mode == EpisodePosterMode.episodeThumbnail
            ? (thumbPath ?? grandparentArtPath)
            : (grandparentArtPath ?? thumbPath);
      }
      return mode == EpisodePosterMode.seasonPoster
          ? (parentThumbPath ?? grandparentThumbPath ?? thumbPath)
          : (grandparentThumbPath ?? thumbPath);
    }

    if (kind == MediaKind.season) {
      if (wide) return artPath ?? grandparentArtPath ?? thumbPath;
      return grandparentThumbPath ?? thumbPath;
    }

    if (wide) return artPath ?? thumbPath;
    return thumbPath;
  }

  /// Secondary poster path to try when [posterThumb] returns an image URL that
  /// exists syntactically but the server cannot serve it.
  String? posterThumbFallback({
    EpisodePosterMode mode = EpisodePosterMode.seriesPoster,
    CardOrientation orientation = CardOrientation.portrait,
  }) {
    final String? fallback;
    if (kind == MediaKind.track) {
      fallback = parentThumbPath;
    } else if (kind == MediaKind.episode && mode == EpisodePosterMode.seasonPoster) {
      fallback = grandparentThumbPath ?? thumbPath;
    } else {
      return null;
    }
    return fallback != null && fallback != posterThumb(mode: mode, orientation: orientation) ? fallback : null;
  }

  /// True when the item should render in 16:9.
  ///
  /// Clips only ever have a 16:9 still, and music artwork is square, so both
  /// opt out of the user's choice rather than render a frame they cannot fill.
  bool usesWideAspectRatio(CardOrientation orientation) {
    if (kind == MediaKind.clip) return true;
    if (kind.isMusic) return false;
    return orientation == CardOrientation.landscape;
  }

  /// The card silhouette this item renders with. Music items (artist/album/
  /// track) are square; everything else folds in the [usesWideAspectRatio]
  /// wide-vs-poster decision, so the two can never disagree.
  CardShape cardShape(CardOrientation orientation) {
    if (kind.isMusic) return CardShape.square;
    return usesWideAspectRatio(orientation) ? CardShape.wide : CardShape.poster;
  }

  /// The single silhouette a rail or grid of [items] reserves room for.
  ///
  /// Kinds that opt out of [orientation] — square music artwork, always-wide
  /// clips — would otherwise render a shape their row never sized for. A row
  /// that agrees on one shape uses it; anything mixed falls back to what
  /// [orientation] asks for, as does an empty row still loading.
  static CardShape shapeForItems(List<MediaItem> items, CardOrientation orientation) {
    final fallback = orientation == CardOrientation.landscape ? CardShape.wide : CardShape.poster;
    if (items.isEmpty) return fallback;
    final first = items.first.cardShape(orientation);
    return items.every((item) => item.cardShape(orientation) == first) ? first : fallback;
  }

  /// Every own-item backdrop in Jellyfin display order. Older persisted
  /// objects and backends with one backdrop fall back to [artPath].
  List<String> get resolvedBackdropPaths {
    final paths = backdropPaths;
    if (paths != null && paths.isNotEmpty) return paths;
    final primary = artPath;
    return primary == null || primary.isEmpty ? const [] : [primary];
  }

  /// Every inherited series backdrop in Jellyfin display order. Older
  /// persisted objects fall back to [grandparentArtPath].
  List<String> get resolvedGrandparentBackdropPaths {
    final paths = grandparentBackdropPaths;
    if (paths != null && paths.isNotEmpty) return paths;
    final primary = grandparentArtPath;
    return primary == null || primary.isEmpty ? const [] : [primary];
  }

  /// Backdrops eligible for rotation. Episodes prefer inherited series art;
  /// other kinds rotate only their own artwork.
  List<String> get heroBackdropPaths {
    if (kind == MediaKind.episode) {
      final inherited = resolvedGrandparentBackdropPaths;
      if (inherited.isNotEmpty) return inherited;
    }
    return resolvedBackdropPaths;
  }

  /// The backdrops a hero may rotate through in a container of
  /// [containerAspectRatio].
  ///
  /// `CyclingMediaBackdrop` cycles its rotation set indefinitely and reaches a
  /// fallback path only once every rotating path has failed to load, so the
  /// rotation set must hold whatever [heroArtCandidates] prefers — otherwise
  /// one servable wide backdrop hides the square background for good and a
  /// near-square hero is stuck with a cropped 16:9 frame. Such containers
  /// therefore rotate the square background alone, which is to say they hold
  /// still.
  List<String> heroRotationPaths({required double containerAspectRatio}) {
    if (containerAspectRatio < _squareHeroAspectRatio) {
      final square = backgroundSquarePath;
      if (square != null && square.isNotEmpty) return [square];
    }
    return heroBackdropPaths;
  }

  /// Returns hero art candidates in display-preference order.
  List<String> heroArtCandidates({required double containerAspectRatio}) {
    final own = resolvedBackdropPaths;
    final inherited = resolvedGrandparentBackdropPaths;
    final isNearSquare = containerAspectRatio < _squareHeroAspectRatio;
    final preferred = switch (kind) {
      MediaKind.episode when isNearSquare => <String?>[backgroundSquarePath, ...inherited, ...own],
      MediaKind.episode => <String?>[...inherited, ...own, backgroundSquarePath],
      _ when isNearSquare => <String?>[backgroundSquarePath, ...own],
      _ => <String?>[...own, backgroundSquarePath],
    };

    final candidates = <String>[];
    for (final path in preferred) {
      if (path == null || path.isEmpty || candidates.contains(path)) continue;
      candidates.add(path);
    }
    return candidates;
  }
}

/// The silhouette a media card renders with: 2:3 posters, 16:9 wide
/// thumbnails (episodes/clips), or 1:1 squares (music artwork; artists clip
/// to a circle). Resolved per item via [MediaItem.cardShape].
enum CardShape { poster, wide, square }

MediaKind _mediaKindFromJson(Object? raw) => MediaKind.fromString(raw as String?);

String _mediaKindToJson(MediaKind kind) => kind.id;

List<String>? _mediaItemStringList(Object? raw) => stringListFromRaw(raw, stringify: true);

List<MediaRole>? _mediaItemRolesFromJson(Object? raw) {
  return raw is List
      ? [
          for (final role in raw)
            if (role is Map<String, dynamic>) MediaRole.fromJson(role),
        ]
      : null;
}

List<MediaVersion>? _mediaItemVersionsFromJson(Object? raw) {
  return raw is List
      ? [
          for (final version in raw)
            if (version is Map<String, dynamic>) MediaVersion.fromJson(version),
        ]
      : null;
}

Map<String, Object?>? _mediaItemRawFromJson(Object? raw) => raw is Map ? Map<String, Object?>.from(raw) : null;
