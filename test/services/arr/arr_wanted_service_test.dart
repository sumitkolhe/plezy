import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/models/arr/managed_service.dart';
import 'package:harbor/providers/managed_services_provider.dart';
import 'package:harbor/services/arr/arr_client.dart';
import 'package:harbor/models/arr/absent_title.dart';
import 'package:harbor/models/arr/server_transfer.dart';
import 'package:harbor/providers/server_activity_provider.dart';
import 'package:harbor/services/arr/arr_wanted_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import '../../test_helpers/arr_fixtures.dart';

void _seedRadarr(ManagedServicesProvider services, http.Client httpClient) {
  const connection = ManagedServiceConnection(
    kind: ManagedServiceKind.radarr,
    baseUrl: 'http://radarr.home.lan',
    secret: 'key',
  );
  services.debugAddServiceForTesting(
    connection,
    client: ArrClient(
      kind: ManagedServiceKind.radarr,
      baseUrl: connection.baseUrl,
      apiKey: connection.secret,
      httpClient: httpClient,
    ),
  );
}

ManagedServicesProvider _withSonarr(http.Client httpClient) {
  final services = ManagedServicesProvider();
  services.debugAddServiceForTesting(
    const ManagedServiceConnection(kind: ManagedServiceKind.sonarr, baseUrl: 'http://sonarr.home.lan', secret: 'key'),
    client: ArrClient(
      kind: ManagedServiceKind.sonarr,
      baseUrl: 'http://sonarr.home.lan',
      apiKey: 'key',
      httpClient: httpClient,
    ),
  );
  return services;
}

ManagedServicesProvider _withRadarr(http.Client httpClient) {
  final services = ManagedServicesProvider();
  _seedRadarr(services, httpClient);
  return services;
}

void main() {
  // ServerActivityProvider registers a WidgetsBinding observer.
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a Radarr restored after the row mounted still populates the list', () async {
    // The cold-start order: the widget asks before the persisted connections
    // have loaded, so the answer is "no services". Nothing used to re-ask, and
    // a kept-alive tab never runs initState twice, so the row stayed empty for
    // the whole session.
    final services = ManagedServicesProvider();
    addTearDown(services.dispose);
    final activity = ServerActivityProvider(services, service: IdleServerActivityService());
    addTearDown(activity.dispose);

    final release = activity.addWatcher();
    addTearDown(release);

    await activity.resolveAbsent(ManagedServiceKind.radarr);
    expect(activity.absent(ManagedServiceKind.radarr), isNull, reason: 'nothing to ask yet');

    _seedRadarr(
      services,
      MockClient(
        (_) async => http.Response(
          jsonEncode({
            'records': [
              {'id': 1, 'title': 'Assi', 'hasFile': false},
            ],
          }),
          200,
          headers: {'content-type': 'application/json'},
        ),
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 20));

    expect(activity.absent(ManagedServiceKind.radarr)?.map((t) => t.title), ['Assi']);
  });

  group('absentMovies', () {
    test('reports the films Radarr has no file for', () async {
      final services = _withRadarr(
        MockClient(
          (_) async => http.Response(
            jsonEncode({
              'records': [
                {'id': 2, 'title': 'B Film', 'hasFile': false},
                {'id': 1, 'title': 'A Film', 'hasFile': false},
              ],
            }),
            200,
            headers: {'content-type': 'application/json'},
          ),
        ),
      );
      addTearDown(services.dispose);

      final titles = await ArrWantedService(services).absentMovies();
      expect(titles?.map((t) => t.title), ['A Film', 'B Film']);
    });

    test('an answered instance with nothing missing is an empty list', () async {
      final services = _withRadarr(
        MockClient(
          (_) async =>
              http.Response(jsonEncode({'records': <Object>[]}), 200, headers: {'content-type': 'application/json'}),
        ),
      );
      addTearDown(services.dispose);

      expect(await ArrWantedService(services).absentMovies(), isEmpty);
    });

    test('a Radarr that never answered is null, not an empty list', () async {
      // The caller caches whatever it gets, so an empty list here would hide
      // the requested row until the app restarted — on one failed request.
      final services = _withRadarr(MockClient((_) async => http.Response('nope', 500)));
      addTearDown(services.dispose);

      expect(await ArrWantedService(services).absentMovies(), isNull);
    });
  });

  group('absentEpisodes', () {
    test('names the series, the slot and when it aired', () async {
      final services = _withSonarr(
        MockClient(
          (req) async => http.Response(
            jsonEncode({
              'records': [
                {
                  'seriesId': 9,
                  'seasonNumber': 3,
                  'episodeNumber': 5,
                  'title': 'Creation Myths',
                  'airDateUtc': '2026-07-29T21:00:00Z',
                  'hasFile': false,
                  'monitored': true,
                  'series': {
                    'title': 'Foundation',
                    'images': [
                      {'coverType': 'poster', 'remoteUrl': 'https://artworks.thetvdb.com/poster.jpg'},
                    ],
                  },
                },
              ],
            }),
            200,
            headers: {'content-type': 'application/json'},
          ),
        ),
      );
      addTearDown(services.dispose);

      final episode = (await ArrWantedService(services).absentEpisodes())!.single;
      expect(episode.seriesTitle, 'Foundation');
      expect(episode.title, 'Creation Myths');
      expect((episode.seasonNumber, episode.episodeNumber), (3, 5));
      expect(episode.airDate, isNotNull);
      expect(episode.posterUrl, 'https://artworks.thetvdb.com/poster.jpg');
      // A Sonarr queue record names the series, so this has to as well.
      expect(episode.mediaId, 9);
      expect(episode.isEpisode, isTrue);
    });

    test('drops a record with no episode slot, and one that already has a file', () async {
      final services = _withSonarr(
        MockClient(
          (_) async => http.Response(
            jsonEncode({
              'records': [
                {'seriesId': 9, 'seasonNumber': 1, 'title': 'No number'},
                {'seriesId': 9, 'seasonNumber': 1, 'episodeNumber': 2, 'title': 'Have it', 'hasFile': true},
              ],
            }),
            200,
            headers: {'content-type': 'application/json'},
          ),
        ),
      );
      addTearDown(services.dispose);

      expect(await ArrWantedService(services).absentEpisodes(), isEmpty);
    });
  });

  test('one episode of a series does not wear another episode of it downloading', () {
    // A Sonarr queue record names the series, so matching on that alone lent
    // S03E05's progress to every other absent episode of the same show.
    final services = ManagedServicesProvider();
    addTearDown(services.dispose);
    final activity = ServerActivityProvider(services, service: IdleServerActivityService());
    addTearDown(activity.dispose);

    const queued = ArrQueueItem(
      downloadId: 'hash',
      title: 'Foundation S03E05',
      stage: TransferStage.downloading,
      size: 100,
      sizeLeft: 40,
      mediaId: 9,
      seasonNumber: 3,
      episodeNumber: 5,
    );
    activity.debugSetTransfersForTesting([
      const ServerTransfer(sourceId: 'sonarr@host', sourceName: 'Sonarr', queued: queued),
    ]);

    AbsentTitle episode(int number) => AbsentTitle(
      sourceId: 'sonarr@host',
      sourceName: 'Sonarr',
      mediaId: 9,
      title: 'Episode $number',
      seasonNumber: 3,
      episodeNumber: number,
    );

    expect(activity.transferFor(episode(5)), isNotNull);
    expect(activity.transferFor(episode(6)), isNull);
  });
}
