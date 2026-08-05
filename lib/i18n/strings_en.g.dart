///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$app$en app = Translations$app$en.internal(_root);
	late final Translations$auth$en auth = Translations$auth$en.internal(_root);
	late final Translations$common$en common = Translations$common$en.internal(_root);
	late final Translations$screens$en screens = Translations$screens$en.internal(_root);
	late final Translations$update$en update = Translations$update$en.internal(_root);
	late final Translations$settings$en settings = Translations$settings$en.internal(_root);
	late final Translations$search$en search = Translations$search$en.internal(_root);
	late final Translations$hotkeys$en hotkeys = Translations$hotkeys$en.internal(_root);
	late final Translations$fileInfo$en fileInfo = Translations$fileInfo$en.internal(_root);
	late final Translations$mediaMenu$en mediaMenu = Translations$mediaMenu$en.internal(_root);
	late final Translations$rateSheet$en rateSheet = Translations$rateSheet$en.internal(_root);
	late final Translations$accessibility$en accessibility = Translations$accessibility$en.internal(_root);
	late final Translations$tooltips$en tooltips = Translations$tooltips$en.internal(_root);
	late final Translations$audioTracks$en audioTracks = Translations$audioTracks$en.internal(_root);
	late final Translations$videoControls$en videoControls = Translations$videoControls$en.internal(_root);
	late final Translations$messages$en messages = Translations$messages$en.internal(_root);
	late final Translations$subtitlingStyling$en subtitlingStyling = Translations$subtitlingStyling$en.internal(_root);
	late final Translations$mpvConfig$en mpvConfig = Translations$mpvConfig$en.internal(_root);
	late final Translations$dialog$en dialog = Translations$dialog$en.internal(_root);
	late final Translations$profiles$en profiles = Translations$profiles$en.internal(_root);
	late final Translations$connections$en connections = Translations$connections$en.internal(_root);
	late final Translations$discover$en discover = Translations$discover$en.internal(_root);
	late final Translations$errors$en errors = Translations$errors$en.internal(_root);
	late final Translations$libraries$en libraries = Translations$libraries$en.internal(_root);
	late final Translations$about$en about = Translations$about$en.internal(_root);
	late final Translations$hubDetail$en hubDetail = Translations$hubDetail$en.internal(_root);
	late final Translations$logs$en logs = Translations$logs$en.internal(_root);
	late final Translations$licenses$en licenses = Translations$licenses$en.internal(_root);
	late final Translations$navigation$en navigation = Translations$navigation$en.internal(_root);
	late final Translations$explore$en explore = Translations$explore$en.internal(_root);
	late final Translations$collections$en collections = Translations$collections$en.internal(_root);
	late final Translations$playlists$en playlists = Translations$playlists$en.internal(_root);
	late final Translations$music$en music = Translations$music$en.internal(_root);
	late final Translations$downloads$en downloads = Translations$downloads$en.internal(_root);
	late final Translations$shaders$en shaders = Translations$shaders$en.internal(_root);
	late final Translations$videoSettings$en videoSettings = Translations$videoSettings$en.internal(_root);
	late final Translations$performanceOverlay$en performanceOverlay = Translations$performanceOverlay$en.internal(_root);
	late final Translations$externalPlayer$en externalPlayer = Translations$externalPlayer$en.internal(_root);
	late final Translations$metadataEdit$en metadataEdit = Translations$metadataEdit$en.internal(_root);
	late final Translations$trakt$en trakt = Translations$trakt$en.internal(_root);
	late final Translations$seerr$en seerr = Translations$seerr$en.internal(_root);
	late final Translations$services$en services = Translations$services$en.internal(_root);
	late final Translations$addServer$en addServer = Translations$addServer$en.internal(_root);
	late final Translations$managedServices$en managedServices = Translations$managedServices$en.internal(_root);
	late final Translations$serverActivity$en serverActivity = Translations$serverActivity$en.internal(_root);
	late final Translations$arrSearch$en arrSearch = Translations$arrSearch$en.internal(_root);
}

// Path: app
class Translations$app$en {
	Translations$app$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Harbor'
	String get title => 'Harbor';
}

// Path: auth
class Translations$auth$en {
	Translations$auth$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connect to Jellyfin'
	String get connectToJellyfin => 'Connect to Jellyfin';

	/// en: 'Use Quick Connect'
	String get useQuickConnect => 'Use Quick Connect';

	/// en: 'Open Quick Connect in Jellyfin and enter this code.'
	String get quickConnectInstructions => 'Open Quick Connect in Jellyfin and enter this code.';

	/// en: 'Waiting for approval…'
	String get quickConnectWaiting => 'Waiting for approval…';

	/// en: 'Cancel'
	String get quickConnectCancel => 'Cancel';

	/// en: 'Quick Connect expired. Try again.'
	String get quickConnectExpired => 'Quick Connect expired. Try again.';
}

// Path: common
class Translations$common$en {
	Translations$common$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Clear'
	String get clear => 'Clear';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Later'
	String get later => 'Later';

	/// en: 'Submit'
	String get submit => 'Submit';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Log out'
	String get logout => 'Log out';

	/// en: 'Unknown'
	String get unknown => 'Unknown';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Yes'
	String get yes => 'Yes';

	/// en: 'No'
	String get no => 'No';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Shuffle'
	String get shuffle => 'Shuffle';

	/// en: 'Add to...'
	String get addTo => 'Add to...';

	/// en: 'Create new'
	String get createNew => 'Create new';

	/// en: 'Disconnect'
	String get disconnect => 'Disconnect';

	/// en: 'Play'
	String get play => 'Play';

	/// en: 'Pause'
	String get pause => 'Pause';

	/// en: 'Resume'
	String get resume => 'Resume';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Off'
	String get off => 'Off';

	/// en: 'Season ${number}'
	String seasonNumber({required Object number}) => 'Season ${number}';

	/// en: 'Episode ${number} - ${title}'
	String episodeNumberTitle({required Object number, required Object title}) => 'Episode ${number} - ${title}';

	/// en: 'Chapter ${number}'
	String chapterNumber({required Object number}) => 'Chapter ${number}';

	/// en: 'Reconnect'
	String get reconnect => 'Reconnect';

	/// en: 'View All'
	String get viewAll => 'View All';

	/// en: 'Checking network...'
	String get checkingNetwork => 'Checking network...';

	/// en: 'Loading servers...'
	String get loadingServers => 'Loading servers...';

	/// en: 'Connecting to servers...'
	String get connectingToServers => 'Connecting to servers...';

	/// en: 'Starting offline mode...'
	String get startingOfflineMode => 'Starting offline mode...';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Press back again to exit'
	String get pressBackAgainToExit => 'Press back again to exit';

	/// en: 'Next'
	String get next => 'Next';
}

// Path: screens
class Translations$screens$en {
	Translations$screens$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Licenses'
	String get licenses => 'Licenses';

	/// en: 'Switch Profile'
	String get switchProfile => 'Switch Profile';

	/// en: 'Subtitle Styling'
	String get subtitleStyling => 'Subtitle Styling';

	/// en: 'mpv.conf'
	String get mpvConfig => 'mpv.conf';

	/// en: 'Logs'
	String get logs => 'Logs';
}

// Path: update
class Translations$update$en {
	Translations$update$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Update Available'
	String get available => 'Update Available';

	/// en: 'Version ${version} is available'
	String versionAvailable({required Object version}) => 'Version ${version} is available';

	/// en: 'Current: ${version}'
	String currentVersion({required Object version}) => 'Current: ${version}';

	/// en: 'Skip This Version'
	String get skipVersion => 'Skip This Version';

	/// en: 'View Release'
	String get viewRelease => 'View Release';

	/// en: 'You are on the latest version'
	String get latestVersion => 'You are on the latest version';

	/// en: 'Failed to check for updates'
	String get checkFailed => 'Failed to check for updates';
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Support Harbor'
	String get supportDeveloper => 'Support Harbor';

	/// en: 'Donate via Liberapay to fund development'
	String get supportDeveloperDescription => 'Donate via Liberapay to fund development';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'Video Playback'
	String get videoPlayback => 'Video Playback';

	/// en: 'Configure playback behavior'
	String get videoPlaybackDescription => 'Configure playback behavior';

	/// en: 'Advanced'
	String get advanced => 'Advanced';

	/// en: 'Episode Poster Style'
	String get episodePosterMode => 'Episode Poster Style';

	/// en: 'Series Poster'
	String get seriesPoster => 'Series Poster';

	/// en: 'Season Poster'
	String get seasonPoster => 'Season Poster';

	/// en: 'Thumbnail'
	String get episodeThumbnail => 'Thumbnail';

	/// en: 'Display featured content carousel on home screen'
	String get showHeroSectionDescription => 'Display featured content carousel on home screen';

	/// en: 'Seconds'
	String get secondsLabel => 'Seconds';

	/// en: 'Minutes'
	String get minutesLabel => 'Minutes';

	/// en: 's'
	String get secondsShort => 's';

	/// en: 'm'
	String get minutesShort => 'm';

	/// en: 'Enter duration (${min}-${max})'
	String durationHint({required Object min, required Object max}) => 'Enter duration (${min}-${max})';

	/// en: 'System'
	String get systemTheme => 'System';

	/// en: 'Light'
	String get lightTheme => 'Light';

	/// en: 'Dark'
	String get darkTheme => 'Dark';

	/// en: 'OLED'
	String get oledTheme => 'OLED';

	/// en: 'Material You'
	String get materialYouTheme => 'Material You';

	/// en: 'Haptic feedback'
	String get hapticFeedback => 'Haptic feedback';

	/// en: 'Vibrate when choosing an item, switching tabs, or flipping a switch'
	String get hapticFeedbackDescription => 'Vibrate when choosing an item, switching tabs, or flipping a switch';

	/// en: 'Library Density'
	String get libraryDensity => 'Library Density';

	/// en: 'Compact'
	String get compact => 'Compact';

	/// en: 'Comfortable'
	String get comfortable => 'Comfortable';

	/// en: 'Corner Spotlight Backdrop'
	String get tvCornerSpotlightBackdrop => 'Corner Spotlight Backdrop';

	/// en: 'Show spotlight artwork in the top-right corner instead of filling the screen'
	String get tvCornerSpotlightBackdropDescription => 'Show spotlight artwork in the top-right corner instead of filling the screen';

	/// en: 'View Mode'
	String get viewMode => 'View Mode';

	/// en: 'Grid'
	String get gridView => 'Grid';

	/// en: 'List'
	String get listView => 'List';

	/// en: 'Show Hero Section'
	String get showHeroSection => 'Show Hero Section';

	/// en: 'Continue Watching Action'
	String get continueWatchingAction => 'Continue Watching Action';

	/// en: 'Play'
	String get continueWatchingPlay => 'Play';

	/// en: 'Open Details'
	String get continueWatchingDetails => 'Open Details';

	/// en: 'Episode Action'
	String get episodeAction => 'Episode Action';

	/// en: 'Play'
	String get episodePlay => 'Play';

	/// en: 'Open Details'
	String get episodeDetails => 'Open Details';

	/// en: 'Show Server Name on Hubs'
	String get showServerNameOnHubs => 'Show Server Name on Hubs';

	/// en: 'Always show server names in hub titles.'
	String get showServerNameOnHubsDescription => 'Always show server names in hub titles.';

	/// en: 'Group Libraries by Server'
	String get groupLibrariesByServer => 'Group Libraries by Server';

	/// en: 'Group sidebar libraries under each media server.'
	String get groupLibrariesByServerDescription => 'Group sidebar libraries under each media server.';

	/// en: 'Always Keep Sidebar Open'
	String get alwaysKeepSidebarOpen => 'Always Keep Sidebar Open';

	/// en: 'Sidebar stays expanded and content area adjusts to fit'
	String get alwaysKeepSidebarOpenDescription => 'Sidebar stays expanded and content area adjusts to fit';

	/// en: 'Show Unwatched Count'
	String get showUnwatchedCount => 'Show Unwatched Count';

	/// en: 'Display unwatched episode count on shows and seasons'
	String get showUnwatchedCountDescription => 'Display unwatched episode count on shows and seasons';

	/// en: 'Show Episode Number on Cards'
	String get showEpisodeNumberOnCards => 'Show Episode Number on Cards';

	/// en: 'Show season and episode number on episode cards'
	String get showEpisodeNumberOnCardsDescription => 'Show season and episode number on episode cards';

	/// en: 'Show Season Posters on Tabs'
	String get showSeasonPostersOnTabs => 'Show Season Posters on Tabs';

	/// en: 'Show each season's poster above its tab'
	String get showSeasonPostersOnTabsDescription => 'Show each season\'s poster above its tab';

	/// en: 'Full TV Cards'
	String get tvFullCardLayout => 'Full TV Cards';

	/// en: 'Use image-only TV cards with actor names overlaid'
	String get tvFullCardLayoutDescription => 'Use image-only TV cards with actor names overlaid';

	/// en: 'Focus Glow'
	String get focusGlow => 'Focus Glow';

	/// en: 'Draw a soft glow around the focused card'
	String get focusGlowDescription => 'Draw a soft glow around the focused card';

	/// en: 'Visual Effects'
	String get visualEffects => 'Visual Effects';

	/// en: 'Auto'
	String get visualEffectsAuto => 'Auto';

	/// en: 'Reduce effects automatically on low-power devices'
	String get visualEffectsAutoDescription => 'Reduce effects automatically on low-power devices';

	/// en: 'Full'
	String get visualEffectsFull => 'Full';

	/// en: 'Reduced'
	String get visualEffectsReduced => 'Reduced';

	/// en: 'Fewer animations and lower-resolution artwork'
	String get visualEffectsReducedDescription => 'Fewer animations and lower-resolution artwork';

	/// en: 'Hide Spoilers for Unwatched Episodes'
	String get hideSpoilers => 'Hide Spoilers for Unwatched Episodes';

	/// en: 'Blur thumbnails and descriptions for unwatched episodes'
	String get hideSpoilersDescription => 'Blur thumbnails and descriptions for unwatched episodes';

	/// en: 'Player Backend'
	String get playerBackend => 'Player Backend';

	/// en: 'ExoPlayer'
	String get exoPlayer => 'ExoPlayer';

	/// en: 'mpv'
	String get mpv => 'mpv';

	/// en: 'Hardware Decoding'
	String get hardwareDecoding => 'Hardware Decoding';

	/// en: 'Use hardware acceleration when available'
	String get hardwareDecodingDescription => 'Use hardware acceleration when available';

	/// en: 'Buffer Size'
	String get bufferSize => 'Buffer Size';

	/// en: '${size}MB'
	String bufferSizeMB({required Object size}) => '${size}MB';

	/// en: 'Auto (Recommended)'
	String get bufferSizeAuto => 'Auto (Recommended)';

	/// en: '${heap}MB memory available. A ${size}MB buffer may affect playback.'
	String bufferSizeWarning({required Object heap, required Object size}) => '${heap}MB memory available. A ${size}MB buffer may affect playback.';

	/// en: 'Default Quality'
	String get defaultQualityTitle => 'Default Quality';

	/// en: 'Music Quality'
	String get musicQualityTitle => 'Music Quality';

	/// en: 'Subtitle Styling'
	String get subtitleStyling => 'Subtitle Styling';

	/// en: 'Customize subtitle appearance'
	String get subtitleStylingDescription => 'Customize subtitle appearance';

	/// en: 'Small Skip Duration'
	String get smallSkipDuration => 'Small Skip Duration';

	/// en: 'Large Skip Duration'
	String get largeSkipDuration => 'Large Skip Duration';

	/// en: 'Rewind on Resume'
	String get rewindOnResume => 'Rewind on Resume';

	/// en: '${seconds} seconds'
	String secondsUnit({required Object seconds}) => '${seconds} seconds';

	/// en: 'Default Sleep Timer'
	String get defaultSleepTimer => 'Default Sleep Timer';

	/// en: '${minutes} minutes'
	String minutesUnit({required Object minutes}) => '${minutes} minutes';

	/// en: 'Remember track selections per show/movie'
	String get rememberTrackSelections => 'Remember track selections per show/movie';

	/// en: 'Remember audio and subtitle choices per title'
	String get rememberTrackSelectionsDescription => 'Remember audio and subtitle choices per title';

	/// en: 'Use server's per-episode track selections'
	String get followServerTrackSelections => 'Use server\'s per-episode track selections';

	/// en: 'On episode change, apply the audio and subtitles selected on the server instead of carrying over the current choice'
	String get followServerTrackSelectionsDescription => 'On episode change, apply the audio and subtitles selected on the server instead of carrying over the current choice';

	/// en: 'Show chapter markers on seek bar'
	String get showChapterMarkersOnTimeline => 'Show chapter markers on seek bar';

	/// en: 'Segment the seek bar at chapter boundaries'
	String get showChapterMarkersOnTimelineDescription => 'Segment the seek bar at chapter boundaries';

	/// en: 'Click on video to toggle play/pause'
	String get clickVideoTogglesPlayback => 'Click on video to toggle play/pause';

	/// en: 'Click video to play/pause instead of showing controls.'
	String get clickVideoTogglesPlaybackDescription => 'Click video to play/pause instead of showing controls.';

	/// en: 'Video Player Controls'
	String get videoPlayerControls => 'Video Player Controls';

	/// en: 'Keyboard Shortcuts'
	String get keyboardShortcuts => 'Keyboard Shortcuts';

	/// en: 'Customize keyboard shortcuts'
	String get keyboardShortcutsDescription => 'Customize keyboard shortcuts';

	/// en: 'Video Player Navigation'
	String get videoPlayerNavigation => 'Video Player Navigation';

	/// en: 'Use arrow keys to navigate video player controls'
	String get videoPlayerNavigationDescription => 'Use arrow keys to navigate video player controls';

	/// en: 'Debug Logging'
	String get debugLogging => 'Debug Logging';

	/// en: 'Enable detailed logging for troubleshooting'
	String get debugLoggingDescription => 'Enable detailed logging for troubleshooting';

	/// en: 'View Logs'
	String get viewLogs => 'View Logs';

	/// en: 'View application logs'
	String get viewLogsDescription => 'View application logs';

	/// en: 'Clear Image Cache'
	String get clearImageCache => 'Clear Image Cache';

	/// en: 'Clear cached artwork and thumbnails. Images may load slower until downloaded again.'
	String get clearImageCacheDescription => 'Clear cached artwork and thumbnails. Images may load slower until downloaded again.';

	/// en: 'Image cache cleared successfully'
	String get clearImageCacheSuccess => 'Image cache cleared successfully';

	/// en: 'Reset Settings'
	String get resetSettings => 'Reset Settings';

	/// en: 'Restore default settings. This can't be undone.'
	String get resetSettingsDescription => 'Restore default settings. This can\'t be undone.';

	/// en: 'Settings reset successfully'
	String get resetSettingsSuccess => 'Settings reset successfully';

	/// en: 'Backup'
	String get backup => 'Backup';

	/// en: 'Export Settings'
	String get exportSettings => 'Export Settings';

	/// en: 'Save your preferences to a file'
	String get exportSettingsDescription => 'Save your preferences to a file';

	/// en: 'Settings exported'
	String get exportSettingsSuccess => 'Settings exported';

	/// en: 'Import Settings'
	String get importSettings => 'Import Settings';

	/// en: 'Restore preferences from a file'
	String get importSettingsDescription => 'Restore preferences from a file';

	/// en: 'This will replace your current settings. Continue?'
	String get importSettingsConfirm => 'This will replace your current settings. Continue?';

	/// en: 'Settings imported'
	String get importSettingsSuccess => 'Settings imported';

	/// en: 'This file isn't a valid Harbor settings export'
	String get importSettingsInvalidFile => 'This file isn\'t a valid Harbor settings export';

	/// en: 'Sign in before importing settings'
	String get importSettingsNoUser => 'Sign in before importing settings';

	/// en: 'Shortcuts reset to defaults'
	String get shortcutsReset => 'Shortcuts reset to defaults';

	/// en: 'About'
	String get about => 'About';

	/// en: 'App information and licenses'
	String get aboutDescription => 'App information and licenses';

	/// en: 'Updates'
	String get updates => 'Updates';

	/// en: 'Update Available'
	String get updateAvailable => 'Update Available';

	/// en: 'Check for Updates'
	String get checkForUpdates => 'Check for Updates';

	/// en: 'Automatically check for updates on startup'
	String get autoCheckUpdatesOnStartup => 'Automatically check for updates on startup';

	/// en: 'Notify when an update is available at launch'
	String get autoCheckUpdatesOnStartupDescription => 'Notify when an update is available at launch';

	/// en: 'Please enter a valid number'
	String get validationErrorEnterNumber => 'Please enter a valid number';

	/// en: 'Duration must be between ${min} and ${max} ${unit}'
	String validationErrorDuration({required Object min, required Object max, required Object unit}) => 'Duration must be between ${min} and ${max} ${unit}';

	/// en: 'Shortcut already assigned to ${action}'
	String shortcutAlreadyAssigned({required Object action}) => 'Shortcut already assigned to ${action}';

	/// en: 'Shortcut updated for ${action}'
	String shortcutUpdated({required Object action}) => 'Shortcut updated for ${action}';

	/// en: 'Could not save changes. Try again.'
	String get saveFailed => 'Could not save changes. Try again.';

	/// en: 'Auto Skip'
	String get autoSkip => 'Auto Skip';

	/// en: 'Auto Skip Intro'
	String get autoSkipIntro => 'Auto Skip Intro';

	/// en: 'Automatically skip intro markers after a few seconds'
	String get autoSkipIntroDescription => 'Automatically skip intro markers after a few seconds';

	/// en: 'Auto Skip Credits'
	String get autoSkipCredits => 'Auto Skip Credits';

	/// en: 'Automatically skip credits and play next episode'
	String get autoSkipCreditsDescription => 'Automatically skip credits and play next episode';

	/// en: 'Force Fallback Markers'
	String get forceSkipMarkerFallback => 'Force Fallback Markers';

	/// en: 'Use chapter title patterns even when Plex has markers'
	String get forceSkipMarkerFallbackDescription => 'Use chapter title patterns even when Plex has markers';

	/// en: 'Auto Skip Delay'
	String get autoSkipDelay => 'Auto Skip Delay';

	/// en: 'Wait ${seconds} seconds before auto-skipping'
	String autoSkipDelayDescription({required Object seconds}) => 'Wait ${seconds} seconds before auto-skipping';

	/// en: 'Intro Marker Pattern'
	String get introPattern => 'Intro Marker Pattern';

	/// en: 'Regex pattern to match intro markers in chapter titles'
	String get introPatternDescription => 'Regex pattern to match intro markers in chapter titles';

	/// en: 'Credits Marker Pattern'
	String get creditsPattern => 'Credits Marker Pattern';

	/// en: 'Regex pattern to match credits markers in chapter titles'
	String get creditsPatternDescription => 'Regex pattern to match credits markers in chapter titles';

	/// en: 'Invalid regular expression'
	String get invalidRegex => 'Invalid regular expression';

	/// en: 'Regular expression'
	String get regex => 'Regular expression';

	/// en: 'Downloads'
	String get downloads => 'Downloads';

	/// en: 'Choose where to store downloaded content'
	String get downloadLocationDescription => 'Choose where to store downloaded content';

	/// en: 'Default (App Storage)'
	String get downloadLocationDefault => 'Default (App Storage)';

	/// en: 'Custom Location'
	String get downloadLocationCustom => 'Custom Location';

	/// en: 'Select Folder'
	String get selectFolder => 'Select Folder';

	/// en: 'Reset to Default'
	String get resetToDefault => 'Reset to Default';

	/// en: 'Current: ${path}'
	String currentPath({required Object path}) => 'Current: ${path}';

	/// en: 'Download location changed'
	String get downloadLocationChanged => 'Download location changed';

	/// en: 'Download location reset to default'
	String get downloadLocationReset => 'Download location reset to default';

	/// en: 'Selected folder is not writable'
	String get downloadLocationInvalid => 'Selected folder is not writable';

	/// en: 'Folder selection is not available on this device'
	String get downloadLocationPickerUnavailable => 'Folder selection is not available on this device';

	/// en: 'Download on Wi-Fi only'
	String get downloadOnWifiOnly => 'Download on Wi-Fi only';

	/// en: 'Prevent downloads when on cellular data'
	String get downloadOnWifiOnlyDescription => 'Prevent downloads when on cellular data';

	/// en: 'Auto-remove watched downloads'
	String get autoRemoveWatchedDownloads => 'Auto-remove watched downloads';

	/// en: 'Delete watched downloads automatically'
	String get autoRemoveWatchedDownloadsDescription => 'Delete watched downloads automatically';

	/// en: 'Downloads are blocked on cellular. Use Wi-Fi or change the setting.'
	String get cellularDownloadBlocked => 'Downloads are blocked on cellular. Use Wi-Fi or change the setting.';

	/// en: 'Maximum Volume'
	String get maxVolume => 'Maximum Volume';

	/// en: 'Allow volume boost above 100% for quiet media'
	String get maxVolumeDescription => 'Allow volume boost above 100% for quiet media';

	/// en: '${percent}%'
	String maxVolumePercent({required Object percent}) => '${percent}%';

	/// en: 'Services'
	String get services => 'Services';

	/// en: 'Connect Trakt, MyAnimeList, Seerr, and more'
	String get servicesDescription => 'Connect Trakt, MyAnimeList, Seerr, and more';

	/// en: 'Reorder and hide libraries'
	String get manageLibrariesDescription => 'Reorder and hide libraries';

	/// en: 'Auto Picture-in-Picture'
	String get autoPip => 'Auto Picture-in-Picture';

	/// en: 'Automatically enter picture-in-picture when you leave the app during playback'
	String get autoPipDescription => 'Automatically enter picture-in-picture when you leave the app during playback';

	/// en: 'Match Content Frame Rate'
	String get matchContentFrameRate => 'Match Content Frame Rate';

	/// en: 'Match display refresh rate to video content'
	String get matchContentFrameRateDescription => 'Match display refresh rate to video content';

	/// en: 'Match Refresh Rate'
	String get matchRefreshRate => 'Match Refresh Rate';

	/// en: 'Match display refresh rate in fullscreen'
	String get matchRefreshRateDescription => 'Match display refresh rate in fullscreen';

	/// en: 'Match Dynamic Range'
	String get matchDynamicRange => 'Match Dynamic Range';

	/// en: 'Switch HDR on for HDR content, then back to SDR'
	String get matchDynamicRangeDescription => 'Switch HDR on for HDR content, then back to SDR';

	/// en: 'Display Switch Delay'
	String get displaySwitchDelay => 'Display Switch Delay';

	/// en: 'Tunneled Playback'
	String get tunneledPlayback => 'Tunneled Playback';

	/// en: 'Use video tunneling. Disable if HDR playback shows black video.'
	String get tunneledPlaybackDescription => 'Use video tunneling. Disable if HDR playback shows black video.';

	/// en: 'Audio Passthrough'
	String get audioPassthrough => 'Audio Passthrough';

	/// en: 'Send Dolby/DTS audio to your receiver or TV without re-encoding, preserving surround sound. Turn off if you have no sound.'
	String get audioPassthroughDescription => 'Send Dolby/DTS audio to your receiver or TV without re-encoding, preserving surround sound. Turn off if you have no sound.';

	/// en: 'Use Apple's native Dolby decoder for Dolby Digital Plus, including Atmos. DTS and TrueHD still play as multichannel PCM. Turn off if you have no sound.'
	String get audioPassthroughDescriptionAppleTv => 'Use Apple\'s native Dolby decoder for Dolby Digital Plus, including Atmos. DTS and TrueHD still play as multichannel PCM. Turn off if you have no sound.';

	/// en: 'Downmix to Stereo'
	String get audioDownmix => 'Downmix to Stereo';

	/// en: 'Mix surround audio down to two channels for stereo speakers or headphones'
	String get audioDownmixDescription => 'Mix surround audio down to two channels for stereo speakers or headphones';

	/// en: 'Center Channel Boost'
	String get downmixCenterBoost => 'Center Channel Boost';

	/// en: '${db} dB'
	String downmixCenterBoostValue({required Object db}) => '${db} dB';

	/// en: 'Boost (dB)'
	String get downmixCenterBoostLabel => 'Boost (dB)';

	/// en: 'dB'
	String get downmixCenterBoostShort => 'dB';

	/// en: 'Normalize Volume on Downmix'
	String get audioDownmixNormalize => 'Normalize Volume on Downmix';

	/// en: 'Lower the mix to prevent clipping. Turn off to keep the original volume (may distort loud scenes).'
	String get audioDownmixNormalizeDescription => 'Lower the mix to prevent clipping. Turn off to keep the original volume (may distort loud scenes).';

	/// en: 'Atmos Output Test'
	String get atmosDiagnostics => 'Atmos Output Test';

	/// en: 'Diagnose Dolby Atmos output by playing test signals through the system player'
	String get atmosDiagnosticsDescription => 'Diagnose Dolby Atmos output by playing test signals through the system player';

	/// en: 'Apple Atmos stream'
	String get atmosTestHlsAtmos => 'Apple Atmos stream';

	/// en: 'Known-good Dolby Atmos stream. The receiver should show Dolby Atmos.'
	String get atmosTestHlsAtmosDescription => 'Known-good Dolby Atmos stream. The receiver should show Dolby Atmos.';

	/// en: 'Apple surround stream'
	String get atmosTestHlsControl => 'Apple surround stream';

	/// en: 'Non-Atmos control stream. The receiver should show surround without Atmos.'
	String get atmosTestHlsControlDescription => 'Non-Atmos control stream. The receiver should show surround without Atmos.';

	/// en: 'Raw EAC3 stream'
	String get atmosTestRawStream => 'Raw EAC3 stream';

	/// en: 'Streams the test file exactly like in-player Atmos playback. Needs the test file URL.'
	String get atmosTestRawStreamDescription => 'Streams the test file exactly like in-player Atmos playback. Needs the test file URL.';

	/// en: 'Raw EAC3 file'
	String get atmosTestRawFile => 'Raw EAC3 file';

	/// en: 'Plays the test file with a known length. Needs the test file URL.'
	String get atmosTestRawFileDescription => 'Plays the test file with a known length. Needs the test file URL.';

	/// en: 'Sample-buffer renderer (native)'
	String get atmosTestAsbarNative => 'Sample-buffer renderer (native)';

	/// en: 'Feeds the file's untouched compressed audio straight to the system renderer. Needs the test file URL.'
	String get atmosTestAsbarNativeDescription => 'Feeds the file\'s untouched compressed audio straight to the system renderer. Needs the test file URL.';

