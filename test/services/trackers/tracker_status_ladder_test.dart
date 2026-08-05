import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:harbor/models/trakt/trakt_ids.dart';
import 'package:harbor/models/trakt/trakt_scrobble_request.dart';
import 'package:harbor/services/trackers/tracker_exceptions.dart';
import 'package:harbor/services/trackers/tracker_session.dart';
import 'package:harbor/services/trackers/trakt/trakt_client.dart';

TrackerSession _session({String refreshToken = 'refresh-old'}) {
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  return TrackerSession(
    accessToken: 'access-old',
    refreshToken: refreshToken,
    expiresAt: now + 86400,
    createdAt: now,
    username: 'alice',
  );
}

const _scrobble = TraktScrobbleRequest.movie(ids: TraktIds(trakt: 1));

void main() {
  group('Trakt status ladder', () {
    test('accepts 409 on scrobble but not on other requests', () async {
      final client = TraktClient(
        _session(),
        onSessionInvalidated: () => fail('409 should not invalidate the session'),
        httpClient: MockClient((_) async => http.Response('conflict', 409)),
      );
      addTearDown(client.dispose);

      await client.scrobbleStart(_scrobble);

      await expectLater(
        client.getUserSettings(),
        throwsA(isA<TrackerApiException>().having((e) => e.statusCode, 'statusCode', 409)),
      );
    });

    test('propagates the refresh TrackerAuthException after a 401', () async {
      var invalidated = 0;
      final client = TraktClient(
        _session(refreshToken: 'refresh-ladder'),
        onSessionInvalidated: () => invalidated++,
        httpClient: MockClient((request) async {
          if (request.url.path == '/oauth/token') {
            return http.Response(json.encode({'error': 'invalid_grant'}), 400);
          }
          return http.Response('unauthorized', 401);
        }),
      );
      addTearDown(client.dispose);

      await expectLater(
        client.getUserSettings(),
        throwsA(isA<TrackerAuthException>().having((e) => e.isPermanent, 'isPermanent', isTrue)),
      );
      expect(invalidated, 1);
    });
  });
}
