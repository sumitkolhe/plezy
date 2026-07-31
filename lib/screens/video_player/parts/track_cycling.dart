part of '../../video_player_screen.dart';

extension _VideoPlayerTrackCyclingMethods on VideoPlayerScreenState {
  void _cycleSubtitleTrack() {
    final sourceTracks = _sourceSubtitleTracksForControls();
    if (!_isOfflinePlayback && sourceTracks.isNotEmpty) {
      _pendingSubtitleCycleCount++;
      if (!_subtitleCycleDrainActive) unawaited(_drainSubtitleCycles());
      return;
    }
    _trackManager?.cycleSubtitleTrack();
  }

  Future<void> _drainSubtitleCycles() async {
    if (_subtitleCycleDrainActive) return;
    _subtitleCycleDrainActive = true;
    try {
      while (mounted && _pendingSubtitleCycleCount > 0) {
        await _waitForPlaybackTransitionIdle();
        if (!mounted || _pendingSubtitleCycleCount == 0) break;

        // Collapse every press queued before this dispatch into one target.
        // Presses arriving during the reopen remain queued for the next pass.
        final advances = _pendingSubtitleCycleCount;
        final sourceTracks = _sourceSubtitleTracksForControls();
        if (_isOfflinePlayback || sourceTracks.isEmpty) {
          _pendingSubtitleCycleCount -= advances;
          for (var i = 0; i < advances; i++) {
            _trackManager?.cycleSubtitleTrack();
          }
          continue;
        }
        final currentChoice =
            _selectedSourceSubtitleChoiceForControls(sourceTracks) ?? const PlaybackSourceSubtitleChoice.off();
        final targetChoice = PlaybackSubtitleResolver.advanceSourceChoice(sourceTracks, currentChoice, advances);
        final outcome = await _switchPlaybackSource(newSubtitleChoice: targetChoice);
        if (outcome == PlaybackSourceChangeOutcome.busy) {
          await _waitForPlaybackTransitionIdle();
          continue;
        }
        _pendingSubtitleCycleCount -= advances;
      }
    } finally {
      _subtitleCycleDrainActive = false;
    }
  }

  void _cycleAudioTrack() => _trackManager?.cycleAudioTrack();
}
