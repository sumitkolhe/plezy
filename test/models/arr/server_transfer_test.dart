import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/models/arr/server_transfer.dart';

ArrQueueItem _arr({
  String downloadId = 'ABCDEF',
  String title = 'The Bear S03E04',
  String tracked = 'downloading',
  String status = 'downloading',
  int size = 0,
  int sizeLeft = 0,
  String error = '',
  String protocol = 'torrent',
}) {
  return ArrQueueItem.fromJson({
    'downloadId': downloadId,
    'title': title,
    'trackedDownloadState': tracked,
    'status': status,
    'size': size,
    'sizeleft': sizeLeft,
    'errorMessage': error,
    'protocol': protocol,
  })!;
}

ClientTorrent _torrent({
  String hash = 'abcdef',
  String name = 'the.bear.s03e04',
  double progress = 0.43,
  int dlspeed = 1200000,
  int eta = 720,
  String state = 'downloading',
  int size = 4800000000,
}) {
  return ClientTorrent.fromJson({
    'hash': hash,
    'name': name,
    'progress': progress,
    'dlspeed': dlspeed,
    'eta': eta,
    'state': state,
    'size': size,
  })!;
}

void main() {
  group('joinTransfers', () {
    test('matches a hash across the case difference between the two services', () {
      // qBittorrent lowercases hashes; *arr does not. This is the whole join.
      final transfers = joinTransfers(
        queued: [(item: _arr(downloadId: 'ABCDEF0123'), sourceName: 'Sonarr', sourceId: 'Sonarr')],
        torrents: [_torrent(hash: 'abcdef0123')],
      );

      expect(transfers, hasLength(1), reason: 'a case-sensitive match would give two rows');
      expect(transfers.single.queued, isNotNull);
      expect(transfers.single.torrent, isNotNull);
      expect(transfers.single.sourceName, 'Sonarr');
    });

    test('keeps a usenet grab that no torrent can match', () {
      final transfers = joinTransfers(
        queued: [(item: _arr(downloadId: 'SABnzbd_nzo_1a2b', protocol: 'usenet'), sourceName: 'Radarr', sourceId: 'Radarr')],
        torrents: [_torrent(hash: 'unrelated')],
      );

      expect(transfers, hasLength(2));
      final usenet = transfers.firstWhere((t) => t.queued?.protocol == 'usenet');
      expect(usenet.torrent, isNull);
      expect(usenet.stage, TransferStage.downloading);
    });

    test('keeps a torrent no *arr claimed', () {
      final transfers = joinTransfers(queued: const [], torrents: [_torrent(name: 'something.by.hand')]);

      expect(transfers.single.queued, isNull);
      expect(transfers.single.title, 'something.by.hand');
    });

    test('one torrent claimed by two instances appears under each', () {
      // A film tracked by both the main and the 4K Radarr: two queue records,
      // one torrent. Both rows are real and must not collapse into one.
      final transfers = joinTransfers(
        queued: [
          (item: _arr(downloadId: 'AA', title: 'Dune'), sourceName: 'Radarr', sourceId: 'Radarr'),
          (item: _arr(downloadId: 'AA', title: 'Dune'), sourceName: 'Radarr 4K', sourceId: 'Radarr 4K'),
        ],
        torrents: [_torrent(hash: 'aa')],
      );

      expect(transfers, hasLength(2));
      expect(transfers.map((t) => t.sourceName), containsAll(['Radarr', 'Radarr 4K']));
      expect(transfers.every((t) => t.torrent != null), isTrue);
      // Distinct ids, or the list throws on duplicate keys.
      expect(transfers.first.id, isNot(transfers.last.id));
    });

    test('a queue record with no download id yet does not match every torrent', () {
      final transfers = joinTransfers(
        queued: [(item: _arr(downloadId: ''), sourceName: 'Sonarr', sourceId: 'Sonarr')],
        torrents: [_torrent(hash: 'abcdef')],
      );

      expect(transfers, hasLength(2));
      expect(transfers.firstWhere((t) => t.queued != null).torrent, isNull);
    });

    test('orders by stage, then title', () {
      final transfers = joinTransfers(
        queued: [
          (item: _arr(downloadId: '1', title: 'Zulu', tracked: 'imported'), sourceName: 'Radarr', sourceId: 'Radarr'),
          (item: _arr(downloadId: '2', title: 'Alpha', tracked: 'importPending'), sourceName: 'Radarr', sourceId: 'Radarr'),
          (item: _arr(downloadId: '3', title: 'Mike', status: 'queued', tracked: ''), sourceName: 'Radarr', sourceId: 'Radarr'),
          (item: _arr(downloadId: '4', title: 'Bravo', tracked: 'failed'), sourceName: 'Radarr', sourceId: 'Radarr'),
        ],
        torrents: const [],
      );

      expect(transfers.map((t) => t.title), ['Mike', 'Alpha', 'Zulu', 'Bravo']);
      expect(transfers.map((t) => t.stage), [
        TransferStage.queued,
        TransferStage.importing,
        TransferStage.done,
        TransferStage.failed,
      ]);
    });
  });

  group('stage', () {
    test('a completed transfer whose import is pending is importing, not done', () {
      final transfer = ServerTransfer(queued: _arr(status: 'completed', tracked: 'importPending'));
      expect(transfer.stage, TransferStage.importing);
    });

    test('failure wins over a completed transfer', () {
      final transfer = ServerTransfer(queued: _arr(status: 'completed', tracked: 'failed', error: 'Unpack failed'));
      expect(transfer.stage, TransferStage.failed);
      expect(transfer.errorMessage, 'Unpack failed');
    });

    test('an unclaimed torrent takes its stage from the client alone', () {
      expect(ServerTransfer(torrent: _torrent(progress: 1.0, state: 'uploading')).stage, TransferStage.done);
      expect(ServerTransfer(torrent: _torrent(state: 'pausedDL')).stage, TransferStage.queued);
      expect(ServerTransfer(torrent: _torrent(state: 'stalledDL')).isStalled, isTrue);
    });
  });

  group('progress', () {
    test('the client wins while transferring, since *arr only refreshes on poll', () {
      final transfer = ServerTransfer(
        queued: _arr(size: 1000, sizeLeft: 900), // *arr thinks 10%
        torrent: _torrent(progress: 0.43),
      );
      expect(transfer.progress, closeTo(0.43, 0.001));
    });

    test('past transferring, *arr wins — the client sits at 100% all through import', () {
      final transfer = ServerTransfer(
        queued: _arr(tracked: 'importing', size: 1000, sizeLeft: 0),
        torrent: _torrent(progress: 1.0),
      );
      expect(transfer.stage, TransferStage.importing);
      expect(transfer.progress, 1.0);
    });

    test('unknown size gives no progress rather than a false zero', () {
      expect(ServerTransfer(queued: _arr(size: 0)).progress, isNull);
    });
  });

  group('ClientTorrent', () {
    test("treats qBittorrent's 100-day sentinel as no estimate", () {
      expect(_torrent(eta: 8640000).etaSeconds, isNull);
      expect(_torrent(eta: 0).etaSeconds, isNull);
      expect(_torrent(eta: 720).etaSeconds, 720);
    });

    test('drops a row with no hash to join on', () {
      expect(ClientTorrent.fromJson({'name': 'x', 'progress': 0.5}), isNull);
      expect(ArrQueueItem.fromJson({'downloadId': 'x'}), isNull, reason: 'a titleless row cannot be shown');
    });
  });
}
