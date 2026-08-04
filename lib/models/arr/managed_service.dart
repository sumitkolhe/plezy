import 'dart:convert';

/// The media-management services Harbor connects to alongside Seerr.
enum ManagedServiceKind {
  radarr(apiKeyAuth: true),
  sonarr(apiKeyAuth: true),

  /// The only one that logs in for a session cookie rather than presenting a
  /// key on every request.
  qbittorrent(apiKeyAuth: false);

  const ManagedServiceKind({required this.apiKeyAuth});

  /// Whether credentials are an API key rather than a username and password.
  final bool apiKeyAuth;
}

/// One saved connection. A profile may hold several of a kind — a 4K Radarr
/// beside the main one, an anime Sonarr beside the main one — so connections
/// are a list keyed by [id] rather than one per kind.
///
/// [secret] is the API key or the password; the store protects it through
/// `CredentialVault` at its boundary, so instances in memory hold it plain.
class ManagedServiceConnection {
  final ManagedServiceKind kind;
  final String baseUrl;

  /// Empty for API-key services.
  final String username;
  final String secret;

  /// What the user calls this instance — "Radarr 4K". Falls back to the
  /// instance's own name from `/system/status` when left blank.
  final String name;

  /// What the service called itself when last probed: the instance name for
  /// *arr, the app version for qBittorrent.
  final String label;

  const ManagedServiceConnection({
    required this.kind,
    required this.baseUrl,
    required this.secret,
    this.username = '',
    this.name = '',
    this.label = '',
  });

  /// Kind plus host, so re-adding a host you already have replaces it instead
  /// of quietly creating a duplicate that polls the same server twice.
  String get id => '${kind.name}@$baseUrl';

  /// What the row shows: the user's own name for it, else the instance's, else
  /// the host — never blank.
  String get displayName {
    if (name.isNotEmpty) return name;
    if (label.isNotEmpty) return label;
    return Uri.tryParse(baseUrl)?.host ?? baseUrl;
  }

  ManagedServiceConnection copyWith({String? secret, String? name, String? label}) => ManagedServiceConnection(
    kind: kind,
    baseUrl: baseUrl,
    username: username,
    secret: secret ?? this.secret,
    name: name ?? this.name,
    label: label ?? this.label,
  );

  Map<String, Object?> toJson() => {
    'kind': kind.name,
    'baseUrl': baseUrl,
    if (username.isNotEmpty) 'username': username,
    'secret': secret,
    if (name.isNotEmpty) 'name': name,
    if (label.isNotEmpty) 'label': label,
  };

  static ManagedServiceConnection? fromJson(Map<String, Object?> json) {
    final kind = ManagedServiceKind.values.asNameMap()[json['kind'] as String? ?? ''];
    final baseUrl = json['baseUrl'] as String? ?? '';
    if (kind == null || baseUrl.isEmpty) return null;
    return ManagedServiceConnection(
      kind: kind,
      baseUrl: baseUrl,
      username: json['username'] as String? ?? '',
      secret: json['secret'] as String? ?? '',
      name: json['name'] as String? ?? '',
      label: json['label'] as String? ?? '',
    );
  }

  static String encodeList(List<ManagedServiceConnection> connections) =>
      jsonEncode([for (final connection in connections) connection.toJson()]);

  /// Drops entries it cannot identify rather than failing the whole list: one
  /// corrupt row must not cost you the other three connections.
  static List<ManagedServiceConnection> decodeList(String raw) {
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) return const [];
      return [
        for (final entry in decoded)
          if (entry is Map<String, dynamic>) ?fromJson(entry),
      ];
    } catch (_) {
      return const [];
    }
  }
}

/// Whether a connection is usable, and why not when it isn't. Distinguished
/// from "absent" so an expired key reads as one service to reconnect rather
/// than as an integration that was never set up.
enum ManagedServiceHealth { unknown, reachable, unauthorized, unreachable }