	/// en: 'Sample-buffer renderer (rebuilt)'
	String get atmosTestAsbarGenerated => 'Sample-buffer renderer (rebuilt)';

	/// en: 'Same, but with the audio description rebuilt the way playback builds it. Needs the test file URL.'
	String get atmosTestAsbarGeneratedDescription => 'Same, but with the audio description rebuilt the way playback builds it. Needs the test file URL.';

	/// en: 'Use movie playback session mode'
	String get atmosTestSessionMode => 'Use movie playback session mode';

	/// en: 'Off uses the mode Dolby documents. On uses the mode playback used previously.'
	String get atmosTestSessionModeDescription => 'Off uses the mode Dolby documents. On uses the mode playback used previously.';

	/// en: 'Choose AirPlay output'
	String get atmosTestShowRoutePicker => 'Choose AirPlay output';

	/// en: 'Hide AirPlay output picker'
	String get atmosTestHideRoutePicker => 'Hide AirPlay output picker';

	/// en: 'Send the test to an AirPlay receiver. Only AirPlay reports the resolved audio mode.'
	String get atmosTestRoutePickerDescription => 'Send the test to an AirPlay receiver. Only AirPlay reports the resolved audio mode.';

	/// en: 'Stop test'
	String get atmosTestStop => 'Stop test';

	/// en: 'Test file URL'
	String get atmosTestUrl => 'Test file URL';

	/// en: 'HTTP URL of a raw .ec3 Dolby Atmos file (e.g. extracted with ffmpeg)'
	String get atmosTestUrlDescription => 'HTTP URL of a raw .ec3 Dolby Atmos file (e.g. extracted with ffmpeg)';

	/// en: 'Set the test file URL first'
	String get atmosTestUrlMissing => 'Set the test file URL first';

	/// en: 'Status'
	String get atmosTestStatus => 'Status';

	/// en: 'Dolby Vision Conversion'
	String get dvConversionMode => 'Dolby Vision Conversion';

	/// en: 'Choose how ExoPlayer handles Dolby Vision Profile 7 files.'
	String get dvConversionModeDescription => 'Choose how ExoPlayer handles Dolby Vision Profile 7 files.';

	/// en: 'Auto'
	String get dvConversionAuto => 'Auto';

	/// en: 'Native / Disabled'
	String get dvConversionNative => 'Native / Disabled';

	/// en: 'P7 → P8.1'
	String get dvConversionDv81 => 'P7 → P8.1';

	/// en: 'P7 → HEVC'
	String get dvConversionHevcStrip => 'P7 → HEVC';

	/// en: 'Use device capability detection and normal fallback behavior'
	String get dvConversionAutoDescription => 'Use device capability detection and normal fallback behavior';

	/// en: 'Force native DV7 and suppress DV conversion retry'
	String get dvConversionNativeDescription => 'Force native DV7 and suppress DV conversion retry';

	/// en: 'Force inline RPU conversion to Dolby Vision profile 8.1'
	String get dvConversionDv81Description => 'Force inline RPU conversion to Dolby Vision profile 8.1';

	/// en: 'Strip Dolby Vision RPU/EL layers and present plain HEVC'
	String get dvConversionHevcStripDescription => 'Strip Dolby Vision RPU/EL layers and present plain HEVC';

	/// en: 'Ask for profile on app open'
	String get requireProfileSelectionOnOpen => 'Ask for profile on app open';

	/// en: 'Show profile selection every time the app is opened'
	String get requireProfileSelectionOnOpenDescription => 'Show profile selection every time the app is opened';

	/// en: 'Force TV mode'
	String get forceTvMode => 'Force TV mode';

	/// en: 'Force TV layout. For devices that don't auto-detect. Requires restart.'
	String get forceTvModeDescription => 'Force TV layout. For devices that don\'t auto-detect. Requires restart.';

	/// en: 'Auto-Hide Performance Overlay'
	String get autoHidePerformanceOverlay => 'Auto-Hide Performance Overlay';

	/// en: 'Fade the performance overlay with the playback controls'
	String get autoHidePerformanceOverlayDescription => 'Fade the performance overlay with the playback controls';

	/// en: 'Show Navigation Bar Labels'
	String get showNavBarLabels => 'Show Navigation Bar Labels';

	/// en: 'Display text labels under navigation bar icons'
	String get showNavBarLabelsDescription => 'Display text labels under navigation bar icons';

	/// en: 'Startup Section'
	String get startupSection => 'Startup Section';

	/// en: 'Card Shape'
	String get cardOrientation => 'Card Shape';

	/// en: 'Portrait'
	String get cardPortrait => 'Portrait';

	/// en: 'Landscape'
	String get cardLandscape => 'Landscape';

	/// en: 'Display'
	String get display => 'Display';

	/// en: 'Home Screen'
	String get homeScreen => 'Home Screen';

	/// en: 'Navigation'
	String get navigation => 'Navigation';

	/// en: 'Content'
	String get content => 'Content';

	/// en: 'Player'
	String get player => 'Player';

	/// en: 'Subtitles & Configuration'
	String get subtitlesAndConfig => 'Subtitles & Configuration';

	/// en: 'Seek & Timing'
	String get seekAndTiming => 'Seek & Timing';

	/// en: 'Behavior'
	String get behavior => 'Behavior';
}

// Path: search
class Translations$search$en {
	Translations$search$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search movies, shows, music...'
	String get hint => 'Search movies, shows, music...';

	/// en: 'Try a different search term'
	String get tryDifferentTerm => 'Try a different search term';

	/// en: 'Search your media'
	String get searchYourMedia => 'Search your media';

	/// en: 'Enter a title, actor, or keyword'
	String get enterTitleActorOrKeyword => 'Enter a title, actor, or keyword';
}

// Path: hotkeys
class Translations$hotkeys$en {
	Translations$hotkeys$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Set Shortcut for ${actionName}'
	String setShortcutFor({required Object actionName}) => 'Set Shortcut for ${actionName}';

	/// en: 'Clear shortcut'
	String get clearShortcut => 'Clear shortcut';

	/// en: 'No shortcut set'
	String get noShortcutSet => 'No shortcut set';

	/// en: 'Current shortcut:'
	String get currentShortcut => 'Current shortcut:';

	/// en: 'Select to record a shortcut'
	String get pressToRecord => 'Select to record a shortcut';

	/// en: 'Press the shortcut now'
	String get recordingShortcut => 'Press the shortcut now';

	late final Translations$hotkeys$actions$en actions = Translations$hotkeys$actions$en.internal(_root);
}

// Path: fileInfo
class Translations$fileInfo$en {
	Translations$fileInfo$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'File Info'
	String get title => 'File Info';

	/// en: 'Overview'
	String get overview => 'Overview';

	/// en: 'Video'
	String get video => 'Video';

	/// en: 'Audio'
	String get audio => 'Audio';

	/// en: 'Subtitles'
	String get subtitles => 'Subtitles';

	/// en: 'Embedded Images'
	String get images => 'Embedded Images';

	/// en: 'Data Streams'
	String get dataStreams => 'Data Streams';

	/// en: 'Lyrics'
	String get lyrics => 'Lyrics';

	/// en: 'File'
	String get file => 'File';

	/// en: 'Attachments'
	String get attachments => 'Attachments';

	/// en: 'Delivery'
	String get delivery => 'Delivery';

	/// en: 'Version ${index} of ${count}'
	String versionCounter({required Object index, required Object count}) => 'Version ${index} of ${count}';

	/// en: 'File ${index} of ${count}'
	String fileCounter({required Object index, required Object count}) => 'File ${index} of ${count}';

	/// en: 'The server reported no streams for this file.'
	String get noStreams => 'The server reported no streams for this file.';

	/// en: 'Copy path'
	String get copyPath => 'Copy path';

	/// en: 'File path copied'
	String get pathCopied => 'File path copied';

	/// en: 'Codec'
	String get codec => 'Codec';

	/// en: 'Codec Tag'
	String get codecTag => 'Codec Tag';

	/// en: 'Resolution'
	String get resolution => 'Resolution';

	/// en: 'Coded Resolution'
	String get codedResolution => 'Coded Resolution';

	/// en: 'Bitrate'
	String get bitrate => 'Bitrate';

	/// en: 'Frame Rate'
	String get frameRate => 'Frame Rate';

	/// en: 'Rotation'
	String get rotation => 'Rotation';

	/// en: 'Comment'
	String get comment => 'Comment';

	/// en: 'Audio Description'
	String get audioDescription => 'Audio Description';

	/// en: 'Header Compression'
	String get headerCompression => 'Header Compression';

	/// en: 'Sidecar File'
	String get sidecarFile => 'Sidecar File';

	/// en: 'Transport Timestamp'
	String get transportTimestamp => 'Transport Timestamp';

	/// en: 'Display Offset'
	String get displayOffset => 'Display Offset';

	/// en: 'Preview Failure Code'
	String get previewFailureCode => 'Preview Failure Code';

	/// en: 'Preview Retries'
	String get previewRetries => 'Preview Retries';

	/// en: 'Aspect Ratio'
	String get aspectRatio => 'Aspect Ratio';

	/// en: 'Pixel Aspect Ratio'
	String get pixelAspectRatio => 'Pixel Aspect Ratio';

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'Level'
	String get level => 'Level';

	/// en: 'Bit Depth'
	String get bitDepth => 'Bit Depth';

	/// en: 'Pixel Format'
	String get pixelFormat => 'Pixel Format';

	/// en: 'Color Space'
	String get colorSpace => 'Color Space';

	/// en: 'Color Range'
	String get colorRange => 'Color Range';

	/// en: 'Color Primaries'
	String get colorPrimaries => 'Color Primaries';

	/// en: 'Color Transfer'
	String get colorTransfer => 'Color Transfer';

	/// en: 'Chroma Subsampling'
	String get chromaSubsampling => 'Chroma Subsampling';

	/// en: 'Chroma Location'
	String get chromaLocation => 'Chroma Location';

	/// en: 'Scan Type'
	String get scanType => 'Scan Type';

	/// en: 'Interlaced'
	String get interlaced => 'Interlaced';

	/// en: 'Anamorphic'
	String get anamorphic => 'Anamorphic';

	/// en: 'Reference Frames'
	String get referenceFrames => 'Reference Frames';

	/// en: 'Dynamic Range'
	String get dynamicRange => 'Dynamic Range';

	/// en: 'Dolby Vision'
	String get dolbyVision => 'Dolby Vision';

	/// en: 'Dolby Vision Level'
	String get dolbyVisionLevel => 'Dolby Vision Level';

	/// en: 'Dolby Vision Version'
	String get dolbyVisionVersion => 'Dolby Vision Version';

	/// en: 'Dolby Vision Layers'
	String get dolbyVisionLayers => 'Dolby Vision Layers';

	/// en: 'Base Layer Compatibility'
	String get baseLayerCompatibility => 'Base Layer Compatibility';

	/// en: 'AVC Bitstream'
	String get avcBitstream => 'AVC Bitstream';

	/// en: 'NAL Length Size'
	String get nalLengthSize => 'NAL Length Size';

	/// en: 'Custom Scaling Matrix'
	String get scalingMatrix => 'Custom Scaling Matrix';

	/// en: 'Stream Identifier'
	String get streamIdentifier => 'Stream Identifier';

	/// en: 'Stream Index'
	String get streamIndex => 'Stream Index';

	/// en: 'Stream ID'
	String get streamId => 'Stream ID';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Language Code'
	String get languageCode => 'Language Code';

	/// en: 'Track Title'
	String get streamTitle => 'Track Title';

	/// en: 'Channels'
	String get channels => 'Channels';

	/// en: 'Sample Rate'
	String get sampleRate => 'Sample Rate';

	/// en: 'Spatial Audio'
	String get spatialAudio => 'Spatial Audio';

	/// en: 'Text Based'
	String get textBased => 'Text Based';

	/// en: 'Sidecar Format'
	String get subtitleFormat => 'Sidecar Format';

	/// en: 'Provider'
	String get provider => 'Provider';

	/// en: 'Match Score'
	String get matchScore => 'Match Score';

	/// en: 'Can Be Served Separately'
	String get externalDelivery => 'Can Be Served Separately';

	/// en: 'Sidecar Path'
	String get sidecarPath => 'Sidecar Path';

	/// en: 'Copied From'
	String get sourceStream => 'Copied From';

	/// en: 'Temporary'
	String get temporary => 'Temporary';

	/// en: 'Time Base'
	String get timeBase => 'Time Base';

	/// en: 'Overall Bitrate'
	String get overallBitrate => 'Overall Bitrate';

	/// en: 'Path'
	String get path => 'Path';

	/// en: 'File Name'
	String get fileName => 'File Name';

	/// en: 'Size'
	String get size => 'Size';

	/// en: 'Total Size'
	String get totalSize => 'Total Size';

	/// en: 'Container'
	String get container => 'Container';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Preview Thumbnails'
	String get previewThumbnails => 'Preview Thumbnails';

	/// en: 'Preview Index'
	String get previewIndex => 'Preview Index';

	/// en: 'Packet Length'
	String get packetLength => 'Packet Length';

	/// en: 'File Present'
	String get filePresent => 'File Present';

	/// en: 'Readable by Server'
	String get fileReadable => 'Readable by Server';

	/// en: 'Stream Path'
	String get streamPath => 'Stream Path';

	/// en: 'Optimized for Streaming'
	String get optimizedForStreaming => 'Optimized for Streaming';

	/// en: '64-bit Offsets'
	String get has64bitOffsets => '64-bit Offsets';

	/// en: 'Protocol'
	String get protocol => 'Protocol';

	/// en: 'Media Type'
	String get mediaType => 'Media Type';

	/// en: 'Source Kind'
	String get sourceKind => 'Source Kind';

	/// en: 'Optimized Version'
	String get optimizedVersion => 'Optimized Version';

	/// en: 'Optimization Target'
	String get optimizationTarget => 'Optimization Target';

	/// en: 'Deleted'
	String get deletedAt => 'Deleted';

	/// en: 'Remote Source'
	String get remoteSource => 'Remote Source';

	/// en: 'Infinite Stream'
	String get infiniteStream => 'Infinite Stream';

	/// en: 'Direct Play'
	String get directPlay => 'Direct Play';

	/// en: 'Direct Stream'
	String get directStream => 'Direct Stream';

	/// en: 'Transcoding'
	String get transcoding => 'Transcoding';

	/// en: 'ETag'
	String get etag => 'ETag';

	/// en: 'Version ID'
	String get versionId => 'Version ID';

	/// en: 'File ID'
	String get fileId => 'File ID';

	/// en: 'Default Audio Track'
	String get defaultAudioTrack => 'Default Audio Track';

	/// en: 'Default Subtitle Track'
	String get defaultSubtitleTrack => 'Default Subtitle Track';

	/// en: 'Off'
	String get subtitlesOff => 'Off';

	/// en: 'Default'
	String get flagDefault => 'Default';

	/// en: 'Forced'
	String get flagForced => 'Forced';

	/// en: 'Selected'
	String get flagSelected => 'Selected';

	/// en: 'External'
	String get flagExternal => 'External';

	/// en: 'Hearing impaired'
	String get flagHearingImpaired => 'Hearing impaired';

	/// en: 'Dub'
	String get flagDub => 'Dub';

	/// en: 'Original'
	String get flagOriginal => 'Original';
}

// Path: mediaMenu
class Translations$mediaMenu$en {
	Translations$mediaMenu$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Mark as Watched'
	String get markAsWatched => 'Mark as Watched';

	/// en: 'Mark as Unwatched'
	String get markAsUnwatched => 'Mark as Unwatched';

	/// en: 'View details'
	String get viewDetails => 'View details';

	/// en: 'Go to series'
	String get goToSeries => 'Go to series';

	/// en: 'Shuffle Play'
	String get shufflePlay => 'Shuffle Play';

	/// en: 'Shuffle not available offline'
	String get shuffleNotAvailableOffline => 'Shuffle not available offline';

	/// en: 'File Info'
	String get fileInfo => 'File Info';

	/// en: 'Delete from server'
	String get deleteFromServer => 'Delete from server';

	/// en: 'Delete this media and its files from your server?'
	String get confirmDelete => 'Delete this media and its files from your server?';

	/// en: 'This includes all episodes and their files.'
	String get deleteMultipleWarning => 'This includes all episodes and their files.';

	/// en: 'Media item deleted successfully'
	String get mediaDeletedSuccessfully => 'Media item deleted successfully';

	/// en: 'Failed to delete media item'
	String get mediaFailedToDelete => 'Failed to delete media item';

	/// en: 'Rate'
	String get rate => 'Rate';

	/// en: 'Play from Beginning'
	String get playFromBeginning => 'Play from Beginning';

	/// en: 'Play Version...'
	String get playVersion => 'Play Version...';
}

// Path: rateSheet
class Translations$rateSheet$en {
	Translations$rateSheet$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server'
	String get server => 'Server';

	/// en: 'Favorite'
	String get favorite => 'Favorite';

	/// en: 'Favorited'
	String get favorited => 'Favorited';

	/// en: 'Saved'
	String get saved => 'Saved';

	/// en: 'No match found'
	String get notAvailable => 'No match found';

	/// en: 'Connect a service in Settings to rate there.'
	String get noConnectedServices => 'Connect a service in Settings to rate there.';
}

// Path: accessibility
class Translations$accessibility$en {
	Translations$accessibility$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${title}, movie'
	String mediaCardMovie({required Object title}) => '${title}, movie';

	/// en: '${title}, TV show'
	String mediaCardShow({required Object title}) => '${title}, TV show';

	/// en: '${title}, ${episodeInfo}'
	String mediaCardEpisode({required Object title, required Object episodeInfo}) => '${title}, ${episodeInfo}';

	/// en: '${title}, ${seasonInfo}'
	String mediaCardSeason({required Object title, required Object seasonInfo}) => '${title}, ${seasonInfo}';

	/// en: 'watched'
	String get mediaCardWatched => 'watched';

	/// en: '${percent} percent watched'
	String mediaCardPartiallyWatched({required Object percent}) => '${percent} percent watched';

	/// en: 'unwatched'
	String get mediaCardUnwatched => 'unwatched';

	/// en: 'Tap to play'
	String get tapToPlay => 'Tap to play';

	/// en: 'Decrease'
	String get decrease => 'Decrease';

	/// en: 'Increase'
	String get increase => 'Increase';

	/// en: 'Decrease ${label}'
	String decreaseValue({required Object label}) => 'Decrease ${label}';

	/// en: 'Increase ${label}'
	String increaseValue({required Object label}) => 'Increase ${label}';

	/// en: 'Hue'
	String get hue => 'Hue';

	/// en: 'Saturation'
	String get saturation => 'Saturation';

	/// en: 'Brightness'
	String get brightness => 'Brightness';

	/// en: 'Hex color'
	String get hexColor => 'Hex color';

	/// en: 'Expand text'
	String get expandText => 'Expand text';

	/// en: 'Collapse text'
	String get collapseText => 'Collapse text';

	/// en: 'Alphabet navigation'
	String get alphabetNavigation => 'Alphabet navigation';

	/// en: 'Swipe up or down to move by letter'
	String get alphabetScrollHint => 'Swipe up or down to move by letter';

	/// en: 'Row ${row} of ${rowCount}, column ${column} of ${columnCount}'
	String rowColumnPosition({required Object row, required Object rowCount, required Object column, required Object columnCount}) => 'Row ${row} of ${rowCount}, column ${column} of ${columnCount}';

	/// en: 'Row ${row} of ${rowCount}'
	String rowPosition({required Object row, required Object rowCount}) => 'Row ${row} of ${rowCount}';
}

// Path: tooltips
class Translations$tooltips$en {
	Translations$tooltips$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Shuffle play'
	String get shufflePlay => 'Shuffle play';

	/// en: 'Play trailer'
	String get playTrailer => 'Play trailer';

	/// en: 'Mark as watched'
	String get markAsWatched => 'Mark as watched';

	/// en: 'Mark as unwatched'
	String get markAsUnwatched => 'Mark as unwatched';

	/// en: 'More options'
	String get moreOptions => 'More options';
}

// Path: audioTracks
class Translations$audioTracks$en {
	Translations$audioTracks$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Audio Track ${n}'
	String track({required Object n}) => 'Audio Track ${n}';
}

// Path: videoControls
class Translations$videoControls$en {
	Translations$videoControls$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Audio'
	String get audioLabel => 'Audio';

	/// en: 'Subtitles'
	String get subtitlesLabel => 'Subtitles';

	/// en: 'Reset to 0ms'
	String get resetToZero => 'Reset to 0ms';

	/// en: '+${amount}${unit}'
	String addTime({required Object amount, required Object unit}) => '+${amount}${unit}';

	/// en: '-${amount}${unit}'
	String minusTime({required Object amount, required Object unit}) => '-${amount}${unit}';

	/// en: '${label} plays later'
	String playsLater({required Object label}) => '${label} plays later';

	/// en: '${label} plays earlier'
	String playsEarlier({required Object label}) => '${label} plays earlier';

	/// en: 'No offset'
	String get noOffset => 'No offset';

	/// en: 'Letterbox'
	String get letterbox => 'Letterbox';

	/// en: 'Fill screen'
	String get fillScreen => 'Fill screen';

	/// en: 'Stretch'
	String get stretch => 'Stretch';

	/// en: 'Lock rotation'
	String get lockRotation => 'Lock rotation';

	/// en: 'Unlock rotation'
	String get unlockRotation => 'Unlock rotation';

	/// en: 'Timer Active'
	String get timerActive => 'Timer Active';

	/// en: 'Playback will pause in ${duration}'
	String playbackWillPauseIn({required Object duration}) => 'Playback will pause in ${duration}';

	/// en: 'End of current video'
	String get sleepTimerEndOfVideo => 'End of current video';

	/// en: 'Stop at'
	String get sleepTimerStopAtHeader => 'Stop at';

	/// en: 'Timer'
	String get sleepTimerDurationHeader => 'Timer';

	/// en: 'Playback will pause at the end of this video'
	String get playbackWillPauseAtEnd => 'Playback will pause at the end of this video';

	/// en: 'Still watching?'
	String get stillWatching => 'Still watching?';

	/// en: 'Pausing in ${seconds}s'
	String pausingIn({required Object seconds}) => 'Pausing in ${seconds}s';

	/// en: 'Continue'
	String get continueWatching => 'Continue';

	/// en: 'Auto-Play Next'
	String get autoPlayNext => 'Auto-Play Next';

	/// en: 'Play Next'
	String get playNext => 'Play Next';

	/// en: 'Play'
	String get playButton => 'Play';

	/// en: 'Pause'
	String get pauseButton => 'Pause';

	/// en: 'Paused'
	String get playbackPaused => 'Paused';

	/// en: 'Playing'
	String get playbackResumed => 'Playing';

	/// en: 'Show playback controls'
	String get showPlaybackControls => 'Show playback controls';

	/// en: 'Hide playback controls'
	String get hidePlaybackControls => 'Hide playback controls';

	/// en: 'Seek backward ${seconds} seconds'
	String seekBackwardButton({required Object seconds}) => 'Seek backward ${seconds} seconds';

	/// en: 'Seek forward ${seconds} seconds'
	String seekForwardButton({required Object seconds}) => 'Seek forward ${seconds} seconds';

	/// en: 'Previous episode'
	String get previousButton => 'Previous episode';

	/// en: 'Next episode'
	String get nextButton => 'Next episode';

	/// en: 'Previous chapter'
	String get previousChapterButton => 'Previous chapter';

	/// en: 'Next chapter'
	String get nextChapterButton => 'Next chapter';

	/// en: 'Mute'
	String get muteButton => 'Mute';

	/// en: 'Unmute'
	String get unmuteButton => 'Unmute';

	/// en: 'Playback Settings'
	String get settingsButton => 'Playback Settings';

	/// en: 'Audio & Subtitles'
	String get tracksButton => 'Audio & Subtitles';

	/// en: 'Chapters'
	String get chaptersButton => 'Chapters';

	/// en: 'Version & Quality'
	String get versionQualityButton => 'Version & Quality';

	/// en: 'Version'
	String get versionColumnHeader => 'Version';

	/// en: 'Quality'
	String get qualityColumnHeader => 'Quality';

	/// en: 'Original'
	String get qualityOriginal => 'Original';

	/// en: '${resolution}p ${bitrate} Mbps'
	String qualityPresetLabel({required Object resolution, required Object bitrate}) => '${resolution}p ${bitrate} Mbps';

	/// en: 'Transcoding unavailable — playing original quality'
	String get transcodeUnavailableFallback => 'Transcoding unavailable — playing original quality';

	/// en: 'Selected subtitles could not be loaded — continuing without subtitles'
	String get subtitleUnavailableFallback => 'Selected subtitles could not be loaded — continuing without subtitles';

	/// en: 'Picture-in-Picture mode'
	String get pipButton => 'Picture-in-Picture mode';

	/// en: 'Aspect ratio'
	String get aspectRatioButton => 'Aspect ratio';

	/// en: 'Ambient lighting'
	String get ambientLighting => 'Ambient lighting';

	/// en: 'Rotation lock'
	String get rotationLockButton => 'Rotation lock';

	/// en: 'Lock screen'
	String get lockScreen => 'Lock screen';

	/// en: 'Screen lock'
	String get screenLockButton => 'Screen lock';

	/// en: 'Long press to unlock'
	String get longPressToUnlock => 'Long press to unlock';

	/// en: 'Video timeline'
	String get timelineSlider => 'Video timeline';

	/// en: 'Volume level'
	String get volumeSlider => 'Volume level';

	/// en: 'Ends at ${time}'
	String endsAt({required Object time}) => 'Ends at ${time}';

	/// en: 'Playing in Picture-in-Picture'
	String get pipActive => 'Playing in Picture-in-Picture';

	/// en: 'Picture-in-picture failed to start'
	String get pipFailed => 'Picture-in-picture failed to start';

	/// en: 'Screenshot saved'
	String get screenshotSaved => 'Screenshot saved';

	/// en: 'Zoom ${percent}%'
	String zoomPercent({required Object percent}) => 'Zoom ${percent}%';

	late final Translations$videoControls$pipErrors$en pipErrors = Translations$videoControls$pipErrors$en.internal(_root);

	/// en: 'Chapters'
	String get chapters => 'Chapters';

	/// en: 'No chapters available'
	String get noChaptersAvailable => 'No chapters available';

	/// en: 'Queue'
	String get queue => 'Queue';

	/// en: 'No items in queue'
	String get noQueueItems => 'No items in queue';
}

// Path: messages
class Translations$messages$en {
	Translations$messages$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Marked as watched'
	String get markedAsWatched => 'Marked as watched';

	/// en: 'Marked as unwatched'
	String get markedAsUnwatched => 'Marked as unwatched';

	/// en: 'Marked as watched (will sync when online)'
	String get markedAsWatchedOffline => 'Marked as watched (will sync when online)';

	/// en: 'Marked as unwatched (will sync when online)'
	String get markedAsUnwatchedOffline => 'Marked as unwatched (will sync when online)';

	/// en: 'Auto-removed: ${title}'
	String autoRemovedWatchedDownload({required Object title}) => 'Auto-removed: ${title}';

	/// en: '(one) {Auto-removed ${n} watched download} (other) {Auto-removed ${n} watched downloads}'
	String autoRemovedWatchedDownloads({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Auto-removed ${n} watched download',
		other: 'Auto-removed ${n} watched downloads',
	);

	/// en: 'Error: ${error}'
	String errorLoading({required Object error}) => 'Error: ${error}';

	/// en: 'Some media servers could not be searched. Showing available results.'
	String get searchPartialResults => 'Some media servers could not be searched. Showing available results.';

	/// en: 'The stream was interrupted. Press play or seek to retry.'
	String get streamInterrupted => 'The stream was interrupted. Press play or seek to retry.';

	/// en: 'File information not available'
	String get fileInfoNotAvailable => 'File information not available';

	/// en: 'Sign in to the media server again to play this item.'
	String get playbackAuthenticationRequired => 'Sign in to the media server again to play this item.';

	/// en: 'The media server is unavailable. Try again later.'
	String get playbackServerUnavailable => 'The media server is unavailable. Try again later.';

	/// en: 'The server returned invalid playback information.'
	String get playbackDataInvalid => 'The server returned invalid playback information.';

	/// en: 'Playback was canceled.'
	String get playbackCancelled => 'Playback was canceled.';

	/// en: 'Playback could not be started.'
	String get playbackFailed => 'Playback could not be started.';

	/// en: 'Error loading file info: ${error}'
	String errorLoadingFileInfo({required Object error}) => 'Error loading file info: ${error}';

	/// en: 'Error loading series'
	String get errorLoadingSeries => 'Error loading series';

	/// en: 'Music playback is not yet supported'
	String get musicNotSupported => 'Music playback is not yet supported';

	/// en: 'No description available'
	String get noDescriptionAvailable => 'No description available';

	/// en: 'No profiles available'
	String get noProfilesAvailable => 'No profiles available';

	/// en: 'Contact your server administrator to add profiles'
	String get contactAdminForProfiles => 'Contact your server administrator to add profiles';

	/// en: 'Unable to determine library section for this item'
	String get unableToDetermineLibrarySection => 'Unable to determine library section for this item';

	/// en: 'Logs cleared'
	String get logsCleared => 'Logs cleared';

	/// en: 'Logs copied to clipboard'
	String get logsCopied => 'Logs copied to clipboard';

	/// en: 'No logs available'
	String get noLogsAvailable => 'No logs available';

	/// en: 'Refreshing metadata for "${title}"...'
	String metadataRefreshing({required Object title}) => 'Refreshing metadata for "${title}"...';

	/// en: 'Metadata refresh started for "${title}"'
	String metadataRefreshStarted({required Object title}) => 'Metadata refresh started for "${title}"';

	/// en: 'Failed to refresh metadata: ${error}'
	String metadataRefreshFailed({required Object error}) => 'Failed to refresh metadata: ${error}';

	/// en: 'Are you sure you want to log out?'
	String get logoutConfirm => 'Are you sure you want to log out?';

	/// en: 'No seasons found'
	String get noSeasonsFound => 'No seasons found';

	/// en: 'Couldn't load seasons'
	String get seasonsLoadFailed => 'Couldn\'t load seasons';

	/// en: 'No episodes found in first season'
	String get noEpisodesFound => 'No episodes found in first season';

	/// en: 'No episodes found'
	String get noEpisodesFoundGeneral => 'No episodes found';

	/// en: 'Couldn't load episodes'
	String get episodesLoadFailed => 'Couldn\'t load episodes';

	/// en: 'No results found'
	String get noResultsFound => 'No results found';

	/// en: 'Sleep timer set for ${label}'
	String sleepTimerSet({required Object label}) => 'Sleep timer set for ${label}';

	/// en: 'No items available'
	String get noItemsAvailable => 'No items available';

	/// en: 'Failed to create a play queue — no items'
	String get failedToCreatePlayQueueNoItems => 'Failed to create a play queue — no items';

	/// en: 'Failed to ${action}: ${error}'
	String failedPlayback({required Object action, required Object error}) => 'Failed to ${action}: ${error}';

	/// en: 'Switching to compatible player...'
	String get switchingToCompatiblePlayer => 'Switching to compatible player...';

	/// en: 'Playback failed'
	String get serverLimitTitle => 'Playback failed';

	/// en: 'Server error (HTTP 500). A bandwidth/transcoding limit likely rejected this session. Ask the owner to adjust it.'
	String get serverLimitBody => 'Server error (HTTP 500). A bandwidth/transcoding limit likely rejected this session. Ask the owner to adjust it.';
}

// Path: subtitlingStyling
class Translations$subtitlingStyling$en {
	Translations$subtitlingStyling$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Text'
	String get text => 'Text';

