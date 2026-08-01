import 'dart:async';
import '../media/ids.dart';

import 'package:flutter/foundation.dart';

import '../connection/connection.dart';
import '../connection/connection_registry.dart';
import '../providers/multi_server_provider.dart';
import '../services/multi_server_manager.dart';
import '../utils/app_logger.dart';
import 'active_profile_provider.dart';
import 'profile.dart';
import 'profile_connection.dart';
import 'profile_connection_registry.dart';

typedef ShouldDeferInitialBind = FutureOr<bool> Function(Profile profile);

class _ProfileBindResult {
  const _ProfileBindResult({required this.visibleServerIds, required this.expectedServerIds});

  const _ProfileBindResult.empty() : visibleServerIds = const {}, expectedServerIds = const {};

  _ProfileBindResult.visible(Set<String> ids)
    : visibleServerIds = Set.unmodifiable(ids),
      expectedServerIds = Set.unmodifiable(ids);

  final Set<String> visibleServerIds;
  final Set<String> expectedServerIds;
}

/// An empty bound set is propagated as `{}` so a profile with no connections
/// shows nothing — falling back to "all visible" would leak servers attached
/// to other profiles.
class ActiveProfileBinder {
  ActiveProfileBinder({
    required this.activeProfile,
    required this.connections,
    required this.profileConnections,
    required this.serverManager,
    required this.multiServerProvider,
    this.shouldDeferInitialBind,
  });

  final ActiveProfileProvider activeProfile;
  final ConnectionRegistry connections;
  final ProfileConnectionRegistry profileConnections;
  final MultiServerManager serverManager;
  final MultiServerProvider multiServerProvider;
  final ShouldDeferInitialBind? shouldDeferInitialBind;

  bool _started = false;
  bool _isSwitching = false;
  String? _lastBoundProfileId;
  String? _bindingProfileId;

  /// Profile whose most recent bind failed (PIN cancel, offline, error).
  /// Passive provider notifications must not retry it — mid-session retries
  /// bypass the token cache, so a protected Plex Home profile would pop a
  /// PIN dialog with no user action. Explicit paths ([rebindActive], a
  /// user-initiated activation, a pre-verified switch) clear the marker.
  String? _lastFailedProfileId;
  bool _pendingRebind = false;
  // Set when something asks for a rebind of the *currently-active* profile
  // while a rebind is already in flight. The normal `_pendingRebind` path
  // only loops when the active id has drifted — this flag covers same-id
  // re-runs, e.g. after a borrow upserts a new join row.
  bool _pendingSameIdRebind = false;
  int _bindGeneration = 0;

  /// True after the binder has successfully bound at least one profile in
  /// this session. Once set, subsequent rebinds bypass the user-token
  /// cache and always call `/home/users/{uuid}/switch` — that round-trip
  /// is the only way Plex re-validates the user's PIN. Cold-start auto-resume
  /// still uses the cache unless the user enabled profile selection on open.
  bool _hasBoundOnce = false;

  /// Plex Home profile ids whose PIN was just verified by the activation
  /// UI via a successful `/home/users/{uuid}/switch` round-trip. Consumed
  /// once by [_bindPlexHome] to permit the freshly cached user-token for
  /// that single rebind and avoid a duplicate PIN prompt.
  final Set<String> _plexHomePreVerified = {};
  final Set<String> _userInitiatedActivations = {};

  @visibleForTesting
  String? get debugLastBoundProfileId => _lastBoundProfileId;

  void markUserInitiatedActivation(String profileId) {
    _userInitiatedActivations.add(profileId);
    if (_lastFailedProfileId == profileId) _lastFailedProfileId = null;
  }

  @visibleForTesting
  bool consumeUserInitiatedActivation(String profileId) {
    return _userInitiatedActivations.remove(profileId);
  }

  void start() {
    if (_started) return;
    _started = true;
    // Flip `isBinding` before anything else: callers navigate right after
    // start(), and screens (DiscoverScreen's no-servers gate) read the flag
    // synchronously during their first build. Deferring the mark to the
    // microtask below leaves a started-but-flag-false gap in which the gate
    // throws "No servers available" on fresh login. Marking before
    // addListener keeps the binder's own listener from reacting to this
    // notification — the microtask stays the single initial-rebind entry.
    activeProfile.markBindingStarted();
    activeProfile.addListener(_onActiveProfileChanged);
    // Callers invoke start() from async contexts after the offline decision
    // has been made (SetupScreen, MainScreen post-frame, AuthScreen). The
    // microtask keeps the initial rebind — and any PIN prompt it pops — out
    // of the caller's current frame.
    scheduleMicrotask(() {
      if (!_started) {
        // Disposed before the rebind could run — settle the flag we set
        // above so awaitBindingSettle callers aren't stranded.
        activeProfile.markBindingFinished(success: true);
        return;
      }
      unawaited(_rebind());
    });
  }

