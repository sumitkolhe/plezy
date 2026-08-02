import 'dart:async';
import '../media/ids.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import '../connection/connection.dart';
import '../media/media_server_client.dart';

import 'jellyfin_client.dart';
import 'jellyfin_endpoint_discovery.dart';
import '../utils/app_logger.dart';
import 'storage_service.dart';

/// Manages multiple media-server connections simultaneously.
///
/// The internal map and public accessors are typed against the
/// [MediaServerClient] interface so consumers don't depend on the concrete
/// backend so consumers don't depend on the concrete backend.
class MultiServerManager {
  MultiServerManager({
    Stream<List<ConnectivityResult>> Function()? connectivityChanges,
    Duration connectivityDebounceDuration = const Duration(seconds: 2),
  }) : this._(connectivityChanges ?? _defaultConnectivityChanges, connectivityDebounceDuration);

  MultiServerManager._(this._connectivityChanges, this._connectivityDebounceDuration);

  static Stream<List<ConnectivityResult>> _defaultConnectivityChanges() => Connectivity().onConnectivityChanged;

  final Stream<List<ConnectivityResult>> Function() _connectivityChanges;
  final Duration _connectivityDebounceDuration;
  FutureOr<void> Function(JellyfinConnection connection)? onJellyfinConnectionUpdated;

  final Map<String, MediaServerClient> _clients = {};

  final Map<String, bool> _serverStatus = {};

  /// Servers whose last health probe rejected the auth token (HTTP 401/403).
  /// These rows also have `_serverStatus[serverId] == false` — auth errors are
  /// a *kind* of offline. Surfaces through [authErrorServerIds] so UI can
  /// show a "Sign in again" banner instead of a generic offline state.
  final Set<String> _authErrorServers = {};

  /// Stream controller for server status changes
  final _statusController = StreamController<Map<String, bool>>.broadcast();

  Stream<Map<String, bool>> get statusStream => _statusController.stream;

  /// Publish a snapshot of the per-server online map — subscribers must never
  /// receive the live [_serverStatus] instance.
  void _emitStatus() => _statusController.add(Map.from(_serverStatus));

  /// Per-server connect progress during a bind. Unlike [statusStream] — whose
  /// first emission means "the binder's first connect pass finished" and which
  /// triggers libraries/live-tv work per emission — this fires as each
  /// individual server lands so the startup splash can flip its checkmarks
  /// incrementally without disturbing those contracts.
  final _connectProgressController = StreamController<({String serverId, bool online})>.broadcast();

  Stream<({String serverId, bool online})> get connectProgressStream => _connectProgressController.stream;

  /// Servers whose authentication has failed (token rejected). A re-auth flow
  /// should be offered for these — they will remain "offline" until the user
  /// signs in again. Cleared once a probe succeeds.
  Set<String> get authErrorServerIds => Set.unmodifiable(_authErrorServers);

  /// Connectivity subscription for network monitoring
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;

  /// Map of serverId to active optimization futures
  final Map<String, Future<void>> _activeOptimizations = {};

  /// Whether [compoundId] is still the client bound as the active user for
  /// [machineId]. Async Jellyfin work must re-check this before publishing a
  /// result — a profile switch can rebind the machine mid-probe.
  bool _isActiveJellyfin(String machineId, String compoundId) => _activeJellyfinMachine[machineId] == compoundId;

  /// All Jellyfin clients ever added, keyed by the compound connection id
  /// (`{serverMachineId}/{userId}`). Lets two users on the same Jellyfin
  /// server coexist — adding the second user's client won't tear down the
  /// first user's in-flight operations. [_clients] holds the currently
  /// "active" entry per machineId for everyone-pass-machineId-as-serverId
  /// consumers (cache resolver, visibility filter, MediaItem.serverId).
  final Map<String, JellyfinClient> _jellyfinByCompoundId = {};
  final Map<String, String> _activeJellyfinMachine = {};
  final Map<String, HealthStatus> _jellyfinHealthByCompoundId = {};

  /// Debounce timers for endpoint-exhaustion-triggered reconnection (per server)
  final Map<String, Timer> _reconnectDebounce = {};

  /// Servers whose endpoint-exhaustion signal is being confirmed by an
  /// auth-required health probe. Exhaustion callbacks raised by that probe
  /// are ignored so a failed confirmation cannot recursively schedule itself.
  final Set<String> _endpointHealthChecks = {};