	/// en: 'Border'
	String get border => 'Border';

	/// en: 'Background'
	String get background => 'Background';

	/// en: 'Font Size'
	String get fontSize => 'Font Size';

	/// en: 'Text Color'
	String get textColor => 'Text Color';

	/// en: 'Border Size'
	String get borderSize => 'Border Size';

	/// en: 'Border Color'
	String get borderColor => 'Border Color';

	/// en: 'Background Opacity'
	String get backgroundOpacity => 'Background Opacity';

	/// en: 'Background Color'
	String get backgroundColor => 'Background Color';

	/// en: 'Position'
	String get position => 'Position';

	/// en: 'ASS Override'
	String get assOverride => 'ASS Override';

	/// en: 'Scale'
	String get overrideScale => 'Scale';

	/// en: 'Force'
	String get overrideForce => 'Force';

	/// en: 'Remove styling'
	String get overrideStrip => 'Remove styling';

	/// en: 'Top'
	String get positionTop => 'Top';

	/// en: 'Bottom'
	String get positionBottom => 'Bottom';

	/// en: 'Bold'
	String get bold => 'Bold';

	/// en: 'Italic'
	String get italic => 'Italic';

	/// en: 'Render Resolution'
	String get renderResolution => 'Render Resolution';

	/// en: 'Screen resolution'
	String get renderResolutionScreen => 'Screen resolution';

	/// en: 'Video resolution'
	String get renderResolutionVideo => 'Video resolution';
}

// Path: mpvConfig
class Translations$mpvConfig$en {
	Translations$mpvConfig$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'mpv.conf'
	String get title => 'mpv.conf';

	/// en: 'Advanced video player settings'
	String get description => 'Advanced video player settings';

	/// en: 'Presets'
	String get presets => 'Presets';

	/// en: 'No saved presets'
	String get noPresets => 'No saved presets';

	/// en: 'Save as Preset...'
	String get saveAsPreset => 'Save as Preset...';

	/// en: 'Preset Name'
	String get presetName => 'Preset Name';

	/// en: 'Enter a name for this preset'
	String get presetNameHint => 'Enter a name for this preset';

	/// en: 'Load'
	String get loadPreset => 'Load';

	/// en: 'Delete'
	String get deletePreset => 'Delete';

	/// en: 'Preset saved'
	String get presetSaved => 'Preset saved';

	/// en: 'Preset loaded'
	String get presetLoaded => 'Preset loaded';

	/// en: 'Preset deleted'
	String get presetDeleted => 'Preset deleted';

	/// en: 'Are you sure you want to delete this preset?'
	String get confirmDeletePreset => 'Are you sure you want to delete this preset?';

	/// en: 'gpu-api=vulkan hwdec=auto # comment'
	String get configPlaceholder => 'gpu-api=vulkan\nhwdec=auto\n# comment';
}

// Path: dialog
class Translations$dialog$en {
	Translations$dialog$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Confirm Action'
	String get confirmAction => 'Confirm Action';
}

// Path: profiles
class Translations$profiles$en {
	Translations$profiles$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Harbor profile'
	String get addLocalProfile => 'Add Harbor profile';

	/// en: 'Switching profile…'
	String get switchingProfile => 'Switching profile…';

	/// en: 'Delete this profile?'
	String get deleteThisProfileTitle => 'Delete this profile?';

	/// en: 'Remove ${displayName}. Connections aren't affected.'
	String deleteThisProfileMessage({required Object displayName}) => 'Remove ${displayName}. Connections aren\'t affected.';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Manage'
	String get manage => 'Manage';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Profiles'
	String get sectionTitle => 'Profiles';

	/// en: 'Add profiles to mix managed users and local identities'
	String get summarySingle => 'Add profiles to mix managed users and local identities';

	/// en: '${count} profiles · active: ${activeName}'
	String summaryMultipleWithActive({required Object count, required Object activeName}) => '${count} profiles · active: ${activeName}';

	/// en: '${count} profiles'
	String summaryMultiple({required Object count}) => '${count} profiles';

	/// en: 'Remove connection?'
	String get removeConnectionTitle => 'Remove connection?';

	/// en: 'Remove ${displayName}'s access to ${connectionLabel}. Other profiles keep it.'
	String removeConnectionMessage({required Object displayName, required Object connectionLabel}) => 'Remove ${displayName}\'s access to ${connectionLabel}. Other profiles keep it.';

	/// en: 'Delete profile?'
	String get deleteProfileTitle => 'Delete profile?';

	/// en: 'Remove ${displayName} and its connections. Servers stay available.'
	String deleteProfileMessage({required Object displayName}) => 'Remove ${displayName} and its connections. Servers stay available.';

	/// en: 'Profile name'
	String get profileNameLabel => 'Profile name';

	/// en: 'PIN protection'
	String get pinProtectionLabel => 'PIN protection';

	/// en: 'Set PIN'
	String get setPin => 'Set PIN';

	/// en: 'Set PIN'
	String get setPinTitle => 'Set PIN';

	/// en: 'Confirm PIN'
	String get confirmPinTitle => 'Confirm PIN';

	/// en: 'PIN set'
	String get pinSet => 'PIN set';

	/// en: 'Change'
	String get changePin => 'Change';

	/// en: 'Remove'
	String get removePin => 'Remove';

	/// en: 'Connections'
	String get connectionsLabel => 'Connections';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Delete profile'
	String get deleteProfileButton => 'Delete profile';

	/// en: 'No connections — add one to use this profile.'
	String get noConnectionsHint => 'No connections — add one to use this profile.';

	/// en: 'No connections'
	String get noConnections => 'No connections';

	/// en: 'Default'
	String get connectionDefault => 'Default';

	/// en: 'Make default'
	String get makeDefault => 'Make default';

	/// en: 'Remove'
	String get removeConnection => 'Remove';

	/// en: 'Profile renamed.'
	String get profileRenamed => 'Profile renamed.';

	/// en: 'Add to ${displayName}'
	String borrowAddTo({required Object displayName}) => 'Add to ${displayName}';

	/// en: 'Borrow another profile's connection. PIN-protected profiles require a PIN.'
	String get borrowExplain => 'Borrow another profile\'s connection. PIN-protected profiles require a PIN.';

	/// en: 'Nothing to borrow yet.'
	String get borrowEmpty => 'Nothing to borrow yet.';

	/// en: 'Connect Plex or Jellyfin to another profile first.'
	String get borrowEmptySubtitle => 'Connect Plex or Jellyfin to another profile first.';

	/// en: 'Available connections could not be loaded. Try again.'
	String get borrowLoadFailed => 'Available connections could not be loaded. Try again.';

	/// en: 'From ${displayName}'
	String borrowFromProfile({required Object displayName}) => 'From ${displayName}';

	/// en: 'Connection borrowed.'
	String get borrowConnectionBorrowed => 'Connection borrowed.';

	/// en: 'Failed to borrow connection.'
	String get borrowFailed => 'Failed to borrow connection.';

	/// en: 'Incorrect PIN.'
	String get incorrectPin => 'Incorrect PIN.';

	/// en: 'Incorrect PIN. Please try again.'
	String get incorrectPinTryAgain => 'Incorrect PIN. Please try again.';

	/// en: 'New profile'
	String get newProfile => 'New profile';

	/// en: 'e.g. Guests, Kids, Family Room'
	String get profileNameHint => 'e.g. Guests, Kids, Family Room';

	/// en: 'PIN protection (optional)'
	String get pinProtectionOptional => 'PIN protection (optional)';

	/// en: '4-digit PIN required to switch profiles.'
	String get pinExplain => '4-digit PIN required to switch profiles.';

	/// en: 'Continue'
	String get continueButton => 'Continue';

	/// en: 'PINs don't match'
	String get pinsDontMatch => 'PINs don\'t match';
}

// Path: connections
class Translations$connections$en {
	Translations$connections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Connections'
	String get sectionTitle => 'Connections';

	/// en: 'Add connection'
	String get addConnection => 'Add connection';

	/// en: 'Sign in with Plex or connect a Jellyfin server'
	String get addConnectionSubtitleNoProfile => 'Sign in with Plex or connect a Jellyfin server';

	/// en: 'Add to ${displayName}: Plex, Jellyfin, or another profile connection'
	String addConnectionSubtitleScoped({required Object displayName}) => 'Add to ${displayName}: Plex, Jellyfin, or another profile connection';

	/// en: 'Session expired for ${name}'
	String sessionExpiredOne({required Object name}) => 'Session expired for ${name}';

	/// en: 'Session expired for ${count} servers'
	String sessionExpiredMany({required Object count}) => 'Session expired for ${count} servers';

	/// en: 'Sign in again'
	String get signInAgain => 'Sign in again';

	/// en: 'Edit Jellyfin connection'
	String get editJellyfinTitle => 'Edit Jellyfin connection';

	/// en: 'Add or remove URLs for ${serverName}. Harbor will use the reachable URL with the lowest latency.'
	String editJellyfinIntro({required Object serverName}) => 'Add or remove URLs for ${serverName}. Harbor will use the reachable URL with the lowest latency.';
}

// Path: discover
class Translations$discover$en {
	Translations$discover$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Discover'
	String get title => 'Discover';

	/// en: 'No content available'
	String get noContentAvailable => 'No content available';

	/// en: 'Add some media to your libraries'
	String get addMediaToLibraries => 'Add some media to your libraries';

	/// en: 'Continue Watching'
	String get continueWatching => 'Continue Watching';

	/// en: 'Continue Watching in ${library}'
	String continueWatchingIn({required Object library}) => 'Continue Watching in ${library}';

	/// en: 'Next Up in ${library}'
	String nextUpIn({required Object library}) => 'Next Up in ${library}';

	/// en: 'Recently Added in ${library}'
	String recentlyAddedIn({required Object library}) => 'Recently Added in ${library}';

	/// en: 'Latest Albums in ${library}'
	String latestAlbumsIn({required Object library}) => 'Latest Albums in ${library}';

	/// en: 'Recently Played in ${library}'
	String recentlyPlayedIn({required Object library}) => 'Recently Played in ${library}';

	/// en: 'Most Played in ${library}'
	String mostPlayedIn({required Object library}) => 'Most Played in ${library}';

	/// en: 'S${season}E${episode}'
	String playEpisode({required Object season, required Object episode}) => 'S${season}E${episode}';

	/// en: 'Cast'
	String get cast => 'Cast';

	/// en: 'Trailers & Extras'
	String get extras => 'Trailers & Extras';

	/// en: 'Studio'
	String get studio => 'Studio';

	/// en: 'Director'
	String get director => 'Director';

	/// en: 'Directors'
	String get directors => 'Directors';

	/// en: 'Movie'
	String get movie => 'Movie';

	/// en: 'TV Show'
	String get tvShow => 'TV Show';

	/// en: '${minutes} min left'
	String minutesLeft({required Object minutes}) => '${minutes} min left';

	/// en: 'More Like This'
	String get moreLikeThis => 'More Like This';

	/// en: 'Genres'
	String get genres => 'Genres';
}

// Path: errors
class Translations$errors$en {
	Translations$errors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search failed: ${error}'
	String searchFailed({required Object error}) => 'Search failed: ${error}';

	/// en: 'Search could not reach any media server.'
	String get searchUnavailable => 'Search could not reach any media server.';

	/// en: 'Connection timeout while loading ${context}'
	String connectionTimeout({required Object context}) => 'Connection timeout while loading ${context}';

	/// en: 'Unable to connect to media server'
	String get connectionFailed => 'Unable to connect to media server';

	/// en: 'Unable to load ${context}. Please try again.'
	String unableToLoad({required Object context}) => 'Unable to load ${context}. Please try again.';

	/// en: 'No client available'
	String get noClientAvailable => 'No client available';

	/// en: 'Failed to switch to ${displayName}'
	String failedToSwitchProfile({required Object displayName}) => 'Failed to switch to ${displayName}';

	/// en: 'Failed to delete ${displayName}'
	String failedToDeleteProfile({required Object displayName}) => 'Failed to delete ${displayName}';

	/// en: 'Couldn't update rating'
	String get failedToRate => 'Couldn\'t update rating';
}

// Path: libraries
class Translations$libraries$en {
	Translations$libraries$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Libraries'
	String get title => 'Libraries';

	/// en: 'Library'
	String get fallbackTitle => 'Library';

	/// en: 'Refresh Metadata'
	String get refreshMetadata => 'Refresh Metadata';

	/// en: 'No libraries found'
	String get noLibrariesFound => 'No libraries found';

	/// en: 'All libraries are hidden'
	String get allLibrariesHidden => 'All libraries are hidden';

	/// en: 'Hidden libraries (${count})'
	String hiddenLibrariesCount({required Object count}) => 'Hidden libraries (${count})';

	/// en: 'This library is empty'
	String get thisLibraryIsEmpty => 'This library is empty';

	/// en: 'No items match the active filters'
	String get noItemsMatchFilters => 'No items match the active filters';

	/// en: 'Reset filters'
	String get resetFilters => 'Reset filters';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Clear All'
	String get clearAll => 'Clear All';

	/// en: 'Are you sure you want to refresh metadata for "${title}"?'
	String refreshMetadataConfirm({required Object title}) => 'Are you sure you want to refresh metadata for "${title}"?';

	/// en: 'Manage Libraries'
	String get manageLibraries => 'Manage Libraries';

	/// en: 'Sort'
	String get sort => 'Sort';

	/// en: 'Sort By'
	String get sortBy => 'Sort By';

	/// en: 'Filters'
	String get filters => 'Filters';

	/// en: 'Are you sure you want to perform this action?'
	String get confirmActionMessage => 'Are you sure you want to perform this action?';

	/// en: 'Show library'
	String get showLibrary => 'Show library';

	/// en: 'Hide library'
	String get hideLibrary => 'Hide library';

	/// en: 'Library options'
	String get libraryOptions => 'Library options';

	/// en: 'library content'
	String get content => 'library content';

	/// en: 'Select library'
	String get selectLibrary => 'Select library';

	/// en: 'Filters (${count})'
	String filtersWithCount({required Object count}) => 'Filters (${count})';

	/// en: 'No collections in this library'
	String get noCollections => 'No collections in this library';

	/// en: 'No folders found'
	String get noFoldersFound => 'No folders found';

	/// en: 'folders'
	String get folders => 'folders';

	late final Translations$libraries$tabs$en tabs = Translations$libraries$tabs$en.internal(_root);
	late final Translations$libraries$groupings$en groupings = Translations$libraries$groupings$en.internal(_root);
	late final Translations$libraries$filterCategories$en filterCategories = Translations$libraries$filterCategories$en.internal(_root);
	late final Translations$libraries$sortLabels$en sortLabels = Translations$libraries$sortLabels$en.internal(_root);
}

// Path: about
class Translations$about$en {
	Translations$about$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About'
	String get title => 'About';

	/// en: 'Open Source Licenses'
	String get openSourceLicenses => 'Open Source Licenses';

	/// en: 'Version ${version}'
	String versionLabel({required Object version}) => 'Version ${version}';

	/// en: 'A beautiful Plex and Jellyfin client for Flutter'
	String get appDescription => 'A beautiful Plex and Jellyfin client for Flutter';

	/// en: 'View licenses of third-party libraries'
	String get viewLicensesDescription => 'View licenses of third-party libraries';
}

// Path: hubDetail
class Translations$hubDetail$en {
	Translations$hubDetail$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Title'
	String get title => 'Title';

	/// en: 'Release Year'
	String get releaseYear => 'Release Year';

	/// en: 'Date Added'
	String get dateAdded => 'Date Added';

	/// en: 'Rating'
	String get rating => 'Rating';

	/// en: 'No items found'
	String get noItemsFound => 'No items found';
}

// Path: logs
class Translations$logs$en {
	Translations$logs$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Clear Logs'
	String get clearLogs => 'Clear Logs';

	/// en: 'Copy Logs'
	String get copyLogs => 'Copy Logs';
}

// Path: licenses
class Translations$licenses$en {
	Translations$licenses$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Related Packages'
	String get relatedPackages => 'Related Packages';

	/// en: 'License'
	String get license => 'License';

	/// en: 'License ${number}'
	String licenseNumber({required Object number}) => 'License ${number}';

	/// en: '${count} licenses'
	String licensesCount({required Object count}) => '${count} licenses';
}

// Path: navigation
class Translations$navigation$en {
	Translations$navigation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Libraries'
	String get libraries => 'Libraries';

	/// en: 'Downloads'
	String get downloads => 'Downloads';

	/// en: 'Explore'
	String get explore => 'Explore';
}

// Path: explore
class Translations$explore$en {
	Translations$explore$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Explore'
	String get title => 'Explore';

	/// en: 'Select source'
	String get selectSource => 'Select source';

	late final Translations$explore$rows$en rows = Translations$explore$rows$en.internal(_root);
	late final Translations$explore$status$en status = Translations$explore$status$en.internal(_root);

	/// en: '(one) {${n} episode} (other) {${n} episodes}'
	String episodeCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} episode',
		other: '${n} episodes',
	);

	/// en: '(one) {${n} season} (other) {${n} seasons}'
	String seasonCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} season',
		other: '${n} seasons',
	);

	/// en: 'Cast'
	String get cast => 'Cast';

	/// en: 'Characters'
	String get characters => 'Characters';

	/// en: 'Add to Watchlist'
	String get addToWatchlist => 'Add to Watchlist';

	/// en: 'Remove from Watchlist'
	String get removeFromWatchlist => 'Remove from Watchlist';

	/// en: 'Couldn't update watchlist'
	String get watchlistUpdateFailed => 'Couldn\'t update watchlist';

	/// en: 'Not in your library'
	String get notInLibrary => 'Not in your library';

	/// en: 'In these libraries'
	String get inTheseLibraries => 'In these libraries';

	/// en: 'Checking your library...'
	String get checkingLibrary => 'Checking your library...';

	/// en: 'Nothing here yet'
	String get emptyTitle => 'Nothing here yet';

	/// en: 'Rows from ${source} will appear here once they have content.'
	String emptyMessage({required Object source}) => 'Rows from ${source} will appear here once they have content.';

	/// en: 'Search ${source}'
	String searchHint({required Object source}) => 'Search ${source}';

	/// en: 'No results for "${query}"'
	String searchEmpty({required Object query}) => 'No results for "${query}"';

	/// en: 'Search for movies and shows on ${source}.'
	String searchPrompt({required Object source}) => 'Search for movies and shows on ${source}.';

	/// en: 'Search failed. Check your connection and try again.'
	String get searchFailed => 'Search failed. Check your connection and try again.';

	late final Translations$explore$badge$en badge = Translations$explore$badge$en.internal(_root);
	late final Translations$explore$stats$en stats = Translations$explore$stats$en.internal(_root);
	late final Translations$explore$season$en season = Translations$explore$season$en.internal(_root);
	late final Translations$explore$format$en format = Translations$explore$format$en.internal(_root);
	late final Translations$explore$sourceMaterial$en sourceMaterial = Translations$explore$sourceMaterial$en.internal(_root);
	late final Translations$explore$creditRole$en creditRole = Translations$explore$creditRole$en.internal(_root);
	late final Translations$explore$ratingSource$en ratingSource = Translations$explore$ratingSource$en.internal(_root);

	/// en: 'Airs ${day} at ${time}'
	String broadcast({required Object day, required Object time}) => 'Airs ${day} at ${time}';

	/// en: 'Airs ${day} at ${time} ${timezone}'
	String broadcastWithZone({required Object day, required Object time, required Object timezone}) => 'Airs ${day} at ${time} ${timezone}';

	late final Translations$explore$detail$en detail = Translations$explore$detail$en.internal(_root);
	late final Translations$explore$relation$en relation = Translations$explore$relation$en.internal(_root);
}

// Path: collections
class Translations$collections$en {
	Translations$collections$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Collection'
	String get collection => 'Collection';

	/// en: 'Collection is empty'
	String get empty => 'Collection is empty';

	/// en: 'Delete Collection'
	String get deleteCollection => 'Delete Collection';

	/// en: 'Delete "${title}"? This can't be undone.'
	String deleteConfirm({required Object title}) => 'Delete "${title}"? This can\'t be undone.';

	/// en: 'Collection deleted'
	String get deleted => 'Collection deleted';

	/// en: 'Failed to delete collection'
	String get deleteFailed => 'Failed to delete collection';

	/// en: 'Failed to delete collection: ${error}'
	String deleteFailedWithError({required Object error}) => 'Failed to delete collection: ${error}';

	/// en: 'Select Collection'
	String get selectCollection => 'Select Collection';

	/// en: 'Collection Name'
	String get collectionName => 'Collection Name';

	/// en: 'Enter collection name'
	String get enterCollectionName => 'Enter collection name';

	/// en: 'Added to collection'
	String get addedToCollection => 'Added to collection';

	/// en: 'Failed to add to collection'
	String get errorAddingToCollection => 'Failed to add to collection';

	/// en: 'Collection created'
	String get created => 'Collection created';

	/// en: 'Remove from collection'
	String get removeFromCollection => 'Remove from collection';

	/// en: 'Remove "${title}" from this collection?'
	String removeFromCollectionConfirm({required Object title}) => 'Remove "${title}" from this collection?';

	/// en: 'Removed from collection'
	String get removedFromCollection => 'Removed from collection';

	/// en: 'Failed to remove from collection'
	String get removeFromCollectionFailed => 'Failed to remove from collection';

	/// en: 'Error removing from collection: ${error}'
	String removeFromCollectionError({required Object error}) => 'Error removing from collection: ${error}';

	/// en: 'Search collections...'
	String get searchCollections => 'Search collections...';
}

// Path: playlists
class Translations$playlists$en {
	Translations$playlists$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Playlists'
	String get title => 'Playlists';

	/// en: 'Playlist'
	String get playlist => 'Playlist';

	/// en: 'No playlists found'
	String get noPlaylists => 'No playlists found';

	/// en: 'Create Playlist'
	String get create => 'Create Playlist';

	/// en: 'Playlist Name'
	String get playlistName => 'Playlist Name';

	/// en: 'Enter playlist name'
	String get enterPlaylistName => 'Enter playlist name';

	/// en: 'Delete Playlist'
	String get delete => 'Delete Playlist';

	/// en: 'Remove from Playlist'
	String get removeItem => 'Remove from Playlist';

	/// en: 'Smart Playlist'
	String get smartPlaylist => 'Smart Playlist';

	/// en: '${count} items'
	String itemCount({required Object count}) => '${count} items';

	/// en: '1 item'
	String get oneItem => '1 item';

	/// en: 'This playlist is empty'
	String get emptyPlaylist => 'This playlist is empty';

	/// en: 'Delete Playlist?'
	String get deleteConfirm => 'Delete Playlist?';

	/// en: 'Are you sure you want to delete "${name}"?'
	String deleteMessage({required Object name}) => 'Are you sure you want to delete "${name}"?';

	/// en: 'Playlist created'
	String get created => 'Playlist created';

	/// en: 'Playlist deleted'
	String get deleted => 'Playlist deleted';

	/// en: 'Added to playlist'
	String get itemAdded => 'Added to playlist';

	/// en: 'Removed from playlist'
	String get itemRemoved => 'Removed from playlist';

	/// en: 'Select Playlist'
	String get selectPlaylist => 'Select Playlist';

	/// en: 'Search playlists...'
	String get searchPlaylists => 'Search playlists...';

	/// en: 'Failed to create playlist'
	String get errorCreating => 'Failed to create playlist';

	/// en: 'Failed to delete playlist'
	String get errorDeleting => 'Failed to delete playlist';

	/// en: 'Failed to load playlists'
	String get errorLoading => 'Failed to load playlists';

	/// en: 'Failed to add to playlist'
	String get errorAdding => 'Failed to add to playlist';

	/// en: 'Failed to reorder playlist item'
	String get errorReordering => 'Failed to reorder playlist item';

	/// en: 'Failed to remove from playlist'
	String get errorRemoving => 'Failed to remove from playlist';
}

// Path: music
class Translations$music$en {
	Translations$music$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Go to album'
	String get goToAlbum => 'Go to album';

	/// en: 'Go to artist'
	String get goToArtist => 'Go to artist';

	/// en: 'Instant Mix'
	String get instantMix => 'Instant Mix';

	/// en: 'Play next'
	String get playNext => 'Play next';

	/// en: 'Add to queue'
	String get addToQueue => 'Add to queue';

	/// en: 'Disc ${n}'
	String discNumber({required Object n}) => 'Disc ${n}';

	/// en: '(one) {${n} track} (other) {${n} tracks}'
	String trackCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} track',
		other: '${n} tracks',
	);

	/// en: 'Now Playing'
	String get nowPlaying => 'Now Playing';

	/// en: 'Playing from ${title}'
	String playingFrom({required Object title}) => 'Playing from ${title}';

	/// en: 'Queue'
	String get queue => 'Queue';

	/// en: 'Clear queue'
	String get clearQueue => 'Clear queue';

	/// en: 'Lyrics'
	String get lyrics => 'Lyrics';

	/// en: 'No lyrics available'
	String get noLyrics => 'No lyrics available';

	/// en: 'Sleep timer'
	String get sleepTimer => 'Sleep timer';

	/// en: 'End of track'
	String get sleepTimerEndOfTrack => 'End of track';

	/// en: '${n} minutes'
	String sleepTimerMinutes({required Object n}) => '${n} minutes';

	/// en: 'Stop playback'
	String get stopPlayback => 'Stop playback';

	/// en: 'Previous track'
	String get previousTrack => 'Previous track';

	/// en: 'Next track'
	String get nextTrack => 'Next track';

	/// en: 'Repeat'
	String get repeat => 'Repeat';

	/// en: 'Repeat all'
	String get repeatAll => 'Repeat all';

	/// en: 'Repeat one'
	String get repeatOne => 'Repeat one';
}

// Path: downloads
class Translations$downloads$en {
	Translations$downloads$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Downloads'
	String get title => 'Downloads';

	/// en: 'Manage'
	String get manage => 'Manage';

	/// en: 'TV Shows'
	String get tvShows => 'TV Shows';

	/// en: 'Movies'
	String get movies => 'Movies';

	/// en: 'Music'
	String get music => 'Music';

	/// en: '${count} tracks queued for download'
	String tracksQueued({required Object count}) => '${count} tracks queued for download';

	/// en: 'No downloads yet'
	String get noDownloads => 'No downloads yet';

	/// en: 'Downloaded content will appear here for offline viewing'
	String get noDownloadsDescription => 'Downloaded content will appear here for offline viewing';

	/// en: 'Download'
	String get downloadNow => 'Download';

	/// en: 'Delete download'
	String get deleteDownload => 'Delete download';

	/// en: 'Retry download'
	String get retryDownload => 'Retry download';

	/// en: 'Download queued'
	String get downloadQueued => 'Download queued';

	/// en: 'Download resumed'
	String get downloadResumed => 'Download resumed';

	/// en: 'Server error: file may exceed the remote bitrate limit'
	String get serverErrorBitrate => 'Server error: file may exceed the remote bitrate limit';

	/// en: 'Downloads stopped because device storage is full. Free some space, then retry.'
	String get storageFull => 'Downloads stopped because device storage is full. Free some space, then retry.';

	/// en: '${count} episodes queued for download'
	String episodesQueued({required Object count}) => '${count} episodes queued for download';

	/// en: 'Download deleted'
	String get downloadDeleted => 'Download deleted';

	/// en: 'Delete "${title}" from this device?'
	String deleteConfirm({required Object title}) => 'Delete "${title}" from this device?';

	/// en: 'Canceled Download'
	String get cancelledDownloadTitle => 'Canceled Download';

	/// en: 'This download was canceled. What would you like to do?'
	String get cancelledDownloadMessage => 'This download was canceled. What would you like to do?';

	/// en: 'All episodes already downloaded'
	String get allEpisodesAlreadyDownloaded => 'All episodes already downloaded';

	/// en: 'Resume download'
	String get resumeDownload => 'Resume download';

	/// en: 'Canceled download'
	String get cancelledDownload => 'Canceled download';

	/// en: '${file} (syncing ${status})'
	String syncingFile({required Object file, required Object status}) => '${file} (syncing ${status})';

	/// en: 'Downloaded ${file} - Click to complete'
	String downloadedFileClickToComplete({required Object file}) => 'Downloaded ${file} - Click to complete';

	/// en: 'Partially downloaded - Click to complete'
	String get partialDownloadClickToComplete => 'Partially downloaded - Click to complete';

	/// en: 'Deleting...'
	String get deleting => 'Deleting...';

	/// en: 'Deleting ${title}... (${current} of ${total})'
	String deletingWithProgress({required Object title, required Object current, required Object total}) => 'Deleting ${title}... (${current} of ${total})';

	/// en: 'Queued'
	String get queuedTooltip => 'Queued';

	/// en: 'Queued ${files}'
	String queuedFilesTooltip({required Object files}) => 'Queued ${files}';

	/// en: 'Downloading...'
	String get downloadingTooltip => 'Downloading...';

	/// en: 'Downloading ${files}'
	String downloadingFilesTooltip({required Object files}) => 'Downloading ${files}';

	/// en: 'No downloads'
	String get noDownloadsTree => 'No downloads';

