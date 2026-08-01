/// The URL doesn't point at a reachable, initialized Seerr instance.
class SeerrUrlException implements Exception {
  final String message;
  const SeerrUrlException(this.message);

  @override
  String toString() => 'SeerrUrlException: $message';
}

/// Sign-in or session-refresh failure (bad credentials, revoked session).
/// [SeerrClient] treats this during re-auth as "the server rejected the
/// stored credentials" and unlinks the session.
class SeerrAuthException implements Exception {
  final String message;
  final int? statusCode;
  const SeerrAuthException(this.message, {this.statusCode});

  @override
  String toString() => 'SeerrAuthException: $message${statusCode == null ? '' : ' ($statusCode)'}';
}

/// Non-auth API failure with a server-provided message (e.g. quota
/// exceeded on a request, duplicate request).
class SeerrApiException implements Exception {
  final String message;
  final int statusCode;
  const SeerrApiException(this.message, {required this.statusCode});

  @override
  String toString() => 'SeerrApiException($statusCode): $message';
}
