import '../media/library_query.dart';
import '../media/media_kind.dart';

/// Browse responses retain up to three backdrops so hero surfaces can rotate
/// artwork without allowing image-tag payloads to grow without bound.
const jellyfinBackdropImageLimit = 3;
const jellyfinImageQueryParameters = <String, String>{
  'EnableImageTypes': 'Primary,Backdrop,Thumb,Logo',
  'ImageTypeLimit': '$jellyfinBackdropImageLimit',
};

/// Translates a backend-neutral [LibraryQuery] into the per-backend
/// query-parameter map that the corresponding `/library/sections/{id}/all`
/// (Plex) or `/Items` (Jellyfin) endpoint expects.
///
/// Pulled out of the clients so the translation can be unit-tested without
/// spinning up an HTTP layer, and so the per-backend filter/sort name
/// mappings live in one place.
abstract class LibraryQueryTranslator {
  Map<String, dynamic> toQueryParameters(LibraryQuery query);

  /// Parse a Plex-style sort string (`field` or `field:desc`) into the
  /// backend-neutral [LibrarySort] consumed by the translators. Returns
  /// `null` when the input is empty or the field portion is missing.
  static LibrarySort? parseSortParam(String? raw) {
    if (raw == null || raw.isEmpty) return null;
    const descSuffix = ':desc';
    const ascSuffix = ':asc';
    final descending = raw.endsWith(descSuffix);
    final ascending = raw.endsWith(ascSuffix);
    final field = descending
        ? raw.substring(0, raw.length - descSuffix.length)
        : ascending
        ? raw.substring(0, raw.length - ascSuffix.length)
        : raw;
    if (field.isEmpty) return null;
    return LibrarySort(
      field: field,
      direction: descending ? LibrarySortDirection.descending : LibrarySortDirection.ascending,
    );
  }
}

/// Build a neutral [LibraryQuery] from the browse tab's flat
/// `Map<String,String>` filter map.
///
/// Recognised keys map to their typed [LibraryQuery] slots (genre/year/
/// contentRating/tag/unwatched/sort/type/alphaPrefix). Anything else carries
/// over as a generic [LibraryFilter] entry.
///
/// `libraryKind` overrides any `type=` entry — both can be sources of truth
/// in the existing browse tab and the explicit argument wins.
LibraryQuery libraryQueryFromPlexMap({
  required Map<String, String> map,
  MediaKind? libraryKind,
  int offset = 0,
  int limit = 50,
}) {
  const knownKeys = {
    'genre',
    'year',
    'contentRating',
    'tag',
    'unwatched',
    'favorite',
    'sort',
    'type',
    'alphaPrefix',
    'includeCollections',
    'title',
  };

  String? nonEmpty(String? raw) => (raw == null || raw.isEmpty) ? null : raw;

  // libraryKind has priority; otherwise derive from `type` (single numeric
  // value only — multi-value `type` like "1,4" stays in the generic filter
  // bucket).
  final typeRaw = nonEmpty(map['type']);
  final kindFromMap = (typeRaw != null && !typeRaw.contains(',')) ? _plexTypeMediaKind(typeRaw) : null;
  final kind = libraryKind ?? kindFromMap;

  final unknownFilters = <LibraryFilter>[];
  for (final entry in map.entries) {
    if (knownKeys.contains(entry.key) || entry.value.isEmpty) continue;
    unknownFilters.add(LibraryFilter(field: entry.key, values: entry.value.split(',')));
  }
  // Multi-value `type` couldn't fold into `kind`; preserve it as a generic
  // filter entry.
  if (typeRaw != null && typeRaw.contains(',')) {
    unknownFilters.add(LibraryFilter(field: 'type', values: typeRaw.split(',')));
  }

  List<String>? singleton(String? raw) => raw == null ? null : [raw];

  final yearRaw = nonEmpty(map['year']);
  final years = yearRaw?.split(',').map(int.tryParse).whereType<int>().toList();

  return LibraryQuery(
    kind: (kind == null || kind == MediaKind.unknown) ? null : kind,
    offset: offset,
    limit: limit,
    includeWatched: nonEmpty(map['unwatched']) != '1',
    favoritesOnly: nonEmpty(map['favorite']) == '1',
    nameStartsWith: nonEmpty(map['alphaPrefix']),
    search: nonEmpty(map['title']),
    genres: singleton(nonEmpty(map['genre'])),
    officialRatings: singleton(nonEmpty(map['contentRating'])),
    tags: singleton(nonEmpty(map['tag'])),
    years: (years == null || years.isEmpty) ? null : years,
    sort: LibraryQueryTranslator.parseSortParam(nonEmpty(map['sort'])),
    filters: unknownFilters,
  );
}

MediaKind? _plexTypeMediaKind(String typeNumber) {
  return switch (typeNumber) {
    '1' => MediaKind.movie,
    '2' => MediaKind.show,
    '3' => MediaKind.season,
    '4' => MediaKind.episode,
    '8' => MediaKind.artist,
    '9' => MediaKind.album,
    '10' => MediaKind.track,
    _ => null,
  };
}

