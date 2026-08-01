import 'dart:async';

import 'package:flutter/foundation.dart';

import '../mixins/disposable_change_notifier_mixin.dart';
import '../models/seerr/seerr_session.dart';
import '../services/seerr/seerr_auth_service.dart';
import '../services/seerr/seerr_client.dart';
import '../services/seerr/seerr_session_store.dart';
import '../utils/app_logger.dart';

/// Owns the active Seerr session for the currently-selected profile,
/// mirroring [TrackersProvider]'s rebind shape: `onActiveProfileChanged` loads
/// the profile's stored session and rebuilds the catalog client.
///
/// Unlike the OAuth trackers there is no in-provider connect flow — the
/// connect screen drives [SeerrAuthService] itself and hands the finished
/// session to [adoptSession].
class SeerrAccountProvider extends ChangeNotifier with DisposableChangeNotifierMixin {
  SeerrAccountProvider({SeerrSessionStore? store, SeerrAuthService? authService})
    : _store = store ?? const SeerrSessionStore(),
      authService = authService ?? SeerrAuthService();

  final SeerrSessionStore _store;
  final SeerrAuthService authService;

  /// Store writes go through one queue: save() awaits an AES-GCM protect
  /// step, so two rapid unawaited writes could otherwise persist
  /// last-started-first (and a clear could lose to a still-pending save).
  Future<void> _pendingPersistence = Future<void>.value();

  Future<void> _enqueuePersistence(Future<void> Function() op) {
    final run = _pendingPersistence.then((_) => op());
    _pendingPersistence = run.then<void>(
      (_) {},
      onError: (Object e) => appLogger.w('Seerr: session persistence failed', error: e),
    );
    return run;
  }

  SeerrSession? _session;
  String _activeUserUuid = '';
  int _bindingGeneration = 0;
  SeerrClient? _catalogClient;

  SeerrSession? get session => _session;
  bool get isConnected => _session != null;
  String? get displayName => _session?.displayName;

  /// Client for the catalog/request surfaces; null when disconnected.
  SeerrClient? get catalogClient => _catalogClient;

  /// Wired once from the provider tree (the registries live above the
  /// profile session subtree).

  /// Called whenever the active profile changes (or on initial load).
  Future<void> onActiveProfileChanged(String? newUserUuid) async {
    if (isDisposed) return;
    final userUuid = newUserUuid ?? '';
    final generation = ++_bindingGeneration;
    _activeUserUuid = userUuid;
    final loaded = await _store.load(userUuid);
    _setSessionAndRebind(userUuid, generation, loaded);
  }

  /// Persist and bind a session the connect screen established.
  Future<void> adoptSession(SeerrSession session) async {
    final userUuid = _activeUserUuid;
    await _enqueuePersistence(() => _store.save(userUuid, session));
    _setSessionAndRebind(userUuid, ++_bindingGeneration, session);
  }

  /// Sign out server-side (best effort) and clear local state.
  Future<void> disconnect() async {
    final userUuid = _activeUserUuid;
    final session = _session;
    _setSessionAndRebind(userUuid, ++_bindingGeneration, null);
    await _enqueuePersistence(() => _store.clear(userUuid));
    if (session != null) await authService.signOut(session);
  }

  void _setSessionAndRebind(String userUuid, int generation, SeerrSession? session) {
    if (!_isCurrentBinding(userUuid, generation)) return;
    _session = session;
    _catalogClient?.dispose();
    _catalogClient = session == null
        ? null
        : SeerrClient(
            session,
            onSessionInvalidated: () => _handleSessionInvalidated(userUuid, generation),
            onSessionUpdated: (next) => _handleSessionUpdated(userUuid, generation, next),
            authService: authService,
          );
    safeNotifyListeners();
  }

  bool _isCurrentBinding(String userUuid, int generation) {
    return !isDisposed && userUuid == _activeUserUuid && generation == _bindingGeneration;
  }

  void _handleSessionUpdated(String userUuid, int generation, SeerrSession session) {
    if (!_isCurrentBinding(userUuid, generation)) return;
    _session = session;
    unawaited(_enqueuePersistence(() => _store.save(userUuid, session)));
    safeNotifyListeners();
  }

  /// Called by [SeerrClient] when silent re-auth fails permanently: clear
  /// local state so the UI shows "not connected" and the user can re-link.
  void _handleSessionInvalidated(String userUuid, int generation) {
    if (!_isCurrentBinding(userUuid, generation)) return;
    final nextGeneration = ++_bindingGeneration;
    unawaited(_enqueuePersistence(() => _store.clear(userUuid)));
    _setSessionAndRebind(userUuid, nextGeneration, null);
  }

  @override
  void dispose() {
    _catalogClient?.dispose();
    _catalogClient = null;
    super.dispose();
  }
}
