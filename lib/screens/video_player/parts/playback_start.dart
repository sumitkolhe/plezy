part of '../../video_player_screen.dart';

extension _VideoPlayerPlaybackStartMethods on VideoPlayerScreenState {
  Future<void> _startPlayback() async {
    final currentPlayer = player;
    if (!mounted || currentPlayer == null) return;
    final attempt = _beginPlaybackAttempt(currentPlayer);
    _hasRenderedFirstFrame = false;
    _hasFatalPlaybackError = false;

    // Capture providers before async gaps
    final offlineWatchService = context.read<OfflineWatchSyncService>();
    var primaryMediaOpened = false;

    try {
      PlaybackContext playbackContext;

      if (_offlineLibraryMode) {
        final playbackResolver = PlaybackSourceResolver(
          serverManager: context.read<MultiServerProvider>().serverManager,
          database: context.read<AppDatabase>(),
        );
        playbackContext = await playbackResolver.resolve(
          PlaybackInitializationOptions(
            metadata: _currentMetadata,
            selectedMediaIndex: _effectiveSelectedMediaIndex,
            selectedMediaSourceId: _requestedMediaSourceId,
            qualityPreset: _selectedQualityPreset,
            selectedAudioStreamId: _selectedAudioStreamId,
            preferredAudioTrack: _preferredAudioTrack,
            preferredSubtitleTrack: _preferredSubtitleTrack,
            sessionIdentifier: _playbackSessionIdentifier,
            transcodeSessionId: _playbackTranscodeSessionId,
          ),
          offlineLibraryMode: true,
        );
        if (playbackContext.result.videoUrl == null) {
          throw PlaybackException(t.messages.fileInfoNotAvailable);
        }
      } else {
        // Online path: `_playbackDataFuture` was kicked off in `_initializePlayer`
        // in parallel with MPV setup. Quality preset + server capabilities +
        // headers were resolved there too. Just await the result.
        final playbackDataFuture = _playbackDataFuture;
        if (playbackDataFuture == null) {
          throw StateError('Playback data was not prepared before playback start');
        }
        playbackContext = await playbackDataFuture;
        if (!mounted || player != currentPlayer) return;

        if (playbackContext.result.fallbackReason != null && !_selectedQualityPreset.isOriginal) {
          if (mounted) {
            showErrorSnackBar(context, t.videoControls.transcodeUnavailableFallback);
          }
        }
      }
      final result = playbackContext.result;
      final streamHeaders = playbackContext.streamHeaders;
      var subtitleSelection = await _resolveSubtitleSelectionForOpen(
        metadata: _currentMetadata,
        result: result,
        preferredAudioTrack: _preferredAudioTrack,
        preferredSubtitleTrack: _preferredSubtitleTrack,
        preferredSecondarySubtitleTrack: _preferredSecondarySubtitleTrack,
      );
      if (!attempt.isCurrent) return;
      // Initial start has no previous session to protect, so commit as soon
      // as the resolve lands (reload-style flows commit at the open
      // boundary instead).
      var session = PlaybackSession.fromContext(
        playbackContext,
        requestedQualityPreset: _selectedQualityPreset,
        requestedMediaSourceId: _requestedMediaSourceId,
        subtitleSelection: subtitleSelection,
      );
      _commitPlaybackSession(session);

      // Primary refresh-rate path: when metadata provides FPS, Android players
      // can switch before creating decoders. MPV still needs a startup refresh
      // when MediaCodec has already produced its first paused frame.
      final settingsService = await SettingsService.getInstance();
      if (!attempt.isCurrent) return;
      final displayCriteria = result.mediaInfo?.displayCriteria;
      var audioFocusReady = false;

      Future<void> ensureAudioFocus() async {
        if (audioFocusReady) return;
        final focusFuture = _audioFocusFuture;
        if (focusFuture != null) {
          await focusFuture;
          _audioFocusFuture = null;
        } else {
          await currentPlayer.requestAudioFocus();
        }
        audioFocusReady = true;
      }

      final frameRatePlan = await _prepareFrameRateForOpen(
        currentPlayer: currentPlayer,
        settingsService: settingsService,
        preKnownFps: displayCriteria?.fps,
        preKnownWidth: displayCriteria?.width ?? 0,
        preKnownHeight: displayCriteria?.height ?? 0,
        hasVideoUrl: result.videoUrl != null,
        ensureAudioFocus: ensureAudioFocus,
      );
      if (frameRatePlan == null) return;
      final shouldHoldPlaybackStart = frameRatePlan.holdPlaybackStart;

      late _ExternalSubtitleOpenPlan externalSubtitlePlan;

      // Open video through Player
      if (result.videoUrl != null) {
        // Reset first frame flag and frame rate retry counter for new video
        _hasFirstFrame.value = false;
        _frameRate.resetForNewItem();
        if (frameRatePlan.countsAsApplied) {
          _frameRate.applied = true;
        }

        // Request audio focus before starting playback (Android)
        // This causes other media apps (Spotify, podcasts, etc.) to pause.
        // Fired in parallel with MPV setup in `_initializePlayer`; we await
        // the in-flight future here (usually already resolved).
        await ensureAudioFocus();
        if (!attempt.isCurrent) return;

        final resumePosition = await _resolveOpenResumePosition(
          metadata: _currentMetadata,
          isOffline: _isOfflinePlayback,
          offlineWatchService: offlineWatchService,
        );
        if (!mounted || player != currentPlayer) return;

        await _primeDisplayCriteria(
          player: currentPlayer,
          settingsService: settingsService,
          displayCriteria: displayCriteria,
          isTranscoding: result.isTranscoding,
        );

        frameRatePlan.armStartupRefreshGate(currentPlayer);
        externalSubtitlePlan = _prepareExternalSubtitleOpenPlan(
          player: currentPlayer,
          externalSubtitles: subtitleSelection.sidecarsAtOpen,
        );
        final shouldAutoPlay = !shouldHoldPlaybackStart && externalSubtitlePlan.canStartBeforeTrackSetup;

        // Backends that support at-open sidecars receive them with open()
        // so tracks are discovered in a single prepare/loadfile cycle. Any
        // backend that cannot do that still uses the post-open sub-add path.
        final openTiming = _playbackOpenTiming(
          isTranscoding: result.isTranscoding,
          resumePosition: resumePosition,
          durationMs: _currentMetadata.durationMs,
        );
        final openResult = await _openMediaOnPlayer(
          player: currentPlayer,
          settingsService: settingsService,
          videoUrl: result.videoUrl!,
          isTranscoding: result.isTranscoding,
          isLocalMedia: _isOfflinePlayback,
          selectedVersion: result.selectedVersion,
          timing: openTiming,
          headers: streamHeaders,
          play: shouldAutoPlay && !PlatformDetector.isAutomotive(),
          externalSubtitlesAtOpen: externalSubtitlePlan.subtitlesAtOpen,
          shouldContinue: () => attempt.isCurrent,
          onMediaAvailabilityChanged: (available) => primaryMediaOpened = available,
        );
        if (!openResult.didOpen || !attempt.isCurrent) return;
        if (openResult.sidecarFallbackUsed) {
          session = _commitSidecarFallbackSession(session);
          subtitleSelection = session.subtitleSelection;
          externalSubtitlePlan = _prepareExternalSubtitleOpenPlan(player: currentPlayer, externalSubtitles: const []);
        }

        // Attach player to Watch Together session for sync (if in session).
        if (shouldAutoPlay && PlatformDetector.isAutomotive()) {
          await _playWithPlaybackIntent(currentPlayer);
          if (!attempt.isCurrent) return;
        }
      } else {
        externalSubtitlePlan = _prepareExternalSubtitleOpenPlan(
          player: currentPlayer,
          externalSubtitles: subtitleSelection.sidecarsAtOpen,
          waitForFileLoaded: false,
        );
      }

      // Versions/mediaInfo come from the committed session; rebuild so the
      // controls pick them up.
      if (mounted) {
        final mediaClient = context.tryGetMediaClientForServer(serverIdOrNull(_currentMetadata.serverId));
        _resetScrubPreviewForNewItem(metadata: _currentMetadata, mediaInfo: result.mediaInfo, mediaClient: mediaClient);

        await _initVideoFilterAndPip();
        if (!attempt.isCurrent) return;

        if (player == currentPlayer) {
          // Auto-PiP: set up callback for API 26-30 path and initial state
          if (_autoPipEnabled) {
            void autoPipEnteringCallback() {
              if (!mounted || player != currentPlayer) return;
              _setAndroidAutoPipTransitionInFlight(true, reason: 'native_auto_pip_entering');
              _preparePipFiltersForEntry();
            }

            _autoPipEnteringCallback = autoPipEnteringCallback;
            PipService.onAutoPipEntering = autoPipEnteringCallback;
            if (currentPlayer.state.playing) {
              unawaited(_updateAutoPipState(isPlaying: true));
            }
          }

          _shaderService = ShaderService(currentPlayer);
          if (_shaderService!.isSupported) {
            _ambientLightingService = AmbientLightingService(currentPlayer);
            _shaderService!.ambientLightingService = _ambientLightingService;
            _videoFilterManager?.ambientLightingService = _ambientLightingService;

            await _applySavedShaderPreset();
            await _restoreAmbientLighting();
          }
        }
        if (!attempt.isCurrent) return;

        // Track manager: owns track selection, external subtitle loading, and Plex
        // immediate stream writes. Jellyfin persists selected stream indexes through
        // playback progress reports instead.
        _trackManager = _buildTrackManager(
          forPlayer: currentPlayer,
          metadata: _currentMetadata,
          getProfileSettings: () => context.read<UserProfileProvider>().profileSettings,
          preferredAudioTrack: _preferredAudioTrack,
          // Same rule as the reload flow: a declined preference is retried by
          // the native passes instead of being frozen into off (#1785).
          preferredSubtitleTrack:
              subtitleSelection.declinedPreference ?? SubtitlePreference.trackOrNull(subtitleSelection.primaryTrack),
          preferredSecondarySubtitleTrack: SubtitlePreference.trackOrNull(subtitleSelection.secondaryTrack),
        );

        // Store only the active sidecars for re-use after backend fallback.
        _trackManager!.cacheExternalSubtitles(subtitleSelection.sidecarsAtOpen);

        final resumeForStartupFrame = frameRatePlan.needsStartupRefresh && externalSubtitlePlan.requiresPostOpenAdd;
        await _applyTracksAfterOpen(
          trackManager: _trackManager!,
          externalSubtitlePlan: externalSubtitlePlan,
          // When a startup gate below owns the resume, skip this one to
          // avoid a double-play. Post-open external-subtitle paths are the
          // exception: after they attach we must resume once so mpv can
          // produce the startup frame that the decoder-refresh gate is waiting
          // for.
          shouldResumeAfterSubtitleLoad: () =>
              (!shouldHoldPlaybackStart || resumeForStartupFrame) && mounted && player == currentPlayer,
          applySelectionWhenResumeSkipped: false,
        );

        await _releaseFrameRateStartupGate(
          currentPlayer: currentPlayer,
          settingsService: settingsService,
          plan: frameRatePlan,
          resumeAfterStartupGate: (reason) => _finishPlaybackAfterStartupGate(
            currentPlayer: currentPlayer,
            externalSubtitlePlan: externalSubtitlePlan,
            reason: reason,
            shouldResume: true,
          ),
          playbackResumedForStartupFrame: resumeForStartupFrame,
        );
      }
    } on PlaybackException catch (e, st) {
      appLogger.w('Playback initialization failed', error: e, stackTrace: st);
      if (attempt.isCurrent && mounted) {
        if (!primaryMediaOpened) {
          _hasFatalPlaybackError = true;
        }
        _hasFirstFrame.value = true; // Hide spinner on every current startup failure
        showErrorSnackBar(context, e.message);
      }
    } catch (e, st) {
      appLogger.e('Failed to start playback', error: e, stackTrace: st);
      if (attempt.isCurrent && mounted) {
        if (!primaryMediaOpened) {
          _hasFatalPlaybackError = true;
        }
        _hasFirstFrame.value = true; // Hide spinner on every current startup failure
        showErrorSnackBar(context, t.messages.errorLoading(error: e.toString()));
      }
    }
  }
}
