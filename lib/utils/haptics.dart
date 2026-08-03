import 'dart:async';

import 'package:flutter/services.dart';

import '../services/settings_service.dart';

/// Touch feedback for choices.
///
/// Flutter's automatic feedback does not cover this: `Feedback.forTap` plays
/// only the click sound on Android, and just `forLongPress` vibrates. Anything
/// else has to ask.
abstract final class Haptics {
  static bool get _enabled => SettingsService.instanceOrNull?.read(SettingsService.hapticFeedback) ?? false;

  /// The light tick for picking something: a row in a sheet, a tab, a toggle.
  static void selection() {
    if (_enabled) unawaited(HapticFeedback.selectionClick());
  }

  /// Android's own long-press effect, which is firmer than [selection] and is
  /// what a held press feels like everywhere else on the device.
  static void longPress() {
    if (_enabled) unawaited(HapticFeedback.vibrate());
  }
}
