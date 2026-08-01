import '../media/ids.dart';

/// Jellyfin's user-specific cache scope is `{machineId}/{userId}`.
bool isJellyfinUserScopeId({required ServerId serverId, required String cacheServerId}) {
  final userPrefix = '$serverId/';
  return cacheServerId.startsWith(userPrefix) && cacheServerId.length > userPrefix.length;
}

/// Returns the user-specific active client scope, or `null` when the client is
/// absent or only exposes the public server namespace.
String? resolveActiveClientScopeId({required ServerId serverId, required String? cacheServerId}) {
  if (cacheServerId == null) return null;
  return isJellyfinUserScopeId(serverId: serverId, cacheServerId: cacheServerId) ? cacheServerId : null;
}
