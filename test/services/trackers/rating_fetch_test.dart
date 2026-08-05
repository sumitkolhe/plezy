import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/services/trackers/tracker_id_resolver.dart';
import 'package:harbor/services/trackers/tracker_session.dart';
import 'package:harbor/services/trackers/trakt/trakt_tracker.dart';
import 'package:harbor/utils/external_ids.dart';

int _now() => DateTime.now().millisecondsSinceEpoch ~/ 1000;

TrackerSession _traktSession() => TrackerSession(
  accessToken: 'token',
  refreshToken: 'refresh',
  expiresAt: _now() + 86400,
  scope: 'public',
  createdAt: _now(),
);

TrackerRatingContext _ctx({
  required MediaKind kind,
  ExternalIds external = const ExternalIds(tvdb: 123, tmdb: 456, imdb: 'tt789'),
  int? season,
  int? episodeNumber,
}) {
  return TrackerRatingContext(
    ids: TrackerIds(external: external),
    kind: kind,
    season: season,
    episodeNumber: episodeNumber,
  );
}

void main() {
  tearDown(() {
    TraktTracker.instance.rebindSession(null, onSessionInvalidated: () {});
  });

  test('Trakt fetches the current episode rating by show ids and episode number', () async {
    final client = MockClient((request) async {
      expect(request.method, 'GET');
      expect(request.url.path, '/sync/ratings/episodes');
      return http.Response(
        json.encode([
          {
            'rating': 8,
            'show': {
              'ids': {'tvdb': 123},
            },
            'episode': {'season': 1, 'number': 2},
          },
        ]),
        200,
      );
    });
    TraktTracker.instance.rebindSession(_traktSession(), onSessionInvalidated: () {}, httpClient: client);

    final score = await TraktTracker.instance.getRating(_ctx(kind: MediaKind.episode, season: 1, episodeNumber: 2));

    expect(score, 8);
  });
}
