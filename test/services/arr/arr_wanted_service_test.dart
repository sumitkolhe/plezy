import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/models/arr/managed_service.dart';
import 'package:harbor/providers/managed_services_provider.dart';
import 'package:harbor/services/arr/arr_client.dart';
import 'package:harbor/services/arr/arr_wanted_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

ManagedServicesProvider _withRadarr(http.Client httpClient) {
  const connection = ManagedServiceConnection(
    kind: ManagedServiceKind.radarr,
    baseUrl: 'http://radarr.home.lan',
    secret: 'key',
  );
  return ManagedServicesProvider()..debugAddServiceForTesting(
    connection,
    client: ArrClient(
      kind: ManagedServiceKind.radarr,
      baseUrl: connection.baseUrl,
      apiKey: connection.secret,
      httpClient: httpClient,
    ),
  );
}

void main() {
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
}