	/// en: 'Pause all'
	String get pauseAll => 'Pause all';

	/// en: 'Resume all'
	String get resumeAll => 'Resume all';

	/// en: 'Delete all'
	String get deleteAll => 'Delete all';

	/// en: 'Select Version'
	String get selectVersion => 'Select Version';

	/// en: 'All episodes'
	String get allEpisodes => 'All episodes';

	/// en: 'Unwatched only'
	String get unwatchedOnly => 'Unwatched only';

	/// en: 'Next ${count} unwatched'
	String nextNUnwatched({required Object count}) => 'Next ${count} unwatched';

	/// en: 'Custom amount...'
	String get customAmount => 'Custom amount...';

	/// en: 'Include Specials'
	String get includeSpecials => 'Include Specials';

	/// en: 'How many episodes?'
	String get howManyEpisodes => 'How many episodes?';

	/// en: 'Enter a valid episode count.'
	String get invalidEpisodeCount => 'Enter a valid episode count.';

	/// en: 'Keep synced'
	String get keepSynced => 'Keep synced';

	/// en: 'Download once'
	String get downloadOnce => 'Download once';

	/// en: 'Keep ${count} unwatched'
	String keepNUnwatched({required Object count}) => 'Keep ${count} unwatched';

	/// en: 'Edit sync rule'
	String get editSyncRule => 'Edit sync rule';

	/// en: 'Remove sync rule'
	String get removeSyncRule => 'Remove sync rule';

	/// en: 'Stop syncing "${title}"? Downloaded episodes will be kept.'
	String removeSyncRuleConfirm({required Object title}) => 'Stop syncing "${title}"? Downloaded episodes will be kept.';

	/// en: 'Stop syncing "${title}"?'
	String removeListSyncRuleConfirm({required Object title}) => 'Stop syncing "${title}"?';

	/// en: 'Also delete associated downloads'
	String get deleteSyncRuleDownloads => 'Also delete associated downloads';

	/// en: 'Downloads used by another sync rule or profile will be kept.'
	String get deleteSyncRuleDownloadsDescription => 'Downloads used by another sync rule or profile will be kept.';

	/// en: 'Sync rule created — keeping ${count} unwatched episodes'
	String syncRuleCreated({required Object count}) => 'Sync rule created — keeping ${count} unwatched episodes';

	/// en: 'Sync rule updated'
	String get syncRuleUpdated => 'Sync rule updated';

	/// en: 'Sync rule removed'
	String get syncRuleRemoved => 'Sync rule removed';

	/// en: 'Sync rule and associated downloads removed'
	String get syncRuleAndDownloadsRemoved => 'Sync rule and associated downloads removed';

	/// en: 'Sync rules are currently updating. Try again in a moment.'
	String get syncRuleCleanupBusy => 'Sync rules are currently updating. Try again in a moment.';

	/// en: 'Associated downloads could not be identified safely. Reconnect the server and try again, or remove the rule without deleting downloads.'
	String get syncRuleCleanupUnavailable => 'Associated downloads could not be identified safely. Reconnect the server and try again, or remove the rule without deleting downloads.';

	/// en: 'Synced ${count} new episodes for ${title}'
	String syncedNewEpisodes({required Object count, required Object title}) => 'Synced ${count} new episodes for ${title}';

	/// en: 'Sync rules'
	String get activeSyncRules => 'Sync rules';

	/// en: 'No sync rules'
	String get noSyncRules => 'No sync rules';

	/// en: 'Manage sync'
	String get manageSyncRule => 'Manage sync';

	/// en: 'Episode count'
	String get editEpisodeCount => 'Episode count';

	/// en: 'Sync filter'
	String get editSyncFilter => 'Sync filter';

	/// en: 'Syncing all items'
	String get syncAllItems => 'Syncing all items';

	/// en: 'Syncing unwatched items'
	String get syncUnwatchedItems => 'Syncing unwatched items';

	/// en: 'Server: ${server} • ${status}'
	String syncRuleServerContext({required Object server, required Object status}) => 'Server: ${server} • ${status}';

	/// en: 'Available'
	String get syncRuleAvailable => 'Available';

	/// en: 'Offline'
	String get syncRuleOffline => 'Offline';

	/// en: 'Sign in required'
	String get syncRuleSignInRequired => 'Sign in required';

	/// en: 'Not available for current profile'
	String get syncRuleNotAvailableForProfile => 'Not available for current profile';

	/// en: 'Unknown server'
	String get syncRuleUnknownServer => 'Unknown server';

	/// en: 'Sync rule created'
	String get syncRuleListCreated => 'Sync rule created';

	late final Translations$downloads$backgroundWarning$en backgroundWarning = Translations$downloads$backgroundWarning$en.internal(_root);
}

// Path: shaders
class Translations$shaders$en {
	Translations$shaders$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Shaders'
	String get title => 'Shaders';

	/// en: 'No video enhancement'
	String get noShaderDescription => 'No video enhancement';

	/// en: 'NVIDIA image scaling for sharper video'
	String get nvscalerDescription => 'NVIDIA image scaling for sharper video';

	/// en: 'Neutral'
	String get artcnnVariantNeutral => 'Neutral';

	/// en: 'Denoise'
	String get artcnnVariantDenoise => 'Denoise';

	/// en: 'Denoise + Sharpen'
	String get artcnnVariantDenoiseSharpen => 'Denoise + Sharpen';

	/// en: 'Fast'
	String get qualityFast => 'Fast';

	/// en: 'High Quality'
	String get qualityHQ => 'High Quality';

	/// en: 'Mode'
	String get mode => 'Mode';

	/// en: 'Import Shader'
	String get importShader => 'Import Shader';

	/// en: 'Custom GLSL shader'
	String get customShaderDescription => 'Custom GLSL shader';

	/// en: 'Shader imported'
	String get shaderImported => 'Shader imported';

	/// en: 'Failed to import shader'
	String get shaderImportFailed => 'Failed to import shader';

	/// en: 'Delete Shader'
	String get deleteShader => 'Delete Shader';

	/// en: 'Delete "${name}"?'
	String deleteShaderConfirm({required Object name}) => 'Delete "${name}"?';
}

// Path: videoSettings
class Translations$videoSettings$en {
	Translations$videoSettings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Playback Speed'
	String get playbackSpeed => 'Playback Speed';

	/// en: 'Normal'
	String get normalSpeed => 'Normal';

	/// en: 'Active (${duration})'
	String sleepTimerActive({required Object duration}) => 'Active (${duration})';

	/// en: 'Zoom'
	String get zoom => 'Zoom';

	/// en: 'Sleep Timer'
	String get sleepTimer => 'Sleep Timer';

	/// en: 'Audio Sync'
	String get audioSync => 'Audio Sync';

	/// en: 'Subtitle Sync'
	String get subtitleSync => 'Subtitle Sync';

	/// en: 'HDR'
	String get hdr => 'HDR';

	/// en: 'Audio Output'
	String get audioOutput => 'Audio Output';

	/// en: 'Performance Overlay'
	String get performanceOverlay => 'Performance Overlay';

	/// en: 'Audio Passthrough'
	String get audioPassthrough => 'Audio Passthrough';

	/// en: 'Dolby Atmos'
	String get audioOutputDolbyAtmos => 'Dolby Atmos';

	/// en: 'Dolby Audio'
	String get audioOutputDolbyAudio => 'Dolby Audio';

	/// en: 'Surround'
	String get audioOutputSurround => 'Surround';

	/// en: 'Spatial Audio'
	String get audioOutputSpatial => 'Spatial Audio';

	/// en: 'Stereo'
	String get audioOutputStereo => 'Stereo';

	/// en: 'Normalize Loudness'
	String get audioNormalization => 'Normalize Loudness';

	/// en: 'Downmix to Stereo'
	String get audioDownmix => 'Downmix to Stereo';
}

// Path: performanceOverlay
class Translations$performanceOverlay$en {
	Translations$performanceOverlay$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Color'
	String get color => 'Color';

	/// en: 'Performance'
	String get performance => 'Performance';

	/// en: 'Buffer'
	String get buffer => 'Buffer';

	/// en: 'App'
	String get app => 'App';

	/// en: 'Decoder'
	String get decoder => 'Decoder';

	/// en: 'Raw Decoder'
	String get rawDecoder => 'Raw Decoder';

	/// en: 'Tunneling'
	String get tunneling => 'Tunneling';

	/// en: 'Aspect'
	String get aspect => 'Aspect';

	/// en: 'Rotation'
	String get rotation => 'Rotation';

	/// en: 'DV Source'
	String get dvSource => 'DV Source';

	/// en: 'DV Path'
	String get dvPath => 'DV Path';

	/// en: 'P7 Conv'
	String get p7Conversion => 'P7 Conv';

	/// en: 'Sample Rate'
	String get sampleRate => 'Sample Rate';

	/// en: 'Pixel Fmt'
	String get pixelFormat => 'Pixel Fmt';

	/// en: 'HW Fmt'
	String get hwFormat => 'HW Fmt';

	/// en: 'Matrix'
	String get matrix => 'Matrix';

	/// en: 'Primaries'
	String get primaries => 'Primaries';

	/// en: 'Transfer'
	String get transfer => 'Transfer';

	/// en: 'Render FPS'
	String get renderFps => 'Render FPS';

	/// en: 'Display FPS'
	String get displayFps => 'Display FPS';

	/// en: 'A/V Sync'
	String get avSync => 'A/V Sync';

	/// en: 'Dropped'
	String get dropped => 'Dropped';

	/// en: 'DV RPUs'
	String get dvRpus => 'DV RPUs';

	/// en: 'DV RPU Avg'
	String get dvRpuAverage => 'DV RPU Avg';

	/// en: 'DV Sample Avg'
	String get dvSampleAverage => 'DV Sample Avg';

	/// en: 'Max Luma'
	String get maxLuma => 'Max Luma';

	/// en: 'Min Luma'
	String get minLuma => 'Min Luma';

	/// en: 'MaxCLL'
	String get maxCll => 'MaxCLL';

	/// en: 'MaxFALL'
	String get maxFall => 'MaxFALL';

	/// en: 'Cache Used'
	String get cacheUsed => 'Cache Used';

	/// en: 'Cache Limit'
	String get cacheLimit => 'Cache Limit';

	/// en: 'Speed'
	String get speed => 'Speed';

	/// en: 'Player'
	String get player => 'Player';

	/// en: 'Memory'
	String get memory => 'Memory';

	/// en: 'UI FPS'
	String get uiFps => 'UI FPS';
}

// Path: externalPlayer
class Translations$externalPlayer$en {
	Translations$externalPlayer$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'External Player'
	String get title => 'External Player';

	/// en: 'Use External Player'
	String get useExternalPlayer => 'Use External Player';

	/// en: 'Open videos in another app'
	String get useExternalPlayerDescription => 'Open videos in another app';

	/// en: 'Select Player'
	String get selectPlayer => 'Select Player';

	/// en: 'Custom Players'
	String get customPlayers => 'Custom Players';

	/// en: 'System Default'
	String get systemDefault => 'System Default';

	/// en: 'Add Custom Player'
	String get addCustomPlayer => 'Add Custom Player';

	/// en: 'Player Name'
	String get playerName => 'Player Name';

	/// en: 'My Player'
	String get playerNameHint => 'My Player';

	/// en: 'Command'
	String get playerCommand => 'Command';

	/// en: 'Package Name'
	String get playerPackage => 'Package Name';

	/// en: 'URL Scheme'
	String get playerUrlScheme => 'URL Scheme';

	/// en: 'Off'
	String get off => 'Off';

	/// en: 'Failed to open external player'
	String get launchFailed => 'Failed to open external player';

	/// en: '${name} is not installed'
	String appNotInstalled({required Object name}) => '${name} is not installed';

	/// en: 'Play in External Player'
	String get playInExternalPlayer => 'Play in External Player';
}

// Path: metadataEdit
class Translations$metadataEdit$en {
	Translations$metadataEdit$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit...'
	String get editMetadata => 'Edit...';

	/// en: 'Edit Metadata'
	String get screenTitle => 'Edit Metadata';

	/// en: 'Basic Info'
	String get basicInfo => 'Basic Info';

	/// en: 'Artwork'
	String get artwork => 'Artwork';

	/// en: 'Title'
	String get title => 'Title';

	/// en: 'Sort Title'
	String get sortTitle => 'Sort Title';

	/// en: 'Original Title'
	String get originalTitle => 'Original Title';

	/// en: 'Release Date'
	String get releaseDate => 'Release Date';

	/// en: 'Content Rating'
	String get contentRating => 'Content Rating';

	/// en: 'Studio'
	String get studio => 'Studio';

	/// en: 'Tagline'
	String get tagline => 'Tagline';

	/// en: 'Summary'
	String get summary => 'Summary';

	/// en: 'Poster'
	String get poster => 'Poster';

	/// en: 'Background'
	String get background => 'Background';

	/// en: 'Logo'
	String get logo => 'Logo';

	/// en: 'Square Art'
	String get squareArt => 'Square Art';

	/// en: 'Select Poster'
	String get selectPoster => 'Select Poster';

	/// en: 'Select Background'
	String get selectBackground => 'Select Background';

	/// en: 'Select Logo'
	String get selectLogo => 'Select Logo';

	/// en: 'Select Square Art'
	String get selectSquareArt => 'Select Square Art';

	/// en: 'From URL'
	String get fromUrl => 'From URL';

	/// en: 'Upload File'
	String get uploadFile => 'Upload File';

	/// en: 'Enter image URL'
	String get enterImageUrl => 'Enter image URL';

	/// en: 'Image URL'
	String get imageUrl => 'Image URL';

	/// en: 'Metadata updated'
	String get metadataUpdated => 'Metadata updated';

	/// en: 'Failed to update metadata'
	String get metadataUpdateFailed => 'Failed to update metadata';

	/// en: 'Artwork updated'
	String get artworkUpdated => 'Artwork updated';

	/// en: 'Failed to update artwork'
	String get artworkUpdateFailed => 'Failed to update artwork';

	/// en: 'No artwork available'
	String get noArtworkAvailable => 'No artwork available';

	/// en: 'Artwork option ${index}'
	String artworkOption({required Object index}) => 'Artwork option ${index}';

	/// en: 'Artwork option ${index}, selected'
	String selectedArtworkOption({required Object index}) => 'Artwork option ${index}, selected';

	/// en: 'Not set'
	String get notSet => 'Not set';

	/// en: 'Tags'
	String get tags => 'Tags';

	/// en: 'Add tag'
	String get addTag => 'Add tag';

	/// en: 'Genre'
	String get genre => 'Genre';

	/// en: 'Director'
	String get director => 'Director';

	/// en: 'Writer'
	String get writer => 'Writer';

	/// en: 'Producer'
	String get producer => 'Producer';

	/// en: 'Country'
	String get country => 'Country';

	/// en: 'Label'
	String get label => 'Label';
}

// Path: trakt
class Translations$trakt$en {
	Translations$trakt$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Trakt'
	String get title => 'Trakt';

	/// en: 'Connected'
	String get connected => 'Connected';

	/// en: 'Connected as @${username}'
	String connectedAs({required Object username}) => 'Connected as @${username}';

	/// en: 'Disconnect Trakt account?'
	String get disconnectConfirm => 'Disconnect Trakt account?';

	/// en: 'Harbor will stop sending events to Trakt. You can reconnect any time.'
	String get disconnectConfirmBody => 'Harbor will stop sending events to Trakt. You can reconnect any time.';

	/// en: 'Real-time scrobbling'
	String get scrobble => 'Real-time scrobbling';

	/// en: 'Send play, pause, and stop events to Trakt during playback.'
	String get scrobbleDescription => 'Send play, pause, and stop events to Trakt during playback.';

	/// en: 'Sync watched status'
	String get watchedSync => 'Sync watched status';

	/// en: 'When you mark items as watched in Harbor, they are also marked as watched on Trakt.'
	String get watchedSyncDescription => 'When you mark items as watched in Harbor, they are also marked as watched on Trakt.';
}

// Path: seerr
class Translations$seerr$en {
	Translations$seerr$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Seerr'
	String get title => 'Seerr';

	/// en: 'Connect Seerr'
	String get connectTitle => 'Connect Seerr';

	/// en: 'Server URL'
	String get serverUrl => 'Server URL';

	/// en: 'The address of your Seerr instance'
	String get serverUrlHelper => 'The address of your Seerr instance';

	/// en: 'Continue'
	String get checkServer => 'Continue';

	/// en: 'Sign in with Jellyfin'
	String get signInWithJellyfin => 'Sign in with Jellyfin';

	/// en: 'Sign in with Emby'
	String get signInWithEmby => 'Sign in with Emby';

	/// en: 'Use a local account'
	String get signInWithLocal => 'Use a local account';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'This Seerr instance offers no sign-in method Harbor supports.'
	String get noSignInMethods => 'This Seerr instance offers no sign-in method Harbor supports.';

	/// en: 'Instance'
	String get instance => 'Instance';

	/// en: 'Disconnect Seerr?'
	String get disconnectConfirm => 'Disconnect Seerr?';

	/// en: 'Harbor will forget this Seerr instance. Reconnect any time.'
	String get disconnectConfirmBody => 'Harbor will forget this Seerr instance. Reconnect any time.';

	/// en: 'Request'
	String get request => 'Request';

	/// en: 'Request in 4K'
	String get request4k => 'Request in 4K';

	/// en: 'Seasons'
	String get seasons => 'Seasons';

	/// en: 'All seasons'
	String get allSeasons => 'All seasons';

	/// en: 'Advanced'
	String get advancedOptions => 'Advanced';

	/// en: 'Destination server'
	String get destinationServer => 'Destination server';

	/// en: 'Quality profile'
	String get qualityProfile => 'Quality profile';

	/// en: 'Root folder'
	String get rootFolder => 'Root folder';

	/// en: 'Language profile'
	String get languageProfile => 'Language profile';

	/// en: 'Request submitted'
	String get requestSubmitted => 'Request submitted';

	/// en: 'Request failed: ${error}'
	String requestFailed({required Object error}) => 'Request failed: ${error}';

	/// en: 'Couldn't load request options'
	String get requestsLoadFailed => 'Couldn\'t load request options';

	/// en: 'Everything is already available or requested.'
	String get nothingToRequest => 'Everything is already available or requested.';

	/// en: 'Available'
	String get statusAvailable => 'Available';

	/// en: 'Partially available'
	String get statusPartiallyAvailable => 'Partially available';

	/// en: 'Requested'
	String get statusRequested => 'Requested';

	/// en: 'Processing'
	String get statusProcessing => 'Processing';
}

// Path: services
class Translations$services$en {
	Translations$services$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Services'
	String get title => 'Services';

	/// en: 'Sync watch progress and request new titles.'
	String get hubSubtitle => 'Sync watch progress and request new titles.';

	/// en: 'Not connected'
	String get notConnected => 'Not connected';

	/// en: 'Connected as @${username}'
	String connectedAs({required Object username}) => 'Connected as @${username}';

	/// en: 'Track progress automatically'
	String get scrobble => 'Track progress automatically';

	/// en: 'Update your list when you finish an episode or movie.'
	String get scrobbleDescription => 'Update your list when you finish an episode or movie.';

	/// en: 'Disconnect ${service}?'
	String disconnectConfirm({required Object service}) => 'Disconnect ${service}?';

	/// en: 'Harbor will stop updating ${service}. Reconnect any time.'
	String disconnectConfirmBody({required Object service}) => 'Harbor will stop updating ${service}. Reconnect any time.';

	/// en: 'Couldn't connect to ${service}. Try again.'
	String connectFailed({required Object service}) => 'Couldn\'t connect to ${service}. Try again.';

	late final Translations$services$names$en names = Translations$services$names$en.internal(_root);
	late final Translations$services$deviceCode$en deviceCode = Translations$services$deviceCode$en.internal(_root);
	late final Translations$services$libraryFilter$en libraryFilter = Translations$services$libraryFilter$en.internal(_root);
}

// Path: addServer
class Translations$addServer$en {
	Translations$addServer$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Jellyfin server'
	String get addJellyfinTitle => 'Add Jellyfin server';

	/// en: 'Server URLs'
	String get serverUrls => 'Server URLs';

	/// en: 'Multiple URLs allowed, separated by commas.'
	String get serverUrlsHelper => 'Multiple URLs allowed, separated by commas.';

	/// en: 'Find server'
	String get findServer => 'Find server';

	/// en: 'Looking for local Jellyfin servers...'
	String get searchingLocalServers => 'Looking for local Jellyfin servers...';

	/// en: 'Local Jellyfin servers'
	String get localServers => 'Local Jellyfin servers';

	/// en: 'Username'
	String get username => 'Username';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Sign in'
	String get signIn => 'Sign in';

	/// en: 'Change'
	String get change => 'Change';

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'Could not reach the server: ${error}'
	String couldNotReachServer({required Object error}) => 'Could not reach the server: ${error}';

	/// en: 'Sign-in failed: ${error}'
	String signInFailed({required Object error}) => 'Sign-in failed: ${error}';

	/// en: 'Quick Connect failed: ${error}'
	String quickConnectFailed({required Object error}) => 'Quick Connect failed: ${error}';

	/// en: 'Enter your Jellyfin server URL'
	String get enterJellyfinUrlError => 'Enter your Jellyfin server URL';

	/// en: 'Add connection'
	String get addConnectionTitle => 'Add connection';

	/// en: 'Add to ${name}'
	String addConnectionTitleScoped({required Object name}) => 'Add to ${name}';

	/// en: 'Connect to Jellyfin'
	String get connectToJellyfinCard => 'Connect to Jellyfin';

	/// en: 'Enter your server URL, username, and password.'
	String get connectToJellyfinCardSubtitle => 'Enter your server URL, username, and password.';

	/// en: 'Sign in to a Jellyfin server. Binds to ${name}.'
	String connectToJellyfinCardSubtitleScoped({required Object name}) => 'Sign in to a Jellyfin server. Binds to ${name}.';

	/// en: 'Borrow from another profile'
	String get borrowFromAnotherProfile => 'Borrow from another profile';

	/// en: 'Reuse another profile's connection. PIN-protected profiles require a PIN.'
	String get borrowFromAnotherProfileSubtitle => 'Reuse another profile\'s connection. PIN-protected profiles require a PIN.';
}

// Path: managedServices
class Translations$managedServices$en {
	Translations$managedServices$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Media servers'
	String get sectionTitle => 'Media servers';

	/// en: 'Add a service'
	String get add => 'Add a service';

	/// en: 'Add a service'
	String get addTitle => 'Add a service';

	late final Translations$managedServices$kinds$en kinds = Translations$managedServices$kinds$en.internal(_root);
	late final Translations$managedServices$kindHints$en kindHints = Translations$managedServices$kindHints$en.internal(_root);

	/// en: 'Address'
	String get addressLabel => 'Address';

	/// en: 'radarr.home.lan:7878'
	String get addressHint => 'radarr.home.lan:7878';

	/// en: 'API key'
	String get apiKeyLabel => 'API key';

	/// en: 'Settings → General → API Key in ${service}.'
	String apiKeyHelp({required Object service}) => 'Settings → General → API Key in ${service}.';

	/// en: 'Username'
	String get usernameLabel => 'Username';

	/// en: 'Password'
	String get passwordLabel => 'Password';

	/// en: 'Name (optional)'
	String get nameLabel => 'Name (optional)';

	/// en: 'Radarr 4K'
	String get nameHint => 'Radarr 4K';

	/// en: 'Shown instead of the address. Useful when you run more than one.'
	String get nameHelp => 'Shown instead of the address. Useful when you run more than one.';

	/// en: 'Connect'
	String get connect => 'Connect';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Connected'
	String get connected => 'Connected';

	/// en: 'Reconnect'
	String get reconnect => 'Reconnect';

	/// en: 'Unreachable'
	String get unreachable => 'Unreachable';

	/// en: 'Checking…'
	String get checking => 'Checking…';

	/// en: 'Check again'
	String get recheck => 'Check again';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Remove ${name}?'
	String removeConfirm({required Object name}) => 'Remove ${name}?';

	/// en: 'Harbor stops reading from it. Nothing on the server changes.'
	String get removeConfirmBody => 'Harbor stops reading from it. Nothing on the server changes.';

	/// en: 'Enter the address Harbor should reach it on.'
	String get addressRequired => 'Enter the address Harbor should reach it on.';

	/// en: 'Enter the API key.'
	String get apiKeyRequired => 'Enter the API key.';

	/// en: 'Enter the username.'
	String get usernameRequired => 'Enter the username.';

	/// en: '${service} rejected that key.'
	String keyRejected({required Object service}) => '${service} rejected that key.';

	/// en: 'That username and password were refused.'
	String get loginRejected => 'That username and password were refused.';

	/// en: 'Could not reach ${address}.'
	String notReachable({required Object address}) => 'Could not reach ${address}.';

	/// en: 'That address answered, but not like ${service}. Check the port and any base path.'
	String notThisService({required Object service}) => 'That address answered, but not like ${service}. Check the port and any base path.';
}

// Path: serverActivity
class Translations$serverActivity$en {
	Translations$serverActivity$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server'
	String get tab => 'Server';

	late final Translations$serverActivity$stages$en stages = Translations$serverActivity$stages$en.internal(_root);

	/// en: 'Stalled'
	String get stalled => 'Stalled';

	/// en: 'Paused'
	String get paused => 'Paused';

	/// en: 'Completed'
	String get completedHeading => 'Completed';

	/// en: 'Nothing downloading'
	String get nothingQueued => 'Nothing downloading';

	/// en: 'When Radarr or Sonarr grabs something, it shows up here.'
	String get nothingQueuedDescription => 'When Radarr or Sonarr grabs something, it shows up here.';

	/// en: 'No media servers connected'
	String get noServices => 'No media servers connected';

	/// en: 'Add Radarr, Sonarr or your download client to watch what is arriving.'
	String get noServicesDescription => 'Add Radarr, Sonarr or your download client to watch what is arriving.';

	/// en: 'Add a service'
	String get openServices => 'Add a service';

	/// en: 'Could not reach ${names}'
	String unreachable({required Object names}) => 'Could not reach ${names}';

	/// en: '${time} left'
	String etaRemaining({required Object time}) => '${time} left';

	/// en: '${done} of ${total}'
	String ofSize({required Object done, required Object total}) => '${done} of ${total}';

	/// en: 'Arriving'
	String get arriving => 'Arriving';

	/// en: 'S${season}E${episode} arriving'
	String arrivingEpisode({required Object season, required Object episode}) => 'S${season}E${episode} arriving';

	/// en: 'Monitored'
	String get monitored => 'Monitored';

	/// en: 'Not monitored'
	String get notMonitored => 'Not monitored';

	/// en: '${count} missing'
	String missingEpisodes({required Object count}) => '${count} missing';

	/// en: 'All episodes present'
	String get allPresent => 'All episodes present';

	/// en: 'On disk'
	String get onDisk => 'On disk';

	/// en: 'Not on disk'
	String get notOnDisk => 'Not on disk';

	/// en: '+${count} more queued'
	String alsoQueued({required Object count}) => '+${count} more queued';

	/// en: 'Next episode ${when}'
	String nextAiring({required Object when}) => 'Next episode ${when}';

	/// en: 'Aired ${date}'
	String airedOn({required Object date}) => 'Aired ${date}';

	/// en: 'Airs ${date}'
	String airsOn({required Object date}) => 'Airs ${date}';

	/// en: 'Unmonitored'
	String get unmonitored => 'Unmonitored';

	/// en: 'Not downloaded'
	String get notDownloadedOne => 'Not downloaded';

	/// en: 'S${season}E${episode}'
	String episodeSlot({required Object season, required Object episode}) => 'S${season}E${episode}';

	/// en: 'Nothing missing'
	String get nothingMissing => 'Nothing missing';

	/// en: '${service} has a file for everything it is tracking here.'
	String nothingMissingDescription({required Object service}) => '${service} has a file for everything it is tracking here.';
}

// Path: arrSearch
class Translations$arrSearch$en {
	Translations$arrSearch$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search'
	String get title => 'Search';

	/// en: 'Search automatically'
	String get auto => 'Search automatically';

	/// en: 'Hand it to ${service} and let it pick.'
	String autoDescription({required Object service}) => 'Hand it to ${service} and let it pick.';

	/// en: 'Choose a release'
	String get manual => 'Choose a release';

	/// en: 'Ask the indexers and pick one yourself.'
	String get manualDescription => 'Ask the indexers and pick one yourself.';

	/// en: 'Asking the indexers…'
	String get searching => 'Asking the indexers…';

	/// en: 'This can take a while.'
	String get searchingSlow => 'This can take a while.';

	/// en: 'No releases found'
	String get noReleases => 'No releases found';

	/// en: 'The indexers had nothing for this.'
	String get noReleasesDescription => 'The indexers had nothing for this.';

	/// en: 'Search failed'
	String get failed => 'Search failed';

	/// en: 'Searching in ${service}'
	String handedOver({required Object service}) => 'Searching in ${service}';

	/// en: 'Sent to ${service}'
	String grabbed({required Object service}) => 'Sent to ${service}';

	/// en: '${service} refused that release'
	String grabFailed({required Object service}) => '${service} refused that release';

	/// en: 'Rejected by ${service}'
	String rejectedTitle({required Object service}) => 'Rejected by ${service}';

	/// en: 'Grab anyway'
	String get grabAnyway => 'Grab anyway';

	/// en: '${count} seeders'
	String seeders({required Object count}) => '${count} seeders';

	/// en: '${count} h old'
	String ageHours({required Object count}) => '${count} h old';

	/// en: '${count} d old'
	String ageDays({required Object count}) => '${count} d old';

	/// en: 'This film'
	String get scopeMovie => 'This film';

	/// en: 'Whole series'
	String get scopeSeries => 'Whole series';

	/// en: 'Season ${season}'
	String scopeSeason({required Object season}) => 'Season ${season}';

	/// en: 'S${season}E${episode}'
	String scopeEpisode({required Object season, required Object episode}) => 'S${season}E${episode}';
}

// Path: hotkeys.actions
class Translations$hotkeys$actions$en {
	Translations$hotkeys$actions$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Play/Pause'
	String get playPause => 'Play/Pause';

	/// en: 'Volume Up'
	String get volumeUp => 'Volume Up';

	/// en: 'Volume Down'
	String get volumeDown => 'Volume Down';

	/// en: 'Seek Forward (${seconds}s)'
	String seekForward({required Object seconds}) => 'Seek Forward (${seconds}s)';

