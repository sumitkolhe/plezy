part of '../../video_player_screen.dart';

extension _VideoPlayerSeekingMethods on VideoPlayerScreenState {
  Future<void> _seekPlayback(Duration position) async {
    final currentPlayer = player;
    if (!mounted || currentPlayer == null) return;

    final target = clampSeekPosition(currentPlayer, position);
    // Parked on a dead stream (#1520): a native seek would land inside the
    // drained cache — rebuild the stream at the target instead.
    if (_spuriousEofRecoveryParked && _playbackTransition == _PlaybackTransition.idle) {
      await _retrySpuriousEofRecovery(reason: 'seek', resumePosition: target);
      return;
    }
    await currentPlayer.seek(target);
  }

  /// Relative seek driven by the OS media-control skip commands.
  Future<void> _seekRelative(Duration delta) async {
    final currentPlayer = player;
    if (currentPlayer == null) return;
    await _seekPlayback(currentPlayer.state.position + delta);
  }
}
