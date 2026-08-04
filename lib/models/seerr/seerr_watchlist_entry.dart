/// One row of Seerr's own watchlist table.
class SeerrWatchlistEntry {
  final int tmdbId;
  final bool isTv;
  final String? title;

  const SeerrWatchlistEntry({required this.tmdbId, required this.isTv, this.title});

  factory SeerrWatchlistEntry.fromJson(Map<String, dynamic> json) => SeerrWatchlistEntry(
    tmdbId: ((json['tmdbId'] ?? json['id']) as num?)?.toInt() ?? 0,
    isTv: json['mediaType'] == 'tv',
    title: json['title'] as String?,
  );
}
