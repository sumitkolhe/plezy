import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/models/arr/managed_service.dart';
import 'package:harbor/services/arr/arr_client.dart';
import 'package:harbor/services/arr/managed_service_exceptions.dart';
import 'package:harbor/services/arr/qbittorrent_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

http.Response _json(Object body, {int status = 200}) =>
    http.Response(jsonEncode(body), status, headers: {'content-type': 'application/json'});

void main() {
  group('normalizeServiceUrl', () {
    test('adds a scheme and drops trailing slashes so one host has one form', () {
      expect(normalizeServiceUrl('  10.0.0.4:8080//  '), 'http://10.0.0.4:8080');
      expect(normalizeServiceUrl('https://sonarr.home.lan/'), 'https://sonarr.home.lan');
      expect(normalizeServiceUrl(''), '');
    });
  });

  group('ArrClient', () {
    test('sends X-Api-Key at the v3 prefix and reports the instance name', () async {
      Uri? seen;
      Map<String, String>? headers;
      final client = ArrClient(
        kind: ManagedServiceKind.sonarr,
        baseUrl: 'sonarr.home.lan/',
        apiKey: 'abc123',
        httpClient: MockClient((request) async {
          seen = request.url;
          headers = request.headers;
          return _json({'instanceName': 'Sonarr', 'version': '4.0.9'});
        }),
      );

      expect(await client.testConnection(), 'Sonarr');
      expect(seen.toString(), 'http://sonarr.home.lan/api/v3/system/status');
      expect(headers?['X-Api-Key'], 'abc123');
    });

    test('falls back to the version when an instance has no name', () async {
      final client = ArrClient(
        kind: ManagedServiceKind.radarr,
        baseUrl: 'http://radarr',
        apiKey: 'k',
        httpClient: MockClient((request) async => _json({'version': '5.4.6'})),
      );

      expect(await client.testConnection(), '5.4.6');
    });

    test('a rejected key is an auth failure, not a generic one', () async {
      final client = ArrClient(
        kind: ManagedServiceKind.radarr,
        baseUrl: 'http://radarr',
        apiKey: 'wrong',
        httpClient: MockClient((request) async => _json({'error': 'Unauthorized'}, status: 401)),
      );

      await expectLater(client.testConnection(), throwsA(isA<ManagedServiceAuthException>()));
    });

    test('an HTML body on a 200 is the wrong host, not an empty instance name', () async {
      final client = ArrClient(
        kind: ManagedServiceKind.radarr,
        baseUrl: 'http://nginx',
        apiKey: 'k',
        httpClient: MockClient((request) async => http.Response('<!doctype html><title>Welcome</title>', 200)),
      );

      await expectLater(
        client.testConnection(),
        throwsA(
          isA<ManagedServiceApiException>().having((e) => e.message, 'message', contains('did not answer with JSON')),
        ),
      );
    });
  });

  group('QbittorrentClient', () {
    test('logs in, keeps the SID, and replays it as a cookie', () async {
      final cookies = <String?>[];
      final client = QbittorrentClient(
        baseUrl: 'http://10.0.0.4:8080',
        username: 'admin',
        password: 'pw',
        httpClient: MockClient((request) async {
          if (request.url.path.endsWith('/auth/login')) {
            expect(request.body, contains('username=admin'));
            return http.Response('Ok.', 200, headers: {'set-cookie': 'SID=abcd1234; HttpOnly; path=/'});
          }
          cookies.add(request.headers['Cookie']);
          return http.Response('4.6.2', 200);
        }),
      );

      expect(await client.testConnection(), '4.6.2');
      expect(client.sid, 'abcd1234');
      expect(cookies.single, 'SID=abcd1234');
    });

    test('a bad password is a 200 with body "Fails." — still an auth failure', () async {
      final client = QbittorrentClient(
        baseUrl: 'http://10.0.0.4:8080',
        username: 'admin',
        password: 'nope',
        httpClient: MockClient((request) async => http.Response('Fails.', 200)),
      );

      await expectLater(client.testConnection(), throwsA(isA<ManagedServiceAuthException>()));
    });

    test('an expired session re-logs in once and retries the call', () async {
      var logins = 0;
      var attempts = 0;
      final client = QbittorrentClient(
        baseUrl: 'http://10.0.0.4:8080',
        username: 'admin',
        password: 'pw',
        sid: 'stale',
        httpClient: MockClient((request) async {
          if (request.url.path.endsWith('/auth/login')) {
            logins++;
            return http.Response('Ok.', 200, headers: {'set-cookie': 'SID=fresh; path=/'});
          }
          attempts++;
          if (attempts == 1) return http.Response('', 403);
          return http.Response('[]', 200);
        }),
      );

      expect(await client.getJson('/api/v2/torrents/info'), isEmpty);
      expect(logins, 1, reason: 're-login happens once, not per retry');
      expect(attempts, 2);
      expect(client.sid, 'fresh');
    });

    test('a 403 that survives re-login gives up instead of looping', () async {
      var logins = 0;
      final client = QbittorrentClient(
        baseUrl: 'http://10.0.0.4:8080',
        username: 'admin',
        password: 'pw',
        sid: 'stale',
        httpClient: MockClient((request) async {
          if (request.url.path.endsWith('/auth/login')) {
            logins++;
            return http.Response('Ok.', 200, headers: {'set-cookie': 'SID=fresh; path=/'});
          }
          return http.Response('', 403);
        }),
      );

      await expectLater(client.getJson('/api/v2/app/version'), throwsA(isA<ManagedServiceAuthException>()));
      expect(logins, 1);
    });
  });

  group('ManagedServiceConnection', () {
    test('round-trips a list through JSON', () {
      final connections = [
        const ManagedServiceConnection(kind: ManagedServiceKind.radarr, baseUrl: 'http://radarr', secret: 'a'),
        const ManagedServiceConnection(
          kind: ManagedServiceKind.radarr,
          baseUrl: 'http://radarr4k',
          secret: 'b',
          name: 'Radarr 4K',
        ),
        const ManagedServiceConnection(
          kind: ManagedServiceKind.qbittorrent,
          baseUrl: 'http://10.0.0.4:8080',
          username: 'admin',
          secret: 'pw',
          label: '4.6.2',
        ),
      ];

      final decoded = ManagedServiceConnection.decodeList(ManagedServiceConnection.encodeList(connections));
      expect(decoded, hasLength(3));
      expect(decoded[1].name, 'Radarr 4K');
      expect(decoded[2].username, 'admin');
    });

    test('two instances of one kind get distinct ids, and the same host does not', () {
      const main = ManagedServiceConnection(kind: ManagedServiceKind.radarr, baseUrl: 'http://radarr', secret: 'a');
      const uhd = ManagedServiceConnection(kind: ManagedServiceKind.radarr, baseUrl: 'http://radarr4k', secret: 'b');
      const rekeyed = ManagedServiceConnection(kind: ManagedServiceKind.radarr, baseUrl: 'http://radarr', secret: 'c');

      expect(main.id, isNot(uhd.id));
      // Re-adding a host you already have replaces it rather than polling twice.
      expect(rekeyed.id, main.id);
    });

    test('one unreadable row does not cost the others', () {
      final decoded = ManagedServiceConnection.decodeList(
        '[{"kind":"radarr","baseUrl":"http://radarr","secret":"a"},'
        '{"kind":"bazarr","baseUrl":"http://bazarr"},'
        '{"kind":"sonarr","baseUrl":"","secret":"c"},'
        '{"kind":"sonarr","baseUrl":"http://sonarr","secret":"d"}]',
      );

      expect(decoded.map((c) => c.kind), [ManagedServiceKind.radarr, ManagedServiceKind.sonarr]);
      expect(ManagedServiceConnection.decodeList('not json'), isEmpty);
    });

    test('a row is never blank: user name, else instance name, else host', () {
      const named = ManagedServiceConnection(
        kind: ManagedServiceKind.radarr,
        baseUrl: 'http://radarr.home.lan',
        secret: 'k',
        name: 'Radarr 4K',
        label: 'Radarr',
      );
      expect(named.displayName, 'Radarr 4K');
      expect(named.copyWith(name: '').displayName, 'Radarr');
      expect(
        const ManagedServiceConnection(
          kind: ManagedServiceKind.radarr,
          baseUrl: 'http://radarr.home.lan:7878',
          secret: 'k',
        ).displayName,
        'radarr.home.lan',
      );
    });
  });
}