  /// Coalescing guard for checkServerHealth — prevents concurrent health checks
  Future<void>? _activeHealthCheck;

  /// Coalescing guard for reconnectOfflineServers — prevents concurrent reconnect sweeps
  Future<void>? _activeReconnect;

  /// Debounce timer for connectivity events — collapses rapid network flapping
  Timer? _connectivityDebounce;

  /// Get all registered server IDs.
  List<String> get serverIds => _clients.keys.toList();

  List<String> get onlineServerIds => _serverStatus.entries.where((e) => e.value).map((e) => e.key).toList();

  List<String> get offlineServerIds => _serverStatus.entries.where((e) => !e.value).map((e) => e.key).toList();

  /// Get client for specific server.
  MediaServerClient? getClient(ServerId serverId) => _clients[serverId];

  /// Resolve an exact private client namespace without falling back to a
  /// different active user on the same public server.
  MediaServerClient? getClientByScope(String clientScopeId) {
    return getJellyfinClientByCompoundId(clientScopeId);
  }

  /// Server ids visible to the active profile; `null` means no restriction.
  /// Owned here rather than on `MultiServerProvider` so non-UI consumers
  /// (the download client resolver) apply the same filter the UI does —
  /// the provider delegates its filter state to this field.
  Set<String>? _visibleServerIds;

  Set<String>? get visibleServerIds => _visibleServerIds;

  void setVisibleServerIds(Set<String>? ids) => _visibleServerIds = ids;

  bool isServerVisible(ServerId serverId) => _visibleServerIds?.contains(serverId) ?? true;

  /// Resolve the client for a queued download. A supplied private namespace
  /// must match exactly; falling back to another active user would run work
  /// under the wrong authenticated identity.
  MediaServerClient? resolveDownloadClient(ServerId serverId, {String? clientScopeId}) {
    if (!isServerVisible(serverId)) return null;
    if (clientScopeId != null && clientScopeId.isNotEmpty) {
      final scoped = getClientByScope(clientScopeId);
      return scoped?.serverId == serverId ? scoped : null;
    }
    return getClient(serverId);
  }

  @visibleForTesting
  void debugRegisterJellyfinClientForTesting(JellyfinClient client, {bool online = true}) {
    _wireJellyfinConnectionUpdates(client);
    final compoundId = client.connection.id;
    final machineId = client.connection.serverMachineId;
    _jellyfinByCompoundId[compoundId] = client;
    _jellyfinHealthByCompoundId[compoundId] = online ? HealthStatus.online : HealthStatus.offline;
    _clients[machineId] = client;
    _activeJellyfinMachine[machineId] = compoundId;
    _serverStatus[machineId] = online;
  }

  @visibleForTesting
  void debugRegisterClientForTesting(MediaServerClient client, {bool online = true}) {
    _clients[client.serverId] = client;
    _serverStatus[client.serverId] = online;
  }

  @visibleForTesting
  void debugMarkAuthErrorForTesting(ServerId serverId) {
    _serverStatus[serverId] = false;
    _authErrorServers.add(serverId);
    _emitStatus();
  }

  String serverDisplayName(ServerId serverId) => _clients[serverId]?.serverName ?? serverId;

  /// Backend-neutral "is this user an owner/admin on [serverId]?" probe used
  /// by UI gates that hide destructive admin entries (delete, edit metadata,
  /// match/unmatch). Returns:
  ///   - Jellyfin: `JellyfinConnection.isAdministrator` captured at sign-in.
  ///   - Unknown server: `false`.
  bool isOwnerOrAdmin(ServerId serverId) {
    final client = _clients[serverId];
    if (client is JellyfinClient) {
      return client.connection.isAdministrator;
    }
    return false;
  }

  /// Get all online clients
  Map<String, MediaServerClient> get onlineClients {
    final result = <String, MediaServerClient>{};
    for (final serverId in onlineServerIds) {
      final client = _clients[serverId];
      if (client != null) {
        result[serverId] = client;
      }
    }
    return result;
  }

  /// Check if a server is online
  bool isServerOnline(ServerId serverId) => _serverStatus[serverId] ?? false;

