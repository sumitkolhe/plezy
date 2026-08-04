/// One candidate release from an interactive search.
class ArrRelease {
  /// The indexer's own id for this release, and what a grab is keyed on.
  final String guid;
  final int indexerId;

  final String title;
  final String indexer;
  final String quality;
  final int size;

  /// Torrent only; null for usenet, where seeders are meaningless.
  final int? seeders;

  final String protocol;

  /// How long ago the release was posted. Usenet's retention makes this the
  /// closest thing it has to health.
  final int ageHours;

  /// *arr's own verdict. A rejected release can still be grabbed — the reasons
  /// are advice, not a lock — so the list shows them rather than hiding it.
  final bool rejected;
  final List<String> rejections;

  const ArrRelease({
    required this.guid,
    required this.indexerId,
    required this.title,
    this.indexer = '',
    this.quality = '',
    this.size = 0,
    this.seeders,
    this.protocol = '',
    this.ageHours = 0,
    this.rejected = false,
    this.rejections = const [],
  });

  bool get isTorrent => protocol.toLowerCase() == 'torrent';

  static ArrRelease? fromJson(Map<String, dynamic> json) {
    final guid = (json['guid'] as String?)?.trim() ?? '';
    final title = (json['title'] as String?)?.trim() ?? '';
    if (guid.isEmpty || title.isEmpty) return null;

    final quality = json['quality'];
    final nested = quality is Map<String, dynamic> ? quality['quality'] : null;
    final rejections = json['rejections'];

    return ArrRelease(
      guid: guid,
      indexerId: ((json['indexerId'] as num?) ?? 0).toInt(),
      title: title,
      indexer: (json['indexer'] as String?)?.trim() ?? '',
      quality: nested is Map<String, dynamic> ? (nested['name'] as String?)?.trim() ?? '' : '',
      size: ((json['size'] as num?) ?? 0).toInt(),
      seeders: (json['seeders'] as num?)?.toInt(),
      protocol: (json['protocol'] as String?)?.trim() ?? '',
      ageHours: ((json['ageHours'] ?? json['age']) as num?)?.round() ?? 0,
      // `rejected` is absent on some indexer responses; a non-empty rejection
      // list is the reliable signal.
      rejected: json['rejected'] == true || (rejections is List && rejections.isNotEmpty),
      rejections: rejections is List ? [for (final r in rejections) if (r is String) r] : const [],
    );
  }
}

/// Orders releases the way a person picks one: everything *arr would accept
/// first, then by health.
///
/// Health means seeders for a torrent and youth for usenet, so the two are
/// ranked on their own terms rather than on one shared number that would sort
/// every usenet result to the bottom.
List<ArrRelease> sortReleases(List<ArrRelease> releases) {
  final sorted = [...releases];
  sorted.sort((a, b) {
    if (a.rejected != b.rejected) return a.rejected ? 1 : -1;
    if (a.isTorrent && b.isTorrent) {
      final bySeeders = (b.seeders ?? 0).compareTo(a.seeders ?? 0);
      if (bySeeders != 0) return bySeeders;
    } else if (!a.isTorrent && !b.isTorrent) {
      final byAge = a.ageHours.compareTo(b.ageHours);
      if (byAge != 0) return byAge;
    }
    return b.size.compareTo(a.size);
  });
  return sorted;
}
