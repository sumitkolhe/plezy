import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:plezy/media/ids.dart';

import 'package:drift/native.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:plezy/connection/connection.dart';
import 'package:plezy/connection/connection_registry.dart';
import 'package:plezy/database/app_database.dart';
import 'package:plezy/services/jellyfin_client.dart';
import 'package:plezy/services/multi_server_manager.dart';

import '../test_helpers/backend_client_fixtures.dart';
import '../test_helpers/prefs.dart';

JellyfinConnection _jellyfinConnection(String userId) => testJellyfinConnection(
  machineId: 'jf-machine',
  userId: userId,
  serverName: 'Shared JF',
  userName: userId,
  accessToken: 'token-$userId',
  deviceId: 'device',
  createdAt: DateTime.fromMillisecondsSinceEpoch(0),
);

JellyfinClient _jellyfinClient(String userId) => testJellyfinClient(connection: _jellyfinConnection(userId));

class _LoopbackJellyfinServer {
  _LoopbackJellyfinServer._(this._server, this.machineId, this.baseUrl, this.requests, this.publicInfoAvailable);

  final HttpServer _server;
  final String machineId;
  final String baseUrl;
  final List<({String path, bool authenticated})> requests;
  bool _closed = false;
  bool publicInfoAvailable;

  static Future<_LoopbackJellyfinServer> start({
    required String machineId,
    Duration responseDelay = Duration.zero,
    void Function(String event)? onRequest,
    bool isAdministrator = false,
    bool publicInfoAvailable = true,
  }) async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final requests = <({String path, bool authenticated})>[];
    final result = _LoopbackJellyfinServer._(
      server,
      machineId,
      'http://127.0.0.1:${server.port}',
      requests,
      publicInfoAvailable,
    );
    server.listen((request) async {
      final authenticated =
          request.headers.value(HttpHeaders.authorizationHeader) != null ||
          request.headers.value('X-Emby-Token') != null ||
          request.uri.queryParameters.keys.any((key) => key.toLowerCase() == 'api_key');
      requests.add((path: request.uri.path, authenticated: authenticated));
      onRequest?.call(request.uri.path);
      if (responseDelay > Duration.zero) {
        await Future<void>.delayed(responseDelay);
      }
      request.response.headers.contentType = ContentType.json;
      if (request.uri.path.endsWith('/System/Info/Public')) {
        if (result.publicInfoAvailable) {
          request.response.write(jsonEncode({'Id': machineId, 'ServerName': 'Loopback', 'Version': '10.9.0'}));
        } else {
          request.response.statusCode = HttpStatus.serviceUnavailable;
          request.response.write('{}');
        }
      } else if (request.uri.path.endsWith('/Users/Me')) {
        request.response.write(
          jsonEncode({
            'Policy': {'IsAdministrator': isAdministrator},
          }),
        );
      } else {
        request.response.write('{}');
      }
      await request.response.close();
    });
    return result;
  }

  Future<void> close() async {
    if (_closed) return;
    _closed = true;
    await _server.close(force: true);
  }
}

// Coverage includes status and lifecycle changes, endpoint exhaustion,
// in-place and fresh scoped Plex profile binding, endpoint persistence and
// promotion ownership, connectivity monitoring/debounce teardown, Jellyfin
// reuse/update, and selected registered-client health outcomes.

