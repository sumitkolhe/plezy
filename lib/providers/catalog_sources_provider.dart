import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../mixins/disposable_change_notifier_mixin.dart';
import '../models/catalog/catalog_item.dart';
import '../profiles/profile.dart';
import '../services/base_shared_preferences_service.dart';
import '../services/catalog/catalog_source.dart';
import '../services/catalog/seerr_catalog_source.dart';
import '../services/catalog/trakt_catalog_source.dart';
import '../services/seerr/seerr_client.dart';
import '../services/trackers/trakt/trakt_client.dart';
import 'seerr_account_provider.dart';
import 'trackers_provider.dart';

/// Owns one client/source pair and applies the shared rebind/dispose contract.
class _CatalogSourceBinding<Client extends Object, Source extends CatalogSource> {
  _CatalogSourceBinding(this._create, {bool Function(Client? previous, Client? next)? equals})
    : _equals = equals ?? ((previous, next) => identical(previous, next));

  final Source Function(Client client) _create;
  final bool Function(Client? previous, Client? next) _equals;
  Client? _client;
  Source? source;

  bool update(Client? next) {
    if (_equals(_client, next)) return false;
    final replacement = next == null ? null : _create(next);
    source?.dispose();
    _client = next;
    source = replacement;
    return true;
  }

  void dispose() {
    source?.dispose();
    source = null;
    _client = null;
  }
}

/// Enumerates the connected [CatalogSource]s for the active profile and owns
/// which one the Explore tab shows.
///
/// Profile-scoped. Tracker/Seerr sources are rebuilt through the
/// proxy-provider update hook so every source appears and disappears with its
/// owning account connection (which also drives the Explore tab's visibility).
class CatalogSourcesProvider extends ChangeNotifier with DisposableChangeNotifierMixin {
  final _CatalogSourceBinding<TraktClient, TraktCatalogSource> _trakt = _CatalogSourceBinding(TraktCatalogSource.new);
  final _CatalogSourceBinding<SeerrClient, SeerrCatalogSource> _seerr = _CatalogSourceBinding(SeerrCatalogSource.new);
  int _profileBindingGeneration = 0;
  static const String _activeSourceBaseKey = 'catalog_active_source';
  CatalogSourceId? _preferredSourceId;
  String _activeUserUuid = '';

  List<CatalogSource> get connectedSources => [?_trakt.source, ?_seerr.source];

  bool get hasAnySource => connectedSources.isNotEmpty;

  /// The connected Seerr source, for the request surfaces (detail-screen
  /// Request action and sheet) that need Seerr's client beyond the
  /// [CatalogSource] interface.
  SeerrCatalogSource? get seerrSource => _seerr.source;

  /// The source whose rows the Explore tab shows: the user's persisted pick
  /// when it is still connected, otherwise the first connected source.
  CatalogSource? get activeSource {
    final sources = connectedSources;
    return sources.firstWhereOrNull((s) => s.id == _preferredSourceId) ?? sources.firstOrNull;
  }

  /// The source backing watchlist membership/mutation surfaces (media-detail
  /// action). Independent of [activeSource] so switching the Explore tab to a
  /// watchlist-less source (e.g. a future Seerr) keeps the action alive.
  CatalogSource? get watchlistCapableSource => connectedSources.firstWhereOrNull((s) => s.supportsWatchlist);

  /// All connected sources whose watchlist can be read and mutated, for
  /// surfaces that offer a choice (media-detail bookmark with several
  /// providers connected).
  List<CatalogSource> get watchlistCapableSources => [...connectedSources.where((source) => source.supportsWatchlist)];

  /// The watchlist source catalog-item surfaces (detail screen, card menu)
  /// must bind to: the item's OWN source — a MAL card toggles the MAL Plan to
  /// Watch, never another provider's list. An item whose source is connected
  /// but has no watchlist (Seerr) gets none at all — no falling back to
  /// another provider's list. The fallback exists only for items whose
  /// source got disconnected mid-session.
  CatalogSource? watchlistSourceFor(CatalogItem item) {
    final own = connectedSources.firstWhereOrNull((s) => s.id == item.source);
    if (own != null) return own.supportsWatchlist ? own : null;
    return watchlistCapableSource;
  }

  /// Hydrate the per-profile active-source preference.
  Future<void> onActiveProfileChanged(String? userUuid) async {
    final generation = ++_profileBindingGeneration;
    _activeUserUuid = userUuid ?? '';
    final prefs = await BaseSharedPreferencesService.sharedCache();
    final raw = prefs.getString(profileScopedPrefsKey(_activeUserUuid, _activeSourceBaseKey));
    if (isDisposed || generation != _profileBindingGeneration) return;

    _preferredSourceId = CatalogSourceId.values.asNameMap()[raw];
    safeNotifyListeners();
  }

  Future<void> setActiveSource(CatalogSourceId id) async {
    if (_preferredSourceId == id) return;
    _preferredSourceId = id;
    safeNotifyListeners();
    final prefs = await BaseSharedPreferencesService.sharedCache();
    await prefs.setString(profileScopedPrefsKey(_activeUserUuid, _activeSourceBaseKey), id.name);
  }

  /// Proxy-provider update hook: rebuild a source when its catalog client
  /// was rebound (connect/disconnect/profile switch).
  void update(TrackersProvider trackers, SeerrAccountProvider seerr) {
    var changed = false;
    changed = _trakt.update(trackers.traktCatalogClient) || changed;
    changed = _seerr.update(seerr.catalogClient) || changed;
    if (changed) safeNotifyListeners();
  }

  @override
  void dispose() {
    _trakt.dispose();
    _seerr.dispose();
    super.dispose();
  }
}
