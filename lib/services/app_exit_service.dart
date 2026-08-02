import 'dart:io' show Platform;
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import '../utils/platform_detector.dart';

typedef AppExitApplication = Future<ui.AppExitResponse> Function(ui.AppExitType exitType, int exitCode);

class AppExitService {
  static const MethodChannel _channel = MethodChannel('co.sumit.harbor/app_exit');

  /// Requests that the host platform closes or backgrounds the app.
  ///
  /// tvOS has no public API for force-quitting or going Home, so callers that
  /// handle a physical back/Menu key should let the event continue instead.
  static Future<bool> requestExit({AppExitApplication? exitApplicationForTesting}) async {
    if (PlatformDetector.isAppleTV()) return false;

    if (Platform.isAndroid) {
      try {
        return await _channel.invokeMethod<bool>('requestExit') ?? true;
      } on MissingPluginException {
        await SystemNavigator.pop();
        return true;
      } on PlatformException {
        await SystemNavigator.pop();
        return true;
      }
    }

    await SystemNavigator.pop();
    return true;
  }

  /// Requests a *cancelable* exit so registered `onExitRequested` handlers run
  /// before the process goes away — app-level teardown depends on it, including
  /// the terminal playback report for trackers that own their own watched
  /// semantics.
  ///
  /// Always false: the cancelable exit handshake was a desktop shell feature,
  /// so callers fall through to their hard-exit path.
  static Future<bool> requestGracefulExit({AppExitApplication? exitApplicationForTesting}) async => false;
}