	/// en: 'Seek Backward (${seconds}s)'
	String seekBackward({required Object seconds}) => 'Seek Backward (${seconds}s)';

	/// en: 'Toggle Fullscreen'
	String get fullscreenToggle => 'Toggle Fullscreen';

	/// en: 'Toggle Mute'
	String get muteToggle => 'Toggle Mute';

	/// en: 'Toggle Subtitles'
	String get subtitleToggle => 'Toggle Subtitles';

	/// en: 'Next Audio Track'
	String get audioTrackNext => 'Next Audio Track';

	/// en: 'Next Subtitle Track'
	String get subtitleTrackNext => 'Next Subtitle Track';

	/// en: 'Next Chapter'
	String get chapterNext => 'Next Chapter';

	/// en: 'Previous Chapter'
	String get chapterPrevious => 'Previous Chapter';

	/// en: 'Next Episode'
	String get episodeNext => 'Next Episode';

	/// en: 'Previous Episode'
	String get episodePrevious => 'Previous Episode';

	/// en: 'Increase Speed'
	String get speedIncrease => 'Increase Speed';

	/// en: 'Decrease Speed'
	String get speedDecrease => 'Decrease Speed';

	/// en: 'Reset Speed'
	String get speedReset => 'Reset Speed';

	/// en: 'Zoom In'
	String get zoomIn => 'Zoom In';

	/// en: 'Zoom Out'
	String get zoomOut => 'Zoom Out';

	/// en: 'Reset Zoom'
	String get zoomReset => 'Reset Zoom';

	/// en: 'Seek to Next Subtitle'
	String get subSeekNext => 'Seek to Next Subtitle';

	/// en: 'Seek to Previous Subtitle'
	String get subSeekPrev => 'Seek to Previous Subtitle';

	/// en: 'Toggle Shaders'
	String get shaderToggle => 'Toggle Shaders';

	/// en: 'Skip Intro/Credits'
	String get skipMarker => 'Skip Intro/Credits';

	/// en: 'Take Screenshot'
	String get screenshot => 'Take Screenshot';
}

// Path: videoControls.pipErrors
class Translations$videoControls$pipErrors$en {
	Translations$videoControls$pipErrors$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Requires Android 8.0 or newer'
	String get androidVersion => 'Requires Android 8.0 or newer';

	/// en: 'Requires iOS 15.0 or newer'
	String get iosVersion => 'Requires iOS 15.0 or newer';

	/// en: 'Picture-in-picture is disabled. Enable it in system settings.'
	String get permissionDisabled => 'Picture-in-picture is disabled. Enable it in system settings.';

	/// en: 'Device doesn't support picture-in-picture mode'
	String get notSupported => 'Device doesn\'t support picture-in-picture mode';

	/// en: 'Failed to switch video output for picture-in-picture'
	String get voSwitchFailed => 'Failed to switch video output for picture-in-picture';

	/// en: 'Picture-in-picture failed to start'
	String get failed => 'Picture-in-picture failed to start';

	/// en: 'An error occurred: ${error}'
	String unknown({required Object error}) => 'An error occurred: ${error}';
}

// Path: libraries.tabs
class Translations$libraries$tabs$en {
	Translations$libraries$tabs$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Browse'
	String get browse => 'Browse';

	/// en: 'Playlists'
	String get playlists => 'Playlists';

	/// en: 'Missing'
	String get missing => 'Missing';
}

// Path: libraries.groupings
class Translations$libraries$groupings$en {
	Translations$libraries$groupings$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Grouping'
	String get title => 'Grouping';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Movies'
	String get movies => 'Movies';

	/// en: 'TV Shows'
	String get shows => 'TV Shows';

	/// en: 'Seasons'
	String get seasons => 'Seasons';

	/// en: 'Episodes'
	String get episodes => 'Episodes';

	/// en: 'Artists'
	String get artists => 'Artists';

	/// en: 'Albums'
	String get albums => 'Albums';

	/// en: 'Tracks'
	String get tracks => 'Tracks';

	/// en: 'Folders'
	String get folders => 'Folders';

	/// en: 'Collections'
	String get collections => 'Collections';
}

// Path: libraries.filterCategories
class Translations$libraries$filterCategories$en {
	Translations$libraries$filterCategories$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Genre'
	String get genre => 'Genre';

	/// en: 'Year'
	String get year => 'Year';

	/// en: 'Content Rating'
	String get contentRating => 'Content Rating';

	/// en: 'Tag'
	String get tag => 'Tag';

	/// en: 'Unwatched'
	String get unwatched => 'Unwatched';

	/// en: 'Unplayed'
	String get unplayed => 'Unplayed';

	/// en: 'Favorites'
	String get favorites => 'Favorites';
}

// Path: libraries.sortLabels
class Translations$libraries$sortLabels$en {
	Translations$libraries$sortLabels$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Title'
	String get title => 'Title';

	/// en: 'Date Added'
	String get dateAdded => 'Date Added';

	/// en: 'Community Rating'
	String get communityRating => 'Community Rating';

	/// en: 'Critic Rating'
	String get criticRating => 'Critic Rating';

	/// en: 'Date Played'
	String get datePlayed => 'Date Played';

	/// en: 'Play Count'
	String get playCount => 'Play Count';

	/// en: 'Production Year'
	String get productionYear => 'Production Year';

	/// en: 'Runtime'
	String get runtime => 'Runtime';

	/// en: 'Official Rating'
	String get officialRating => 'Official Rating';

	/// en: 'Premiere Date'
	String get premiereDate => 'Premiere Date';

	/// en: 'Start Date'
	String get startDate => 'Start Date';

	/// en: 'Air Time'
	String get airTime => 'Air Time';

	/// en: 'Studio'
	String get studio => 'Studio';

	/// en: 'Random'
	String get random => 'Random';

	/// en: 'Last Episode Date Added'
	String get lastEpisodeDateAdded => 'Last Episode Date Added';
}

// Path: explore.rows
class Translations$explore$rows$en {
	Translations$explore$rows$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Watchlist'
	String get watchlist => 'Watchlist';

	/// en: 'Recommended Movies'
	String get recommendedMovies => 'Recommended Movies';

	/// en: 'Recommended Shows'
	String get recommendedShows => 'Recommended Shows';

	/// en: 'Trending Movies'
	String get trendingMovies => 'Trending Movies';

	/// en: 'Trending Shows'
	String get trendingShows => 'Trending Shows';

	/// en: 'Popular Movies'
	String get popularMovies => 'Popular Movies';

	/// en: 'Popular Shows'
	String get popularShows => 'Popular Shows';

	/// en: 'Trending Anime'
	String get trendingAnime => 'Trending Anime';

	/// en: 'Suggested Anime'
	String get suggestedAnime => 'Suggested Anime';

	/// en: 'Top Airing Anime'
	String get airingAnime => 'Top Airing Anime';

	/// en: 'Most Popular Anime'
	String get popularAnime => 'Most Popular Anime';

	/// en: 'Trending'
	String get trending => 'Trending';

	/// en: 'Upcoming Movies'
	String get upcomingMovies => 'Upcoming Movies';

	/// en: 'Upcoming Shows'
	String get upcomingShows => 'Upcoming Shows';
}

// Path: explore.status
class Translations$explore$status$en {
	Translations$explore$status$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Airing'
	String get airing => 'Airing';

	/// en: 'Ended'
	String get ended => 'Ended';

	/// en: 'Canceled'
	String get canceled => 'Canceled';

	/// en: 'Upcoming'
	String get upcoming => 'Upcoming';
}

// Path: explore.badge
class Translations$explore$badge$en {
	Translations$explore$badge$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '#${n} popular'
	String rankPopular({required Object n}) => '#${n} popular';

	/// en: '#${n} airing'
	String rankAiring({required Object n}) => '#${n} airing';

	/// en: '#${n} rated'
	String rankRated({required Object n}) => '#${n} rated';

	/// en: '#${n} favorited'
	String rankFavorited({required Object n}) => '#${n} favorited';

	/// en: '#${n} trending'
	String rankTrending({required Object n}) => '#${n} trending';

	/// en: '#${n} in ${season}'
	String rankSeasonal({required Object n, required Object season}) => '#${n} in ${season}';

	/// en: '${n} watching'
	String watchingNow({required Object n}) => '${n} watching';

	/// en: 'Available'
	String get available => 'Available';

	/// en: 'Partly available'
	String get partiallyAvailable => 'Partly available';

	/// en: '4K available'
	String get availableIn4k => '4K available';

	/// en: 'Requested'
	String get requested => 'Requested';

	/// en: 'Pending approval'
	String get pendingApproval => 'Pending approval';

	/// en: 'Processing'
	String get processing => 'Processing';

	/// en: 'Declined'
	String get declined => 'Declined';

	/// en: 'Request failed'
	String get requestFailed => 'Request failed';

	/// en: '4K requested'
	String get requested4k => '4K requested';

	/// en: '${available}/${total} seasons'
	String seasonsAvailable({required Object available, required Object total}) => '${available}/${total} seasons';

	/// en: 'Ep ${episode} in ${duration}'
	String nextEpisodeIn({required Object episode, required Object duration}) => 'Ep ${episode} in ${duration}';

	/// en: 'Next in ${duration}'
	String nextAiringIn({required Object duration}) => 'Next in ${duration}';

	/// en: '${n} eps'
	String episodesShort({required Object n}) => '${n} eps';

	/// en: '${n} min/ep'
	String minutesPerEpisode({required Object n}) => '${n} min/ep';

	/// en: '18+'
	String get adult => '18+';
}

// Path: explore.stats
class Translations$explore$stats$en {
	Translations$explore$stats$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: '${n} listed'
	String listed({required Object n}) => '${n} listed';

	/// en: '${n} watched today'
	String viewersDay({required Object n}) => '${n} watched today';

	/// en: '${n} watched this week'
	String viewersWeek({required Object n}) => '${n} watched this week';

	/// en: '${n} watched this month'
	String viewersMonth({required Object n}) => '${n} watched this month';

	/// en: '${n} watched this year'
	String viewersYear({required Object n}) => '${n} watched this year';

	/// en: '${n} viewers'
	String viewersAllTime({required Object n}) => '${n} viewers';

	/// en: '${n} planning to watch'
	String planning({required Object n}) => '${n} planning to watch';

	/// en: '${n} favorites'
	String favorited({required Object n}) => '${n} favorites';

	/// en: '${percent} dropped it'
	String dropRate({required Object percent}) => '${percent} dropped it';

	/// en: '(one) {${n} comment} (other) {${n} comments}'
	String comments({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: '${n} comment',
		other: '${n} comments',
	);

	/// en: '${n} votes'
	String votes({required Object n}) => '${n} votes';

	/// en: '${n} watching it'
	String watching({required Object n}) => '${n} watching it';

	/// en: '${n} completed'
	String completed({required Object n}) => '${n} completed';

	/// en: '${n} on hold'
	String onHold({required Object n}) => '${n} on hold';

	/// en: '${n} dropped'
	String dropped({required Object n}) => '${n} dropped';
}

// Path: explore.season
class Translations$explore$season$en {
	Translations$explore$season$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Winter'
	String get winter => 'Winter';

	/// en: 'Spring'
	String get spring => 'Spring';

	/// en: 'Summer'
	String get summer => 'Summer';

	/// en: 'Fall'
	String get fall => 'Fall';

	/// en: '${season} ${year}'
	String withYear({required Object season, required Object year}) => '${season} ${year}';
}

// Path: explore.format
class Translations$explore$format$en {
	Translations$explore$format$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'TV'
	String get tv => 'TV';

	/// en: 'TV Short'
	String get tvShort => 'TV Short';

	/// en: 'Movie'
	String get movie => 'Movie';

	/// en: 'Special'
	String get special => 'Special';

	/// en: 'OVA'
	String get ova => 'OVA';

	/// en: 'ONA'
	String get ona => 'ONA';

	/// en: 'Music'
	String get music => 'Music';

	/// en: 'Other'
	String get other => 'Other';
}

// Path: explore.sourceMaterial
class Translations$explore$sourceMaterial$en {
	Translations$explore$sourceMaterial$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Original'
	String get original => 'Original';

	/// en: 'Manga'
	String get manga => 'Manga';

	/// en: 'Light novel'
	String get lightNovel => 'Light novel';

	/// en: 'Novel'
	String get novel => 'Novel';

	/// en: 'Visual novel'
	String get visualNovel => 'Visual novel';

	/// en: 'Game'
	String get game => 'Game';

	/// en: 'Web comic'
	String get webComic => 'Web comic';

	/// en: 'Music'
	String get musicRelease => 'Music';

	/// en: 'Other'
	String get otherMedia => 'Other';
}

// Path: explore.creditRole
class Translations$explore$creditRole$en {
	Translations$explore$creditRole$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Director'
	String get director => 'Director';

	/// en: 'Writer'
	String get writer => 'Writer';

	/// en: 'Producer'
	String get producer => 'Producer';

	/// en: 'Creator'
	String get creator => 'Creator';

	/// en: 'Composer'
	String get composer => 'Composer';
}

// Path: explore.ratingSource
class Translations$explore$ratingSource$en {
	Translations$explore$ratingSource$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Critics'
	String get critic => 'Critics';

	/// en: 'Audience'
	String get audience => 'Audience';

	/// en: 'IMDb'
	String get imdb => 'IMDb';

	/// en: 'TMDB'
	String get tmdb => 'TMDB';

	/// en: 'Rotten Tomatoes'
	String get rottenTomatoes => 'Rotten Tomatoes';

	/// en: 'Simkl'
	String get simkl => 'Simkl';

	/// en: 'MyAnimeList'
	String get mal => 'MyAnimeList';

	/// en: 'AniList'
	String get anilist => 'AniList';

	/// en: 'Trakt'
	String get trakt => 'Trakt';

	/// en: 'Rotten Tomatoes critics'
	String get rottenTomatoesCritic => 'Rotten Tomatoes critics';

	/// en: 'Rotten Tomatoes audience'
	String get rottenTomatoesAudience => 'Rotten Tomatoes audience';
}

// Path: explore.detail
class Translations$explore$detail$en {
	Translations$explore$detail$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Original title'
	String get originalTitle => 'Original title';

	/// en: 'Also known as'
	String get alsoKnownAs => 'Also known as';

	/// en: 'Studios'
	String get studios => 'Studios';

	/// en: 'Country'
	String get country => 'Country';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Released'
	String get released => 'Released';

	/// en: 'On disc'
	String get physicalRelease => 'On disc';

	/// en: 'Ended'
	String get ended => 'Ended';

	/// en: 'Added ${date}'
	String addedOn({required Object date}) => 'Added ${date}';

	/// en: 'Your rating'
	String get yourRating => 'Your rating';

	/// en: 'Budget'
	String get budget => 'Budget';

	/// en: 'Box office'
	String get revenue => 'Box office';

	/// en: 'Age guidance'
	String get contentAdvisory => 'Age guidance';

	/// en: 'Tags'
	String get tags => 'Tags';

	/// en: 'Show spoiler tags'
	String get revealSpoilerTags => 'Show spoiler tags';

	/// en: 'Links'
	String get links => 'Links';

	/// en: 'Watch on'
	String get watchOn => 'Watch on';

	/// en: 'Watch trailer'
	String get watchTrailer => 'Watch trailer';

	/// en: 'Open on ${site}'
	String openOn({required Object site}) => 'Open on ${site}';

	/// en: 'Crew'
	String get crew => 'Crew';

	/// en: 'Ratings'
	String get ratings => 'Ratings';

	/// en: 'Schedule'
	String get schedule => 'Schedule';

	/// en: '(one) {Recommended by ${n} user} (other) {Recommended by ${n} users}'
	String recommendedByUsers({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n,
		one: 'Recommended by ${n} user',
		other: 'Recommended by ${n} users',
	);

	/// en: 'Recommended by ${who}'
	String recommendedBy({required Object who}) => 'Recommended by ${who}';

	/// en: 'Favorited by ${who}'
	String favoritedBy({required Object who}) => 'Favorited by ${who}';

	/// en: '${n} not aired yet'
	String unairedEpisodes({required Object n}) => '${n} not aired yet';

	/// en: 'Recommended by ${percent} of viewers'
	String recommendedByPercent({required Object percent}) => 'Recommended by ${percent} of viewers';

	/// en: 'Related titles'
	String get relatedTitles => 'Related titles';

	/// en: 'Background'
	String get background => 'Background';
}

// Path: explore.relation
class Translations$explore$relation$en {
	Translations$explore$relation$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Prequel'
	String get prequel => 'Prequel';

	/// en: 'Sequel'
	String get sequel => 'Sequel';

	/// en: 'Side story'
	String get sideStory => 'Side story';

	/// en: 'Spin-off'
	String get spinOff => 'Spin-off';

	/// en: 'Alternative version'
	String get alternativeVersion => 'Alternative version';

	/// en: 'Summary'
	String get summary => 'Summary';

	/// en: 'Parent story'
	String get parentStory => 'Parent story';

	/// en: 'Adaptation'
	String get adaptation => 'Adaptation';

	/// en: 'Related'
	String get other => 'Related';
}

// Path: downloads.backgroundWarning
class Translations$downloads$backgroundWarning$en {
	Translations$downloads$backgroundWarning$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Downloads will stop when you leave the app'
	String get bannerBlocked => 'Downloads will stop when you leave the app';

	/// en: 'Background downloads may be limited'
	String get bannerDegraded => 'Background downloads may be limited';

	/// en: 'Details'
	String get bannerAction => 'Details';

	/// en: 'Background downloads are blocked'
	String get sheetTitle => 'Background downloads are blocked';

	/// en: 'Background downloads may be limited'
	String get sheetTitleDegraded => 'Background downloads may be limited';

	/// en: 'Android is preventing Harbor from downloading reliably in the background.'
	String get sheetIntro => 'Android is preventing Harbor from downloading reliably in the background.';

	/// en: 'Your device is limiting when Harbor can download in the background.'
	String get sheetIntroDegraded => 'Your device is limiting when Harbor can download in the background.';

	/// en: 'Harbor's background usage is restricted. Set its battery or background usage to "Unrestricted".'
	String get reasonBackgroundRestricted => 'Harbor\'s background usage is restricted. Set its battery or background usage to "Unrestricted".';

	/// en: 'Android has put Harbor in a restricted standby state. Set its battery usage to "Unrestricted".'
	String get reasonStandbyRestricted => 'Android has put Harbor in a restricted standby state. Set its battery usage to "Unrestricted".';

	/// en: 'Download notifications are turned off, so progress and controls may be unavailable.'
	String get reasonDownloadChannelBlocked => 'Download notifications are turned off, so progress and controls may be unavailable.';

	/// en: 'Notifications are turned off. On Android 13 or newer, they are required for long background downloads.'
	String get reasonNotificationsDisabled => 'Notifications are turned off. On Android 13 or newer, they are required for long background downloads.';

	/// en: 'Data Saver is on, which blocks background downloads on mobile data. Downloads should still run on Wi-Fi.'
	String get reasonDataSaver => 'Data Saver is on, which blocks background downloads on mobile data. Downloads should still run on Wi-Fi.';

	/// en: 'Downloads repeatedly stopped while Harbor was in the background. Check Harbor's battery or background usage settings.'
	String get reasonOemUnknown => 'Downloads repeatedly stopped while Harbor was in the background. Check Harbor\'s battery or background usage settings.';

	/// en: 'Open settings'
	String get openSettings => 'Open settings';

	/// en: 'Device-specific help'
	String get stillNotWorking => 'Device-specific help';

	/// en: 'See steps for your device, or send a log from Settings › View Logs if the issue continues.'
	String get stillNotWorkingDescription => 'See steps for your device, or send a log from Settings › View Logs if the issue continues.';

	/// en: 'Downloads may not finish'
	String get dialogTitle => 'Downloads may not finish';

	/// en: 'Download anyway'
	String get dialogDownloadAnyway => 'Download anyway';

	/// en: 'Fix this first'
	String get dialogFixFirst => 'Fix this first';

	/// en: 'Background downloads'
	String get statusTile => 'Background downloads';

	/// en: 'Allowed to run in the background'
	String get statusOk => 'Allowed to run in the background';

	/// en: 'Blocked by system settings'
	String get statusBlocked => 'Blocked by system settings';

	/// en: 'Limited by system settings'
	String get statusDegraded => 'Limited by system settings';

	/// en: 'Not checked yet'
	String get statusUnknown => 'Not checked yet';

	/// en: 'Couldn't open system settings on this device'
	String get settingsUnavailable => 'Couldn\'t open system settings on this device';

	/// en: 'Couldn't open dontkillmyapp.com on this device'
	String get linkUnavailable => 'Couldn\'t open dontkillmyapp.com on this device';
}

// Path: services.names
class Translations$services$names$en {
	Translations$services$names$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Simkl'
	String get simkl => 'Simkl';

	/// en: 'Seerr'
	String get seerr => 'Seerr';
}

// Path: services.deviceCode
class Translations$services$deviceCode$en {
	Translations$services$deviceCode$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Activate Harbor on ${service}'
	String title({required Object service}) => 'Activate Harbor on ${service}';

	/// en: 'Visit ${url} and enter this code:'
	String body({required Object url}) => 'Visit ${url} and enter this code:';

	/// en: 'Open ${service} to activate'
	String openToActivate({required Object service}) => 'Open ${service} to activate';

	/// en: 'Copy activation code'
	String get copyCode => 'Copy activation code';

	/// en: 'Waiting for authorization…'
	String get waitingForAuthorization => 'Waiting for authorization…';

	/// en: 'Code copied'
	String get codeCopied => 'Code copied';
}

// Path: services.libraryFilter
class Translations$services$libraryFilter$en {
	Translations$services$libraryFilter$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Library filter'
	String get title => 'Library filter';

	/// en: 'Syncing all libraries'
	String get subtitleAllSyncing => 'Syncing all libraries';

	/// en: 'Nothing syncing'
	String get subtitleNoneSyncing => 'Nothing syncing';

	/// en: '${count} blocked'
	String subtitleBlocked({required Object count}) => '${count} blocked';

	/// en: '${count} allowed'
	String subtitleAllowed({required Object count}) => '${count} allowed';

	/// en: 'Filter mode'
	String get mode => 'Filter mode';

	/// en: 'Blacklist'
	String get modeBlacklist => 'Blacklist';

	/// en: 'Whitelist'
	String get modeWhitelist => 'Whitelist';

	/// en: 'Sync every library except the ones checked below.'
	String get modeHintBlacklist => 'Sync every library except the ones checked below.';

	/// en: 'Sync only the libraries checked below.'
	String get modeHintWhitelist => 'Sync only the libraries checked below.';

	/// en: 'Libraries'
	String get libraries => 'Libraries';

	/// en: 'No libraries available'
	String get noLibraries => 'No libraries available';
}

// Path: managedServices.kinds
class Translations$managedServices$kinds$en {
	Translations$managedServices$kinds$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Radarr'
	String get radarr => 'Radarr';

	/// en: 'Sonarr'
	String get sonarr => 'Sonarr';

	/// en: 'qBittorrent'
	String get qbittorrent => 'qBittorrent';
}

// Path: managedServices.kindHints
class Translations$managedServices$kindHints$en {
	Translations$managedServices$kindHints$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Films'
	String get radarr => 'Films';

	/// en: 'Series'
	String get sonarr => 'Series';

	/// en: 'Download client'
	String get qbittorrent => 'Download client';
}

// Path: serverActivity.stages
class Translations$serverActivity$stages$en {
	Translations$serverActivity$stages$en.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Queued'
	String get queued => 'Queued';

	/// en: 'Downloading'
	String get downloading => 'Downloading';

	/// en: 'Importing'
	String get importing => 'Importing';

	/// en: 'Available'
	String get done => 'Available';

