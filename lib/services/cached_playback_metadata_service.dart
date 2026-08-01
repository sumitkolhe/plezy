import 'dart:convert';
import '../media/ids.dart';

import '../media/media_backend.dart';
import '../media/media_source_info.dart';
import '../utils/app_logger.dart';
import 'api_cache.dart';
import 'jellyfin_api_cache.dart';
import 'jellyfin_cache_resolver.dart';
import 'jellyfin_media_info_mapper.dart';

class CachedPlaybackMetadataService {
  const CachedPlaybackMetadataService._();

  static Future<MediaSourceInfo?> fetchMediaSourceInfo({
    required MediaBackend backend,
    required String cacheServerId,
    required String itemId,
    int mediaIndex = 0,
  }) async {
    try {
      return switch (backend) {
        MediaBackend.jellyfin => _fetchJellyfinMediaSourceInfo(cacheServerId, itemId, mediaIndex: mediaIndex),
      };
    } catch (e) {
      appLogger.d('Cached media source info unavailable for $cacheServerId:$itemId', error: e);
      return null;
    }
  }

  static Future<PlaybackExtras?> fetchPlaybackExtras({
    required MediaBackend backend,
    required String cacheServerId,
    required String itemId,
    String? introPattern,
    String? creditsPattern,
    bool forceChapterFallback = false,
  }) async {
    try {
      return switch (backend) {
        MediaBackend.jellyfin => _fetchJellyfinPlaybackExtras(
          cacheServerId,
          itemId,
          introPattern: introPattern,
          creditsPattern: creditsPattern,
          forceChapterFallback: forceChapterFallback,
        ),
      };
    } catch (e) {
      appLogger.d('Cached playback extras unavailable for $cacheServerId:$itemId', error: e);
      return null;
    }
  }

  static Future<MediaSourceInfo?> _fetchJellyfinMediaSourceInfo(
    String cacheServerId,
    String itemId, {
    required int mediaIndex,
  }) async {
    final resolved = await _jellyfinRawItem(cacheServerId, itemId);
    final raw = resolved.raw;
    final sources = raw['MediaSources'];
    if (sources is! List || sources.isEmpty) return null;
    final selected = mediaIndex >= 0 && mediaIndex < sources.length ? sources[mediaIndex] : sources.first;
    if (selected is! Map<String, dynamic>) return null;
    return jellyfinMediaSourceToMediaSourceInfo(selected, chapters: raw['Chapters'], trickplay: raw['Trickplay']);
  }

  static Future<PlaybackExtras?> _fetchJellyfinPlaybackExtras(
    String cacheServerId,
    String itemId, {
    String? introPattern,
    String? creditsPattern,
    bool forceChapterFallback = false,
  }) async {
    final resolved = await _jellyfinRawItem(cacheServerId, itemId);
    final raw = resolved.raw;
    final markers = await _jellyfinMediaSegmentMarkers(resolved.scopeId, itemId);
    return jellyfinPlaybackExtrasFromRaw(
      raw,
      itemId,
      introPattern: introPattern,
      creditsPattern: creditsPattern,
      forceChapterFallback: forceChapterFallback,
      markers: markers,
    );
  }

  static Future<List<MediaMarker>> _jellyfinMediaSegmentMarkers(String cacheServerId, String itemId) async {
    try {
      final raw = await ApiCache.forBackend(
        MediaBackend.jellyfin,
      ).get(ServerId(cacheServerId), JellyfinApiCache.mediaSegmentsEndpoint(itemId));
      return jellyfinMediaSegmentsToMarkers(raw);
    } catch (e) {
      appLogger.d('Cached Jellyfin media segments unavailable for $cacheServerId:$itemId', error: e);
      return const [];
    }
  }

  static Future<({Map<String, dynamic> raw, String scopeId})> _jellyfinRawItem(
    String cacheServerId,
    String itemId,
  ) async {
    final cache = ApiCache.forBackend(MediaBackend.jellyfin);
    final resolved = await JellyfinCacheResolver(cache.database).findItem(cacheServerId, itemId);
    if (resolved == null) throw StateError('No Jellyfin cache row for $cacheServerId:$itemId');
    return (raw: jsonDecode(resolved.cacheRow.data) as Map<String, dynamic>, scopeId: resolved.key.scopeId);
  }
}
