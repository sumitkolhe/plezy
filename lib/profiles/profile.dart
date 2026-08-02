import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';

/// Top-level profile — the user-facing identity in the app, with an
/// optional 4-digit PIN.
///
/// A profile owns 1+ connections via the `profile_connections` join table.
/// The join row carries the per-profile user-level token used to talk to
/// each connection.
@freezed
sealed class Profile with _$Profile {
  const Profile._();

  const factory Profile.local({
    required String id,
    required String displayName,
    String? avatarThumbUrl,

    /// Hashed PIN if set. The raw PIN is never persisted; see [computePinHash].
    String? pinHash,
    @Default(0) int sortOrder,
    required DateTime createdAt,
    DateTime? lastUsedAt,
  }) = LocalProfile;

  factory Profile.fromRow({
    required String id,
    required String kind,
    required String displayName,
    required String? avatarThumbUrl,
    required Map<String, Object?> json,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime? lastUsedAt,
  }) {
    ProfileKind.fromId(kind);
    return Profile.local(
      id: id,
      displayName: displayName,
      avatarThumbUrl: avatarThumbUrl,
      pinHash: json['pinHash'] as String?,
      sortOrder: sortOrder,
      createdAt: createdAt,
      lastUsedAt: lastUsedAt,
    );
  }

  ProfileKind get kind => ProfileKind.local;

  /// True when entering this profile requires a user-supplied PIN.
  bool get isPinProtected => switch (this) {
    LocalProfile(:final pinHash) => pinHash != null && pinHash.isNotEmpty,
  };

  @override
  String? get pinHash => switch (this) {
    LocalProfile(:final pinHash) => pinHash,
  };

  Map<String, Object?> toConfigJson() => switch (this) {
    LocalProfile(:final pinHash) => {'pinHash': pinHash},
  };
}

enum ProfileKind {
  local;

  String get id => switch (this) {
    ProfileKind.local => 'local',
  };

  static ProfileKind fromId(String id) => switch (id) {
    'local' => ProfileKind.local,
    _ => throw ArgumentError('Unknown ProfileKind id: $id'),
  };
}

/// Salted SHA-256 of the PIN. The salt is fixed (per-app) — this is a
/// social-barrier hash, not real authentication. The threat model is
/// "kid bypassing parent's profile", not "adversary with device access".
const _pinSalt = 'harbor-app-profile-pin-v1';

String computePinHash(String rawPin) {
  final digest = sha256.convert(utf8.encode('$_pinSalt:$rawPin'));
  return digest.toString();
}

bool verifyPin(String rawPin, String hash) {
  return computePinHash(rawPin) == hash;
}

/// THE builder for profile-scoped prefs keys: `user_{scope}_{baseKey}`, or
/// the bare [baseKey] for the empty (signed-out/account-level) scope.
String profileScopedPrefsKey(String userUuid, String baseKey) =>
    userUuid.isEmpty ? baseKey : 'user_${userUuid}_$baseKey';
