///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$de app = _Translations$app$de._(_root);
	@override late final _Translations$auth$de auth = _Translations$auth$de._(_root);
	@override late final _Translations$common$de common = _Translations$common$de._(_root);
	@override late final _Translations$screens$de screens = _Translations$screens$de._(_root);
	@override late final _Translations$update$de update = _Translations$update$de._(_root);
	@override late final _Translations$settings$de settings = _Translations$settings$de._(_root);
	@override late final _Translations$search$de search = _Translations$search$de._(_root);
	@override late final _Translations$hotkeys$de hotkeys = _Translations$hotkeys$de._(_root);
	@override late final _Translations$fileInfo$de fileInfo = _Translations$fileInfo$de._(_root);
	@override late final _Translations$mediaMenu$de mediaMenu = _Translations$mediaMenu$de._(_root);
	@override late final _Translations$rateSheet$de rateSheet = _Translations$rateSheet$de._(_root);
	@override late final _Translations$accessibility$de accessibility = _Translations$accessibility$de._(_root);
	@override late final _Translations$tooltips$de tooltips = _Translations$tooltips$de._(_root);
	@override late final _Translations$audioTracks$de audioTracks = _Translations$audioTracks$de._(_root);
	@override late final _Translations$videoControls$de videoControls = _Translations$videoControls$de._(_root);
	@override late final _Translations$messages$de messages = _Translations$messages$de._(_root);
	@override late final _Translations$subtitlingStyling$de subtitlingStyling = _Translations$subtitlingStyling$de._(_root);
	@override late final _Translations$mpvConfig$de mpvConfig = _Translations$mpvConfig$de._(_root);
	@override late final _Translations$dialog$de dialog = _Translations$dialog$de._(_root);
	@override late final _Translations$profiles$de profiles = _Translations$profiles$de._(_root);
	@override late final _Translations$connections$de connections = _Translations$connections$de._(_root);
	@override late final _Translations$discover$de discover = _Translations$discover$de._(_root);
	@override late final _Translations$errors$de errors = _Translations$errors$de._(_root);
	@override late final _Translations$libraries$de libraries = _Translations$libraries$de._(_root);
	@override late final _Translations$about$de about = _Translations$about$de._(_root);
	@override late final _Translations$hubDetail$de hubDetail = _Translations$hubDetail$de._(_root);
	@override late final _Translations$logs$de logs = _Translations$logs$de._(_root);
	@override late final _Translations$licenses$de licenses = _Translations$licenses$de._(_root);
	@override late final _Translations$navigation$de navigation = _Translations$navigation$de._(_root);
	@override late final _Translations$explore$de explore = _Translations$explore$de._(_root);
	@override late final _Translations$collections$de collections = _Translations$collections$de._(_root);
	@override late final _Translations$playlists$de playlists = _Translations$playlists$de._(_root);
	@override late final _Translations$music$de music = _Translations$music$de._(_root);
	@override late final _Translations$downloads$de downloads = _Translations$downloads$de._(_root);
	@override late final _Translations$shaders$de shaders = _Translations$shaders$de._(_root);
	@override late final _Translations$videoSettings$de videoSettings = _Translations$videoSettings$de._(_root);
	@override late final _Translations$performanceOverlay$de performanceOverlay = _Translations$performanceOverlay$de._(_root);
	@override late final _Translations$externalPlayer$de externalPlayer = _Translations$externalPlayer$de._(_root);
	@override late final _Translations$metadataEdit$de metadataEdit = _Translations$metadataEdit$de._(_root);
	@override late final _Translations$trakt$de trakt = _Translations$trakt$de._(_root);
	@override late final _Translations$seerr$de seerr = _Translations$seerr$de._(_root);
	@override late final _Translations$services$de services = _Translations$services$de._(_root);
	@override late final _Translations$addServer$de addServer = _Translations$addServer$de._(_root);
}

// Path: app
class _Translations$app$de extends Translations$app$en {
	_Translations$app$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plezy';
}

// Path: auth
class _Translations$auth$de extends Translations$auth$en {
	_Translations$auth$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get connectToJellyfin => 'Mit Jellyfin verbinden';
	@override String get useQuickConnect => 'Quick Connect verwenden';
	@override String get quickConnectInstructions => 'Öffne Quick Connect in Jellyfin und gib diesen Code ein.';
	@override String get quickConnectWaiting => 'Warte auf Bestätigung…';
	@override String get quickConnectCancel => 'Abbrechen';
	@override String get quickConnectExpired => 'Quick Connect ist abgelaufen. Versuche es erneut.';
	@override String get localDataRecoveryRequired => 'Plezy konnte lokale Anmeldedaten und ausstehende Wiedergabedaten nicht sicher wiederherstellen. Bitte melde dich erneut an.';
}

// Path: common
class _Translations$common$de extends Translations$common$en {
	_Translations$common$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Abbrechen';
	@override String get save => 'Speichern';
	@override String get close => 'Schließen';
	@override String get clear => 'Leeren';
	@override String get reset => 'Zurücksetzen';
	@override String get later => 'Später';
	@override String get submit => 'Senden';
	@override String get confirm => 'Bestätigen';
	@override String get retry => 'Erneut versuchen';
	@override String get logout => 'Abmelden';
	@override String get unknown => 'Unbekannt';
	@override String get refresh => 'Aktualisieren';
	@override String get yes => 'Ja';
	@override String get no => 'Nein';
	@override String get delete => 'Löschen';
	@override String get edit => 'Bearbeiten';
	@override String get shuffle => 'Zufallswiedergabe';
	@override String get addTo => 'Hinzufügen zu …';
	@override String get createNew => 'Neu erstellen';
	@override String get disconnect => 'Trennen';
	@override String get play => 'Abspielen';
	@override String get pause => 'Pause';
	@override String get resume => 'Fortsetzen';
	@override String get error => 'Fehler';
	@override String get search => 'Suche';
	@override String get home => 'Start';
	@override String get back => 'Zurück';
	@override String get settings => 'Einstellungen';
	@override String get ok => 'OK';
	@override String get off => 'Aus';
	@override String seasonNumber({required Object number}) => 'Staffel ${number}';
	@override String episodeNumberTitle({required Object number, required Object title}) => 'Folge ${number} – ${title}';
	@override String chapterNumber({required Object number}) => 'Kapitel ${number}';
	@override String get reconnect => 'Erneut verbinden';
	@override String get viewAll => 'Alle anzeigen';
	@override String get checkingNetwork => 'Netzwerk wird geprüft...';
	@override String get loadingServers => 'Server werden geladen...';
	@override String get connectingToServers => 'Verbindung zu Servern wird hergestellt …';
	@override String get startingOfflineMode => 'Offlinemodus wird gestartet...';
	@override String get loading => 'Wird geladen …';
	@override String get fullscreen => 'Vollbild';
	@override String get exitFullscreen => 'Vollbild verlassen';
	@override String get pressBackAgainToExit => 'Zum Beenden erneut Zurück drücken';
	@override String get next => 'Weiter';
}

// Path: screens
class _Translations$screens$de extends Translations$screens$en {
	_Translations$screens$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get licenses => 'Lizenzen';
	@override String get switchProfile => 'Profil wechseln';
	@override String get subtitleStyling => 'Untertitel-Stil';
	@override String get mpvConfig => 'mpv.conf';
	@override String get logs => 'Protokolle';
}

// Path: update
class _Translations$update$de extends Translations$update$en {
	_Translations$update$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get available => 'Update verfügbar';
	@override String versionAvailable({required Object version}) => 'Version ${version} ist verfügbar';
	@override String currentVersion({required Object version}) => 'Aktuell: ${version}';
	@override String get skipVersion => 'Diese Version überspringen';
	@override String get viewRelease => 'Versionshinweise anzeigen';
	@override String get latestVersion => 'Aktuellste Version installiert';
	@override String get checkFailed => 'Fehler bei der Updateprüfung';
}

// Path: settings
class _Translations$settings$de extends Translations$settings$en {
	_Translations$settings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Einstellungen';
	@override String get supportDeveloper => 'Plezy unterstützen';
	@override String get supportDeveloperDescription => 'Per Liberapay spenden, um die Entwicklung zu fördern';
	@override String get language => 'Sprache';
	@override String get theme => 'Design';
	@override String get appearance => 'Darstellung';
	@override String get videoPlayback => 'Videowiedergabe';
	@override String get videoPlaybackDescription => 'Wiedergabeverhalten konfigurieren';
	@override String get advanced => 'Erweitert';
	@override String get episodePosterMode => 'Episodenposter-Stil';
	@override String get seriesPoster => 'Serienposter';
	@override String get seasonPoster => 'Staffelposter';
	@override String get episodeThumbnail => 'Vorschaubild';
	@override String get showHeroSectionDescription => 'Bereich mit empfohlenen Inhalten auf der Startseite anzeigen';
	@override String get secondsLabel => 'Sekunden';
	@override String get minutesLabel => 'Minuten';
	@override String get secondsShort => 's';
	@override String get minutesShort => 'm';
	@override String durationHint({required Object min, required Object max}) => 'Dauer eingeben (${min}-${max})';
	@override String get systemTheme => 'System';
	@override String get lightTheme => 'Hell';
	@override String get darkTheme => 'Dunkel';
	@override String get oledTheme => 'OLED';
	@override String get libraryDensity => 'Darstellungsdichte der Mediathek';
	@override String get compact => 'Kompakt';
	@override String get comfortable => 'Großzügig';
	@override String get tvCornerSpotlightBackdrop => 'Backdrop in der Ecke';
	@override String get tvCornerSpotlightBackdropDescription => 'Zeigt das Spotlight-Artwork oben rechts statt bildschirmfüllend';
	@override String get viewMode => 'Ansichtsmodus';
	@override String get gridView => 'Raster';
	@override String get listView => 'Liste';
	@override String get showHeroSection => 'Empfehlungsbereich anzeigen';
	@override String get continueWatchingAction => 'Aktion für Weiterschauen';
	@override String get continueWatchingPlay => 'Abspielen';
	@override String get continueWatchingDetails => 'Details öffnen';
	@override String get episodeAction => 'Episodenaktion';
	@override String get episodePlay => 'Abspielen';
	@override String get episodeDetails => 'Details öffnen';
	@override String get useGlobalHubs => 'Startlayout verwenden';
	@override String get useGlobalHubsDescription => 'Einheitliche Start-Hubs anzeigen. Sonst Bibliotheksempfehlungen verwenden.';
	@override String get showServerNameOnHubs => 'Servername bei Hubs anzeigen';
	@override String get showServerNameOnHubsDescription => 'Servernamen immer in Hub-Titeln anzeigen.';
	@override String get groupLibrariesByServer => 'Mediatheken nach Server gruppieren';
	@override String get groupLibrariesByServerDescription => 'Sidebar-Bibliotheken nach Medienserver gruppieren.';
	@override String get alwaysKeepSidebarOpen => 'Seitenleiste immer geöffnet halten';
	@override String get alwaysKeepSidebarOpenDescription => 'Seitenleiste bleibt erweitert und Inhaltsbereich passt sich an';
	@override String get showUnwatchedCount => 'Anzahl nicht gesehener Folgen anzeigen';
	@override String get showUnwatchedCountDescription => 'Zeigt die Anzahl nicht gesehener Episoden bei Serien und Staffeln an';
	@override String get showEpisodeNumberOnCards => 'Episodennummer auf Karten anzeigen';
	@override String get showEpisodeNumberOnCardsDescription => 'Staffel- und Episodennummer auf Episodenkarten anzeigen';
	@override String get showSeasonPostersOnTabs => 'Staffelposter auf Tabs anzeigen';
	@override String get showSeasonPostersOnTabsDescription => 'Poster jeder Staffel über ihrem Tab anzeigen';
	@override String get tvFullCardLayout => 'Vollflächige TV-Karten';
	@override String get tvFullCardLayoutDescription => 'TV-Karten nur mit Bild verwenden und Darstellernamen einblenden';
	@override String get focusGlow => 'Fokusleuchten';
	@override String get focusGlowDescription => 'Sanftes Leuchten um die fokussierte Karte anzeigen';
	@override String get visualEffects => 'Visuelle Effekte';
	@override String get visualEffectsAuto => 'Automatisch';
	@override String get visualEffectsAutoDescription => 'Effekte auf leistungsschwachen Geräten automatisch reduzieren';
	@override String get visualEffectsFull => 'Vollständig';
	@override String get visualEffectsReduced => 'Reduziert';
	@override String get visualEffectsReducedDescription => 'Weniger Animationen und Grafiken mit niedrigerer Auflösung';
	@override String get hideSpoilers => 'Spoiler für nicht gesehene Episoden verbergen';
	@override String get hideSpoilersDescription => 'Vorschaubilder und Beschreibungen ungesehener Episoden verwischen';
	@override String get playerBackend => 'Wiedergabe-Engine';
	@override String get exoPlayer => 'ExoPlayer';
	@override String get mpv => 'mpv';
	@override String get hardwareDecoding => 'Hardwaredekodierung';
	@override String get hardwareDecodingDescription => 'Hardwarebeschleunigung verwenden, sofern verfügbar';
	@override String get bufferSize => 'Puffergröße';
	@override String bufferSizeMB({required Object size}) => '${size} MB';
	@override String get bufferSizeAuto => 'Automatisch (empfohlen)';
	@override String bufferSizeWarning({required Object heap, required Object size}) => '${heap} MB Speicher verfügbar. Ein Puffer von ${size} MB kann die Wiedergabe beeinträchtigen.';
	@override String get defaultQualityTitle => 'Standardqualität';
	@override String get musicQualityTitle => 'Musikqualität';
	@override String get subtitleStyling => 'Untertitel-Stil';
	@override String get subtitleStylingDescription => 'Aussehen von Untertiteln anpassen';
	@override String get smallSkipDuration => 'Kleines Sprungintervall';
	@override String get largeSkipDuration => 'Großes Sprungintervall';
	@override String get rewindOnResume => 'Zurückspulen bei Fortsetzung';
	@override String secondsUnit({required Object seconds}) => '${seconds} Sekunden';
	@override String get defaultSleepTimer => 'Standard-Schlaftimer';
	@override String minutesUnit({required Object minutes}) => '${minutes} Minuten';
	@override String get rememberTrackSelections => 'Spurauswahl pro Serie/Film merken';
	@override String get rememberTrackSelectionsDescription => 'Audio- und Untertitelauswahl je Titel merken';
	@override String get followServerTrackSelections => 'Serverseitige Spurauswahl pro Episode verwenden';
	@override String get followServerTrackSelectionsDescription => 'Beim Episodenwechsel die auf dem Server ausgewählten Audio- und Untertitelspuren übernehmen, statt die aktuelle Auswahl zu übertragen';
	@override String get showChapterMarkersOnTimeline => 'Kapitelmarkierungen auf der Suchleiste anzeigen';
	@override String get showChapterMarkersOnTimelineDescription => 'Die Suchleiste an Kapitelgrenzen unterteilen';
	@override String get clickVideoTogglesPlayback => 'Video zum Abspielen oder Pausieren anklicken';
	@override String get clickVideoTogglesPlaybackDescription => 'Video zum Abspielen oder Pausieren anklicken, statt die Steuerung anzuzeigen.';
	@override String get videoPlayerControls => 'Videoplayer-Steuerung';
	@override String get keyboardShortcuts => 'Tastenkürzel';
	@override String get keyboardShortcutsDescription => 'Tastenkürzel anpassen';
	@override String get videoPlayerNavigation => 'Videoplayer-Navigation';
	@override String get videoPlayerNavigationDescription => 'Mit den Pfeiltasten durch die Videoplayer-Steuerung navigieren';
	@override String get crashReporting => 'Absturzberichte';
	@override String get crashReportingDescription => 'Absturzberichte senden, um die App zu verbessern';
	@override String get debugLogging => 'Debug-Protokollierung';
	@override String get debugLoggingDescription => 'Detaillierte Protokolle zur Fehleranalyse aktivieren';
	@override String get viewLogs => 'Protokolle anzeigen';
	@override String get viewLogsDescription => 'App-Protokolle anzeigen';
	@override String get resetSettings => 'Einstellungen zurücksetzen';
	@override String get resetSettingsDescription => 'Standardeinstellungen wiederherstellen. Dies kann nicht rückgängig gemacht werden.';
	@override String get resetSettingsSuccess => 'Einstellungen erfolgreich zurückgesetzt';
	@override String get backup => 'Sicherung';
	@override String get exportSettings => 'Einstellungen exportieren';
	@override String get exportSettingsDescription => 'Einstellungen in einer Datei speichern';
	@override String get exportSettingsSuccess => 'Einstellungen exportiert';
	@override String get importSettings => 'Einstellungen importieren';
	@override String get importSettingsDescription => 'Einstellungen aus einer Datei wiederherstellen';
	@override String get importSettingsConfirm => 'Dies ersetzt deine aktuellen Einstellungen. Fortfahren?';
	@override String get importSettingsSuccess => 'Einstellungen importiert';
	@override String get importSettingsInvalidFile => 'Diese Datei ist kein gültiger Plezy-Einstellungsexport';
	@override String get importSettingsNoUser => 'Vor dem Import bitte anmelden';
	@override String get shortcutsReset => 'Tastenkürzel auf Standard zurückgesetzt';
	@override String get about => 'Über';
	@override String get aboutDescription => 'App-Informationen und Lizenzen';
	@override String get updates => 'Updates';
	@override String get updateAvailable => 'Update verfügbar';
	@override String get checkForUpdates => 'Nach Updates suchen';
	@override String get autoCheckUpdatesOnStartup => 'Beim Start automatisch nach Updates suchen';
	@override String get autoCheckUpdatesOnStartupDescription => 'Beim Start benachrichtigen, wenn ein Update verfügbar ist';
	@override String get validationErrorEnterNumber => 'Bitte eine gültige Zahl eingeben';
	@override String validationErrorDuration({required Object min, required Object max, required Object unit}) => 'Dauer muss zwischen ${min} und ${max} ${unit} liegen';
	@override String shortcutAlreadyAssigned({required Object action}) => 'Tastenkürzel bereits zugewiesen an ${action}';
	@override String shortcutUpdated({required Object action}) => 'Tastenkürzel aktualisiert für ${action}';
	@override String get saveFailed => 'Änderungen konnten nicht gespeichert werden. Versuche es erneut.';
	@override String get autoSkip => 'Automatisches Überspringen';
	@override String get autoSkipIntro => 'Intro automatisch überspringen';
	@override String get autoSkipIntroDescription => 'Intro-Marker nach wenigen Sekunden automatisch überspringen';
	@override String get autoSkipCredits => 'Abspann automatisch überspringen';
	@override String get autoSkipCreditsDescription => 'Abspann automatisch überspringen und nächste Episode abspielen';
	@override String get forceSkipMarkerFallback => 'Ersatzmarkierungen erzwingen';
	@override String get forceSkipMarkerFallbackDescription => 'Kapitel-Titelmuster auch dann verwenden, wenn Plex über Markierungen verfügt';
	@override String get autoSkipDelay => 'Verzögerung für automatisches Überspringen';
	@override String autoSkipDelayDescription({required Object seconds}) => '${seconds} Sekunden vor dem automatischen Überspringen warten';
	@override String get introPattern => 'Intro-Markierungsmuster';
	@override String get introPatternDescription => 'Regulärer Ausdruck zum Erkennen von Intro-Markierungen in Kapiteltiteln';
	@override String get creditsPattern => 'Abspann-Markierungsmuster';
	@override String get creditsPatternDescription => 'Regulärer Ausdruck zum Erkennen von Abspann-Markierungen in Kapiteltiteln';
	@override String get invalidRegex => 'Ungültiger regulärer Ausdruck';
	@override String get regex => 'Regulärer Ausdruck';
	@override String get downloads => 'Downloads';
	@override String get downloadLocationDescription => 'Speicherort für heruntergeladene Inhalte wählen';
	@override String get downloadLocationDefault => 'Standard (App-Speicher)';
	@override String get downloadLocationCustom => 'Benutzerdefinierter Speicherort';
	@override String get selectFolder => 'Ordner auswählen';
	@override String get resetToDefault => 'Auf Standard zurücksetzen';
	@override String currentPath({required Object path}) => 'Aktuell: ${path}';
	@override String get downloadLocationChanged => 'Download-Speicherort geändert';
	@override String get downloadLocationReset => 'Download-Speicherort auf Standard zurückgesetzt';
	@override String get downloadLocationInvalid => 'Ausgewählter Ordner ist nicht beschreibbar';
	@override String get downloadLocationPickerUnavailable => 'Die Ordnerauswahl ist auf diesem Gerät nicht verfügbar';
	@override String get downloadOnWifiOnly => 'Nur über WLAN herunterladen';
	@override String get downloadOnWifiOnlyDescription => 'Downloads über mobile Daten verhindern';
	@override String get autoRemoveWatchedDownloads => 'Gesehene Downloads automatisch entfernen';
	@override String get autoRemoveWatchedDownloadsDescription => 'Angesehene Downloads automatisch löschen';
	@override String get cellularDownloadBlocked => 'Downloads über das Mobilfunknetz sind blockiert. Nutze WLAN oder ändere die Einstellung.';
	@override String get maxVolume => 'Maximale Lautstärke';
	@override String get maxVolumeDescription => 'Lautstärkeanhebung über 100 % für leise Medien erlauben';
	@override String maxVolumePercent({required Object percent}) => '${percent} %';
	@override String get discordRichPresence => 'Discord Rich Presence';
	@override String get discordRichPresenceDescription => 'Auf Discord anzeigen, was du gerade schaust';
	@override String get services => 'Dienste';
	@override String get servicesDescription => 'Trakt, MyAnimeList, Seerr und mehr verbinden';
	@override String get manageLibrariesDescription => 'Mediatheken neu anordnen und ausblenden';
	@override String get autoPip => 'Automatisches Bild-in-Bild';
	@override String get autoPipDescription => 'Beim Verlassen der App während der Wiedergabe automatisch Bild-in-Bild starten';
	@override String get matchContentFrameRate => 'Inhalts-Bildrate anpassen';
	@override String get matchContentFrameRateDescription => 'Bildwiederholrate des Displays an Videoinhalt anpassen';
	@override String get matchRefreshRate => 'Bildwiederholrate anpassen';
	@override String get matchRefreshRateDescription => 'Bildwiederholrate im Vollbild anpassen';
	@override String get matchDynamicRange => 'Dynamikumfang anpassen';
	@override String get matchDynamicRangeDescription => 'HDR für HDR-Inhalte einschalten, danach zurück zu SDR';
	@override String get displaySwitchDelay => 'Verzögerung beim Displaywechsel';
	@override String get tunneledPlayback => 'Tunnelwiedergabe';
	@override String get tunneledPlaybackDescription => 'Video-Tunneling verwenden. Deaktivieren, wenn HDR-Wiedergabe schwarzes Video zeigt.';
	@override String get audioPassthrough => 'Audio-Durchleitung';
	@override String get audioPassthroughDescription => 'Dolby/DTS-Audio ohne Neukodierung an deinen Receiver oder Fernseher senden und Surround-Sound erhalten. Deaktivieren, wenn kein Ton zu hören ist.';
	@override String get audioPassthroughDescriptionAppleTv => 'Apples nativen Dolby-Decoder für Dolby Digital Plus einschließlich Atmos verwenden. DTS und TrueHD werden weiterhin als Mehrkanal-PCM wiedergegeben. Deaktivieren, wenn kein Ton zu hören ist.';
	@override String get audioDownmix => 'Auf Stereo heruntermischen';
	@override String get audioDownmixDescription => 'Surround-Ton für Stereolautsprecher oder Kopfhörer auf zwei Kanäle heruntermischen';
	@override String get downmixCenterBoost => 'Verstärkung des Center-Kanals';
	@override String downmixCenterBoostValue({required Object db}) => '${db} dB';
	@override String get downmixCenterBoostLabel => 'Verstärkung (dB)';
	@override String get downmixCenterBoostShort => 'dB';
	@override String get audioDownmixNormalize => 'Lautstärke beim Downmix normalisieren';
	@override String get audioDownmixNormalizeDescription => 'Senkt den Mix ab, um Übersteuerung zu vermeiden. Deaktivieren, um die Originallautstärke zu behalten (laute Szenen können verzerren).';
	@override String get atmosDiagnostics => 'Atmos-Ausgabetest';
	@override String get atmosDiagnosticsDescription => 'Dolby-Atmos-Ausgabe diagnostizieren, indem Testsignale über den Systemplayer abgespielt werden';
	@override String get atmosTestHlsAtmos => 'Apple-Atmos-Stream';
	@override String get atmosTestHlsAtmosDescription => 'Garantiert funktionierender Dolby-Atmos-Stream. Der Receiver sollte Dolby Atmos anzeigen.';
	@override String get atmosTestHlsControl => 'Apple-Surround-Stream';
	@override String get atmosTestHlsControlDescription => 'Kontrollstream ohne Atmos. Der Receiver sollte Surround ohne Atmos anzeigen.';
	@override String get atmosTestRawStream => 'Roher EAC3-Stream';
	@override String get atmosTestRawStreamDescription => 'Streamt die Testdatei genau wie die Atmos-Wiedergabe im Player. Benötigt die URL der Testdatei.';
	@override String get atmosTestRawFile => 'Rohe EAC3-Datei';
	@override String get atmosTestRawFileDescription => 'Spielt die Testdatei mit bekannter Länge ab. Benötigt die URL der Testdatei.';
	@override String get atmosTestAsbarNative => 'Sample-Buffer-Renderer (nativ)';
	@override String get atmosTestAsbarNativeDescription => 'Übergibt die unveränderte komprimierte Audiospur direkt an den System-Renderer. Benötigt die URL der Testdatei.';
	@override String get atmosTestAsbarGenerated => 'Sample-Buffer-Renderer (neu erstellt)';
	@override String get atmosTestAsbarGeneratedDescription => 'Dasselbe, aber mit der Audiobeschreibung wie bei der Wiedergabe erstellt. Benötigt die URL der Testdatei.';
	@override String get atmosTestSessionMode => 'Filmwiedergabe-Modus verwenden';
	@override String get atmosTestSessionModeDescription => 'Aus verwendet den von Dolby dokumentierten Modus. Ein verwendet den bisherigen Modus.';
	@override String get atmosTestShowRoutePicker => 'AirPlay-Ausgabe wählen';
	@override String get atmosTestHideRoutePicker => 'AirPlay-Auswahl ausblenden';
	@override String get atmosTestRoutePickerDescription => 'Sendet den Test an einen AirPlay-Empfänger. Nur AirPlay meldet den ermittelten Audiomodus.';
	@override String get atmosTestStop => 'Test stoppen';
	@override String get atmosTestUrl => 'URL der Testdatei';
	@override String get atmosTestUrlDescription => 'HTTP-URL einer rohen .ec3-Dolby-Atmos-Datei (z. B. mit ffmpeg extrahiert)';
	@override String get atmosTestUrlMissing => 'Zuerst die URL der Testdatei festlegen';
	@override String get atmosTestStatus => 'Status';
	@override String get dvConversionMode => 'Dolby-Vision-Konvertierung';
	@override String get dvConversionModeDescription => 'Wähle, wie ExoPlayer Dateien mit Dolby-Vision-Profil 7 behandelt.';
	@override String get dvConversionAuto => 'Automatisch';
	@override String get dvConversionNative => 'Nativ / deaktiviert';
	@override String get dvConversionDv81 => 'P7 → P8.1';
	@override String get dvConversionHevcStrip => 'P7 → HEVC';
	@override String get dvConversionAutoDescription => 'Gerätefähigkeiten erkennen und normales Fallback-Verhalten verwenden';
	@override String get dvConversionNativeDescription => 'Natives DV7 erzwingen und einen erneuten DV-Konvertierungsversuch unterdrücken';
	@override String get dvConversionDv81Description => 'Inline-RPU-Konvertierung in Dolby-Vision-Profil 8.1 erzwingen';
	@override String get dvConversionHevcStripDescription => 'Dolby-Vision-RPU/EL-Schichten entfernen und reines HEVC ausgeben';
	@override String get requireProfileSelectionOnOpen => 'Profil beim Öffnen abfragen';
	@override String get requireProfileSelectionOnOpenDescription => 'Profilauswahl bei jedem Öffnen der App anzeigen';
	@override String get forceTvMode => 'TV-Modus erzwingen';
	@override String get forceTvModeDescription => 'TV-Layout erzwingen. Für Geräte ohne automatische Erkennung. Neustart erforderlich.';
	@override String get startInFullscreen => 'Im Vollbildmodus starten';
	@override String get startInFullscreenDescription => 'Plezy beim Start im Vollbildmodus öffnen';
	@override String get exitFullscreenOnPlayerClose => 'Vollbild beim Schließen des Players beenden';
	@override String get exitFullscreenOnPlayerCloseDescription => 'Vollbildmodus automatisch beenden, wenn der Videoplayer geschlossen wird';
	@override String get autoHidePerformanceOverlay => 'Leistungsoverlay automatisch ausblenden';
	@override String get autoHidePerformanceOverlayDescription => 'Leistungsoverlay mit den Wiedergabesteuerungen ein-/ausblenden';
	@override String get showNavBarLabels => 'Navigationsleisten-Beschriftungen anzeigen';
	@override String get showNavBarLabelsDescription => 'Textbeschriftungen unter den Symbolen der Navigationsleiste anzeigen';
	@override String get startupSection => 'Startbereich';
	@override String get display => 'Anzeige';
	@override String get homeScreen => 'Startseite';
	@override String get navigation => 'Navigation';
	@override String get window => 'Fenster';
	@override String get content => 'Inhalt';
	@override String get player => 'Wiedergabe';
	@override String get subtitlesAndConfig => 'Untertitel und Konfiguration';
	@override String get seekAndTiming => 'Spulen & Timing';
	@override String get behavior => 'Verhalten';
}

