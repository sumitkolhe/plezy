/// Where a download has got to. Ordered as it progresses, so a list can sort
/// by stage without a separate rank.
enum TransferStage { queued, downloading, importing, done, failed }

/// One download as *arr sees it: what was grabbed, and how far the import got.
class ArrQueueItem {
  /// The download client's own identifier for this grab — a torrent hash or a
  /// usenet id. The join key.
  final String downloadId;

  final String title;
  final TransferStage stage;

  /// Bytes, from *arr's own accounting. Zero when it does not know yet.
  final int size;
  final int sizeLeft;

  /// *arr's message when something went wrong — an unpack failure, an import
  /// it refused. Empty otherwise.
  final String errorMessage;

  /// 'torrent' or 'usenet'. A usenet grab never matches a torrent client, so
  /// this is why an unmatched row is expected rather than a bug.
  final String protocol;

  /// `movieId` in Radarr, `seriesId` in Sonarr. The only thing a detail screen
  /// can match on — queue titles are release names.
  final int? mediaId;

  /// Season and episode when Sonarr says which, so a page can name the episode.
  final int? seasonNumber;
  final int? episodeNumber;

  const ArrQueueItem({
    required this.downloadId,
    required this.title,
    required this.stage,
    this.size = 0,
    this.sizeLeft = 0,
    this.errorMessage = '',
    this.protocol = '',
    this.mediaId,
    this.seasonNumber,
    this.episodeNumber,
  });

  /// *arr reports progress in two independent fields, and which one is
  /// authoritative depends on the stage — see [ServerTransfer.progress].
  double? get progress => size <= 0 ? null : ((size - sizeLeft) / size).clamp(0.0, 1.0);

  static ArrQueueItem? fromJson(Map<String, dynamic> json) {
    final title = (json['title'] as String?)?.trim() ?? '';
    if (title.isEmpty) return null;
    final episode = json['episode'] is Map<String, dynamic> ? json['episode'] as Map<String, dynamic> : null;
    return ArrQueueItem(
      downloadId: (json['downloadId'] as String?)?.trim() ?? '',
      title: title,
      stage: _stageFrom(json),
      size: ((json['size'] as num?) ?? 0).toInt(),
      sizeLeft: ((json['sizeleft'] as num?) ?? 0).toInt(),
      errorMessage: (json['errorMessage'] as String?)?.trim() ?? '',
      protocol: (json['protocol'] as String?)?.trim() ?? '',
      mediaId: ((json['movieId'] ?? json['seriesId']) as num?)?.toInt(),
      seasonNumber: ((json['seasonNumber'] ?? episode?['seasonNumber']) as num?)?.toInt(),
      episodeNumber: (episode?['episodeNumber'] as num?)?.toInt(),
    );
  }

  /// `trackedDownloadState` describes the import pipeline and `status` the
  /// transfer, so both are consulted: a record can be `status: completed`
  /// while its import is still pending, which is "importing", not "done".
  static TransferStage _stageFrom(Map<String, dynamic> json) {
    final tracked = (json['trackedDownloadState'] as String?) ?? '';
    final status = (json['status'] as String?) ?? '';
    if (tracked == 'failed' || tracked == 'failedPending' || status == 'failed') return TransferStage.failed;
    if (tracked == 'imported') return TransferStage.done;
    if (tracked == 'importPending' || tracked == 'importBlocked' || tracked == 'importing') {
      return TransferStage.importing;
    }
    if (status == 'queued' || status == 'delay' || status == 'paused') return TransferStage.queued;
    return TransferStage.downloading;
  }
}

/// One torrent as the download client sees it: the only place a live
/// percentage, speed and stall reason exist.
class ClientTorrent {
  final String hash;
  final String name;

  /// 0..1.
  final double progress;

  /// Bytes per second; zero when stalled or paused.
  final int downloadSpeed;

  /// Seconds remaining, or null when the client cannot say (it reports
  /// 8640000 — 100 days — as "unknown", which would render as a bogus ETA).
  final int? etaSeconds;

  /// qBittorrent's own state string, kept verbatim: it distinguishes stalled
  /// from paused from checking, which no *arr field does.
  final String state;

  final int size;

  const ClientTorrent({
    required this.hash,
    required this.name,
    required this.progress,
    this.downloadSpeed = 0,
    this.etaSeconds,
    this.state = '',
    this.size = 0,
  });

  static const int _unknownEta = 8640000;

  bool get isStalled => state.startsWith('stalled');
  bool get isPaused => state.startsWith('paused') || state == 'stoppedDL' || state == 'stoppedUP';
  bool get isComplete => progress >= 1.0;

