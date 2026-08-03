import 'package:flutter/material.dart';
import 'package:tabler_icons_plus/tabler_icons_plus.dart';

/// Seek icons carry their interval in the glyph, so six controls read as six
/// things rather than two arrows repeated.
IconData getReplayIcon(int seconds) => switch (seconds) {
  5 => TablerIcons.rewindBackward5,
  10 => TablerIcons.rewindBackward10,
  15 => TablerIcons.rewindBackward15,
  20 => TablerIcons.rewindBackward20,
  30 => TablerIcons.rewindBackward30,
  _ => TablerIcons.rotate2,
};

IconData getForwardIcon(int seconds) => switch (seconds) {
  5 => TablerIcons.rewindForward5,
  10 => TablerIcons.rewindForward10,
  15 => TablerIcons.rewindForward15,
  20 => TablerIcons.rewindForward20,
  30 => TablerIcons.rewindForward30,
  _ => TablerIcons.playerTrackNext,
};
