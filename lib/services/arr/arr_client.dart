import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/arr/managed_service.dart';
import '../../utils/platform_http_client_stub.dart'
    if (dart.library.io) '../../utils/platform_http_client_io.dart'
    as platform;
import 'managed_service_exceptions.dart';

/// Radarr and Sonarr, which speak the same v3 API with different resource
/// nouns, authenticated by an `X-Api-Key` header.
class ArrClient {
  final ManagedServiceKind kind;
  final String baseUrl;
  final String apiKey;
  final http.Client _http;

  ArrClient({required this.kind, required String baseUrl, required this.apiKey, http.Client? httpClient})
    : baseUrl = normalizeServiceUrl(baseUrl),
      _http = httpClient ?? platform.createPlatformClient();

  void dispose() => _http.close();

  static const String _apiPrefix = '/api/v3';

  /// The instance's own name for itself, and proof the key works.
  ///
  /// Throws [ManagedServiceAuthException] on a rejected key so the caller can
  /// tell "wrong key" from "wrong host".
  Future<String> testConnection() async {
    final data = await get('/system/status');
    if (data is! Map<String, dynamic>) return '';
    final name = data['instanceName'] as String?;
    if (name != null && name.isNotEmpty) return name;
    final version = data['version'];
    return version is String ? version : '';
  }

  Future<dynamic> get(String path, {Map<String, String>? query}) async {
    final uri = Uri.parse('$baseUrl$_apiPrefix$path').replace(queryParameters: query?.isEmpty ?? true ? null : query);
    final res = await _http.get(uri, headers: _headers);
    return _decode(res);
  }

  Future<dynamic> post(String path, Object? body) async {
    final res = await _http.post(
      Uri.parse('$baseUrl$_apiPrefix$path'),
      headers: {..._headers, 'Content-Type': 'application/json'},
      body: body == null ? null : jsonEncode(body),
    );
    return _decode(res);
  }

  Future<dynamic> put(String path, Object? body) async {
    final res = await _http.put(
      Uri.parse('$baseUrl$_apiPrefix$path'),
      headers: {..._headers, 'Content-Type': 'application/json'},
      body: body == null ? null : jsonEncode(body),
    );
    return _decode(res);
  }

  Map<String, String> get _headers => {'X-Api-Key': apiKey, 'Accept': 'application/json'};

  dynamic _decode(http.Response res) {
    final code = res.statusCode;
    if (code == 401 || code == 403) {
      throw ManagedServiceAuthException('${kind.name} rejected the API key', statusCode: code);
    }
    if (code < 200 || code >= 300) {
      throw ManagedServiceApiException('${kind.name} returned HTTP $code', statusCode: code);
    }
    if (res.body.isEmpty) return null;
    try {
      return jsonDecode(res.body);
    } catch (_) {
      // An HTML body on a 200 means the host is something else entirely — a
      // reverse proxy landing page, or *arr's own UI at the wrong base path.
      throw ManagedServiceApiException('${kind.name} did not answer with JSON', statusCode: code);
    }
  }
}

/// Trim whitespace and trailing slashes so a saved URL and a request URL agree
/// on one canonical form, matching `SeerrHttpClient.normalizeBaseUrl`.
String normalizeServiceUrl(String input) {
  var value = input.trim();
  while (value.endsWith('/')) {
    value = value.substring(0, value.length - 1);
  }
  if (value.isEmpty) return value;
  if (!value.startsWith('http://') && !value.startsWith('https://')) value = 'http://$value';
  return value;
}
