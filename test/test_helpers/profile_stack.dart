import 'package:drift/native.dart';
import 'package:plezy/connection/connection_registry.dart';
import 'package:plezy/database/app_database.dart';
import 'package:plezy/profiles/active_profile_provider.dart';
import 'package:plezy/profiles/profile_connection_registry.dart';
import 'package:plezy/profiles/profile_registry.dart';
import 'package:plezy/services/storage_service.dart';

/// The profile dependency graph wired the way production wires it: database →
/// registries → [ActiveProfileProvider].
class ProfileStack {
  ProfileStack._({
    required this.db,
    required this.connections,
    required this.profileConnections,
    required this.profiles,
    required this.active,
    required this._storage,
    required this._ownsDatabase,
  });

  final AppDatabase db;
  final ConnectionRegistry connections;
  final ProfileConnectionRegistry profileConnections;
  final ProfileRegistry profiles;
  final ActiveProfileProvider active;

  final StorageService? _storage;
  final bool _ownsDatabase;

  /// Only wired when the stack was created with `withStorage: true`.
  StorageService get storage => _storage!;

  /// Pass [db] when the test also needs the database for caches or downloads;
  /// the caller then owns closing it.
  static Future<ProfileStack> create({AppDatabase? db, bool withStorage = true}) async {
    final database = db ?? AppDatabase.forTesting(NativeDatabase.memory());
    final connections = ConnectionRegistry(database);
    final profileConnections = ProfileConnectionRegistry(database);
    final profiles = ProfileRegistry(database);
    final storage = withStorage ? await StorageService.getInstance() : null;
    return ProfileStack._(
      db: database,
      connections: connections,
      profileConnections: profileConnections,
      profiles: profiles,
      active: ActiveProfileProvider(registry: profiles, connections: connections, storage: storage),
      storage: storage,
      ownsDatabase: db == null,
    );
  }

  Future<void> dispose() async {
    await active.resetForTesting();
    active.dispose();
    if (_ownsDatabase) await db.close();
  }
}