// Path: search
class _Translations$search$de extends Translations$search$en {
	_Translations$search$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Filme, Serien und Musik suchen …';
	@override String get tryDifferentTerm => 'Anderen Suchbegriff versuchen';
	@override String get searchYourMedia => 'In den eigenen Medien suchen';
	@override String get enterTitleActorOrKeyword => 'Titel, Schauspieler oder Stichwort eingeben';
}

// Path: hotkeys
class _Translations$hotkeys$de extends Translations$hotkeys$en {
	_Translations$hotkeys$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String setShortcutFor({required Object actionName}) => 'Tastenkürzel festlegen für ${actionName}';
	@override String get clearShortcut => 'Kürzel löschen';
	@override String get noShortcutSet => 'Kein Tastenkürzel festgelegt';
	@override String get currentShortcut => 'Aktuelle Tastenkombination:';
	@override String get pressToRecord => 'Auswählen, um eine Tastenkombination aufzuzeichnen';
	@override String get recordingShortcut => 'Jetzt die Tastenkombination drücken';
	@override late final _Translations$hotkeys$actions$de actions = _Translations$hotkeys$actions$de._(_root);
}

// Path: fileInfo
class _Translations$fileInfo$de extends Translations$fileInfo$en {
	_Translations$fileInfo$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dateiinformationen';
	@override String get video => 'Video';
	@override String get audio => 'Audio';
	@override String get subtitles => 'Untertitel';
	@override String get file => 'Datei';
	@override String get codec => 'Codec';
	@override String get resolution => 'Auflösung';
	@override String get bitrate => 'Bitrate';
	@override String get frameRate => 'Bildrate';
	@override String get aspectRatio => 'Seitenverhältnis';
	@override String get profile => 'Profil';
	@override String get bitDepth => 'Bittiefe';
	@override String get colorSpace => 'Farbraum';
	@override String get colorRange => 'Farbbereich';
	@override String get colorPrimaries => 'Primärfarben';
	@override String get chromaSubsampling => 'Chroma-Subsampling';
	@override String get channels => 'Kanäle';
	@override String get overallBitrate => 'Gesamtbitrate';
	@override String get path => 'Pfad';
	@override String get size => 'Größe';
	@override String get container => 'Container';
	@override String get duration => 'Dauer';
	@override String get optimizedForStreaming => 'Für Streaming optimiert';
	@override String get has64bitOffsets => '64-Bit-Offsets';
}

// Path: mediaMenu
class _Translations$mediaMenu$de extends Translations$mediaMenu$en {
	_Translations$mediaMenu$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get markAsWatched => 'Als gesehen markieren';
	@override String get markAsUnwatched => 'Als ungesehen markieren';
	@override String get removeFromContinueWatching => 'Aus ‚Weiterschauen‘ entfernen';
	@override String get viewDetails => 'Details anzeigen';
	@override String get goToSeries => 'Zur Serie';
	@override String get shufflePlay => 'Zufallswiedergabe';
	@override String get shuffleNotAvailableOffline => 'Zufallswiedergabe ist offline nicht verfügbar';
	@override String get fileInfo => 'Dateiinfo';
	@override String get deleteFromServer => 'Vom Server löschen';
	@override String get confirmDelete => 'Dieses Medium und seine Dateien von deinem Server löschen?';
	@override String get deleteMultipleWarning => 'Dies umfasst alle Episoden und deren Dateien.';
	@override String get mediaDeletedSuccessfully => 'Medienelement gelöscht';
	@override String get mediaFailedToDelete => 'Medienelement konnte nicht gelöscht werden';
	@override String get rate => 'Bewerten';
	@override String get playFromBeginning => 'Von Anfang an abspielen';
	@override String get playVersion => 'Version abspielen …';
}

// Path: rateSheet
class _Translations$rateSheet$de extends Translations$rateSheet$en {
	_Translations$rateSheet$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Bewerten';
	@override String get server => 'Server';
	@override String get favorite => 'Favorit';
	@override String get favorited => 'Favorisiert';
	@override String get saved => 'Gespeichert';
	@override String get notAvailable => 'Keine Übereinstimmung gefunden';
	@override String get noConnectedServices => 'Verbinde einen Dienst in den Einstellungen, um dort zu bewerten.';
}

// Path: accessibility
class _Translations$accessibility$de extends Translations$accessibility$en {
	_Translations$accessibility$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String mediaCardMovie({required Object title}) => '${title}, Film';
	@override String mediaCardShow({required Object title}) => '${title}, Serie';
	@override String mediaCardEpisode({required Object title, required Object episodeInfo}) => '${title}, ${episodeInfo}';
	@override String mediaCardSeason({required Object title, required Object seasonInfo}) => '${title}, ${seasonInfo}';
	@override String get mediaCardWatched => 'gesehen';
	@override String mediaCardPartiallyWatched({required Object percent}) => 'zu ${percent} Prozent gesehen';
	@override String get mediaCardUnwatched => 'ungesehen';
	@override String get tapToPlay => 'Zum Abspielen tippen';
	@override String get decrease => 'Verringern';
	@override String get increase => 'Erhöhen';
	@override String decreaseValue({required Object label}) => '${label} verringern';
	@override String increaseValue({required Object label}) => '${label} erhöhen';
	@override String get hue => 'Farbton';
	@override String get saturation => 'Sättigung';
	@override String get brightness => 'Helligkeit';
	@override String get hexColor => 'Hexadezimalfarbe';
	@override String get expandText => 'Text ausklappen';
	@override String get collapseText => 'Text einklappen';
	@override String get alphabetNavigation => 'Alphabetische Navigation';
	@override String get alphabetScrollHint => 'Nach oben oder unten wischen, um einen Buchstaben weiterzugehen';
	@override String rowColumnPosition({required Object row, required Object rowCount, required Object column, required Object columnCount}) => 'Zeile ${row} von ${rowCount}, Spalte ${column} von ${columnCount}';
	@override String rowPosition({required Object row, required Object rowCount}) => 'Zeile ${row} von ${rowCount}';
}

// Path: tooltips
class _Translations$tooltips$de extends Translations$tooltips$en {
	_Translations$tooltips$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get shufflePlay => 'Zufallswiedergabe';
	@override String get playTrailer => 'Trailer abspielen';
	@override String get markAsWatched => 'Als gesehen markieren';
	@override String get markAsUnwatched => 'Als ungesehen markieren';
}

// Path: audioTracks
class _Translations$audioTracks$de extends Translations$audioTracks$en {
	_Translations$audioTracks$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String track({required Object n}) => 'Audiospur ${n}';
}

// Path: videoControls
class _Translations$videoControls$de extends Translations$videoControls$en {
	_Translations$videoControls$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get audioLabel => 'Audio';
	@override String get subtitlesLabel => 'Untertitel';
	@override String get resetToZero => 'Auf 0 ms zurücksetzen';
	@override String addTime({required Object amount, required Object unit}) => '+${amount}${unit}';
	@override String minusTime({required Object amount, required Object unit}) => '-${amount}${unit}';
	@override String playsLater({required Object label}) => '${label} spielt später';
	@override String playsEarlier({required Object label}) => '${label} spielt früher';
	@override String get noOffset => 'Kein Offset';
	@override String get letterbox => 'Letterbox';
	@override String get fillScreen => 'Bild füllen';
	@override String get stretch => 'Strecken';
	@override String get lockRotation => 'Rotation sperren';
	@override String get unlockRotation => 'Rotation entsperren';
	@override String get timerActive => 'Schlaftimer aktiv';
	@override String playbackWillPauseIn({required Object duration}) => 'Wiedergabe wird in ${duration} pausiert';
	@override String get sleepTimerEndOfVideo => 'Ende des aktuellen Videos';
	@override String get sleepTimerStopAtHeader => 'Beenden bei';
	@override String get sleepTimerDurationHeader => 'Timer';
	@override String get playbackWillPauseAtEnd => 'Wiedergabe wird am Ende dieses Videos pausiert';
	@override String get stillWatching => 'Schaust du noch?';
	@override String pausingIn({required Object seconds}) => 'Pause in ${seconds}s';
	@override String get continueWatching => 'Weiter';
	@override String get autoPlayNext => 'Nächstes automatisch abspielen';
	@override String get playNext => 'Nächstes abspielen';
	@override String get playButton => 'Abspielen';
	@override String get pauseButton => 'Pause';
	@override String get showPlaybackControls => 'Wiedergabesteuerung anzeigen';
	@override String get hidePlaybackControls => 'Wiedergabesteuerung ausblenden';
	@override String seekBackwardButton({required Object seconds}) => '${seconds} Sekunden zurück';
	@override String seekForwardButton({required Object seconds}) => '${seconds} Sekunden vorwärts';
	@override String get previousButton => 'Vorherige Episode';
	@override String get nextButton => 'Nächste Episode';
	@override String get previousChapterButton => 'Vorheriges Kapitel';
	@override String get nextChapterButton => 'Nächstes Kapitel';
	@override String get muteButton => 'Stumm schalten';
	@override String get unmuteButton => 'Stummschaltung aufheben';
	@override String get settingsButton => 'Wiedergabeeinstellungen';
	@override String get tracksButton => 'Audio und Untertitel';
	@override String get chaptersButton => 'Kapitel';
	@override String get versionQualityButton => 'Version & Qualität';
	@override String get versionColumnHeader => 'Version';
	@override String get qualityColumnHeader => 'Qualität';
	@override String get qualityOriginal => 'Original';
	@override String qualityPresetLabel({required Object resolution, required Object bitrate}) => '${resolution}p ${bitrate} Mbps';
	@override String get transcodeUnavailableFallback => 'Transkodierung nicht verfügbar – Wiedergabe in Originalqualität';
	@override String get subtitleUnavailableFallback => 'Die ausgewählten Untertitel konnten nicht geladen werden – die Wiedergabe wird ohne Untertitel fortgesetzt';
	@override String get pipButton => 'Bild-in-Bild-Modus';
	@override String get aspectRatioButton => 'Seitenverhältnis';
	@override String get ambientLighting => 'Umgebungsbeleuchtung';
	@override String get fullscreenButton => 'Vollbild aktivieren';
	@override String get exitFullscreenButton => 'Vollbild verlassen';
	@override String get alwaysOnTopButton => 'Immer im Vordergrund';
	@override String get rotationLockButton => 'Drehsperre';
	@override String get lockScreen => 'Bildschirm sperren';
	@override String get screenLockButton => 'Bildschirmsperre';
	@override String get longPressToUnlock => 'Lange drücken zum Entsperren';
	@override String get timelineSlider => 'Videozeitleiste';
	@override String get volumeSlider => 'Lautstärkepegel';
	@override String endsAt({required Object time}) => 'Endet um ${time}';
	@override String get pipActive => 'Wiedergabe im Bild-in-Bild-Modus';
	@override String get pipFailed => 'Bild-in-Bild konnte nicht gestartet werden';
	@override String get screenshotSaved => 'Screenshot gespeichert';
	@override String zoomPercent({required Object percent}) => 'Zoom ${percent}%';
	@override late final _Translations$videoControls$pipErrors$de pipErrors = _Translations$videoControls$pipErrors$de._(_root);
	@override String get chapters => 'Kapitel';
	@override String get noChaptersAvailable => 'Keine Kapitel verfügbar';
	@override String get queue => 'Warteschlange';
	@override String get noQueueItems => 'Keine Elemente in der Warteschlange';
}