	/// en: 'Failed'
	String get failed => 'Failed';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Harbor',
			'auth.connectToJellyfin' => 'Connect to Jellyfin',
			'auth.useQuickConnect' => 'Use Quick Connect',
			'auth.quickConnectInstructions' => 'Open Quick Connect in Jellyfin and enter this code.',
			'auth.quickConnectWaiting' => 'Waiting for approval…',
			'auth.quickConnectCancel' => 'Cancel',
			'auth.quickConnectExpired' => 'Quick Connect expired. Try again.',
			'common.cancel' => 'Cancel',
			'common.save' => 'Save',
			'common.close' => 'Close',
			'common.clear' => 'Clear',
			'common.reset' => 'Reset',
			'common.later' => 'Later',
			'common.submit' => 'Submit',
			'common.confirm' => 'Confirm',
			'common.retry' => 'Retry',
			'common.logout' => 'Log out',
			'common.unknown' => 'Unknown',
			'common.refresh' => 'Refresh',
			'common.yes' => 'Yes',
			'common.no' => 'No',
			'common.delete' => 'Delete',
			'common.edit' => 'Edit',
			'common.shuffle' => 'Shuffle',
			'common.addTo' => 'Add to...',
			'common.createNew' => 'Create new',
			'common.disconnect' => 'Disconnect',
			'common.play' => 'Play',
			'common.pause' => 'Pause',
			'common.resume' => 'Resume',
			'common.error' => 'Error',
			'common.search' => 'Search',
			'common.home' => 'Home',
			'common.back' => 'Back',
			'common.settings' => 'Settings',
			'common.ok' => 'OK',
			'common.off' => 'Off',
			'common.seasonNumber' => ({required Object number}) => 'Season ${number}',
			'common.episodeNumberTitle' => ({required Object number, required Object title}) => 'Episode ${number} - ${title}',
			'common.chapterNumber' => ({required Object number}) => 'Chapter ${number}',
			'common.reconnect' => 'Reconnect',
			'common.viewAll' => 'View All',
			'common.checkingNetwork' => 'Checking network...',
			'common.loadingServers' => 'Loading servers...',
			'common.connectingToServers' => 'Connecting to servers...',
			'common.startingOfflineMode' => 'Starting offline mode...',
			'common.loading' => 'Loading...',
			'common.pressBackAgainToExit' => 'Press back again to exit',
			'common.next' => 'Next',
			'screens.licenses' => 'Licenses',
			'screens.switchProfile' => 'Switch Profile',
			'screens.subtitleStyling' => 'Subtitle Styling',
			'screens.mpvConfig' => 'mpv.conf',
			'screens.logs' => 'Logs',
			'update.available' => 'Update Available',
			'update.versionAvailable' => ({required Object version}) => 'Version ${version} is available',
			'update.currentVersion' => ({required Object version}) => 'Current: ${version}',
			'update.skipVersion' => 'Skip This Version',
			'update.viewRelease' => 'View Release',
			'update.latestVersion' => 'You are on the latest version',
			'update.checkFailed' => 'Failed to check for updates',
			'settings.title' => 'Settings',
			'settings.supportDeveloper' => 'Support Harbor',
			'settings.supportDeveloperDescription' => 'Donate via Liberapay to fund development',
			'settings.language' => 'Language',
			'settings.theme' => 'Theme',
			'settings.appearance' => 'Appearance',
			'settings.videoPlayback' => 'Video Playback',
			'settings.videoPlaybackDescription' => 'Configure playback behavior',
			'settings.advanced' => 'Advanced',
			'settings.episodePosterMode' => 'Episode Poster Style',
			'settings.seriesPoster' => 'Series Poster',
			'settings.seasonPoster' => 'Season Poster',
			'settings.episodeThumbnail' => 'Thumbnail',
			'settings.showHeroSectionDescription' => 'Display featured content carousel on home screen',
			'settings.secondsLabel' => 'Seconds',
			'settings.minutesLabel' => 'Minutes',
			'settings.secondsShort' => 's',
			'settings.minutesShort' => 'm',
			'settings.durationHint' => ({required Object min, required Object max}) => 'Enter duration (${min}-${max})',
			'settings.systemTheme' => 'System',
			'settings.lightTheme' => 'Light',
			'settings.darkTheme' => 'Dark',
			'settings.oledTheme' => 'OLED',
			'settings.materialYouTheme' => 'Material You',
			'settings.hapticFeedback' => 'Haptic feedback',
			'settings.hapticFeedbackDescription' => 'Vibrate when choosing an item, switching tabs, or flipping a switch',
			'settings.libraryDensity' => 'Library Density',
			'settings.compact' => 'Compact',
			'settings.comfortable' => 'Comfortable',
			'settings.tvCornerSpotlightBackdrop' => 'Corner Spotlight Backdrop',
			'settings.tvCornerSpotlightBackdropDescription' => 'Show spotlight artwork in the top-right corner instead of filling the screen',
			'settings.viewMode' => 'View Mode',
			'settings.gridView' => 'Grid',
			'settings.listView' => 'List',
			'settings.showHeroSection' => 'Show Hero Section',
			'settings.continueWatchingAction' => 'Continue Watching Action',
			'settings.continueWatchingPlay' => 'Play',
			'settings.continueWatchingDetails' => 'Open Details',
			'settings.episodeAction' => 'Episode Action',
			'settings.episodePlay' => 'Play',
			'settings.episodeDetails' => 'Open Details',
			'settings.showServerNameOnHubs' => 'Show Server Name on Hubs',
			'settings.showServerNameOnHubsDescription' => 'Always show server names in hub titles.',
			'settings.groupLibrariesByServer' => 'Group Libraries by Server',
			'settings.groupLibrariesByServerDescription' => 'Group sidebar libraries under each media server.',
			'settings.alwaysKeepSidebarOpen' => 'Always Keep Sidebar Open',
			'settings.alwaysKeepSidebarOpenDescription' => 'Sidebar stays expanded and content area adjusts to fit',
			'settings.showUnwatchedCount' => 'Show Unwatched Count',
			'settings.showUnwatchedCountDescription' => 'Display unwatched episode count on shows and seasons',
			'settings.showEpisodeNumberOnCards' => 'Show Episode Number on Cards',
			'settings.showEpisodeNumberOnCardsDescription' => 'Show season and episode number on episode cards',
			'settings.showSeasonPostersOnTabs' => 'Show Season Posters on Tabs',
			'settings.showSeasonPostersOnTabsDescription' => 'Show each season\'s poster above its tab',
			'settings.tvFullCardLayout' => 'Full TV Cards',
			'settings.tvFullCardLayoutDescription' => 'Use image-only TV cards with actor names overlaid',
			'settings.focusGlow' => 'Focus Glow',
			'settings.focusGlowDescription' => 'Draw a soft glow around the focused card',
			'settings.visualEffects' => 'Visual Effects',
			'settings.visualEffectsAuto' => 'Auto',
			'settings.visualEffectsAutoDescription' => 'Reduce effects automatically on low-power devices',
			'settings.visualEffectsFull' => 'Full',
			'settings.visualEffectsReduced' => 'Reduced',
			'settings.visualEffectsReducedDescription' => 'Fewer animations and lower-resolution artwork',
			'settings.hideSpoilers' => 'Hide Spoilers for Unwatched Episodes',
			'settings.hideSpoilersDescription' => 'Blur thumbnails and descriptions for unwatched episodes',
			'settings.playerBackend' => 'Player Backend',
			'settings.exoPlayer' => 'ExoPlayer',
			'settings.mpv' => 'mpv',
			'settings.hardwareDecoding' => 'Hardware Decoding',
			'settings.hardwareDecodingDescription' => 'Use hardware acceleration when available',
			'settings.bufferSize' => 'Buffer Size',
			'settings.bufferSizeMB' => ({required Object size}) => '${size}MB',
			'settings.bufferSizeAuto' => 'Auto (Recommended)',
			'settings.bufferSizeWarning' => ({required Object heap, required Object size}) => '${heap}MB memory available. A ${size}MB buffer may affect playback.',
			'settings.defaultQualityTitle' => 'Default Quality',
			'settings.musicQualityTitle' => 'Music Quality',
			'settings.subtitleStyling' => 'Subtitle Styling',
			'settings.subtitleStylingDescription' => 'Customize subtitle appearance',
			'settings.smallSkipDuration' => 'Small Skip Duration',
			'settings.largeSkipDuration' => 'Large Skip Duration',
			'settings.rewindOnResume' => 'Rewind on Resume',
			'settings.secondsUnit' => ({required Object seconds}) => '${seconds} seconds',
			'settings.defaultSleepTimer' => 'Default Sleep Timer',
			'settings.minutesUnit' => ({required Object minutes}) => '${minutes} minutes',
			'settings.rememberTrackSelections' => 'Remember track selections per show/movie',
			'settings.rememberTrackSelectionsDescription' => 'Remember audio and subtitle choices per title',
			'settings.followServerTrackSelections' => 'Use server\'s per-episode track selections',
			'settings.followServerTrackSelectionsDescription' => 'On episode change, apply the audio and subtitles selected on the server instead of carrying over the current choice',
			'settings.showChapterMarkersOnTimeline' => 'Show chapter markers on seek bar',
			'settings.showChapterMarkersOnTimelineDescription' => 'Segment the seek bar at chapter boundaries',
			'settings.clickVideoTogglesPlayback' => 'Click on video to toggle play/pause',
			'settings.clickVideoTogglesPlaybackDescription' => 'Click video to play/pause instead of showing controls.',
			'settings.videoPlayerControls' => 'Video Player Controls',
			'settings.keyboardShortcuts' => 'Keyboard Shortcuts',
			'settings.keyboardShortcutsDescription' => 'Customize keyboard shortcuts',
			'settings.videoPlayerNavigation' => 'Video Player Navigation',
			'settings.videoPlayerNavigationDescription' => 'Use arrow keys to navigate video player controls',
			'settings.debugLogging' => 'Debug Logging',
			'settings.debugLoggingDescription' => 'Enable detailed logging for troubleshooting',
			'settings.viewLogs' => 'View Logs',
			'settings.viewLogsDescription' => 'View application logs',
			'settings.clearImageCache' => 'Clear Image Cache',
			'settings.clearImageCacheDescription' => 'Clear cached artwork and thumbnails. Images may load slower until downloaded again.',
			'settings.clearImageCacheSuccess' => 'Image cache cleared successfully',
			'settings.resetSettings' => 'Reset Settings',
			'settings.resetSettingsDescription' => 'Restore default settings. This can\'t be undone.',
			'settings.resetSettingsSuccess' => 'Settings reset successfully',
			'settings.backup' => 'Backup',
			'settings.exportSettings' => 'Export Settings',
			'settings.exportSettingsDescription' => 'Save your preferences to a file',
			'settings.exportSettingsSuccess' => 'Settings exported',
			'settings.importSettings' => 'Import Settings',
			'settings.importSettingsDescription' => 'Restore preferences from a file',
			'settings.importSettingsConfirm' => 'This will replace your current settings. Continue?',
			'settings.importSettingsSuccess' => 'Settings imported',
			'settings.importSettingsInvalidFile' => 'This file isn\'t a valid Harbor settings export',
			'settings.importSettingsNoUser' => 'Sign in before importing settings',
			'settings.shortcutsReset' => 'Shortcuts reset to defaults',
			'settings.about' => 'About',
			'settings.aboutDescription' => 'App information and licenses',
			'settings.updates' => 'Updates',
			'settings.updateAvailable' => 'Update Available',
			'settings.checkForUpdates' => 'Check for Updates',
			'settings.autoCheckUpdatesOnStartup' => 'Automatically check for updates on startup',
			'settings.autoCheckUpdatesOnStartupDescription' => 'Notify when an update is available at launch',
			'settings.validationErrorEnterNumber' => 'Please enter a valid number',
			'settings.validationErrorDuration' => ({required Object min, required Object max, required Object unit}) => 'Duration must be between ${min} and ${max} ${unit}',
			'settings.shortcutAlreadyAssigned' => ({required Object action}) => 'Shortcut already assigned to ${action}',
			'settings.shortcutUpdated' => ({required Object action}) => 'Shortcut updated for ${action}',
			'settings.saveFailed' => 'Could not save changes. Try again.',
			'settings.autoSkip' => 'Auto Skip',
			'settings.autoSkipIntro' => 'Auto Skip Intro',
			'settings.autoSkipIntroDescription' => 'Automatically skip intro markers after a few seconds',
			'settings.autoSkipCredits' => 'Auto Skip Credits',
			'settings.autoSkipCreditsDescription' => 'Automatically skip credits and play next episode',
			'settings.forceSkipMarkerFallback' => 'Force Fallback Markers',
			'settings.forceSkipMarkerFallbackDescription' => 'Use chapter title patterns even when Plex has markers',
			'settings.autoSkipDelay' => 'Auto Skip Delay',
			'settings.autoSkipDelayDescription' => ({required Object seconds}) => 'Wait ${seconds} seconds before auto-skipping',
			'settings.introPattern' => 'Intro Marker Pattern',
			'settings.introPatternDescription' => 'Regex pattern to match intro markers in chapter titles',
			'settings.creditsPattern' => 'Credits Marker Pattern',
			'settings.creditsPatternDescription' => 'Regex pattern to match credits markers in chapter titles',
			'settings.invalidRegex' => 'Invalid regular expression',
			'settings.regex' => 'Regular expression',
			'settings.downloads' => 'Downloads',
			'settings.downloadLocationDescription' => 'Choose where to store downloaded content',
			'settings.downloadLocationDefault' => 'Default (App Storage)',
			'settings.downloadLocationCustom' => 'Custom Location',
			'settings.selectFolder' => 'Select Folder',
			'settings.resetToDefault' => 'Reset to Default',
			'settings.currentPath' => ({required Object path}) => 'Current: ${path}',
			'settings.downloadLocationChanged' => 'Download location changed',
			'settings.downloadLocationReset' => 'Download location reset to default',
			'settings.downloadLocationInvalid' => 'Selected folder is not writable',
			'settings.downloadLocationPickerUnavailable' => 'Folder selection is not available on this device',
			'settings.downloadOnWifiOnly' => 'Download on Wi-Fi only',
			'settings.downloadOnWifiOnlyDescription' => 'Prevent downloads when on cellular data',
			'settings.autoRemoveWatchedDownloads' => 'Auto-remove watched downloads',
			'settings.autoRemoveWatchedDownloadsDescription' => 'Delete watched downloads automatically',
			'settings.cellularDownloadBlocked' => 'Downloads are blocked on cellular. Use Wi-Fi or change the setting.',
			'settings.maxVolume' => 'Maximum Volume',
			'settings.maxVolumeDescription' => 'Allow volume boost above 100% for quiet media',
			'settings.maxVolumePercent' => ({required Object percent}) => '${percent}%',
			'settings.services' => 'Services',
			'settings.servicesDescription' => 'Connect Trakt, MyAnimeList, Seerr, and more',
			'settings.manageLibrariesDescription' => 'Reorder and hide libraries',
			'settings.autoPip' => 'Auto Picture-in-Picture',
			'settings.autoPipDescription' => 'Automatically enter picture-in-picture when you leave the app during playback',
			'settings.matchContentFrameRate' => 'Match Content Frame Rate',
			'settings.matchContentFrameRateDescription' => 'Match display refresh rate to video content',
			'settings.matchRefreshRate' => 'Match Refresh Rate',
			'settings.matchRefreshRateDescription' => 'Match display refresh rate in fullscreen',
			'settings.matchDynamicRange' => 'Match Dynamic Range',
			'settings.matchDynamicRangeDescription' => 'Switch HDR on for HDR content, then back to SDR',
			'settings.displaySwitchDelay' => 'Display Switch Delay',
			'settings.tunneledPlayback' => 'Tunneled Playback',
			'settings.tunneledPlaybackDescription' => 'Use video tunneling. Disable if HDR playback shows black video.',
			'settings.audioPassthrough' => 'Audio Passthrough',
			'settings.audioPassthroughDescription' => 'Send Dolby/DTS audio to your receiver or TV without re-encoding, preserving surround sound. Turn off if you have no sound.',
			'settings.audioPassthroughDescriptionAppleTv' => 'Use Apple\'s native Dolby decoder for Dolby Digital Plus, including Atmos. DTS and TrueHD still play as multichannel PCM. Turn off if you have no sound.',
			'settings.audioDownmix' => 'Downmix to Stereo',
			'settings.audioDownmixDescription' => 'Mix surround audio down to two channels for stereo speakers or headphones',
			'settings.downmixCenterBoost' => 'Center Channel Boost',
			'settings.downmixCenterBoostValue' => ({required Object db}) => '${db} dB',
			'settings.downmixCenterBoostLabel' => 'Boost (dB)',
			'settings.downmixCenterBoostShort' => 'dB',
			'settings.audioDownmixNormalize' => 'Normalize Volume on Downmix',
			'settings.audioDownmixNormalizeDescription' => 'Lower the mix to prevent clipping. Turn off to keep the original volume (may distort loud scenes).',
			'settings.atmosDiagnostics' => 'Atmos Output Test',
			'settings.atmosDiagnosticsDescription' => 'Diagnose Dolby Atmos output by playing test signals through the system player',
			'settings.atmosTestHlsAtmos' => 'Apple Atmos stream',
			'settings.atmosTestHlsAtmosDescription' => 'Known-good Dolby Atmos stream. The receiver should show Dolby Atmos.',
			'settings.atmosTestHlsControl' => 'Apple surround stream',
			'settings.atmosTestHlsControlDescription' => 'Non-Atmos control stream. The receiver should show surround without Atmos.',
			'settings.atmosTestRawStream' => 'Raw EAC3 stream',
			'settings.atmosTestRawStreamDescription' => 'Streams the test file exactly like in-player Atmos playback. Needs the test file URL.',
			'settings.atmosTestRawFile' => 'Raw EAC3 file',
			'settings.atmosTestRawFileDescription' => 'Plays the test file with a known length. Needs the test file URL.',
			'settings.atmosTestAsbarNative' => 'Sample-buffer renderer (native)',
			'settings.atmosTestAsbarNativeDescription' => 'Feeds the file\'s untouched compressed audio straight to the system renderer. Needs the test file URL.',
			'settings.atmosTestAsbarGenerated' => 'Sample-buffer renderer (rebuilt)',
			'settings.atmosTestAsbarGeneratedDescription' => 'Same, but with the audio description rebuilt the way playback builds it. Needs the test file URL.',
			'settings.atmosTestSessionMode' => 'Use movie playback session mode',
			'settings.atmosTestSessionModeDescription' => 'Off uses the mode Dolby documents. On uses the mode playback used previously.',
			'settings.atmosTestShowRoutePicker' => 'Choose AirPlay output',
			'settings.atmosTestHideRoutePicker' => 'Hide AirPlay output picker',
			'settings.atmosTestRoutePickerDescription' => 'Send the test to an AirPlay receiver. Only AirPlay reports the resolved audio mode.',
			'settings.atmosTestStop' => 'Stop test',
			'settings.atmosTestUrl' => 'Test file URL',
			'settings.atmosTestUrlDescription' => 'HTTP URL of a raw .ec3 Dolby Atmos file (e.g. extracted with ffmpeg)',
			'settings.atmosTestUrlMissing' => 'Set the test file URL first',
			'settings.atmosTestStatus' => 'Status',
			'settings.dvConversionMode' => 'Dolby Vision Conversion',
			'settings.dvConversionModeDescription' => 'Choose how ExoPlayer handles Dolby Vision Profile 7 files.',
			'settings.dvConversionAuto' => 'Auto',
			'settings.dvConversionNative' => 'Native / Disabled',
			'settings.dvConversionDv81' => 'P7 → P8.1',
			'settings.dvConversionHevcStrip' => 'P7 → HEVC',
			'settings.dvConversionAutoDescription' => 'Use device capability detection and normal fallback behavior',
			'settings.dvConversionNativeDescription' => 'Force native DV7 and suppress DV conversion retry',
			'settings.dvConversionDv81Description' => 'Force inline RPU conversion to Dolby Vision profile 8.1',
			'settings.dvConversionHevcStripDescription' => 'Strip Dolby Vision RPU/EL layers and present plain HEVC',
			'settings.requireProfileSelectionOnOpen' => 'Ask for profile on app open',
			'settings.requireProfileSelectionOnOpenDescription' => 'Show profile selection every time the app is opened',
			'settings.forceTvMode' => 'Force TV mode',
			'settings.forceTvModeDescription' => 'Force TV layout. For devices that don\'t auto-detect. Requires restart.',
			'settings.autoHidePerformanceOverlay' => 'Auto-Hide Performance Overlay',
			'settings.autoHidePerformanceOverlayDescription' => 'Fade the performance overlay with the playback controls',
			'settings.showNavBarLabels' => 'Show Navigation Bar Labels',
			'settings.showNavBarLabelsDescription' => 'Display text labels under navigation bar icons',
			'settings.startupSection' => 'Startup Section',
			'settings.cardOrientation' => 'Card Shape',
			'settings.cardPortrait' => 'Portrait',
			'settings.cardLandscape' => 'Landscape',
			'settings.display' => 'Display',
			'settings.homeScreen' => 'Home Screen',
			'settings.navigation' => 'Navigation',
			'settings.content' => 'Content',
			'settings.player' => 'Player',
			'settings.subtitlesAndConfig' => 'Subtitles & Configuration',
			'settings.seekAndTiming' => 'Seek & Timing',
			'settings.behavior' => 'Behavior',
			'search.hint' => 'Search movies, shows, music...',
			'search.tryDifferentTerm' => 'Try a different search term',
			'search.searchYourMedia' => 'Search your media',
			'search.enterTitleActorOrKeyword' => 'Enter a title, actor, or keyword',
			'hotkeys.setShortcutFor' => ({required Object actionName}) => 'Set Shortcut for ${actionName}',
			'hotkeys.clearShortcut' => 'Clear shortcut',
			'hotkeys.noShortcutSet' => 'No shortcut set',
			'hotkeys.currentShortcut' => 'Current shortcut:',
			'hotkeys.pressToRecord' => 'Select to record a shortcut',
			'hotkeys.recordingShortcut' => 'Press the shortcut now',
			'hotkeys.actions.playPause' => 'Play/Pause',
			'hotkeys.actions.volumeUp' => 'Volume Up',
			'hotkeys.actions.volumeDown' => 'Volume Down',
			'hotkeys.actions.seekForward' => ({required Object seconds}) => 'Seek Forward (${seconds}s)',
			'hotkeys.actions.seekBackward' => ({required Object seconds}) => 'Seek Backward (${seconds}s)',
			'hotkeys.actions.fullscreenToggle' => 'Toggle Fullscreen',
			'hotkeys.actions.muteToggle' => 'Toggle Mute',
			'hotkeys.actions.subtitleToggle' => 'Toggle Subtitles',
			'hotkeys.actions.audioTrackNext' => 'Next Audio Track',
			'hotkeys.actions.subtitleTrackNext' => 'Next Subtitle Track',
			'hotkeys.actions.chapterNext' => 'Next Chapter',
			'hotkeys.actions.chapterPrevious' => 'Previous Chapter',
			'hotkeys.actions.episodeNext' => 'Next Episode',
			'hotkeys.actions.episodePrevious' => 'Previous Episode',
			'hotkeys.actions.speedIncrease' => 'Increase Speed',
			'hotkeys.actions.speedDecrease' => 'Decrease Speed',
			'hotkeys.actions.speedReset' => 'Reset Speed',
			'hotkeys.actions.zoomIn' => 'Zoom In',
			'hotkeys.actions.zoomOut' => 'Zoom Out',
			'hotkeys.actions.zoomReset' => 'Reset Zoom',
			'hotkeys.actions.subSeekNext' => 'Seek to Next Subtitle',
			'hotkeys.actions.subSeekPrev' => 'Seek to Previous Subtitle',
			'hotkeys.actions.shaderToggle' => 'Toggle Shaders',
			'hotkeys.actions.skipMarker' => 'Skip Intro/Credits',
			'hotkeys.actions.screenshot' => 'Take Screenshot',
			'fileInfo.title' => 'File Info',
			'fileInfo.overview' => 'Overview',
			'fileInfo.video' => 'Video',
			'fileInfo.audio' => 'Audio',
			'fileInfo.subtitles' => 'Subtitles',
			'fileInfo.images' => 'Embedded Images',
			'fileInfo.dataStreams' => 'Data Streams',
			'fileInfo.lyrics' => 'Lyrics',
			'fileInfo.file' => 'File',
			'fileInfo.attachments' => 'Attachments',
			'fileInfo.delivery' => 'Delivery',
			'fileInfo.versionCounter' => ({required Object index, required Object count}) => 'Version ${index} of ${count}',
			'fileInfo.fileCounter' => ({required Object index, required Object count}) => 'File ${index} of ${count}',
			'fileInfo.noStreams' => 'The server reported no streams for this file.',
			'fileInfo.copyPath' => 'Copy path',
			'fileInfo.pathCopied' => 'File path copied',
			'fileInfo.codec' => 'Codec',
			'fileInfo.codecTag' => 'Codec Tag',
			'fileInfo.resolution' => 'Resolution',
			'fileInfo.codedResolution' => 'Coded Resolution',
			'fileInfo.bitrate' => 'Bitrate',
			'fileInfo.frameRate' => 'Frame Rate',
			'fileInfo.rotation' => 'Rotation',
			'fileInfo.comment' => 'Comment',
			'fileInfo.audioDescription' => 'Audio Description',
			'fileInfo.headerCompression' => 'Header Compression',
			'fileInfo.sidecarFile' => 'Sidecar File',
			'fileInfo.transportTimestamp' => 'Transport Timestamp',
			'fileInfo.displayOffset' => 'Display Offset',
			'fileInfo.previewFailureCode' => 'Preview Failure Code',
			'fileInfo.previewRetries' => 'Preview Retries',
			'fileInfo.aspectRatio' => 'Aspect Ratio',
			'fileInfo.pixelAspectRatio' => 'Pixel Aspect Ratio',
			'fileInfo.profile' => 'Profile',
			'fileInfo.level' => 'Level',
			'fileInfo.bitDepth' => 'Bit Depth',
			'fileInfo.pixelFormat' => 'Pixel Format',
			'fileInfo.colorSpace' => 'Color Space',
			'fileInfo.colorRange' => 'Color Range',
			'fileInfo.colorPrimaries' => 'Color Primaries',
			'fileInfo.colorTransfer' => 'Color Transfer',
			'fileInfo.chromaSubsampling' => 'Chroma Subsampling',
			'fileInfo.chromaLocation' => 'Chroma Location',
			'fileInfo.scanType' => 'Scan Type',
			'fileInfo.interlaced' => 'Interlaced',
			'fileInfo.anamorphic' => 'Anamorphic',
			'fileInfo.referenceFrames' => 'Reference Frames',
			'fileInfo.dynamicRange' => 'Dynamic Range',
			'fileInfo.dolbyVision' => 'Dolby Vision',
			'fileInfo.dolbyVisionLevel' => 'Dolby Vision Level',
			'fileInfo.dolbyVisionVersion' => 'Dolby Vision Version',
			'fileInfo.dolbyVisionLayers' => 'Dolby Vision Layers',
			'fileInfo.baseLayerCompatibility' => 'Base Layer Compatibility',
			'fileInfo.avcBitstream' => 'AVC Bitstream',
			'fileInfo.nalLengthSize' => 'NAL Length Size',
			'fileInfo.scalingMatrix' => 'Custom Scaling Matrix',
			'fileInfo.streamIdentifier' => 'Stream Identifier',
			'fileInfo.streamIndex' => 'Stream Index',
			'fileInfo.streamId' => 'Stream ID',
			'fileInfo.language' => 'Language',
			'fileInfo.languageCode' => 'Language Code',
			'fileInfo.streamTitle' => 'Track Title',
			'fileInfo.channels' => 'Channels',
			'fileInfo.sampleRate' => 'Sample Rate',
			'fileInfo.spatialAudio' => 'Spatial Audio',
			'fileInfo.textBased' => 'Text Based',
			'fileInfo.subtitleFormat' => 'Sidecar Format',
			'fileInfo.provider' => 'Provider',
			'fileInfo.matchScore' => 'Match Score',
			'fileInfo.externalDelivery' => 'Can Be Served Separately',
			'fileInfo.sidecarPath' => 'Sidecar Path',
			'fileInfo.sourceStream' => 'Copied From',
			'fileInfo.temporary' => 'Temporary',
			'fileInfo.timeBase' => 'Time Base',
			'fileInfo.overallBitrate' => 'Overall Bitrate',
			'fileInfo.path' => 'Path',
			'fileInfo.fileName' => 'File Name',
			'fileInfo.size' => 'Size',
			'fileInfo.totalSize' => 'Total Size',
			'fileInfo.container' => 'Container',
			'fileInfo.duration' => 'Duration',
			'fileInfo.previewThumbnails' => 'Preview Thumbnails',
			'fileInfo.previewIndex' => 'Preview Index',
			'fileInfo.packetLength' => 'Packet Length',
			'fileInfo.filePresent' => 'File Present',
			'fileInfo.fileReadable' => 'Readable by Server',
			'fileInfo.streamPath' => 'Stream Path',
			'fileInfo.optimizedForStreaming' => 'Optimized for Streaming',
			'fileInfo.has64bitOffsets' => '64-bit Offsets',
			'fileInfo.protocol' => 'Protocol',
			'fileInfo.mediaType' => 'Media Type',
			'fileInfo.sourceKind' => 'Source Kind',
			'fileInfo.optimizedVersion' => 'Optimized Version',
			'fileInfo.optimizationTarget' => 'Optimization Target',
			'fileInfo.deletedAt' => 'Deleted',
			'fileInfo.remoteSource' => 'Remote Source',
			'fileInfo.infiniteStream' => 'Infinite Stream',
			'fileInfo.directPlay' => 'Direct Play',
			'fileInfo.directStream' => 'Direct Stream',
			'fileInfo.transcoding' => 'Transcoding',
			'fileInfo.etag' => 'ETag',
			'fileInfo.versionId' => 'Version ID',
			'fileInfo.fileId' => 'File ID',
			'fileInfo.defaultAudioTrack' => 'Default Audio Track',
			'fileInfo.defaultSubtitleTrack' => 'Default Subtitle Track',
			'fileInfo.subtitlesOff' => 'Off',
			'fileInfo.flagDefault' => 'Default',
			'fileInfo.flagForced' => 'Forced',
			'fileInfo.flagSelected' => 'Selected',
			'fileInfo.flagExternal' => 'External',
			'fileInfo.flagHearingImpaired' => 'Hearing impaired',
			'fileInfo.flagDub' => 'Dub',
			'fileInfo.flagOriginal' => 'Original',
			'mediaMenu.markAsWatched' => 'Mark as Watched',
			'mediaMenu.markAsUnwatched' => 'Mark as Unwatched',
			'mediaMenu.viewDetails' => 'View details',
			'mediaMenu.goToSeries' => 'Go to series',
			'mediaMenu.shufflePlay' => 'Shuffle Play',
			'mediaMenu.shuffleNotAvailableOffline' => 'Shuffle not available offline',
			'mediaMenu.fileInfo' => 'File Info',
			'mediaMenu.deleteFromServer' => 'Delete from server',
			'mediaMenu.confirmDelete' => 'Delete this media and its files from your server?',
			'mediaMenu.deleteMultipleWarning' => 'This includes all episodes and their files.',
			'mediaMenu.mediaDeletedSuccessfully' => 'Media item deleted successfully',
			'mediaMenu.mediaFailedToDelete' => 'Failed to delete media item',
			'mediaMenu.rate' => 'Rate',
			'mediaMenu.playFromBeginning' => 'Play from Beginning',
			'mediaMenu.playVersion' => 'Play Version...',
			'rateSheet.server' => 'Server',
			'rateSheet.favorite' => 'Favorite',
			'rateSheet.favorited' => 'Favorited',
			'rateSheet.saved' => 'Saved',
			'rateSheet.notAvailable' => 'No match found',
			'rateSheet.noConnectedServices' => 'Connect a service in Settings to rate there.',
			'accessibility.mediaCardMovie' => ({required Object title}) => '${title}, movie',
			'accessibility.mediaCardShow' => ({required Object title}) => '${title}, TV show',
			'accessibility.mediaCardEpisode' => ({required Object title, required Object episodeInfo}) => '${title}, ${episodeInfo}',
			'accessibility.mediaCardSeason' => ({required Object title, required Object seasonInfo}) => '${title}, ${seasonInfo}',
			'accessibility.mediaCardWatched' => 'watched',
			'accessibility.mediaCardPartiallyWatched' => ({required Object percent}) => '${percent} percent watched',
			'accessibility.mediaCardUnwatched' => 'unwatched',
			'accessibility.tapToPlay' => 'Tap to play',
			'accessibility.decrease' => 'Decrease',
			'accessibility.increase' => 'Increase',
			'accessibility.decreaseValue' => ({required Object label}) => 'Decrease ${label}',
			'accessibility.increaseValue' => ({required Object label}) => 'Increase ${label}',
			'accessibility.hue' => 'Hue',
			'accessibility.saturation' => 'Saturation',
			'accessibility.brightness' => 'Brightness',
			'accessibility.hexColor' => 'Hex color',
			'accessibility.expandText' => 'Expand text',
			'accessibility.collapseText' => 'Collapse text',
			'accessibility.alphabetNavigation' => 'Alphabet navigation',
			'accessibility.alphabetScrollHint' => 'Swipe up or down to move by letter',
			'accessibility.rowColumnPosition' => ({required Object row, required Object rowCount, required Object column, required Object columnCount}) => 'Row ${row} of ${rowCount}, column ${column} of ${columnCount}',
			'accessibility.rowPosition' => ({required Object row, required Object rowCount}) => 'Row ${row} of ${rowCount}',
			'tooltips.shufflePlay' => 'Shuffle play',
			'tooltips.playTrailer' => 'Play trailer',
			'tooltips.markAsWatched' => 'Mark as watched',
			'tooltips.markAsUnwatched' => 'Mark as unwatched',
			'tooltips.moreOptions' => 'More options',
			'audioTracks.track' => ({required Object n}) => 'Audio Track ${n}',
			'videoControls.audioLabel' => 'Audio',
			'videoControls.subtitlesLabel' => 'Subtitles',
			'videoControls.resetToZero' => 'Reset to 0ms',
			'videoControls.addTime' => ({required Object amount, required Object unit}) => '+${amount}${unit}',
			'videoControls.minusTime' => ({required Object amount, required Object unit}) => '-${amount}${unit}',
			'videoControls.playsLater' => ({required Object label}) => '${label} plays later',
			'videoControls.playsEarlier' => ({required Object label}) => '${label} plays earlier',
			'videoControls.noOffset' => 'No offset',
			'videoControls.letterbox' => 'Letterbox',
			'videoControls.fillScreen' => 'Fill screen',
			'videoControls.stretch' => 'Stretch',
			_ => null,
		} ?? switch (path) {
			'videoControls.lockRotation' => 'Lock rotation',
			'videoControls.unlockRotation' => 'Unlock rotation',
			'videoControls.timerActive' => 'Timer Active',
			'videoControls.playbackWillPauseIn' => ({required Object duration}) => 'Playback will pause in ${duration}',
			'videoControls.sleepTimerEndOfVideo' => 'End of current video',
			'videoControls.sleepTimerStopAtHeader' => 'Stop at',
			'videoControls.sleepTimerDurationHeader' => 'Timer',
			'videoControls.playbackWillPauseAtEnd' => 'Playback will pause at the end of this video',
			'videoControls.stillWatching' => 'Still watching?',
			'videoControls.pausingIn' => ({required Object seconds}) => 'Pausing in ${seconds}s',
			'videoControls.continueWatching' => 'Continue',
			'videoControls.autoPlayNext' => 'Auto-Play Next',
			'videoControls.playNext' => 'Play Next',
			'videoControls.playButton' => 'Play',
			'videoControls.pauseButton' => 'Pause',
			'videoControls.playbackPaused' => 'Paused',
			'videoControls.playbackResumed' => 'Playing',
			'videoControls.showPlaybackControls' => 'Show playback controls',
			'videoControls.hidePlaybackControls' => 'Hide playback controls',
			'videoControls.seekBackwardButton' => ({required Object seconds}) => 'Seek backward ${seconds} seconds',
			'videoControls.seekForwardButton' => ({required Object seconds}) => 'Seek forward ${seconds} seconds',
			'videoControls.previousButton' => 'Previous episode',
			'videoControls.nextButton' => 'Next episode',
			'videoControls.previousChapterButton' => 'Previous chapter',
			'videoControls.nextChapterButton' => 'Next chapter',
			'videoControls.muteButton' => 'Mute',
			'videoControls.unmuteButton' => 'Unmute',
			'videoControls.settingsButton' => 'Playback Settings',
			'videoControls.tracksButton' => 'Audio & Subtitles',
			'videoControls.chaptersButton' => 'Chapters',
			'videoControls.versionQualityButton' => 'Version & Quality',
			'videoControls.versionColumnHeader' => 'Version',
			'videoControls.qualityColumnHeader' => 'Quality',
			'videoControls.qualityOriginal' => 'Original',
			'videoControls.qualityPresetLabel' => ({required Object resolution, required Object bitrate}) => '${resolution}p ${bitrate} Mbps',
			'videoControls.transcodeUnavailableFallback' => 'Transcoding unavailable — playing original quality',
			'videoControls.subtitleUnavailableFallback' => 'Selected subtitles could not be loaded — continuing without subtitles',
			'videoControls.pipButton' => 'Picture-in-Picture mode',
			'videoControls.aspectRatioButton' => 'Aspect ratio',
			'videoControls.ambientLighting' => 'Ambient lighting',
			'videoControls.rotationLockButton' => 'Rotation lock',
			'videoControls.lockScreen' => 'Lock screen',
			'videoControls.screenLockButton' => 'Screen lock',
			'videoControls.longPressToUnlock' => 'Long press to unlock',
			'videoControls.timelineSlider' => 'Video timeline',
			'videoControls.volumeSlider' => 'Volume level',
			'videoControls.endsAt' => ({required Object time}) => 'Ends at ${time}',
			'videoControls.pipActive' => 'Playing in Picture-in-Picture',
			'videoControls.pipFailed' => 'Picture-in-picture failed to start',
			'videoControls.screenshotSaved' => 'Screenshot saved',
			'videoControls.zoomPercent' => ({required Object percent}) => 'Zoom ${percent}%',
			'videoControls.pipErrors.androidVersion' => 'Requires Android 8.0 or newer',
			'videoControls.pipErrors.iosVersion' => 'Requires iOS 15.0 or newer',
			'videoControls.pipErrors.permissionDisabled' => 'Picture-in-picture is disabled. Enable it in system settings.',
			'videoControls.pipErrors.notSupported' => 'Device doesn\'t support picture-in-picture mode',
			'videoControls.pipErrors.voSwitchFailed' => 'Failed to switch video output for picture-in-picture',
			'videoControls.pipErrors.failed' => 'Picture-in-picture failed to start',
			'videoControls.pipErrors.unknown' => ({required Object error}) => 'An error occurred: ${error}',
			'videoControls.chapters' => 'Chapters',
			'videoControls.noChaptersAvailable' => 'No chapters available',
			'videoControls.queue' => 'Queue',
			'videoControls.noQueueItems' => 'No items in queue',
			'messages.markedAsWatched' => 'Marked as watched',
			'messages.markedAsUnwatched' => 'Marked as unwatched',
			'messages.markedAsWatchedOffline' => 'Marked as watched (will sync when online)',
			'messages.markedAsUnwatchedOffline' => 'Marked as unwatched (will sync when online)',
			'messages.autoRemovedWatchedDownload' => ({required Object title}) => 'Auto-removed: ${title}',
			'messages.autoRemovedWatchedDownloads' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Auto-removed ${n} watched download', other: 'Auto-removed ${n} watched downloads', ), 
			'messages.errorLoading' => ({required Object error}) => 'Error: ${error}',
			'messages.searchPartialResults' => 'Some media servers could not be searched. Showing available results.',
			'messages.streamInterrupted' => 'The stream was interrupted. Press play or seek to retry.',
			'messages.fileInfoNotAvailable' => 'File information not available',
			'messages.playbackAuthenticationRequired' => 'Sign in to the media server again to play this item.',
			'messages.playbackServerUnavailable' => 'The media server is unavailable. Try again later.',
			'messages.playbackDataInvalid' => 'The server returned invalid playback information.',
			'messages.playbackCancelled' => 'Playback was canceled.',
			'messages.playbackFailed' => 'Playback could not be started.',
			'messages.errorLoadingFileInfo' => ({required Object error}) => 'Error loading file info: ${error}',
			'messages.errorLoadingSeries' => 'Error loading series',
			'messages.musicNotSupported' => 'Music playback is not yet supported',
			'messages.noDescriptionAvailable' => 'No description available',
			'messages.noProfilesAvailable' => 'No profiles available',
			'messages.contactAdminForProfiles' => 'Contact your server administrator to add profiles',
			'messages.unableToDetermineLibrarySection' => 'Unable to determine library section for this item',
			'messages.logsCleared' => 'Logs cleared',
			'messages.logsCopied' => 'Logs copied to clipboard',
			'messages.noLogsAvailable' => 'No logs available',
			'messages.metadataRefreshing' => ({required Object title}) => 'Refreshing metadata for "${title}"...',
			'messages.metadataRefreshStarted' => ({required Object title}) => 'Metadata refresh started for "${title}"',
			'messages.metadataRefreshFailed' => ({required Object error}) => 'Failed to refresh metadata: ${error}',
			'messages.logoutConfirm' => 'Are you sure you want to log out?',
			'messages.noSeasonsFound' => 'No seasons found',
			'messages.seasonsLoadFailed' => 'Couldn\'t load seasons',
			'messages.noEpisodesFound' => 'No episodes found in first season',
			'messages.noEpisodesFoundGeneral' => 'No episodes found',
			'messages.episodesLoadFailed' => 'Couldn\'t load episodes',
			'messages.noResultsFound' => 'No results found',
			'messages.sleepTimerSet' => ({required Object label}) => 'Sleep timer set for ${label}',
			'messages.noItemsAvailable' => 'No items available',
			'messages.failedToCreatePlayQueueNoItems' => 'Failed to create a play queue — no items',
			'messages.failedPlayback' => ({required Object action, required Object error}) => 'Failed to ${action}: ${error}',
			'messages.switchingToCompatiblePlayer' => 'Switching to compatible player...',
			'messages.serverLimitTitle' => 'Playback failed',
			'messages.serverLimitBody' => 'Server error (HTTP 500). A bandwidth/transcoding limit likely rejected this session. Ask the owner to adjust it.',
			'subtitlingStyling.text' => 'Text',
			'subtitlingStyling.border' => 'Border',
			'subtitlingStyling.background' => 'Background',
			'subtitlingStyling.fontSize' => 'Font Size',
			'subtitlingStyling.textColor' => 'Text Color',
			'subtitlingStyling.borderSize' => 'Border Size',
			'subtitlingStyling.borderColor' => 'Border Color',
			'subtitlingStyling.backgroundOpacity' => 'Background Opacity',
			'subtitlingStyling.backgroundColor' => 'Background Color',
			'subtitlingStyling.position' => 'Position',
			'subtitlingStyling.assOverride' => 'ASS Override',
			'subtitlingStyling.overrideScale' => 'Scale',
			'subtitlingStyling.overrideForce' => 'Force',
			'subtitlingStyling.overrideStrip' => 'Remove styling',
			'subtitlingStyling.positionTop' => 'Top',
			'subtitlingStyling.positionBottom' => 'Bottom',
			'subtitlingStyling.bold' => 'Bold',
			'subtitlingStyling.italic' => 'Italic',
			'subtitlingStyling.renderResolution' => 'Render Resolution',
			'subtitlingStyling.renderResolutionScreen' => 'Screen resolution',
			'subtitlingStyling.renderResolutionVideo' => 'Video resolution',
			'mpvConfig.title' => 'mpv.conf',
			'mpvConfig.description' => 'Advanced video player settings',
			'mpvConfig.presets' => 'Presets',
			'mpvConfig.noPresets' => 'No saved presets',
			'mpvConfig.saveAsPreset' => 'Save as Preset...',
			'mpvConfig.presetName' => 'Preset Name',
			'mpvConfig.presetNameHint' => 'Enter a name for this preset',
			'mpvConfig.loadPreset' => 'Load',
			'mpvConfig.deletePreset' => 'Delete',
			'mpvConfig.presetSaved' => 'Preset saved',
			'mpvConfig.presetLoaded' => 'Preset loaded',
			'mpvConfig.presetDeleted' => 'Preset deleted',
			'mpvConfig.confirmDeletePreset' => 'Are you sure you want to delete this preset?',
			'mpvConfig.configPlaceholder' => 'gpu-api=vulkan\nhwdec=auto\n# comment',
			'dialog.confirmAction' => 'Confirm Action',
			'profiles.addLocalProfile' => 'Add Harbor profile',
			'profiles.switchingProfile' => 'Switching profile…',
			'profiles.deleteThisProfileTitle' => 'Delete this profile?',
			'profiles.deleteThisProfileMessage' => ({required Object displayName}) => 'Remove ${displayName}. Connections aren\'t affected.',
			'profiles.active' => 'Active',
			'profiles.manage' => 'Manage',
			'profiles.delete' => 'Delete',
			'profiles.sectionTitle' => 'Profiles',
			'profiles.summarySingle' => 'Add profiles to mix managed users and local identities',
			'profiles.summaryMultipleWithActive' => ({required Object count, required Object activeName}) => '${count} profiles · active: ${activeName}',
			'profiles.summaryMultiple' => ({required Object count}) => '${count} profiles',
			'profiles.removeConnectionTitle' => 'Remove connection?',
			'profiles.removeConnectionMessage' => ({required Object displayName, required Object connectionLabel}) => 'Remove ${displayName}\'s access to ${connectionLabel}. Other profiles keep it.',
			'profiles.deleteProfileTitle' => 'Delete profile?',
			'profiles.deleteProfileMessage' => ({required Object displayName}) => 'Remove ${displayName} and its connections. Servers stay available.',
			'profiles.profileNameLabel' => 'Profile name',
			'profiles.pinProtectionLabel' => 'PIN protection',
			'profiles.setPin' => 'Set PIN',
			'profiles.setPinTitle' => 'Set PIN',
			'profiles.confirmPinTitle' => 'Confirm PIN',
			'profiles.pinSet' => 'PIN set',
			'profiles.changePin' => 'Change',
			'profiles.removePin' => 'Remove',
			'profiles.connectionsLabel' => 'Connections',
			'profiles.add' => 'Add',
			'profiles.deleteProfileButton' => 'Delete profile',
			'profiles.noConnectionsHint' => 'No connections — add one to use this profile.',
			'profiles.noConnections' => 'No connections',
			'profiles.connectionDefault' => 'Default',
			'profiles.makeDefault' => 'Make default',
			'profiles.removeConnection' => 'Remove',
			'profiles.profileRenamed' => 'Profile renamed.',
			'profiles.borrowAddTo' => ({required Object displayName}) => 'Add to ${displayName}',
			'profiles.borrowExplain' => 'Borrow another profile\'s connection. PIN-protected profiles require a PIN.',
			'profiles.borrowEmpty' => 'Nothing to borrow yet.',
			'profiles.borrowEmptySubtitle' => 'Connect Plex or Jellyfin to another profile first.',
			'profiles.borrowLoadFailed' => 'Available connections could not be loaded. Try again.',
			'profiles.borrowFromProfile' => ({required Object displayName}) => 'From ${displayName}',
			'profiles.borrowConnectionBorrowed' => 'Connection borrowed.',
			'profiles.borrowFailed' => 'Failed to borrow connection.',
			'profiles.incorrectPin' => 'Incorrect PIN.',
			'profiles.incorrectPinTryAgain' => 'Incorrect PIN. Please try again.',
			'profiles.newProfile' => 'New profile',
			'profiles.profileNameHint' => 'e.g. Guests, Kids, Family Room',
			'profiles.pinProtectionOptional' => 'PIN protection (optional)',
			'profiles.pinExplain' => '4-digit PIN required to switch profiles.',
			'profiles.continueButton' => 'Continue',
			'profiles.pinsDontMatch' => 'PINs don\'t match',
			'connections.sectionTitle' => 'Connections',
			'connections.addConnection' => 'Add connection',
			'connections.addConnectionSubtitleNoProfile' => 'Sign in with Plex or connect a Jellyfin server',
			'connections.addConnectionSubtitleScoped' => ({required Object displayName}) => 'Add to ${displayName}: Plex, Jellyfin, or another profile connection',
			'connections.sessionExpiredOne' => ({required Object name}) => 'Session expired for ${name}',
			'connections.sessionExpiredMany' => ({required Object count}) => 'Session expired for ${count} servers',
			'connections.signInAgain' => 'Sign in again',
			'connections.editJellyfinTitle' => 'Edit Jellyfin connection',
			'connections.editJellyfinIntro' => ({required Object serverName}) => 'Add or remove URLs for ${serverName}. Harbor will use the reachable URL with the lowest latency.',
			'discover.title' => 'Discover',
			'discover.noContentAvailable' => 'No content available',
			'discover.addMediaToLibraries' => 'Add some media to your libraries',
			'discover.continueWatching' => 'Continue Watching',
			'discover.continueWatchingIn' => ({required Object library}) => 'Continue Watching in ${library}',
			'discover.nextUpIn' => ({required Object library}) => 'Next Up in ${library}',
			'discover.recentlyAddedIn' => ({required Object library}) => 'Recently Added in ${library}',
			'discover.latestAlbumsIn' => ({required Object library}) => 'Latest Albums in ${library}',
			'discover.recentlyPlayedIn' => ({required Object library}) => 'Recently Played in ${library}',
			'discover.mostPlayedIn' => ({required Object library}) => 'Most Played in ${library}',
			'discover.playEpisode' => ({required Object season, required Object episode}) => 'S${season}E${episode}',
			'discover.cast' => 'Cast',
			'discover.extras' => 'Trailers & Extras',
			'discover.studio' => 'Studio',
			'discover.director' => 'Director',
			'discover.directors' => 'Directors',
			'discover.movie' => 'Movie',
			'discover.tvShow' => 'TV Show',
			'discover.minutesLeft' => ({required Object minutes}) => '${minutes} min left',
			'discover.moreLikeThis' => 'More Like This',
			'discover.genres' => 'Genres',
			'errors.searchFailed' => ({required Object error}) => 'Search failed: ${error}',
			'errors.searchUnavailable' => 'Search could not reach any media server.',
			'errors.connectionTimeout' => ({required Object context}) => 'Connection timeout while loading ${context}',
			'errors.connectionFailed' => 'Unable to connect to media server',
			'errors.unableToLoad' => ({required Object context}) => 'Unable to load ${context}. Please try again.',
			'errors.noClientAvailable' => 'No client available',
			'errors.failedToSwitchProfile' => ({required Object displayName}) => 'Failed to switch to ${displayName}',
			'errors.failedToDeleteProfile' => ({required Object displayName}) => 'Failed to delete ${displayName}',
			'errors.failedToRate' => 'Couldn\'t update rating',
			'libraries.title' => 'Libraries',
			'libraries.fallbackTitle' => 'Library',
			'libraries.refreshMetadata' => 'Refresh Metadata',
			'libraries.noLibrariesFound' => 'No libraries found',
			'libraries.allLibrariesHidden' => 'All libraries are hidden',
			'libraries.hiddenLibrariesCount' => ({required Object count}) => 'Hidden libraries (${count})',
			'libraries.thisLibraryIsEmpty' => 'This library is empty',
			'libraries.noItemsMatchFilters' => 'No items match the active filters',
			'libraries.resetFilters' => 'Reset filters',
			'libraries.all' => 'All',
			'libraries.clearAll' => 'Clear All',
			'libraries.refreshMetadataConfirm' => ({required Object title}) => 'Are you sure you want to refresh metadata for "${title}"?',
			'libraries.manageLibraries' => 'Manage Libraries',
			'libraries.sort' => 'Sort',
			'libraries.sortBy' => 'Sort By',
			'libraries.filters' => 'Filters',
			'libraries.confirmActionMessage' => 'Are you sure you want to perform this action?',
			'libraries.showLibrary' => 'Show library',
			'libraries.hideLibrary' => 'Hide library',
			'libraries.libraryOptions' => 'Library options',
			'libraries.content' => 'library content',
			'libraries.selectLibrary' => 'Select library',
			'libraries.filtersWithCount' => ({required Object count}) => 'Filters (${count})',
			'libraries.noCollections' => 'No collections in this library',
			'libraries.noFoldersFound' => 'No folders found',
			'libraries.folders' => 'folders',
			'libraries.tabs.browse' => 'Browse',
			'libraries.tabs.playlists' => 'Playlists',
			'libraries.tabs.missing' => 'Missing',
			'libraries.groupings.title' => 'Grouping',
			'libraries.groupings.all' => 'All',
			'libraries.groupings.movies' => 'Movies',
			'libraries.groupings.shows' => 'TV Shows',
			'libraries.groupings.seasons' => 'Seasons',
			'libraries.groupings.episodes' => 'Episodes',
			'libraries.groupings.artists' => 'Artists',
			'libraries.groupings.albums' => 'Albums',
			'libraries.groupings.tracks' => 'Tracks',
			'libraries.groupings.folders' => 'Folders',
			'libraries.groupings.collections' => 'Collections',
			'libraries.filterCategories.genre' => 'Genre',
			'libraries.filterCategories.year' => 'Year',
			'libraries.filterCategories.contentRating' => 'Content Rating',
			'libraries.filterCategories.tag' => 'Tag',
			'libraries.filterCategories.unwatched' => 'Unwatched',
			'libraries.filterCategories.unplayed' => 'Unplayed',
			'libraries.filterCategories.favorites' => 'Favorites',
			'libraries.sortLabels.title' => 'Title',
			'libraries.sortLabels.dateAdded' => 'Date Added',
			'libraries.sortLabels.communityRating' => 'Community Rating',
			'libraries.sortLabels.criticRating' => 'Critic Rating',
			'libraries.sortLabels.datePlayed' => 'Date Played',
			'libraries.sortLabels.playCount' => 'Play Count',
			'libraries.sortLabels.productionYear' => 'Production Year',
			'libraries.sortLabels.runtime' => 'Runtime',
			'libraries.sortLabels.officialRating' => 'Official Rating',
			'libraries.sortLabels.premiereDate' => 'Premiere Date',
			'libraries.sortLabels.startDate' => 'Start Date',
			'libraries.sortLabels.airTime' => 'Air Time',
			'libraries.sortLabels.studio' => 'Studio',
			'libraries.sortLabels.random' => 'Random',
			'libraries.sortLabels.lastEpisodeDateAdded' => 'Last Episode Date Added',
			'about.title' => 'About',
			'about.openSourceLicenses' => 'Open Source Licenses',
			'about.versionLabel' => ({required Object version}) => 'Version ${version}',
			'about.appDescription' => 'A beautiful Plex and Jellyfin client for Flutter',
			'about.viewLicensesDescription' => 'View licenses of third-party libraries',
			'hubDetail.title' => 'Title',
			'hubDetail.releaseYear' => 'Release Year',
			'hubDetail.dateAdded' => 'Date Added',
			'hubDetail.rating' => 'Rating',
			'hubDetail.noItemsFound' => 'No items found',
			'logs.clearLogs' => 'Clear Logs',
			'logs.copyLogs' => 'Copy Logs',
			'licenses.relatedPackages' => 'Related Packages',
			'licenses.license' => 'License',
			'licenses.licenseNumber' => ({required Object number}) => 'License ${number}',
			'licenses.licensesCount' => ({required Object count}) => '${count} licenses',
			'navigation.libraries' => 'Libraries',
			'navigation.downloads' => 'Downloads',
			'navigation.explore' => 'Explore',
			'explore.title' => 'Explore',
			'explore.selectSource' => 'Select source',
			'explore.rows.watchlist' => 'Watchlist',
			'explore.rows.recommendedMovies' => 'Recommended Movies',
			'explore.rows.recommendedShows' => 'Recommended Shows',
			'explore.rows.trendingMovies' => 'Trending Movies',
			'explore.rows.trendingShows' => 'Trending Shows',
			'explore.rows.popularMovies' => 'Popular Movies',
			'explore.rows.popularShows' => 'Popular Shows',
			'explore.rows.trendingAnime' => 'Trending Anime',
			'explore.rows.suggestedAnime' => 'Suggested Anime',
			'explore.rows.airingAnime' => 'Top Airing Anime',
			'explore.rows.popularAnime' => 'Most Popular Anime',
			'explore.rows.trending' => 'Trending',
			'explore.rows.upcomingMovies' => 'Upcoming Movies',
			'explore.rows.upcomingShows' => 'Upcoming Shows',
			'explore.status.airing' => 'Airing',
			'explore.status.ended' => 'Ended',
			'explore.status.canceled' => 'Canceled',
			'explore.status.upcoming' => 'Upcoming',
			'explore.episodeCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} episode', other: '${n} episodes', ), 
			'explore.seasonCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} season', other: '${n} seasons', ), 
			'explore.cast' => 'Cast',
			'explore.characters' => 'Characters',
			'explore.addToWatchlist' => 'Add to Watchlist',
			'explore.removeFromWatchlist' => 'Remove from Watchlist',
			'explore.watchlistUpdateFailed' => 'Couldn\'t update watchlist',
			'explore.notInLibrary' => 'Not in your library',
			'explore.inTheseLibraries' => 'In these libraries',
			'explore.checkingLibrary' => 'Checking your library...',
			'explore.emptyTitle' => 'Nothing here yet',
			'explore.emptyMessage' => ({required Object source}) => 'Rows from ${source} will appear here once they have content.',
			'explore.searchHint' => ({required Object source}) => 'Search ${source}',
			'explore.searchEmpty' => ({required Object query}) => 'No results for "${query}"',
			'explore.searchPrompt' => ({required Object source}) => 'Search for movies and shows on ${source}.',
			'explore.searchFailed' => 'Search failed. Check your connection and try again.',
			'explore.badge.rankPopular' => ({required Object n}) => '#${n} popular',
			'explore.badge.rankAiring' => ({required Object n}) => '#${n} airing',
			'explore.badge.rankRated' => ({required Object n}) => '#${n} rated',
			'explore.badge.rankFavorited' => ({required Object n}) => '#${n} favorited',
			'explore.badge.rankTrending' => ({required Object n}) => '#${n} trending',
			'explore.badge.rankSeasonal' => ({required Object n, required Object season}) => '#${n} in ${season}',
			'explore.badge.watchingNow' => ({required Object n}) => '${n} watching',
			'explore.badge.available' => 'Available',
			'explore.badge.partiallyAvailable' => 'Partly available',
			'explore.badge.availableIn4k' => '4K available',
			'explore.badge.requested' => 'Requested',
			'explore.badge.pendingApproval' => 'Pending approval',
			'explore.badge.processing' => 'Processing',
			'explore.badge.declined' => 'Declined',
			'explore.badge.requestFailed' => 'Request failed',
			'explore.badge.requested4k' => '4K requested',
			'explore.badge.seasonsAvailable' => ({required Object available, required Object total}) => '${available}/${total} seasons',
			'explore.badge.nextEpisodeIn' => ({required Object episode, required Object duration}) => 'Ep ${episode} in ${duration}',
			'explore.badge.nextAiringIn' => ({required Object duration}) => 'Next in ${duration}',
			'explore.badge.episodesShort' => ({required Object n}) => '${n} eps',
			'explore.badge.minutesPerEpisode' => ({required Object n}) => '${n} min/ep',
			'explore.badge.adult' => '18+',
			'explore.stats.listed' => ({required Object n}) => '${n} listed',
			'explore.stats.viewersDay' => ({required Object n}) => '${n} watched today',
			'explore.stats.viewersWeek' => ({required Object n}) => '${n} watched this week',
			'explore.stats.viewersMonth' => ({required Object n}) => '${n} watched this month',
			'explore.stats.viewersYear' => ({required Object n}) => '${n} watched this year',
			'explore.stats.viewersAllTime' => ({required Object n}) => '${n} viewers',
			'explore.stats.planning' => ({required Object n}) => '${n} planning to watch',
			'explore.stats.favorited' => ({required Object n}) => '${n} favorites',
			'explore.stats.dropRate' => ({required Object percent}) => '${percent} dropped it',
			'explore.stats.comments' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} comment', other: '${n} comments', ), 
			'explore.stats.votes' => ({required Object n}) => '${n} votes',
			'explore.stats.watching' => ({required Object n}) => '${n} watching it',
			'explore.stats.completed' => ({required Object n}) => '${n} completed',
			'explore.stats.onHold' => ({required Object n}) => '${n} on hold',
			'explore.stats.dropped' => ({required Object n}) => '${n} dropped',
			'explore.season.winter' => 'Winter',
			'explore.season.spring' => 'Spring',
			'explore.season.summer' => 'Summer',
			'explore.season.fall' => 'Fall',
			'explore.season.withYear' => ({required Object season, required Object year}) => '${season} ${year}',
			'explore.format.tv' => 'TV',
			'explore.format.tvShort' => 'TV Short',
			'explore.format.movie' => 'Movie',
			'explore.format.special' => 'Special',
			'explore.format.ova' => 'OVA',
			'explore.format.ona' => 'ONA',
			'explore.format.music' => 'Music',
			'explore.format.other' => 'Other',
			'explore.sourceMaterial.original' => 'Original',
			'explore.sourceMaterial.manga' => 'Manga',
			'explore.sourceMaterial.lightNovel' => 'Light novel',
			'explore.sourceMaterial.novel' => 'Novel',
			'explore.sourceMaterial.visualNovel' => 'Visual novel',
			'explore.sourceMaterial.game' => 'Game',
			'explore.sourceMaterial.webComic' => 'Web comic',
			'explore.sourceMaterial.musicRelease' => 'Music',
			'explore.sourceMaterial.otherMedia' => 'Other',
			'explore.creditRole.director' => 'Director',
			'explore.creditRole.writer' => 'Writer',
			'explore.creditRole.producer' => 'Producer',
			'explore.creditRole.creator' => 'Creator',
			'explore.creditRole.composer' => 'Composer',
			'explore.ratingSource.critic' => 'Critics',
			'explore.ratingSource.audience' => 'Audience',
			'explore.ratingSource.imdb' => 'IMDb',
			'explore.ratingSource.tmdb' => 'TMDB',
			'explore.ratingSource.rottenTomatoes' => 'Rotten Tomatoes',
			'explore.ratingSource.simkl' => 'Simkl',
			'explore.ratingSource.mal' => 'MyAnimeList',
			'explore.ratingSource.anilist' => 'AniList',
			'explore.ratingSource.trakt' => 'Trakt',
			'explore.ratingSource.rottenTomatoesCritic' => 'Rotten Tomatoes critics',
			'explore.ratingSource.rottenTomatoesAudience' => 'Rotten Tomatoes audience',
			'explore.broadcast' => ({required Object day, required Object time}) => 'Airs ${day} at ${time}',
			'explore.broadcastWithZone' => ({required Object day, required Object time, required Object timezone}) => 'Airs ${day} at ${time} ${timezone}',
			'explore.detail.originalTitle' => 'Original title',
			'explore.detail.alsoKnownAs' => 'Also known as',
			'explore.detail.studios' => 'Studios',
			'explore.detail.country' => 'Country',
			'explore.detail.language' => 'Language',
			'explore.detail.released' => 'Released',
			'explore.detail.physicalRelease' => 'On disc',
			'explore.detail.ended' => 'Ended',
			'explore.detail.addedOn' => ({required Object date}) => 'Added ${date}',
			'explore.detail.yourRating' => 'Your rating',
			'explore.detail.budget' => 'Budget',
			'explore.detail.revenue' => 'Box office',
			'explore.detail.contentAdvisory' => 'Age guidance',
			'explore.detail.tags' => 'Tags',
			'explore.detail.revealSpoilerTags' => 'Show spoiler tags',
			'explore.detail.links' => 'Links',
			'explore.detail.watchOn' => 'Watch on',
			'explore.detail.watchTrailer' => 'Watch trailer',
			'explore.detail.openOn' => ({required Object site}) => 'Open on ${site}',
			'explore.detail.crew' => 'Crew',
			'explore.detail.ratings' => 'Ratings',
			'explore.detail.schedule' => 'Schedule',
			'explore.detail.recommendedByUsers' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: 'Recommended by ${n} user', other: 'Recommended by ${n} users', ), 
			'explore.detail.recommendedBy' => ({required Object who}) => 'Recommended by ${who}',
			'explore.detail.favoritedBy' => ({required Object who}) => 'Favorited by ${who}',
			'explore.detail.unairedEpisodes' => ({required Object n}) => '${n} not aired yet',
			'explore.detail.recommendedByPercent' => ({required Object percent}) => 'Recommended by ${percent} of viewers',
			'explore.detail.relatedTitles' => 'Related titles',
			'explore.detail.background' => 'Background',
			'explore.relation.prequel' => 'Prequel',
			'explore.relation.sequel' => 'Sequel',
			'explore.relation.sideStory' => 'Side story',
			'explore.relation.spinOff' => 'Spin-off',
			'explore.relation.alternativeVersion' => 'Alternative version',
			'explore.relation.summary' => 'Summary',
			'explore.relation.parentStory' => 'Parent story',
			'explore.relation.adaptation' => 'Adaptation',
			'explore.relation.other' => 'Related',
			'collections.collection' => 'Collection',
			'collections.empty' => 'Collection is empty',
			'collections.deleteCollection' => 'Delete Collection',
			'collections.deleteConfirm' => ({required Object title}) => 'Delete "${title}"? This can\'t be undone.',
			'collections.deleted' => 'Collection deleted',
			'collections.deleteFailed' => 'Failed to delete collection',
			'collections.deleteFailedWithError' => ({required Object error}) => 'Failed to delete collection: ${error}',
			'collections.selectCollection' => 'Select Collection',
			'collections.collectionName' => 'Collection Name',
			'collections.enterCollectionName' => 'Enter collection name',
			'collections.addedToCollection' => 'Added to collection',
			'collections.errorAddingToCollection' => 'Failed to add to collection',
			'collections.created' => 'Collection created',
			'collections.removeFromCollection' => 'Remove from collection',
			'collections.removeFromCollectionConfirm' => ({required Object title}) => 'Remove "${title}" from this collection?',
			'collections.removedFromCollection' => 'Removed from collection',
			'collections.removeFromCollectionFailed' => 'Failed to remove from collection',
			'collections.removeFromCollectionError' => ({required Object error}) => 'Error removing from collection: ${error}',
			'collections.searchCollections' => 'Search collections...',
			'playlists.title' => 'Playlists',
			'playlists.playlist' => 'Playlist',
			'playlists.noPlaylists' => 'No playlists found',
			'playlists.create' => 'Create Playlist',
			'playlists.playlistName' => 'Playlist Name',
			'playlists.enterPlaylistName' => 'Enter playlist name',
			'playlists.delete' => 'Delete Playlist',
			'playlists.removeItem' => 'Remove from Playlist',
			'playlists.smartPlaylist' => 'Smart Playlist',
			'playlists.itemCount' => ({required Object count}) => '${count} items',
			'playlists.oneItem' => '1 item',
			'playlists.emptyPlaylist' => 'This playlist is empty',
			'playlists.deleteConfirm' => 'Delete Playlist?',
			'playlists.deleteMessage' => ({required Object name}) => 'Are you sure you want to delete "${name}"?',
			'playlists.created' => 'Playlist created',
			'playlists.deleted' => 'Playlist deleted',
			'playlists.itemAdded' => 'Added to playlist',
			'playlists.itemRemoved' => 'Removed from playlist',
			'playlists.selectPlaylist' => 'Select Playlist',
			'playlists.searchPlaylists' => 'Search playlists...',
			'playlists.errorCreating' => 'Failed to create playlist',
			'playlists.errorDeleting' => 'Failed to delete playlist',
			'playlists.errorLoading' => 'Failed to load playlists',
			'playlists.errorAdding' => 'Failed to add to playlist',
			'playlists.errorReordering' => 'Failed to reorder playlist item',
			'playlists.errorRemoving' => 'Failed to remove from playlist',
			'music.goToAlbum' => 'Go to album',
			'music.goToArtist' => 'Go to artist',
			'music.instantMix' => 'Instant Mix',
			'music.playNext' => 'Play next',
			'music.addToQueue' => 'Add to queue',
			'music.discNumber' => ({required Object n}) => 'Disc ${n}',
			'music.trackCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('en'))(n, one: '${n} track', other: '${n} tracks', ), 
			'music.nowPlaying' => 'Now Playing',
			_ => null,
		} ?? switch (path) {
			'music.playingFrom' => ({required Object title}) => 'Playing from ${title}',
			'music.queue' => 'Queue',
			'music.clearQueue' => 'Clear queue',
			'music.lyrics' => 'Lyrics',
			'music.noLyrics' => 'No lyrics available',
			'music.sleepTimer' => 'Sleep timer',
			'music.sleepTimerEndOfTrack' => 'End of track',
			'music.sleepTimerMinutes' => ({required Object n}) => '${n} minutes',
			'music.stopPlayback' => 'Stop playback',
			'music.previousTrack' => 'Previous track',
			'music.nextTrack' => 'Next track',
			'music.repeat' => 'Repeat',
			'music.repeatAll' => 'Repeat all',
			'music.repeatOne' => 'Repeat one',
			'downloads.title' => 'Downloads',
			'downloads.manage' => 'Manage',
			'downloads.tvShows' => 'TV Shows',
			'downloads.movies' => 'Movies',
			'downloads.music' => 'Music',
			'downloads.tracksQueued' => ({required Object count}) => '${count} tracks queued for download',
			'downloads.noDownloads' => 'No downloads yet',
			'downloads.noDownloadsDescription' => 'Downloaded content will appear here for offline viewing',
			'downloads.downloadNow' => 'Download',
			'downloads.deleteDownload' => 'Delete download',
			'downloads.retryDownload' => 'Retry download',
			'downloads.downloadQueued' => 'Download queued',
			'downloads.downloadResumed' => 'Download resumed',
			'downloads.serverErrorBitrate' => 'Server error: file may exceed the remote bitrate limit',
			'downloads.storageFull' => 'Downloads stopped because device storage is full. Free some space, then retry.',
			'downloads.episodesQueued' => ({required Object count}) => '${count} episodes queued for download',
			'downloads.downloadDeleted' => 'Download deleted',
			'downloads.deleteConfirm' => ({required Object title}) => 'Delete "${title}" from this device?',
			'downloads.cancelledDownloadTitle' => 'Canceled Download',
			'downloads.cancelledDownloadMessage' => 'This download was canceled. What would you like to do?',
			'downloads.allEpisodesAlreadyDownloaded' => 'All episodes already downloaded',
			'downloads.resumeDownload' => 'Resume download',
			'downloads.cancelledDownload' => 'Canceled download',
			'downloads.syncingFile' => ({required Object file, required Object status}) => '${file} (syncing ${status})',
			'downloads.downloadedFileClickToComplete' => ({required Object file}) => 'Downloaded ${file} - Click to complete',
			'downloads.partialDownloadClickToComplete' => 'Partially downloaded - Click to complete',
			'downloads.deleting' => 'Deleting...',
			'downloads.deletingWithProgress' => ({required Object title, required Object current, required Object total}) => 'Deleting ${title}... (${current} of ${total})',
			'downloads.queuedTooltip' => 'Queued',
			'downloads.queuedFilesTooltip' => ({required Object files}) => 'Queued ${files}',
			'downloads.downloadingTooltip' => 'Downloading...',
			'downloads.downloadingFilesTooltip' => ({required Object files}) => 'Downloading ${files}',
			'downloads.noDownloadsTree' => 'No downloads',
			'downloads.pauseAll' => 'Pause all',
			'downloads.resumeAll' => 'Resume all',
			'downloads.deleteAll' => 'Delete all',
			'downloads.selectVersion' => 'Select Version',
			'downloads.allEpisodes' => 'All episodes',
			'downloads.unwatchedOnly' => 'Unwatched only',
			'downloads.nextNUnwatched' => ({required Object count}) => 'Next ${count} unwatched',
			'downloads.customAmount' => 'Custom amount...',
			'downloads.includeSpecials' => 'Include Specials',
			'downloads.howManyEpisodes' => 'How many episodes?',
			'downloads.invalidEpisodeCount' => 'Enter a valid episode count.',
			'downloads.keepSynced' => 'Keep synced',
			'downloads.downloadOnce' => 'Download once',
			'downloads.keepNUnwatched' => ({required Object count}) => 'Keep ${count} unwatched',
			'downloads.editSyncRule' => 'Edit sync rule',
			'downloads.removeSyncRule' => 'Remove sync rule',
			'downloads.removeSyncRuleConfirm' => ({required Object title}) => 'Stop syncing "${title}"? Downloaded episodes will be kept.',
			'downloads.removeListSyncRuleConfirm' => ({required Object title}) => 'Stop syncing "${title}"?',
			'downloads.deleteSyncRuleDownloads' => 'Also delete associated downloads',
			'downloads.deleteSyncRuleDownloadsDescription' => 'Downloads used by another sync rule or profile will be kept.',
			'downloads.syncRuleCreated' => ({required Object count}) => 'Sync rule created — keeping ${count} unwatched episodes',
			'downloads.syncRuleUpdated' => 'Sync rule updated',
			'downloads.syncRuleRemoved' => 'Sync rule removed',
			'downloads.syncRuleAndDownloadsRemoved' => 'Sync rule and associated downloads removed',
			'downloads.syncRuleCleanupBusy' => 'Sync rules are currently updating. Try again in a moment.',
			'downloads.syncRuleCleanupUnavailable' => 'Associated downloads could not be identified safely. Reconnect the server and try again, or remove the rule without deleting downloads.',
			'downloads.syncedNewEpisodes' => ({required Object count, required Object title}) => 'Synced ${count} new episodes for ${title}',
			'downloads.activeSyncRules' => 'Sync rules',
			'downloads.noSyncRules' => 'No sync rules',
			'downloads.manageSyncRule' => 'Manage sync',
			'downloads.editEpisodeCount' => 'Episode count',
			'downloads.editSyncFilter' => 'Sync filter',
			'downloads.syncAllItems' => 'Syncing all items',
			'downloads.syncUnwatchedItems' => 'Syncing unwatched items',
			'downloads.syncRuleServerContext' => ({required Object server, required Object status}) => 'Server: ${server} • ${status}',
			'downloads.syncRuleAvailable' => 'Available',
			'downloads.syncRuleOffline' => 'Offline',
			'downloads.syncRuleSignInRequired' => 'Sign in required',
			'downloads.syncRuleNotAvailableForProfile' => 'Not available for current profile',
			'downloads.syncRuleUnknownServer' => 'Unknown server',
			'downloads.syncRuleListCreated' => 'Sync rule created',
			'downloads.backgroundWarning.bannerBlocked' => 'Downloads will stop when you leave the app',
			'downloads.backgroundWarning.bannerDegraded' => 'Background downloads may be limited',
			'downloads.backgroundWarning.bannerAction' => 'Details',
			'downloads.backgroundWarning.sheetTitle' => 'Background downloads are blocked',
			'downloads.backgroundWarning.sheetTitleDegraded' => 'Background downloads may be limited',
			'downloads.backgroundWarning.sheetIntro' => 'Android is preventing Harbor from downloading reliably in the background.',
			'downloads.backgroundWarning.sheetIntroDegraded' => 'Your device is limiting when Harbor can download in the background.',
			'downloads.backgroundWarning.reasonBackgroundRestricted' => 'Harbor\'s background usage is restricted. Set its battery or background usage to "Unrestricted".',
			'downloads.backgroundWarning.reasonStandbyRestricted' => 'Android has put Harbor in a restricted standby state. Set its battery usage to "Unrestricted".',
			'downloads.backgroundWarning.reasonDownloadChannelBlocked' => 'Download notifications are turned off, so progress and controls may be unavailable.',
			'downloads.backgroundWarning.reasonNotificationsDisabled' => 'Notifications are turned off. On Android 13 or newer, they are required for long background downloads.',
			'downloads.backgroundWarning.reasonDataSaver' => 'Data Saver is on, which blocks background downloads on mobile data. Downloads should still run on Wi-Fi.',
			'downloads.backgroundWarning.reasonOemUnknown' => 'Downloads repeatedly stopped while Harbor was in the background. Check Harbor\'s battery or background usage settings.',
			'downloads.backgroundWarning.openSettings' => 'Open settings',
			'downloads.backgroundWarning.stillNotWorking' => 'Device-specific help',
			'downloads.backgroundWarning.stillNotWorkingDescription' => 'See steps for your device, or send a log from Settings › View Logs if the issue continues.',
			'downloads.backgroundWarning.dialogTitle' => 'Downloads may not finish',
			'downloads.backgroundWarning.dialogDownloadAnyway' => 'Download anyway',
			'downloads.backgroundWarning.dialogFixFirst' => 'Fix this first',
			'downloads.backgroundWarning.statusTile' => 'Background downloads',
			'downloads.backgroundWarning.statusOk' => 'Allowed to run in the background',
			'downloads.backgroundWarning.statusBlocked' => 'Blocked by system settings',
			'downloads.backgroundWarning.statusDegraded' => 'Limited by system settings',
			'downloads.backgroundWarning.statusUnknown' => 'Not checked yet',
			'downloads.backgroundWarning.settingsUnavailable' => 'Couldn\'t open system settings on this device',
			'downloads.backgroundWarning.linkUnavailable' => 'Couldn\'t open dontkillmyapp.com on this device',
			'shaders.title' => 'Shaders',
			'shaders.noShaderDescription' => 'No video enhancement',
			'shaders.nvscalerDescription' => 'NVIDIA image scaling for sharper video',
			'shaders.artcnnVariantNeutral' => 'Neutral',
			'shaders.artcnnVariantDenoise' => 'Denoise',
			'shaders.artcnnVariantDenoiseSharpen' => 'Denoise + Sharpen',
			'shaders.qualityFast' => 'Fast',
			'shaders.qualityHQ' => 'High Quality',
			'shaders.mode' => 'Mode',
			'shaders.importShader' => 'Import Shader',
			'shaders.customShaderDescription' => 'Custom GLSL shader',
			'shaders.shaderImported' => 'Shader imported',
			'shaders.shaderImportFailed' => 'Failed to import shader',
			'shaders.deleteShader' => 'Delete Shader',
			'shaders.deleteShaderConfirm' => ({required Object name}) => 'Delete "${name}"?',
			'videoSettings.playbackSpeed' => 'Playback Speed',
			'videoSettings.normalSpeed' => 'Normal',
			'videoSettings.sleepTimerActive' => ({required Object duration}) => 'Active (${duration})',
			'videoSettings.zoom' => 'Zoom',
			'videoSettings.sleepTimer' => 'Sleep Timer',
			'videoSettings.audioSync' => 'Audio Sync',
			'videoSettings.subtitleSync' => 'Subtitle Sync',
			'videoSettings.hdr' => 'HDR',
			'videoSettings.audioOutput' => 'Audio Output',
			'videoSettings.performanceOverlay' => 'Performance Overlay',
			'videoSettings.audioPassthrough' => 'Audio Passthrough',
			'videoSettings.audioOutputDolbyAtmos' => 'Dolby Atmos',
			'videoSettings.audioOutputDolbyAudio' => 'Dolby Audio',
			'videoSettings.audioOutputSurround' => 'Surround',
			'videoSettings.audioOutputSpatial' => 'Spatial Audio',
			'videoSettings.audioOutputStereo' => 'Stereo',
			'videoSettings.audioNormalization' => 'Normalize Loudness',
			'videoSettings.audioDownmix' => 'Downmix to Stereo',
			'performanceOverlay.color' => 'Color',
			'performanceOverlay.performance' => 'Performance',
			'performanceOverlay.buffer' => 'Buffer',
			'performanceOverlay.app' => 'App',
			'performanceOverlay.decoder' => 'Decoder',
			'performanceOverlay.rawDecoder' => 'Raw Decoder',
			'performanceOverlay.tunneling' => 'Tunneling',
			'performanceOverlay.aspect' => 'Aspect',
			'performanceOverlay.rotation' => 'Rotation',
			'performanceOverlay.dvSource' => 'DV Source',
			'performanceOverlay.dvPath' => 'DV Path',
			'performanceOverlay.p7Conversion' => 'P7 Conv',
			'performanceOverlay.sampleRate' => 'Sample Rate',
			'performanceOverlay.pixelFormat' => 'Pixel Fmt',
			'performanceOverlay.hwFormat' => 'HW Fmt',
			'performanceOverlay.matrix' => 'Matrix',
			'performanceOverlay.primaries' => 'Primaries',
			'performanceOverlay.transfer' => 'Transfer',
			'performanceOverlay.renderFps' => 'Render FPS',
			'performanceOverlay.displayFps' => 'Display FPS',
			'performanceOverlay.avSync' => 'A/V Sync',
			'performanceOverlay.dropped' => 'Dropped',
			'performanceOverlay.dvRpus' => 'DV RPUs',
			'performanceOverlay.dvRpuAverage' => 'DV RPU Avg',
			'performanceOverlay.dvSampleAverage' => 'DV Sample Avg',
			'performanceOverlay.maxLuma' => 'Max Luma',
			'performanceOverlay.minLuma' => 'Min Luma',
			'performanceOverlay.maxCll' => 'MaxCLL',
			'performanceOverlay.maxFall' => 'MaxFALL',
			'performanceOverlay.cacheUsed' => 'Cache Used',
			'performanceOverlay.cacheLimit' => 'Cache Limit',
			'performanceOverlay.speed' => 'Speed',
			'performanceOverlay.player' => 'Player',
			'performanceOverlay.memory' => 'Memory',
			'performanceOverlay.uiFps' => 'UI FPS',
			'externalPlayer.title' => 'External Player',
			'externalPlayer.useExternalPlayer' => 'Use External Player',
			'externalPlayer.useExternalPlayerDescription' => 'Open videos in another app',
			'externalPlayer.selectPlayer' => 'Select Player',
			'externalPlayer.customPlayers' => 'Custom Players',
			'externalPlayer.systemDefault' => 'System Default',
			'externalPlayer.addCustomPlayer' => 'Add Custom Player',
			'externalPlayer.playerName' => 'Player Name',
			'externalPlayer.playerNameHint' => 'My Player',
			'externalPlayer.playerCommand' => 'Command',
			'externalPlayer.playerPackage' => 'Package Name',
			'externalPlayer.playerUrlScheme' => 'URL Scheme',
			'externalPlayer.off' => 'Off',
			'externalPlayer.launchFailed' => 'Failed to open external player',
			'externalPlayer.appNotInstalled' => ({required Object name}) => '${name} is not installed',
			'externalPlayer.playInExternalPlayer' => 'Play in External Player',
			'metadataEdit.editMetadata' => 'Edit...',
			'metadataEdit.screenTitle' => 'Edit Metadata',
			'metadataEdit.basicInfo' => 'Basic Info',
			'metadataEdit.artwork' => 'Artwork',
			'metadataEdit.title' => 'Title',
			'metadataEdit.sortTitle' => 'Sort Title',
			'metadataEdit.originalTitle' => 'Original Title',
			'metadataEdit.releaseDate' => 'Release Date',
			'metadataEdit.contentRating' => 'Content Rating',
			'metadataEdit.studio' => 'Studio',
			'metadataEdit.tagline' => 'Tagline',
			'metadataEdit.summary' => 'Summary',
			'metadataEdit.poster' => 'Poster',
			'metadataEdit.background' => 'Background',
			'metadataEdit.logo' => 'Logo',
			'metadataEdit.squareArt' => 'Square Art',
			'metadataEdit.selectPoster' => 'Select Poster',
			'metadataEdit.selectBackground' => 'Select Background',
			'metadataEdit.selectLogo' => 'Select Logo',
			'metadataEdit.selectSquareArt' => 'Select Square Art',
			'metadataEdit.fromUrl' => 'From URL',
			'metadataEdit.uploadFile' => 'Upload File',
			'metadataEdit.enterImageUrl' => 'Enter image URL',
			'metadataEdit.imageUrl' => 'Image URL',
			'metadataEdit.metadataUpdated' => 'Metadata updated',
			'metadataEdit.metadataUpdateFailed' => 'Failed to update metadata',
			'metadataEdit.artworkUpdated' => 'Artwork updated',
			'metadataEdit.artworkUpdateFailed' => 'Failed to update artwork',
			'metadataEdit.noArtworkAvailable' => 'No artwork available',
			'metadataEdit.artworkOption' => ({required Object index}) => 'Artwork option ${index}',
			'metadataEdit.selectedArtworkOption' => ({required Object index}) => 'Artwork option ${index}, selected',
			'metadataEdit.notSet' => 'Not set',
			'metadataEdit.tags' => 'Tags',
			'metadataEdit.addTag' => 'Add tag',
			'metadataEdit.genre' => 'Genre',
			'metadataEdit.director' => 'Director',
			'metadataEdit.writer' => 'Writer',
			'metadataEdit.producer' => 'Producer',
			'metadataEdit.country' => 'Country',
			'metadataEdit.label' => 'Label',
			'trakt.title' => 'Trakt',
			'trakt.connected' => 'Connected',
			'trakt.connectedAs' => ({required Object username}) => 'Connected as @${username}',
			'trakt.disconnectConfirm' => 'Disconnect Trakt account?',
			'trakt.disconnectConfirmBody' => 'Harbor will stop sending events to Trakt. You can reconnect any time.',
			'trakt.scrobble' => 'Real-time scrobbling',
			'trakt.scrobbleDescription' => 'Send play, pause, and stop events to Trakt during playback.',
			'trakt.watchedSync' => 'Sync watched status',
			'trakt.watchedSyncDescription' => 'When you mark items as watched in Harbor, they are also marked as watched on Trakt.',
			'seerr.title' => 'Seerr',
			'seerr.connectTitle' => 'Connect Seerr',
			'seerr.serverUrl' => 'Server URL',
			'seerr.serverUrlHelper' => 'The address of your Seerr instance',
			'seerr.checkServer' => 'Continue',
			'seerr.signInWithJellyfin' => 'Sign in with Jellyfin',
			'seerr.signInWithEmby' => 'Sign in with Emby',
			'seerr.signInWithLocal' => 'Use a local account',
			'seerr.email' => 'Email',
			'seerr.noSignInMethods' => 'This Seerr instance offers no sign-in method Harbor supports.',
			'seerr.instance' => 'Instance',
			'seerr.disconnectConfirm' => 'Disconnect Seerr?',
			'seerr.disconnectConfirmBody' => 'Harbor will forget this Seerr instance. Reconnect any time.',
			'seerr.request' => 'Request',
			'seerr.request4k' => 'Request in 4K',
			'seerr.seasons' => 'Seasons',
			'seerr.allSeasons' => 'All seasons',
			'seerr.advancedOptions' => 'Advanced',
			'seerr.destinationServer' => 'Destination server',
			'seerr.qualityProfile' => 'Quality profile',
			'seerr.rootFolder' => 'Root folder',
			'seerr.languageProfile' => 'Language profile',
			'seerr.requestSubmitted' => 'Request submitted',
			'seerr.requestFailed' => ({required Object error}) => 'Request failed: ${error}',
			'seerr.requestsLoadFailed' => 'Couldn\'t load request options',
			'seerr.nothingToRequest' => 'Everything is already available or requested.',
			'seerr.statusAvailable' => 'Available',
			'seerr.statusPartiallyAvailable' => 'Partially available',
			'seerr.statusRequested' => 'Requested',
			'seerr.statusProcessing' => 'Processing',
			'services.title' => 'Services',
			'services.hubSubtitle' => 'Sync watch progress and request new titles.',
			'services.notConnected' => 'Not connected',
			'services.connectedAs' => ({required Object username}) => 'Connected as @${username}',
			'services.scrobble' => 'Track progress automatically',
			'services.scrobbleDescription' => 'Update your list when you finish an episode or movie.',
			'services.disconnectConfirm' => ({required Object service}) => 'Disconnect ${service}?',
			'services.disconnectConfirmBody' => ({required Object service}) => 'Harbor will stop updating ${service}. Reconnect any time.',
			'services.connectFailed' => ({required Object service}) => 'Couldn\'t connect to ${service}. Try again.',
			'services.names.simkl' => 'Simkl',
			'services.names.seerr' => 'Seerr',
			'services.deviceCode.title' => ({required Object service}) => 'Activate Harbor on ${service}',
			'services.deviceCode.body' => ({required Object url}) => 'Visit ${url} and enter this code:',
			'services.deviceCode.openToActivate' => ({required Object service}) => 'Open ${service} to activate',
			'services.deviceCode.copyCode' => 'Copy activation code',
			'services.deviceCode.waitingForAuthorization' => 'Waiting for authorization…',
			'services.deviceCode.codeCopied' => 'Code copied',
			'services.libraryFilter.title' => 'Library filter',
			'services.libraryFilter.subtitleAllSyncing' => 'Syncing all libraries',
			'services.libraryFilter.subtitleNoneSyncing' => 'Nothing syncing',
			'services.libraryFilter.subtitleBlocked' => ({required Object count}) => '${count} blocked',
			'services.libraryFilter.subtitleAllowed' => ({required Object count}) => '${count} allowed',
			'services.libraryFilter.mode' => 'Filter mode',
			'services.libraryFilter.modeBlacklist' => 'Blacklist',
			'services.libraryFilter.modeWhitelist' => 'Whitelist',
			'services.libraryFilter.modeHintBlacklist' => 'Sync every library except the ones checked below.',
			'services.libraryFilter.modeHintWhitelist' => 'Sync only the libraries checked below.',
			'services.libraryFilter.libraries' => 'Libraries',
			'services.libraryFilter.noLibraries' => 'No libraries available',
			'addServer.addJellyfinTitle' => 'Add Jellyfin server',
			'addServer.serverUrls' => 'Server URLs',
			'addServer.serverUrlsHelper' => 'Multiple URLs allowed, separated by commas.',
			'addServer.findServer' => 'Find server',
			'addServer.searchingLocalServers' => 'Looking for local Jellyfin servers...',
			'addServer.localServers' => 'Local Jellyfin servers',
			'addServer.username' => 'Username',
			'addServer.password' => 'Password',
			'addServer.signIn' => 'Sign in',
			'addServer.change' => 'Change',
			'addServer.required' => 'Required',
			'addServer.couldNotReachServer' => ({required Object error}) => 'Could not reach the server: ${error}',
			'addServer.signInFailed' => ({required Object error}) => 'Sign-in failed: ${error}',
			'addServer.quickConnectFailed' => ({required Object error}) => 'Quick Connect failed: ${error}',
			'addServer.enterJellyfinUrlError' => 'Enter your Jellyfin server URL',
			'addServer.addConnectionTitle' => 'Add connection',
			'addServer.addConnectionTitleScoped' => ({required Object name}) => 'Add to ${name}',
			'addServer.connectToJellyfinCard' => 'Connect to Jellyfin',
			'addServer.connectToJellyfinCardSubtitle' => 'Enter your server URL, username, and password.',
			'addServer.connectToJellyfinCardSubtitleScoped' => ({required Object name}) => 'Sign in to a Jellyfin server. Binds to ${name}.',
			'addServer.borrowFromAnotherProfile' => 'Borrow from another profile',
			'addServer.borrowFromAnotherProfileSubtitle' => 'Reuse another profile\'s connection. PIN-protected profiles require a PIN.',
			'managedServices.sectionTitle' => 'Media servers',
			'managedServices.add' => 'Add a service',
			'managedServices.addTitle' => 'Add a service',
			'managedServices.kinds.radarr' => 'Radarr',
			'managedServices.kinds.sonarr' => 'Sonarr',
			'managedServices.kinds.qbittorrent' => 'qBittorrent',
			'managedServices.kindHints.radarr' => 'Films',
			'managedServices.kindHints.sonarr' => 'Series',
			'managedServices.kindHints.qbittorrent' => 'Download client',
			'managedServices.addressLabel' => 'Address',
			'managedServices.addressHint' => 'radarr.home.lan:7878',
			'managedServices.apiKeyLabel' => 'API key',
			'managedServices.apiKeyHelp' => ({required Object service}) => 'Settings → General → API Key in ${service}.',
			'managedServices.usernameLabel' => 'Username',
			'managedServices.passwordLabel' => 'Password',
			'managedServices.nameLabel' => 'Name (optional)',
			'managedServices.nameHint' => 'Radarr 4K',
			'managedServices.nameHelp' => 'Shown instead of the address. Useful when you run more than one.',
			'managedServices.connect' => 'Connect',
			'managedServices.save' => 'Save',
			'managedServices.connected' => 'Connected',
			'managedServices.reconnect' => 'Reconnect',
			'managedServices.unreachable' => 'Unreachable',
			'managedServices.checking' => 'Checking…',
			'managedServices.recheck' => 'Check again',
			'managedServices.remove' => 'Remove',
			'managedServices.removeConfirm' => ({required Object name}) => 'Remove ${name}?',
			'managedServices.removeConfirmBody' => 'Harbor stops reading from it. Nothing on the server changes.',
			'managedServices.addressRequired' => 'Enter the address Harbor should reach it on.',
			'managedServices.apiKeyRequired' => 'Enter the API key.',
			'managedServices.usernameRequired' => 'Enter the username.',
			'managedServices.keyRejected' => ({required Object service}) => '${service} rejected that key.',
			'managedServices.loginRejected' => 'That username and password were refused.',
			'managedServices.notReachable' => ({required Object address}) => 'Could not reach ${address}.',
			'managedServices.notThisService' => ({required Object service}) => 'That address answered, but not like ${service}. Check the port and any base path.',
			'serverActivity.tab' => 'Server',
			'serverActivity.stages.queued' => 'Queued',
			'serverActivity.stages.downloading' => 'Downloading',
			'serverActivity.stages.importing' => 'Importing',
			'serverActivity.stages.done' => 'Available',
			'serverActivity.stages.failed' => 'Failed',
			'serverActivity.stalled' => 'Stalled',
			'serverActivity.paused' => 'Paused',
			'serverActivity.completedHeading' => 'Completed',
			'serverActivity.nothingQueued' => 'Nothing downloading',
			'serverActivity.nothingQueuedDescription' => 'When Radarr or Sonarr grabs something, it shows up here.',
			'serverActivity.noServices' => 'No media servers connected',
			'serverActivity.noServicesDescription' => 'Add Radarr, Sonarr or your download client to watch what is arriving.',
			'serverActivity.openServices' => 'Add a service',
			'serverActivity.unreachable' => ({required Object names}) => 'Could not reach ${names}',
			'serverActivity.etaRemaining' => ({required Object time}) => '${time} left',
			'serverActivity.ofSize' => ({required Object done, required Object total}) => '${done} of ${total}',
			'serverActivity.arriving' => 'Arriving',
			'serverActivity.arrivingEpisode' => ({required Object season, required Object episode}) => 'S${season}E${episode} arriving',
			'serverActivity.monitored' => 'Monitored',
			'serverActivity.notMonitored' => 'Not monitored',
			'serverActivity.missingEpisodes' => ({required Object count}) => '${count} missing',
			'serverActivity.allPresent' => 'All episodes present',
			'serverActivity.onDisk' => 'On disk',
			'serverActivity.notOnDisk' => 'Not on disk',
			'serverActivity.alsoQueued' => ({required Object count}) => '+${count} more queued',
			'serverActivity.nextAiring' => ({required Object when}) => 'Next episode ${when}',
			'serverActivity.airedOn' => ({required Object date}) => 'Aired ${date}',
			'serverActivity.airsOn' => ({required Object date}) => 'Airs ${date}',
			'serverActivity.unmonitored' => 'Unmonitored',
			'serverActivity.notDownloadedOne' => 'Not downloaded',
			'serverActivity.episodeSlot' => ({required Object season, required Object episode}) => 'S${season}E${episode}',
			'serverActivity.nothingMissing' => 'Nothing missing',
			'serverActivity.nothingMissingDescription' => ({required Object service}) => '${service} has a file for everything it is tracking here.',
			'arrSearch.title' => 'Search',
			'arrSearch.auto' => 'Search automatically',
			'arrSearch.autoDescription' => ({required Object service}) => 'Hand it to ${service} and let it pick.',
			'arrSearch.manual' => 'Choose a release',
			'arrSearch.manualDescription' => 'Ask the indexers and pick one yourself.',
			'arrSearch.searching' => 'Asking the indexers…',
			'arrSearch.searchingSlow' => 'This can take a while.',
			'arrSearch.noReleases' => 'No releases found',
			'arrSearch.noReleasesDescription' => 'The indexers had nothing for this.',
			'arrSearch.failed' => 'Search failed',
			'arrSearch.handedOver' => ({required Object service}) => 'Searching in ${service}',
			'arrSearch.grabbed' => ({required Object service}) => 'Sent to ${service}',
			'arrSearch.grabFailed' => ({required Object service}) => '${service} refused that release',
			'arrSearch.rejectedTitle' => ({required Object service}) => 'Rejected by ${service}',
			'arrSearch.grabAnyway' => 'Grab anyway',
			'arrSearch.seeders' => ({required Object count}) => '${count} seeders',
			'arrSearch.ageHours' => ({required Object count}) => '${count} h old',
			'arrSearch.ageDays' => ({required Object count}) => '${count} d old',
			'arrSearch.scopeMovie' => 'This film',
			'arrSearch.scopeSeries' => 'Whole series',
			'arrSearch.scopeSeason' => ({required Object season}) => 'Season ${season}',
			'arrSearch.scopeEpisode' => ({required Object season, required Object episode}) => 'S${season}E${episode}',
			_ => null,
		};
	}
}
