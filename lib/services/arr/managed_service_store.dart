import '../../models/arr/managed_service.dart';
import '../../profiles/profile.dart';
import '../base_shared_preferences_service.dart';
import '../credential_vault.dart';

/// Per-profile persistence for [ManagedServiceConnection]s, scoped the way
/// `SeerrSessionStore` scopes its session.
///
/// One key holds the whole list, so several instances of a kind cost no extra
/// bookkeeping and their order is stable.
class ManagedServiceStore {
  static const String _baseKey = 'managed_services';

  const ManagedServiceStore();

  String _scopedKey(String userUuid) => profileScopedPrefsKey(userUuid, _baseKey);

  Future<List<ManagedServiceConnection>> load(String userUuid) async {
    final prefs = await BaseSharedPreferencesService.sharedCache();
    final raw = prefs.getString(_scopedKey(userUuid));
    if (raw == null) return const [];
    final stored = ManagedServiceConnection.decodeList(raw);
    return [
      for (final connection in stored)
        // A failed decrypt degrades to an empty secret rather than dropping the
        // connection: the host stays on screen so its row can say "reconnect".
        if (connection.secret.isEmpty)
          connection
        else
          connection.copyWith(secret: await CredentialVault.reveal(connection.secret) ?? ''),
    ];
  }

  Future<void> save(String userUuid, List<ManagedServiceConnection> connections) async {
    final prefs = await BaseSharedPreferencesService.sharedCache();
    final protected = [
      for (final connection in connections)
        if (connection.secret.isEmpty)
          connection
        else
          connection.copyWith(secret: await CredentialVault.protect(connection.secret)),
    ];
    await prefs.setString(_scopedKey(userUuid), ManagedServiceConnection.encodeList(protected));
  }

  Future<void> clear(String userUuid) async {
    final prefs = await BaseSharedPreferencesService.sharedCache();
    await prefs.remove(_scopedKey(userUuid));
  }
}
