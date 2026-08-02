import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';

/// Get the replay icon based on the duration
/// Returns numbered icons (replay_5, replay_10, replay_30) when available,
/// otherwise returns generic replay icon
IconData getReplayIcon(int seconds) {
  switch (seconds) {
    case 5:
      return PhosphorIconsFill.arrowCounterClockwise;
    case 10:
      return PhosphorIconsFill.arrowCounterClockwise;
    case 30:
      return PhosphorIconsFill.arrowCounterClockwise;
    default:
      return PhosphorIconsFill.arrowCounterClockwise;
  }
}

/// Get the forward icon based on the duration
/// Returns numbered icons (forward_5, forward_10, forward_30) when available,
/// otherwise returns generic forward icon
IconData getForwardIcon(int seconds) {
  switch (seconds) {
    case 5:
      return PhosphorIconsFill.fastForward;
    case 10:
      return PhosphorIconsFill.fastForward;
    case 30:
      return PhosphorIconsFill.fastForward;
    default:
      return PhosphorIconsFill.fastForward;
  }
}
