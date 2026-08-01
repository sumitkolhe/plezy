/// Static capability flags advertised by a [MediaServerClient]. UI consults
/// these to gate feature affordances per server.
///
/// These describe what the *backend kind* supports in this app's current
/// implementation — not necessarily what the wire protocol can do. As more
/// Jellyfin features are wired in over time, the corresponding flags flip
/// without changing call sites.
class ServerCapabilities {
  /// Server provides curated recommendation hubs the home screen can use
  /// wholesale. False routes home through per-library hubs instead, so one
  /// capped "Latest" response cannot hide whole library types.
  ///
  /// `JellyfinClient.fetchGlobalHubs` is implemented and tested but stays
  /// unreachable while this is false; flipping it is a product judgement about
  /// how sparse Jellyfin's categorisation is, not a wiring gap.
  final bool richHubs;

  const ServerCapabilities({this.richHubs = false});

  static const ServerCapabilities jellyfin = ServerCapabilities();
}
