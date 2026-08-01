import '../media/media_backend.dart';
import '../utils/url_utils.dart';

/// Identifier of a backend kind a [Connection] points at. Lighter-weight than
/// [MediaBackend] for places that only care about persistence/auth shape
/// (e.g. database column values).
enum ConnectionKind {
  jellyfin;

  String get id => switch (this) {
    ConnectionKind.jellyfin => 'jellyfin',
  };

  static ConnectionKind fromId(String id) => switch (id) {
    'jellyfin' => ConnectionKind.jellyfin,
    _ => throw ArgumentError('Unknown ConnectionKind id: $id'),
  };

  MediaBackend get backend => switch (this) {
    ConnectionKind.jellyfin => MediaBackend.jellyfin,
  };
}

/// Health snapshot for a connection. Updated by the orchestrator each time a
/// session is established or refreshed.
enum ConnectionStatus { unknown, online, offline, authError, disabled }

/// A media server connection — a unit of authentication the user added:
/// one server plus the user authenticated against it.
sealed class Connection {
  String get id;
  ConnectionKind get kind;
  String get displayName;
  ConnectionStatus get status;
  DateTime get createdAt;
  DateTime? get lastAuthenticatedAt;

  /// Backend kind as a [MediaBackend] — for UI that branches on backend
  /// (badges, etc.). Just a passthrough to [kind.backend].
  MediaBackend get backend => kind.backend;

  /// Primary label shown in connection-list UIs: the server name.
  String get displayLabel;

  /// Secondary line shown beneath [displayLabel]: `userName · baseUrl`.
  /// May be null when no useful subtitle exists.
  String? get displaySubtitle;

  /// Backend-specific config payload, persisted as JSON. Each subclass
  /// defines the schema.
  Map<String, Object?> toConfigJson();
}

/// A single-server Jellyfin connection.
class JellyfinConnection extends Connection {
  @override
  final String id;

  @override
  final ConnectionStatus status;

  @override
  final DateTime createdAt;

  @override
  final DateTime? lastAuthenticatedAt;

  /// Active server base URL, no trailing slash. e.g. `https://jellyfin.home.lan`.
  final String baseUrl;

  /// Candidate server URLs for this Jellyfin server, with [baseUrl] first.
  /// Existing installs only have [baseUrl]; deserialization backfills this.
  final List<String> baseUrls;

  /// Server's reported name (System/Info).
  final String serverName;

  /// Server's machine identifier (System/Info `Id`).
  final String serverMachineId;

  /// Authenticated Jellyfin user id (UUID).
  final String userId;

  /// Authenticated user's display name.
  final String userName;

  /// Long-lived access token from `/Users/AuthenticateByName`.
  final String accessToken;

  /// Per-device client identifier (same value sent in the
  /// `Authorization: MediaBrowser DeviceId="..."` header).
  final String deviceId;

  /// Whether this user is a Jellyfin admin (`/Users/{id}.Policy.IsAdministrator`).
  /// Captured at auth time so the UI can gate admin-only entries (delete,
  /// match/unmatch, edit metadata) without an extra round-trip.
  final bool isAdministrator;

  JellyfinConnection({
    required this.id,
    required String baseUrl,
    List<String>? baseUrls,
    required this.serverName,
    required this.serverMachineId,
    required this.userId,
    required this.userName,
    required this.accessToken,
    required this.deviceId,
    this.isAdministrator = false,
    this.status = ConnectionStatus.unknown,
    required this.createdAt,
    this.lastAuthenticatedAt,
  }) : baseUrl = canonicalizeBaseUrl(baseUrl),
       baseUrls = _normalizeBaseUrls(baseUrl, baseUrls);

  @override
  ConnectionKind get kind => ConnectionKind.jellyfin;

  @override
  String get displayName => '$userName · $serverName';

  @override
  String get displayLabel => serverName;

  @override
  String? get displaySubtitle {
    final extraCount = baseUrls.length - 1;
    final suffix = extraCount > 0 ? ' +$extraCount' : '';
    return '$userName · ${_truncateUrl(baseUrl)}$suffix';
  }

  static String _truncateUrl(String url) {
    if (url.length <= 40) return url;
    return '${url.substring(0, 37)}…';
  }

  static List<String> _normalizeBaseUrls(String activeBaseUrl, List<String>? urls) {
    final result = <String>[];
    final seen = <String>{};

    void add(String url) {
      final normalized = canonicalizeBaseUrl(url);
      if (normalized.isEmpty || !seen.add(normalized)) return;
      result.add(normalized);
    }

    add(activeBaseUrl);
    for (final url in urls ?? const <String>[]) {
      add(url);
    }
    return List.unmodifiable(result);
  }

  JellyfinConnection copyWith({
    String? id,
    String? baseUrl,
    List<String>? baseUrls,
    String? serverName,
    String? serverMachineId,
    String? userId,
    String? userName,
    String? accessToken,
    String? deviceId,
    bool? isAdministrator,
    ConnectionStatus? status,
    DateTime? createdAt,
    DateTime? lastAuthenticatedAt,
  }) {
    final nextBaseUrl = baseUrl ?? this.baseUrl;
    return JellyfinConnection(
      id: id ?? this.id,
      baseUrl: nextBaseUrl,
      baseUrls: baseUrls ?? this.baseUrls,
      serverName: serverName ?? this.serverName,
      serverMachineId: serverMachineId ?? this.serverMachineId,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      accessToken: accessToken ?? this.accessToken,
      deviceId: deviceId ?? this.deviceId,
      isAdministrator: isAdministrator ?? this.isAdministrator,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      lastAuthenticatedAt: lastAuthenticatedAt ?? this.lastAuthenticatedAt,
    );
  }

  @override
  Map<String, Object?> toConfigJson() {
    return {
      'baseUrl': baseUrl,
      'baseUrls': baseUrls,
      'serverName': serverName,
      'serverMachineId': serverMachineId,
      'userId': userId,
      'userName': userName,
      'accessToken': accessToken,
      'deviceId': deviceId,
      'isAdministrator': isAdministrator,
    };
  }

  factory JellyfinConnection.fromConfigJson({
    required String id,
    required Map<String, Object?> json,
    required ConnectionStatus status,
    required DateTime createdAt,
    DateTime? lastAuthenticatedAt,
  }) {
    final rawBaseUrls = json['baseUrls'];
    final baseUrls = rawBaseUrls is List ? rawBaseUrls.whereType<String>().toList(growable: false) : const <String>[];
    final rawBaseUrl = json['baseUrl'] as String?;
    final baseUrl = rawBaseUrl != null && rawBaseUrl.isNotEmpty
        ? rawBaseUrl
        : (baseUrls.isNotEmpty ? baseUrls.first : '');
    return JellyfinConnection(
      id: id,
      baseUrl: baseUrl,
      baseUrls: baseUrls,
      serverName: json['serverName'] as String? ?? 'Jellyfin',
      serverMachineId: json['serverMachineId'] as String? ?? '',
      userId: json['userId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      accessToken: json['accessToken'] as String? ?? '',
      deviceId: json['deviceId'] as String? ?? '',
      isAdministrator: json['isAdministrator'] as bool? ?? false,
      status: status,
      createdAt: createdAt,
      lastAuthenticatedAt: lastAuthenticatedAt,
    );
  }
}