  void _onActiveProfileChanged() {
    final id = activeProfile.activeId;
    if (_isSwitching) {
      // Ignore our own markBindingStarted/markBindingFinished
      // notifications. They don't mean the active profile changed, and a
      // failed bind intentionally leaves `_lastBoundProfileId` unset so the
      // same profile can be retried later.
      if (id == _bindingProfileId) {
        // The active id can briefly move away and back while this pass is
        // awaiting multiple connection binds. Any component that observed the
        // intermediate id may already have returned an empty stale result, so
        // the current pass cannot be committed as the final same-id bind.
        if (_pendingRebind) _pendingSameIdRebind = true;
        return;
      }
      // A rebind is already in flight — flag a follow-up so the loop in
      // [_rebind] picks up the new active id once the current pass settles.
      // Otherwise the switch is silently dropped (the early-return on
      // `_isSwitching` would leave storage saying B is active while the
      // binder is still wired to A).
      _pendingRebind = true;
      return;
    }
    if (id == _lastBoundProfileId) return;
    // Don't retry a failed profile from a passive notification — see
    // [_lastFailedProfileId]. A different profile id still rebinds.
    if (id != null && id == _lastFailedProfileId) return;
    unawaited(_rebind());
  }

  /// Force the binder to re-run for the currently-active profile, even
  /// when the active id hasn't changed. Used by flows that mutate the
  /// active profile's connection set in-place — e.g. the borrow screen
  /// upserts a new join row and needs the binder to pick it up so the new
  /// server's libraries appear without an app restart.
  ///
  /// Safe to call while a rebind is in flight; the request is queued and
  /// the loop runs an extra pass when the current one settles.
  Future<void> rebindActive() async {
    _lastFailedProfileId = null;
    if (_isSwitching) {
      _pendingSameIdRebind = true;
      return;
    }
    await _rebind();
  }

  /// Convenience: rebind only when [profileId] matches the active profile.
  /// No-op otherwise — the change will be picked up on next activation.
  /// Use this from screens that mutate a specific profile's connections.
  Future<void> rebindIfActive(String profileId) async {
    if (activeProfile.activeId != profileId) return;
    await rebindActive();
  }

  Future<void> _rebind() async {
    if (_isSwitching) return;
    _isSwitching = true;
    // Binding is marked per CYCLE, not per pass: `awaitBindingSettle`
    // waiters must observe the FINAL outcome. Settling between passes hands
    // a caller who activated profile B mid-pass the outcome of profile A's
    // pass — reporting a switch as succeeded/failed before B's bind ran.
    _bindingProfileId = activeProfile.activeId;
    activeProfile.markBindingStarted();
    var success = false;
    try {
      do {
        _pendingRebind = false;
        _pendingSameIdRebind = false;
        success = await _runRebindOnce();
        // Loop only when the active id has drifted to something we haven't
        // bound yet, OR when an explicit same-id rebind was queued (borrow
        // / connection-list mutation while a rebind was in flight). Bare
        // `_pendingRebind` would spin forever if the user taps the active
        // profile while we're binding (id matches, no work to do, flag
        // re-asserts).
      } while (_pendingSameIdRebind || (_pendingRebind && activeProfile.activeId != _lastBoundProfileId));
    } finally {
      // Notify while `_isSwitching`/`_bindingProfileId` still attribute the
      // notification to this cycle — otherwise the binder's own listener
      // would treat it as an external change and immediately re-rebind.
      activeProfile.markBindingFinished(success: success);
      _bindingProfileId = null;
      _isSwitching = false;
    }
  }