  /// Check whether the active or exact scoped client for [serverId] is online.
  bool isClientOnline(ServerId serverId, {String? clientScopeId}) {
    if (clientScopeId != null && clientScopeId.isNotEmpty) {
      final client = getClientByScope(clientScopeId);
      if (client == null || client.serverId != serverId) return false;
      if (client is JellyfinClient) {
        return _jellyfinHealthByCompoundId[clientScopeId] == HealthStatus.online;
      }
    }
    return isServerOnline(serverId);
  }

  /// Remove a server connection
  void removeServer(ServerId serverId) {
    final jellyfinCompoundIds = _jellyfinByCompoundId.entries
        .where((entry) => entry.value.connection.serverMachineId == serverId)
        .map((entry) => entry.key)
        .toList();
    final activeClient = _forgetServer(serverId);
    if (jellyfinCompoundIds.isNotEmpty) {
      final closed = <JellyfinClient>{};
      for (final compoundId in jellyfinCompoundIds) {
        final client = _jellyfinByCompoundId.remove(compoundId);
        _jellyfinHealthByCompoundId.remove(compoundId);
        if (client != null && closed.add(client)) {
          unawaited(_closeClientGracefully(client));
        }
      }
    } else if (activeClient != null) {
      // Jellyfin's clients were all closed above.
      unawaited(_closeClientGracefully(activeClient));
    }
    _emitStatus();
    appLogger.i('Removed server: $serverId');
  }

  /// Drop every registration keyed by [serverId], cancel its pending exhaustion
  /// retry, and return the client that was bound (the caller closes it). The
  /// single teardown for both removal paths, so they cannot drift apart again.
  /// The in-flight guards ([_activeOptimizations], [_endpointHealthChecks]) are
  /// deliberately left alone — they are owned by the futures that set them.
  MediaServerClient? _forgetServer(String serverId) {
    _reconnectDebounce.remove(serverId)?.cancel();
    final client = _clients.remove(serverId);
    _activeJellyfinMachine.remove(serverId);
    _serverStatus.remove(serverId);
    _authErrorServers.remove(serverId);
    return client;
  }

  /// Close [client], draining in-flight requests when it supports it. Callers
  /// that do not need to wait wrap the call in `unawaited(...)`.
  Future<void> _closeClientGracefully(
    MediaServerClient client, {
    Duration drainTimeout = const Duration(seconds: 2),
  }) async {
    if (client case final GracefullyCloseable graceful) {
      await graceful.closeGracefully(drainTimeout: drainTimeout);
    } else {
      client.close();
    }
  }

