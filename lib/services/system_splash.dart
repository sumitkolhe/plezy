import 'package:flutter/services.dart';

import '../utils/app_logger.dart';

/// Lets Android drop the system splash it is holding over Flutter's startup.
///
/// The hold caps out on its own, so a failure here costs a slightly longer
/// splash and nothing else — which is why it is swallowed rather than surfaced.
Future<void> releaseSystemSplash() async {
  try {
    await const MethodChannel('co.sumit.harbor/splash').invokeMethod<void>('release');
  } on PlatformException catch (e) {
    appLogger.w('Could not release the system splash', error: e);
  } on MissingPluginException {
    // Not Android, or an engine without the host side attached.
  }
}