// Path: messages
class _Translations$messages$de extends Translations$messages$en {
	_Translations$messages$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get markedAsWatched => 'Als gesehen markiert';
	@override String get markedAsUnwatched => 'Als ungesehen markiert';
	@override String get markedAsWatchedOffline => 'Als gesehen markiert (wird synchronisiert, wenn online)';
	@override String get markedAsUnwatchedOffline => 'Als ungesehen markiert (wird synchronisiert, wenn online)';
	@override String autoRemovedWatchedDownload({required Object title}) => 'Automatisch entfernt: ${title}';
	@override String autoRemovedWatchedDownloads({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: 'Automatisch entfernt: ${n} angesehener Download',
		other: 'Automatisch entfernt: ${n} angesehene Downloads',
	);
	@override String get removedFromContinueWatching => 'Aus „Weiterschauen“ entfernt';
	@override String errorLoading({required Object error}) => 'Fehler: ${error}';
	@override String get streamInterrupted => 'Der Stream wurde unterbrochen. Drücke auf Wiedergabe oder spule, um es erneut zu versuchen.';
	@override String get fileInfoNotAvailable => 'Dateiinfo nicht verfügbar';
	@override String get playbackAuthenticationRequired => 'Melde dich erneut beim Medienserver an, um dieses Element abzuspielen.';
	@override String get playbackServerUnavailable => 'Der Medienserver ist nicht verfügbar. Versuche es später erneut.';
	@override String get playbackDataInvalid => 'Der Server hat ungültige Wiedergabeinformationen zurückgegeben.';
	@override String get playbackCancelled => 'Die Wiedergabe wurde abgebrochen.';
	@override String get playbackFailed => 'Die Wiedergabe konnte nicht gestartet werden.';
	@override String errorLoadingFileInfo({required Object error}) => 'Fehler beim Laden der Dateiinfo: ${error}';
	@override String get errorLoadingSeries => 'Fehler beim Laden der Serie';
	@override String get musicNotSupported => 'Musikwiedergabe wird noch nicht unterstützt';
	@override String get noDescriptionAvailable => 'Keine Beschreibung verfügbar';
	@override String get noProfilesAvailable => 'Keine Profile verfügbar';
	@override String get contactAdminForProfiles => 'Wende dich an deinen Serveradministrator, um Profile hinzuzufügen';
	@override String get unableToDetermineLibrarySection => 'Der Mediatheksbereich für dieses Element konnte nicht ermittelt werden';
	@override String get logsCleared => 'Protokolle gelöscht';
	@override String get logsCopied => 'Protokolle in Zwischenablage kopiert';
	@override String get noLogsAvailable => 'Keine Protokolle verfügbar';
	@override String metadataRefreshing({required Object title}) => 'Metadaten für „${title}“ werden aktualisiert …';
	@override String metadataRefreshStarted({required Object title}) => 'Metadaten-Aktualisierung gestartet für „${title}“';
	@override String metadataRefreshFailed({required Object error}) => 'Metadaten konnten nicht aktualisiert werden: ${error}';
	@override String get logoutConfirm => 'Abmeldung wirklich durchführen?';
	@override String get noSeasonsFound => 'Keine Staffeln gefunden';
	@override String get seasonsLoadFailed => 'Staffeln konnten nicht geladen werden';
	@override String get noEpisodesFound => 'Keine Episoden in der ersten Staffel gefunden';
	@override String get noEpisodesFoundGeneral => 'Keine Episoden gefunden';
	@override String get episodesLoadFailed => 'Episoden konnten nicht geladen werden';
	@override String get noResultsFound => 'Keine Ergebnisse gefunden';
	@override String sleepTimerSet({required Object label}) => 'Schlaftimer auf ${label} eingestellt';
	@override String get noItemsAvailable => 'Keine Elemente verfügbar';
	@override String get failedToCreatePlayQueueNoItems => 'Wiedergabewarteschlange konnte nicht erstellt werden – keine Elemente';
	@override String failedPlayback({required Object action, required Object error}) => 'Wiedergabe für ${action} fehlgeschlagen: ${error}';
	@override String get switchingToCompatiblePlayer => 'Wechsel zu einem kompatiblen Player …';
	@override String get serverLimitTitle => 'Wiedergabe fehlgeschlagen';
	@override String get serverLimitBody => 'Serverfehler (HTTP 500). Vermutlich hat ein Bandbreiten- oder Transkodierungslimit diese Sitzung abgelehnt. Bitte den Besitzer, das Limit anzupassen.';
	@override String get logsUploaded => 'Protokolle hochgeladen';
	@override String get logsUploadFailed => 'Protokolle konnten nicht hochgeladen werden';
	@override String get logId => 'Protokoll-ID';
}

// Path: subtitlingStyling
class _Translations$subtitlingStyling$de extends Translations$subtitlingStyling$en {
	_Translations$subtitlingStyling$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get text => 'Text';
	@override String get border => 'Rahmen';
	@override String get background => 'Hintergrund';
	@override String get fontSize => 'Schriftgröße';
	@override String get textColor => 'Textfarbe';
	@override String get borderSize => 'Rahmengröße';
	@override String get borderColor => 'Rahmenfarbe';
	@override String get backgroundOpacity => 'Hintergrunddeckkraft';
	@override String get backgroundColor => 'Hintergrundfarbe';
	@override String get position => 'Position';
	@override String get assOverride => 'ASS-Überschreibung';
	@override String get overrideScale => 'Skalieren';
	@override String get overrideForce => 'Erzwingen';
	@override String get overrideStrip => 'Formatierung entfernen';
	@override String get positionTop => 'Oben';
	@override String get positionBottom => 'Unten';
	@override String get bold => 'Fett';
	@override String get italic => 'Kursiv';
	@override String get renderResolution => 'Render-Auflösung';
	@override String get renderResolutionScreen => 'Bildschirmauflösung';
	@override String get renderResolutionVideo => 'Videoauflösung';
}

// Path: mpvConfig
class _Translations$mpvConfig$de extends Translations$mpvConfig$en {
	_Translations$mpvConfig$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'mpv-Konfiguration';
	@override String get description => 'Erweiterte Videoplayer-Einstellungen';
	@override String get presets => 'Voreinstellungen';
	@override String get noPresets => 'Keine gespeicherten Voreinstellungen';
	@override String get saveAsPreset => 'Als Voreinstellung speichern …';
	@override String get presetName => 'Name der Voreinstellung';
	@override String get presetNameHint => 'Namen für diese Voreinstellung eingeben';
	@override String get loadPreset => 'Laden';
	@override String get deletePreset => 'Löschen';
	@override String get presetSaved => 'Voreinstellung gespeichert';
	@override String get presetLoaded => 'Voreinstellung geladen';
	@override String get presetDeleted => 'Voreinstellung gelöscht';
	@override String get confirmDeletePreset => 'Diese Voreinstellung wirklich löschen?';
	@override String get configPlaceholder => 'gpu-api=vulkan\nhwdec=auto\n# comment';
}

// Path: dialog
class _Translations$dialog$de extends Translations$dialog$en {
	_Translations$dialog$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get confirmAction => 'Aktion bestätigen';
}

// Path: profiles
class _Translations$profiles$de extends Translations$profiles$en {
	_Translations$profiles$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addPlezyProfile => 'Plezy-Profil hinzufügen';
	@override String get switchingProfile => 'Profil wird gewechselt…';
	@override String get deleteThisProfileTitle => 'Dieses Profil löschen?';
	@override String deleteThisProfileMessage({required Object displayName}) => '${displayName} entfernen. Verbindungen bleiben unberührt.';
	@override String get active => 'Aktiv';
	@override String get manage => 'Verwalten';
	@override String get delete => 'Löschen';
	@override String get signOut => 'Abmelden';
	@override String get signOutPlexTitle => 'Von Plex abmelden?';
	@override String signOutPlexMessage({required Object displayName}) => '${displayName} und alle Plex Home-Benutzer entfernen? Du kannst dich jederzeit wieder anmelden.';
	@override String get signedOutPlex => 'Von Plex abgemeldet.';
	@override String get signOutFailed => 'Abmeldung fehlgeschlagen.';
	@override String get sectionTitle => 'Profile';
	@override String get summarySingle => 'Profile hinzufügen, um verwaltete Benutzer mit lokalen Identitäten zu kombinieren';
	@override String summaryMultipleWithActive({required Object count, required Object activeName}) => '${count} Profile · aktiv: ${activeName}';
	@override String summaryMultiple({required Object count}) => '${count} Profile';
	@override String get removeConnectionTitle => 'Verbindung entfernen?';
	@override String removeConnectionMessage({required Object displayName, required Object connectionLabel}) => 'Zugriff von ${displayName} auf ${connectionLabel} entfernen. Andere Profile behalten ihn.';
	@override String get deleteProfileTitle => 'Profil löschen?';
	@override String deleteProfileMessage({required Object displayName}) => '${displayName} und Verbindungen entfernen. Server bleiben verfügbar.';
	@override String get profileNameLabel => 'Profilname';
	@override String get pinProtectionLabel => 'PIN-Schutz';
	@override String get setPin => 'PIN festlegen';
	@override String get setPinTitle => 'PIN festlegen';
	@override String get confirmPinTitle => 'PIN bestätigen';
	@override String get pinSet => 'PIN festgelegt';
	@override String get changePin => 'Ändern';
	@override String get removePin => 'Entfernen';
	@override String get connectionsLabel => 'Verbindungen';
	@override String get add => 'Hinzufügen';
	@override String get deleteProfileButton => 'Profil löschen';
	@override String get noConnectionsHint => 'Keine Verbindungen — füge eine hinzu, um dieses Profil zu nutzen.';
	@override String get noConnections => 'Keine Verbindungen';
	@override String get connectionDefault => 'Standard';
	@override String connectionAs({required Object displayName}) => 'als ${displayName}';
	@override String get makeDefault => 'Als Standard festlegen';
	@override String get removeConnection => 'Entfernen';
	@override String get profileRenamed => 'Profil umbenannt.';
	@override String borrowAddTo({required Object displayName}) => 'Zu ${displayName} hinzufügen';
	@override String get borrowExplain => 'Verbindung eines anderen Profils übernehmen. PIN-geschützte Profile erfordern eine PIN.';
	@override String get borrowEmpty => 'Keine Verbindungen zum Übernehmen verfügbar.';
	@override String get borrowEmptySubtitle => 'Verbinde zuerst Plex oder Jellyfin mit einem anderen Profil.';
	@override String get borrowLoadFailed => 'Verfügbare Verbindungen konnten nicht geladen werden. Versuche es erneut.';
	@override String borrowFromProfile({required Object displayName}) => 'Von ${displayName}';
	@override String get borrowConnectionBorrowed => 'Verbindung übernommen.';
	@override String get borrowFailed => 'Verbindung konnte nicht übernommen werden.';
	@override String get incorrectPin => 'Falsche PIN.';
	@override String get incorrectPinTryAgain => 'Falsche PIN. Bitte erneut versuchen.';
	@override String get newProfile => 'Neues Profil';
	@override String get profileNameHint => 'z. B. Gäste, Kinder, Wohnzimmer';
	@override String get pinProtectionOptional => 'PIN-Schutz (optional)';
	@override String get pinExplain => '4-stellige PIN zum Profilwechsel erforderlich.';
	@override String get continueButton => 'Weiter';
	@override String get pinsDontMatch => 'PINs stimmen nicht überein';
}

// Path: connections
class _Translations$connections$de extends Translations$connections$en {
	_Translations$connections$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get sectionTitle => 'Verbindungen';
	@override String get addConnection => 'Verbindung hinzufügen';
	@override String get addConnectionSubtitleNoProfile => 'Mit Plex anmelden oder mit einem Jellyfin-Server verbinden';
	@override String addConnectionSubtitleScoped({required Object displayName}) => 'Zu ${displayName} hinzufügen: Plex, Jellyfin oder eine andere Profilverbindung';
	@override String sessionExpiredOne({required Object name}) => 'Sitzung für ${name} abgelaufen';
	@override String sessionExpiredMany({required Object count}) => 'Sitzungen für ${count} Server abgelaufen';
	@override String get signInAgain => 'Erneut anmelden';
	@override String get editJellyfinTitle => 'Jellyfin-Verbindung bearbeiten';
	@override String editJellyfinIntro({required Object serverName}) => 'Füge URLs für ${serverName} hinzu oder entferne sie. Plezy verwendet die erreichbare URL mit der geringsten Latenz.';
}

// Path: discover
class _Translations$discover$de extends Translations$discover$en {
	_Translations$discover$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Entdecken';
	@override String get noContentAvailable => 'Kein Inhalt verfügbar';
	@override String get addMediaToLibraries => 'Medien zur Mediathek hinzufügen';
	@override String get continueWatching => 'Weiterschauen';
	@override String continueWatchingIn({required Object library}) => 'Weiterschauen in ${library}';
	@override String get nextUp => 'Als Nächstes';
	@override String nextUpIn({required Object library}) => 'Als Nächstes in ${library}';
	@override String get recentlyAdded => 'Kürzlich hinzugefügt';
	@override String recentlyAddedIn({required Object library}) => 'Kürzlich hinzugefügt in ${library}';
	@override String latestAlbumsIn({required Object library}) => 'Neueste Alben in ${library}';
	@override String recentlyPlayedIn({required Object library}) => 'Kürzlich gespielt in ${library}';
	@override String mostPlayedIn({required Object library}) => 'Am häufigsten gespielt in ${library}';
	@override String playEpisode({required Object season, required Object episode}) => 'S${season}E${episode}';
	@override String get cast => 'Besetzung';
	@override String get extras => 'Trailer & Extras';
	@override String get studio => 'Studio';
	@override String get director => 'Regisseur';
	@override String get directors => 'Regisseure';
	@override String get movie => 'Film';
	@override String get tvShow => 'Serie';
	@override String minutesLeft({required Object minutes}) => 'Noch ${minutes} Min.';
	@override String get moreLikeThis => 'Ähnliche Inhalte';
}

// Path: errors
class _Translations$errors$de extends Translations$errors$en {
	_Translations$errors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String searchFailed({required Object error}) => 'Suche fehlgeschlagen: ${error}';
	@override String connectionTimeout({required Object context}) => 'Zeitüberschreitung beim Laden von ${context}';
	@override String get connectionFailed => 'Keine Verbindung zum Medienserver möglich';
	@override String unableToLoad({required Object context}) => '${context} konnte nicht geladen werden. Bitte erneut versuchen.';
	@override String get noClientAvailable => 'Kein Client verfügbar';
	@override String failedToSwitchProfile({required Object displayName}) => 'Profilwechsel zu ${displayName} fehlgeschlagen';
	@override String failedToDeleteProfile({required Object displayName}) => 'Löschen von ${displayName} fehlgeschlagen';
	@override String get failedToRate => 'Bewertung konnte nicht aktualisiert werden';
}

// Path: libraries
class _Translations$libraries$de extends Translations$libraries$en {
	_Translations$libraries$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mediatheken';
	@override String get fallbackTitle => 'Mediathek';
	@override String get refreshMetadata => 'Metadaten aktualisieren';
	@override String get noLibrariesFound => 'Keine Mediatheken gefunden';
	@override String get allLibrariesHidden => 'Alle Mediatheken sind ausgeblendet';
	@override String hiddenLibrariesCount({required Object count}) => 'Ausgeblendete Mediatheken (${count})';
	@override String get thisLibraryIsEmpty => 'Diese Mediathek ist leer';
	@override String get noItemsMatchFilters => 'Keine Elemente entsprechen den aktiven Filtern';
	@override String get resetFilters => 'Filter zurücksetzen';
	@override String get all => 'Alle';
	@override String get clearAll => 'Alle Filter entfernen';
	@override String refreshMetadataConfirm({required Object title}) => 'Metadaten für „${title}“ wirklich aktualisieren?';
	@override String get manageLibraries => 'Mediatheken verwalten';
	@override String get sort => 'Sortieren';
	@override String get sortBy => 'Sortieren nach';
	@override String get filters => 'Filter';
	@override String get confirmActionMessage => 'Aktion wirklich durchführen?';
	@override String get showLibrary => 'Mediathek anzeigen';
	@override String get hideLibrary => 'Mediathek ausblenden';
	@override String get libraryOptions => 'Mediatheksoptionen';
	@override String get content => 'Mediatheksinhalt';
	@override String get selectLibrary => 'Mediathek auswählen';
	@override String filtersWithCount({required Object count}) => 'Filter (${count})';
	@override String get noRecommendations => 'Keine Empfehlungen verfügbar';
	@override String get noCollections => 'Keine Sammlungen in dieser Mediathek';
	@override String get noFoldersFound => 'Keine Ordner gefunden';
	@override String get folders => 'Ordner';
	@override late final _Translations$libraries$tabs$de tabs = _Translations$libraries$tabs$de._(_root);
	@override late final _Translations$libraries$groupings$de groupings = _Translations$libraries$groupings$de._(_root);
	@override late final _Translations$libraries$filterCategories$de filterCategories = _Translations$libraries$filterCategories$de._(_root);
	@override late final _Translations$libraries$sortLabels$de sortLabels = _Translations$libraries$sortLabels$de._(_root);
}

// Path: about
class _Translations$about$de extends Translations$about$en {
	_Translations$about$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Über';
	@override String get openSourceLicenses => 'Open-Source-Lizenzen';
	@override String versionLabel({required Object version}) => 'Version ${version}';
	@override String get appDescription => 'Ein schöner, mit Flutter entwickelter Plex- und Jellyfin-Client';
	@override String get viewLicensesDescription => 'Lizenzen von Drittanbieter-Bibliotheken anzeigen';
}

// Path: hubDetail
class _Translations$hubDetail$de extends Translations$hubDetail$en {
	_Translations$hubDetail$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Titel';
	@override String get releaseYear => 'Erscheinungsjahr';
	@override String get dateAdded => 'Hinzugefügt am';
	@override String get rating => 'Bewertung';
	@override String get noItemsFound => 'Keine Elemente gefunden';
}

// Path: logs
class _Translations$logs$de extends Translations$logs$en {
	_Translations$logs$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get clearLogs => 'Protokolle löschen';
	@override String get copyLogs => 'Protokolle kopieren';
	@override String get uploadLogs => 'Protokolle hochladen';
}

// Path: licenses
class _Translations$licenses$de extends Translations$licenses$en {
	_Translations$licenses$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get relatedPackages => 'Verwandte Pakete';
	@override String get license => 'Lizenz';
	@override String licenseNumber({required Object number}) => 'Lizenz ${number}';
	@override String licensesCount({required Object count}) => '${count} Lizenzen';
}

// Path: navigation
class _Translations$navigation$de extends Translations$navigation$en {
	_Translations$navigation$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get libraries => 'Mediatheken';
	@override String get downloads => 'Downloads';
	@override String get explore => 'Erkunden';
}

// Path: explore
class _Translations$explore$de extends Translations$explore$en {
	_Translations$explore$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Erkunden';
	@override String get selectSource => 'Quelle auswählen';
	@override late final _Translations$explore$rows$de rows = _Translations$explore$rows$de._(_root);
	@override late final _Translations$explore$status$de status = _Translations$explore$status$de._(_root);
	@override String episodeCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Folge',
		other: '${n} Folgen',
	);
	@override String get cast => 'Besetzung';
	@override String get characters => 'Charaktere';
	@override String get addToWatchlist => 'Zur Merkliste hinzufügen';
	@override String get removeFromWatchlist => 'Von Merkliste entfernen';
	@override String get watchlistUpdateFailed => 'Merkliste konnte nicht aktualisiert werden';
	@override String get notInLibrary => 'Nicht in deiner Mediathek';
	@override String get inTheseLibraries => 'In diesen Mediatheken';
	@override String get checkingLibrary => 'Deine Mediathek wird überprüft …';
	@override String get emptyTitle => 'Hier ist noch nichts';
	@override String emptyMessage({required Object source}) => 'Zeilen aus ${source} erscheinen hier, sobald sie Inhalte enthalten.';
	@override String searchHint({required Object source}) => '${source} durchsuchen';
	@override String searchEmpty({required Object query}) => 'Keine Ergebnisse für „${query}“';
	@override String searchPrompt({required Object source}) => 'Suche nach Filmen und Serien auf ${source}.';
	@override String get searchFailed => 'Suche fehlgeschlagen. Prüfe deine Verbindung und versuche es erneut.';
}

// Path: collections
class _Translations$collections$de extends Translations$collections$en {
	_Translations$collections$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sammlungen';
	@override String get collection => 'Sammlung';
	@override String get empty => 'Sammlung ist leer';
	@override String get deleteCollection => 'Sammlung löschen';
	@override String deleteConfirm({required Object title}) => '„${title}“ löschen? Dies kann nicht rückgängig gemacht werden.';
	@override String get deleted => 'Sammlung gelöscht';
	@override String get deleteFailed => 'Sammlung konnte nicht gelöscht werden';
	@override String deleteFailedWithError({required Object error}) => 'Sammlung konnte nicht gelöscht werden: ${error}';
	@override String get selectCollection => 'Sammlung auswählen';
	@override String get collectionName => 'Sammlungsname';
	@override String get enterCollectionName => 'Sammlungsnamen eingeben';
	@override String get addedToCollection => 'Zur Sammlung hinzugefügt';
	@override String get errorAddingToCollection => 'Fehler beim Hinzufügen zur Sammlung';
	@override String get created => 'Sammlung erstellt';
	@override String get removeFromCollection => 'Aus Sammlung entfernen';
	@override String removeFromCollectionConfirm({required Object title}) => '„${title}“ aus dieser Sammlung entfernen?';
	@override String get removedFromCollection => 'Aus Sammlung entfernt';
	@override String get removeFromCollectionFailed => 'Entfernen aus Sammlung fehlgeschlagen';
	@override String removeFromCollectionError({required Object error}) => 'Fehler beim Entfernen aus der Sammlung: ${error}';
	@override String get searchCollections => 'Sammlungen durchsuchen...';
}

// Path: playlists
class _Translations$playlists$de extends Translations$playlists$en {
	_Translations$playlists$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wiedergabelisten';
	@override String get playlist => 'Wiedergabeliste';
	@override String get noPlaylists => 'Keine Wiedergabelisten gefunden';
	@override String get create => 'Wiedergabeliste erstellen';
	@override String get playlistName => 'Name der Wiedergabeliste';
	@override String get enterPlaylistName => 'Name der Wiedergabeliste eingeben';
	@override String get delete => 'Wiedergabeliste löschen';
	@override String get removeItem => 'Aus Wiedergabeliste entfernen';
	@override String get smartPlaylist => 'Intelligente Wiedergabeliste';
	@override String itemCount({required Object count}) => '${count} Elemente';
	@override String get oneItem => '1 Element';
	@override String get emptyPlaylist => 'Diese Wiedergabeliste ist leer';
	@override String get deleteConfirm => 'Wiedergabeliste löschen?';
	@override String deleteMessage({required Object name}) => '„${name}“ wirklich löschen?';
	@override String get created => 'Wiedergabeliste erstellt';
	@override String get deleted => 'Wiedergabeliste gelöscht';
	@override String get itemAdded => 'Zur Wiedergabeliste hinzugefügt';
	@override String get itemRemoved => 'Aus Wiedergabeliste entfernt';
	@override String get selectPlaylist => 'Wiedergabeliste auswählen';
	@override String get searchPlaylists => 'Wiedergabelisten durchsuchen...';
	@override String get errorCreating => 'Wiedergabeliste konnte nicht erstellt werden';
	@override String get errorDeleting => 'Wiedergabeliste konnte nicht gelöscht werden';
	@override String get errorLoading => 'Wiedergabelisten konnten nicht geladen werden';
	@override String get errorAdding => 'Konnte nicht zur Wiedergabeliste hinzugefügt werden';
	@override String get errorReordering => 'Element der Wiedergabeliste konnte nicht neu geordnet werden';
	@override String get errorRemoving => 'Konnte nicht aus der Wiedergabeliste entfernt werden';
}

// Path: music
class _Translations$music$de extends Translations$music$en {
	_Translations$music$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get goToAlbum => 'Zum Album';
	@override String get goToArtist => 'Zum Interpreten';
	@override String get instantMix => 'Instant-Mix';
	@override String get playNext => 'Als Nächstes abspielen';
	@override String get addToQueue => 'Zur Warteschlange hinzufügen';
	@override String discNumber({required Object n}) => 'Disc ${n}';
	@override String trackCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n,
		one: '${n} Titel',
		other: '${n} Titel',
	);
	@override String get nowPlaying => 'Wird wiedergegeben';
	@override String playingFrom({required Object title}) => 'Wiedergabe von ${title}';
	@override String get queue => 'Warteschlange';
	@override String get clearQueue => 'Warteschlange leeren';
	@override String get lyrics => 'Songtext';
	@override String get noLyrics => 'Kein Songtext verfügbar';
	@override String get sleepTimer => 'Schlaftimer';
	@override String get sleepTimerEndOfTrack => 'Ende des Titels';
	@override String sleepTimerMinutes({required Object n}) => '${n} Minuten';
	@override String get stopPlayback => 'Wiedergabe stoppen';
	@override String get previousTrack => 'Vorheriger Titel';
	@override String get nextTrack => 'Nächster Titel';
	@override String get repeat => 'Wiederholen';
	@override String get repeatAll => 'Alle wiederholen';
	@override String get repeatOne => 'Titel wiederholen';
}

// Path: downloads
class _Translations$downloads$de extends Translations$downloads$en {
	_Translations$downloads$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Downloads';
	@override String get manage => 'Verwalten';
	@override String get tvShows => 'Serien';
	@override String get movies => 'Filme';
	@override String get music => 'Musik';
	@override String tracksQueued({required Object count}) => '${count} Titel zum Download in Warteschlange';
	@override String get noDownloads => 'Noch keine Downloads';
	@override String get noDownloadsDescription => 'Heruntergeladene Inhalte werden hier für die Offline-Wiedergabe angezeigt';
	@override String get downloadNow => 'Herunterladen';
	@override String get deleteDownload => 'Download löschen';
	@override String get retryDownload => 'Download wiederholen';
	@override String get downloadQueued => 'Download in Warteschlange';
	@override String get downloadResumed => 'Download fortgesetzt';
	@override String get serverErrorBitrate => 'Serverfehler: Datei überschreitet möglicherweise das Remote-Bitrate-Limit';
	@override String get storageFull => 'Die Downloads wurden angehalten, weil der Gerätespeicher voll ist. Gib Speicherplatz frei und versuche es erneut.';
	@override String episodesQueued({required Object count}) => '${count} Episoden zum Download hinzugefügt';
	@override String get downloadDeleted => 'Download gelöscht';
	@override String deleteConfirm({required Object title}) => '"${title}" von diesem Gerät löschen?';
	@override String get cancelledDownloadTitle => 'Abgebrochener Download';
	@override String get cancelledDownloadMessage => 'Dieser Download wurde abgebrochen. Was möchtest du tun?';
	@override String get allEpisodesAlreadyDownloaded => 'Alle Episoden sind bereits heruntergeladen';
	@override String get resumeDownload => 'Download fortsetzen';
	@override String get cancelledDownload => 'Abgebrochener Download';
	@override String syncingFile({required Object file, required Object status}) => '${file} (${status} wird synchronisiert)';
	@override String downloadedFileClickToComplete({required Object file}) => '${file} heruntergeladen — zum Abschließen klicken';
	@override String get partialDownloadClickToComplete => 'Teilweise heruntergeladen — zum Abschließen klicken';
	@override String get deleting => 'Wird gelöscht …';
	@override String deletingWithProgress({required Object title, required Object current, required Object total}) => '${title} wird gelöscht … (${current} von ${total})';
	@override String get queuedTooltip => 'In Warteschlange';
	@override String queuedFilesTooltip({required Object files}) => 'In Warteschlange: ${files}';
	@override String get downloadingTooltip => 'Wird heruntergeladen …';
	@override String downloadingFilesTooltip({required Object files}) => '${files} werden heruntergeladen';
	@override String get noDownloadsTree => 'Keine Downloads';
	@override String get pauseAll => 'Alle pausieren';
	@override String get resumeAll => 'Alle fortsetzen';
	@override String get deleteAll => 'Alle löschen';
	@override String get selectVersion => 'Version auswählen';
	@override String get allEpisodes => 'Alle Episoden';
	@override String get unwatchedOnly => 'Nur ungesehene';
	@override String nextNUnwatched({required Object count}) => 'Nächste ${count} ungesehene';
	@override String get customAmount => 'Eigene Anzahl...';
	@override String get includeSpecials => 'Sonderfolgen einschließen';
	@override String get howManyEpisodes => 'Wie viele Episoden?';
	@override String get invalidEpisodeCount => 'Gib eine gültige Episodenanzahl ein.';
	@override String get keepSynced => 'Synchronisiert halten';
	@override String get downloadOnce => 'Einmal herunterladen';
	@override String keepNUnwatched({required Object count}) => '${count} ungesehene behalten';
	@override String get editSyncRule => 'Synchronisierungsregel bearbeiten';
	@override String get removeSyncRule => 'Synchronisierungsregel entfernen';
	@override String removeSyncRuleConfirm({required Object title}) => 'Synchronisierung von „${title}“ beenden? Heruntergeladene Episoden werden behalten.';
	@override String syncRuleCreated({required Object count}) => 'Synchronisierungsregel erstellt – ${count} ungesehene Episoden werden behalten';
	@override String get syncRuleUpdated => 'Synchronisierungsregel aktualisiert';
	@override String get syncRuleRemoved => 'Synchronisierungsregel entfernt';
	@override String syncedNewEpisodes({required Object count, required Object title}) => '${count} neue Episoden für ${title} synchronisiert';
	@override String get activeSyncRules => 'Synchronisierungsregeln';
	@override String get noSyncRules => 'Keine Synchronisierungsregeln';
	@override String get manageSyncRule => 'Synchronisierung verwalten';
	@override String get editEpisodeCount => 'Episodenanzahl';
	@override String get editSyncFilter => 'Synchronisierungsfilter';
	@override String get syncAllItems => 'Alle Elemente synchronisieren';
	@override String get syncUnwatchedItems => 'Ungesehene Elemente synchronisieren';
	@override String syncRuleServerContext({required Object server, required Object status}) => 'Server: ${server} • ${status}';
	@override String get syncRuleAvailable => 'Verfügbar';
	@override String get syncRuleOffline => 'Offline';
	@override String get syncRuleSignInRequired => 'Anmeldung erforderlich';
	@override String get syncRuleNotAvailableForProfile => 'Für das aktuelle Profil nicht verfügbar';
	@override String get syncRuleUnknownServer => 'Unbekannter Server';
	@override String get syncRuleListCreated => 'Synchronisierungsregel erstellt';
	@override late final _Translations$downloads$backgroundWarning$de backgroundWarning = _Translations$downloads$backgroundWarning$de._(_root);
}

