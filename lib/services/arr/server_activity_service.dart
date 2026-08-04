import '../../models/arr/managed_service.dart';
import '../../models/arr/server_transfer.dart';
import '../../providers/managed_services_provider.dart';
import '../../utils/app_logger.dart';

/// One poll's worth of server-side activity, plus which instances failed to
/// answer it.
///
/// Failures are carried rather than thrown: with four instances configured, one
/// being down must still show the other three's work.
typedef ServerActivity = ({List<ServerTransfer> transfers, List<String> unreachable});

/// Reads the *arr queues and the download client, and folds them together.
///
/// Stateless: the provider owns cadence and the last result, so this stays
/// testable without a timer.
class ServerActivityService {
  final ManagedServicesProvider services;

  const ServerActivityService(this.services);

  Future<ServerActivity> fetch() async {
    final queued = <({ArrQueueItem item, String sourceName})>[];
    final torrents = <ClientTorrent>[];
    final unreachable = <String>[];

    for (final connection in services.connections) {
      try {
        switch (connection.kind) {
          case ManagedServiceKind.radarr:
          case ManagedServiceKind.sonarr:
            queued.addAll(await _fetchQueue(connection));
          case ManagedServiceKind.qbittorrent:
            torrents.addAll(await _fetchTorrents(connection));
        }
      } catch (e) {
        appLogger.d('${connection.kind.name}: activity poll failed', error: e);
        unreachable.add(connection.displayName);
      }
    }

    return (transfers: joinTransfers(queued: queued, torrents: torrents), unreachable: unreachable);
  }

  Future<List<({ArrQueueItem item, String sourceName})>> _fetchQueue(ManagedServiceConnection connection) async {
    final client = services.arrClient(connection.id);
    if (client == null) return const [];
    // includeUnknownItems: the client may hold grabs *arr no longer tracks, and
    // those are exactly the ones worth surfacing rather than hiding.
    final data = await client.get('/queue', query: {'pageSize': '100', 'includeUnknownMovieItems': 'true'});
    final records = data is Map<String, dynamic> ? data['records'] : data;
    if (records is! List) return const [];
    return [
      for (final record in records)
        if (record is Map<String, dynamic>)
          if (ArrQueueItem.fromJson(record) case final item?) (item: item, sourceName: connection.displayName),
    ];
  }

  Future<List<ClientTorrent>> _fetchTorrents(ManagedServiceConnection connection) async {
    final client = services.qbittorrentClient(connection.id);
    if (client == null) return const [];
    final data = await client.getJson('/api/v2/torrents/info');
    if (data is! List) return const [];
    return [
      for (final entry in data)
        if (entry is Map<String, dynamic>) ?ClientTorrent.fromJson(entry),
    ];
  }
}
