import 'dart:io' show HttpClient, Platform;

import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import 'app_logger.dart';
import 'managed_http_client.dart';

/// Shared Cronet engine so all clients reuse the same connection pool.
CronetEngine? _sharedEngine;
bool _cronetBroken = false;

bool _loggedPlatformClient = false;

void _logPlatformClient(String platform, String client) {
  if (_loggedPlatformClient) return;
  _loggedPlatformClient = true;
  appLogger.i('Platform HTTP client', error: {'platform': platform, 'client': client});
}

http.Client _createTunedIoClient(String debugLabel) {
  return ManagedHttpClient(
    IOClient(
      HttpClient()
        ..maxConnectionsPerHost = 12
        ..idleTimeout = const Duration(seconds: 90),
    ),
    debugLabel: debugLabel,
  );
}

http.Client createPlatformClient() {
  if (Platform.isAndroid) {
    if (!_cronetBroken) {
      try {
        _sharedEngine ??= CronetEngine.build(
          cacheMode: CacheMode.memory,
          cacheMaxSize: 2 * 1024 * 1024,
          enableBrotli: true,
          enableHttp2: true,
        );
        _logPlatformClient('android', 'CronetClient');
        return ManagedHttpClient(CronetClient.fromCronetEngine(_sharedEngine!), debugLabel: 'CronetClient');
      } catch (e, st) {
        _cronetBroken = true;
        _sharedEngine = null;
        appLogger.w('CronetClient init failed, falling back to IOClient', error: e, stackTrace: st);
      }
    }
    _logPlatformClient('android', 'IOClient (Android fallback)');
    return _createTunedIoClient('IOClient (Android fallback)');
  }
  if (Platform.isIOS) {
    try {
      final client = CupertinoClient.defaultSessionConfiguration();
      _logPlatformClient('ios', 'CupertinoClient');
      return ManagedHttpClient(client, debugLabel: 'CupertinoClient');
    } catch (e, st) {
      appLogger.w('CupertinoClient init failed, falling back to IOClient', error: e, stackTrace: st);
      _logPlatformClient('ios', 'IOClient (fallback)');
      return ManagedHttpClient(IOClient(), debugLabel: 'IOClient (fallback)');
    }
  }
  // The macOS test host lands here; it has no native client wired up.
  _logPlatformClient(Platform.operatingSystem, 'IOClient');
  return ManagedHttpClient(IOClient(), debugLabel: 'IOClient');
}