/// Jellyfin's `/Items` accepts a richer parameter set with separate keys
/// for filters (`Genres`, `OfficialRatings`, `Tags`, `Years`), sort
/// (`SortBy`/`SortOrder`), pagination (`StartIndex`/`Limit`), and
/// item-type narrowing (`IncludeItemTypes`).
///
/// The translator needs the calling user's id (every Jellyfin browse
/// query is user-scoped) and the parent library id; both are passed in
/// at construction time so the resulting map round-trips through
/// `_http.get('/Items', queryParameters: ...)` without further mutation.
class JellyfinLibraryQueryTranslator implements LibraryQueryTranslator {
  final String userId;
  final String parentId;
  final String fields;

  const JellyfinLibraryQueryTranslator({required this.userId, required this.parentId, required this.fields});

  @override
  Map<String, dynamic> toQueryParameters(LibraryQuery query) {
    final params = <String, dynamic>{
      'userId': userId,
      'ParentId': parentId,
      'Recursive': 'true',
      'StartIndex': query.offset.toString(),
      'Limit': query.limit.toString(),
      'EnableTotalRecordCount': 'true',
      'IncludeItemTypes': _includeTypesFor(query),
      'Fields': fields,
      ...jellyfinImageQueryParameters,
    };
    final wireFilters = <String>[if (!query.includeWatched) 'IsUnplayed', if (query.favoritesOnly) 'IsFavorite'];
    if (wireFilters.isNotEmpty) {
      params['Filters'] = wireFilters.join(',');
    }
    if (query.genres != null && query.genres!.isNotEmpty) {
      // Jellyfin uses `|` as the multi-value separator for Genres.
      params['Genres'] = query.genres!.join('|');
    }
    if (query.officialRatings != null && query.officialRatings!.isNotEmpty) {
      params['OfficialRatings'] = query.officialRatings!.join('|');
    }
    if (query.years != null && query.years!.isNotEmpty) {
      params['Years'] = query.years!.join(',');
    }
    if (query.tags != null && query.tags!.isNotEmpty) {
      params['Tags'] = query.tags!.join('|');
    }
    final sort = query.sort;
    if (sort != null) {
      params['SortBy'] = _sortFieldFor(sort.field, query.kind);
      params['SortOrder'] = sort.direction == LibrarySortDirection.descending ? 'Descending' : 'Ascending';
    }
    if (query.search != null && query.search!.isNotEmpty) {
      params['SearchTerm'] = query.search;
    }
    final prefix = query.nameStartsWith;
    if (prefix != null && prefix.isNotEmpty) {
      // `#` is the alpha-bar sentinel for "non-alphabetic" — match the JF
      // web client by asking for everything sorted before "A".
      if (prefix == '#') {
        params['NameLessThan'] = 'A';
      } else {
        params['NameStartsWith'] = prefix;
      }
    }
    return params;
  }

  static String _includeTypesFor(LibraryQuery query) {
    if (query.includeKinds.isNotEmpty) {
      return query.includeKinds.map(_includeTypesForKind).join(',');
    }
    return _includeTypesForKind(query.kind);
  }

  static String _includeTypesForKind(MediaKind? kind) {
    return switch (kind) {
      MediaKind.movie => 'Movie',
      MediaKind.show => 'Series',
      MediaKind.season => 'Season',
      MediaKind.episode => 'Episode',
      MediaKind.artist => 'MusicArtist',
      MediaKind.album => 'MusicAlbum',
      MediaKind.track => 'Audio',
      MediaKind.collection => 'BoxSet',
      MediaKind.playlist => 'Playlist',
      MediaKind.clip => 'Video,MusicVideo',
      MediaKind.photo => 'Photo',
      _ => 'Movie,Series,Episode,Audio',
    };
  }

  static String _sortFieldFor(String neutral, MediaKind? kind) {
    return switch (neutral) {
      'addedAt' => 'DateCreated',
      'episode.addedAt' => 'DateLastContentAdded,SortName',
      'dateCreated' => 'DateCreated',
      'originallyAvailableAt' => 'PremiereDate',
      'premiereDate' => 'PremiereDate',
      'lastViewedAt' || 'datePlayed' => kind == MediaKind.show ? 'SeriesDatePlayed' : 'DatePlayed',
      'title' => 'SortName',
      'name' => 'SortName',
      'rating' || 'communityRating' => 'CommunityRating',
      'viewCount' || 'playCount' => 'PlayCount',
      'productionYear' => 'ProductionYear',
      'runtime' => 'Runtime',
      'officialRating' => 'OfficialRating',
      'criticRating' => 'CriticRating',
      'startDate' => 'StartDate',
      'airTime' => 'AirTime',
      'studio' => 'Studio',
      'random' => 'Random',
      _ => neutral,
    };
  }
}