  Future<bool> _runRebindOnce() async {
    _bindingProfileId = activeProfile.activeId;
    final generation = ++_bindGeneration;
    final stopwatch = Stopwatch()..start();
    var success = false;
    String? attemptedProfileId;
    try {
      final profile = activeProfile.active;
      if (profile == null) {
        // No active profile is a valid quiescent state (e.g. fresh sign-in
        // before the picker fires) — report success so the picker, if it's
        // waiting, doesn't surface a spurious "switch failed" error. Also
        // clear the runtime filter so stale clients from the previous
        // profile cannot leak into the no-selection state.
        _clearBoundServers();
        success = true;
        return success;
      }
      attemptedProfileId = profile.id;

      final userInitiated = consumeUserInitiatedActivation(profile.id);
      if (!userInitiated && !_hasBoundOnce && await _shouldDeferInitialBind(profile)) {
        appLogger.i('ActiveProfileBinder: deferring initial bind for ${profile.displayName} until profile selection');
        _clearBoundServers();
        attemptedProfileId = null;
        success = true;
        return success;
      }

      appLogger.i('ActiveProfileBinder: rebinding for ${profile.displayName} (${profile.id})');

      // One snapshot of the join rows + connections per pass — every
      // downstream helper reads from these instead of re-querying (each
      // registry read pays per-row CredentialVault reveals).
      final joinRows = await profileConnections.listForProfile(profile.id);
      final connectionsById = {for (final c in await connections.list()) c.id: c};
      if (!_isCurrentBind(profile.id, generation)) return false;

      // PIN prompts may only surface from a user-initiated bind or the
      // session's initial bind (cold-start resume). Passive rebinds — an
      // hourly Plex Home refresh, an unrelated table write — must never pop
      // a modal PIN dialog over whatever the user is doing.
      final allowPinPrompt = userInitiated || !_hasBoundOnce;

      final expectedServerIds = _expectedServerIdsForProfile(
        profile,
        joinRows: joinRows,
        connectionsById: connectionsById,
      );
      multiServerProvider.setExpectedVisibleServerIds(expectedServerIds);
      final localProfileHasJoinRows = profile.isLocal && joinRows.isNotEmpty;

      final results = await Future.wait([
        _bindJoinRows(
          profile,
          joinRows: joinRows,
          connectionsById: connectionsById,
          allowPinPrompt: allowPinPrompt,
          generation: generation,
        ),
      ]);
      if (!_isCurrentBind(profile.id, generation)) return false;
      final visibleServerIds = <String>{};
      for (final result in results) {
        visibleServerIds.addAll(result.visibleServerIds);
        expectedServerIds.addAll(result.expectedServerIds);
      }

      // Remove servers the profile no longer has access to. Always set the
      // filter to the bound set (even when empty) so a profile with no
      // connections shows nothing — falling back to "all visible" on empty
      // would leak servers attached to other profiles.
      for (final serverId in serverManager.serverIds.toList()) {
        if (!visibleServerIds.contains(serverId)) {
          serverManager.removeServer(ServerId(serverId));
        }
      }
      multiServerProvider.setExpectedVisibleServerIds(expectedServerIds);
      multiServerProvider.setVisibleServerIds(visibleServerIds);
      success = (profile.isLocal && !localProfileHasJoinRows) || visibleServerIds.isNotEmpty;
      // Once we've bound a profile with real servers in this session,
      // we've crossed the cold-start boundary — every subsequent rebind
      // is a user-initiated switch and must re-prompt for PIN where
      // applicable. See [_hasBoundOnce] for the security rationale.
      if (success) _hasBoundOnce = true;
    } catch (e, st) {
      appLogger.e('ActiveProfileBinder: rebind failed', error: e, stackTrace: st);
      success = false;
    } finally {
      if (success) {
        _lastBoundProfileId = attemptedProfileId;
        _lastFailedProfileId = null;
      } else {
        if (_lastBoundProfileId == attemptedProfileId) {
          _lastBoundProfileId = null;
        }
        _lastFailedProfileId = attemptedProfileId;
      }
      appLogger.i(
        'ActiveProfileBinder: rebind settled',
        error: {'profileId': attemptedProfileId, 'success': success, 'elapsedMs': stopwatch.elapsedMilliseconds},
      );
    }
    return success;
  }

