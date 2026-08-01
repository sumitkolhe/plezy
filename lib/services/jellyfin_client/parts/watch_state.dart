part of '../../jellyfin_client.dart';

mixin _JellyfinWatchStateMethods on _JellyfinClientInternals {
  @override
  Future<void> markWatched(MediaItem item) async {
    final response = await _http.post(
      '/UserPlayedItems/${_segment(item.id)}',
      queryParameters: {'userId': connection.userId},
    );
    throwIfHttpError(response);
  }

  @override
  Future<void> markUnwatched(MediaItem item) async {
    final response = await _http.delete(
      '/UserPlayedItems/${_segment(item.id)}',
      queryParameters: {'userId': connection.userId},
    );
    throwIfHttpError(response);
  }

  @override
  Future<void> removeFromContinueWatching(MediaItem item) async {
    throw UnsupportedError('Jellyfin does not support removing items from Continue Watching.');
  }

  @override
  Future<void> setFavorite(MediaItem item, bool isFavorite) => _setItemFavorite(item.id, isFavorite);

  /// Toggle the per-user `IsFavorite` flag for [itemId]. Backs [setFavorite]
  /// and the live-TV favorite-channel adapter; works on any Jellyfin item.
  Future<void> _setItemFavorite(String itemId, bool isFavorite) async {
    final path = '/UserFavoriteItems/${_segment(itemId)}';
    final response = isFavorite
        ? await _http.post(path, queryParameters: {'userId': connection.userId})
        : await _http.delete(path, queryParameters: {'userId': connection.userId});
    throwIfHttpError(response);
  }
}
