import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';

/// Get the replay icon based on the duration
/// Returns numbered icons (replay_5, replay_10, replay_30) when available,
/// otherwise returns generic replay icon
IconData getReplayIcon(int seconds) {
  switch (seconds) {
    case 5:
      return PhosphorIconsRegular.arrowCounterClockwise;
    case 10:
      return PhosphorIconsRegular.arrowCounterClockwise;
    case 30:
      return PhosphorIconsRegular.arrowCounterClockwise;
    default:
      return PhosphorIconsRegular.arrowCounterClockwise;
  }
}

/// Get the forward icon based on the duration
/// Returns numbered icons (forward_5, forward_10, forward_30) when available,
/// otherwise returns generic forward icon
IconData getForwardIcon(int seconds) {
  switch (seconds) {
    case 5:
      return PhosphorIconsDuotone.fastForward;
    case 10:
      return PhosphorIconsDuotone.fastForward;
    case 30:
      return PhosphorIconsDuotone.fastForward;
    default:
      return PhosphorIconsDuotone.fastForward;
  }
}
