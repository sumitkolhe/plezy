import '../exceptions/media_server_exceptions.dart';
import '../utils/media_server_http_client.dart';
import '../utils/device_identity.dart';

/// Connection probes retained from the deleted Plex client.
///
/// [PlexAuthService] races candidate endpoints for a persisted Plex account
/// and needs latency plus reachability, nothing else the client offered.
/// Keeping just these two here is what let the client itself go.
class ConnectionTestResult {
  final bool success;
  final int latencyMs;
  final String? error;

  /// `transcoderVideo` from the `/` MediaContainer, captured on successful
  /// probes so the connection race doubles as a capability probe. `null`
  /// when the probe didn't succeed or the field was absent.
  final bool? transcoderVideo;

  ConnectionTestResult({required this.success, required this.latencyMs, this.error, this.transcoderVideo});
}

bool? _parsePlexTranscoderVideoCapability(Object? value) {
  return switch (value) {
    final bool b => b,
    final int n when n == 1 => true,
    final int n when n == 0 => false,
    final String s when s.trim().toLowerCase() == 'true' || s.trim() == '1' => true,
    final String s when s.trim().toLowerCase() == 'false' || s.trim() == '0' => false,
    _ => null,
  };
}

Future<ConnectionTestResult> testConnectionWithLatency(
  String baseUrl,
  String token, {
  Duration timeout = const Duration(seconds: 5),
  String? clientIdentifier,
}) async {
  // Memoized after the first call — resolve outside the latency window.
  final identity = await DeviceIdentityService.resolve();
  final stopwatch = Stopwatch()..start();
  MediaServerHttpClient? client;

  try {
    client = MediaServerHttpClient(baseUrl: baseUrl, connectTimeout: timeout, receiveTimeout: timeout);

    final headers = <String, String>{'X-Plex-Token': token};
    if (clientIdentifier != null) {
      headers['X-Plex-Client-Identifier'] = clientIdentifier;
      headers['X-Plex-Product'] = 'Plezy';
      headers['X-Plex-Device-Name'] = sanitizeHeaderValue(identity.deviceName) ?? 'Plezy';
    }

    final response = await client.get('/', headers: headers);

    stopwatch.stop();
    final success = response.statusCode == 200;

    bool? transcoderVideo;
    if (success && response.data is Map && response.data['MediaContainer'] is Map) {
      transcoderVideo = _parsePlexTranscoderVideoCapability(
        (response.data['MediaContainer'] as Map)['transcoderVideo'],
      );
    }

    return ConnectionTestResult(
      success: success,
      latencyMs: stopwatch.elapsedMilliseconds,
      error: success ? null : 'HTTP ${response.statusCode}',
      transcoderVideo: transcoderVideo,
    );
  } on MediaServerHttpException catch (e) {
    stopwatch.stop();
    final label = switch (e.type) {
      MediaServerHttpErrorType.connectionTimeout => 'Connection timeout',
      MediaServerHttpErrorType.receiveTimeout => 'Receive timeout',
      MediaServerHttpErrorType.connectionError => 'Connection error',
      _ => e.type.name,
    };
    final message = e.message.trim();
    var error = message.isEmpty ? label : '$label: $message';
    if (e.statusCode != null) {
      error += ' (HTTP ${e.statusCode})';
    }
    return ConnectionTestResult(success: false, latencyMs: stopwatch.elapsedMilliseconds, error: error);
  } catch (e) {
    stopwatch.stop();
    return ConnectionTestResult(success: false, latencyMs: stopwatch.elapsedMilliseconds, error: e.toString());
  } finally {
    client?.close();
  }
}

/// Test connection multiple times and return average latency
Future<ConnectionTestResult> testConnectionWithAverageLatency(
  String baseUrl,
  String token, {
  int attempts = 3,
  Duration timeout = const Duration(seconds: 5),
  String? clientIdentifier,
}) async {
  final results = <ConnectionTestResult>[];

  for (int i = 0; i < attempts; i++) {
    final result = await testConnectionWithLatency(
      baseUrl,
      token,
      timeout: timeout,
      clientIdentifier: clientIdentifier,
    );

    // If any attempt fails, return failed result immediately
    if (!result.success) {
      return ConnectionTestResult(success: false, latencyMs: result.latencyMs);
    }

    results.add(result);
  }

  // Calculate average latency from successful attempts
  final avgLatency = results.fold<int>(0, (sum, result) => sum + result.latencyMs) ~/ results.length;

  return ConnectionTestResult(success: true, latencyMs: avgLatency);
}