  /// Add a Jellyfin server backed by an authenticated [JellyfinConnection].
  /// Returns true on success.
  ///
  /// When a live client already exists for the same compound id and the
  /// connection is equivalent (see [canReuseJellyfinClient]), that client is
  /// reused instead of recreated — profile rebinds re-add unchanged
  /// connections routinely, and tearing the client down would abort its
  /// in-flight requests. A material change (token, deviceId, URL set) still
  /// replaces the client. This mirrors the rebind path, where
  /// [refreshTokensForProfile] reuses the online client via an in-place
  /// token update.
  ///
  /// Jellyfin clients use the shared endpoint-racing flow when multiple URLs
  /// are configured, then instantiate the client against the lowest-latency
  /// reachable URL.
  ///
  /// Two users on the same Jellyfin server are tracked separately in
  /// [_jellyfinByCompoundId]; only one is "active" per machineId at a time.
  /// Adding the second user's connection doesn't close the first user's
  /// client (preserves any in-flight operations on the prior profile).
  Future<bool> addJellyfinConnection(JellyfinConnection connection) async {
    try {
      // Every close path detaches the client from [_jellyfinByCompoundId]
      // before closing it, so a client found here is never mid-close.
      final existing = _jellyfinByCompoundId[connection.id];
      if (existing != null && canReuseJellyfinClient(live: existing.connection, incoming: connection)) {
        return _reuseJellyfinClient(existing);
      }

      var resolvedConnection = connection;
      var endpointSelectionValidated = false;
      if (connection.baseUrls.length > 1) {
        try {
          final endpoint = await JellyfinEndpointDiscovery().raceEndpoints(
            connection.baseUrls,
            preferredUrl: connection.baseUrl,
            expectedMachineId: connection.serverMachineId,
            // Historic alternates are independent retry candidates, not one
            // atomic user-entered group. Reconcile each probe outcome below
            // instead of rejecting the whole stored connection.
            baseUrlsToValidate: const [],
          );
          resolvedConnection = connection.copyWith(
            baseUrl: endpoint.activeBaseUrl,
            baseUrls: endpoint.reconcilePreviouslyStoredBaseUrls(connection.baseUrls),
            serverName: endpoint.serverInfo.serverName,
          );
          endpointSelectionValidated = true;
        } catch (e, st) {
          appLogger.w(
            'Jellyfin endpoint race failed; using only the stored active endpoint',
            error: e.runtimeType,
            stackTrace: st,
          );
          resolvedConnection = connection.copyWith(baseUrl: connection.baseUrl, baseUrls: [connection.baseUrl]);
        }
      }

      final exhaustedMachineId = resolvedConnection.serverMachineId;
      final exhaustedCompoundId = resolvedConnection.id;
      final client = await JellyfinClient.create(
        resolvedConnection,
        onAllEndpointsExhausted: () => _onJellyfinEndpointsExhausted(exhaustedMachineId, exhaustedCompoundId),
      );
      // Admin status can change server-side; re-broadcast and persist so
      // admin-gated UI survives app restarts without requiring re-auth.
      _wireJellyfinConnectionUpdates(
        client,
        baseUrlsForPersistence: endpointSelectionValidated ? null : connection.baseUrls,
      );
      if (endpointSelectionValidated &&
          (resolvedConnection.baseUrl != connection.baseUrl ||
              !listEquals(resolvedConnection.baseUrls, connection.baseUrls))) {
        try {
          await onJellyfinConnectionUpdated?.call(resolvedConnection);
        } catch (e, st) {
          // Persistence failure does not alter the already-reconciled
          // in-memory client.
          appLogger.w('Failed to persist reconciled Jellyfin endpoints', error: e.runtimeType, stackTrace: st);
        }
      }
      final compoundId = resolvedConnection.id;
      final machineId = resolvedConnection.serverMachineId;

      // Replace the prior client for this compound id — reaching here means
      // the connection materially changed (token refresh, URL-set edit); an
      // unchanged re-add was already handled by the reuse branch above.
      final oldClient = _jellyfinByCompoundId[compoundId];
      if (oldClient != null) unawaited(_closeClientGracefully(oldClient));
      _jellyfinByCompoundId[compoundId] = client;

      // Bind this user as the active client for its machine. A previously
      // active client for a *different* compound id stays alive in
      // [_jellyfinByCompoundId] so a future profile switch can re-bind it.
      _clients[machineId] = client;
      _activeJellyfinMachine[machineId] = compoundId;

      final health = await client.checkHealth();
      final healthy = health == HealthStatus.online;
      _jellyfinHealthByCompoundId[compoundId] = health;
      _applyHealth(ServerId(machineId), health);

      appLogger.i('Added Jellyfin server: ${resolvedConnection.serverName}${healthy ? '' : ' (unhealthy)'}');
      if (_connectivitySubscription == null && healthy) {
        _startNetworkMonitoring();
      }
      return healthy;
    } catch (e, stackTrace) {
      appLogger.e('Failed to add Jellyfin server ${connection.serverName}', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  /// Whether the live client bound to [live] can serve [incoming] without
  /// being recreated. Recreation is required when a field baked into the
  /// client at construction time changes:
  /// - `accessToken` / `deviceId` are embedded in the auth headers when the
  ///   HTTP client is built;
  /// - `baseUrls` fixes the failover candidate set. Compared as a set: both
  ///   the client and the add-path endpoint race reorder the list as
  ///   endpoints are promoted, so ordering drifts on an unchanged server.
  ///
  /// Everything else is deliberately ignored: the active `baseUrl` drifts as
  /// the client rotates endpoints, `isAdministrator` self-refreshes on health
  /// checks, and the remaining fields are display metadata. `userId` and
  /// `serverMachineId` equality is implied by the compound-id lookup that
  /// precedes this check.
  @visibleForTesting
  static bool canReuseJellyfinClient({required JellyfinConnection live, required JellyfinConnection incoming}) {
    return live.accessToken == incoming.accessToken &&
        live.deviceId == incoming.deviceId &&
        setEquals(live.baseUrls.toSet(), incoming.baseUrls.toSet());
  }

  /// Re-add of an unchanged connection: keep the live client (preserving its
  /// in-flight requests and settled endpoint choice), re-bind it as the
  /// machine's active user, and run a fresh health probe so callers still
  /// get a current result. Skips the endpoint race ([JellyfinClient] has
  /// per-request failover plus exhaustion-triggered reconnect), the
  /// connection-update wiring (already attached when the client was first
  /// added), and the connection persist (the client persists its own
  /// endpoint rotations).
  Future<bool> _reuseJellyfinClient(JellyfinClient client) async {
    final compoundId = client.connection.id;
    final machineId = client.connection.serverMachineId;
    final rebound = !_isActiveJellyfin(machineId, compoundId);
    _clients[machineId] = client;
    _activeJellyfinMachine[machineId] = compoundId;

    final health = await client.checkHealth();
    _jellyfinHealthByCompoundId[compoundId] = health;
    if (!_isActiveJellyfin(machineId, compoundId)) {
      // A concurrent remove/re-add won while the probe was in flight.
      appLogger.d('Ignoring stale Jellyfin reuse result for ${client.connection.serverName}');
      return health == HealthStatus.online;
    }
    _applyHealth(ServerId(machineId), health);
    if (rebound) {
      // The machine's active user changed even if its online status didn't;
      // client-map consumers need to observe the swap.
      _emitStatus();
    }
    final healthy = health == HealthStatus.online;
    appLogger.i(
      'Reusing existing Jellyfin client for ${client.connection.serverName}'
      '${healthy ? '' : ' (unhealthy)'} (connection unchanged)',
    );
    if (_connectivitySubscription == null && healthy) {
      _startNetworkMonitoring();
    }
    return healthy;
  }

  void _wireJellyfinConnectionUpdates(JellyfinClient client, {List<String>? baseUrlsForPersistence}) {
    client.onConnectionUpdated = (updated) async {
      if (_jellyfinByCompoundId[updated.id] != client) {
        appLogger.d('Ignoring stale Jellyfin connection update for ${updated.serverName}');
        return;
      }
      final persist = onJellyfinConnectionUpdated;
      if (persist != null) {
        try {
          final connectionToPersist = baseUrlsForPersistence == null
              ? updated
              : updated.copyWith(baseUrls: baseUrlsForPersistence);
          await Future.sync(() => persist(connectionToPersist));
        } catch (e, st) {
          appLogger.w('Failed to persist Jellyfin connection update', error: e, stackTrace: st);
        }
      }
      _emitStatus();
    };
  }

  /// Look up a tracked Jellyfin client by its compound id
  /// (`{serverMachineId}/{userId}`). Returns `null` if no Jellyfin
  /// connection with that id has been added. Useful for callers that need
  /// the *specific* user's client, not whichever is currently active for
  /// the machine.
  JellyfinClient? getJellyfinClientByCompoundId(String compoundId) => _jellyfinByCompoundId[compoundId];

  /// Tear down a specific Jellyfin user's client. If it was the active one
  /// for its machine, the machine slot is cleared.
  void removeJellyfinConnection(JellyfinConnection connection) {
    final compoundId = connection.id;
    final machineId = connection.serverMachineId;
    final client = _jellyfinByCompoundId.remove(compoundId);
    _jellyfinHealthByCompoundId.remove(compoundId);
    if (client != null) unawaited(_closeClientGracefully(client));
    if (_isActiveJellyfin(machineId, compoundId)) {
      _forgetServer(machineId);
      _emitStatus();
    }
  }

  /// Update server status (used for health monitoring).
  ///
  /// Clears the auth-error flag — callers that observed an auth failure
  /// should use [_applyHealth] instead.
  void updateServerStatus(ServerId serverId, bool isOnline) =>
      _applyHealth(serverId, isOnline ? HealthStatus.online : HealthStatus.offline);

  /// Apply a health-probe outcome to both online state and auth-error
  /// tracking. Used by the manager's own health checks; external callers
  /// without an auth-distinct signal should use [updateServerStatus].
  void _applyHealth(ServerId serverId, HealthStatus status) {
    final isOnline = status == HealthStatus.online;
    final isAuthError = status == HealthStatus.authError;
    final prevOnline = _serverStatus[serverId];
    final hadAuthError = _authErrorServers.contains(serverId);

    _serverStatus[serverId] = isOnline;
    if (isAuthError) {
      _authErrorServers.add(serverId);
    } else {
      _authErrorServers.remove(serverId);
    }

    final changed = prevOnline != isOnline || hadAuthError != isAuthError;
    if (changed) {
      _emitStatus();
      if (isAuthError) {
        appLogger.w('Server $serverId auth rejected — token expired or revoked');
      } else {
        appLogger.d('Server $serverId status changed to: $isOnline');
      }
    }
  }

  /// Test connection health for all servers. The probe is backend-defined:
  /// Jellyfin hits `/Users/Me` (auth-required)
  /// so a server with a revoked token is correctly reported as offline.
  Future<void> checkServerHealth() async {
    // Coalesce concurrent calls — return the in-flight future if one exists
    if (_activeHealthCheck != null) return _activeHealthCheck!;

    _activeHealthCheck = _doCheckServerHealth();
    try {
      await _activeHealthCheck;
    } finally {
      _activeHealthCheck = null;
    }
  }

  Future<void> _doCheckServerHealth() async {
    appLogger.d('Checking health for ${_clients.length} servers');

    final healthChecks = _clients.entries.map((entry) async {
      final serverId = entry.key;
      final client = entry.value;
      final expectedJellyfinCompoundId = client is JellyfinClient ? client.connection.id : null;

      final status = await client.checkHealth();
      if (client is JellyfinClient) {
        final compoundId = expectedJellyfinCompoundId ?? client.connection.id;
        _jellyfinHealthByCompoundId[compoundId] = status;
        if (!_isActiveJellyfin(serverId, compoundId)) {
          appLogger.d('Ignoring stale Jellyfin health result for ${client.connection.serverName}');
          return;
        }
      }
      _applyHealth(ServerId(serverId), status);
      if (status != HealthStatus.online) {
        appLogger.w('Server $serverId health check failed: ${status.name}');
      }
    });

    await Future.wait(healthChecks);
  }

  /// Start monitoring network connectivity for all servers
  void _startNetworkMonitoring() {
    if (_connectivitySubscription != null) {
      appLogger.d('Network monitoring already active');
      return;
    }

    appLogger.i('Starting network monitoring for all servers');
    try {
      _connectivitySubscription = _connectivityChanges().listen(
        (results) {
          final status = results.isNotEmpty ? results.first : ConnectivityResult.none;

          if (status == ConnectivityResult.none) {
            appLogger.w('Connectivity lost, pausing optimization until network returns');
            return;
          }

          // Debounce rapid connectivity events (e.g. WiFi flapping) into a single trigger
          _connectivityDebounce?.cancel();
          _connectivityDebounce = Timer(_connectivityDebounceDuration, () {
            _connectivityDebounce = null;

            appLogger.d(
              'Connectivity change detected, re-optimizing all servers',
              error: {'status': status.name, 'interfaces': results.map((r) => r.name).toList()},
            );

            // Re-optimize all servers and re-probe offline ones
            _reoptimizeAllServers(reason: 'connectivity:${status.name}');
            checkServerHealth();
          });
        },
        onError: (error, stackTrace) {
          appLogger.w('Connectivity listener error', error: error, stackTrace: stackTrace);
        },
      );
    } catch (e) {
      appLogger.w('Connectivity monitoring unavailable', error: e);
    }
  }

  /// Stop monitoring network connectivity
  void _stopNetworkMonitoring() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    _connectivityDebounce?.cancel();
    _connectivityDebounce = null;
    appLogger.i('Stopped network monitoring');
  }

  /// Run [taskBuilder] as the single in-flight optimize/reconnect task for
  /// [serverId] — the sole owner of the [_activeOptimizations] invariant.
  ///
  /// While an entry exists the builder is never invoked and a completed future
  /// is returned, so a caller awaiting a batch never waits on work it did not
  /// start. The registered future always clears its own entry. [timeout] bounds
  /// the task, logging `<timeoutLabel> timed out for <serverId>` when it fires.
  Future<void> _runServerTask(
    String serverId,
    Future<void> Function() taskBuilder, {
    Duration? timeout,
    String? timeoutLabel,
  }) {
    if (_activeOptimizations.containsKey(serverId)) return Future<void>.value();

    var task = taskBuilder();
    if (timeout != null) {
      task = task.timeout(timeout, onTimeout: () => appLogger.d('$timeoutLabel timed out for $serverId'));
    }
    // Must not *return* the removed entry — whenComplete would then await this very future.
    final registered = task.whenComplete(() {
      _activeOptimizations.remove(serverId);
    });
    _activeOptimizations[serverId] = registered;
    return registered;
  }

  /// Re-probe offline servers after a connectivity change.
  void _reoptimizeAllServers({required String reason}) {
    // Jellyfin re-probes offline servers here. Online clients keep their current
    // endpoint and can still fail over per request through JellyfinClient.
    for (final entry in _activeJellyfinMachine.entries) {
      final serverId = entry.key;
      if (isServerOnline(ServerId(serverId))) continue;

      final client = _jellyfinByCompoundId[entry.value];
      if (client == null) continue;

      unawaited(_runServerTask(serverId, () => _reconnectJellyfinServer(serverId, client)));
    }
  }

  /// Attempt reconnection for a single offline Jellyfin server.
  ///
  /// Jellyfin has a single fixed base URL — there's no connection-racing to
  /// run, just a health round-trip. The existing [JellyfinClient] is reused
  /// (the access token persists in [JellyfinConnection]); on success we flip
  /// the machine slot back to online so MediaServer-aware UI un-greys the
  /// entry.
  Future<void> _reconnectJellyfinServer(String machineId, JellyfinClient client) async {
    final expectedCompoundId = client.connection.id;
    try {
      appLogger.d('Attempting reconnection for Jellyfin server ${client.connection.serverName}');
      final status = await client.checkHealth();
      _jellyfinHealthByCompoundId[expectedCompoundId] = status;
      if (!_isActiveJellyfin(machineId, expectedCompoundId)) {
        appLogger.d('Ignoring stale Jellyfin reconnection result for ${client.connection.serverName}');
        return;
      }
      _applyHealth(ServerId(machineId), status);
      if (status == HealthStatus.online) {
        appLogger.i('Successfully reconnected to ${client.connection.serverName}');
      } else {
        appLogger.d('Reconnection probe for ${client.connection.serverName} returned ${status.name}');
      }
    } catch (e) {
      appLogger.d('Reconnection failed for ${client.connection.serverName}: $e');
      // Leave status as offline — will retry on next trigger
    }
  }

  /// Attempt reconnection for all offline servers.
  ///
  /// When [forceRediscovery] is true, the cached endpoint is cleared before
  /// reconnecting so the fast-path is skipped and a full candidate race runs.
  /// Used by the manual reconnect button when the cached URL may be stale
  /// (e.g. after a network change while the app was backgrounded).
  Future<void> reconnectOfflineServers({bool forceRediscovery = false}) async {
    // Coalesce concurrent calls — return the in-flight future if one exists
    if (_activeReconnect != null) return _activeReconnect!;

    _activeReconnect = _doReconnectOfflineServers(forceRediscovery: forceRediscovery);
    try {
      await _activeReconnect;
    } finally {
      _activeReconnect = null;
    }
  }

  Future<void> _doReconnectOfflineServers({required bool forceRediscovery}) async {
    final offline = offlineServerIds;
    if (offline.isEmpty) return;

    appLogger.d('Attempting reconnection for ${offline.length} offline servers');

    if (forceRediscovery) {
      final storage = await StorageService.getInstance();
      await Future.wait(offline.map((id) => storage.clearServerEndpoint(ServerId(id))));
    }

    final futures = offline.map((serverId) {
      // The active [JellyfinClient] is keyed by machineId in `_clients` and
      // tracked in `_activeJellyfinMachine`. Run the same auth probe used at
      // add time.
      final activeCompoundId = _activeJellyfinMachine[serverId];
      final jellyfinClient = activeCompoundId != null ? _jellyfinByCompoundId[activeCompoundId] : null;
      if (jellyfinClient == null) return Future<void>.value();

      return _runServerTask(
        serverId,
        () => _reconnectJellyfinServer(serverId, jellyfinClient),
        timeout: const Duration(seconds: 15),
        timeoutLabel: 'Jellyfin reconnection',
      );
    });

    await Future.wait(futures);
  }

  /// Called when all failover endpoints are exhausted for a server.
  ///
  /// A content route timing out does not prove the server itself is offline.
  /// Debounce parallel failures, then confirm with the backend's lightweight
  /// auth-required health probe before publishing an offline transition.
  void _onServerEndpointsExhausted(ServerId serverId) {
    if (_endpointHealthChecks.contains(serverId)) return;

    _reconnectDebounce[serverId]?.cancel();
    _reconnectDebounce[serverId] = Timer(const Duration(seconds: 5), () {
      _reconnectDebounce.remove(serverId);
      unawaited(_verifyServerEndpointsExhausted(serverId));
    });
  }

  /// Fire-and-forget safe: both backends' `checkHealth` catch every failure
  /// and fold it into a [HealthStatus], and the scheduled reconnection guards
  /// its own errors — this future must never complete with one.
  Future<void> _verifyServerEndpointsExhausted(ServerId serverId) async {
    final client = _clients[serverId];
    if (client == null || !_endpointHealthChecks.add(serverId)) return;

    try {
      final health = await client.checkHealth();
      if (!identical(_clients[serverId], client)) return;

      if (client is JellyfinClient) {
        _jellyfinHealthByCompoundId[client.connection.id] = health;
      }

      if (health == HealthStatus.online) {
        _applyHealth(serverId, health);
        appLogger.d('Endpoint exhaustion not confirmed for $serverId; health probe succeeded');
        return;
      }

      _applyHealth(serverId, health);
      if (health == HealthStatus.authError) return;

      final jellyfinClient = client is JellyfinClient ? client : null;
      if (jellyfinClient == null) return;

      appLogger.i('Health probe confirmed $serverId offline, triggering reconnection');

      unawaited(_runServerTask(serverId, () => _reconnectJellyfinServer(serverId, jellyfinClient)));
    } finally {
      _endpointHealthChecks.remove(serverId);
    }
  }

  /// Jellyfin clients outlive their active binding (a previous profile's
  /// client stays in [_jellyfinByCompoundId]); only the currently bound
  /// client's exhaustion may verify and flip the machine's status.
  void _onJellyfinEndpointsExhausted(String machineId, String compoundId) {
    if (!_isActiveJellyfin(machineId, compoundId)) {
      appLogger.d('Ignoring endpoint exhaustion from inactive Jellyfin client', error: compoundId);
      return;
    }
    _onServerEndpointsExhausted(ServerId(machineId));
  }

  @visibleForTesting
  Future<void> debugVerifyServerEndpointsExhaustedForTesting(ServerId serverId) =>
      _verifyServerEndpointsExhausted(serverId);

  /// Entry point matching production exhaustion wiring (debounce + the
  /// in-flight-verification guard), for tests driving the full retry loop.
  @visibleForTesting
  void debugTriggerEndpointsExhaustedForTesting(ServerId serverId) => _onServerEndpointsExhausted(serverId);

  /// Disconnect all servers, fire-and-forget.
  ///
  /// Registrations are dropped synchronously ([_detachAllClients] runs before
  /// the first await); only the socket drain is left running in the background.
  void disconnectAll() {
    unawaited(disconnectAllGracefully(drainTimeout: const Duration(seconds: 2)));
  }

  Future<void> disconnectAllGracefully({Duration drainTimeout = const Duration(seconds: 5)}) async {
    appLogger.i('Gracefully disconnecting all servers');
    final clients = _detachAllClients();
    await Future.wait(
      clients.map((client) => _closeClientGracefully(client, drainTimeout: drainTimeout)),
      eagerError: false,
    );
  }

  Set<MediaServerClient> _detachAllClients() {
    _stopNetworkMonitoring();
    for (final timer in _reconnectDebounce.values) {
      timer.cancel();
    }
    _reconnectDebounce.clear();
    _activeHealthCheck = null;
    _activeReconnect = null;
    final clients = <MediaServerClient>{..._clients.values, ..._jellyfinByCompoundId.values};
    _clients.clear();
    _jellyfinByCompoundId.clear();
    _activeJellyfinMachine.clear();
    _jellyfinHealthByCompoundId.clear();
    _serverStatus.clear();
    _authErrorServers.clear();
    _activeOptimizations.clear();
    if (!_statusController.isClosed) {
      _statusController.add({});
    }
    return clients;
  }

  /// Dispose resources
  void dispose() {
    disconnectAll();
    if (!_statusController.isClosed) {
      _statusController.close();
    }
    if (!_connectProgressController.isClosed) {
      _connectProgressController.close();
    }
  }
}
