import 'dart:ui' as ui;

import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/services/app_exit_service.dart';

void main() {
  // The window's close button must run the registered onExitRequested handlers
  // (app-level teardown, including the terminal playback report), which only a
  // cancelable request does — `required` skips them.

  test('a declined graceful exit reports failure so the caller can hard-exit', () async {
    expect(
      await AppExitService.requestGracefulExit(exitApplicationForTesting: (_, _) async => ui.AppExitResponse.cancel),
      isFalse,
    );
  });
}