  /// Server ids the profile should reach once bound: its join rows plus the
  /// implicit Plex Home parent, which normally has no row. Not shared with
  /// `_serverIdsForProfile` (profile_connection_cleanup.dart) — that one is
  /// join-rows-only and [ServerId]-typed, while this set keeps growing with
  /// bind results and is compared against the manager's raw string ids.
  Set<String> _expectedServerIdsForProfile(
    Profile profile, {
    required List<ProfileConnection> joinRows,
    required Map<String, Connection> connectionsById,
  }) {
    final expected = <String>{};
    for (final pc in joinRows) {
      switch (connectionsById[pc.connectionId]) {
        case PlexAccountConnection(:final servers):
          expected.addAll(servers.map((server) => server.clientIdentifier));
        case JellyfinConnection(:final serverMachineId):
          expected.add(serverMachineId);
        case null:
          break;
      }
    }
    return expected;
  }

  /// Bind every [ProfileConnection] row for [profile]. Used by both kinds:
  /// for local profiles, this is the entire bind. For plex_home profiles,
  /// this handles connections borrowed on top of the parent account (the
  /// parent itself is bound by [_bindPlexHome] and is implicit — not in the
  /// join table). Skips Plex rows whose `connectionId` matches the parent
  /// (defensive guard — sync code shouldn't insert one, but treating it as
  /// a borrow would re-mint a redundant token).
  Future<_ProfileBindResult> _bindJoinRows(
    Profile profile, {
    required List<ProfileConnection> joinRows,
    required Map<String, Connection> connectionsById,
    required bool allowPinPrompt,
    required int generation,
  }) async {
    if (joinRows.isEmpty) {
      if (profile.isLocal) {
        appLogger.w('ActiveProfileBinder: ${profile.displayName} has no connections');
      }
      return const _ProfileBindResult.empty();
    }
    final visible = <String>{};
    final expected = <String>{};
    final futures = <Future<_ProfileBindResult>>[];
    for (final pc in joinRows) {
      final conn = connectionsById[pc.connectionId];
      if (conn == null) {
        appLogger.w('ActiveProfileBinder: missing connection ${pc.connectionId} for ${profile.displayName}');
        continue;
      }
      // Connection keeps its Plex arm for persisted rows; nothing binds them.
      if (conn case JellyfinConnection()) {
        expected.add(conn.serverMachineId);
        futures.add(_bindJellyfin(conn, profileId: profile.id, generation: generation));
      }
    }
    final results = await Future.wait(futures);
    for (final result in results) {
      visible.addAll(result.visibleServerIds);
      expected.addAll(result.expectedServerIds);
    }
    return _ProfileBindResult(visibleServerIds: visible, expectedServerIds: expected);
  }

  Future<_ProfileBindResult> _bindJellyfin(
    JellyfinConnection conn, {
    required String profileId,
    required int generation,
  }) async {
    final ok = await serverManager.addJellyfinConnection(conn);
    if (!_isCurrentBind(profileId, generation)) {
      return _ProfileBindResult(visibleServerIds: const {}, expectedServerIds: {conn.serverMachineId});
    }
    // `addJellyfinConnection` registers the client even when the health probe
    // returns authError. Keep that server in the active profile's visibility
    // filter so the re-auth banner can surface it instead of hiding it as if
    // the profile had no server.
    if (ok || serverManager.authErrorServerIds.contains(conn.serverMachineId)) {
      return _ProfileBindResult.visible({conn.serverMachineId});
    }
    return _ProfileBindResult(visibleServerIds: const {}, expectedServerIds: {conn.serverMachineId});
  }

  bool _isCurrentBind(String profileId, int generation) {
    return _bindGeneration == generation && activeProfile.activeId == profileId;
  }

  Future<bool> _shouldDeferInitialBind(Profile profile) async {
    final shouldDefer = shouldDeferInitialBind;
    if (shouldDefer == null) return false;
    try {
      return await shouldDefer(profile);
    } catch (e, st) {
      appLogger.w('ActiveProfileBinder: defer check failed; continuing with bind', error: e, stackTrace: st);
      return false;
    }
  }

  void _clearBoundServers() {
    for (final serverId in serverManager.serverIds.toList()) {
      serverManager.removeServer(ServerId(serverId));
    }
    multiServerProvider.setExpectedVisibleServerIds(<String>{});
    multiServerProvider.setVisibleServerIds(<String>{});
  }

  void dispose() {
    _bindGeneration++;
    if (!_started) return;
    activeProfile.removeListener(_onActiveProfileChanged);
    _plexHomePreVerified.clear();
    _userInitiatedActivations.clear();
    _lastFailedProfileId = null;
    _started = false;
  }
}