void main() {
  setUp(resetSharedPreferencesForTest);

  // ============================================================
  // Initial state
  // ============================================================

  group('initial state', () {
    test('a freshly constructed manager has no servers, clients, or status', () {
      final m = MultiServerManager();
      addTearDown(m.dispose);

      expect(m.serverIds, isEmpty);
      expect(m.onlineServerIds, isEmpty);
      expect(m.offlineServerIds, isEmpty);
      expect(m.onlineClients, isEmpty);
    });

    test('getClient returns null for unknown ids', () {
      final m = MultiServerManager();
      addTearDown(m.dispose);

      expect(m.getClient(ServerId('nope')), isNull);
      expect(m.isServerOnline(ServerId('nope')), isFalse);
    });
  });

  // ============================================================
  // updateServerStatus + status stream
  // ============================================================

  group('updateServerStatus + statusStream', () {
    test('emits a snapshot when status flips for a tracked server', () async {
      final m = MultiServerManager();
      addTearDown(m.dispose);

      final emitted = <Map<String, bool>>[];
      final sub = m.statusStream.listen(emitted.add);
      addTearDown(sub.cancel);

      // Pre-seed status (mirrors what addServer would do post-connect).
      m.updateServerStatus(ServerId('srv-1'), true);
      m.updateServerStatus(ServerId('srv-2'), false);
      m.updateServerStatus(ServerId('srv-1'), false); // change

      // Let the broadcast stream events drain.
      await Future<void>.delayed(Duration.zero);

      expect(emitted, hasLength(3));
      expect(emitted[0], {'srv-1': true});
      expect(emitted[1], {'srv-1': true, 'srv-2': false});
      expect(emitted[2], {'srv-1': false, 'srv-2': false});
    });

    test('repeated identical status is debounced (no extra emission)', () async {
      final m = MultiServerManager();
      addTearDown(m.dispose);

      final emitted = <Map<String, bool>>[];
      final sub = m.statusStream.listen(emitted.add);
      addTearDown(sub.cancel);

      m.updateServerStatus(ServerId('srv-1'), true);
      m.updateServerStatus(ServerId('srv-1'), true); // same value: no-op
      m.updateServerStatus(ServerId('srv-1'), true);

      await Future<void>.delayed(Duration.zero);
      expect(emitted, hasLength(1));
      expect(emitted.first, {'srv-1': true});
    });

    test('online/offline server-id getters reflect updateServerStatus', () {
      final m = MultiServerManager();
      addTearDown(m.dispose);

      m.updateServerStatus(ServerId('a'), true);
      m.updateServerStatus(ServerId('b'), false);
      m.updateServerStatus(ServerId('c'), true);

      expect(m.onlineServerIds.toSet(), {'a', 'c'});
      expect(m.offlineServerIds.toSet(), {'b'});
      expect(m.isServerOnline(ServerId('a')), isTrue);
      expect(m.isServerOnline(ServerId('b')), isFalse);
    });
  });

  group('endpoint exhaustion verification', () {
    test('content-route exhaustion keeps an authenticated Jellyfin server online', () async {
      final manager = MultiServerManager();
      addTearDown(manager.dispose);
      final client = testJellyfinClient(
        connection: _jellyfinConnection('user-a'),
        handler: (_) async =>
            http.Response('{"Policy":{"IsAdministrator":false}}', 200, headers: {'content-type': 'application/json'}),
      );
      manager.debugRegisterJellyfinClientForTesting(client);

      final emitted = <Map<String, bool>>[];
      final sub = manager.statusStream.listen(emitted.add);
      addTearDown(sub.cancel);

      await manager.debugVerifyServerEndpointsExhaustedForTesting(ServerId('jf-machine'));
      await Future<void>.delayed(Duration.zero);

      expect(manager.isServerOnline(ServerId('jf-machine')), isTrue);
      expect(manager.authErrorServerIds, isEmpty);
      expect(emitted, isEmpty, reason: 'a successful health probe must not publish a false offline transition');
    });

    test('auth rejection is published without attempting generic reconnection', () async {
      final manager = MultiServerManager();
      addTearDown(manager.dispose);
      final client = testJellyfinClient(
        connection: _jellyfinConnection('user-a'),
        handler: (_) async => http.Response('', 401),
      );
      manager.debugRegisterJellyfinClientForTesting(client);

      final emitted = <Map<String, bool>>[];
      final sub = manager.statusStream.listen(emitted.add);
      addTearDown(sub.cancel);

      await manager.debugVerifyServerEndpointsExhaustedForTesting(ServerId('jf-machine'));
      await Future<void>.delayed(Duration.zero);

      expect(manager.isServerOnline(ServerId('jf-machine')), isFalse);
      expect(manager.authErrorServerIds, {'jf-machine'});
      expect(emitted, [
        {'jf-machine': false},
      ]);
    });

    test('confirmed-offline probe publishes offline once and schedules reconnection', () async {
      final manager = MultiServerManager();
      addTearDown(manager.dispose);
      var probes = 0;
      final client = testJellyfinClient(
        connection: _jellyfinConnection('user-a'),
        handler: (req) async {
          if (req.url.path == '/Users/Me') probes++;
          return http.Response('', 500);
        },
      );
      manager.debugRegisterJellyfinClientForTesting(client);

      final emitted = <Map<String, bool>>[];
      final sub = manager.statusStream.listen(emitted.add);
      addTearDown(sub.cancel);

      await manager.debugVerifyServerEndpointsExhaustedForTesting(ServerId('jf-machine'));
      // The scheduled reconnection runs unawaited — let it finish.
      await pumpEventQueue();

      expect(manager.isServerOnline(ServerId('jf-machine')), isFalse);
      expect(probes, 2, reason: 'confirmed exhaustion schedules the backend reconnection probe');
      expect(emitted, [
        {'jf-machine': false},
      ], reason: 'the reconnection probe repeating the offline verdict must not re-publish it');
    });

    test('probe-raised exhaustion re-arms the retry loop and recovers when the server returns', () {
      fakeAsync((async) {
        final manager = MultiServerManager();
        var healthy = false;
        final client = testJellyfinClient(
          connection: _jellyfinConnection('user-a'),
          handler: (_) async => healthy
              ? http.Response(
                  '{"Policy":{"IsAdministrator":false}}',
                  200,
                  headers: {'content-type': 'application/json'},
                )
              : http.Response('', 500),
          // Production wiring: the probe's own failed GET re-raises exhaustion.
          onAllEndpointsExhausted: () => manager.debugTriggerEndpointsExhaustedForTesting(ServerId('jf-machine')),
        );
        manager.debugRegisterJellyfinClientForTesting(client);

        final emitted = <Map<String, bool>>[];
        final sub = manager.statusStream.listen(emitted.add);

        // A failed content GET raises exhaustion → debounce → probe confirms
        // offline. Exhaustion raised DURING the verification is swallowed by
        // the in-flight guard; the reconnection probe's failure fires after
        // the guard clears and re-arms the debounce.
        manager.debugTriggerEndpointsExhaustedForTesting(ServerId('jf-machine'));
        async.elapse(const Duration(seconds: 5));
        async.flushMicrotasks();
        expect(manager.isServerOnline(ServerId('jf-machine')), isFalse);

        // Server recovers: the self-re-armed loop flips it back online with
        // no external trigger — offline retry must survive the guard.
        healthy = true;
        async.elapse(const Duration(seconds: 6));
        async.flushMicrotasks();
        expect(manager.isServerOnline(ServerId('jf-machine')), isTrue);
        expect(emitted, [
          {'jf-machine': false},
          {'jf-machine': true},
        ]);

        sub.cancel();
        manager.dispose();
      });
    });
  });

  group('Jellyfin connection updates', () {
    test('persists refreshed admin status discovered during health checks', () async {
      final persisted = <JellyfinConnection>[];
      final persistStarted = Completer<void>();
      final allowPersist = Completer<void>();
      final client = JellyfinClient.forTesting(
        connection: _jellyfinConnection('user-a'),
        httpClient: MockClient((request) async {
          expect(request.url.path, '/Users/Me');
          return http.Response(
            '{"Policy":{"IsAdministrator":true}}',
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      );
      addTearDown(client.close);
      final m = MultiServerManager()
        ..onJellyfinConnectionUpdated = (connection) async {
          persistStarted.complete();
          await allowPersist.future;
          persisted.add(connection);
        };
      addTearDown(m.dispose);
      m.debugRegisterJellyfinClientForTesting(client);

      final healthFuture = m.checkServerHealth();
      await persistStarted.future;
      expect(persisted, isEmpty);
      allowPersist.complete();
      await healthFuture;

      expect(persisted, hasLength(1));
      expect(persisted.single.isAdministrator, isTrue);
    });

    test('health remains online when persisting refreshed admin status fails', () async {
      final client = JellyfinClient.forTesting(
        connection: _jellyfinConnection('user-a'),
        httpClient: MockClient(
          (_) async =>
              http.Response('{"Policy":{"IsAdministrator":true}}', 200, headers: {'content-type': 'application/json'}),
        ),
      );
      addTearDown(client.close);
      final m = MultiServerManager()
        ..onJellyfinConnectionUpdated = (_) async {
          throw Exception('disk full');
        };
      addTearDown(m.dispose);
      m.debugRegisterJellyfinClientForTesting(client);

      await m.checkServerHealth();

      expect(m.isServerOnline(ServerId('jf-machine')), isTrue);
      expect(m.isOwnerOrAdmin(ServerId('jf-machine')), isTrue);
    });

    test('ignores stale admin-status persistence from a replaced Jellyfin client', () async {
      final persisted = <JellyfinConnection>[];
      final requestStarted = Completer<void>();
      final allowResponse = Completer<void>();
      final oldClient = JellyfinClient.forTesting(
        connection: _jellyfinConnection('user-a'),
        httpClient: MockClient((_) async {
          requestStarted.complete();
          await allowResponse.future;
          return http.Response(
            '{"Policy":{"IsAdministrator":true}}',
            200,
            headers: {'content-type': 'application/json'},
          );
        }),
      );
      final newClient = JellyfinClient.forTesting(
        connection: _jellyfinConnection('user-a').copyWith(accessToken: 'new-token'),
        httpClient: MockClient((_) async => http.Response('{}', 200)),
      );
      addTearDown(oldClient.close);
      final m = MultiServerManager()..onJellyfinConnectionUpdated = persisted.add;
      addTearDown(m.dispose);

      m.debugRegisterJellyfinClientForTesting(oldClient);
      final healthFuture = m.checkServerHealth();
      await requestStarted.future;
      m.debugRegisterJellyfinClientForTesting(newClient);
      allowResponse.complete();
      await healthFuture;

      expect(persisted, isEmpty);
      expect(m.getJellyfinClientByCompoundId('jf-machine/user-a'), same(newClient));
    });

    test('ignores stale health status when active Jellyfin user changes mid-check', () async {
      final requestStarted = Completer<void>();
      final allowResponse = Completer<void>();
      final userA = JellyfinClient.forTesting(
        connection: _jellyfinConnection('user-a'),
        httpClient: MockClient((_) async {
          requestStarted.complete();
          await allowResponse.future;
          return http.Response('', 403);
        }),
      );
      final userB = _jellyfinClient('user-b');
      final m = MultiServerManager();
      addTearDown(m.dispose);

      m.debugRegisterJellyfinClientForTesting(userA);
      final healthFuture = m.checkServerHealth();
      await requestStarted.future;
      m.debugRegisterJellyfinClientForTesting(userB, online: true);
      allowResponse.complete();
      await healthFuture;

      expect(m.getClient(ServerId('jf-machine')), same(userB));
      expect(m.isServerOnline(ServerId('jf-machine')), isTrue);
      expect(m.authErrorServerIds, isNot(contains('jf-machine')));
    });
  });

  group('addJellyfinConnection endpoint trust admission', () {
    test('historic wrong-machine alternate is removed before authenticated health', () async {
      final previousHttpOverrides = HttpOverrides.current;
      HttpOverrides.global = null;
      addTearDown(() => HttpOverrides.global = previousHttpOverrides);
      final events = <String>[];
      final active = await _LoopbackJellyfinServer.start(
        machineId: 'jf-machine',
        onRequest: (path) => events.add('active:$path'),
      );
      final wrong = await _LoopbackJellyfinServer.start(
        machineId: 'different-machine',
        onRequest: (path) => events.add('wrong:$path'),
      );
      addTearDown(active.close);
      addTearDown(wrong.close);

      final db = AppDatabase.forTesting(NativeDatabase.memory());
      final registry = ConnectionRegistry(db);
      addTearDown(db.close);
      final historic = _jellyfinConnection(
        'user-a',
      ).copyWith(baseUrl: active.baseUrl, baseUrls: [active.baseUrl, wrong.baseUrl]);
      await registry.upsert(historic);

      final manager = MultiServerManager()
        ..onJellyfinConnectionUpdated = (connection) async {
          await registry.upsert(connection);
          events.add('persist');
        };
      addTearDown(manager.dispose);

      expect(await manager.addJellyfinConnection(historic), isTrue);

      final live = manager.getJellyfinClientByCompoundId(historic.id)!;
      final stored = await registry.get(historic.id) as JellyfinConnection;
      expect(live.connection.baseUrls, [active.baseUrl]);
      expect(stored.baseUrls, [active.baseUrl]);
      expect(events.indexOf('persist'), greaterThanOrEqualTo(0));
      expect(events.indexOf('persist'), lessThan(events.indexOf('active:/Users/Me')));
      expect(wrong.requests, isNotEmpty);
      expect(wrong.requests, everyElement((path: '/System/Info/Public', authenticated: false)));
    });

    test('partial success retains an unavailable historic alternate and re-admits it on failover', () async {
      final previousHttpOverrides = HttpOverrides.current;
      HttpOverrides.global = null;
      addTearDown(() => HttpOverrides.global = previousHttpOverrides);
      final active = await _LoopbackJellyfinServer.start(machineId: 'jf-machine');
      final fallback = await _LoopbackJellyfinServer.start(machineId: 'jf-machine', publicInfoAvailable: false);
      final wrong = await _LoopbackJellyfinServer.start(machineId: 'different-machine');
      addTearDown(active.close);
      addTearDown(fallback.close);
      addTearDown(wrong.close);

      final db = AppDatabase.forTesting(NativeDatabase.memory());
      final registry = ConnectionRegistry(db);
      addTearDown(db.close);
      final historic = _jellyfinConnection(
        'user-a',
      ).copyWith(baseUrl: active.baseUrl, baseUrls: [active.baseUrl, fallback.baseUrl, wrong.baseUrl]);
      await registry.upsert(historic);

      final manager = MultiServerManager()..onJellyfinConnectionUpdated = registry.upsert;
      addTearDown(manager.dispose);

      expect(await manager.addJellyfinConnection(historic), isTrue);

      final live = manager.getJellyfinClientByCompoundId(historic.id)!;
      var stored = await registry.get(historic.id) as JellyfinConnection;
      expect(live.connection.baseUrls, [active.baseUrl, fallback.baseUrl]);
      expect(stored.baseUrls, [active.baseUrl, fallback.baseUrl]);
      expect(wrong.requests, isNotEmpty);
      expect(wrong.requests, everyElement((path: '/System/Info/Public', authenticated: false)));

      final fallbackRequestsBeforeFailover = fallback.requests.length;
      fallback.publicInfoAvailable = true;
      await active.close();

      expect(await live.getMachineIdentifier(), 'jf-machine');

      expect(fallback.requests.skip(fallbackRequestsBeforeFailover), [
        (path: '/System/Info/Public', authenticated: false),
        (path: '/System/Info/Public', authenticated: true),
      ]);
      expect(live.connection.baseUrl, fallback.baseUrl);
      stored = await registry.get(historic.id) as JellyfinConnection;
      expect(stored.baseUrl, fallback.baseUrl);
      expect(stored.baseUrls, [fallback.baseUrl, active.baseUrl]);
    });

    test('unvalidated endpoint race preserves full persisted fallback set during admin refresh', () async {
      final previousHttpOverrides = HttpOverrides.current;
      HttpOverrides.global = null;
      addTearDown(() => HttpOverrides.global = previousHttpOverrides);
      final active = await _LoopbackJellyfinServer.start(machineId: 'different-machine', isAdministrator: true);
      final fallback = await _LoopbackJellyfinServer.start(machineId: 'different-machine');
      addTearDown(active.close);
      addTearDown(fallback.close);

      final historic = _jellyfinConnection(
        'user-a',
      ).copyWith(baseUrl: active.baseUrl, baseUrls: [active.baseUrl, fallback.baseUrl]);
      final updates = <JellyfinConnection>[];
      final manager = MultiServerManager()..onJellyfinConnectionUpdated = updates.add;
      addTearDown(manager.dispose);

      expect(await manager.addJellyfinConnection(historic), isTrue);

      final live = manager.getJellyfinClientByCompoundId(historic.id)!;
      expect(live.connection.baseUrls, [active.baseUrl]);
      expect(live.connection.isAdministrator, isTrue);
      expect(updates, hasLength(1));
      expect(updates.single.isAdministrator, isTrue);
      expect(updates.single.baseUrls, [active.baseUrl, fallback.baseUrl]);
    });

    test('same-machine pair remains eligible for validated authenticated failover', () async {
      final previousHttpOverrides = HttpOverrides.current;
      HttpOverrides.global = null;
      addTearDown(() => HttpOverrides.global = previousHttpOverrides);
      final active = await _LoopbackJellyfinServer.start(machineId: 'jf-machine');
      final fallback = await _LoopbackJellyfinServer.start(
        machineId: 'jf-machine',
        responseDelay: const Duration(milliseconds: 20),
      );
      addTearDown(active.close);
      addTearDown(fallback.close);

      final db = AppDatabase.forTesting(NativeDatabase.memory());
      final registry = ConnectionRegistry(db);
      addTearDown(db.close);
      final historic = _jellyfinConnection(
        'user-a',
      ).copyWith(baseUrl: active.baseUrl, baseUrls: [active.baseUrl, fallback.baseUrl]);
      await registry.upsert(historic);

      final manager = MultiServerManager()..onJellyfinConnectionUpdated = registry.upsert;
      addTearDown(manager.dispose);

      expect(await manager.addJellyfinConnection(historic), isTrue);
      final live = manager.getJellyfinClientByCompoundId(historic.id)!;
      expect(live.connection.baseUrls, [active.baseUrl, fallback.baseUrl]);

      final fallbackRequestsBeforeFailover = fallback.requests.length;
      await active.close();

      expect(await live.getMachineIdentifier(), 'jf-machine');

      final failoverRequests = fallback.requests.skip(fallbackRequestsBeforeFailover).toList();
      expect(failoverRequests, [
        (path: '/System/Info/Public', authenticated: false),
        (path: '/System/Info/Public', authenticated: true),
      ]);
      expect(live.connection.baseUrl, fallback.baseUrl);
      final stored = await registry.get(historic.id) as JellyfinConnection;
      expect(stored.baseUrl, fallback.baseUrl);
      expect(stored.baseUrls, [fallback.baseUrl, active.baseUrl]);
    });

    test('persistence failure never restores rejected alternates in memory', () async {
      final previousHttpOverrides = HttpOverrides.current;
      HttpOverrides.global = null;
      addTearDown(() => HttpOverrides.global = previousHttpOverrides);
      final active = await _LoopbackJellyfinServer.start(machineId: 'jf-machine');
      final wrong = await _LoopbackJellyfinServer.start(machineId: 'different-machine');
      addTearDown(active.close);
      addTearDown(wrong.close);

      final historic = _jellyfinConnection(
        'user-a',
      ).copyWith(baseUrl: active.baseUrl, baseUrls: [active.baseUrl, wrong.baseUrl]);
      final updates = <JellyfinConnection>[];
      final manager = MultiServerManager()
        ..onJellyfinConnectionUpdated = (connection) async {
          updates.add(connection);
          throw StateError('persistence unavailable');
        };
      addTearDown(manager.dispose);

      expect(await manager.addJellyfinConnection(historic), isTrue);

      expect(updates, hasLength(1));
      expect(updates.single.baseUrls, [active.baseUrl]);
      final live = manager.getJellyfinClientByCompoundId(historic.id)!;
      expect(live.connection.baseUrls, [active.baseUrl]);
      expect(wrong.requests, everyElement((path: '/System/Info/Public', authenticated: false)));
    });
  });

  // ============================================================
  // addJellyfinConnection reuse
  // ============================================================

  group('addJellyfinConnection reuse', () {
    // The reuse branch is what keeps a passive rebind (re-adding the same
    // persisted connection) from tearing down a live client and aborting its
    // in-flight requests. The identity assertions are load-bearing: any
    // recreation implies the prior client was closed.
    test('re-adding an identical connection reuses the live client', () async {
      var probes = 0;
      final client = JellyfinClient.forTesting(
        connection: _jellyfinConnection('user-a'),
        httpClient: MockClient((request) async {
          probes++;
          expect(request.url.path, '/Users/Me');
          return http.Response('{}', 200, headers: {'content-type': 'application/json'});
        }),
      );
      addTearDown(client.close);
      final m = MultiServerManager();
      addTearDown(m.dispose);
      m.debugRegisterJellyfinClientForTesting(client);

      final healthy = await m.addJellyfinConnection(_jellyfinConnection('user-a'));

      expect(healthy, isTrue);
      expect(m.getJellyfinClientByCompoundId('jf-machine/user-a'), same(client));
      expect(m.getClient(ServerId('jf-machine')), same(client));
      // One fresh health probe on the existing client; no recreation.
      expect(probes, 1);
    });

    test('reuse rebinds an inactive compound client without closing the active one', () async {
      JellyfinClient clientFor(String userId) => JellyfinClient.forTesting(
        connection: _jellyfinConnection(userId),
        httpClient: MockClient((_) async => http.Response('{}', 200, headers: {'content-type': 'application/json'})),
      );
      final userA = clientFor('user-a');
      final userB = clientFor('user-b');
      addTearDown(userA.close);
      addTearDown(userB.close);
      final m = MultiServerManager();
      addTearDown(m.dispose);
      m.debugRegisterJellyfinClientForTesting(userA);
      m.debugRegisterJellyfinClientForTesting(userB); // takes the machine slot

      await m.addJellyfinConnection(_jellyfinConnection('user-a'));

      expect(m.getClient(ServerId('jf-machine')), same(userA));
      expect(m.getJellyfinClientByCompoundId('jf-machine/user-a'), same(userA));
      // The other user's client stays registered for a future switch back.
      expect(m.getJellyfinClientByCompoundId('jf-machine/user-b'), same(userB));
    });
  });

  group('canReuseJellyfinClient', () {
    // A false verdict routes addJellyfinConnection to the pre-existing
    // replace path (covered by 'ignores stale admin-status persistence from
    // a replaced Jellyfin client' above).
    final base = _jellyfinConnection('user-a');

    test('identical connection is reusable', () {
      expect(MultiServerManager.canReuseJellyfinClient(live: base, incoming: _jellyfinConnection('user-a')), isTrue);
    });

    test('changed access token requires recreation', () {
      expect(
        MultiServerManager.canReuseJellyfinClient(
          live: base,
          incoming: base.copyWith(accessToken: 'rotated'),
        ),
        isFalse,
      );
    });

    test('changed device id requires recreation', () {
      expect(
        MultiServerManager.canReuseJellyfinClient(
          live: base,
          incoming: base.copyWith(deviceId: 'other-device'),
        ),
        isFalse,
      );
    });

    test('same URL set with a different active URL is reusable', () {
      // The live client rotates its active endpoint on its own; the add-path
      // race reorders the candidate list. Neither warrants a teardown.
      final live = base.copyWith(
        baseUrl: 'https://a.example.com',
        baseUrls: ['https://a.example.com', 'https://b.example.com'],
      );
      final incoming = base.copyWith(
        baseUrl: 'https://b.example.com',
        baseUrls: ['https://b.example.com', 'https://a.example.com'],
      );
      expect(MultiServerManager.canReuseJellyfinClient(live: live, incoming: incoming), isTrue);
    });

    test('an added or removed URL requires recreation', () {
      final twoUrls = base.copyWith(baseUrls: ['https://jf.example.com', 'https://alt.example.com']);
      expect(MultiServerManager.canReuseJellyfinClient(live: twoUrls, incoming: base), isFalse);
      expect(MultiServerManager.canReuseJellyfinClient(live: base, incoming: twoUrls), isFalse);
    });
  });

  // ============================================================
  // removeServer
  // ============================================================

  group('removeServer', () {
    test('removes a tracked server\'s status entry and emits a snapshot', () async {
      final m = MultiServerManager();
      addTearDown(m.dispose);

      m.updateServerStatus(ServerId('srv-1'), true);
      m.updateServerStatus(ServerId('srv-2'), true);

      final emitted = <Map<String, bool>>[];
      final sub = m.statusStream.listen(emitted.add);
      addTearDown(sub.cancel);

      m.removeServer(ServerId('srv-1'));
      await Future<void>.delayed(Duration.zero);

      expect(m.serverIds, isNot(contains('srv-1')));
      expect(emitted, isNotEmpty);
      expect(emitted.last, {'srv-2': true});
    });

    test('removing an unknown id still emits a snapshot (does not throw)', () async {
      final m = MultiServerManager();
      addTearDown(m.dispose);

      final emitted = <Map<String, bool>>[];
      final sub = m.statusStream.listen(emitted.add);
      addTearDown(sub.cancel);

      m.removeServer(ServerId('never-added'));
      await Future<void>.delayed(Duration.zero);

      // Doesn't throw; state stays empty; one snapshot fires.
      expect(m.serverIds, isEmpty);
      expect(emitted, hasLength(1));
      expect(emitted.first, isEmpty);
    });

    test('removing a Jellyfin machine clears every scoped user client', () {
      final m = MultiServerManager();
      addTearDown(m.dispose);

      m.debugRegisterJellyfinClientForTesting(_jellyfinClient('user-a'));
      m.debugRegisterJellyfinClientForTesting(_jellyfinClient('user-b'));

      expect(m.getJellyfinClientByCompoundId('jf-machine/user-a'), isNotNull);
      expect(m.getJellyfinClientByCompoundId('jf-machine/user-b'), isNotNull);

      m.removeServer(ServerId('jf-machine'));

      expect(m.getClient(ServerId('jf-machine')), isNull);
      expect(m.getJellyfinClientByCompoundId('jf-machine/user-a'), isNull);
      expect(m.getJellyfinClientByCompoundId('jf-machine/user-b'), isNull);
    });
  });

  // ============================================================
  // disconnectAll
  // ============================================================

  group('disconnectAll', () {
    test('clears all status and emits an empty snapshot', () async {
      final m = MultiServerManager();
      addTearDown(m.dispose);

      m.updateServerStatus(ServerId('a'), true);
      m.updateServerStatus(ServerId('b'), false);

      final emitted = <Map<String, bool>>[];
      final sub = m.statusStream.listen(emitted.add);
      addTearDown(sub.cancel);

      m.disconnectAll();
      await Future<void>.delayed(Duration.zero);

      expect(m.serverIds, isEmpty);
      expect(m.onlineServerIds, isEmpty);
      expect(m.offlineServerIds, isEmpty);
      expect(emitted.last, isEmpty);
    });

    test('clears inactive Jellyfin scoped clients', () {
      final m = MultiServerManager();
      addTearDown(m.dispose);

      m.debugRegisterJellyfinClientForTesting(_jellyfinClient('user-a'));
      m.debugRegisterJellyfinClientForTesting(_jellyfinClient('user-b'));

      m.disconnectAll();

      expect(m.getClient(ServerId('jf-machine')), isNull);
      expect(m.getJellyfinClientByCompoundId('jf-machine/user-a'), isNull);
      expect(m.getJellyfinClientByCompoundId('jf-machine/user-b'), isNull);
    });
  });

  // ============================================================
  // dispose
  // ============================================================

  group('dispose', () {
    test('disposing without connectivity monitoring does not throw', () {
      final m = MultiServerManager();
      // No startNetworkMonitoring call → _connectivitySubscription is null.
      // dispose() must handle the null-subscription path cleanly.
      expect(m.dispose, returnsNormally);
    });

    test('dispose closes the status stream (existing subscribers get onDone)', () async {
      final m = MultiServerManager();
      var done = false;
      final sub = m.statusStream.listen((_) {}, onDone: () => done = true);
      m.dispose();
      // Allow the close event to propagate.
      await Future<void>.delayed(Duration.zero);
      expect(done, isTrue);
      await sub.cancel();
    });
  });
}
