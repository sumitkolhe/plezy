/// The service answered, and said no.
class ManagedServiceApiException implements Exception {
  final String message;
  final int statusCode;

  const ManagedServiceApiException(this.message, {required this.statusCode});

  @override
  String toString() => 'ManagedServiceApiException($statusCode): $message';
}

/// Credentials were rejected — a bad API key, or an expired qBittorrent
/// session that a re-login could not recover.
class ManagedServiceAuthException extends ManagedServiceApiException {
  const ManagedServiceAuthException(super.message, {required super.statusCode});

  @override
  String toString() => 'ManagedServiceAuthException($statusCode): $message';
}