// Path: shaders
class _Translations$shaders$de extends Translations$shaders$en {
	_Translations$shaders$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Shader';
	@override String get noShaderDescription => 'Keine Videoverbesserung';
	@override String get nvscalerDescription => 'NVIDIA-Bildskalierung für schärferes Video';
	@override String get artcnnVariantNeutral => 'Neutral';
	@override String get artcnnVariantDenoise => 'Rauschreduzierung';
	@override String get artcnnVariantDenoiseSharpen => 'Rauschreduzierung + Schärfen';
	@override String get qualityFast => 'Schnell';
	@override String get qualityHQ => 'Hohe Qualität';
	@override String get mode => 'Modus';
	@override String get importShader => 'Shader importieren';
	@override String get customShaderDescription => 'Benutzerdefinierter GLSL-Shader';
	@override String get shaderImported => 'Shader importiert';
	@override String get shaderImportFailed => 'Shader konnte nicht importiert werden';
	@override String get deleteShader => 'Shader löschen';
	@override String deleteShaderConfirm({required Object name}) => '"${name}" löschen?';
}

// Path: videoSettings
class _Translations$videoSettings$de extends Translations$videoSettings$en {
	_Translations$videoSettings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get playbackSpeed => 'Wiedergabegeschwindigkeit';
	@override String get normalSpeed => 'Normal';
	@override String sleepTimerActive({required Object duration}) => 'Aktiv (${duration})';
	@override String get zoom => 'Zoom';
	@override String get sleepTimer => 'Schlaftimer';
	@override String get audioSync => 'Audio-Synchronisation';
	@override String get subtitleSync => 'Untertitel-Synchronisation';
	@override String get hdr => 'HDR';
	@override String get audioOutput => 'Audioausgabe';
	@override String get performanceOverlay => 'Leistungsanzeige';
	@override String get audioPassthrough => 'Audio-Durchleitung';
	@override String get audioOutputDolbyAtmos => 'Dolby Atmos';
	@override String get audioOutputDolbyAudio => 'Dolby Audio';
	@override String get audioOutputSurround => 'Surround';
	@override String get audioOutputSpatial => 'Räumliches Audio';
	@override String get audioOutputStereo => 'Stereo';
	@override String get audioNormalization => 'Lautstärke normalisieren';
	@override String get audioDownmix => 'Downmix auf Stereo';
}

// Path: performanceOverlay
class _Translations$performanceOverlay$de extends Translations$performanceOverlay$en {
	_Translations$performanceOverlay$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get color => 'Farbe';
	@override String get performance => 'Leistung';
	@override String get buffer => 'Puffer';
	@override String get app => 'App';
	@override String get decoder => 'Decoder';
	@override String get rawDecoder => 'Raw-Decoder';
	@override String get tunneling => 'Tunneling';
	@override String get aspect => 'Seitenverhältnis';
	@override String get rotation => 'Drehung';
	@override String get dvSource => 'DV-Quelle';
	@override String get dvPath => 'DV-Pfad';
	@override String get p7Conversion => 'P7-Konv.';
	@override String get sampleRate => 'Abtastrate';
	@override String get pixelFormat => 'Pixelformat';
	@override String get hwFormat => 'HW-Format';
	@override String get matrix => 'Matrix';
	@override String get primaries => 'Primärfarben';
	@override String get transfer => 'Transfer';
	@override String get renderFps => 'Render-FPS';
	@override String get displayFps => 'Display-FPS';
	@override String get avSync => 'A/V-Sync';
	@override String get dropped => 'Verworfen';
	@override String get dvRpus => 'DV-RPUs';
	@override String get dvRpuAverage => 'DV-RPU Ø';
	@override String get dvSampleAverage => 'DV-Sample Ø';
	@override String get maxLuma => 'Max. Luma';
	@override String get minLuma => 'Min. Luma';
	@override String get maxCll => 'MaxCLL';
	@override String get maxFall => 'MaxFALL';
	@override String get cacheUsed => 'Cache genutzt';
	@override String get cacheLimit => 'Cache-Limit';
	@override String get speed => 'Geschwindigkeit';
	@override String get player => 'Player';
	@override String get memory => 'Speicher';
	@override String get uiFps => 'UI-FPS';
}

// Path: externalPlayer
class _Translations$externalPlayer$de extends Translations$externalPlayer$en {
	_Translations$externalPlayer$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Externer Player';
	@override String get useExternalPlayer => 'Externen Player verwenden';
	@override String get useExternalPlayerDescription => 'Videos in einer anderen App öffnen';
	@override String get selectPlayer => 'Player auswählen';
	@override String get customPlayers => 'Benutzerdefinierte Player';
	@override String get systemDefault => 'Systemstandard';
	@override String get addCustomPlayer => 'Benutzerdefinierten Player hinzufügen';
	@override String get playerName => 'Playername';
	@override String get playerNameHint => 'Mein Player';
	@override String get playerCommand => 'Befehl';
	@override String get playerPackage => 'Paketname';
	@override String get playerUrlScheme => 'URL-Schema';
	@override String get off => 'Aus';
	@override String get launchFailed => 'Externer Player konnte nicht geöffnet werden';
	@override String appNotInstalled({required Object name}) => '${name} ist nicht installiert';
	@override String get playInExternalPlayer => 'In externem Player abspielen';
}

// Path: metadataEdit
class _Translations$metadataEdit$de extends Translations$metadataEdit$en {
	_Translations$metadataEdit$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get editMetadata => 'Bearbeiten...';
	@override String get screenTitle => 'Metadaten bearbeiten';
	@override String get basicInfo => 'Grundinformationen';
	@override String get artwork => 'Grafiken';
	@override String get title => 'Titel';
	@override String get sortTitle => 'Sortiertitel';
	@override String get originalTitle => 'Originaltitel';
	@override String get releaseDate => 'Erscheinungsdatum';
	@override String get contentRating => 'Altersfreigabe';
	@override String get studio => 'Studio';
	@override String get tagline => 'Slogan';
	@override String get summary => 'Zusammenfassung';
	@override String get poster => 'Poster';
	@override String get background => 'Hintergrund';
	@override String get logo => 'Logo';
	@override String get squareArt => 'Quadratisches Bild';
	@override String get selectPoster => 'Poster auswählen';
	@override String get selectBackground => 'Hintergrund auswählen';
	@override String get selectLogo => 'Logo auswählen';
	@override String get selectSquareArt => 'Quadratisches Bild auswählen';
	@override String get fromUrl => 'Über URL';
	@override String get uploadFile => 'Datei hochladen';
	@override String get enterImageUrl => 'Bild-URL eingeben';
	@override String get imageUrl => 'Bild-URL';
	@override String get metadataUpdated => 'Metadaten aktualisiert';
	@override String get metadataUpdateFailed => 'Metadaten konnten nicht aktualisiert werden';
	@override String get artworkUpdated => 'Grafiken aktualisiert';
	@override String get artworkUpdateFailed => 'Grafiken konnten nicht aktualisiert werden';
	@override String get noArtworkAvailable => 'Keine Grafiken verfügbar';
	@override String artworkOption({required Object index}) => 'Grafikoption ${index}';
	@override String selectedArtworkOption({required Object index}) => 'Grafikoption ${index}, ausgewählt';
	@override String get notSet => 'Nicht festgelegt';
	@override String get tags => 'Tags';
	@override String get addTag => 'Tag hinzufügen';
	@override String get genre => 'Genre';
	@override String get director => 'Regisseur';
	@override String get writer => 'Autor';
	@override String get producer => 'Produzent';
	@override String get country => 'Land';
	@override String get label => 'Label';
}

// Path: trakt
class _Translations$trakt$de extends Translations$trakt$en {
	_Translations$trakt$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Trakt';
	@override String get connected => 'Verbunden';
	@override String connectedAs({required Object username}) => 'Verbunden als @${username}';
	@override String get disconnectConfirm => 'Trakt-Konto trennen?';
	@override String get disconnectConfirmBody => 'Plezy sendet keine Ereignisse mehr an Trakt. Du kannst jederzeit erneut verbinden.';
	@override String get scrobble => 'Echtzeit-Scrobbling';
	@override String get scrobbleDescription => 'Sende Play-, Pause- und Stopp-Ereignisse während der Wiedergabe an Trakt.';
	@override String get watchedSync => 'Gesehen-Status synchronisieren';
	@override String get watchedSyncDescription => 'Wenn du Inhalte in Plezy als gesehen markierst, werden sie auch auf Trakt markiert.';
}

// Path: seerr
class _Translations$seerr$de extends Translations$seerr$en {
	_Translations$seerr$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seerr';
	@override String get connectTitle => 'Seerr verbinden';
	@override String get serverUrl => 'Server-URL';
	@override String get serverUrlHelper => 'Die Adresse deiner Seerr-Instanz';
	@override String get checkServer => 'Weiter';
	@override String get signInWithJellyfin => 'Mit Jellyfin anmelden';
	@override String get signInWithEmby => 'Mit Emby anmelden';
	@override String get signInWithLocal => 'Lokales Konto verwenden';
	@override String get email => 'E-Mail';
	@override String get noSignInMethods => 'Diese Seerr-Instanz bietet keine von Plezy unterstützte Anmeldemethode.';
	@override String get instance => 'Instanz';
	@override String get disconnectConfirm => 'Seerr trennen?';
	@override String get disconnectConfirmBody => 'Plezy vergisst diese Seerr-Instanz. Jederzeit erneut verbinden.';
	@override String get request => 'Anfragen';
	@override String get request4k => 'In 4K anfragen';
	@override String get seasons => 'Staffeln';
	@override String get allSeasons => 'Alle Staffeln';
	@override String get advancedOptions => 'Erweitert';
	@override String get destinationServer => 'Zielserver';
	@override String get qualityProfile => 'Qualitätsprofil';
	@override String get rootFolder => 'Stammordner';
	@override String get languageProfile => 'Sprachprofil';
	@override String get requestSubmitted => 'Anfrage gesendet';
	@override String requestFailed({required Object error}) => 'Anfrage fehlgeschlagen: ${error}';
	@override String get requestsLoadFailed => 'Anfrageoptionen konnten nicht geladen werden';
	@override String get nothingToRequest => 'Alles ist bereits verfügbar oder angefragt.';
	@override String get statusAvailable => 'Verfügbar';
	@override String get statusPartiallyAvailable => 'Teilweise verfügbar';
	@override String get statusRequested => 'Angefragt';
	@override String get statusProcessing => 'Wird verarbeitet';
}

// Path: services
class _Translations$services$de extends Translations$services$en {
	_Translations$services$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dienste';
	@override String get hubSubtitle => 'Wiedergabefortschritt synchronisieren und neue Titel anfragen.';
	@override String get notConnected => 'Nicht verbunden';
	@override String connectedAs({required Object username}) => 'Verbunden als @${username}';
	@override String get scrobble => 'Fortschritt automatisch verfolgen';
	@override String get scrobbleDescription => 'Aktualisiere deine Liste, wenn du eine Folge oder einen Film beendest.';
	@override String disconnectConfirm({required Object service}) => '${service} trennen?';
	@override String disconnectConfirmBody({required Object service}) => 'Plezy aktualisiert ${service} nicht mehr. Jederzeit erneut verbinden.';
	@override String connectFailed({required Object service}) => 'Verbindung zu ${service} fehlgeschlagen. Versuche es erneut.';
	@override late final _Translations$services$names$de names = _Translations$services$names$de._(_root);
	@override late final _Translations$services$deviceCode$de deviceCode = _Translations$services$deviceCode$de._(_root);
	@override late final _Translations$services$oauthProxy$de oauthProxy = _Translations$services$oauthProxy$de._(_root);
	@override late final _Translations$services$libraryFilter$de libraryFilter = _Translations$services$libraryFilter$de._(_root);
}

// Path: addServer
class _Translations$addServer$de extends Translations$addServer$en {
	_Translations$addServer$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get addJellyfinTitle => 'Jellyfin-Server hinzufügen';
	@override String get serverUrls => 'Server-URLs';
	@override String get serverUrlsHelper => 'Mehrere URLs möglich, durch Kommas getrennt.';
	@override String get findServer => 'Server finden';
	@override String get searchingLocalServers => 'Suche nach lokalen Jellyfin-Servern …';
	@override String get localServers => 'Lokale Jellyfin-Server';
	@override String get username => 'Benutzername';
	@override String get password => 'Passwort';
	@override String get signIn => 'Anmelden';
	@override String get change => 'Ändern';
	@override String get required => 'Erforderlich';
	@override String couldNotReachServer({required Object error}) => 'Server nicht erreichbar: ${error}';
	@override String signInFailed({required Object error}) => 'Anmeldung fehlgeschlagen: ${error}';
	@override String quickConnectFailed({required Object error}) => 'Quick Connect fehlgeschlagen: ${error}';
	@override String get enterJellyfinUrlError => 'Gib die URL deines Jellyfin-Servers ein';
	@override String get addConnectionTitle => 'Verbindung hinzufügen';
	@override String addConnectionTitleScoped({required Object name}) => 'Zu ${name} hinzufügen';
	@override String get connectToJellyfinCard => 'Mit Jellyfin verbinden';
	@override String get connectToJellyfinCardSubtitle => 'Gib Server-URL, Benutzername und Passwort ein.';
	@override String connectToJellyfinCardSubtitleScoped({required Object name}) => 'Bei einem Jellyfin-Server anmelden. Wird mit ${name} verknüpft.';
	@override String get borrowFromAnotherProfile => 'Von einem anderen Profil ausleihen';
	@override String get borrowFromAnotherProfileSubtitle => 'Verbindung eines anderen Profils wiederverwenden. PIN-geschützte Profile erfordern eine PIN.';
}

// Path: hotkeys.actions
class _Translations$hotkeys$actions$de extends Translations$hotkeys$actions$en {
	_Translations$hotkeys$actions$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get playPause => 'Wiedergabe/Pause';
	@override String get volumeUp => 'Lauter';
	@override String get volumeDown => 'Leiser';
	@override String seekForward({required Object seconds}) => 'Vorspulen (${seconds}s)';
	@override String seekBackward({required Object seconds}) => 'Zurückspulen (${seconds}s)';
	@override String get fullscreenToggle => 'Vollbild umschalten';
	@override String get muteToggle => 'Stumm umschalten';
	@override String get subtitleToggle => 'Untertitel umschalten';
	@override String get audioTrackNext => 'Nächste Audiospur';
	@override String get subtitleTrackNext => 'Nächste Untertitelspur';
	@override String get chapterNext => 'Nächstes Kapitel';
	@override String get chapterPrevious => 'Vorheriges Kapitel';
	@override String get episodeNext => 'Nächste Episode';
	@override String get episodePrevious => 'Vorherige Episode';
	@override String get speedIncrease => 'Geschwindigkeit erhöhen';
	@override String get speedDecrease => 'Geschwindigkeit verringern';
	@override String get speedReset => 'Geschwindigkeit zurücksetzen';
	@override String get zoomIn => 'Vergrößern';
	@override String get zoomOut => 'Verkleinern';
	@override String get zoomReset => 'Zoom zurücksetzen';
	@override String get subSeekNext => 'Zum nächsten Untertitel springen';
	@override String get subSeekPrev => 'Zum vorherigen Untertitel springen';
	@override String get shaderToggle => 'Shader umschalten';
	@override String get skipMarker => 'Intro/Abspann überspringen';
	@override String get screenshot => 'Screenshot aufnehmen';
}

// Path: videoControls.pipErrors
class _Translations$videoControls$pipErrors$de extends Translations$videoControls$pipErrors$en {
	_Translations$videoControls$pipErrors$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get androidVersion => 'Erfordert Android 8.0 oder neuer';
	@override String get iosVersion => 'Erfordert iOS 15.0 oder neuer';
	@override String get permissionDisabled => 'Bild-in-Bild ist deaktiviert. Aktiviere es in den Systemeinstellungen.';
	@override String get notSupported => 'Dieses Gerät unterstützt den Bild-in-Bild-Modus nicht';
	@override String get voSwitchFailed => 'Videoausgabe für Bild-in-Bild konnte nicht umgeschaltet werden';
	@override String get failed => 'Bild-in-Bild konnte nicht gestartet werden';
	@override String unknown({required Object error}) => 'Ein Fehler ist aufgetreten: ${error}';
}

// Path: libraries.tabs
class _Translations$libraries$tabs$de extends Translations$libraries$tabs$en {
	_Translations$libraries$tabs$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get recommended => 'Empfohlen';
	@override String get browse => 'Durchsuchen';
	@override String get collections => 'Sammlungen';
	@override String get playlists => 'Wiedergabelisten';
}

// Path: libraries.groupings
class _Translations$libraries$groupings$de extends Translations$libraries$groupings$en {
	_Translations$libraries$groupings$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Gruppierung';
	@override String get all => 'Alle';
	@override String get movies => 'Filme';
	@override String get shows => 'Serien';
	@override String get seasons => 'Staffeln';
	@override String get episodes => 'Episoden';
	@override String get artists => 'Interpreten';
	@override String get albums => 'Alben';
	@override String get tracks => 'Titel';
	@override String get folders => 'Ordner';
}

// Path: libraries.filterCategories
class _Translations$libraries$filterCategories$de extends Translations$libraries$filterCategories$en {
	_Translations$libraries$filterCategories$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get genre => 'Genre';
	@override String get year => 'Jahr';
	@override String get contentRating => 'Altersfreigabe';
	@override String get tag => 'Tag';
	@override String get unwatched => 'Ungesehene';
	@override String get unplayed => 'Nicht abgespielt';
	@override String get favorites => 'Favoriten';
}

// Path: libraries.sortLabels
class _Translations$libraries$sortLabels$de extends Translations$libraries$sortLabels$en {
	_Translations$libraries$sortLabels$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Titel';
	@override String get dateAdded => 'Hinzugefügt am';
	@override String get communityRating => 'Communitybewertung';
	@override String get criticRating => 'Kritikerbewertung';
	@override String get datePlayed => 'Wiedergabedatum';
	@override String get playCount => 'Wiedergaben';
	@override String get productionYear => 'Produktionsjahr';
	@override String get runtime => 'Laufzeit';
	@override String get officialRating => 'Offizielle Bewertung';
	@override String get premiereDate => 'Premierendatum';
	@override String get startDate => 'Startdatum';
	@override String get airTime => 'Sendezeit';
	@override String get studio => 'Studio';
	@override String get random => 'Zufällig';
	@override String get lastEpisodeDateAdded => 'Hinzugefügt am (neueste Folge)';
}

// Path: explore.rows
class _Translations$explore$rows$de extends Translations$explore$rows$en {
	_Translations$explore$rows$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get watchlist => 'Merkliste';
	@override String get recommendedMovies => 'Empfohlene Filme';
	@override String get recommendedShows => 'Empfohlene Serien';
	@override String get trendingMovies => 'Angesagte Filme';
	@override String get trendingShows => 'Angesagte Serien';
	@override String get popularMovies => 'Beliebte Filme';
	@override String get popularShows => 'Beliebte Serien';
	@override String get trendingAnime => 'Angesagte Anime';
	@override String get suggestedAnime => 'Empfohlene Anime';
	@override String get airingAnime => 'Beste derzeit laufende Anime';
	@override String get popularAnime => 'Beliebteste Anime';
	@override String get trending => 'Angesagt';
	@override String get upcomingMovies => 'Kommende Filme';
	@override String get upcomingShows => 'Kommende Serien';
}

// Path: explore.status
class _Translations$explore$status$de extends Translations$explore$status$en {
	_Translations$explore$status$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get airing => 'Laufend';
	@override String get ended => 'Beendet';
	@override String get canceled => 'Abgesetzt';
	@override String get upcoming => 'Demnächst';
}

// Path: downloads.backgroundWarning
class _Translations$downloads$backgroundWarning$de extends Translations$downloads$backgroundWarning$en {
	_Translations$downloads$backgroundWarning$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get bannerBlocked => 'Downloads werden gestoppt, wenn du die App verlässt';
	@override String get bannerDegraded => 'Downloads im Hintergrund sind möglicherweise eingeschränkt';
	@override String get bannerAction => 'Details';
	@override String get sheetTitle => 'Downloads im Hintergrund sind blockiert';
	@override String get sheetTitleDegraded => 'Downloads im Hintergrund sind möglicherweise eingeschränkt';
	@override String get sheetIntro => 'Android verhindert, dass Plezy zuverlässig im Hintergrund herunterlädt.';
	@override String get sheetIntroDegraded => 'Dein Gerät schränkt ein, wann Plezy im Hintergrund herunterladen kann.';
	@override String get reasonBackgroundRestricted => 'Die Hintergrundnutzung von Plezy ist eingeschränkt. Stelle die Akku- oder Hintergrundnutzung auf „Uneingeschränkt“.';
	@override String get reasonStandbyRestricted => 'Android hat Plezy in einen eingeschränkten Standby-Modus versetzt. Stelle die Akkunutzung auf „Uneingeschränkt“.';
	@override String get reasonDownloadChannelBlocked => 'Download-Benachrichtigungen sind deaktiviert. Fortschritt und Steuerelemente sind daher möglicherweise nicht verfügbar.';
	@override String get reasonNotificationsDisabled => 'Benachrichtigungen sind deaktiviert. Ab Android 13 sind sie für lange Downloads im Hintergrund erforderlich.';
	@override String get reasonDataSaver => 'Der Datensparmodus ist aktiviert und blockiert Downloads im Hintergrund über mobile Daten. Über Wi-Fi sollten Downloads weiterhin funktionieren.';
	@override String get reasonOemUnknown => 'Downloads wurden wiederholt gestoppt, während Plezy im Hintergrund war. Prüfe die Einstellungen zur Akku- oder Hintergrundnutzung von Plezy.';
	@override String get openSettings => 'Einstellungen öffnen';
	@override String get stillNotWorking => 'Gerätespezifische Hilfe';
	@override String get stillNotWorkingDescription => 'Sieh dir die Schritte für dein Gerät an oder sende bei anhaltendem Problem ein Protokoll über Einstellungen › Protokolle anzeigen.';
	@override String get dialogTitle => 'Downloads werden möglicherweise nicht abgeschlossen';
	@override String get dialogDownloadAnyway => 'Trotzdem herunterladen';
	@override String get dialogFixFirst => 'Zuerst beheben';
	@override String get statusTile => 'Downloads im Hintergrund';
	@override String get statusOk => 'Ausführung im Hintergrund erlaubt';
	@override String get statusBlocked => 'Durch Systemeinstellungen blockiert';
	@override String get statusDegraded => 'Durch Systemeinstellungen eingeschränkt';
	@override String get statusUnknown => 'Noch nicht geprüft';
	@override String get settingsUnavailable => 'Die Systemeinstellungen konnten auf diesem Gerät nicht geöffnet werden';
	@override String get linkUnavailable => 'dontkillmyapp.com konnte auf diesem Gerät nicht geöffnet werden';
}

// Path: services.names
class _Translations$services$names$de extends Translations$services$names$en {
	_Translations$services$names$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get mal => 'MyAnimeList';
	@override String get anilist => 'AniList';
	@override String get simkl => 'Simkl';
	@override String get seerr => 'Seerr';
}

// Path: services.deviceCode
class _Translations$services$deviceCode$de extends Translations$services$deviceCode$en {
	_Translations$services$deviceCode$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object service}) => 'Plezy auf ${service} aktivieren';
	@override String body({required Object url}) => 'Gehe zu ${url} und gib diesen Code ein:';
	@override String openToActivate({required Object service}) => '${service} zum Aktivieren öffnen';
	@override String get copyCode => 'Aktivierungscode kopieren';
	@override String get waitingForAuthorization => 'Warte auf Autorisierung…';
	@override String get codeCopied => 'Code kopiert';
}

// Path: services.oauthProxy
class _Translations$services$oauthProxy$de extends Translations$services$oauthProxy$en {
	_Translations$services$oauthProxy$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String title({required Object service}) => 'Bei ${service} anmelden';
	@override String get body => 'Scanne diesen QR-Code oder öffne die URL auf einem beliebigen Gerät.';
	@override String openToSignIn({required Object service}) => '${service} zum Anmelden öffnen';
	@override String get copyUrl => 'Anmelde-URL kopieren';
	@override String get urlCopied => 'URL kopiert';
}