  static ClientTorrent? fromJson(Map<String, dynamic> json) {
    final hash = (json['hash'] as String?)?.trim() ?? '';
    if (hash.isEmpty) return null;
    final eta = (json['eta'] as num?)?.toInt();
    return ClientTorrent(
      hash: hash,
      name: (json['name'] as String?)?.trim() ?? '',
      progress: ((json['progress'] as num?) ?? 0).toDouble().clamp(0.0, 1.0),
      downloadSpeed: ((json['dlspeed'] as num?) ?? 0).toInt(),
      etaSeconds: eta == null || eta <= 0 || eta >= _unknownEta ? null : eta,
      state: (json['state'] as String?)?.trim() ?? '',
      size: ((json['size'] as num?) ?? 0).toInt(),
    );
  }
}

/// One download, as both layers describe it.
///
/// Either side may be absent: a usenet grab has no torrent, and a torrent
/// someone added by hand has no *arr record.
class ServerTransfer {
  final ArrQueueItem? queued;
  final ClientTorrent? torrent;

  /// Which instance reported the *arr side, for the "via" line.
  final String sourceName;

  /// Its connection id: one Radarr's movie 41 is not another's.
  final String sourceId;

  const ServerTransfer({this.queued, this.torrent, this.sourceName = '', this.sourceId = ''});

  String get title => queued?.title ?? torrent?.name ?? '';

  /// The client's percentage wins while transferring — it is live, where *arr's
  /// `sizeleft` only refreshes when it polls the client. Past that point the
  /// client sits at 100% through the whole import, so *arr's stage takes over.
  double? get progress {
    if (stage == TransferStage.downloading && torrent != null) return torrent!.progress;
    return queued?.progress ?? torrent?.progress;
  }

  TransferStage get stage {
    final fromArr = queued?.stage;
    if (fromArr != null) return fromArr;
    final torrent = this.torrent;
    if (torrent == null) return TransferStage.queued;
    if (torrent.isComplete) return TransferStage.done;
    return torrent.isPaused ? TransferStage.queued : TransferStage.downloading;
  }

  /// Only the client knows a torrent has no seeds; *arr just reports
  /// "downloading" forever.
  bool get isStalled => torrent?.isStalled ?? false;

  int? get etaSeconds => torrent?.etaSeconds;

  int get size {
    final arrSize = queued?.size ?? 0;
    return arrSize > 0 ? arrSize : (torrent?.size ?? 0);
  }

  int get bytesDone {
    final arr = queued;
    if (arr != null && arr.size > 0) return arr.size - arr.sizeLeft;
    final torrent = this.torrent;
    if (torrent == null) return 0;
    return (torrent.size * torrent.progress).round();
  }

  String get errorMessage => queued?.errorMessage ?? '';

  /// Stable across polls so a list can keep its scroll position, and unique:
  /// two instances tracking one release are two rows, and duplicate list keys
  /// throw.
  String get id {
    final key = queued?.downloadId ?? '';
    final own = key.isNotEmpty ? key.toLowerCase() : (torrent?.hash.toLowerCase() ?? title);
    return sourceName.isEmpty ? own : '$sourceName/$own';
  }
}

/// Fold *arr queue records and client torrents into one row per download.
///
/// Matched on the download id, which is the torrent hash — case-insensitively,
/// because qBittorrent lowercases hashes and *arr does not. A case-sensitive
/// match splits every torrent into two unrelated rows.
List<ServerTransfer> joinTransfers({
  required List<({ArrQueueItem item, String sourceName, String sourceId})> queued,
  required List<ClientTorrent> torrents,
}) {
  final byHash = {for (final torrent in torrents) torrent.hash.toLowerCase(): torrent};
  final claimed = <String>{};

  final transfers = <ServerTransfer>[];
  for (final entry in queued) {
    final key = entry.item.downloadId.toLowerCase();
    final torrent = key.isEmpty ? null : byHash[key];
    if (torrent != null) claimed.add(key);
    transfers.add(
      ServerTransfer(queued: entry.item, torrent: torrent, sourceName: entry.sourceName, sourceId: entry.sourceId),
    );
  }

  // Torrents no *arr claimed: added by hand, or grabbed by something Harbor is
  // not connected to. Still arriving, so still worth showing.
  for (final torrent in torrents) {
    if (claimed.contains(torrent.hash.toLowerCase())) continue;
    transfers.add(ServerTransfer(torrent: torrent));
  }

  transfers.sort((a, b) {
    final byStage = a.stage.index.compareTo(b.stage.index);
    return byStage != 0 ? byStage : a.title.toLowerCase().compareTo(b.title.toLowerCase());
  });
  return transfers;
}
