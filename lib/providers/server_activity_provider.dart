import 'dart:async';

import 'package:flutter/widgets.dart';

import '../mixins/disposable_change_notifier_mixin.dart';
import '../models/arr/server_transfer.dart';
import '../models/arr/absent_title.dart';
import '../models/arr/managed_service.dart';
import '../services/arr/arr_item_lookup.dart';
import '../services/arr/arr_wanted_service.dart';
import '../services/arr/server_activity_service.dart';
import '../utils/external_ids.dart';
import 'managed_services_provider.dart';

/// Polls the *arr queues and the download client while something is watching.
///
/// One timer for the whole app: five instances times several widgets would
/// otherwise hammer a home server. Nothing polls until [addWatcher] is called,
/// and polling stops when the last watcher leaves or the app backgrounds — a
/// phone in a pocket has no reason to ask.
class ServerActivityProvider extends ChangeNotifier with DisposableChangeNotifierMixin, WidgetsBindingObserver {
  ServerActivityProvider(ManagedServicesProvider services, {ServerActivityService? service})
    : _service = service ?? ServerActivityService(services),
      _lookup = ArrItemLookup(services),
      _services = services {
    WidgetsBinding.instance.addObserver(this);
    _services.addListener(_onServicesChanged);
  }

  final ServerActivityService _service;
  final ArrItemLookup _lookup;
  final ManagedServicesProvider _services;

  static const Duration _interval = Duration(seconds: 5);

  Timer? _timer;
  int _watchers = 0;
  bool _inFlight = false;
  bool _foreground = true;

  List<ServerTransfer> _transfers = const [];
  final Map<ManagedServiceKind, List<AbsentTitle>?> _absent = {};
  List<String> _unreachable = const [];
  bool _loadedOnce = false;

  List<ServerTransfer> get transfers => _transfers;

  /// Instances that failed this poll, by name — shown so a partial list is not
  /// mistaken for an empty queue.
  List<String> get unreachable => _unreachable;

  /// False until the first poll settles, so the UI can tell "nothing yet" from
  /// "nothing queued".
  bool get loadedOnce => _loadedOnce;

  bool get hasServices => _services.connections.isNotEmpty;

  /// Call from a screen that is showing this data; keep the returned callback
  /// and invoke it on dispose.
  VoidCallback addWatcher() {
    _watchers++;
    _syncTimer();
    if (!_loadedOnce) unawaited(refresh());
    var released = false;
    return () {
      if (released) return;
      released = true;
      _watchers--;
      _syncTimer();
    };
  }

  /// Null until [resolveItem] has answered once.
  List<ArrItemState>? itemState(ExternalIds ids, {required bool isSeries}) => _lookup.cached(ids, isSeries: isSeries);

  /// Cached and coalesced, so calling it repeatedly is free.
  Future<void> resolveItem(ExternalIds ids, {required bool isSeries}) async {
    if (_lookup.cached(ids, isSeries: isSeries) != null) return;
    await _lookup.resolve(ids, isSeries: isSeries);
    if (!isDisposed) safeNotifyListeners();
  }

  /// What [kind] has no file for. Null until [resolveAbsent] answers, which a
  /// caller must treat as "not known yet" rather than "nothing missing".
  List<AbsentTitle>? absent(ManagedServiceKind kind) => _absent[kind];

  /// Fetched once per session unless [force]: the wanted list changes when
  /// something imports, not while you scroll a library.
  Future<void> resolveAbsent(ManagedServiceKind kind, {bool force = false}) async {
    if (!hasServices || (_absent[kind] != null && !force)) return;
    final service = ArrWantedService(_services);
    final titles = switch (kind) {
      ManagedServiceKind.radarr => await service.absentMovies(),
      ManagedServiceKind.sonarr => await service.absentEpisodes(),
      ManagedServiceKind.qbittorrent => const <AbsentTitle>[],
    };
    // A null answer leaves this unresolved so the next visit retries, rather
    // than caching an empty list nobody actually reported.
    if (isDisposed || titles == null) return;
    _absent[kind] = titles;
    safeNotifyListeners();
  }

  @visibleForTesting
  void debugSetTransfersForTesting(List<ServerTransfer> transfers) => _transfers = transfers;

  /// Progress for an absent title, which has no external ids to resolve.
  ///
  /// An episode has to match its season and number too: a Sonarr queue record
  /// names the *series*, so mediaId alone would lend one episode's progress to
  /// every other absent episode of the same show.
  ServerTransfer? transferFor(AbsentTitle title) {
    for (final transfer in _transfers) {
      if (transfer.sourceId != title.sourceId) continue;
      final queued = transfer.queued;
      if (queued?.mediaId != title.mediaId) continue;
      if (title.isEpisode &&
          (queued?.seasonNumber != title.seasonNumber || queued?.episodeNumber != title.episodeNumber)) {
        continue;
      }
      return transfer;
    }
    return null;
  }

  /// Null until [resolveEpisodes] has answered.
  List<ArrEpisode>? episodesFor(ArrItemState state) => _lookup.cachedEpisodes(state.sourceId, state.mediaId);

  Future<void> resolveEpisodes(ArrItemState state) async {
    if (_lookup.cachedEpisodes(state.sourceId, state.mediaId) != null) return;
    await _lookup.episodes(state.sourceId, state.mediaId);
    if (!isDisposed) safeNotifyListeners();
  }

  /// Transfers belonging to one *arr record, matched on media id.
  List<ServerTransfer> transfersFor(List<ArrItemState> states) {
    if (states.isEmpty) return const [];
    final keys = {for (final state in states) '${state.sourceId}/${state.mediaId}'};
    return [
      for (final transfer in _transfers)
        if (transfer.queued?.mediaId case final mediaId?)
          if (keys.contains('${transfer.sourceId}/$mediaId')) transfer,
    ];
  }

  Future<void> refresh() async {
    if (_inFlight || !hasServices) return;
    _inFlight = true;
    try {
      final activity = await _service.fetch();
      if (isDisposed) return;
      _transfers = activity.transfers;
      _unreachable = activity.unreachable;
      _loadedOnce = true;
      safeNotifyListeners();
    } finally {
      _inFlight = false;
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _foreground = state == AppLifecycleState.resumed;
    _syncTimer();
    // Coming back after a while, the numbers on screen are stale by definition.
    if (_foreground && _watchers > 0) unawaited(refresh());
  }

  void _onServicesChanged() {
    // A connection change moves what a poll covers and which instance holds
    // what, so both the list and resolved items stop being trustworthy.
    _lookup.clear();
    _absent.clear();
    if (!hasServices) {
      _transfers = const [];
      _unreachable = const [];
      _loadedOnce = false;
      safeNotifyListeners();
    }
    _syncTimer();
    if (hasServices && _watchers > 0) {
      unawaited(refresh());
      // The lists were just invalidated above, and their only other caller is a
      // widget's initState. Without this, connections restored after that widget
      // mounted — an ordinary cold start — left it empty for the whole session,
      // because a kept-alive tab never runs initState again.
      for (final kind in const [ManagedServiceKind.radarr, ManagedServiceKind.sonarr]) {
        unawaited(resolveAbsent(kind));
      }
    }
  }

  void _syncTimer() {
    final shouldPoll = _watchers > 0 && _foreground && hasServices;
    if (shouldPoll == (_timer != null)) return;
    _timer?.cancel();
    _timer = shouldPoll ? Timer.periodic(_interval, (_) => unawaited(refresh())) : null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _services.removeListener(_onServicesChanged);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