// Path: services.libraryFilter
class _Translations$services$libraryFilter$de extends Translations$services$libraryFilter$en {
	_Translations$services$libraryFilter$de._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Mediatheksfilter';
	@override String get subtitleAllSyncing => 'Alle Mediatheken werden synchronisiert';
	@override String get subtitleNoneSyncing => 'Nichts wird synchronisiert';
	@override String subtitleBlocked({required Object count}) => '${count} ausgeschlossen';
	@override String subtitleAllowed({required Object count}) => '${count} zugelassen';
	@override String get mode => 'Filtermodus';
	@override String get modeBlacklist => 'Ausschlussliste';
	@override String get modeWhitelist => 'Zulassungsliste';
	@override String get modeHintBlacklist => 'Alle Mediatheken außer den unten markierten synchronisieren.';
	@override String get modeHintWhitelist => 'Nur die unten markierten Mediatheken synchronisieren.';
	@override String get libraries => 'Mediatheken';
	@override String get noLibraries => 'Keine Mediatheken verfügbar';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Plezy',
			'auth.connectToJellyfin' => 'Mit Jellyfin verbinden',
			'auth.useQuickConnect' => 'Quick Connect verwenden',
			'auth.quickConnectInstructions' => 'Öffne Quick Connect in Jellyfin und gib diesen Code ein.',
			'auth.quickConnectWaiting' => 'Warte auf Bestätigung…',
			'auth.quickConnectCancel' => 'Abbrechen',
			'auth.quickConnectExpired' => 'Quick Connect ist abgelaufen. Versuche es erneut.',
			'auth.localDataRecoveryRequired' => 'Plezy konnte lokale Anmeldedaten und ausstehende Wiedergabedaten nicht sicher wiederherstellen. Bitte melde dich erneut an.',
			'common.cancel' => 'Abbrechen',
			'common.save' => 'Speichern',
			'common.close' => 'Schließen',
			'common.clear' => 'Leeren',
			'common.reset' => 'Zurücksetzen',
			'common.later' => 'Später',
			'common.submit' => 'Senden',
			'common.confirm' => 'Bestätigen',
			'common.retry' => 'Erneut versuchen',
			'common.logout' => 'Abmelden',
			'common.unknown' => 'Unbekannt',
			'common.refresh' => 'Aktualisieren',
			'common.yes' => 'Ja',
			'common.no' => 'Nein',
			'common.delete' => 'Löschen',
			'common.edit' => 'Bearbeiten',
			'common.shuffle' => 'Zufallswiedergabe',
			'common.addTo' => 'Hinzufügen zu …',
			'common.createNew' => 'Neu erstellen',
			'common.disconnect' => 'Trennen',
			'common.play' => 'Abspielen',
			'common.pause' => 'Pause',
			'common.resume' => 'Fortsetzen',
			'common.error' => 'Fehler',
			'common.search' => 'Suche',
			'common.home' => 'Start',
			'common.back' => 'Zurück',
			'common.settings' => 'Einstellungen',
			'common.ok' => 'OK',
			'common.off' => 'Aus',
			'common.seasonNumber' => ({required Object number}) => 'Staffel ${number}',
			'common.episodeNumberTitle' => ({required Object number, required Object title}) => 'Folge ${number} – ${title}',
			'common.chapterNumber' => ({required Object number}) => 'Kapitel ${number}',
			'common.reconnect' => 'Erneut verbinden',
			'common.viewAll' => 'Alle anzeigen',
			'common.checkingNetwork' => 'Netzwerk wird geprüft...',
			'common.loadingServers' => 'Server werden geladen...',
			'common.connectingToServers' => 'Verbindung zu Servern wird hergestellt …',
			'common.startingOfflineMode' => 'Offlinemodus wird gestartet...',
			'common.loading' => 'Wird geladen …',
			'common.fullscreen' => 'Vollbild',
			'common.exitFullscreen' => 'Vollbild verlassen',
			'common.pressBackAgainToExit' => 'Zum Beenden erneut Zurück drücken',
			'common.next' => 'Weiter',
			'screens.licenses' => 'Lizenzen',
			'screens.switchProfile' => 'Profil wechseln',
			'screens.subtitleStyling' => 'Untertitel-Stil',
			'screens.mpvConfig' => 'mpv.conf',
			'screens.logs' => 'Protokolle',
			'update.available' => 'Update verfügbar',
			'update.versionAvailable' => ({required Object version}) => 'Version ${version} ist verfügbar',
			'update.currentVersion' => ({required Object version}) => 'Aktuell: ${version}',
			'update.skipVersion' => 'Diese Version überspringen',
			'update.viewRelease' => 'Versionshinweise anzeigen',
			'update.latestVersion' => 'Aktuellste Version installiert',
			'update.checkFailed' => 'Fehler bei der Updateprüfung',
			'settings.title' => 'Einstellungen',
			'settings.supportDeveloper' => 'Plezy unterstützen',
			'settings.supportDeveloperDescription' => 'Per Liberapay spenden, um die Entwicklung zu fördern',
			'settings.language' => 'Sprache',
			'settings.theme' => 'Design',
			'settings.appearance' => 'Darstellung',
			'settings.videoPlayback' => 'Videowiedergabe',
			'settings.videoPlaybackDescription' => 'Wiedergabeverhalten konfigurieren',
			'settings.advanced' => 'Erweitert',
			'settings.episodePosterMode' => 'Episodenposter-Stil',
			'settings.seriesPoster' => 'Serienposter',
			'settings.seasonPoster' => 'Staffelposter',
			'settings.episodeThumbnail' => 'Vorschaubild',
			'settings.showHeroSectionDescription' => 'Bereich mit empfohlenen Inhalten auf der Startseite anzeigen',
			'settings.secondsLabel' => 'Sekunden',
			'settings.minutesLabel' => 'Minuten',
			'settings.secondsShort' => 's',
			'settings.minutesShort' => 'm',
			'settings.durationHint' => ({required Object min, required Object max}) => 'Dauer eingeben (${min}-${max})',
			'settings.systemTheme' => 'System',
			'settings.lightTheme' => 'Hell',
			'settings.darkTheme' => 'Dunkel',
			'settings.oledTheme' => 'OLED',
			'settings.libraryDensity' => 'Darstellungsdichte der Mediathek',
			'settings.compact' => 'Kompakt',
			'settings.comfortable' => 'Großzügig',
			'settings.tvCornerSpotlightBackdrop' => 'Backdrop in der Ecke',
			'settings.tvCornerSpotlightBackdropDescription' => 'Zeigt das Spotlight-Artwork oben rechts statt bildschirmfüllend',
			'settings.viewMode' => 'Ansichtsmodus',
			'settings.gridView' => 'Raster',
			'settings.listView' => 'Liste',
			'settings.showHeroSection' => 'Empfehlungsbereich anzeigen',
			'settings.continueWatchingAction' => 'Aktion für Weiterschauen',
			'settings.continueWatchingPlay' => 'Abspielen',
			'settings.continueWatchingDetails' => 'Details öffnen',
			'settings.episodeAction' => 'Episodenaktion',
			'settings.episodePlay' => 'Abspielen',
			'settings.episodeDetails' => 'Details öffnen',
			'settings.useGlobalHubs' => 'Startlayout verwenden',
			'settings.useGlobalHubsDescription' => 'Einheitliche Start-Hubs anzeigen. Sonst Bibliotheksempfehlungen verwenden.',
			'settings.showServerNameOnHubs' => 'Servername bei Hubs anzeigen',
			'settings.showServerNameOnHubsDescription' => 'Servernamen immer in Hub-Titeln anzeigen.',
			'settings.groupLibrariesByServer' => 'Mediatheken nach Server gruppieren',
			'settings.groupLibrariesByServerDescription' => 'Sidebar-Bibliotheken nach Medienserver gruppieren.',
			'settings.alwaysKeepSidebarOpen' => 'Seitenleiste immer geöffnet halten',
			'settings.alwaysKeepSidebarOpenDescription' => 'Seitenleiste bleibt erweitert und Inhaltsbereich passt sich an',
			'settings.showUnwatchedCount' => 'Anzahl nicht gesehener Folgen anzeigen',
			'settings.showUnwatchedCountDescription' => 'Zeigt die Anzahl nicht gesehener Episoden bei Serien und Staffeln an',
			'settings.showEpisodeNumberOnCards' => 'Episodennummer auf Karten anzeigen',
			'settings.showEpisodeNumberOnCardsDescription' => 'Staffel- und Episodennummer auf Episodenkarten anzeigen',
			'settings.showSeasonPostersOnTabs' => 'Staffelposter auf Tabs anzeigen',
			'settings.showSeasonPostersOnTabsDescription' => 'Poster jeder Staffel über ihrem Tab anzeigen',
			'settings.tvFullCardLayout' => 'Vollflächige TV-Karten',
			'settings.tvFullCardLayoutDescription' => 'TV-Karten nur mit Bild verwenden und Darstellernamen einblenden',
			'settings.focusGlow' => 'Fokusleuchten',
			'settings.focusGlowDescription' => 'Sanftes Leuchten um die fokussierte Karte anzeigen',
			'settings.visualEffects' => 'Visuelle Effekte',
			'settings.visualEffectsAuto' => 'Automatisch',
			'settings.visualEffectsAutoDescription' => 'Effekte auf leistungsschwachen Geräten automatisch reduzieren',
			'settings.visualEffectsFull' => 'Vollständig',
			'settings.visualEffectsReduced' => 'Reduziert',
			'settings.visualEffectsReducedDescription' => 'Weniger Animationen und Grafiken mit niedrigerer Auflösung',
			'settings.hideSpoilers' => 'Spoiler für nicht gesehene Episoden verbergen',
			'settings.hideSpoilersDescription' => 'Vorschaubilder und Beschreibungen ungesehener Episoden verwischen',
			'settings.playerBackend' => 'Wiedergabe-Engine',
			'settings.exoPlayer' => 'ExoPlayer',
			'settings.mpv' => 'mpv',
			'settings.hardwareDecoding' => 'Hardwaredekodierung',
			'settings.hardwareDecodingDescription' => 'Hardwarebeschleunigung verwenden, sofern verfügbar',
			'settings.bufferSize' => 'Puffergröße',
			'settings.bufferSizeMB' => ({required Object size}) => '${size} MB',
			'settings.bufferSizeAuto' => 'Automatisch (empfohlen)',
			'settings.bufferSizeWarning' => ({required Object heap, required Object size}) => '${heap} MB Speicher verfügbar. Ein Puffer von ${size} MB kann die Wiedergabe beeinträchtigen.',
			'settings.defaultQualityTitle' => 'Standardqualität',
			'settings.musicQualityTitle' => 'Musikqualität',
			'settings.subtitleStyling' => 'Untertitel-Stil',
			'settings.subtitleStylingDescription' => 'Aussehen von Untertiteln anpassen',
			'settings.smallSkipDuration' => 'Kleines Sprungintervall',
			'settings.largeSkipDuration' => 'Großes Sprungintervall',
			'settings.rewindOnResume' => 'Zurückspulen bei Fortsetzung',
			'settings.secondsUnit' => ({required Object seconds}) => '${seconds} Sekunden',
			'settings.defaultSleepTimer' => 'Standard-Schlaftimer',
			'settings.minutesUnit' => ({required Object minutes}) => '${minutes} Minuten',
			'settings.rememberTrackSelections' => 'Spurauswahl pro Serie/Film merken',
			'settings.rememberTrackSelectionsDescription' => 'Audio- und Untertitelauswahl je Titel merken',
			'settings.followServerTrackSelections' => 'Serverseitige Spurauswahl pro Episode verwenden',
			'settings.followServerTrackSelectionsDescription' => 'Beim Episodenwechsel die auf dem Server ausgewählten Audio- und Untertitelspuren übernehmen, statt die aktuelle Auswahl zu übertragen',
			'settings.showChapterMarkersOnTimeline' => 'Kapitelmarkierungen auf der Suchleiste anzeigen',
			'settings.showChapterMarkersOnTimelineDescription' => 'Die Suchleiste an Kapitelgrenzen unterteilen',
			'settings.clickVideoTogglesPlayback' => 'Video zum Abspielen oder Pausieren anklicken',
			'settings.clickVideoTogglesPlaybackDescription' => 'Video zum Abspielen oder Pausieren anklicken, statt die Steuerung anzuzeigen.',
			'settings.videoPlayerControls' => 'Videoplayer-Steuerung',
			'settings.keyboardShortcuts' => 'Tastenkürzel',
			'settings.keyboardShortcutsDescription' => 'Tastenkürzel anpassen',
			'settings.videoPlayerNavigation' => 'Videoplayer-Navigation',
			'settings.videoPlayerNavigationDescription' => 'Mit den Pfeiltasten durch die Videoplayer-Steuerung navigieren',
			'settings.crashReporting' => 'Absturzberichte',
			'settings.crashReportingDescription' => 'Absturzberichte senden, um die App zu verbessern',
			'settings.debugLogging' => 'Debug-Protokollierung',
			'settings.debugLoggingDescription' => 'Detaillierte Protokolle zur Fehleranalyse aktivieren',
			'settings.viewLogs' => 'Protokolle anzeigen',
			'settings.viewLogsDescription' => 'App-Protokolle anzeigen',
			'settings.resetSettings' => 'Einstellungen zurücksetzen',
			'settings.resetSettingsDescription' => 'Standardeinstellungen wiederherstellen. Dies kann nicht rückgängig gemacht werden.',
			'settings.resetSettingsSuccess' => 'Einstellungen erfolgreich zurückgesetzt',
			'settings.backup' => 'Sicherung',
			'settings.exportSettings' => 'Einstellungen exportieren',
			'settings.exportSettingsDescription' => 'Einstellungen in einer Datei speichern',
			'settings.exportSettingsSuccess' => 'Einstellungen exportiert',
			'settings.importSettings' => 'Einstellungen importieren',
			'settings.importSettingsDescription' => 'Einstellungen aus einer Datei wiederherstellen',
			'settings.importSettingsConfirm' => 'Dies ersetzt deine aktuellen Einstellungen. Fortfahren?',
			'settings.importSettingsSuccess' => 'Einstellungen importiert',
			'settings.importSettingsInvalidFile' => 'Diese Datei ist kein gültiger Plezy-Einstellungsexport',
			'settings.importSettingsNoUser' => 'Vor dem Import bitte anmelden',
			'settings.shortcutsReset' => 'Tastenkürzel auf Standard zurückgesetzt',
			'settings.about' => 'Über',
			'settings.aboutDescription' => 'App-Informationen und Lizenzen',
			'settings.updates' => 'Updates',
			'settings.updateAvailable' => 'Update verfügbar',
			'settings.checkForUpdates' => 'Nach Updates suchen',
			'settings.autoCheckUpdatesOnStartup' => 'Beim Start automatisch nach Updates suchen',
			'settings.autoCheckUpdatesOnStartupDescription' => 'Beim Start benachrichtigen, wenn ein Update verfügbar ist',
			'settings.validationErrorEnterNumber' => 'Bitte eine gültige Zahl eingeben',
			'settings.validationErrorDuration' => ({required Object min, required Object max, required Object unit}) => 'Dauer muss zwischen ${min} und ${max} ${unit} liegen',
			'settings.shortcutAlreadyAssigned' => ({required Object action}) => 'Tastenkürzel bereits zugewiesen an ${action}',
			'settings.shortcutUpdated' => ({required Object action}) => 'Tastenkürzel aktualisiert für ${action}',
			'settings.saveFailed' => 'Änderungen konnten nicht gespeichert werden. Versuche es erneut.',
			'settings.autoSkip' => 'Automatisches Überspringen',
			'settings.autoSkipIntro' => 'Intro automatisch überspringen',
			'settings.autoSkipIntroDescription' => 'Intro-Marker nach wenigen Sekunden automatisch überspringen',
			'settings.autoSkipCredits' => 'Abspann automatisch überspringen',
			'settings.autoSkipCreditsDescription' => 'Abspann automatisch überspringen und nächste Episode abspielen',
			'settings.forceSkipMarkerFallback' => 'Ersatzmarkierungen erzwingen',
			'settings.forceSkipMarkerFallbackDescription' => 'Kapitel-Titelmuster auch dann verwenden, wenn Plex über Markierungen verfügt',
			'settings.autoSkipDelay' => 'Verzögerung für automatisches Überspringen',
			'settings.autoSkipDelayDescription' => ({required Object seconds}) => '${seconds} Sekunden vor dem automatischen Überspringen warten',
			'settings.introPattern' => 'Intro-Markierungsmuster',
			'settings.introPatternDescription' => 'Regulärer Ausdruck zum Erkennen von Intro-Markierungen in Kapiteltiteln',
			'settings.creditsPattern' => 'Abspann-Markierungsmuster',
			'settings.creditsPatternDescription' => 'Regulärer Ausdruck zum Erkennen von Abspann-Markierungen in Kapiteltiteln',
			'settings.invalidRegex' => 'Ungültiger regulärer Ausdruck',
			'settings.regex' => 'Regulärer Ausdruck',
			'settings.downloads' => 'Downloads',
			'settings.downloadLocationDescription' => 'Speicherort für heruntergeladene Inhalte wählen',
			'settings.downloadLocationDefault' => 'Standard (App-Speicher)',
			'settings.downloadLocationCustom' => 'Benutzerdefinierter Speicherort',
			'settings.selectFolder' => 'Ordner auswählen',
			'settings.resetToDefault' => 'Auf Standard zurücksetzen',
			'settings.currentPath' => ({required Object path}) => 'Aktuell: ${path}',
			'settings.downloadLocationChanged' => 'Download-Speicherort geändert',
			'settings.downloadLocationReset' => 'Download-Speicherort auf Standard zurückgesetzt',
			'settings.downloadLocationInvalid' => 'Ausgewählter Ordner ist nicht beschreibbar',
			'settings.downloadLocationPickerUnavailable' => 'Die Ordnerauswahl ist auf diesem Gerät nicht verfügbar',
			'settings.downloadOnWifiOnly' => 'Nur über WLAN herunterladen',
			'settings.downloadOnWifiOnlyDescription' => 'Downloads über mobile Daten verhindern',
			'settings.autoRemoveWatchedDownloads' => 'Gesehene Downloads automatisch entfernen',
			'settings.autoRemoveWatchedDownloadsDescription' => 'Angesehene Downloads automatisch löschen',
			'settings.cellularDownloadBlocked' => 'Downloads über das Mobilfunknetz sind blockiert. Nutze WLAN oder ändere die Einstellung.',
			'settings.maxVolume' => 'Maximale Lautstärke',
			'settings.maxVolumeDescription' => 'Lautstärkeanhebung über 100 % für leise Medien erlauben',
			'settings.maxVolumePercent' => ({required Object percent}) => '${percent} %',
			'settings.discordRichPresence' => 'Discord Rich Presence',
			'settings.discordRichPresenceDescription' => 'Auf Discord anzeigen, was du gerade schaust',
			'settings.services' => 'Dienste',
			'settings.servicesDescription' => 'Trakt, MyAnimeList, Seerr und mehr verbinden',
			'settings.manageLibrariesDescription' => 'Mediatheken neu anordnen und ausblenden',
			'settings.autoPip' => 'Automatisches Bild-in-Bild',
			'settings.autoPipDescription' => 'Beim Verlassen der App während der Wiedergabe automatisch Bild-in-Bild starten',
			'settings.matchContentFrameRate' => 'Inhalts-Bildrate anpassen',
			'settings.matchContentFrameRateDescription' => 'Bildwiederholrate des Displays an Videoinhalt anpassen',
			'settings.matchRefreshRate' => 'Bildwiederholrate anpassen',
			'settings.matchRefreshRateDescription' => 'Bildwiederholrate im Vollbild anpassen',
			'settings.matchDynamicRange' => 'Dynamikumfang anpassen',
			'settings.matchDynamicRangeDescription' => 'HDR für HDR-Inhalte einschalten, danach zurück zu SDR',
			'settings.displaySwitchDelay' => 'Verzögerung beim Displaywechsel',
			'settings.tunneledPlayback' => 'Tunnelwiedergabe',
			'settings.tunneledPlaybackDescription' => 'Video-Tunneling verwenden. Deaktivieren, wenn HDR-Wiedergabe schwarzes Video zeigt.',
			'settings.audioPassthrough' => 'Audio-Durchleitung',
			'settings.audioPassthroughDescription' => 'Dolby/DTS-Audio ohne Neukodierung an deinen Receiver oder Fernseher senden und Surround-Sound erhalten. Deaktivieren, wenn kein Ton zu hören ist.',
			'settings.audioPassthroughDescriptionAppleTv' => 'Apples nativen Dolby-Decoder für Dolby Digital Plus einschließlich Atmos verwenden. DTS und TrueHD werden weiterhin als Mehrkanal-PCM wiedergegeben. Deaktivieren, wenn kein Ton zu hören ist.',
			'settings.audioDownmix' => 'Auf Stereo heruntermischen',
			'settings.audioDownmixDescription' => 'Surround-Ton für Stereolautsprecher oder Kopfhörer auf zwei Kanäle heruntermischen',
			'settings.downmixCenterBoost' => 'Verstärkung des Center-Kanals',
			'settings.downmixCenterBoostValue' => ({required Object db}) => '${db} dB',
			'settings.downmixCenterBoostLabel' => 'Verstärkung (dB)',
			'settings.downmixCenterBoostShort' => 'dB',
			'settings.audioDownmixNormalize' => 'Lautstärke beim Downmix normalisieren',
			'settings.audioDownmixNormalizeDescription' => 'Senkt den Mix ab, um Übersteuerung zu vermeiden. Deaktivieren, um die Originallautstärke zu behalten (laute Szenen können verzerren).',
			'settings.atmosDiagnostics' => 'Atmos-Ausgabetest',
			'settings.atmosDiagnosticsDescription' => 'Dolby-Atmos-Ausgabe diagnostizieren, indem Testsignale über den Systemplayer abgespielt werden',
			'settings.atmosTestHlsAtmos' => 'Apple-Atmos-Stream',
			'settings.atmosTestHlsAtmosDescription' => 'Garantiert funktionierender Dolby-Atmos-Stream. Der Receiver sollte Dolby Atmos anzeigen.',
			'settings.atmosTestHlsControl' => 'Apple-Surround-Stream',
			'settings.atmosTestHlsControlDescription' => 'Kontrollstream ohne Atmos. Der Receiver sollte Surround ohne Atmos anzeigen.',
			'settings.atmosTestRawStream' => 'Roher EAC3-Stream',
			'settings.atmosTestRawStreamDescription' => 'Streamt die Testdatei genau wie die Atmos-Wiedergabe im Player. Benötigt die URL der Testdatei.',
			'settings.atmosTestRawFile' => 'Rohe EAC3-Datei',
			'settings.atmosTestRawFileDescription' => 'Spielt die Testdatei mit bekannter Länge ab. Benötigt die URL der Testdatei.',
			'settings.atmosTestAsbarNative' => 'Sample-Buffer-Renderer (nativ)',
			'settings.atmosTestAsbarNativeDescription' => 'Übergibt die unveränderte komprimierte Audiospur direkt an den System-Renderer. Benötigt die URL der Testdatei.',
			'settings.atmosTestAsbarGenerated' => 'Sample-Buffer-Renderer (neu erstellt)',
			'settings.atmosTestAsbarGeneratedDescription' => 'Dasselbe, aber mit der Audiobeschreibung wie bei der Wiedergabe erstellt. Benötigt die URL der Testdatei.',
			'settings.atmosTestSessionMode' => 'Filmwiedergabe-Modus verwenden',
			'settings.atmosTestSessionModeDescription' => 'Aus verwendet den von Dolby dokumentierten Modus. Ein verwendet den bisherigen Modus.',
			'settings.atmosTestShowRoutePicker' => 'AirPlay-Ausgabe wählen',
			'settings.atmosTestHideRoutePicker' => 'AirPlay-Auswahl ausblenden',
			'settings.atmosTestRoutePickerDescription' => 'Sendet den Test an einen AirPlay-Empfänger. Nur AirPlay meldet den ermittelten Audiomodus.',
			'settings.atmosTestStop' => 'Test stoppen',
			'settings.atmosTestUrl' => 'URL der Testdatei',
			'settings.atmosTestUrlDescription' => 'HTTP-URL einer rohen .ec3-Dolby-Atmos-Datei (z. B. mit ffmpeg extrahiert)',
			'settings.atmosTestUrlMissing' => 'Zuerst die URL der Testdatei festlegen',
			'settings.atmosTestStatus' => 'Status',
			'settings.dvConversionMode' => 'Dolby-Vision-Konvertierung',
			'settings.dvConversionModeDescription' => 'Wähle, wie ExoPlayer Dateien mit Dolby-Vision-Profil 7 behandelt.',
			'settings.dvConversionAuto' => 'Automatisch',
			'settings.dvConversionNative' => 'Nativ / deaktiviert',
			'settings.dvConversionDv81' => 'P7 → P8.1',
			'settings.dvConversionHevcStrip' => 'P7 → HEVC',
			'settings.dvConversionAutoDescription' => 'Gerätefähigkeiten erkennen und normales Fallback-Verhalten verwenden',
			'settings.dvConversionNativeDescription' => 'Natives DV7 erzwingen und einen erneuten DV-Konvertierungsversuch unterdrücken',
			'settings.dvConversionDv81Description' => 'Inline-RPU-Konvertierung in Dolby-Vision-Profil 8.1 erzwingen',
			'settings.dvConversionHevcStripDescription' => 'Dolby-Vision-RPU/EL-Schichten entfernen und reines HEVC ausgeben',
			'settings.requireProfileSelectionOnOpen' => 'Profil beim Öffnen abfragen',
			'settings.requireProfileSelectionOnOpenDescription' => 'Profilauswahl bei jedem Öffnen der App anzeigen',
			'settings.forceTvMode' => 'TV-Modus erzwingen',
			'settings.forceTvModeDescription' => 'TV-Layout erzwingen. Für Geräte ohne automatische Erkennung. Neustart erforderlich.',
			'settings.startInFullscreen' => 'Im Vollbildmodus starten',
			'settings.startInFullscreenDescription' => 'Plezy beim Start im Vollbildmodus öffnen',
			'settings.exitFullscreenOnPlayerClose' => 'Vollbild beim Schließen des Players beenden',
			'settings.exitFullscreenOnPlayerCloseDescription' => 'Vollbildmodus automatisch beenden, wenn der Videoplayer geschlossen wird',
			'settings.autoHidePerformanceOverlay' => 'Leistungsoverlay automatisch ausblenden',
			'settings.autoHidePerformanceOverlayDescription' => 'Leistungsoverlay mit den Wiedergabesteuerungen ein-/ausblenden',
			'settings.showNavBarLabels' => 'Navigationsleisten-Beschriftungen anzeigen',
			'settings.showNavBarLabelsDescription' => 'Textbeschriftungen unter den Symbolen der Navigationsleiste anzeigen',
			'settings.startupSection' => 'Startbereich',
			'settings.display' => 'Anzeige',
			'settings.homeScreen' => 'Startseite',
			'settings.navigation' => 'Navigation',
			'settings.window' => 'Fenster',
			'settings.content' => 'Inhalt',
			'settings.player' => 'Wiedergabe',
			'settings.subtitlesAndConfig' => 'Untertitel und Konfiguration',
			'settings.seekAndTiming' => 'Spulen & Timing',
			'settings.behavior' => 'Verhalten',
			'search.hint' => 'Filme, Serien und Musik suchen …',
			'search.tryDifferentTerm' => 'Anderen Suchbegriff versuchen',
			'search.searchYourMedia' => 'In den eigenen Medien suchen',
			'search.enterTitleActorOrKeyword' => 'Titel, Schauspieler oder Stichwort eingeben',
			'hotkeys.setShortcutFor' => ({required Object actionName}) => 'Tastenkürzel festlegen für ${actionName}',
			'hotkeys.clearShortcut' => 'Kürzel löschen',
			'hotkeys.noShortcutSet' => 'Kein Tastenkürzel festgelegt',
			'hotkeys.currentShortcut' => 'Aktuelle Tastenkombination:',
			'hotkeys.pressToRecord' => 'Auswählen, um eine Tastenkombination aufzuzeichnen',
			'hotkeys.recordingShortcut' => 'Jetzt die Tastenkombination drücken',
			'hotkeys.actions.playPause' => 'Wiedergabe/Pause',
			'hotkeys.actions.volumeUp' => 'Lauter',
			'hotkeys.actions.volumeDown' => 'Leiser',
			'hotkeys.actions.seekForward' => ({required Object seconds}) => 'Vorspulen (${seconds}s)',
			'hotkeys.actions.seekBackward' => ({required Object seconds}) => 'Zurückspulen (${seconds}s)',
			'hotkeys.actions.fullscreenToggle' => 'Vollbild umschalten',
			'hotkeys.actions.muteToggle' => 'Stumm umschalten',
			'hotkeys.actions.subtitleToggle' => 'Untertitel umschalten',
			'hotkeys.actions.audioTrackNext' => 'Nächste Audiospur',
			'hotkeys.actions.subtitleTrackNext' => 'Nächste Untertitelspur',
			'hotkeys.actions.chapterNext' => 'Nächstes Kapitel',
			'hotkeys.actions.chapterPrevious' => 'Vorheriges Kapitel',
			'hotkeys.actions.episodeNext' => 'Nächste Episode',
			'hotkeys.actions.episodePrevious' => 'Vorherige Episode',
			'hotkeys.actions.speedIncrease' => 'Geschwindigkeit erhöhen',
			'hotkeys.actions.speedDecrease' => 'Geschwindigkeit verringern',
			'hotkeys.actions.speedReset' => 'Geschwindigkeit zurücksetzen',
			'hotkeys.actions.zoomIn' => 'Vergrößern',
			'hotkeys.actions.zoomOut' => 'Verkleinern',
			'hotkeys.actions.zoomReset' => 'Zoom zurücksetzen',
			'hotkeys.actions.subSeekNext' => 'Zum nächsten Untertitel springen',
			'hotkeys.actions.subSeekPrev' => 'Zum vorherigen Untertitel springen',
			'hotkeys.actions.shaderToggle' => 'Shader umschalten',
			'hotkeys.actions.skipMarker' => 'Intro/Abspann überspringen',
			'hotkeys.actions.screenshot' => 'Screenshot aufnehmen',
			'fileInfo.title' => 'Dateiinformationen',
			'fileInfo.video' => 'Video',
			'fileInfo.audio' => 'Audio',
			'fileInfo.subtitles' => 'Untertitel',
			'fileInfo.file' => 'Datei',
			'fileInfo.codec' => 'Codec',
			'fileInfo.resolution' => 'Auflösung',
			'fileInfo.bitrate' => 'Bitrate',
			'fileInfo.frameRate' => 'Bildrate',
			'fileInfo.aspectRatio' => 'Seitenverhältnis',
			'fileInfo.profile' => 'Profil',
			'fileInfo.bitDepth' => 'Bittiefe',
			'fileInfo.colorSpace' => 'Farbraum',
			'fileInfo.colorRange' => 'Farbbereich',
			'fileInfo.colorPrimaries' => 'Primärfarben',
			'fileInfo.chromaSubsampling' => 'Chroma-Subsampling',
			'fileInfo.channels' => 'Kanäle',
			'fileInfo.overallBitrate' => 'Gesamtbitrate',
			'fileInfo.path' => 'Pfad',
			'fileInfo.size' => 'Größe',
			'fileInfo.container' => 'Container',
			'fileInfo.duration' => 'Dauer',
			'fileInfo.optimizedForStreaming' => 'Für Streaming optimiert',
			'fileInfo.has64bitOffsets' => '64-Bit-Offsets',
			'mediaMenu.markAsWatched' => 'Als gesehen markieren',
			'mediaMenu.markAsUnwatched' => 'Als ungesehen markieren',
			'mediaMenu.removeFromContinueWatching' => 'Aus ‚Weiterschauen‘ entfernen',
			'mediaMenu.viewDetails' => 'Details anzeigen',
			'mediaMenu.goToSeries' => 'Zur Serie',
			'mediaMenu.shufflePlay' => 'Zufallswiedergabe',
			'mediaMenu.shuffleNotAvailableOffline' => 'Zufallswiedergabe ist offline nicht verfügbar',
			'mediaMenu.fileInfo' => 'Dateiinfo',
			'mediaMenu.deleteFromServer' => 'Vom Server löschen',
			'mediaMenu.confirmDelete' => 'Dieses Medium und seine Dateien von deinem Server löschen?',
			'mediaMenu.deleteMultipleWarning' => 'Dies umfasst alle Episoden und deren Dateien.',
			'mediaMenu.mediaDeletedSuccessfully' => 'Medienelement gelöscht',
			'mediaMenu.mediaFailedToDelete' => 'Medienelement konnte nicht gelöscht werden',
			'mediaMenu.rate' => 'Bewerten',
			'mediaMenu.playFromBeginning' => 'Von Anfang an abspielen',
			'mediaMenu.playVersion' => 'Version abspielen …',
			'rateSheet.title' => 'Bewerten',
			'rateSheet.server' => 'Server',
			'rateSheet.favorite' => 'Favorit',
			'rateSheet.favorited' => 'Favorisiert',
			'rateSheet.saved' => 'Gespeichert',
			'rateSheet.notAvailable' => 'Keine Übereinstimmung gefunden',
			'rateSheet.noConnectedServices' => 'Verbinde einen Dienst in den Einstellungen, um dort zu bewerten.',
			'accessibility.mediaCardMovie' => ({required Object title}) => '${title}, Film',
			'accessibility.mediaCardShow' => ({required Object title}) => '${title}, Serie',
			'accessibility.mediaCardEpisode' => ({required Object title, required Object episodeInfo}) => '${title}, ${episodeInfo}',
			'accessibility.mediaCardSeason' => ({required Object title, required Object seasonInfo}) => '${title}, ${seasonInfo}',
			'accessibility.mediaCardWatched' => 'gesehen',
			'accessibility.mediaCardPartiallyWatched' => ({required Object percent}) => 'zu ${percent} Prozent gesehen',
			'accessibility.mediaCardUnwatched' => 'ungesehen',
			'accessibility.tapToPlay' => 'Zum Abspielen tippen',
			'accessibility.decrease' => 'Verringern',
			'accessibility.increase' => 'Erhöhen',
			'accessibility.decreaseValue' => ({required Object label}) => '${label} verringern',
			'accessibility.increaseValue' => ({required Object label}) => '${label} erhöhen',
			'accessibility.hue' => 'Farbton',
			'accessibility.saturation' => 'Sättigung',
			'accessibility.brightness' => 'Helligkeit',
			'accessibility.hexColor' => 'Hexadezimalfarbe',
			'accessibility.expandText' => 'Text ausklappen',
			'accessibility.collapseText' => 'Text einklappen',
			'accessibility.alphabetNavigation' => 'Alphabetische Navigation',
			'accessibility.alphabetScrollHint' => 'Nach oben oder unten wischen, um einen Buchstaben weiterzugehen',
			'accessibility.rowColumnPosition' => ({required Object row, required Object rowCount, required Object column, required Object columnCount}) => 'Zeile ${row} von ${rowCount}, Spalte ${column} von ${columnCount}',
			'accessibility.rowPosition' => ({required Object row, required Object rowCount}) => 'Zeile ${row} von ${rowCount}',
			'tooltips.shufflePlay' => 'Zufallswiedergabe',
			'tooltips.playTrailer' => 'Trailer abspielen',
			'tooltips.markAsWatched' => 'Als gesehen markieren',
			'tooltips.markAsUnwatched' => 'Als ungesehen markieren',
			'audioTracks.track' => ({required Object n}) => 'Audiospur ${n}',
			'videoControls.audioLabel' => 'Audio',
			'videoControls.subtitlesLabel' => 'Untertitel',
			'videoControls.resetToZero' => 'Auf 0 ms zurücksetzen',
			'videoControls.addTime' => ({required Object amount, required Object unit}) => '+${amount}${unit}',
			'videoControls.minusTime' => ({required Object amount, required Object unit}) => '-${amount}${unit}',
			'videoControls.playsLater' => ({required Object label}) => '${label} spielt später',
			'videoControls.playsEarlier' => ({required Object label}) => '${label} spielt früher',
			'videoControls.noOffset' => 'Kein Offset',
			'videoControls.letterbox' => 'Letterbox',
			'videoControls.fillScreen' => 'Bild füllen',
			'videoControls.stretch' => 'Strecken',
			'videoControls.lockRotation' => 'Rotation sperren',
			'videoControls.unlockRotation' => 'Rotation entsperren',
			'videoControls.timerActive' => 'Schlaftimer aktiv',
			'videoControls.playbackWillPauseIn' => ({required Object duration}) => 'Wiedergabe wird in ${duration} pausiert',
			'videoControls.sleepTimerEndOfVideo' => 'Ende des aktuellen Videos',
			'videoControls.sleepTimerStopAtHeader' => 'Beenden bei',
			'videoControls.sleepTimerDurationHeader' => 'Timer',
			'videoControls.playbackWillPauseAtEnd' => 'Wiedergabe wird am Ende dieses Videos pausiert',
			'videoControls.stillWatching' => 'Schaust du noch?',
			'videoControls.pausingIn' => ({required Object seconds}) => 'Pause in ${seconds}s',
			'videoControls.continueWatching' => 'Weiter',
			'videoControls.autoPlayNext' => 'Nächstes automatisch abspielen',
			'videoControls.playNext' => 'Nächstes abspielen',
			'videoControls.playButton' => 'Abspielen',
			'videoControls.pauseButton' => 'Pause',
			'videoControls.showPlaybackControls' => 'Wiedergabesteuerung anzeigen',
			'videoControls.hidePlaybackControls' => 'Wiedergabesteuerung ausblenden',
			'videoControls.seekBackwardButton' => ({required Object seconds}) => '${seconds} Sekunden zurück',
			'videoControls.seekForwardButton' => ({required Object seconds}) => '${seconds} Sekunden vorwärts',
			'videoControls.previousButton' => 'Vorherige Episode',
			'videoControls.nextButton' => 'Nächste Episode',
			'videoControls.previousChapterButton' => 'Vorheriges Kapitel',
			'videoControls.nextChapterButton' => 'Nächstes Kapitel',
			'videoControls.muteButton' => 'Stumm schalten',
			'videoControls.unmuteButton' => 'Stummschaltung aufheben',
			'videoControls.settingsButton' => 'Wiedergabeeinstellungen',
			'videoControls.tracksButton' => 'Audio und Untertitel',
			'videoControls.chaptersButton' => 'Kapitel',
			'videoControls.versionQualityButton' => 'Version & Qualität',
			'videoControls.versionColumnHeader' => 'Version',
			'videoControls.qualityColumnHeader' => 'Qualität',
			'videoControls.qualityOriginal' => 'Original',
			'videoControls.qualityPresetLabel' => ({required Object resolution, required Object bitrate}) => '${resolution}p ${bitrate} Mbps',
			'videoControls.transcodeUnavailableFallback' => 'Transkodierung nicht verfügbar – Wiedergabe in Originalqualität',
			'videoControls.subtitleUnavailableFallback' => 'Die ausgewählten Untertitel konnten nicht geladen werden – die Wiedergabe wird ohne Untertitel fortgesetzt',
			'videoControls.pipButton' => 'Bild-in-Bild-Modus',
			'videoControls.aspectRatioButton' => 'Seitenverhältnis',
			'videoControls.ambientLighting' => 'Umgebungsbeleuchtung',
			'videoControls.fullscreenButton' => 'Vollbild aktivieren',
			'videoControls.exitFullscreenButton' => 'Vollbild verlassen',
			'videoControls.alwaysOnTopButton' => 'Immer im Vordergrund',
			'videoControls.rotationLockButton' => 'Drehsperre',
			'videoControls.lockScreen' => 'Bildschirm sperren',
			'videoControls.screenLockButton' => 'Bildschirmsperre',
			'videoControls.longPressToUnlock' => 'Lange drücken zum Entsperren',
			'videoControls.timelineSlider' => 'Videozeitleiste',
			'videoControls.volumeSlider' => 'Lautstärkepegel',
			'videoControls.endsAt' => ({required Object time}) => 'Endet um ${time}',
			'videoControls.pipActive' => 'Wiedergabe im Bild-in-Bild-Modus',
			'videoControls.pipFailed' => 'Bild-in-Bild konnte nicht gestartet werden',
			'videoControls.screenshotSaved' => 'Screenshot gespeichert',
			'videoControls.zoomPercent' => ({required Object percent}) => 'Zoom ${percent}%',
			'videoControls.pipErrors.androidVersion' => 'Erfordert Android 8.0 oder neuer',
			'videoControls.pipErrors.iosVersion' => 'Erfordert iOS 15.0 oder neuer',
			'videoControls.pipErrors.permissionDisabled' => 'Bild-in-Bild ist deaktiviert. Aktiviere es in den Systemeinstellungen.',
			'videoControls.pipErrors.notSupported' => 'Dieses Gerät unterstützt den Bild-in-Bild-Modus nicht',
			'videoControls.pipErrors.voSwitchFailed' => 'Videoausgabe für Bild-in-Bild konnte nicht umgeschaltet werden',
			'videoControls.pipErrors.failed' => 'Bild-in-Bild konnte nicht gestartet werden',
			'videoControls.pipErrors.unknown' => ({required Object error}) => 'Ein Fehler ist aufgetreten: ${error}',
			'videoControls.chapters' => 'Kapitel',
			'videoControls.noChaptersAvailable' => 'Keine Kapitel verfügbar',
			'videoControls.queue' => 'Warteschlange',
			'videoControls.noQueueItems' => 'Keine Elemente in der Warteschlange',
			'messages.markedAsWatched' => 'Als gesehen markiert',
			'messages.markedAsUnwatched' => 'Als ungesehen markiert',
			'messages.markedAsWatchedOffline' => 'Als gesehen markiert (wird synchronisiert, wenn online)',
			'messages.markedAsUnwatchedOffline' => 'Als ungesehen markiert (wird synchronisiert, wenn online)',
			'messages.autoRemovedWatchedDownload' => ({required Object title}) => 'Automatisch entfernt: ${title}',
			'messages.autoRemovedWatchedDownloads' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: 'Automatisch entfernt: ${n} angesehener Download', other: 'Automatisch entfernt: ${n} angesehene Downloads', ), 
			'messages.removedFromContinueWatching' => 'Aus „Weiterschauen“ entfernt',
			'messages.errorLoading' => ({required Object error}) => 'Fehler: ${error}',
			'messages.streamInterrupted' => 'Der Stream wurde unterbrochen. Drücke auf Wiedergabe oder spule, um es erneut zu versuchen.',
			'messages.fileInfoNotAvailable' => 'Dateiinfo nicht verfügbar',
			'messages.playbackAuthenticationRequired' => 'Melde dich erneut beim Medienserver an, um dieses Element abzuspielen.',
			'messages.playbackServerUnavailable' => 'Der Medienserver ist nicht verfügbar. Versuche es später erneut.',
			'messages.playbackDataInvalid' => 'Der Server hat ungültige Wiedergabeinformationen zurückgegeben.',
			'messages.playbackCancelled' => 'Die Wiedergabe wurde abgebrochen.',
			'messages.playbackFailed' => 'Die Wiedergabe konnte nicht gestartet werden.',
			'messages.errorLoadingFileInfo' => ({required Object error}) => 'Fehler beim Laden der Dateiinfo: ${error}',
			'messages.errorLoadingSeries' => 'Fehler beim Laden der Serie',
			'messages.musicNotSupported' => 'Musikwiedergabe wird noch nicht unterstützt',
			'messages.noDescriptionAvailable' => 'Keine Beschreibung verfügbar',
			'messages.noProfilesAvailable' => 'Keine Profile verfügbar',
			_ => null,
		} ?? switch (path) {
			'messages.contactAdminForProfiles' => 'Wende dich an deinen Serveradministrator, um Profile hinzuzufügen',
			'messages.unableToDetermineLibrarySection' => 'Der Mediatheksbereich für dieses Element konnte nicht ermittelt werden',
			'messages.logsCleared' => 'Protokolle gelöscht',
			'messages.logsCopied' => 'Protokolle in Zwischenablage kopiert',
			'messages.noLogsAvailable' => 'Keine Protokolle verfügbar',
			'messages.metadataRefreshing' => ({required Object title}) => 'Metadaten für „${title}“ werden aktualisiert …',
			'messages.metadataRefreshStarted' => ({required Object title}) => 'Metadaten-Aktualisierung gestartet für „${title}“',
			'messages.metadataRefreshFailed' => ({required Object error}) => 'Metadaten konnten nicht aktualisiert werden: ${error}',
			'messages.logoutConfirm' => 'Abmeldung wirklich durchführen?',
			'messages.noSeasonsFound' => 'Keine Staffeln gefunden',
			'messages.seasonsLoadFailed' => 'Staffeln konnten nicht geladen werden',
			'messages.noEpisodesFound' => 'Keine Episoden in der ersten Staffel gefunden',
			'messages.noEpisodesFoundGeneral' => 'Keine Episoden gefunden',
			'messages.episodesLoadFailed' => 'Episoden konnten nicht geladen werden',
			'messages.noResultsFound' => 'Keine Ergebnisse gefunden',
			'messages.sleepTimerSet' => ({required Object label}) => 'Schlaftimer auf ${label} eingestellt',
			'messages.noItemsAvailable' => 'Keine Elemente verfügbar',
			'messages.failedToCreatePlayQueueNoItems' => 'Wiedergabewarteschlange konnte nicht erstellt werden – keine Elemente',
			'messages.failedPlayback' => ({required Object action, required Object error}) => 'Wiedergabe für ${action} fehlgeschlagen: ${error}',
			'messages.switchingToCompatiblePlayer' => 'Wechsel zu einem kompatiblen Player …',
			'messages.serverLimitTitle' => 'Wiedergabe fehlgeschlagen',
			'messages.serverLimitBody' => 'Serverfehler (HTTP 500). Vermutlich hat ein Bandbreiten- oder Transkodierungslimit diese Sitzung abgelehnt. Bitte den Besitzer, das Limit anzupassen.',
			'messages.logsUploaded' => 'Protokolle hochgeladen',
			'messages.logsUploadFailed' => 'Protokolle konnten nicht hochgeladen werden',
			'messages.logId' => 'Protokoll-ID',
			'subtitlingStyling.text' => 'Text',
			'subtitlingStyling.border' => 'Rahmen',
			'subtitlingStyling.background' => 'Hintergrund',
			'subtitlingStyling.fontSize' => 'Schriftgröße',
			'subtitlingStyling.textColor' => 'Textfarbe',
			'subtitlingStyling.borderSize' => 'Rahmengröße',
			'subtitlingStyling.borderColor' => 'Rahmenfarbe',
			'subtitlingStyling.backgroundOpacity' => 'Hintergrunddeckkraft',
			'subtitlingStyling.backgroundColor' => 'Hintergrundfarbe',
			'subtitlingStyling.position' => 'Position',
			'subtitlingStyling.assOverride' => 'ASS-Überschreibung',
			'subtitlingStyling.overrideScale' => 'Skalieren',
			'subtitlingStyling.overrideForce' => 'Erzwingen',
			'subtitlingStyling.overrideStrip' => 'Formatierung entfernen',
			'subtitlingStyling.positionTop' => 'Oben',
			'subtitlingStyling.positionBottom' => 'Unten',
			'subtitlingStyling.bold' => 'Fett',
			'subtitlingStyling.italic' => 'Kursiv',
			'subtitlingStyling.renderResolution' => 'Render-Auflösung',
			'subtitlingStyling.renderResolutionScreen' => 'Bildschirmauflösung',
			'subtitlingStyling.renderResolutionVideo' => 'Videoauflösung',
			'mpvConfig.title' => 'mpv-Konfiguration',
			'mpvConfig.description' => 'Erweiterte Videoplayer-Einstellungen',
			'mpvConfig.presets' => 'Voreinstellungen',
			'mpvConfig.noPresets' => 'Keine gespeicherten Voreinstellungen',
			'mpvConfig.saveAsPreset' => 'Als Voreinstellung speichern …',
			'mpvConfig.presetName' => 'Name der Voreinstellung',
			'mpvConfig.presetNameHint' => 'Namen für diese Voreinstellung eingeben',
			'mpvConfig.loadPreset' => 'Laden',
			'mpvConfig.deletePreset' => 'Löschen',
			'mpvConfig.presetSaved' => 'Voreinstellung gespeichert',
			'mpvConfig.presetLoaded' => 'Voreinstellung geladen',
			'mpvConfig.presetDeleted' => 'Voreinstellung gelöscht',
			'mpvConfig.confirmDeletePreset' => 'Diese Voreinstellung wirklich löschen?',
			'mpvConfig.configPlaceholder' => 'gpu-api=vulkan\nhwdec=auto\n# comment',
			'dialog.confirmAction' => 'Aktion bestätigen',
			'profiles.addPlezyProfile' => 'Plezy-Profil hinzufügen',
			'profiles.switchingProfile' => 'Profil wird gewechselt…',
			'profiles.deleteThisProfileTitle' => 'Dieses Profil löschen?',
			'profiles.deleteThisProfileMessage' => ({required Object displayName}) => '${displayName} entfernen. Verbindungen bleiben unberührt.',
			'profiles.active' => 'Aktiv',
			'profiles.manage' => 'Verwalten',
			'profiles.delete' => 'Löschen',
			'profiles.signOut' => 'Abmelden',
			'profiles.signOutPlexTitle' => 'Von Plex abmelden?',
			'profiles.signOutPlexMessage' => ({required Object displayName}) => '${displayName} und alle Plex Home-Benutzer entfernen? Du kannst dich jederzeit wieder anmelden.',
			'profiles.signedOutPlex' => 'Von Plex abgemeldet.',
			'profiles.signOutFailed' => 'Abmeldung fehlgeschlagen.',
			'profiles.sectionTitle' => 'Profile',
			'profiles.summarySingle' => 'Profile hinzufügen, um verwaltete Benutzer mit lokalen Identitäten zu kombinieren',
			'profiles.summaryMultipleWithActive' => ({required Object count, required Object activeName}) => '${count} Profile · aktiv: ${activeName}',
			'profiles.summaryMultiple' => ({required Object count}) => '${count} Profile',
			'profiles.removeConnectionTitle' => 'Verbindung entfernen?',
			'profiles.removeConnectionMessage' => ({required Object displayName, required Object connectionLabel}) => 'Zugriff von ${displayName} auf ${connectionLabel} entfernen. Andere Profile behalten ihn.',
			'profiles.deleteProfileTitle' => 'Profil löschen?',
			'profiles.deleteProfileMessage' => ({required Object displayName}) => '${displayName} und Verbindungen entfernen. Server bleiben verfügbar.',
			'profiles.profileNameLabel' => 'Profilname',
			'profiles.pinProtectionLabel' => 'PIN-Schutz',
			'profiles.setPin' => 'PIN festlegen',
			'profiles.setPinTitle' => 'PIN festlegen',
			'profiles.confirmPinTitle' => 'PIN bestätigen',
			'profiles.pinSet' => 'PIN festgelegt',
			'profiles.changePin' => 'Ändern',
			'profiles.removePin' => 'Entfernen',
			'profiles.connectionsLabel' => 'Verbindungen',
			'profiles.add' => 'Hinzufügen',
			'profiles.deleteProfileButton' => 'Profil löschen',
			'profiles.noConnectionsHint' => 'Keine Verbindungen — füge eine hinzu, um dieses Profil zu nutzen.',
			'profiles.noConnections' => 'Keine Verbindungen',
			'profiles.connectionDefault' => 'Standard',
			'profiles.connectionAs' => ({required Object displayName}) => 'als ${displayName}',
			'profiles.makeDefault' => 'Als Standard festlegen',
			'profiles.removeConnection' => 'Entfernen',
			'profiles.profileRenamed' => 'Profil umbenannt.',
			'profiles.borrowAddTo' => ({required Object displayName}) => 'Zu ${displayName} hinzufügen',
			'profiles.borrowExplain' => 'Verbindung eines anderen Profils übernehmen. PIN-geschützte Profile erfordern eine PIN.',
			'profiles.borrowEmpty' => 'Keine Verbindungen zum Übernehmen verfügbar.',
			'profiles.borrowEmptySubtitle' => 'Verbinde zuerst Plex oder Jellyfin mit einem anderen Profil.',
			'profiles.borrowLoadFailed' => 'Verfügbare Verbindungen konnten nicht geladen werden. Versuche es erneut.',
			'profiles.borrowFromProfile' => ({required Object displayName}) => 'Von ${displayName}',
			'profiles.borrowConnectionBorrowed' => 'Verbindung übernommen.',
			'profiles.borrowFailed' => 'Verbindung konnte nicht übernommen werden.',
			'profiles.incorrectPin' => 'Falsche PIN.',
			'profiles.incorrectPinTryAgain' => 'Falsche PIN. Bitte erneut versuchen.',
			'profiles.newProfile' => 'Neues Profil',
			'profiles.profileNameHint' => 'z. B. Gäste, Kinder, Wohnzimmer',
			'profiles.pinProtectionOptional' => 'PIN-Schutz (optional)',
			'profiles.pinExplain' => '4-stellige PIN zum Profilwechsel erforderlich.',
			'profiles.continueButton' => 'Weiter',
			'profiles.pinsDontMatch' => 'PINs stimmen nicht überein',
			'connections.sectionTitle' => 'Verbindungen',
			'connections.addConnection' => 'Verbindung hinzufügen',
			'connections.addConnectionSubtitleNoProfile' => 'Mit Plex anmelden oder mit einem Jellyfin-Server verbinden',
			'connections.addConnectionSubtitleScoped' => ({required Object displayName}) => 'Zu ${displayName} hinzufügen: Plex, Jellyfin oder eine andere Profilverbindung',
			'connections.sessionExpiredOne' => ({required Object name}) => 'Sitzung für ${name} abgelaufen',
			'connections.sessionExpiredMany' => ({required Object count}) => 'Sitzungen für ${count} Server abgelaufen',
			'connections.signInAgain' => 'Erneut anmelden',
			'connections.editJellyfinTitle' => 'Jellyfin-Verbindung bearbeiten',
			'connections.editJellyfinIntro' => ({required Object serverName}) => 'Füge URLs für ${serverName} hinzu oder entferne sie. Plezy verwendet die erreichbare URL mit der geringsten Latenz.',
			'discover.title' => 'Entdecken',
			'discover.noContentAvailable' => 'Kein Inhalt verfügbar',
			'discover.addMediaToLibraries' => 'Medien zur Mediathek hinzufügen',
			'discover.continueWatching' => 'Weiterschauen',
			'discover.continueWatchingIn' => ({required Object library}) => 'Weiterschauen in ${library}',
			'discover.nextUp' => 'Als Nächstes',
			'discover.nextUpIn' => ({required Object library}) => 'Als Nächstes in ${library}',
			'discover.recentlyAdded' => 'Kürzlich hinzugefügt',
			'discover.recentlyAddedIn' => ({required Object library}) => 'Kürzlich hinzugefügt in ${library}',
			'discover.latestAlbumsIn' => ({required Object library}) => 'Neueste Alben in ${library}',
			'discover.recentlyPlayedIn' => ({required Object library}) => 'Kürzlich gespielt in ${library}',
			'discover.mostPlayedIn' => ({required Object library}) => 'Am häufigsten gespielt in ${library}',
			'discover.playEpisode' => ({required Object season, required Object episode}) => 'S${season}E${episode}',
			'discover.cast' => 'Besetzung',
			'discover.extras' => 'Trailer & Extras',
			'discover.studio' => 'Studio',
			'discover.director' => 'Regisseur',
			'discover.directors' => 'Regisseure',
			'discover.movie' => 'Film',
			'discover.tvShow' => 'Serie',
			'discover.minutesLeft' => ({required Object minutes}) => 'Noch ${minutes} Min.',
			'discover.moreLikeThis' => 'Ähnliche Inhalte',
			'errors.searchFailed' => ({required Object error}) => 'Suche fehlgeschlagen: ${error}',
			'errors.connectionTimeout' => ({required Object context}) => 'Zeitüberschreitung beim Laden von ${context}',
			'errors.connectionFailed' => 'Keine Verbindung zum Medienserver möglich',
			'errors.unableToLoad' => ({required Object context}) => '${context} konnte nicht geladen werden. Bitte erneut versuchen.',
			'errors.noClientAvailable' => 'Kein Client verfügbar',
			'errors.failedToSwitchProfile' => ({required Object displayName}) => 'Profilwechsel zu ${displayName} fehlgeschlagen',
			'errors.failedToDeleteProfile' => ({required Object displayName}) => 'Löschen von ${displayName} fehlgeschlagen',
			'errors.failedToRate' => 'Bewertung konnte nicht aktualisiert werden',
			'libraries.title' => 'Mediatheken',
			'libraries.fallbackTitle' => 'Mediathek',
			'libraries.refreshMetadata' => 'Metadaten aktualisieren',
			'libraries.noLibrariesFound' => 'Keine Mediatheken gefunden',
			'libraries.allLibrariesHidden' => 'Alle Mediatheken sind ausgeblendet',
			'libraries.hiddenLibrariesCount' => ({required Object count}) => 'Ausgeblendete Mediatheken (${count})',
			'libraries.thisLibraryIsEmpty' => 'Diese Mediathek ist leer',
			'libraries.noItemsMatchFilters' => 'Keine Elemente entsprechen den aktiven Filtern',
			'libraries.resetFilters' => 'Filter zurücksetzen',
			'libraries.all' => 'Alle',
			'libraries.clearAll' => 'Alle Filter entfernen',
			'libraries.refreshMetadataConfirm' => ({required Object title}) => 'Metadaten für „${title}“ wirklich aktualisieren?',
			'libraries.manageLibraries' => 'Mediatheken verwalten',
			'libraries.sort' => 'Sortieren',
			'libraries.sortBy' => 'Sortieren nach',
			'libraries.filters' => 'Filter',
			'libraries.confirmActionMessage' => 'Aktion wirklich durchführen?',
			'libraries.showLibrary' => 'Mediathek anzeigen',
			'libraries.hideLibrary' => 'Mediathek ausblenden',
			'libraries.libraryOptions' => 'Mediatheksoptionen',
			'libraries.content' => 'Mediatheksinhalt',
			'libraries.selectLibrary' => 'Mediathek auswählen',
			'libraries.filtersWithCount' => ({required Object count}) => 'Filter (${count})',
			'libraries.noRecommendations' => 'Keine Empfehlungen verfügbar',
			'libraries.noCollections' => 'Keine Sammlungen in dieser Mediathek',
			'libraries.noFoldersFound' => 'Keine Ordner gefunden',
			'libraries.folders' => 'Ordner',
			'libraries.tabs.recommended' => 'Empfohlen',
			'libraries.tabs.browse' => 'Durchsuchen',
			'libraries.tabs.collections' => 'Sammlungen',
			'libraries.tabs.playlists' => 'Wiedergabelisten',
			'libraries.groupings.title' => 'Gruppierung',
			'libraries.groupings.all' => 'Alle',
			'libraries.groupings.movies' => 'Filme',
			'libraries.groupings.shows' => 'Serien',
			'libraries.groupings.seasons' => 'Staffeln',
			'libraries.groupings.episodes' => 'Episoden',
			'libraries.groupings.artists' => 'Interpreten',
			'libraries.groupings.albums' => 'Alben',
			'libraries.groupings.tracks' => 'Titel',
			'libraries.groupings.folders' => 'Ordner',
			'libraries.filterCategories.genre' => 'Genre',
			'libraries.filterCategories.year' => 'Jahr',
			'libraries.filterCategories.contentRating' => 'Altersfreigabe',
			'libraries.filterCategories.tag' => 'Tag',
			'libraries.filterCategories.unwatched' => 'Ungesehene',
			'libraries.filterCategories.unplayed' => 'Nicht abgespielt',
			'libraries.filterCategories.favorites' => 'Favoriten',
			'libraries.sortLabels.title' => 'Titel',
			'libraries.sortLabels.dateAdded' => 'Hinzugefügt am',
			'libraries.sortLabels.communityRating' => 'Communitybewertung',
			'libraries.sortLabels.criticRating' => 'Kritikerbewertung',
			'libraries.sortLabels.datePlayed' => 'Wiedergabedatum',
			'libraries.sortLabels.playCount' => 'Wiedergaben',
			'libraries.sortLabels.productionYear' => 'Produktionsjahr',
			'libraries.sortLabels.runtime' => 'Laufzeit',
			'libraries.sortLabels.officialRating' => 'Offizielle Bewertung',
			'libraries.sortLabels.premiereDate' => 'Premierendatum',
			'libraries.sortLabels.startDate' => 'Startdatum',
			'libraries.sortLabels.airTime' => 'Sendezeit',
			'libraries.sortLabels.studio' => 'Studio',
			'libraries.sortLabels.random' => 'Zufällig',
			'libraries.sortLabels.lastEpisodeDateAdded' => 'Hinzugefügt am (neueste Folge)',
			'about.title' => 'Über',
			'about.openSourceLicenses' => 'Open-Source-Lizenzen',
			'about.versionLabel' => ({required Object version}) => 'Version ${version}',
			'about.appDescription' => 'Ein schöner, mit Flutter entwickelter Plex- und Jellyfin-Client',
			'about.viewLicensesDescription' => 'Lizenzen von Drittanbieter-Bibliotheken anzeigen',
			'hubDetail.title' => 'Titel',
			'hubDetail.releaseYear' => 'Erscheinungsjahr',
			'hubDetail.dateAdded' => 'Hinzugefügt am',
			'hubDetail.rating' => 'Bewertung',
			'hubDetail.noItemsFound' => 'Keine Elemente gefunden',
			'logs.clearLogs' => 'Protokolle löschen',
			'logs.copyLogs' => 'Protokolle kopieren',
			'logs.uploadLogs' => 'Protokolle hochladen',
			'licenses.relatedPackages' => 'Verwandte Pakete',
			'licenses.license' => 'Lizenz',
			'licenses.licenseNumber' => ({required Object number}) => 'Lizenz ${number}',
			'licenses.licensesCount' => ({required Object count}) => '${count} Lizenzen',
			'navigation.libraries' => 'Mediatheken',
			'navigation.downloads' => 'Downloads',
			'navigation.explore' => 'Erkunden',
			'explore.title' => 'Erkunden',
			'explore.selectSource' => 'Quelle auswählen',
			'explore.rows.watchlist' => 'Merkliste',
			'explore.rows.recommendedMovies' => 'Empfohlene Filme',
			'explore.rows.recommendedShows' => 'Empfohlene Serien',
			'explore.rows.trendingMovies' => 'Angesagte Filme',
			'explore.rows.trendingShows' => 'Angesagte Serien',
			'explore.rows.popularMovies' => 'Beliebte Filme',
			'explore.rows.popularShows' => 'Beliebte Serien',
			'explore.rows.trendingAnime' => 'Angesagte Anime',
			'explore.rows.suggestedAnime' => 'Empfohlene Anime',
			'explore.rows.airingAnime' => 'Beste derzeit laufende Anime',
			'explore.rows.popularAnime' => 'Beliebteste Anime',
			'explore.rows.trending' => 'Angesagt',
			'explore.rows.upcomingMovies' => 'Kommende Filme',
			'explore.rows.upcomingShows' => 'Kommende Serien',
			'explore.status.airing' => 'Laufend',
			'explore.status.ended' => 'Beendet',
			'explore.status.canceled' => 'Abgesetzt',
			'explore.status.upcoming' => 'Demnächst',
			'explore.episodeCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Folge', other: '${n} Folgen', ), 
			'explore.cast' => 'Besetzung',
			'explore.characters' => 'Charaktere',
			'explore.addToWatchlist' => 'Zur Merkliste hinzufügen',
			'explore.removeFromWatchlist' => 'Von Merkliste entfernen',
			'explore.watchlistUpdateFailed' => 'Merkliste konnte nicht aktualisiert werden',
			'explore.notInLibrary' => 'Nicht in deiner Mediathek',
			'explore.inTheseLibraries' => 'In diesen Mediatheken',
			'explore.checkingLibrary' => 'Deine Mediathek wird überprüft …',
			'explore.emptyTitle' => 'Hier ist noch nichts',
			'explore.emptyMessage' => ({required Object source}) => 'Zeilen aus ${source} erscheinen hier, sobald sie Inhalte enthalten.',
			'explore.searchHint' => ({required Object source}) => '${source} durchsuchen',
			'explore.searchEmpty' => ({required Object query}) => 'Keine Ergebnisse für „${query}“',
			'explore.searchPrompt' => ({required Object source}) => 'Suche nach Filmen und Serien auf ${source}.',
			'explore.searchFailed' => 'Suche fehlgeschlagen. Prüfe deine Verbindung und versuche es erneut.',
			'collections.title' => 'Sammlungen',
			'collections.collection' => 'Sammlung',
			'collections.empty' => 'Sammlung ist leer',
			'collections.deleteCollection' => 'Sammlung löschen',
			'collections.deleteConfirm' => ({required Object title}) => '„${title}“ löschen? Dies kann nicht rückgängig gemacht werden.',
			'collections.deleted' => 'Sammlung gelöscht',
			'collections.deleteFailed' => 'Sammlung konnte nicht gelöscht werden',
			'collections.deleteFailedWithError' => ({required Object error}) => 'Sammlung konnte nicht gelöscht werden: ${error}',
			'collections.selectCollection' => 'Sammlung auswählen',
			'collections.collectionName' => 'Sammlungsname',
			'collections.enterCollectionName' => 'Sammlungsnamen eingeben',
			'collections.addedToCollection' => 'Zur Sammlung hinzugefügt',
			'collections.errorAddingToCollection' => 'Fehler beim Hinzufügen zur Sammlung',
			'collections.created' => 'Sammlung erstellt',
			'collections.removeFromCollection' => 'Aus Sammlung entfernen',
			'collections.removeFromCollectionConfirm' => ({required Object title}) => '„${title}“ aus dieser Sammlung entfernen?',
			'collections.removedFromCollection' => 'Aus Sammlung entfernt',
			'collections.removeFromCollectionFailed' => 'Entfernen aus Sammlung fehlgeschlagen',
			'collections.removeFromCollectionError' => ({required Object error}) => 'Fehler beim Entfernen aus der Sammlung: ${error}',
			'collections.searchCollections' => 'Sammlungen durchsuchen...',
			'playlists.title' => 'Wiedergabelisten',
			'playlists.playlist' => 'Wiedergabeliste',
			'playlists.noPlaylists' => 'Keine Wiedergabelisten gefunden',
			'playlists.create' => 'Wiedergabeliste erstellen',
			'playlists.playlistName' => 'Name der Wiedergabeliste',
			'playlists.enterPlaylistName' => 'Name der Wiedergabeliste eingeben',
			'playlists.delete' => 'Wiedergabeliste löschen',
			'playlists.removeItem' => 'Aus Wiedergabeliste entfernen',
			'playlists.smartPlaylist' => 'Intelligente Wiedergabeliste',
			'playlists.itemCount' => ({required Object count}) => '${count} Elemente',
			'playlists.oneItem' => '1 Element',
			'playlists.emptyPlaylist' => 'Diese Wiedergabeliste ist leer',
			'playlists.deleteConfirm' => 'Wiedergabeliste löschen?',
			'playlists.deleteMessage' => ({required Object name}) => '„${name}“ wirklich löschen?',
			'playlists.created' => 'Wiedergabeliste erstellt',
			'playlists.deleted' => 'Wiedergabeliste gelöscht',
			'playlists.itemAdded' => 'Zur Wiedergabeliste hinzugefügt',
			'playlists.itemRemoved' => 'Aus Wiedergabeliste entfernt',
			'playlists.selectPlaylist' => 'Wiedergabeliste auswählen',
			'playlists.searchPlaylists' => 'Wiedergabelisten durchsuchen...',
			'playlists.errorCreating' => 'Wiedergabeliste konnte nicht erstellt werden',
			'playlists.errorDeleting' => 'Wiedergabeliste konnte nicht gelöscht werden',
			'playlists.errorLoading' => 'Wiedergabelisten konnten nicht geladen werden',
			'playlists.errorAdding' => 'Konnte nicht zur Wiedergabeliste hinzugefügt werden',
			'playlists.errorReordering' => 'Element der Wiedergabeliste konnte nicht neu geordnet werden',
			'playlists.errorRemoving' => 'Konnte nicht aus der Wiedergabeliste entfernt werden',
			'music.goToAlbum' => 'Zum Album',
			'music.goToArtist' => 'Zum Interpreten',
			'music.instantMix' => 'Instant-Mix',
			'music.playNext' => 'Als Nächstes abspielen',
			'music.addToQueue' => 'Zur Warteschlange hinzufügen',
			'music.discNumber' => ({required Object n}) => 'Disc ${n}',
			'music.trackCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('de'))(n, one: '${n} Titel', other: '${n} Titel', ), 
			'music.nowPlaying' => 'Wird wiedergegeben',
			'music.playingFrom' => ({required Object title}) => 'Wiedergabe von ${title}',
			'music.queue' => 'Warteschlange',
			'music.clearQueue' => 'Warteschlange leeren',
			'music.lyrics' => 'Songtext',
			'music.noLyrics' => 'Kein Songtext verfügbar',
			'music.sleepTimer' => 'Schlaftimer',
			'music.sleepTimerEndOfTrack' => 'Ende des Titels',
			'music.sleepTimerMinutes' => ({required Object n}) => '${n} Minuten',
			'music.stopPlayback' => 'Wiedergabe stoppen',
			'music.previousTrack' => 'Vorheriger Titel',
			'music.nextTrack' => 'Nächster Titel',
			'music.repeat' => 'Wiederholen',
			'music.repeatAll' => 'Alle wiederholen',
			'music.repeatOne' => 'Titel wiederholen',
			'downloads.title' => 'Downloads',
			'downloads.manage' => 'Verwalten',
			'downloads.tvShows' => 'Serien',
			'downloads.movies' => 'Filme',
			'downloads.music' => 'Musik',
			'downloads.tracksQueued' => ({required Object count}) => '${count} Titel zum Download in Warteschlange',
			'downloads.noDownloads' => 'Noch keine Downloads',
			'downloads.noDownloadsDescription' => 'Heruntergeladene Inhalte werden hier für die Offline-Wiedergabe angezeigt',
			'downloads.downloadNow' => 'Herunterladen',
			'downloads.deleteDownload' => 'Download löschen',
			'downloads.retryDownload' => 'Download wiederholen',
			'downloads.downloadQueued' => 'Download in Warteschlange',
			'downloads.downloadResumed' => 'Download fortgesetzt',
			'downloads.serverErrorBitrate' => 'Serverfehler: Datei überschreitet möglicherweise das Remote-Bitrate-Limit',
			'downloads.storageFull' => 'Die Downloads wurden angehalten, weil der Gerätespeicher voll ist. Gib Speicherplatz frei und versuche es erneut.',
			'downloads.episodesQueued' => ({required Object count}) => '${count} Episoden zum Download hinzugefügt',
			'downloads.downloadDeleted' => 'Download gelöscht',
			'downloads.deleteConfirm' => ({required Object title}) => '"${title}" von diesem Gerät löschen?',
			'downloads.cancelledDownloadTitle' => 'Abgebrochener Download',
			'downloads.cancelledDownloadMessage' => 'Dieser Download wurde abgebrochen. Was möchtest du tun?',
			'downloads.allEpisodesAlreadyDownloaded' => 'Alle Episoden sind bereits heruntergeladen',
			'downloads.resumeDownload' => 'Download fortsetzen',
			'downloads.cancelledDownload' => 'Abgebrochener Download',
			'downloads.syncingFile' => ({required Object file, required Object status}) => '${file} (${status} wird synchronisiert)',
			'downloads.downloadedFileClickToComplete' => ({required Object file}) => '${file} heruntergeladen — zum Abschließen klicken',
			'downloads.partialDownloadClickToComplete' => 'Teilweise heruntergeladen — zum Abschließen klicken',
			'downloads.deleting' => 'Wird gelöscht …',
			'downloads.deletingWithProgress' => ({required Object title, required Object current, required Object total}) => '${title} wird gelöscht … (${current} von ${total})',
			'downloads.queuedTooltip' => 'In Warteschlange',
			'downloads.queuedFilesTooltip' => ({required Object files}) => 'In Warteschlange: ${files}',
			'downloads.downloadingTooltip' => 'Wird heruntergeladen …',
			'downloads.downloadingFilesTooltip' => ({required Object files}) => '${files} werden heruntergeladen',
			'downloads.noDownloadsTree' => 'Keine Downloads',
			'downloads.pauseAll' => 'Alle pausieren',
			'downloads.resumeAll' => 'Alle fortsetzen',
			'downloads.deleteAll' => 'Alle löschen',
			'downloads.selectVersion' => 'Version auswählen',
			'downloads.allEpisodes' => 'Alle Episoden',
			'downloads.unwatchedOnly' => 'Nur ungesehene',
			'downloads.nextNUnwatched' => ({required Object count}) => 'Nächste ${count} ungesehene',
			'downloads.customAmount' => 'Eigene Anzahl...',
			'downloads.includeSpecials' => 'Sonderfolgen einschließen',
			'downloads.howManyEpisodes' => 'Wie viele Episoden?',
			'downloads.invalidEpisodeCount' => 'Gib eine gültige Episodenanzahl ein.',
			'downloads.keepSynced' => 'Synchronisiert halten',
			'downloads.downloadOnce' => 'Einmal herunterladen',
			'downloads.keepNUnwatched' => ({required Object count}) => '${count} ungesehene behalten',
			'downloads.editSyncRule' => 'Synchronisierungsregel bearbeiten',
			'downloads.removeSyncRule' => 'Synchronisierungsregel entfernen',
			'downloads.removeSyncRuleConfirm' => ({required Object title}) => 'Synchronisierung von „${title}“ beenden? Heruntergeladene Episoden werden behalten.',
			'downloads.syncRuleCreated' => ({required Object count}) => 'Synchronisierungsregel erstellt – ${count} ungesehene Episoden werden behalten',
			'downloads.syncRuleUpdated' => 'Synchronisierungsregel aktualisiert',
			'downloads.syncRuleRemoved' => 'Synchronisierungsregel entfernt',
			'downloads.syncedNewEpisodes' => ({required Object count, required Object title}) => '${count} neue Episoden für ${title} synchronisiert',
			'downloads.activeSyncRules' => 'Synchronisierungsregeln',
			'downloads.noSyncRules' => 'Keine Synchronisierungsregeln',
			'downloads.manageSyncRule' => 'Synchronisierung verwalten',
			'downloads.editEpisodeCount' => 'Episodenanzahl',
			'downloads.editSyncFilter' => 'Synchronisierungsfilter',
			'downloads.syncAllItems' => 'Alle Elemente synchronisieren',
			'downloads.syncUnwatchedItems' => 'Ungesehene Elemente synchronisieren',
			'downloads.syncRuleServerContext' => ({required Object server, required Object status}) => 'Server: ${server} • ${status}',
			'downloads.syncRuleAvailable' => 'Verfügbar',
			'downloads.syncRuleOffline' => 'Offline',
			'downloads.syncRuleSignInRequired' => 'Anmeldung erforderlich',
			'downloads.syncRuleNotAvailableForProfile' => 'Für das aktuelle Profil nicht verfügbar',
			'downloads.syncRuleUnknownServer' => 'Unbekannter Server',
			'downloads.syncRuleListCreated' => 'Synchronisierungsregel erstellt',
			'downloads.backgroundWarning.bannerBlocked' => 'Downloads werden gestoppt, wenn du die App verlässt',
			'downloads.backgroundWarning.bannerDegraded' => 'Downloads im Hintergrund sind möglicherweise eingeschränkt',
			'downloads.backgroundWarning.bannerAction' => 'Details',
			'downloads.backgroundWarning.sheetTitle' => 'Downloads im Hintergrund sind blockiert',
			'downloads.backgroundWarning.sheetTitleDegraded' => 'Downloads im Hintergrund sind möglicherweise eingeschränkt',
			'downloads.backgroundWarning.sheetIntro' => 'Android verhindert, dass Plezy zuverlässig im Hintergrund herunterlädt.',
			'downloads.backgroundWarning.sheetIntroDegraded' => 'Dein Gerät schränkt ein, wann Plezy im Hintergrund herunterladen kann.',
			'downloads.backgroundWarning.reasonBackgroundRestricted' => 'Die Hintergrundnutzung von Plezy ist eingeschränkt. Stelle die Akku- oder Hintergrundnutzung auf „Uneingeschränkt“.',
			'downloads.backgroundWarning.reasonStandbyRestricted' => 'Android hat Plezy in einen eingeschränkten Standby-Modus versetzt. Stelle die Akkunutzung auf „Uneingeschränkt“.',
			'downloads.backgroundWarning.reasonDownloadChannelBlocked' => 'Download-Benachrichtigungen sind deaktiviert. Fortschritt und Steuerelemente sind daher möglicherweise nicht verfügbar.',
			'downloads.backgroundWarning.reasonNotificationsDisabled' => 'Benachrichtigungen sind deaktiviert. Ab Android 13 sind sie für lange Downloads im Hintergrund erforderlich.',
			'downloads.backgroundWarning.reasonDataSaver' => 'Der Datensparmodus ist aktiviert und blockiert Downloads im Hintergrund über mobile Daten. Über Wi-Fi sollten Downloads weiterhin funktionieren.',
			'downloads.backgroundWarning.reasonOemUnknown' => 'Downloads wurden wiederholt gestoppt, während Plezy im Hintergrund war. Prüfe die Einstellungen zur Akku- oder Hintergrundnutzung von Plezy.',
			'downloads.backgroundWarning.openSettings' => 'Einstellungen öffnen',
			'downloads.backgroundWarning.stillNotWorking' => 'Gerätespezifische Hilfe',
			'downloads.backgroundWarning.stillNotWorkingDescription' => 'Sieh dir die Schritte für dein Gerät an oder sende bei anhaltendem Problem ein Protokoll über Einstellungen › Protokolle anzeigen.',
			'downloads.backgroundWarning.dialogTitle' => 'Downloads werden möglicherweise nicht abgeschlossen',
			'downloads.backgroundWarning.dialogDownloadAnyway' => 'Trotzdem herunterladen',
			'downloads.backgroundWarning.dialogFixFirst' => 'Zuerst beheben',
			'downloads.backgroundWarning.statusTile' => 'Downloads im Hintergrund',
			'downloads.backgroundWarning.statusOk' => 'Ausführung im Hintergrund erlaubt',
			'downloads.backgroundWarning.statusBlocked' => 'Durch Systemeinstellungen blockiert',
			'downloads.backgroundWarning.statusDegraded' => 'Durch Systemeinstellungen eingeschränkt',
			'downloads.backgroundWarning.statusUnknown' => 'Noch nicht geprüft',
			'downloads.backgroundWarning.settingsUnavailable' => 'Die Systemeinstellungen konnten auf diesem Gerät nicht geöffnet werden',
			'downloads.backgroundWarning.linkUnavailable' => 'dontkillmyapp.com konnte auf diesem Gerät nicht geöffnet werden',
			'shaders.title' => 'Shader',
			'shaders.noShaderDescription' => 'Keine Videoverbesserung',
			'shaders.nvscalerDescription' => 'NVIDIA-Bildskalierung für schärferes Video',
			'shaders.artcnnVariantNeutral' => 'Neutral',
			'shaders.artcnnVariantDenoise' => 'Rauschreduzierung',
			'shaders.artcnnVariantDenoiseSharpen' => 'Rauschreduzierung + Schärfen',
			'shaders.qualityFast' => 'Schnell',
			'shaders.qualityHQ' => 'Hohe Qualität',
			'shaders.mode' => 'Modus',
			'shaders.importShader' => 'Shader importieren',
			'shaders.customShaderDescription' => 'Benutzerdefinierter GLSL-Shader',
			'shaders.shaderImported' => 'Shader importiert',
			'shaders.shaderImportFailed' => 'Shader konnte nicht importiert werden',
			'shaders.deleteShader' => 'Shader löschen',
			'shaders.deleteShaderConfirm' => ({required Object name}) => '"${name}" löschen?',
			'videoSettings.playbackSpeed' => 'Wiedergabegeschwindigkeit',
			'videoSettings.normalSpeed' => 'Normal',
			'videoSettings.sleepTimerActive' => ({required Object duration}) => 'Aktiv (${duration})',
			'videoSettings.zoom' => 'Zoom',
			'videoSettings.sleepTimer' => 'Schlaftimer',
			'videoSettings.audioSync' => 'Audio-Synchronisation',
			'videoSettings.subtitleSync' => 'Untertitel-Synchronisation',
			'videoSettings.hdr' => 'HDR',
			'videoSettings.audioOutput' => 'Audioausgabe',
			'videoSettings.performanceOverlay' => 'Leistungsanzeige',
			'videoSettings.audioPassthrough' => 'Audio-Durchleitung',
			'videoSettings.audioOutputDolbyAtmos' => 'Dolby Atmos',
			'videoSettings.audioOutputDolbyAudio' => 'Dolby Audio',
			'videoSettings.audioOutputSurround' => 'Surround',
			'videoSettings.audioOutputSpatial' => 'Räumliches Audio',
			'videoSettings.audioOutputStereo' => 'Stereo',
			'videoSettings.audioNormalization' => 'Lautstärke normalisieren',
			'videoSettings.audioDownmix' => 'Downmix auf Stereo',
			'performanceOverlay.color' => 'Farbe',
			'performanceOverlay.performance' => 'Leistung',
			'performanceOverlay.buffer' => 'Puffer',
			'performanceOverlay.app' => 'App',
			'performanceOverlay.decoder' => 'Decoder',
			'performanceOverlay.rawDecoder' => 'Raw-Decoder',
			'performanceOverlay.tunneling' => 'Tunneling',
			'performanceOverlay.aspect' => 'Seitenverhältnis',
			'performanceOverlay.rotation' => 'Drehung',
			'performanceOverlay.dvSource' => 'DV-Quelle',
			'performanceOverlay.dvPath' => 'DV-Pfad',
			'performanceOverlay.p7Conversion' => 'P7-Konv.',
			'performanceOverlay.sampleRate' => 'Abtastrate',
			'performanceOverlay.pixelFormat' => 'Pixelformat',
			'performanceOverlay.hwFormat' => 'HW-Format',
			'performanceOverlay.matrix' => 'Matrix',
			'performanceOverlay.primaries' => 'Primärfarben',
			'performanceOverlay.transfer' => 'Transfer',
			'performanceOverlay.renderFps' => 'Render-FPS',
			'performanceOverlay.displayFps' => 'Display-FPS',
			'performanceOverlay.avSync' => 'A/V-Sync',
			'performanceOverlay.dropped' => 'Verworfen',
			'performanceOverlay.dvRpus' => 'DV-RPUs',
			'performanceOverlay.dvRpuAverage' => 'DV-RPU Ø',
			'performanceOverlay.dvSampleAverage' => 'DV-Sample Ø',
			'performanceOverlay.maxLuma' => 'Max. Luma',
			'performanceOverlay.minLuma' => 'Min. Luma',
			'performanceOverlay.maxCll' => 'MaxCLL',
			'performanceOverlay.maxFall' => 'MaxFALL',
			'performanceOverlay.cacheUsed' => 'Cache genutzt',
			'performanceOverlay.cacheLimit' => 'Cache-Limit',
			'performanceOverlay.speed' => 'Geschwindigkeit',
			'performanceOverlay.player' => 'Player',
			'performanceOverlay.memory' => 'Speicher',
			'performanceOverlay.uiFps' => 'UI-FPS',
			'externalPlayer.title' => 'Externer Player',
			'externalPlayer.useExternalPlayer' => 'Externen Player verwenden',
			'externalPlayer.useExternalPlayerDescription' => 'Videos in einer anderen App öffnen',
			'externalPlayer.selectPlayer' => 'Player auswählen',
			'externalPlayer.customPlayers' => 'Benutzerdefinierte Player',
			'externalPlayer.systemDefault' => 'Systemstandard',
			'externalPlayer.addCustomPlayer' => 'Benutzerdefinierten Player hinzufügen',
			'externalPlayer.playerName' => 'Playername',
			'externalPlayer.playerNameHint' => 'Mein Player',
			'externalPlayer.playerCommand' => 'Befehl',
			_ => null,
		} ?? switch (path) {
			'externalPlayer.playerPackage' => 'Paketname',
			'externalPlayer.playerUrlScheme' => 'URL-Schema',
			'externalPlayer.off' => 'Aus',
			'externalPlayer.launchFailed' => 'Externer Player konnte nicht geöffnet werden',
			'externalPlayer.appNotInstalled' => ({required Object name}) => '${name} ist nicht installiert',
			'externalPlayer.playInExternalPlayer' => 'In externem Player abspielen',
			'metadataEdit.editMetadata' => 'Bearbeiten...',
			'metadataEdit.screenTitle' => 'Metadaten bearbeiten',
			'metadataEdit.basicInfo' => 'Grundinformationen',
			'metadataEdit.artwork' => 'Grafiken',
			'metadataEdit.title' => 'Titel',
			'metadataEdit.sortTitle' => 'Sortiertitel',
			'metadataEdit.originalTitle' => 'Originaltitel',
			'metadataEdit.releaseDate' => 'Erscheinungsdatum',
			'metadataEdit.contentRating' => 'Altersfreigabe',
			'metadataEdit.studio' => 'Studio',
			'metadataEdit.tagline' => 'Slogan',
			'metadataEdit.summary' => 'Zusammenfassung',
			'metadataEdit.poster' => 'Poster',
			'metadataEdit.background' => 'Hintergrund',
			'metadataEdit.logo' => 'Logo',
			'metadataEdit.squareArt' => 'Quadratisches Bild',
			'metadataEdit.selectPoster' => 'Poster auswählen',
			'metadataEdit.selectBackground' => 'Hintergrund auswählen',
			'metadataEdit.selectLogo' => 'Logo auswählen',
			'metadataEdit.selectSquareArt' => 'Quadratisches Bild auswählen',
			'metadataEdit.fromUrl' => 'Über URL',
			'metadataEdit.uploadFile' => 'Datei hochladen',
			'metadataEdit.enterImageUrl' => 'Bild-URL eingeben',
			'metadataEdit.imageUrl' => 'Bild-URL',
			'metadataEdit.metadataUpdated' => 'Metadaten aktualisiert',
			'metadataEdit.metadataUpdateFailed' => 'Metadaten konnten nicht aktualisiert werden',
			'metadataEdit.artworkUpdated' => 'Grafiken aktualisiert',
			'metadataEdit.artworkUpdateFailed' => 'Grafiken konnten nicht aktualisiert werden',
			'metadataEdit.noArtworkAvailable' => 'Keine Grafiken verfügbar',
			'metadataEdit.artworkOption' => ({required Object index}) => 'Grafikoption ${index}',
			'metadataEdit.selectedArtworkOption' => ({required Object index}) => 'Grafikoption ${index}, ausgewählt',
			'metadataEdit.notSet' => 'Nicht festgelegt',
			'metadataEdit.tags' => 'Tags',
			'metadataEdit.addTag' => 'Tag hinzufügen',
			'metadataEdit.genre' => 'Genre',
			'metadataEdit.director' => 'Regisseur',
			'metadataEdit.writer' => 'Autor',
			'metadataEdit.producer' => 'Produzent',
			'metadataEdit.country' => 'Land',
			'metadataEdit.label' => 'Label',
			'trakt.title' => 'Trakt',
			'trakt.connected' => 'Verbunden',
			'trakt.connectedAs' => ({required Object username}) => 'Verbunden als @${username}',
			'trakt.disconnectConfirm' => 'Trakt-Konto trennen?',
			'trakt.disconnectConfirmBody' => 'Plezy sendet keine Ereignisse mehr an Trakt. Du kannst jederzeit erneut verbinden.',
			'trakt.scrobble' => 'Echtzeit-Scrobbling',
			'trakt.scrobbleDescription' => 'Sende Play-, Pause- und Stopp-Ereignisse während der Wiedergabe an Trakt.',
			'trakt.watchedSync' => 'Gesehen-Status synchronisieren',
			'trakt.watchedSyncDescription' => 'Wenn du Inhalte in Plezy als gesehen markierst, werden sie auch auf Trakt markiert.',
			'seerr.title' => 'Seerr',
			'seerr.connectTitle' => 'Seerr verbinden',
			'seerr.serverUrl' => 'Server-URL',
			'seerr.serverUrlHelper' => 'Die Adresse deiner Seerr-Instanz',
			'seerr.checkServer' => 'Weiter',
			'seerr.signInWithJellyfin' => 'Mit Jellyfin anmelden',
			'seerr.signInWithEmby' => 'Mit Emby anmelden',
			'seerr.signInWithLocal' => 'Lokales Konto verwenden',
			'seerr.email' => 'E-Mail',
			'seerr.noSignInMethods' => 'Diese Seerr-Instanz bietet keine von Plezy unterstützte Anmeldemethode.',
			'seerr.instance' => 'Instanz',
			'seerr.disconnectConfirm' => 'Seerr trennen?',
			'seerr.disconnectConfirmBody' => 'Plezy vergisst diese Seerr-Instanz. Jederzeit erneut verbinden.',
			'seerr.request' => 'Anfragen',
			'seerr.request4k' => 'In 4K anfragen',
			'seerr.seasons' => 'Staffeln',
			'seerr.allSeasons' => 'Alle Staffeln',
			'seerr.advancedOptions' => 'Erweitert',
			'seerr.destinationServer' => 'Zielserver',
			'seerr.qualityProfile' => 'Qualitätsprofil',
			'seerr.rootFolder' => 'Stammordner',
			'seerr.languageProfile' => 'Sprachprofil',
			'seerr.requestSubmitted' => 'Anfrage gesendet',
			'seerr.requestFailed' => ({required Object error}) => 'Anfrage fehlgeschlagen: ${error}',
			'seerr.requestsLoadFailed' => 'Anfrageoptionen konnten nicht geladen werden',
			'seerr.nothingToRequest' => 'Alles ist bereits verfügbar oder angefragt.',
			'seerr.statusAvailable' => 'Verfügbar',
			'seerr.statusPartiallyAvailable' => 'Teilweise verfügbar',
			'seerr.statusRequested' => 'Angefragt',
			'seerr.statusProcessing' => 'Wird verarbeitet',
			'services.title' => 'Dienste',
			'services.hubSubtitle' => 'Wiedergabefortschritt synchronisieren und neue Titel anfragen.',
			'services.notConnected' => 'Nicht verbunden',
			'services.connectedAs' => ({required Object username}) => 'Verbunden als @${username}',
			'services.scrobble' => 'Fortschritt automatisch verfolgen',
			'services.scrobbleDescription' => 'Aktualisiere deine Liste, wenn du eine Folge oder einen Film beendest.',
			'services.disconnectConfirm' => ({required Object service}) => '${service} trennen?',
			'services.disconnectConfirmBody' => ({required Object service}) => 'Plezy aktualisiert ${service} nicht mehr. Jederzeit erneut verbinden.',
			'services.connectFailed' => ({required Object service}) => 'Verbindung zu ${service} fehlgeschlagen. Versuche es erneut.',
			'services.names.mal' => 'MyAnimeList',
			'services.names.anilist' => 'AniList',
			'services.names.simkl' => 'Simkl',
			'services.names.seerr' => 'Seerr',
			'services.deviceCode.title' => ({required Object service}) => 'Plezy auf ${service} aktivieren',
			'services.deviceCode.body' => ({required Object url}) => 'Gehe zu ${url} und gib diesen Code ein:',
			'services.deviceCode.openToActivate' => ({required Object service}) => '${service} zum Aktivieren öffnen',
			'services.deviceCode.copyCode' => 'Aktivierungscode kopieren',
			'services.deviceCode.waitingForAuthorization' => 'Warte auf Autorisierung…',
			'services.deviceCode.codeCopied' => 'Code kopiert',
			'services.oauthProxy.title' => ({required Object service}) => 'Bei ${service} anmelden',
			'services.oauthProxy.body' => 'Scanne diesen QR-Code oder öffne die URL auf einem beliebigen Gerät.',
			'services.oauthProxy.openToSignIn' => ({required Object service}) => '${service} zum Anmelden öffnen',
			'services.oauthProxy.copyUrl' => 'Anmelde-URL kopieren',
			'services.oauthProxy.urlCopied' => 'URL kopiert',
			'services.libraryFilter.title' => 'Mediatheksfilter',
			'services.libraryFilter.subtitleAllSyncing' => 'Alle Mediatheken werden synchronisiert',
			'services.libraryFilter.subtitleNoneSyncing' => 'Nichts wird synchronisiert',
			'services.libraryFilter.subtitleBlocked' => ({required Object count}) => '${count} ausgeschlossen',
			'services.libraryFilter.subtitleAllowed' => ({required Object count}) => '${count} zugelassen',
			'services.libraryFilter.mode' => 'Filtermodus',
			'services.libraryFilter.modeBlacklist' => 'Ausschlussliste',
			'services.libraryFilter.modeWhitelist' => 'Zulassungsliste',
			'services.libraryFilter.modeHintBlacklist' => 'Alle Mediatheken außer den unten markierten synchronisieren.',
			'services.libraryFilter.modeHintWhitelist' => 'Nur die unten markierten Mediatheken synchronisieren.',
			'services.libraryFilter.libraries' => 'Mediatheken',
			'services.libraryFilter.noLibraries' => 'Keine Mediatheken verfügbar',
			'addServer.addJellyfinTitle' => 'Jellyfin-Server hinzufügen',
			'addServer.serverUrls' => 'Server-URLs',
			'addServer.serverUrlsHelper' => 'Mehrere URLs möglich, durch Kommas getrennt.',
			'addServer.findServer' => 'Server finden',
			'addServer.searchingLocalServers' => 'Suche nach lokalen Jellyfin-Servern …',
			'addServer.localServers' => 'Lokale Jellyfin-Server',
			'addServer.username' => 'Benutzername',
			'addServer.password' => 'Passwort',
			'addServer.signIn' => 'Anmelden',
			'addServer.change' => 'Ändern',
			'addServer.required' => 'Erforderlich',
			'addServer.couldNotReachServer' => ({required Object error}) => 'Server nicht erreichbar: ${error}',
			'addServer.signInFailed' => ({required Object error}) => 'Anmeldung fehlgeschlagen: ${error}',
			'addServer.quickConnectFailed' => ({required Object error}) => 'Quick Connect fehlgeschlagen: ${error}',
			'addServer.enterJellyfinUrlError' => 'Gib die URL deines Jellyfin-Servers ein',
			'addServer.addConnectionTitle' => 'Verbindung hinzufügen',
			'addServer.addConnectionTitleScoped' => ({required Object name}) => 'Zu ${name} hinzufügen',
			'addServer.connectToJellyfinCard' => 'Mit Jellyfin verbinden',
			'addServer.connectToJellyfinCardSubtitle' => 'Gib Server-URL, Benutzername und Passwort ein.',
			'addServer.connectToJellyfinCardSubtitleScoped' => ({required Object name}) => 'Bei einem Jellyfin-Server anmelden. Wird mit ${name} verknüpft.',
			'addServer.borrowFromAnotherProfile' => 'Von einem anderen Profil ausleihen',
			'addServer.borrowFromAnotherProfileSubtitle' => 'Verbindung eines anderen Profils wiederverwenden. PIN-geschützte Profile erfordern eine PIN.',
			_ => null,
		};
	}
}
