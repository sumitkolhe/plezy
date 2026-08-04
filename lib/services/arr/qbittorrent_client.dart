import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/platform_http_client_stub.dart'
    if (dart.library.io) '../../utils/platform_http_client_io.dart'
    as platform;
import 'arr_client.dart' show normalizeServiceUrl;
import 'managed_service_exceptions.dart';

/// qBittorrent's WebUI API, which logs in for an `SID` cookie rather than
/// taking a key per request.
///
/// The cookie expires without warning, so every call re-logs in once on a 403
/// — the same shape `SeerrClient` uses for its Express session.
class QbittorrentClient {
  final String baseUrl;
  final String username;
  final String password;
  final http.Client _http;
  String? _sid;

  QbittorrentClient({
    required String baseUrl,
    required this.username,
    required this.password,
    http.Client? httpClient,
    String? sid,
  }) : baseUrl = normalizeServiceUrl(baseUrl),
       _http = httpClient ?? platform.createPlatformClient(),
       _sid = (sid?.isNotEmpty ?? false) ? sid : null;

  String? get sid => _sid;

  void dispose() => _http.close();

  /// Logs in and returns the app version, which doubles as the row's label.
  Future<String> testConnection() async {
    await login();
    final version = await _send('GET', '/api/v2/app/version');
    return version.trim();
  }

  /// qBittorrent answers a bad login with 200 and the body `Fails.`, not a 401.
  Future<void> login() async {
    final res = await _http.post(
      Uri.parse('$baseUrl/api/v2/auth/login'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded', 'Referer': baseUrl},
      body: {'username': username, 'password': password},
    );
    if (res.statusCode == 403) {
      throw const ManagedServiceAuthException('qBittorrent refused the login (banned IP?)', statusCode: 403);
    }
    if (res.statusCode != 200 || res.body.trim() != 'Ok.') {
      throw const ManagedServiceAuthException('qBittorrent rejected the username or password', statusCode: 401);
    }
    _sid = _captureSid(res) ?? _sid;
  }

  Future<dynamic> getJson(String path, {Map<String, String>? query}) async {
    final body = await _send('GET', path, query: query);
    if (body.isEmpty) return null;
    try {
      return jsonDecode(body);
    } catch (_) {
      throw const ManagedServiceApiException('qBittorrent did not answer with JSON', statusCode: 200);
    }
  }

  Future<String> _send(String method, String path, {Map<String, String>? query, bool retried = false}) async {
    final uri = Uri.parse('$baseUrl$path').replace(queryParameters: query?.isEmpty ?? true ? null : query);
    final res = await _http.get(uri, headers: {if (_sid != null) 'Cookie': 'SID=$_sid', 'Referer': baseUrl});

    // 403 is what an expired or absent session looks like here.
    if (res.statusCode == 403 && !retried) {
      await login();
      return _send(method, path, query: query, retried: true);
    }
    if (res.statusCode == 403) {
      throw const ManagedServiceAuthException('qBittorrent session rejected after re-login', statusCode: 403);
    }
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw ManagedServiceApiException('qBittorrent returned HTTP ${res.statusCode}', statusCode: res.statusCode);
    }
    return res.body;
  }

  /// `package:http` folds repeated Set-Cookie headers into one comma-joined
  /// string; SID values are URL-safe so splitting on `,` is safe.
  String? _captureSid(http.Response res) {
    final raw = res.headers['set-cookie'];
    if (raw == null || raw.isEmpty) return null;
    for (final chunk in raw.split(',')) {
      final trimmed = chunk.trimLeft();
      if (!trimmed.startsWith('SID=')) continue;
      final afterName = trimmed.substring(4);
      final end = afterName.indexOf(';');
      final value = (end == -1 ? afterName : afterName.substring(0, end)).trim();
      if (value.isNotEmpty) return value;
    }
    return null;
  }
}
