import 'package:drift/native.dart';
import 'package:harbor/media/ids.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/database/app_database.dart';
import 'package:harbor/media/media_backend.dart';

import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_server_client.dart';
import 'package:harbor/models/transcode_quality_preset.dart';
import 'package:harbor/services/multi_server_manager.dart';
import 'package:harbor/services/playback_context.dart';
import 'package:harbor/services/playback_initialization_types.dart';
import 'package:harbor/services/playback_source_resolver.dart';
import '../test_helpers/media_items.dart';

class _PlaybackClient implements MediaServerClient {
  _PlaybackClient({this.clientBackend = MediaBackend.jellyfin, PlaybackInitializationResult? result})
    : result =
          result ??
          PlaybackInitializationResult(availableVersions: const [], videoUrl: 'https://example.com/video.mp4');

  final MediaBackend clientBackend;
  final PlaybackInitializationResult result;

  @override
  ServerId get serverId => ServerId('srv');

  @override
  MediaBackend get backend => clientBackend;

  @override
  double get watchedThreshold => 0.9;

  @override
  Map<String, String> get streamHeaders => const {'X-Test': 'token'};

  @override
  void close() {}

  @override
  Future<PlaybackInitializationResult> getPlaybackInitialization(PlaybackInitializationOptions options) async => result;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  test('online playback uses registered client even when status is stale offline', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final manager = MultiServerManager();
    addTearDown(() async {
      manager.dispose();
      await db.close();
    });

    final client = _PlaybackClient();
    manager.debugRegisterClientForTesting(client, online: false);

    final context = await PlaybackSourceResolver(serverManager: manager, database: db).resolve(
      PlaybackInitializationOptions(
        metadata: testMediaItem(id: 'item-1', backend: MediaBackend.jellyfin, kind: MediaKind.movie, serverId: 'srv'),
        selectedMediaIndex: 0,
        qualityPreset: TranscodeQualityPreset.original,
      ),
      offlineLibraryMode: false,
    );

    expect(context.result.videoUrl, 'https://example.com/video.mp4');
    expect(context.reportingClient, same(client));
    expect(context.reportingMode, PlaybackReportingMode.online);
  });

  test('non-plex direct playback does not add plex session header', () async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final manager = MultiServerManager();
    addTearDown(() async {
      manager.dispose();
      await db.close();
    });

    final client = _PlaybackClient(clientBackend: MediaBackend.jellyfin);
    manager.debugRegisterClientForTesting(client, online: true);

    final context = await PlaybackSourceResolver(serverManager: manager, database: db).resolve(
      PlaybackInitializationOptions(
        metadata: testMediaItem(id: 'item-1', backend: MediaBackend.jellyfin, kind: MediaKind.movie, serverId: 'srv'),
        selectedMediaIndex: 0,
        qualityPreset: TranscodeQualityPreset.original,
        sessionIdentifier: 'playback-session-id',
      ),
      offlineLibraryMode: false,
    );

    expect(context.sourceKind, PlaybackSourceKind.remoteDirect);
    expect(context.streamHeaders, isNot(contains('X-Plex-Session-Identifier')));
  });
}
