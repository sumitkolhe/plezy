import 'dart:async' show unawaited;

import 'package:flutter/foundation.dart';

import '../mixins/disposable_change_notifier_mixin.dart';
import '../models/arr/managed_service.dart';
import '../services/arr/arr_client.dart';
import '../services/arr/managed_service_exceptions.dart';
import '../services/arr/managed_service_store.dart';
import '../services/arr/qbittorrent_client.dart';
import '../utils/app_logger.dart';

/// Result of probing one connection, kept beside it so a row can say
/// "reconnect" without the caller re-deriving why.
typedef ManagedServiceProbe = ({ManagedServiceHealth health, String label});

/// Owns the saved [ManagedServiceConnection]s for the active profile and the
/// clients built from them.
///
/// A kind may appear several times — a 4K Radarr beside the main one — so
/// everything here is keyed by [ManagedServiceConnection.id]. Nothing carries a
/// "4K" flag: which instance holds a title is answered by asking each of them,
/// which stays right when someone splits by language or anime instead.
class ManagedServicesProvider extends ChangeNotifier with DisposableChangeNotifierMixin {
  ManagedServicesProvider({ManagedServiceStore? store}) : _store = store ?? const ManagedServiceStore();

  final ManagedServiceStore _store;

  final List<ManagedServiceConnection> _connections = [];
  final Map<String, ManagedServiceProbe> _probes = {};
  final Map<String, ArrClient> _arrClients = {};
  final Map<String, QbittorrentClient> _qbClients = {};

  String _activeUserUuid = '';
  int _bindingGeneration = 0;

  /// Writes go through one queue: save() awaits an AES-GCM protect step, so two
  /// rapid writes could otherwise land last-started-first.
  Future<void> _pendingPersistence = Future<void>.value();

  List<ManagedServiceConnection> get connections => List.unmodifiable(_connections);

  List<ManagedServiceConnection> of(ManagedServiceKind kind) => [
    for (final connection in _connections)
      if (connection.kind == kind) connection,
  ];

  bool get hasAny => _connections.isNotEmpty;

  ManagedServiceHealth healthFor(String id) => _probes[id]?.health ?? ManagedServiceHealth.unknown;

  /// Rebind to a profile's saved connections. Generation-guarded: a profile
  /// switch mid-load must not let the older read win.
  Future<void> onActiveProfileChanged(String? userUuid) async {
    final generation = ++_bindingGeneration;
    _activeUserUuid = userUuid ?? '';
    _disposeClients();
    _connections.clear();
    _probes.clear();
    if (_activeUserUuid.isEmpty) {
      safeNotifyListeners();
      return;
    }
    final loaded = await _store.load(_activeUserUuid);
    if (isDisposed || generation != _bindingGeneration) return;
    _connections.addAll(loaded);
    safeNotifyListeners();
    for (final connection in loaded) {
      unawaited(probe(connection.id));
    }
  }

  /// Save [connection] and record its probe. Replaces an existing entry with
  /// the same [ManagedServiceConnection.id]. Rethrows so the connect screen can
  /// show why a host was refused.
  Future<void> connect(ManagedServiceConnection connection) async {
    final probe = await _probeConnection(connection);
    final labelled = connection.copyWith(label: probe.label);
    final existing = _connections.indexWhere((c) => c.id == labelled.id);
    if (existing == -1) {
      _connections.add(labelled);
    } else {
      _connections[existing] = labelled;
    }
    _probes[labelled.id] = probe;
    _disposeClientFor(labelled.id);
    safeNotifyListeners();
    await _persist();
  }

  Future<void> disconnect(String id) async {
    _connections.removeWhere((c) => c.id == id);
    _probes.remove(id);
    _disposeClientFor(id);
    safeNotifyListeners();
    await _persist();
  }

  /// Re-check a saved connection, updating [healthFor] and its label.
  Future<void> probe(String id) async {
    final connection = _connections.firstWhere((c) => c.id == id, orElse: _missing);
    if (connection.baseUrl.isEmpty) return;
    ManagedServiceProbe result;
    try {
      result = await _probeConnection(connection);
    } on ManagedServiceAuthException {
      result = (health: ManagedServiceHealth.unauthorized, label: '');
    } catch (e) {
      appLogger.d('${connection.kind.name}: probe failed', error: e);
      result = (health: ManagedServiceHealth.unreachable, label: '');
    }
    if (isDisposed) return;
    _probes[id] = result;
    safeNotifyListeners();
  }

  /// Builds a throwaway client so a probe never adopts a half-configured one
  /// into the cache.
  Future<ManagedServiceProbe> _probeConnection(ManagedServiceConnection connection) async {
    if (connection.kind == ManagedServiceKind.qbittorrent) {
      final client = QbittorrentClient(
        baseUrl: connection.baseUrl,
        username: connection.username,
        password: connection.secret,
      );
      try {
        return (health: ManagedServiceHealth.reachable, label: await client.testConnection());
      } finally {
        client.dispose();
      }
    }
    final client = ArrClient(kind: connection.kind, baseUrl: connection.baseUrl, apiKey: connection.secret);
    try {
      return (health: ManagedServiceHealth.reachable, label: await client.testConnection());
    } finally {
      client.dispose();
    }
  }

  /// Long-lived clients for query work (phase 2 onward), one per instance.
  ArrClient? arrClient(String id) {
    final connection = _connections.firstWhere((c) => c.id == id, orElse: _missing);
    if (connection.baseUrl.isEmpty || connection.kind == ManagedServiceKind.qbittorrent) return null;
    return _arrClients[id] ??= ArrClient(
      kind: connection.kind,
      baseUrl: connection.baseUrl,
      apiKey: connection.secret,
    );
  }

  QbittorrentClient? qbittorrentClient(String id) {
    final connection = _connections.firstWhere((c) => c.id == id, orElse: _missing);
    if (connection.kind != ManagedServiceKind.qbittorrent) return null;
    return _qbClients[id] ??= QbittorrentClient(
      baseUrl: connection.baseUrl,
      username: connection.username,
      password: connection.secret,
    );
  }

  static ManagedServiceConnection _missing() =>
      const ManagedServiceConnection(kind: ManagedServiceKind.radarr, baseUrl: '', secret: '');

  Future<void> _persist() {
    final snapshot = List<ManagedServiceConnection>.of(_connections);
    final run = _pendingPersistence.then((_) => _store.save(_activeUserUuid, snapshot));
    _pendingPersistence = run.then<void>(
      (_) {},
      onError: (Object e) => appLogger.w('Managed services: persistence failed', error: e),
    );
    return run;
  }

  void _disposeClientFor(String id) {
    _arrClients.remove(id)?.dispose();
    _qbClients.remove(id)?.dispose();
  }

  void _disposeClients() {
    for (final client in _arrClients.values) {
      client.dispose();
    }
    for (final client in _qbClients.values) {
      client.dispose();
    }
    _arrClients.clear();
    _qbClients.clear();
  }

  @override
  void dispose() {
    _disposeClients();
    super.dispose();
  }
}
