import 'dart:async';

import '../connection/connection.dart';
import '../connection/connection_registry.dart';
import '../services/storage_service.dart';
import 'profile.dart';
import 'profile_connection.dart';
import 'profile_connection_registry.dart';
import 'profile_merge.dart';
import 'profile_registry.dart';

/// Snapshot for picker / manage-profiles UIs: every visible profile plus
/// the data needed to render per-profile connection chips.
class ProfilesView {
  final List<Profile> profiles;

  /// Per-profile borrowed connections.
  final Map<String, List<ProfileConnection>> connectionsByProfile;

  final Map<String, Connection> connectionsById;

  const ProfilesView({required this.profiles, required this.connectionsByProfile, required this.connectionsById});

  static const empty = ProfilesView(profiles: [], connectionsByProfile: {}, connectionsById: {});
}

/// Join-table rows that should be shown as explicit, user-manageable
/// connections for [profile].
///
/// Combine [ProfileRegistry], [ProfileConnectionRegistry] and
/// [ConnectionRegistry] into a single stream.
Stream<ProfilesView> watchProfilesView({
  required ProfileRegistry profiles,
  required ProfileConnectionRegistry profileConnections,
  required ConnectionRegistry connections,
  StorageService? storage,
}) {
  return _combineLatest3<List<Profile>, List<ProfileConnection>, List<Connection>, ProfilesView>(
    profiles.watchProfiles(),
    profileConnections.watchAll(),
    connections.watchConnections(),
    (locals, pcs, conns) => _build(locals: locals, pcs: pcs, conns: conns, storage: storage),
  );
}

ProfilesView _build({
  required List<Profile> locals,
  required List<ProfileConnection> pcs,
  required List<Connection> conns,
  required StorageService? storage,
}) {
  final connectionsById = {for (final c in conns) c.id: c};
  final all = hydrateProfiles(locals: locals, storage: storage);
  return ProfilesView(profiles: all, connectionsByProfile: _groupByProfile(pcs), connectionsById: connectionsById);
}

Map<String, List<ProfileConnection>> _groupByProfile(List<ProfileConnection> pcs) {
  final out = <String, List<ProfileConnection>>{};
  for (final pc in pcs) {
    out.putIfAbsent(pc.profileId, () => []).add(pc);
  }
  return out;
}

/// Lightweight `combineLatest3` — emits the combined value once each input
/// has produced a value, then on every subsequent tick from any input.
Stream<R> _combineLatest3<A, B, C, R>(Stream<A> a, Stream<B> b, Stream<C> c, R Function(A, B, C) combine) {
  late StreamController<R> controller;
  StreamSubscription<A>? subA;
  StreamSubscription<B>? subB;
  StreamSubscription<C>? subC;
  A? lastA;
  B? lastB;
  C? lastC;
  var hasA = false, hasB = false, hasC = false;

  void emit() {
    if (hasA && hasB && hasC) controller.add(combine(lastA as A, lastB as B, lastC as C));
  }

  controller = StreamController<R>(
    onListen: () {
      subA = a.listen((v) {
        lastA = v;
        hasA = true;
        emit();
      }, onError: controller.addError);
      subB = b.listen((v) {
        lastB = v;
        hasB = true;
        emit();
      }, onError: controller.addError);
      subC = c.listen((v) {
        lastC = v;
        hasC = true;
        emit();
      }, onError: controller.addError);
    },
    onCancel: () async {
      await subA?.cancel();
      await subB?.cancel();
      await subC?.cancel();
      await controller.close();
    },
  );
  return controller.stream;
}
