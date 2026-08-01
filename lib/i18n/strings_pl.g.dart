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
class TranslationsPl extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsPl({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.pl,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <pl>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsPl _root = this; // ignore: unused_field

	@override 
	TranslationsPl $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsPl(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$pl app = _Translations$app$pl._(_root);
	@override late final _Translations$auth$pl auth = _Translations$auth$pl._(_root);
	@override late final _Translations$common$pl common = _Translations$common$pl._(_root);
	@override late final _Translations$screens$pl screens = _Translations$screens$pl._(_root);
	@override late final _Translations$update$pl update = _Translations$update$pl._(_root);
	@override late final _Translations$settings$pl settings = _Translations$settings$pl._(_root);
	@override late final _Translations$search$pl search = _Translations$search$pl._(_root);
	@override late final _Translations$hotkeys$pl hotkeys = _Translations$hotkeys$pl._(_root);
	@override late final _Translations$fileInfo$pl fileInfo = _Translations$fileInfo$pl._(_root);
	@override late final _Translations$mediaMenu$pl mediaMenu = _Translations$mediaMenu$pl._(_root);
	@override late final _Translations$rateSheet$pl rateSheet = _Translations$rateSheet$pl._(_root);
	@override late final _Translations$accessibility$pl accessibility = _Translations$accessibility$pl._(_root);
	@override late final _Translations$tooltips$pl tooltips = _Translations$tooltips$pl._(_root);
	@override late final _Translations$audioTracks$pl audioTracks = _Translations$audioTracks$pl._(_root);
	@override late final _Translations$videoControls$pl videoControls = _Translations$videoControls$pl._(_root);
	@override late final _Translations$messages$pl messages = _Translations$messages$pl._(_root);
	@override late final _Translations$subtitlingStyling$pl subtitlingStyling = _Translations$subtitlingStyling$pl._(_root);
	@override late final _Translations$mpvConfig$pl mpvConfig = _Translations$mpvConfig$pl._(_root);
	@override late final _Translations$dialog$pl dialog = _Translations$dialog$pl._(_root);
	@override late final _Translations$profiles$pl profiles = _Translations$profiles$pl._(_root);
	@override late final _Translations$connections$pl connections = _Translations$connections$pl._(_root);
	@override late final _Translations$discover$pl discover = _Translations$discover$pl._(_root);
	@override late final _Translations$errors$pl errors = _Translations$errors$pl._(_root);
	@override late final _Translations$libraries$pl libraries = _Translations$libraries$pl._(_root);
	@override late final _Translations$about$pl about = _Translations$about$pl._(_root);
	@override late final _Translations$hubDetail$pl hubDetail = _Translations$hubDetail$pl._(_root);
	@override late final _Translations$logs$pl logs = _Translations$logs$pl._(_root);
	@override late final _Translations$licenses$pl licenses = _Translations$licenses$pl._(_root);
	@override late final _Translations$navigation$pl navigation = _Translations$navigation$pl._(_root);
	@override late final _Translations$explore$pl explore = _Translations$explore$pl._(_root);
	@override late final _Translations$collections$pl collections = _Translations$collections$pl._(_root);
	@override late final _Translations$playlists$pl playlists = _Translations$playlists$pl._(_root);
	@override late final _Translations$music$pl music = _Translations$music$pl._(_root);
	@override late final _Translations$downloads$pl downloads = _Translations$downloads$pl._(_root);
	@override late final _Translations$shaders$pl shaders = _Translations$shaders$pl._(_root);
	@override late final _Translations$videoSettings$pl videoSettings = _Translations$videoSettings$pl._(_root);
	@override late final _Translations$performanceOverlay$pl performanceOverlay = _Translations$performanceOverlay$pl._(_root);
	@override late final _Translations$externalPlayer$pl externalPlayer = _Translations$externalPlayer$pl._(_root);
	@override late final _Translations$metadataEdit$pl metadataEdit = _Translations$metadataEdit$pl._(_root);
	@override late final _Translations$trakt$pl trakt = _Translations$trakt$pl._(_root);
	@override late final _Translations$seerr$pl seerr = _Translations$seerr$pl._(_root);
	@override late final _Translations$services$pl services = _Translations$services$pl._(_root);
	@override late final _Translations$addServer$pl addServer = _Translations$addServer$pl._(_root);
}

// Path: app
class _Translations$app$pl extends Translations$app$en {
	_Translations$app$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plezy';
}

// Path: auth
class _Translations$auth$pl extends Translations$auth$en {
	_Translations$auth$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get connectToJellyfin => 'Połącz z Jellyfin';
	@override String get useQuickConnect => 'Użyj Quick Connect';
	@override String get quickConnectInstructions => 'Otwórz Quick Connect w Jellyfin i wpisz ten kod.';
	@override String get quickConnectWaiting => 'Oczekiwanie na zatwierdzenie…';
	@override String get quickConnectCancel => 'Anuluj';
	@override String get quickConnectExpired => 'Quick Connect wygasł. Spróbuj ponownie.';
	@override String get localDataRecoveryRequired => 'Plezy nie mogło bezpiecznie odzyskać lokalnych danych logowania ani oczekujących danych odtwarzania. Zaloguj się ponownie.';
}

// Path: common
class _Translations$common$pl extends Translations$common$en {
	_Translations$common$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Anuluj';
	@override String get save => 'Zapisz';
	@override String get close => 'Zamknij';
	@override String get clear => 'Wyczyść';
	@override String get reset => 'Resetuj';
	@override String get later => 'Później';
	@override String get submit => 'Wyślij';
	@override String get confirm => 'Potwierdź';
	@override String get retry => 'Ponów';
	@override String get logout => 'Wyloguj';
	@override String get unknown => 'Nieznane';
	@override String get refresh => 'Odśwież';
	@override String get yes => 'Tak';
	@override String get no => 'Nie';
	@override String get delete => 'Usuń';
	@override String get edit => 'Edytuj';
	@override String get shuffle => 'Losowo';
	@override String get addTo => 'Dodaj do...';
	@override String get createNew => 'Utwórz';
	@override String get disconnect => 'Rozłącz';
	@override String get play => 'Odtwórz';
	@override String get pause => 'Pauza';
	@override String get resume => 'Wznów';
	@override String get error => 'Błąd';
	@override String get search => 'Szukaj';
	@override String get home => 'Strona główna';
	@override String get back => 'Wstecz';
	@override String get settings => 'Ustawienia';
	@override String get ok => 'OK';
	@override String get off => 'Wył.';
	@override String seasonNumber({required Object number}) => 'Sezon ${number}';
	@override String episodeNumberTitle({required Object number, required Object title}) => 'Odcinek ${number} - ${title}';
	@override String chapterNumber({required Object number}) => 'Rozdział ${number}';
	@override String get reconnect => 'Połącz ponownie';
	@override String get viewAll => 'Pokaż wszystko';
	@override String get checkingNetwork => 'Sprawdzanie sieci...';
	@override String get loadingServers => 'Ładowanie serwerów...';
	@override String get connectingToServers => 'Łączenie z serwerami...';
	@override String get startingOfflineMode => 'Uruchamianie trybu offline...';
	@override String get loading => 'Ładowanie...';
	@override String get pressBackAgainToExit => 'Naciśnij ponownie przycisk Wstecz, aby wyjść';
	@override String get next => 'Następny';
}

// Path: screens
class _Translations$screens$pl extends Translations$screens$en {
	_Translations$screens$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get licenses => 'Licencje';
	@override String get switchProfile => 'Zmień profil';
	@override String get subtitleStyling => 'Styl napisów';
	@override String get mpvConfig => 'mpv.conf';
	@override String get logs => 'Logi';
}

// Path: update
class _Translations$update$pl extends Translations$update$en {
	_Translations$update$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get available => 'Dostępna aktualizacja';
	@override String versionAvailable({required Object version}) => 'Dostępna wersja ${version}';
	@override String currentVersion({required Object version}) => 'Bieżąca: ${version}';
	@override String get skipVersion => 'Pomiń tę wersję';
	@override String get viewRelease => 'Zobacz wydanie';
	@override String get latestVersion => 'Masz najnowszą wersję';
	@override String get checkFailed => 'Nie udało się sprawdzić aktualizacji';
}

// Path: settings
class _Translations$settings$pl extends Translations$settings$en {
	_Translations$settings$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ustawienia';
	@override String get supportDeveloper => 'Wesprzyj Plezy';
	@override String get supportDeveloperDescription => 'Wspomóż rozwój darowizną na Liberapay';
	@override String get language => 'Język';
	@override String get theme => 'Motyw';
	@override String get appearance => 'Wygląd';
	@override String get videoPlayback => 'Odtwarzanie wideo';
	@override String get videoPlaybackDescription => 'Skonfiguruj zachowanie odtwarzania';
	@override String get advanced => 'Zaawansowane';
	@override String get episodePosterMode => 'Styl plakatu odcinka';
	@override String get seriesPoster => 'Plakat serialu';
	@override String get seasonPoster => 'Plakat sezonu';
	@override String get episodeThumbnail => 'Miniatura';
	@override String get showHeroSectionDescription => 'Wyświetl karuzelę wyróżnionych treści na ekranie głównym';
	@override String get secondsLabel => 'Sekundy';
	@override String get minutesLabel => 'Minuty';
	@override String get secondsShort => 's';
	@override String get minutesShort => 'm';
	@override String durationHint({required Object min, required Object max}) => 'Wprowadź czas (${min}-${max})';
	@override String get systemTheme => 'Systemowy';
	@override String get lightTheme => 'Jasny';
	@override String get darkTheme => 'Ciemny';
	@override String get oledTheme => 'OLED';
	@override String get libraryDensity => 'Gęstość biblioteki';
	@override String get compact => 'Kompaktowy';
	@override String get comfortable => 'Wygodny';
	@override String get tvCornerSpotlightBackdrop => 'Tło wyróżnionej pozycji w rogu';
	@override String get tvCornerSpotlightBackdropDescription => 'Wyświetlaj grafikę wyróżnionej pozycji w prawym górnym rogu zamiast na całym ekranie';
	@override String get viewMode => 'Tryb widoku';
	@override String get gridView => 'Siatka';
	@override String get listView => 'Lista';
	@override String get showHeroSection => 'Pokaż sekcję wyróżnioną';
	@override String get continueWatchingAction => 'Działanie w sekcji „Kontynuuj oglądanie”';
	@override String get continueWatchingPlay => 'Odtwórz';
	@override String get continueWatchingDetails => 'Otwórz szczegóły';
	@override String get episodeAction => 'Akcja odcinka';
	@override String get episodePlay => 'Odtwórz';
	@override String get episodeDetails => 'Otwórz szczegóły';
	@override String get useGlobalHubs => 'Użyj układu strony głównej';
	@override String get useGlobalHubsDescription => 'Wyświetlaj ujednolicone sekcje ekranu głównego. W przeciwnym razie używaj rekomendacji bibliotek.';
	@override String get showServerNameOnHubs => 'Pokaż nazwę serwera w sekcjach';
	@override String get showServerNameOnHubsDescription => 'Zawsze pokazuj nazwy serwerów w tytułach sekcji.';
	@override String get groupLibrariesByServer => 'Grupuj biblioteki według serwera';
	@override String get groupLibrariesByServerDescription => 'Grupuj biblioteki paska bocznego pod każdym serwerem multimediów.';
	@override String get alwaysKeepSidebarOpen => 'Zawsze utrzymuj panel boczny otwarty';
	@override String get alwaysKeepSidebarOpenDescription => 'Panel boczny jest rozwinięty, a obszar treści dostosowuje się';
	@override String get showUnwatchedCount => 'Pokaż liczbę nieobejrzanych';
	@override String get showUnwatchedCountDescription => 'Wyświetl liczbę nieobejrzanych odcinków w serialach i sezonach';
	@override String get showEpisodeNumberOnCards => 'Pokaż numer odcinka na kartach';
	@override String get showEpisodeNumberOnCardsDescription => 'Pokazuj numer sezonu i odcinka na kartach odcinków';
	@override String get showSeasonPostersOnTabs => 'Pokaż plakaty sezonów na zakładkach';
	@override String get showSeasonPostersOnTabsDescription => 'Pokazuj plakat każdego sezonu nad jego zakładką';
	@override String get tvFullCardLayout => 'Pełne karty TV';
	@override String get tvFullCardLayoutDescription => 'Używaj kart TV tylko z obrazem i nałożonymi nazwiskami aktorów';
	@override String get focusGlow => 'Poświata zaznaczenia';
	@override String get focusGlowDescription => 'Wyświetlaj delikatną poświatę wokół zaznaczonej karty';
	@override String get visualEffects => 'Efekty wizualne';
	@override String get visualEffectsAuto => 'Automatycznie';
	@override String get visualEffectsAutoDescription => 'Automatycznie ograniczaj efekty na urządzeniach o niższej wydajności';
	@override String get visualEffectsFull => 'Pełne';
	@override String get visualEffectsReduced => 'Ograniczone';
	@override String get visualEffectsReducedDescription => 'Mniej animacji i grafiki o niższej rozdzielczości';
	@override String get hideSpoilers => 'Ukryj spoilery nieobejrzanych odcinków';
	@override String get hideSpoilersDescription => 'Rozmywaj miniatury i opisy nieobejrzanych odcinków';
	@override String get playerBackend => 'Mechanizm odtwarzania';
	@override String get exoPlayer => 'ExoPlayer';
	@override String get mpv => 'mpv';
	@override String get hardwareDecoding => 'Dekodowanie sprzętowe';
	@override String get hardwareDecodingDescription => 'Użyj akceleracji sprzętowej, gdy dostępna';
	@override String get bufferSize => 'Rozmiar bufora';
	@override String bufferSizeMB({required Object size}) => '${size}MB';
	@override String get bufferSizeAuto => 'Automatyczny (zalecany)';
	@override String bufferSizeWarning({required Object heap, required Object size}) => 'Dostępna pamięć: ${heap}MB. Bufor ${size}MB może wpłynąć na odtwarzanie.';
	@override String get defaultQualityTitle => 'Domyślna jakość';
	@override String get musicQualityTitle => 'Jakość muzyki';
	@override String get subtitleStyling => 'Styl napisów';
	@override String get subtitleStylingDescription => 'Dostosuj wygląd napisów';
	@override String get smallSkipDuration => 'Krótki skok';
	@override String get largeSkipDuration => 'Długi skok';
	@override String get rewindOnResume => 'Przewiń przy wznowieniu';
	@override String secondsUnit({required Object seconds}) => '${seconds} sekund';
	@override String get defaultSleepTimer => 'Domyślny wyłącznik czasowy';
	@override String minutesUnit({required Object minutes}) => '${minutes} minut';
	@override String get rememberTrackSelections => 'Zapamiętuj wybór ścieżek dla każdego serialu i filmu';
	@override String get rememberTrackSelectionsDescription => 'Zapamiętuj wybór ścieżki dźwiękowej i napisów dla każdego tytułu';
	@override String get followServerTrackSelections => 'Używaj wyboru ścieżek z serwera dla każdego odcinka';
	@override String get followServerTrackSelectionsDescription => 'Przy zmianie odcinka stosuj ścieżkę dźwiękową i napisy wybrane na serwerze zamiast przenosić bieżący wybór';
	@override String get showChapterMarkersOnTimeline => 'Pokaż znaczniki rozdziałów na pasku przewijania';
	@override String get showChapterMarkersOnTimelineDescription => 'Podziel pasek przewijania na granicach rozdziałów';
	@override String get clickVideoTogglesPlayback => 'Kliknięcie wideo przełącza odtwarzanie/pauzę';
	@override String get clickVideoTogglesPlaybackDescription => 'Kliknięcie wideo odtwarza/wstrzymuje zamiast pokazywać sterowanie.';
	@override String get videoPlayerControls => 'Kontrolki odtwarzacza wideo';
	@override String get keyboardShortcuts => 'Skróty klawiszowe';
	@override String get keyboardShortcutsDescription => 'Dostosuj skróty klawiszowe';
	@override String get videoPlayerNavigation => 'Nawigacja odtwarzacza wideo';
	@override String get videoPlayerNavigationDescription => 'Użyj klawiszy strzałek do nawigacji kontrolkami odtwarzacza';
	@override String get crashReporting => 'Raportowanie błędów';
	@override String get crashReportingDescription => 'Wysyłaj raporty o błędach, aby pomóc ulepszyć aplikację';
	@override String get debugLogging => 'Rejestrowanie diagnostyczne';
	@override String get debugLoggingDescription => 'Włącz szczegółowe rejestrowanie, aby ułatwić rozwiązywanie problemów';
	@override String get viewLogs => 'Pokaż logi';
	@override String get viewLogsDescription => 'Pokaż logi aplikacji';
	@override String get resetSettings => 'Zresetuj ustawienia';
	@override String get resetSettingsDescription => 'Przywróć ustawienia domyślne. Tego nie można cofnąć.';
	@override String get resetSettingsSuccess => 'Przywrócono ustawienia domyślne';
	@override String get backup => 'Kopia zapasowa';
	@override String get exportSettings => 'Eksportuj ustawienia';
	@override String get exportSettingsDescription => 'Zapisz swoje preferencje do pliku';
	@override String get exportSettingsSuccess => 'Ustawienia wyeksportowane';
	@override String get importSettings => 'Importuj ustawienia';
	@override String get importSettingsDescription => 'Przywróć preferencje z pliku';
	@override String get importSettingsConfirm => 'Bieżące ustawienia zostaną zastąpione. Kontynuować?';
	@override String get importSettingsSuccess => 'Ustawienia zaimportowane';
	@override String get importSettingsInvalidFile => 'Ten plik nie jest prawidłowym eksportem Plezy';
	@override String get importSettingsNoUser => 'Zaloguj się przed importem ustawień';
	@override String get shortcutsReset => 'Skróty przywrócone do domyślnych';
	@override String get about => 'O aplikacji';
	@override String get aboutDescription => 'Informacje o aplikacji i licencje';
	@override String get updates => 'Aktualizacje';
	@override String get updateAvailable => 'Dostępna aktualizacja';
	@override String get checkForUpdates => 'Sprawdź aktualizacje';
	@override String get autoCheckUpdatesOnStartup => 'Automatycznie sprawdzaj aktualizacje przy uruchomieniu';
	@override String get autoCheckUpdatesOnStartupDescription => 'Powiadamiaj o dostępnej aktualizacji przy uruchomieniu';
	@override String get validationErrorEnterNumber => 'Wprowadź prawidłową liczbę';
	@override String validationErrorDuration({required Object min, required Object max, required Object unit}) => 'Czas musi być między ${min} a ${max} ${unit}';
	@override String shortcutAlreadyAssigned({required Object action}) => 'Skrót jest już przypisany do ${action}';
	@override String shortcutUpdated({required Object action}) => 'Skrót zaktualizowany dla ${action}';
	@override String get saveFailed => 'Nie udało się zapisać zmian. Spróbuj ponownie.';
	@override String get autoSkip => 'Automatyczne pomijanie';
	@override String get autoSkipIntro => 'Automatyczne pomijanie intro';
	@override String get autoSkipIntroDescription => 'Automatycznie pomijaj znaczniki intro po kilku sekundach';
	@override String get autoSkipCredits => 'Automatyczne pomijanie napisów końcowych';
	@override String get autoSkipCreditsDescription => 'Automatycznie pomijaj napisy końcowe i odtwórz następny odcinek';
	@override String get forceSkipMarkerFallback => 'Wymuś znaczniki awaryjne';
	@override String get forceSkipMarkerFallbackDescription => 'Używaj wzorców tytułów rozdziałów, nawet gdy Plex ma znaczniki';
	@override String get autoSkipDelay => 'Opóźnienie automatycznego pomijania';
	@override String autoSkipDelayDescription({required Object seconds}) => 'Czekaj ${seconds} sekund przed automatycznym pominięciem';
	@override String get introPattern => 'Wzorzec znacznika intro';
	@override String get introPatternDescription => 'Wyrażenie regularne do rozpoznawania znaczników intro w tytułach rozdziałów';
	@override String get creditsPattern => 'Wzorzec znacznika napisów końcowych';
	@override String get creditsPatternDescription => 'Wyrażenie regularne do rozpoznawania znaczników napisów końcowych w tytułach rozdziałów';
	@override String get invalidRegex => 'Nieprawidłowe wyrażenie regularne';
	@override String get regex => 'Wyrażenie regularne';
	@override String get downloads => 'Pobrania';
	@override String get downloadLocationDescription => 'Wybierz miejsce przechowywania pobranych treści';
	@override String get downloadLocationDefault => 'Domyślne (pamięć aplikacji)';
	@override String get downloadLocationCustom => 'Niestandardowa lokalizacja';
	@override String get selectFolder => 'Wybierz folder';
	@override String get resetToDefault => 'Przywróć domyślne';
	@override String currentPath({required Object path}) => 'Bieżąca: ${path}';
	@override String get downloadLocationChanged => 'Lokalizacja pobierania zmieniona';
	@override String get downloadLocationReset => 'Lokalizacja pobierania przywrócona do domyślnej';
	@override String get downloadLocationInvalid => 'Nie można zapisywać w wybranym folderze';
	@override String get downloadLocationPickerUnavailable => 'Wybór folderu nie jest dostępny na tym urządzeniu';
	@override String get downloadOnWifiOnly => 'Pobieraj tylko przez Wi-Fi';
	@override String get downloadOnWifiOnlyDescription => 'Blokuj pobieranie na danych komórkowych';
	@override String get autoRemoveWatchedDownloads => 'Automatycznie usuwaj obejrzane pobrania';
	@override String get autoRemoveWatchedDownloadsDescription => 'Automatycznie usuwaj obejrzane pobrania';
	@override String get cellularDownloadBlocked => 'Pobieranie przez sieć komórkową jest zablokowane. Użyj Wi-Fi lub zmień ustawienie.';
	@override String get maxVolume => 'Maksymalna głośność';
	@override String get maxVolumeDescription => 'Pozwól na wzmocnienie głośności powyżej 100% dla cichych multimediów';
	@override String maxVolumePercent({required Object percent}) => '${percent}%';
	@override String get discordRichPresence => 'Discord Rich Presence';
	@override String get discordRichPresenceDescription => 'Pokaż, co oglądasz na Discordzie';
	@override String get services => 'Usługi';
	@override String get servicesDescription => 'Połącz Trakt, MyAnimeList, Seerr i inne';
	@override String get manageLibrariesDescription => 'Zmieniaj kolejność i ukrywaj biblioteki';
	@override String get autoPip => 'Automatyczny obraz w obrazie';
	@override String get autoPipDescription => 'Automatycznie włączaj tryb obrazu w obrazie po opuszczeniu aplikacji podczas odtwarzania';
	@override String get matchContentFrameRate => 'Dopasuj częstotliwość klatek do treści';
	@override String get matchContentFrameRateDescription => 'Dopasuj częstotliwość odświeżania ekranu do wideo';
	@override String get matchRefreshRate => 'Dopasuj częstotliwość odświeżania';
	@override String get matchRefreshRateDescription => 'Dopasuj częstotliwość odświeżania w trybie pełnoekranowym';
	@override String get matchDynamicRange => 'Dopasuj zakres dynamiki';
	@override String get matchDynamicRangeDescription => 'Włącz HDR dla treści HDR, potem wróć do SDR';
	@override String get displaySwitchDelay => 'Opóźnienie przełączania ekranu';
	@override String get tunneledPlayback => 'Tunelowane odtwarzanie';
	@override String get tunneledPlaybackDescription => 'Użyj tunelowania wideo. Wyłącz, jeśli HDR pokazuje czarny obraz.';
	@override String get audioPassthrough => 'Przekazywanie dźwięku';
	@override String get audioPassthroughDescription => 'Przesyłaj dźwięk Dolby/DTS do amplitunera lub telewizora bez ponownego kodowania, zachowując dźwięk przestrzenny. Wyłącz tę opcję, jeśli nie słychać dźwięku.';
	@override String get audioPassthroughDescriptionAppleTv => 'Używaj natywnego dekodera Dolby firmy Apple dla Dolby Digital Plus, w tym Atmos. DTS i TrueHD nadal będą odtwarzane jako wielokanałowy dźwięk PCM. Wyłącz tę opcję, jeśli nie słychać dźwięku.';
	@override String get audioDownmix => 'Miksowanie do stereo';
	@override String get audioDownmixDescription => 'Miksuje dźwięk przestrzenny do dwóch kanałów dla głośników stereo lub słuchawek';
	@override String get downmixCenterBoost => 'Wzmocnienie kanału centralnego';
	@override String downmixCenterBoostValue({required Object db}) => '${db} dB';
	@override String get downmixCenterBoostLabel => 'Wzmocnienie (dB)';
	@override String get downmixCenterBoostShort => 'dB';
	@override String get audioDownmixNormalize => 'Normalizacja głośności przy miksowaniu';
	@override String get audioDownmixNormalizeDescription => 'Obniża miks, aby zapobiec przesterowaniu. Wyłącz, aby zachować oryginalną głośność (głośne sceny mogą być zniekształcone).';
	@override String get atmosDiagnostics => 'Test wyjścia Atmos';
	@override String get atmosDiagnosticsDescription => 'Diagnozuj wyjście Dolby Atmos, odtwarzając sygnały testowe przez odtwarzacz systemowy';
	@override String get atmosTestHlsAtmos => 'Strumień Atmos Apple';
	@override String get atmosTestHlsAtmosDescription => 'Sprawdzony strumień Dolby Atmos. Amplituner powinien pokazać Dolby Atmos.';
	@override String get atmosTestHlsControl => 'Strumień dźwięku przestrzennego Apple';
	@override String get atmosTestHlsControlDescription => 'Strumień kontrolny bez Atmos. Amplituner powinien wskazywać dźwięk przestrzenny bez Atmos.';
	@override String get atmosTestRawStream => 'Surowy strumień EAC3';
	@override String get atmosTestRawStreamDescription => 'Przesyła strumieniowo plik testowy dokładnie tak jak podczas odtwarzania Atmos w odtwarzaczu. Wymaga adresu URL pliku testowego.';
	@override String get atmosTestRawFile => 'Surowy plik EAC3';
	@override String get atmosTestRawFileDescription => 'Odtwarza plik testowy o znanej długości. Wymaga URL pliku testowego.';
	@override String get atmosTestAsbarNative => 'Renderer bufora próbek (natywny)';
	@override String get atmosTestAsbarNativeDescription => 'Przekazuje nienaruszony skompresowany dźwięk pliku prosto do renderera systemu. Wymaga URL pliku testowego.';
	@override String get atmosTestAsbarGenerated => 'Renderer bufora próbek (odtworzony)';
	@override String get atmosTestAsbarGeneratedDescription => 'To samo, ale z opisem dźwięku budowanym tak jak przy odtwarzaniu. Wymaga URL pliku testowego.';
	@override String get atmosTestSessionMode => 'Użyj trybu odtwarzania filmów';
	@override String get atmosTestSessionModeDescription => 'Wyłączone używa trybu udokumentowanego przez Dolby. Włączone używa poprzedniego trybu.';
	@override String get atmosTestShowRoutePicker => 'Wybierz wyjście AirPlay';
	@override String get atmosTestHideRoutePicker => 'Ukryj wybór wyjścia AirPlay';
	@override String get atmosTestRoutePickerDescription => 'Wysyła test do odbiornika AirPlay. Tylko AirPlay zgłasza ustalony tryb dźwięku.';
	@override String get atmosTestStop => 'Zatrzymaj test';
	@override String get atmosTestUrl => 'Adres URL pliku testowego';
	@override String get atmosTestUrlDescription => 'Adres URL HTTP surowego pliku Dolby Atmos w formacie .ec3 (np. wyodrębnionego za pomocą ffmpeg)';
	@override String get atmosTestUrlMissing => 'Najpierw ustaw adres URL pliku testowego';
	@override String get atmosTestStatus => 'Stan';
	@override String get dvConversionMode => 'Konwersja Dolby Vision';
	@override String get dvConversionModeDescription => 'Wybierz, jak ExoPlayer obsługuje pliki Dolby Vision Profile 7.';
	@override String get dvConversionAuto => 'Automatycznie';
	@override String get dvConversionNative => 'Natywnie / wyłączone';
	@override String get dvConversionDv81 => 'P7 → P8.1';
	@override String get dvConversionHevcStrip => 'P7 → HEVC';
	@override String get dvConversionAutoDescription => 'Wykrywaj możliwości urządzenia i stosuj standardowy mechanizm awaryjny';
	@override String get dvConversionNativeDescription => 'Wymuś natywne DV7 i wyłącz ponowną próbę konwersji DV';
	@override String get dvConversionDv81Description => 'Wymuś wbudowaną konwersję RPU do profilu Dolby Vision 8.1';
	@override String get dvConversionHevcStripDescription => 'Usuń warstwy Dolby Vision RPU/EL i przedstaw zwykłe HEVC';
	@override String get requireProfileSelectionOnOpen => 'Pytaj o profil przy otwarciu aplikacji';
	@override String get requireProfileSelectionOnOpenDescription => 'Pokaż wybór profilu za każdym razem, gdy aplikacja jest otwierana';
	@override String get forceTvMode => 'Wymuś tryb TV';
	@override String get forceTvModeDescription => 'Wymuś układ telewizyjny na urządzeniach, które nie wykrywają go automatycznie. Wymaga ponownego uruchomienia.';
	@override String get startInFullscreen => 'Uruchom na pełnym ekranie';
	@override String get startInFullscreenDescription => 'Otwiera Plezy w trybie pełnoekranowym przy uruchomieniu';
	@override String get exitFullscreenOnPlayerClose => 'Wyjdź z pełnego ekranu przy zamykaniu odtwarzacza';
	@override String get exitFullscreenOnPlayerCloseDescription => 'Automatycznie wychodzi z trybu pełnoekranowego po zamknięciu odtwarzacza wideo';
	@override String get autoHidePerformanceOverlay => 'Automatycznie ukrywaj nakładkę wydajności';
	@override String get autoHidePerformanceOverlayDescription => 'Wygaszaj nakładkę wydajności wraz z kontrolkami odtwarzania';
	@override String get showNavBarLabels => 'Pokaż etykiety paska nawigacji';
	@override String get showNavBarLabelsDescription => 'Wyświetl tekstowe etykiety pod ikonami paska nawigacji';
	@override String get startupSection => 'Sekcja startowa';
	@override String get display => 'Ekran';
	@override String get homeScreen => 'Ekran główny';
	@override String get navigation => 'Nawigacja';
	@override String get window => 'Okno';
	@override String get content => 'Zawartość';
	@override String get player => 'Odtwarzacz';
	@override String get subtitlesAndConfig => 'Napisy i konfiguracja';
	@override String get seekAndTiming => 'Przewijanie i czas';
	@override String get behavior => 'Zachowanie';
}

// Path: search
class _Translations$search$pl extends Translations$search$en {
	_Translations$search$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Szukaj filmów, seriali, muzyki...';
	@override String get tryDifferentTerm => 'Spróbuj innego wyszukiwania';
	@override String get searchYourMedia => 'Przeszukaj swoje media';
	@override String get enterTitleActorOrKeyword => 'Wprowadź tytuł, aktora lub słowo kluczowe';
}

// Path: hotkeys
class _Translations$hotkeys$pl extends Translations$hotkeys$en {
	_Translations$hotkeys$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String setShortcutFor({required Object actionName}) => 'Ustaw skrót dla ${actionName}';
	@override String get clearShortcut => 'Wyczyść skrót';
	@override String get noShortcutSet => 'Brak ustawionego skrótu';
	@override String get currentShortcut => 'Bieżący skrót:';
	@override String get pressToRecord => 'Wybierz, aby zapisać skrót klawiszowy';
	@override String get recordingShortcut => 'Naciśnij teraz skrót klawiszowy';
	@override late final _Translations$hotkeys$actions$pl actions = _Translations$hotkeys$actions$pl._(_root);
}

// Path: fileInfo
class _Translations$fileInfo$pl extends Translations$fileInfo$en {
	_Translations$fileInfo$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Informacje o pliku';
	@override String get video => 'Wideo';
	@override String get audio => 'Audio';
	@override String get subtitles => 'Napisy';
	@override String get file => 'Plik';
	@override String get codec => 'Kodek';
	@override String get resolution => 'Rozdzielczość';
	@override String get bitrate => 'Przepływność';
	@override String get frameRate => 'Klatki na sekundę';
	@override String get aspectRatio => 'Proporcje';
	@override String get profile => 'Profil';
	@override String get bitDepth => 'Głębia bitowa';
	@override String get colorSpace => 'Przestrzeń kolorów';
	@override String get colorRange => 'Zakres kolorów';
	@override String get colorPrimaries => 'Kolory podstawowe';
	@override String get chromaSubsampling => 'Podpróbkowanie chrominancji';
	@override String get channels => 'Kanały';
	@override String get overallBitrate => 'Całkowita przepływność';
	@override String get path => 'Ścieżka';
	@override String get size => 'Rozmiar';
	@override String get container => 'Kontener';
	@override String get duration => 'Czas trwania';
	@override String get optimizedForStreaming => 'Zoptymalizowane do strumieniowania';
	@override String get has64bitOffsets => 'Przesunięcia 64-bitowe';
}

// Path: mediaMenu
class _Translations$mediaMenu$pl extends Translations$mediaMenu$en {
	_Translations$mediaMenu$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get markAsWatched => 'Oznacz jako obejrzane';
	@override String get markAsUnwatched => 'Oznacz jako nieobejrzane';
	@override String get removeFromContinueWatching => 'Usuń z kontynuowania oglądania';
	@override String get viewDetails => 'Pokaż szczegóły';
	@override String get goToSeries => 'Przejdź do serialu';
	@override String get shufflePlay => 'Odtwarzanie losowe';
	@override String get shuffleNotAvailableOffline => 'Odtwarzanie losowe nie jest dostępne offline';
	@override String get fileInfo => 'Informacje o pliku';
	@override String get deleteFromServer => 'Usuń z serwera';
	@override String get confirmDelete => 'Usunąć to medium i jego pliki z serwera?';
	@override String get deleteMultipleWarning => 'Obejmuje to wszystkie odcinki i ich pliki.';
	@override String get mediaDeletedSuccessfully => 'Usunięto element multimedialny';
	@override String get mediaFailedToDelete => 'Nie udało się usunąć elementu multimedialnego';
	@override String get rate => 'Oceń';
	@override String get playFromBeginning => 'Odtwórz od początku';
	@override String get playVersion => 'Odtwórz wersję...';
}

// Path: rateSheet
class _Translations$rateSheet$pl extends Translations$rateSheet$en {
	_Translations$rateSheet$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oceń';
	@override String get server => 'Serwer';
	@override String get favorite => 'Dodaj do ulubionych';
	@override String get favorited => 'Dodano do ulubionych';
	@override String get saved => 'Zapisano';
	@override String get notAvailable => 'Nie znaleziono dopasowania';
	@override String get noConnectedServices => 'Połącz usługę w Ustawieniach, aby tam oceniać.';
}

// Path: accessibility
class _Translations$accessibility$pl extends Translations$accessibility$en {
	_Translations$accessibility$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String mediaCardMovie({required Object title}) => '${title}, film';
	@override String mediaCardShow({required Object title}) => '${title}, serial TV';
	@override String mediaCardEpisode({required Object title, required Object episodeInfo}) => '${title}, ${episodeInfo}';
	@override String mediaCardSeason({required Object title, required Object seasonInfo}) => '${title}, ${seasonInfo}';
	@override String get mediaCardWatched => 'obejrzane';
	@override String mediaCardPartiallyWatched({required Object percent}) => 'obejrzano w ${percent} procentach';
	@override String get mediaCardUnwatched => 'nieobejrzane';
	@override String get tapToPlay => 'Dotknij, aby odtworzyć';
	@override String get decrease => 'Zmniejsz';
	@override String get increase => 'Zwiększ';
	@override String decreaseValue({required Object label}) => 'Zmniejsz ${label}';
	@override String increaseValue({required Object label}) => 'Zwiększ ${label}';
	@override String get hue => 'Odcień';
	@override String get saturation => 'Nasycenie';
	@override String get brightness => 'Jasność';
	@override String get hexColor => 'Kolor szesnastkowy';
	@override String get expandText => 'Rozwiń tekst';
	@override String get collapseText => 'Zwiń tekst';
	@override String get alphabetNavigation => 'Nawigacja alfabetyczna';
	@override String get alphabetScrollHint => 'Przesuń w górę lub w dół, aby przejść o literę';
	@override String rowColumnPosition({required Object row, required Object rowCount, required Object column, required Object columnCount}) => 'Wiersz ${row} z ${rowCount}, kolumna ${column} z ${columnCount}';
	@override String rowPosition({required Object row, required Object rowCount}) => 'Wiersz ${row} z ${rowCount}';
}

// Path: tooltips
class _Translations$tooltips$pl extends Translations$tooltips$en {
	_Translations$tooltips$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get shufflePlay => 'Odtwarzanie losowe';
	@override String get playTrailer => 'Odtwórz zwiastun';
	@override String get markAsWatched => 'Oznacz jako obejrzane';
	@override String get markAsUnwatched => 'Oznacz jako nieobejrzane';
}

// Path: audioTracks
class _Translations$audioTracks$pl extends Translations$audioTracks$en {
	_Translations$audioTracks$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String track({required Object n}) => 'Ścieżka audio ${n}';
}

// Path: videoControls
class _Translations$videoControls$pl extends Translations$videoControls$en {
	_Translations$videoControls$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get audioLabel => 'Audio';
	@override String get subtitlesLabel => 'Napisy';
	@override String get resetToZero => 'Zresetuj do 0 ms';
	@override String addTime({required Object amount, required Object unit}) => '+${amount}${unit}';
	@override String minusTime({required Object amount, required Object unit}) => '-${amount}${unit}';
	@override String playsLater({required Object label}) => '${label}: później';
	@override String playsEarlier({required Object label}) => '${label}: wcześniej';
	@override String get noOffset => 'Bez przesunięcia';
	@override String get letterbox => 'Pasy wokół obrazu';
	@override String get fillScreen => 'Wypełnij ekran';
	@override String get stretch => 'Rozciągnij';
	@override String get lockRotation => 'Zablokuj obrót';
	@override String get unlockRotation => 'Odblokuj obrót';
	@override String get timerActive => 'Wyłącznik aktywny';
	@override String playbackWillPauseIn({required Object duration}) => 'Odtwarzanie zatrzyma się za ${duration}';
	@override String get sleepTimerEndOfVideo => 'Koniec bieżącego wideo';
	@override String get sleepTimerStopAtHeader => 'Zatrzymaj o';
	@override String get sleepTimerDurationHeader => 'Minutnik';
	@override String get playbackWillPauseAtEnd => 'Odtwarzanie zatrzyma się na końcu tego wideo';
	@override String get stillWatching => 'Nadal oglądasz?';
	@override String pausingIn({required Object seconds}) => 'Pauza za ${seconds}s';
	@override String get continueWatching => 'Kontynuuj';
	@override String get autoPlayNext => 'Automatycznie odtwórz następny';
	@override String get playNext => 'Odtwórz następny';
	@override String get playButton => 'Odtwórz';
	@override String get pauseButton => 'Pauza';
	@override String get showPlaybackControls => 'Pokaż elementy sterujące odtwarzaniem';
	@override String get hidePlaybackControls => 'Ukryj elementy sterujące odtwarzaniem';
	@override String seekBackwardButton({required Object seconds}) => 'Przewiń do tyłu o ${seconds} sekund';
	@override String seekForwardButton({required Object seconds}) => 'Przewiń do przodu o ${seconds} sekund';
	@override String get previousButton => 'Poprzedni odcinek';
	@override String get nextButton => 'Następny odcinek';
	@override String get previousChapterButton => 'Poprzedni rozdział';
	@override String get nextChapterButton => 'Następny rozdział';
	@override String get muteButton => 'Wycisz';
	@override String get unmuteButton => 'Wyłącz wyciszenie';
	@override String get settingsButton => 'Ustawienia odtwarzania';
	@override String get tracksButton => 'Audio i napisy';
	@override String get chaptersButton => 'Rozdziały';
	@override String get versionQualityButton => 'Wersja i jakość';
	@override String get versionColumnHeader => 'Wersja';
	@override String get qualityColumnHeader => 'Jakość';
	@override String get qualityOriginal => 'Oryginalna';
	@override String qualityPresetLabel({required Object resolution, required Object bitrate}) => '${resolution}p ${bitrate} Mbps';
	@override String get transcodeUnavailableFallback => 'Transkodowanie niedostępne — odtwarzanie w oryginalnej jakości';
	@override String get subtitleUnavailableFallback => 'Nie udało się wczytać wybranych napisów — odtwarzanie jest kontynuowane bez napisów';
	@override String get pipButton => 'Tryb obraz w obrazie';
	@override String get aspectRatioButton => 'Proporcje';
	@override String get ambientLighting => 'Oświetlenie otoczenia';
	@override String get rotationLockButton => 'Blokada obrotu';
	@override String get lockScreen => 'Zablokuj ekran';
	@override String get screenLockButton => 'Blokada ekranu';
	@override String get longPressToUnlock => 'Przytrzymaj, aby odblokować';
	@override String get timelineSlider => 'Oś czasu wideo';
	@override String get volumeSlider => 'Poziom głośności';
	@override String endsAt({required Object time}) => 'Kończy się o ${time}';
	@override String get pipActive => 'Odtwarzanie w trybie obraz w obrazie';
	@override String get pipFailed => 'Nie udało się uruchomić trybu obraz w obrazie';
	@override String get screenshotSaved => 'Zrzut ekranu zapisany';
	@override String zoomPercent({required Object percent}) => 'Powiększenie ${percent}%';
	@override late final _Translations$videoControls$pipErrors$pl pipErrors = _Translations$videoControls$pipErrors$pl._(_root);
	@override String get chapters => 'Rozdziały';
	@override String get noChaptersAvailable => 'Brak dostępnych rozdziałów';
	@override String get queue => 'Kolejka';
	@override String get noQueueItems => 'Brak elementów w kolejce';
}

// Path: messages
class _Translations$messages$pl extends Translations$messages$en {
	_Translations$messages$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get markedAsWatched => 'Oznaczono jako obejrzane';
	@override String get markedAsUnwatched => 'Oznaczono jako nieobejrzane';
	@override String get markedAsWatchedOffline => 'Oznaczono jako obejrzane (zsynchronizuje się po połączeniu)';
	@override String get markedAsUnwatchedOffline => 'Oznaczono jako nieobejrzane (zsynchronizuje się po połączeniu)';
	@override String autoRemovedWatchedDownload({required Object title}) => 'Automatycznie usunięto: ${title}';
	@override String autoRemovedWatchedDownloads({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(n,
		one: 'Automatycznie usunięto ${n} obejrzane pobranie',
		few: 'Automatycznie usunięto ${n} obejrzane pobrania',
		many: 'Automatycznie usunięto ${n} obejrzanych pobrań',
		other: 'Automatycznie usunięto ${n} obejrzanego pobrania',
	);
	@override String get removedFromContinueWatching => 'Usunięto z kontynuowania oglądania';
	@override String errorLoading({required Object error}) => 'Błąd: ${error}';
	@override String get streamInterrupted => 'Strumień został przerwany. Naciśnij odtwarzanie lub przewiń, aby spróbować ponownie.';
	@override String get fileInfoNotAvailable => 'Informacje o pliku niedostępne';
	@override String get playbackAuthenticationRequired => 'Zaloguj się ponownie na serwerze multimediów, aby odtworzyć ten element.';
	@override String get playbackServerUnavailable => 'Serwer multimediów jest niedostępny. Spróbuj ponownie później.';
	@override String get playbackDataInvalid => 'Serwer zwrócił nieprawidłowe informacje o odtwarzaniu.';
	@override String get playbackCancelled => 'Odtwarzanie zostało anulowane.';
	@override String get playbackFailed => 'Nie udało się rozpocząć odtwarzania.';
	@override String errorLoadingFileInfo({required Object error}) => 'Błąd ładowania informacji o pliku: ${error}';
	@override String get errorLoadingSeries => 'Błąd ładowania serialu';
	@override String get musicNotSupported => 'Odtwarzanie muzyki nie jest jeszcze obsługiwane';
	@override String get noDescriptionAvailable => 'Brak dostępnego opisu';
	@override String get noProfilesAvailable => 'Brak dostępnych profili';
	@override String get contactAdminForProfiles => 'Skontaktuj się z administratorem serwera, aby dodać profile';
	@override String get unableToDetermineLibrarySection => 'Nie można określić sekcji biblioteki dla tego elementu';
	@override String get logsCleared => 'Logi wyczyszczone';
	@override String get logsCopied => 'Logi skopiowane do schowka';
	@override String get noLogsAvailable => 'Brak dostępnych logów';
	@override String metadataRefreshing({required Object title}) => 'Odświeżanie metadanych "${title}"...';
	@override String metadataRefreshStarted({required Object title}) => 'Rozpoczęto odświeżanie metadanych "${title}"';
	@override String metadataRefreshFailed({required Object error}) => 'Nie udało się odświeżyć metadanych: ${error}';
	@override String get logoutConfirm => 'Czy na pewno chcesz się wylogować?';
	@override String get noSeasonsFound => 'Nie znaleziono sezonów';
	@override String get seasonsLoadFailed => 'Nie udało się załadować sezonów';
	@override String get noEpisodesFound => 'Nie znaleziono odcinków w pierwszym sezonie';
	@override String get noEpisodesFoundGeneral => 'Nie znaleziono odcinków';
	@override String get episodesLoadFailed => 'Nie udało się załadować odcinków';
	@override String get noResultsFound => 'Nie znaleziono wyników';
	@override String sleepTimerSet({required Object label}) => 'Wyłącznik czasowy ustawiony na ${label}';
	@override String get noItemsAvailable => 'Brak dostępnych elementów';
	@override String get failedToCreatePlayQueueNoItems => 'Nie udało się utworzyć kolejki odtwarzania — brak elementów';
	@override String failedPlayback({required Object action, required Object error}) => 'Nie udało się ${action}: ${error}';
	@override String get switchingToCompatiblePlayer => 'Przełączanie na kompatybilny odtwarzacz...';
	@override String get serverLimitTitle => 'Odtwarzanie nie powiodło się';
	@override String get serverLimitBody => 'Błąd serwera (HTTP 500). Limit przepustowości/transkodowania prawdopodobnie odrzucił tę sesję. Poproś właściciela o zmianę.';
	@override String get logsUploaded => 'Logi przesłane';
	@override String get logsUploadFailed => 'Nie udało się przesłać logów';
	@override String get logId => 'ID logu';
}

// Path: subtitlingStyling
class _Translations$subtitlingStyling$pl extends Translations$subtitlingStyling$en {
	_Translations$subtitlingStyling$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get text => 'Tekst';
	@override String get border => 'Obramowanie';
	@override String get background => 'Tło';
	@override String get fontSize => 'Rozmiar czcionki';
	@override String get textColor => 'Kolor tekstu';
	@override String get borderSize => 'Rozmiar obramowania';
	@override String get borderColor => 'Kolor obramowania';
	@override String get backgroundOpacity => 'Przezroczystość tła';
	@override String get backgroundColor => 'Kolor tła';
	@override String get position => 'Pozycja';
	@override String get assOverride => 'Nadpisywanie ASS';
	@override String get overrideScale => 'Skaluj';
	@override String get overrideForce => 'Wymuś';
	@override String get overrideStrip => 'Usuń style';
	@override String get positionTop => 'Góra';
	@override String get positionBottom => 'Dół';
	@override String get bold => 'Pogrubienie';
	@override String get italic => 'Kursywa';
	@override String get renderResolution => 'Rozdzielczość renderowania';
	@override String get renderResolutionScreen => 'Rozdzielczość ekranu';
	@override String get renderResolutionVideo => 'Rozdzielczość wideo';
}

// Path: mpvConfig
class _Translations$mpvConfig$pl extends Translations$mpvConfig$en {
	_Translations$mpvConfig$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'mpv.conf';
	@override String get description => 'Zaawansowane ustawienia odtwarzacza wideo';
	@override String get presets => 'Ustawienia wstępne';
	@override String get noPresets => 'Brak zapisanych ustawień wstępnych';
	@override String get saveAsPreset => 'Zapisz jako ustawienie wstępne...';
	@override String get presetName => 'Nazwa ustawienia wstępnego';
	@override String get presetNameHint => 'Wprowadź nazwę tego ustawienia wstępnego';
	@override String get loadPreset => 'Wczytaj';
	@override String get deletePreset => 'Usuń';
	@override String get presetSaved => 'Zapisano ustawienie wstępne';
	@override String get presetLoaded => 'Wczytano ustawienie wstępne';
	@override String get presetDeleted => 'Usunięto ustawienie wstępne';
	@override String get confirmDeletePreset => 'Czy na pewno chcesz usunąć to ustawienie wstępne?';
	@override String get configPlaceholder => 'gpu-api=vulkan\nhwdec=auto\n# comment';
}

// Path: dialog
class _Translations$dialog$pl extends Translations$dialog$en {
	_Translations$dialog$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get confirmAction => 'Potwierdź działanie';
}

// Path: profiles
class _Translations$profiles$pl extends Translations$profiles$en {
	_Translations$profiles$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get addPlezyProfile => 'Dodaj profil Plezy';
	@override String get switchingProfile => 'Przełączanie profilu…';
	@override String get deleteThisProfileTitle => 'Usunąć ten profil?';
	@override String deleteThisProfileMessage({required Object displayName}) => 'Usuń ${displayName}. Połączenia nie zostaną zmienione.';
	@override String get active => 'Aktywny';
	@override String get manage => 'Zarządzaj';
	@override String get delete => 'Usuń';
	@override String get sectionTitle => 'Profile';
	@override String get summarySingle => 'Dodaj profile, aby łączyć użytkowników zarządzanych z profilami lokalnymi';
	@override String summaryMultipleWithActive({required Object count, required Object activeName}) => 'Liczba profili: ${count} · aktywny: ${activeName}';
	@override String summaryMultiple({required Object count}) => 'Liczba profili: ${count}';
	@override String get removeConnectionTitle => 'Usunąć połączenie?';
	@override String removeConnectionMessage({required Object displayName, required Object connectionLabel}) => 'Usuń dostęp ${displayName} do ${connectionLabel}. Inne profile go zachowają.';
	@override String get deleteProfileTitle => 'Usunąć profil?';
	@override String deleteProfileMessage({required Object displayName}) => 'Usuń ${displayName} i jego połączenia. Serwery pozostaną dostępne.';
	@override String get profileNameLabel => 'Nazwa profilu';
	@override String get pinProtectionLabel => 'Ochrona PIN-em';
	@override String get setPin => 'Ustaw PIN';
	@override String get setPinTitle => 'Ustaw PIN';
	@override String get confirmPinTitle => 'Potwierdź PIN';
	@override String get pinSet => 'PIN ustawiony';
	@override String get changePin => 'Zmień';
	@override String get removePin => 'Usuń';
	@override String get connectionsLabel => 'Połączenia';
	@override String get add => 'Dodaj';
	@override String get deleteProfileButton => 'Usuń profil';
	@override String get noConnectionsHint => 'Brak połączeń — dodaj jedno, aby używać tego profilu.';
	@override String get noConnections => 'Brak połączeń';
	@override String get connectionDefault => 'Domyślne';
	@override String get makeDefault => 'Ustaw jako domyślne';
	@override String get removeConnection => 'Usuń';
	@override String get profileRenamed => 'Zmieniono nazwę profilu.';
	@override String borrowAddTo({required Object displayName}) => 'Dodaj do ${displayName}';
	@override String get borrowExplain => 'Skorzystaj z połączenia innego profilu. Profile chronione PIN-em wymagają podania PIN-u.';
	@override String get borrowEmpty => 'Nie ma jeszcze żadnych dostępnych połączeń.';
	@override String get borrowEmptySubtitle => 'Najpierw połącz Plex lub Jellyfin z innym profilem.';
	@override String get borrowLoadFailed => 'Nie udało się wczytać dostępnych połączeń. Spróbuj ponownie.';
	@override String borrowFromProfile({required Object displayName}) => 'Z profilu ${displayName}';
	@override String get borrowConnectionBorrowed => 'Dodano połączenie z innego profilu.';
	@override String get borrowFailed => 'Nie udało się dodać połączenia z innego profilu.';
	@override String get incorrectPin => 'Nieprawidłowy PIN.';
	@override String get incorrectPinTryAgain => 'Nieprawidłowy PIN. Spróbuj ponownie.';
	@override String get newProfile => 'Nowy profil';
	@override String get profileNameHint => 'np. Goście, Dzieci, Salon';
	@override String get pinProtectionOptional => 'Ochrona PIN-em (opcjonalnie)';
	@override String get pinExplain => 'Do przełączania profili wymagany jest 4-cyfrowy PIN.';
	@override String get continueButton => 'Kontynuuj';
	@override String get pinsDontMatch => 'PIN-y nie pasują';
}

// Path: connections
class _Translations$connections$pl extends Translations$connections$en {
	_Translations$connections$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get sectionTitle => 'Połączenia';
	@override String get addConnection => 'Dodaj połączenie';
	@override String get addConnectionSubtitleNoProfile => 'Zaloguj się przez Plex lub połącz serwer Jellyfin';
	@override String addConnectionSubtitleScoped({required Object displayName}) => 'Dodaj do ${displayName}: Plex, Jellyfin lub połączenie innego profilu';
	@override String sessionExpiredOne({required Object name}) => 'Sesja wygasła dla ${name}';
	@override String sessionExpiredMany({required Object count}) => 'Sesja wygasła dla ${count} serwerów';
	@override String get signInAgain => 'Zaloguj się ponownie';
	@override String get editJellyfinTitle => 'Edytuj połączenie Jellyfin';
	@override String editJellyfinIntro({required Object serverName}) => 'Dodaj lub usuń adresy URL dla ${serverName}. Plezy użyje osiągalnego URL-a o najniższym opóźnieniu.';
}

// Path: discover
class _Translations$discover$pl extends Translations$discover$en {
	_Translations$discover$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Odkryj';
	@override String get noContentAvailable => 'Brak dostępnych treści';
	@override String get addMediaToLibraries => 'Dodaj multimedia do swoich bibliotek';
	@override String get continueWatching => 'Kontynuuj oglądanie';
	@override String continueWatchingIn({required Object library}) => 'Kontynuuj oglądanie w ${library}';
	@override String get nextUp => 'Następny odcinek';
	@override String nextUpIn({required Object library}) => 'Następny odcinek w ${library}';
	@override String get recentlyAdded => 'Ostatnio dodane';
	@override String recentlyAddedIn({required Object library}) => 'Ostatnio dodane w ${library}';
	@override String latestAlbumsIn({required Object library}) => 'Najnowsze albumy w ${library}';
	@override String recentlyPlayedIn({required Object library}) => 'Ostatnio odtwarzane w ${library}';
	@override String mostPlayedIn({required Object library}) => 'Najczęściej odtwarzane w ${library}';
	@override String playEpisode({required Object season, required Object episode}) => 'S${season}E${episode}';
	@override String get cast => 'Obsada';
	@override String get extras => 'Zwiastuny i dodatki';
	@override String get studio => 'Studio';
	@override String get director => 'Reżyser';
	@override String get directors => 'Reżyserzy';
	@override String get movie => 'Film';
	@override String get tvShow => 'Serial TV';
	@override String minutesLeft({required Object minutes}) => 'Pozostało ${minutes} min';
	@override String get moreLikeThis => 'Więcej podobnych';
}

// Path: errors
class _Translations$errors$pl extends Translations$errors$en {
	_Translations$errors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String searchFailed({required Object error}) => 'Wyszukiwanie nie powiodło się: ${error}';
	@override String connectionTimeout({required Object context}) => 'Limit czasu połączenia przy ładowaniu ${context}';
	@override String get connectionFailed => 'Nie można połączyć się z serwerem multimediów';
	@override String unableToLoad({required Object context}) => 'Nie udało się załadować ${context}. Spróbuj ponownie.';
	@override String get noClientAvailable => 'Brak dostępnego klienta';
	@override String failedToSwitchProfile({required Object displayName}) => 'Nie udało się przełączyć na ${displayName}';
	@override String failedToDeleteProfile({required Object displayName}) => 'Nie udało się usunąć ${displayName}';
	@override String get failedToRate => 'Nie udało się zaktualizować oceny';
}

// Path: libraries
class _Translations$libraries$pl extends Translations$libraries$en {
	_Translations$libraries$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Biblioteki';
	@override String get fallbackTitle => 'Biblioteka';
	@override String get refreshMetadata => 'Odśwież metadane';
	@override String get noLibrariesFound => 'Nie znaleziono bibliotek';
	@override String get allLibrariesHidden => 'Wszystkie biblioteki są ukryte';
	@override String hiddenLibrariesCount({required Object count}) => 'Ukryte biblioteki (${count})';
	@override String get thisLibraryIsEmpty => 'Ta biblioteka jest pusta';
	@override String get noItemsMatchFilters => 'Żaden element nie pasuje do aktywnych filtrów';
	@override String get resetFilters => 'Resetuj filtry';
	@override String get all => 'Wszystkie';
	@override String get clearAll => 'Wyczyść wszystko';
	@override String refreshMetadataConfirm({required Object title}) => 'Czy na pewno chcesz odświeżyć metadane dla "${title}"?';
	@override String get manageLibraries => 'Zarządzaj bibliotekami';
	@override String get sort => 'Sortuj';
	@override String get sortBy => 'Sortuj wg';
	@override String get filters => 'Filtry';
	@override String get confirmActionMessage => 'Czy na pewno chcesz wykonać tę operację?';
	@override String get showLibrary => 'Pokaż bibliotekę';
	@override String get hideLibrary => 'Ukryj bibliotekę';
	@override String get libraryOptions => 'Opcje biblioteki';
	@override String get content => 'zawartość biblioteki';
	@override String get selectLibrary => 'Wybierz bibliotekę';
	@override String filtersWithCount({required Object count}) => 'Filtry (${count})';
	@override String get noRecommendations => 'Brak dostępnych rekomendacji';
	@override String get noCollections => 'Brak kolekcji w tej bibliotece';
	@override String get noFoldersFound => 'Nie znaleziono folderów';
	@override String get folders => 'foldery';
	@override late final _Translations$libraries$tabs$pl tabs = _Translations$libraries$tabs$pl._(_root);
	@override late final _Translations$libraries$groupings$pl groupings = _Translations$libraries$groupings$pl._(_root);
	@override late final _Translations$libraries$filterCategories$pl filterCategories = _Translations$libraries$filterCategories$pl._(_root);
	@override late final _Translations$libraries$sortLabels$pl sortLabels = _Translations$libraries$sortLabels$pl._(_root);
}

// Path: about
class _Translations$about$pl extends Translations$about$en {
	_Translations$about$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'O aplikacji';
	@override String get openSourceLicenses => 'Licencje oprogramowania open source';
	@override String versionLabel({required Object version}) => 'Wersja ${version}';
	@override String get appDescription => 'Piękny klient Plex i Jellyfin stworzony we Flutterze';
	@override String get viewLicensesDescription => 'Wyświetl licencje bibliotek innych firm';
}

// Path: hubDetail
class _Translations$hubDetail$pl extends Translations$hubDetail$en {
	_Translations$hubDetail$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tytuł';
	@override String get releaseYear => 'Rok premiery';
	@override String get dateAdded => 'Data dodania';
	@override String get rating => 'Ocena';
	@override String get noItemsFound => 'Nie znaleziono elementów';
}

// Path: logs
class _Translations$logs$pl extends Translations$logs$en {
	_Translations$logs$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get clearLogs => 'Wyczyść logi';
	@override String get copyLogs => 'Kopiuj logi';
	@override String get uploadLogs => 'Prześlij logi';
}

// Path: licenses
class _Translations$licenses$pl extends Translations$licenses$en {
	_Translations$licenses$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get relatedPackages => 'Powiązane pakiety';
	@override String get license => 'Licencja';
	@override String licenseNumber({required Object number}) => 'Licencja ${number}';
	@override String licensesCount({required Object count}) => 'Liczba licencji: ${count}';
}

// Path: navigation
class _Translations$navigation$pl extends Translations$navigation$en {
	_Translations$navigation$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get libraries => 'Biblioteki';
	@override String get downloads => 'Pobrania';
	@override String get explore => 'Przeglądaj';
}

// Path: explore
class _Translations$explore$pl extends Translations$explore$en {
	_Translations$explore$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Przeglądaj';
	@override String get selectSource => 'Wybierz źródło';
	@override late final _Translations$explore$rows$pl rows = _Translations$explore$rows$pl._(_root);
	@override late final _Translations$explore$status$pl status = _Translations$explore$status$pl._(_root);
	@override String episodeCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(n,
		one: '${n} odcinek',
		few: '${n} odcinki',
		many: '${n} odcinków',
		other: '${n} odcinka',
	);
	@override String get cast => 'Obsada';
	@override String get characters => 'Postacie';
	@override String get addToWatchlist => 'Dodaj do listy do obejrzenia';
	@override String get removeFromWatchlist => 'Usuń z listy do obejrzenia';
	@override String get watchlistUpdateFailed => 'Nie udało się zaktualizować listy do obejrzenia';
	@override String get notInLibrary => 'Nie ma tego w Twojej bibliotece';
	@override String get inTheseLibraries => 'W tych bibliotekach';
	@override String get checkingLibrary => 'Sprawdzanie Twojej biblioteki...';
	@override String get emptyTitle => 'Jeszcze nic tu nie ma';
	@override String emptyMessage({required Object source}) => 'Wiersze z ${source} pojawią się tutaj, gdy będą zawierać treści.';
	@override String searchHint({required Object source}) => 'Szukaj w ${source}';
	@override String searchEmpty({required Object query}) => 'Brak wyników dla "${query}"';
	@override String searchPrompt({required Object source}) => 'Szukaj filmów i seriali w ${source}.';
	@override String get searchFailed => 'Wyszukiwanie nie powiodło się. Sprawdź połączenie i spróbuj ponownie.';
}

// Path: collections
class _Translations$collections$pl extends Translations$collections$en {
	_Translations$collections$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kolekcje';
	@override String get collection => 'Kolekcja';
	@override String get empty => 'Kolekcja jest pusta';
	@override String get deleteCollection => 'Usuń kolekcję';
	@override String deleteConfirm({required Object title}) => 'Usunąć "${title}"? Tego nie można cofnąć.';
	@override String get deleted => 'Kolekcja usunięta';
	@override String get deleteFailed => 'Nie udało się usunąć kolekcji';
	@override String deleteFailedWithError({required Object error}) => 'Nie udało się usunąć kolekcji: ${error}';
	@override String get selectCollection => 'Wybierz kolekcję';
	@override String get collectionName => 'Nazwa kolekcji';
	@override String get enterCollectionName => 'Wprowadź nazwę kolekcji';
	@override String get addedToCollection => 'Dodano do kolekcji';
	@override String get errorAddingToCollection => 'Nie udało się dodać do kolekcji';
	@override String get created => 'Kolekcja utworzona';
	@override String get removeFromCollection => 'Usuń z kolekcji';
	@override String removeFromCollectionConfirm({required Object title}) => 'Usunąć "${title}" z tej kolekcji?';
	@override String get removedFromCollection => 'Usunięto z kolekcji';
	@override String get removeFromCollectionFailed => 'Nie udało się usunąć z kolekcji';
	@override String removeFromCollectionError({required Object error}) => 'Błąd usuwania z kolekcji: ${error}';
	@override String get searchCollections => 'Szukaj kolekcji...';
}

// Path: playlists
class _Translations$playlists$pl extends Translations$playlists$en {
	_Translations$playlists$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Playlisty';
	@override String get playlist => 'Playlista';
	@override String get noPlaylists => 'Nie znaleziono playlist';
	@override String get create => 'Utwórz playlistę';
	@override String get playlistName => 'Nazwa playlisty';
	@override String get enterPlaylistName => 'Wprowadź nazwę playlisty';
	@override String get delete => 'Usuń playlistę';
	@override String get removeItem => 'Usuń z playlisty';
	@override String get smartPlaylist => 'Inteligentna playlista';
	@override String itemCount({required Object count}) => '${count} elementów';
	@override String get oneItem => '1 element';
	@override String get emptyPlaylist => 'Ta playlista jest pusta';
	@override String get deleteConfirm => 'Usunąć playlistę?';
	@override String deleteMessage({required Object name}) => 'Czy na pewno chcesz usunąć "${name}"?';
	@override String get created => 'Playlista utworzona';
	@override String get deleted => 'Playlista usunięta';
	@override String get itemAdded => 'Dodano do playlisty';
	@override String get itemRemoved => 'Usunięto z playlisty';
	@override String get selectPlaylist => 'Wybierz playlistę';
	@override String get searchPlaylists => 'Szukaj playlist...';
	@override String get errorCreating => 'Nie udało się utworzyć playlisty';
	@override String get errorDeleting => 'Nie udało się usunąć playlisty';
	@override String get errorLoading => 'Nie udało się załadować playlist';
	@override String get errorAdding => 'Nie udało się dodać do playlisty';
	@override String get errorReordering => 'Nie udało się zmienić kolejności elementu playlisty';
	@override String get errorRemoving => 'Nie udało się usunąć z playlisty';
}

// Path: music
class _Translations$music$pl extends Translations$music$en {
	_Translations$music$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get goToAlbum => 'Przejdź do albumu';
	@override String get goToArtist => 'Przejdź do wykonawcy';
	@override String get instantMix => 'Miks błyskawiczny';
	@override String get playNext => 'Odtwórz następny';
	@override String get addToQueue => 'Dodaj do kolejki';
	@override String discNumber({required Object n}) => 'Płyta ${n}';
	@override String trackCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(n,
		one: '${n} utwór',
		few: '${n} utwory',
		many: '${n} utworów',
		other: '${n} utworu',
	);
	@override String get nowPlaying => 'Teraz odtwarzane';
	@override String playingFrom({required Object title}) => 'Odtwarzanie z ${title}';
	@override String get queue => 'Kolejka';
	@override String get clearQueue => 'Wyczyść kolejkę';
	@override String get lyrics => 'Tekst utworu';
	@override String get noLyrics => 'Brak tekstu utworu';
	@override String get sleepTimer => 'Wyłącznik czasowy';
	@override String get sleepTimerEndOfTrack => 'Koniec utworu';
	@override String sleepTimerMinutes({required Object n}) => '${n} minut';
	@override String get stopPlayback => 'Zatrzymaj odtwarzanie';
	@override String get previousTrack => 'Poprzedni utwór';
	@override String get nextTrack => 'Następny utwór';
	@override String get repeat => 'Powtarzaj';
	@override String get repeatAll => 'Powtarzaj wszystko';
	@override String get repeatOne => 'Powtarzaj jeden';
}

// Path: downloads
class _Translations$downloads$pl extends Translations$downloads$en {
	_Translations$downloads$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Pobrania';
	@override String get manage => 'Zarządzaj';
	@override String get tvShows => 'Seriale TV';
	@override String get movies => 'Filmy';
	@override String get music => 'Muzyka';
	@override String tracksQueued({required Object count}) => '${count} utworów w kolejce do pobrania';
	@override String get noDownloads => 'Brak pobrań';
	@override String get noDownloadsDescription => 'Pobrane treści pojawią się tutaj do oglądania offline';
	@override String get downloadNow => 'Pobierz';
	@override String get deleteDownload => 'Usuń pobranie';
	@override String get retryDownload => 'Ponów pobieranie';
	@override String get downloadQueued => 'Pobranie w kolejce';
	@override String get downloadResumed => 'Pobieranie wznowione';
	@override String get serverErrorBitrate => 'Błąd serwera: plik może przekraczać zdalny limit bitrate';
	@override String get storageFull => 'Pobieranie zostało zatrzymane, ponieważ pamięć urządzenia jest pełna. Zwolnij miejsce i spróbuj ponownie.';
	@override String episodesQueued({required Object count}) => '${count} odcinków w kolejce pobierania';
	@override String get downloadDeleted => 'Pobranie usunięte';
	@override String deleteConfirm({required Object title}) => 'Usunąć "${title}" z tego urządzenia?';
	@override String get cancelledDownloadTitle => 'Anulowane pobieranie';
	@override String get cancelledDownloadMessage => 'To pobieranie zostało anulowane. Co chcesz zrobić?';
	@override String get allEpisodesAlreadyDownloaded => 'Wszystkie odcinki są już pobrane';
	@override String get resumeDownload => 'Wznów pobieranie';
	@override String get cancelledDownload => 'Anulowane pobieranie';
	@override String syncingFile({required Object file, required Object status}) => '${file} (synchronizowanie ${status})';
	@override String downloadedFileClickToComplete({required Object file}) => 'Pobrano ${file} — kliknij, aby dokończyć';
	@override String get partialDownloadClickToComplete => 'Pobrano częściowo — kliknij, aby dokończyć';
	@override String get deleting => 'Usuwanie...';
	@override String deletingWithProgress({required Object title, required Object current, required Object total}) => 'Usuwanie ${title}... (${current} z ${total})';
	@override String get queuedTooltip => 'W kolejce';
	@override String queuedFilesTooltip({required Object files}) => 'W kolejce: ${files}';
	@override String get downloadingTooltip => 'Pobieranie...';
	@override String downloadingFilesTooltip({required Object files}) => 'Pobieranie ${files}';
	@override String get noDownloadsTree => 'Brak pobrań';
	@override String get pauseAll => 'Wstrzymaj wszystko';
	@override String get resumeAll => 'Wznów wszystko';
	@override String get deleteAll => 'Usuń wszystko';
	@override String get selectVersion => 'Wybierz wersję';
	@override String get allEpisodes => 'Wszystkie odcinki';
	@override String get unwatchedOnly => 'Tylko nieobejrzane';
	@override String nextNUnwatched({required Object count}) => 'Następne ${count} nieobejrzanych';
	@override String get customAmount => 'Własna liczba...';
	@override String get includeSpecials => 'Uwzględnij odcinki specjalne';
	@override String get howManyEpisodes => 'Ile odcinków?';
	@override String get invalidEpisodeCount => 'Wprowadź prawidłową liczbę odcinków.';
	@override String get keepSynced => 'Synchronizuj na bieżąco';
	@override String get downloadOnce => 'Pobierz raz';
	@override String keepNUnwatched({required Object count}) => 'Zachowaj ${count} nieobejrzanych';
	@override String get editSyncRule => 'Edytuj regułę synchronizacji';
	@override String get removeSyncRule => 'Usuń regułę synchronizacji';
	@override String removeSyncRuleConfirm({required Object title}) => 'Zatrzymać synchronizację "${title}"? Pobrane odcinki zostaną zachowane.';
	@override String syncRuleCreated({required Object count}) => 'Reguła synchronizacji utworzona — zachowywanie ${count} nieobejrzanych odcinków';
	@override String get syncRuleUpdated => 'Reguła synchronizacji zaktualizowana';
	@override String get syncRuleRemoved => 'Reguła synchronizacji usunięta';
	@override String syncedNewEpisodes({required Object count, required Object title}) => 'Zsynchronizowano ${count} nowych odcinków dla ${title}';
	@override String get activeSyncRules => 'Reguły synchronizacji';
	@override String get noSyncRules => 'Brak reguł synchronizacji';
	@override String get manageSyncRule => 'Zarządzaj synchronizacją';
	@override String get editEpisodeCount => 'Liczba odcinków';
	@override String get editSyncFilter => 'Filtr synchronizacji';
	@override String get syncAllItems => 'Synchronizacja wszystkich elementów';
	@override String get syncUnwatchedItems => 'Synchronizacja nieobejrzanych elementów';
	@override String syncRuleServerContext({required Object server, required Object status}) => 'Serwer: ${server} • ${status}';
	@override String get syncRuleAvailable => 'Dostępne';
	@override String get syncRuleOffline => 'Brak połączenia';
	@override String get syncRuleSignInRequired => 'Wymagane logowanie';
	@override String get syncRuleNotAvailableForProfile => 'Niedostępne dla bieżącego profilu';
	@override String get syncRuleUnknownServer => 'Nieznany serwer';
	@override String get syncRuleListCreated => 'Utworzono regułę synchronizacji';
	@override late final _Translations$downloads$backgroundWarning$pl backgroundWarning = _Translations$downloads$backgroundWarning$pl._(_root);
}

// Path: shaders
class _Translations$shaders$pl extends Translations$shaders$en {
	_Translations$shaders$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Shadery';
	@override String get noShaderDescription => 'Bez ulepszenia wideo';
	@override String get nvscalerDescription => 'Skalowanie obrazu NVIDIA dla ostrzejszego wideo';
	@override String get artcnnVariantNeutral => 'Neutralny';
	@override String get artcnnVariantDenoise => 'Odszumianie';
	@override String get artcnnVariantDenoiseSharpen => 'Odszumianie + wyostrzanie';
	@override String get qualityFast => 'Szybki';
	@override String get qualityHQ => 'Wysoka jakość';
	@override String get mode => 'Tryb';
	@override String get importShader => 'Importuj shader';
	@override String get customShaderDescription => 'Niestandardowy shader GLSL';
	@override String get shaderImported => 'Shader zaimportowany';
	@override String get shaderImportFailed => 'Nie udało się zaimportować shadera';
	@override String get deleteShader => 'Usuń shader';
	@override String deleteShaderConfirm({required Object name}) => 'Usunąć "${name}"?';
}

// Path: videoSettings
class _Translations$videoSettings$pl extends Translations$videoSettings$en {
	_Translations$videoSettings$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get playbackSpeed => 'Prędkość odtwarzania';
	@override String get normalSpeed => 'Normalna';
	@override String sleepTimerActive({required Object duration}) => 'Aktywny (${duration})';
	@override String get zoom => 'Powiększenie';
	@override String get sleepTimer => 'Wyłącznik czasowy';
	@override String get audioSync => 'Synchronizacja audio';
	@override String get subtitleSync => 'Synchronizacja napisów';
	@override String get hdr => 'HDR';
	@override String get audioOutput => 'Wyjście audio';
	@override String get performanceOverlay => 'Nakładka wydajności';
	@override String get audioPassthrough => 'Przekazywanie dźwięku';
	@override String get audioOutputDolbyAtmos => 'Dolby Atmos';
	@override String get audioOutputDolbyAudio => 'Dolby Audio';
	@override String get audioOutputSurround => 'Przestrzenny';
	@override String get audioOutputSpatial => 'Dźwięk przestrzenny';
	@override String get audioOutputStereo => 'Stereo';
	@override String get audioNormalization => 'Normalizacja głośności';
	@override String get audioDownmix => 'Miksowanie do stereo';
}

// Path: performanceOverlay
class _Translations$performanceOverlay$pl extends Translations$performanceOverlay$en {
	_Translations$performanceOverlay$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get color => 'Kolor';
	@override String get performance => 'Wydajność';
	@override String get buffer => 'Bufor';
	@override String get app => 'Aplikacja';
	@override String get decoder => 'Dekoder';
	@override String get rawDecoder => 'Surowy dekoder';
	@override String get tunneling => 'Tunelowanie';
	@override String get aspect => 'Proporcje';
	@override String get rotation => 'Obrót';
	@override String get dvSource => 'Źródło DV';
	@override String get dvPath => 'Ścieżka DV';
	@override String get p7Conversion => 'Konw. P7';
	@override String get sampleRate => 'Częstotliwość próbkowania';
	@override String get pixelFormat => 'Format pikseli';
	@override String get hwFormat => 'Format HW';
	@override String get matrix => 'Macierz';
	@override String get primaries => 'Barwy podstawowe';
	@override String get transfer => 'Charakterystyka przenoszenia';
	@override String get renderFps => 'FPS renderowania';
	@override String get displayFps => 'FPS ekranu';
	@override String get avSync => 'Synchronizacja A/V';
	@override String get dropped => 'Pominięte';
	@override String get dvRpus => 'DV RPU';
	@override String get dvRpuAverage => 'Śr. DV RPU';
	@override String get dvSampleAverage => 'Śr. próbki DV';
	@override String get maxLuma => 'Maks. luma';
	@override String get minLuma => 'Min. luma';
	@override String get maxCll => 'MaxCLL';
	@override String get maxFall => 'MaxFALL';
	@override String get cacheUsed => 'Użyta pamięć podręczna';
	@override String get cacheLimit => 'Limit pamięci podręcznej';
	@override String get speed => 'Szybkość';
	@override String get player => 'Odtwarzacz';
	@override String get memory => 'Pamięć';
	@override String get uiFps => 'UI FPS';
}

// Path: externalPlayer
class _Translations$externalPlayer$pl extends Translations$externalPlayer$en {
	_Translations$externalPlayer$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Zewnętrzny odtwarzacz';
	@override String get useExternalPlayer => 'Użyj zewnętrznego odtwarzacza';
	@override String get useExternalPlayerDescription => 'Otwieraj wideo w innej aplikacji';
	@override String get selectPlayer => 'Wybierz odtwarzacz';
	@override String get customPlayers => 'Niestandardowe odtwarzacze';
	@override String get systemDefault => 'Domyślny systemowy';
	@override String get addCustomPlayer => 'Dodaj niestandardowy odtwarzacz';
	@override String get playerName => 'Nazwa odtwarzacza';
	@override String get playerNameHint => 'Mój odtwarzacz';
	@override String get playerCommand => 'Polecenie';
	@override String get playerPackage => 'Nazwa pakietu';
	@override String get playerUrlScheme => 'Schemat URL';
	@override String get off => 'Wyłączony';
	@override String get launchFailed => 'Nie udało się otworzyć zewnętrznego odtwarzacza';
	@override String appNotInstalled({required Object name}) => '${name} nie jest zainstalowany';
	@override String get playInExternalPlayer => 'Odtwórz w zewnętrznym odtwarzaczu';
}

// Path: metadataEdit
class _Translations$metadataEdit$pl extends Translations$metadataEdit$en {
	_Translations$metadataEdit$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get editMetadata => 'Edytuj...';
	@override String get screenTitle => 'Edytuj metadane';
	@override String get basicInfo => 'Podstawowe informacje';
	@override String get artwork => 'Grafika';
	@override String get title => 'Tytuł';
	@override String get sortTitle => 'Tytuł do sortowania';
	@override String get originalTitle => 'Tytuł oryginalny';
	@override String get releaseDate => 'Data premiery';
	@override String get contentRating => 'Klasyfikacja wiekowa';
	@override String get studio => 'Studio';
	@override String get tagline => 'Slogan';
	@override String get summary => 'Opis';
	@override String get poster => 'Plakat';
	@override String get background => 'Tło';
	@override String get logo => 'Logo';
	@override String get squareArt => 'Kwadratowy obraz';
	@override String get selectPoster => 'Wybierz plakat';
	@override String get selectBackground => 'Wybierz tło';
	@override String get selectLogo => 'Wybierz logo';
	@override String get selectSquareArt => 'Wybierz kwadratowy obraz';
	@override String get fromUrl => 'Z URL';
	@override String get uploadFile => 'Prześlij plik';
	@override String get enterImageUrl => 'Wprowadź URL obrazu';
	@override String get imageUrl => 'URL obrazu';
	@override String get metadataUpdated => 'Metadane zaktualizowane';
	@override String get metadataUpdateFailed => 'Nie udało się zaktualizować metadanych';
	@override String get artworkUpdated => 'Grafika zaktualizowana';
	@override String get artworkUpdateFailed => 'Nie udało się zaktualizować grafiki';
	@override String get noArtworkAvailable => 'Brak dostępnej grafiki';
	@override String artworkOption({required Object index}) => 'Opcja grafiki ${index}';
	@override String selectedArtworkOption({required Object index}) => 'Opcja grafiki ${index}, wybrana';
	@override String get notSet => 'Nie ustawiono';
	@override String get tags => 'Tagi';
	@override String get addTag => 'Dodaj tag';
	@override String get genre => 'Gatunek';
	@override String get director => 'Reżyser';
	@override String get writer => 'Scenarzysta';
	@override String get producer => 'Producent';
	@override String get country => 'Kraj';
	@override String get label => 'Etykieta';
}

// Path: trakt
class _Translations$trakt$pl extends Translations$trakt$en {
	_Translations$trakt$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Trakt';
	@override String get connected => 'Połączono';
	@override String connectedAs({required Object username}) => 'Połączono jako @${username}';
	@override String get disconnectConfirm => 'Rozłączyć konto Trakt?';
	@override String get disconnectConfirmBody => 'Plezy przestanie wysyłać zdarzenia do serwisu Trakt. Połączenie można przywrócić w dowolnym momencie.';
	@override String get scrobble => 'Śledzenie odtwarzania w czasie rzeczywistym';
	@override String get scrobbleDescription => 'Wysyłaj do serwisu Trakt zdarzenia odtwarzania, wstrzymania i zatrzymania.';
	@override String get watchedSync => 'Synchronizuj stan obejrzenia';
	@override String get watchedSyncDescription => 'Gdy oznaczysz element jako obejrzany w Plezy, zostanie on również oznaczony jako obejrzany w serwisie Trakt.';
}

// Path: seerr
class _Translations$seerr$pl extends Translations$seerr$en {
	_Translations$seerr$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seerr';
	@override String get connectTitle => 'Połącz Seerr';
	@override String get serverUrl => 'Adres URL serwera';
	@override String get serverUrlHelper => 'Adres Twojej instancji Seerr';
	@override String get checkServer => 'Kontynuuj';
	@override String get signInWithJellyfin => 'Zaloguj się przez Jellyfin';
	@override String get signInWithEmby => 'Zaloguj się przez Emby';
	@override String get signInWithLocal => 'Użyj konta lokalnego';
	@override String get email => 'E-mail';
	@override String get noSignInMethods => 'Ta instancja Seerr nie oferuje metody logowania obsługiwanej przez Plezy.';
	@override String get instance => 'Instancja';
	@override String get disconnectConfirm => 'Odłączyć Seerr?';
	@override String get disconnectConfirmBody => 'Plezy zapomni tę instancję Seerr. Połącz ponownie w dowolnym momencie.';
	@override String get request => 'Zamów';
	@override String get request4k => 'Zamów w 4K';
	@override String get seasons => 'Sezony';
	@override String get allSeasons => 'Wszystkie sezony';
	@override String get advancedOptions => 'Zaawansowane';
	@override String get destinationServer => 'Serwer docelowy';
	@override String get qualityProfile => 'Profil jakości';
	@override String get rootFolder => 'Folder główny';
	@override String get languageProfile => 'Profil językowy';
	@override String get requestSubmitted => 'Zamówienie wysłane';
	@override String requestFailed({required Object error}) => 'Zamówienie nie powiodło się: ${error}';
	@override String get requestsLoadFailed => 'Nie udało się wczytać opcji zamówienia';
	@override String get nothingToRequest => 'Wszystko jest już dostępne lub zamówione.';
	@override String get statusAvailable => 'Dostępne';
	@override String get statusPartiallyAvailable => 'Częściowo dostępne';
	@override String get statusRequested => 'Zamówione';
	@override String get statusProcessing => 'Przetwarzanie';
}

// Path: services
class _Translations$services$pl extends Translations$services$en {
	_Translations$services$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Usługi';
	@override String get hubSubtitle => 'Synchronizuj postęp oglądania i zamawiaj nowe tytuły.';
	@override String get notConnected => 'Nie połączono';
	@override String connectedAs({required Object username}) => 'Połączono jako @${username}';
	@override String get scrobble => 'Automatycznie śledź postęp';
	@override String get scrobbleDescription => 'Aktualizuj swoją listę po ukończeniu odcinka lub filmu.';
	@override String disconnectConfirm({required Object service}) => 'Odłączyć ${service}?';
	@override String disconnectConfirmBody({required Object service}) => 'Plezy przestanie aktualizować ${service}. Połącz ponownie w dowolnym momencie.';
	@override String connectFailed({required Object service}) => 'Nie udało się połączyć z ${service}. Spróbuj ponownie.';
	@override late final _Translations$services$names$pl names = _Translations$services$names$pl._(_root);
	@override late final _Translations$services$deviceCode$pl deviceCode = _Translations$services$deviceCode$pl._(_root);
	@override late final _Translations$services$oauthProxy$pl oauthProxy = _Translations$services$oauthProxy$pl._(_root);
	@override late final _Translations$services$libraryFilter$pl libraryFilter = _Translations$services$libraryFilter$pl._(_root);
}

// Path: addServer
class _Translations$addServer$pl extends Translations$addServer$en {
	_Translations$addServer$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get addJellyfinTitle => 'Dodaj serwer Jellyfin';
	@override String get serverUrls => 'Adresy URL serwera';
	@override String get serverUrlsHelper => 'Można podać wiele adresów URL rozdzielonych przecinkami.';
	@override String get findServer => 'Znajdź serwer';
	@override String get searchingLocalServers => 'Szukanie lokalnych serwerów Jellyfin...';
	@override String get localServers => 'Lokalne serwery Jellyfin';
	@override String get username => 'Nazwa użytkownika';
	@override String get password => 'Hasło';
	@override String get signIn => 'Zaloguj się';
	@override String get change => 'Zmień';
	@override String get required => 'Wymagane';
	@override String couldNotReachServer({required Object error}) => 'Nie udało się połączyć z serwerem: ${error}';
	@override String signInFailed({required Object error}) => 'Logowanie nie powiodło się: ${error}';
	@override String quickConnectFailed({required Object error}) => 'Quick Connect nie powiodło się: ${error}';
	@override String get enterJellyfinUrlError => 'Podaj URL serwera Jellyfin';
	@override String get addConnectionTitle => 'Dodaj połączenie';
	@override String addConnectionTitleScoped({required Object name}) => 'Dodaj do ${name}';
	@override String get connectToJellyfinCard => 'Połącz z Jellyfin';
	@override String get connectToJellyfinCardSubtitle => 'Wpisz URL serwera, nazwę użytkownika i hasło.';
	@override String connectToJellyfinCardSubtitleScoped({required Object name}) => 'Zaloguj się do serwera Jellyfin. Powiązane z ${name}.';
	@override String get borrowFromAnotherProfile => 'Pożycz z innego profilu';
	@override String get borrowFromAnotherProfileSubtitle => 'Użyj połączenia innego profilu. Profile chronione PIN-em wymagają podania PIN-u.';
}

// Path: hotkeys.actions
class _Translations$hotkeys$actions$pl extends Translations$hotkeys$actions$en {
	_Translations$hotkeys$actions$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get playPause => 'Odtwórz/Pauza';
	@override String get volumeUp => 'Głośniej';
	@override String get volumeDown => 'Ciszej';
	@override String seekForward({required Object seconds}) => 'Przewiń do przodu (${seconds}s)';
	@override String seekBackward({required Object seconds}) => 'Przewiń do tyłu (${seconds}s)';
	@override String get fullscreenToggle => 'Pełny ekran';
	@override String get muteToggle => 'Wyciszenie';
	@override String get subtitleToggle => 'Napisy';
	@override String get audioTrackNext => 'Następna ścieżka audio';
	@override String get subtitleTrackNext => 'Następna ścieżka napisów';
	@override String get chapterNext => 'Następny rozdział';
	@override String get chapterPrevious => 'Poprzedni rozdział';
	@override String get episodeNext => 'Następny odcinek';
	@override String get episodePrevious => 'Poprzedni odcinek';
	@override String get speedIncrease => 'Zwiększ prędkość';
	@override String get speedDecrease => 'Zmniejsz prędkość';
	@override String get speedReset => 'Zresetuj prędkość';
	@override String get zoomIn => 'Powiększ';
	@override String get zoomOut => 'Pomniejsz';
	@override String get zoomReset => 'Zresetuj zoom';
	@override String get subSeekNext => 'Przewiń do następnego napisu';
	@override String get subSeekPrev => 'Przewiń do poprzedniego napisu';
	@override String get shaderToggle => 'Przełącz shadery';
	@override String get skipMarker => 'Pomiń intro/napisy końcowe';
	@override String get screenshot => 'Zrób zrzut ekranu';
}

// Path: videoControls.pipErrors
class _Translations$videoControls$pipErrors$pl extends Translations$videoControls$pipErrors$en {
	_Translations$videoControls$pipErrors$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get androidVersion => 'Wymaga Androida 8.0 lub nowszego';
	@override String get iosVersion => 'Wymaga iOS 15.0 lub nowszego';
	@override String get permissionDisabled => 'Obraz w obrazie jest wyłączony. Włącz go w ustawieniach systemu.';
	@override String get notSupported => 'Urządzenie nie obsługuje trybu obraz w obrazie';
	@override String get voSwitchFailed => 'Nie udało się przełączyć wyjścia wideo dla trybu obraz w obrazie';
	@override String get failed => 'Nie udało się uruchomić trybu obraz w obrazie';
	@override String unknown({required Object error}) => 'Wystąpił błąd: ${error}';
}

// Path: libraries.tabs
class _Translations$libraries$tabs$pl extends Translations$libraries$tabs$en {
	_Translations$libraries$tabs$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get recommended => 'Polecane';
	@override String get browse => 'Przeglądaj';
	@override String get collections => 'Kolekcje';
	@override String get playlists => 'Playlisty';
}

// Path: libraries.groupings
class _Translations$libraries$groupings$pl extends Translations$libraries$groupings$en {
	_Translations$libraries$groupings$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Grupowanie';
	@override String get all => 'Wszystkie';
	@override String get movies => 'Filmy';
	@override String get shows => 'Seriale TV';
	@override String get seasons => 'Sezony';
	@override String get episodes => 'Odcinki';
	@override String get artists => 'Wykonawcy';
	@override String get albums => 'Albumy';
	@override String get tracks => 'Utwory';
	@override String get folders => 'Foldery';
}

// Path: libraries.filterCategories
class _Translations$libraries$filterCategories$pl extends Translations$libraries$filterCategories$en {
	_Translations$libraries$filterCategories$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get genre => 'Gatunek';
	@override String get year => 'Rok';
	@override String get contentRating => 'Klasyfikacja wiekowa';
	@override String get tag => 'Tag';
	@override String get unwatched => 'Nieobejrzane';
	@override String get unplayed => 'Nieodtworzone';
	@override String get favorites => 'Ulubione';
}

// Path: libraries.sortLabels
class _Translations$libraries$sortLabels$pl extends Translations$libraries$sortLabels$en {
	_Translations$libraries$sortLabels$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tytuł';
	@override String get dateAdded => 'Data dodania';
	@override String get communityRating => 'Ocena społeczności';
	@override String get criticRating => 'Ocena krytyków';
	@override String get datePlayed => 'Data odtworzenia';
	@override String get playCount => 'Liczba odtworzeń';
	@override String get productionYear => 'Rok produkcji';
	@override String get runtime => 'Czas trwania';
	@override String get officialRating => 'Oficjalna klasyfikacja';
	@override String get premiereDate => 'Data premiery';
	@override String get startDate => 'Data rozpoczęcia';
	@override String get airTime => 'Godzina emisji';
	@override String get studio => 'Studio';
	@override String get random => 'Losowo';
	@override String get lastEpisodeDateAdded => 'Data dodania ostatniego odcinka';
}

// Path: explore.rows
class _Translations$explore$rows$pl extends Translations$explore$rows$en {
	_Translations$explore$rows$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get watchlist => 'Lista do obejrzenia';
	@override String get recommendedMovies => 'Rekomendowane filmy';
	@override String get recommendedShows => 'Rekomendowane seriale';
	@override String get trendingMovies => 'Filmy na czasie';
	@override String get trendingShows => 'Seriale na czasie';
	@override String get popularMovies => 'Popularne filmy';
	@override String get popularShows => 'Popularne seriale';
	@override String get trendingAnime => 'Anime na czasie';
	@override String get suggestedAnime => 'Sugerowane anime';
	@override String get airingAnime => 'Najpopularniejsze emitowane anime';
	@override String get popularAnime => 'Najpopularniejsze anime';
	@override String get trending => 'Na czasie';
	@override String get upcomingMovies => 'Nadchodzące filmy';
	@override String get upcomingShows => 'Nadchodzące seriale';
}

// Path: explore.status
class _Translations$explore$status$pl extends Translations$explore$status$en {
	_Translations$explore$status$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get airing => 'W emisji';
	@override String get ended => 'Zakończony';
	@override String get canceled => 'Anulowany';
	@override String get upcoming => 'Nadchodzący';
}

// Path: downloads.backgroundWarning
class _Translations$downloads$backgroundWarning$pl extends Translations$downloads$backgroundWarning$en {
	_Translations$downloads$backgroundWarning$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get bannerBlocked => 'Po opuszczeniu aplikacji pobieranie zostanie zatrzymane';
	@override String get bannerDegraded => 'Pobieranie w tle może być ograniczone';
	@override String get bannerAction => 'Szczegóły';
	@override String get sheetTitle => 'Pobieranie w tle jest zablokowane';
	@override String get sheetTitleDegraded => 'Pobieranie w tle może być ograniczone';
	@override String get sheetIntro => 'Android uniemożliwia Plezy niezawodne pobieranie plików w tle.';
	@override String get sheetIntroDegraded => 'Twoje urządzenie ogranicza możliwość pobierania w tle przez Plezy.';
	@override String get reasonBackgroundRestricted => 'Działanie Plezy w tle jest ograniczone. Ustaw użycie baterii lub działanie w tle na „Bez ograniczeń”.';
	@override String get reasonStandbyRestricted => 'Android umieścił Plezy w ograniczonym trybie gotowości. Ustaw użycie baterii na „Bez ograniczeń”.';
	@override String get reasonDownloadChannelBlocked => 'Powiadomienia o pobieraniu są wyłączone, więc postęp i opcje sterowania mogą być niedostępne.';
	@override String get reasonNotificationsDisabled => 'Powiadomienia są wyłączone. W Android 13 lub nowszym są wymagane przy długim pobieraniu w tle.';
	@override String get reasonDataSaver => 'Oszczędzanie danych jest włączone, co blokuje pobieranie w tle przez mobilną transmisję danych. Pobieranie powinno nadal działać przez Wi-Fi.';
	@override String get reasonOemUnknown => 'Pobieranie wielokrotnie przerywało się, gdy Plezy działało w tle. Sprawdź ustawienia baterii lub działania w tle dla Plezy.';
	@override String get openSettings => 'Otwórz ustawienia';
	@override String get stillNotWorking => 'Pomoc dla Twojego urządzenia';
	@override String get stillNotWorkingDescription => 'Zobacz instrukcje dla swojego urządzenia lub, jeśli problem nadal występuje, wyślij log przez Ustawienia › Pokaż logi.';
	@override String get dialogTitle => 'Pobieranie może się nie zakończyć';
	@override String get dialogDownloadAnyway => 'Pobierz mimo to';
	@override String get dialogFixFirst => 'Najpierw rozwiąż problem';
	@override String get statusTile => 'Pobieranie w tle';
	@override String get statusOk => 'Działanie w tle jest dozwolone';
	@override String get statusBlocked => 'Zablokowane przez ustawienia systemu';
	@override String get statusDegraded => 'Ograniczone przez ustawienia systemu';
	@override String get statusUnknown => 'Jeszcze nie sprawdzono';
	@override String get settingsUnavailable => 'Nie udało się otworzyć ustawień systemowych na tym urządzeniu';
	@override String get linkUnavailable => 'Nie udało się otworzyć dontkillmyapp.com na tym urządzeniu';
}

// Path: services.names
class _Translations$services$names$pl extends Translations$services$names$en {
	_Translations$services$names$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get mal => 'MyAnimeList';
	@override String get anilist => 'AniList';
	@override String get simkl => 'Simkl';
	@override String get seerr => 'Seerr';
}

// Path: services.deviceCode
class _Translations$services$deviceCode$pl extends Translations$services$deviceCode$en {
	_Translations$services$deviceCode$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String title({required Object service}) => 'Aktywuj Plezy w ${service}';
	@override String body({required Object url}) => 'Odwiedź ${url} i wpisz ten kod:';
	@override String openToActivate({required Object service}) => 'Otwórz ${service}, aby aktywować';
	@override String get copyCode => 'Skopiuj kod aktywacyjny';
	@override String get waitingForAuthorization => 'Oczekiwanie na autoryzację…';
	@override String get codeCopied => 'Kod skopiowany';
}

// Path: services.oauthProxy
class _Translations$services$oauthProxy$pl extends Translations$services$oauthProxy$en {
	_Translations$services$oauthProxy$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String title({required Object service}) => 'Zaloguj się do ${service}';
	@override String get body => 'Zeskanuj ten kod QR lub otwórz URL na dowolnym urządzeniu.';
	@override String openToSignIn({required Object service}) => 'Otwórz ${service}, aby się zalogować';
	@override String get copyUrl => 'Skopiuj adres URL logowania';
	@override String get urlCopied => 'URL skopiowany';
}

// Path: services.libraryFilter
class _Translations$services$libraryFilter$pl extends Translations$services$libraryFilter$en {
	_Translations$services$libraryFilter$pl._(TranslationsPl root) : this._root = root, super.internal(root);

	final TranslationsPl _root; // ignore: unused_field

	// Translations
	@override String get title => 'Filtr bibliotek';
	@override String get subtitleAllSyncing => 'Synchronizowanie wszystkich bibliotek';
	@override String get subtitleNoneSyncing => 'Brak synchronizowanych bibliotek';
	@override String subtitleBlocked({required Object count}) => '${count} zablokowanych';
	@override String subtitleAllowed({required Object count}) => '${count} dozwolonych';
	@override String get mode => 'Tryb filtra';
	@override String get modeBlacklist => 'Czarna lista';
	@override String get modeWhitelist => 'Biała lista';
	@override String get modeHintBlacklist => 'Synchronizuj wszystkie biblioteki oprócz zaznaczonych poniżej.';
	@override String get modeHintWhitelist => 'Synchronizuj tylko biblioteki zaznaczone poniżej.';
	@override String get libraries => 'Biblioteki';
	@override String get noLibraries => 'Brak dostępnych bibliotek';
}

/// The flat map containing all translations for locale <pl>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsPl {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Plezy',
			'auth.connectToJellyfin' => 'Połącz z Jellyfin',
			'auth.useQuickConnect' => 'Użyj Quick Connect',
			'auth.quickConnectInstructions' => 'Otwórz Quick Connect w Jellyfin i wpisz ten kod.',
			'auth.quickConnectWaiting' => 'Oczekiwanie na zatwierdzenie…',
			'auth.quickConnectCancel' => 'Anuluj',
			'auth.quickConnectExpired' => 'Quick Connect wygasł. Spróbuj ponownie.',
			'auth.localDataRecoveryRequired' => 'Plezy nie mogło bezpiecznie odzyskać lokalnych danych logowania ani oczekujących danych odtwarzania. Zaloguj się ponownie.',
			'common.cancel' => 'Anuluj',
			'common.save' => 'Zapisz',
			'common.close' => 'Zamknij',
			'common.clear' => 'Wyczyść',
			'common.reset' => 'Resetuj',
			'common.later' => 'Później',
			'common.submit' => 'Wyślij',
			'common.confirm' => 'Potwierdź',
			'common.retry' => 'Ponów',
			'common.logout' => 'Wyloguj',
			'common.unknown' => 'Nieznane',
			'common.refresh' => 'Odśwież',
			'common.yes' => 'Tak',
			'common.no' => 'Nie',
			'common.delete' => 'Usuń',
			'common.edit' => 'Edytuj',
			'common.shuffle' => 'Losowo',
			'common.addTo' => 'Dodaj do...',
			'common.createNew' => 'Utwórz',
			'common.disconnect' => 'Rozłącz',
			'common.play' => 'Odtwórz',
			'common.pause' => 'Pauza',
			'common.resume' => 'Wznów',
			'common.error' => 'Błąd',
			'common.search' => 'Szukaj',
			'common.home' => 'Strona główna',
			'common.back' => 'Wstecz',
			'common.settings' => 'Ustawienia',
			'common.ok' => 'OK',
			'common.off' => 'Wył.',
			'common.seasonNumber' => ({required Object number}) => 'Sezon ${number}',
			'common.episodeNumberTitle' => ({required Object number, required Object title}) => 'Odcinek ${number} - ${title}',
			'common.chapterNumber' => ({required Object number}) => 'Rozdział ${number}',
			'common.reconnect' => 'Połącz ponownie',
			'common.viewAll' => 'Pokaż wszystko',
			'common.checkingNetwork' => 'Sprawdzanie sieci...',
			'common.loadingServers' => 'Ładowanie serwerów...',
			'common.connectingToServers' => 'Łączenie z serwerami...',
			'common.startingOfflineMode' => 'Uruchamianie trybu offline...',
			'common.loading' => 'Ładowanie...',
			'common.pressBackAgainToExit' => 'Naciśnij ponownie przycisk Wstecz, aby wyjść',
			'common.next' => 'Następny',
			'screens.licenses' => 'Licencje',
			'screens.switchProfile' => 'Zmień profil',
			'screens.subtitleStyling' => 'Styl napisów',
			'screens.mpvConfig' => 'mpv.conf',
			'screens.logs' => 'Logi',
			'update.available' => 'Dostępna aktualizacja',
			'update.versionAvailable' => ({required Object version}) => 'Dostępna wersja ${version}',
			'update.currentVersion' => ({required Object version}) => 'Bieżąca: ${version}',
			'update.skipVersion' => 'Pomiń tę wersję',
			'update.viewRelease' => 'Zobacz wydanie',
			'update.latestVersion' => 'Masz najnowszą wersję',
			'update.checkFailed' => 'Nie udało się sprawdzić aktualizacji',
			'settings.title' => 'Ustawienia',
			'settings.supportDeveloper' => 'Wesprzyj Plezy',
			'settings.supportDeveloperDescription' => 'Wspomóż rozwój darowizną na Liberapay',
			'settings.language' => 'Język',
			'settings.theme' => 'Motyw',
			'settings.appearance' => 'Wygląd',
			'settings.videoPlayback' => 'Odtwarzanie wideo',
			'settings.videoPlaybackDescription' => 'Skonfiguruj zachowanie odtwarzania',
			'settings.advanced' => 'Zaawansowane',
			'settings.episodePosterMode' => 'Styl plakatu odcinka',
			'settings.seriesPoster' => 'Plakat serialu',
			'settings.seasonPoster' => 'Plakat sezonu',
			'settings.episodeThumbnail' => 'Miniatura',
			'settings.showHeroSectionDescription' => 'Wyświetl karuzelę wyróżnionych treści na ekranie głównym',
			'settings.secondsLabel' => 'Sekundy',
			'settings.minutesLabel' => 'Minuty',
			'settings.secondsShort' => 's',
			'settings.minutesShort' => 'm',
			'settings.durationHint' => ({required Object min, required Object max}) => 'Wprowadź czas (${min}-${max})',
			'settings.systemTheme' => 'Systemowy',
			'settings.lightTheme' => 'Jasny',
			'settings.darkTheme' => 'Ciemny',
			'settings.oledTheme' => 'OLED',
			'settings.libraryDensity' => 'Gęstość biblioteki',
			'settings.compact' => 'Kompaktowy',
			'settings.comfortable' => 'Wygodny',
			'settings.tvCornerSpotlightBackdrop' => 'Tło wyróżnionej pozycji w rogu',
			'settings.tvCornerSpotlightBackdropDescription' => 'Wyświetlaj grafikę wyróżnionej pozycji w prawym górnym rogu zamiast na całym ekranie',
			'settings.viewMode' => 'Tryb widoku',
			'settings.gridView' => 'Siatka',
			'settings.listView' => 'Lista',
			'settings.showHeroSection' => 'Pokaż sekcję wyróżnioną',
			'settings.continueWatchingAction' => 'Działanie w sekcji „Kontynuuj oglądanie”',
			'settings.continueWatchingPlay' => 'Odtwórz',
			'settings.continueWatchingDetails' => 'Otwórz szczegóły',
			'settings.episodeAction' => 'Akcja odcinka',
			'settings.episodePlay' => 'Odtwórz',
			'settings.episodeDetails' => 'Otwórz szczegóły',
			'settings.useGlobalHubs' => 'Użyj układu strony głównej',
			'settings.useGlobalHubsDescription' => 'Wyświetlaj ujednolicone sekcje ekranu głównego. W przeciwnym razie używaj rekomendacji bibliotek.',
			'settings.showServerNameOnHubs' => 'Pokaż nazwę serwera w sekcjach',
			'settings.showServerNameOnHubsDescription' => 'Zawsze pokazuj nazwy serwerów w tytułach sekcji.',
			'settings.groupLibrariesByServer' => 'Grupuj biblioteki według serwera',
			'settings.groupLibrariesByServerDescription' => 'Grupuj biblioteki paska bocznego pod każdym serwerem multimediów.',
			'settings.alwaysKeepSidebarOpen' => 'Zawsze utrzymuj panel boczny otwarty',
			'settings.alwaysKeepSidebarOpenDescription' => 'Panel boczny jest rozwinięty, a obszar treści dostosowuje się',
			'settings.showUnwatchedCount' => 'Pokaż liczbę nieobejrzanych',
			'settings.showUnwatchedCountDescription' => 'Wyświetl liczbę nieobejrzanych odcinków w serialach i sezonach',
			'settings.showEpisodeNumberOnCards' => 'Pokaż numer odcinka na kartach',
			'settings.showEpisodeNumberOnCardsDescription' => 'Pokazuj numer sezonu i odcinka na kartach odcinków',
			'settings.showSeasonPostersOnTabs' => 'Pokaż plakaty sezonów na zakładkach',
			'settings.showSeasonPostersOnTabsDescription' => 'Pokazuj plakat każdego sezonu nad jego zakładką',
			'settings.tvFullCardLayout' => 'Pełne karty TV',
			'settings.tvFullCardLayoutDescription' => 'Używaj kart TV tylko z obrazem i nałożonymi nazwiskami aktorów',
			'settings.focusGlow' => 'Poświata zaznaczenia',
			'settings.focusGlowDescription' => 'Wyświetlaj delikatną poświatę wokół zaznaczonej karty',
			'settings.visualEffects' => 'Efekty wizualne',
			'settings.visualEffectsAuto' => 'Automatycznie',
			'settings.visualEffectsAutoDescription' => 'Automatycznie ograniczaj efekty na urządzeniach o niższej wydajności',
			'settings.visualEffectsFull' => 'Pełne',
			'settings.visualEffectsReduced' => 'Ograniczone',
			'settings.visualEffectsReducedDescription' => 'Mniej animacji i grafiki o niższej rozdzielczości',
			'settings.hideSpoilers' => 'Ukryj spoilery nieobejrzanych odcinków',
			'settings.hideSpoilersDescription' => 'Rozmywaj miniatury i opisy nieobejrzanych odcinków',
			'settings.playerBackend' => 'Mechanizm odtwarzania',
			'settings.exoPlayer' => 'ExoPlayer',
			'settings.mpv' => 'mpv',
			'settings.hardwareDecoding' => 'Dekodowanie sprzętowe',
			'settings.hardwareDecodingDescription' => 'Użyj akceleracji sprzętowej, gdy dostępna',
			'settings.bufferSize' => 'Rozmiar bufora',
			'settings.bufferSizeMB' => ({required Object size}) => '${size}MB',
			'settings.bufferSizeAuto' => 'Automatyczny (zalecany)',
			'settings.bufferSizeWarning' => ({required Object heap, required Object size}) => 'Dostępna pamięć: ${heap}MB. Bufor ${size}MB może wpłynąć na odtwarzanie.',
			'settings.defaultQualityTitle' => 'Domyślna jakość',
			'settings.musicQualityTitle' => 'Jakość muzyki',
			'settings.subtitleStyling' => 'Styl napisów',
			'settings.subtitleStylingDescription' => 'Dostosuj wygląd napisów',
			'settings.smallSkipDuration' => 'Krótki skok',
			'settings.largeSkipDuration' => 'Długi skok',
			'settings.rewindOnResume' => 'Przewiń przy wznowieniu',
			'settings.secondsUnit' => ({required Object seconds}) => '${seconds} sekund',
			'settings.defaultSleepTimer' => 'Domyślny wyłącznik czasowy',
			'settings.minutesUnit' => ({required Object minutes}) => '${minutes} minut',
			'settings.rememberTrackSelections' => 'Zapamiętuj wybór ścieżek dla każdego serialu i filmu',
			'settings.rememberTrackSelectionsDescription' => 'Zapamiętuj wybór ścieżki dźwiękowej i napisów dla każdego tytułu',
			'settings.followServerTrackSelections' => 'Używaj wyboru ścieżek z serwera dla każdego odcinka',
			'settings.followServerTrackSelectionsDescription' => 'Przy zmianie odcinka stosuj ścieżkę dźwiękową i napisy wybrane na serwerze zamiast przenosić bieżący wybór',
			'settings.showChapterMarkersOnTimeline' => 'Pokaż znaczniki rozdziałów na pasku przewijania',
			'settings.showChapterMarkersOnTimelineDescription' => 'Podziel pasek przewijania na granicach rozdziałów',
			'settings.clickVideoTogglesPlayback' => 'Kliknięcie wideo przełącza odtwarzanie/pauzę',
			'settings.clickVideoTogglesPlaybackDescription' => 'Kliknięcie wideo odtwarza/wstrzymuje zamiast pokazywać sterowanie.',
			'settings.videoPlayerControls' => 'Kontrolki odtwarzacza wideo',
			'settings.keyboardShortcuts' => 'Skróty klawiszowe',
			'settings.keyboardShortcutsDescription' => 'Dostosuj skróty klawiszowe',
			'settings.videoPlayerNavigation' => 'Nawigacja odtwarzacza wideo',
			'settings.videoPlayerNavigationDescription' => 'Użyj klawiszy strzałek do nawigacji kontrolkami odtwarzacza',
			'settings.crashReporting' => 'Raportowanie błędów',
			'settings.crashReportingDescription' => 'Wysyłaj raporty o błędach, aby pomóc ulepszyć aplikację',
			'settings.debugLogging' => 'Rejestrowanie diagnostyczne',
			'settings.debugLoggingDescription' => 'Włącz szczegółowe rejestrowanie, aby ułatwić rozwiązywanie problemów',
			'settings.viewLogs' => 'Pokaż logi',
			'settings.viewLogsDescription' => 'Pokaż logi aplikacji',
			'settings.resetSettings' => 'Zresetuj ustawienia',
			'settings.resetSettingsDescription' => 'Przywróć ustawienia domyślne. Tego nie można cofnąć.',
			'settings.resetSettingsSuccess' => 'Przywrócono ustawienia domyślne',
			'settings.backup' => 'Kopia zapasowa',
			'settings.exportSettings' => 'Eksportuj ustawienia',
			'settings.exportSettingsDescription' => 'Zapisz swoje preferencje do pliku',
			'settings.exportSettingsSuccess' => 'Ustawienia wyeksportowane',
			'settings.importSettings' => 'Importuj ustawienia',
			'settings.importSettingsDescription' => 'Przywróć preferencje z pliku',
			'settings.importSettingsConfirm' => 'Bieżące ustawienia zostaną zastąpione. Kontynuować?',
			'settings.importSettingsSuccess' => 'Ustawienia zaimportowane',
			'settings.importSettingsInvalidFile' => 'Ten plik nie jest prawidłowym eksportem Plezy',
			'settings.importSettingsNoUser' => 'Zaloguj się przed importem ustawień',
			'settings.shortcutsReset' => 'Skróty przywrócone do domyślnych',
			'settings.about' => 'O aplikacji',
			'settings.aboutDescription' => 'Informacje o aplikacji i licencje',
			'settings.updates' => 'Aktualizacje',
			'settings.updateAvailable' => 'Dostępna aktualizacja',
			'settings.checkForUpdates' => 'Sprawdź aktualizacje',
			'settings.autoCheckUpdatesOnStartup' => 'Automatycznie sprawdzaj aktualizacje przy uruchomieniu',
			'settings.autoCheckUpdatesOnStartupDescription' => 'Powiadamiaj o dostępnej aktualizacji przy uruchomieniu',
			'settings.validationErrorEnterNumber' => 'Wprowadź prawidłową liczbę',
			'settings.validationErrorDuration' => ({required Object min, required Object max, required Object unit}) => 'Czas musi być między ${min} a ${max} ${unit}',
			'settings.shortcutAlreadyAssigned' => ({required Object action}) => 'Skrót jest już przypisany do ${action}',
			'settings.shortcutUpdated' => ({required Object action}) => 'Skrót zaktualizowany dla ${action}',
			'settings.saveFailed' => 'Nie udało się zapisać zmian. Spróbuj ponownie.',
			'settings.autoSkip' => 'Automatyczne pomijanie',
			'settings.autoSkipIntro' => 'Automatyczne pomijanie intro',
			'settings.autoSkipIntroDescription' => 'Automatycznie pomijaj znaczniki intro po kilku sekundach',
			'settings.autoSkipCredits' => 'Automatyczne pomijanie napisów końcowych',
			'settings.autoSkipCreditsDescription' => 'Automatycznie pomijaj napisy końcowe i odtwórz następny odcinek',
			'settings.forceSkipMarkerFallback' => 'Wymuś znaczniki awaryjne',
			'settings.forceSkipMarkerFallbackDescription' => 'Używaj wzorców tytułów rozdziałów, nawet gdy Plex ma znaczniki',
			'settings.autoSkipDelay' => 'Opóźnienie automatycznego pomijania',
			'settings.autoSkipDelayDescription' => ({required Object seconds}) => 'Czekaj ${seconds} sekund przed automatycznym pominięciem',
			'settings.introPattern' => 'Wzorzec znacznika intro',
			'settings.introPatternDescription' => 'Wyrażenie regularne do rozpoznawania znaczników intro w tytułach rozdziałów',
			'settings.creditsPattern' => 'Wzorzec znacznika napisów końcowych',
			'settings.creditsPatternDescription' => 'Wyrażenie regularne do rozpoznawania znaczników napisów końcowych w tytułach rozdziałów',
			'settings.invalidRegex' => 'Nieprawidłowe wyrażenie regularne',
			'settings.regex' => 'Wyrażenie regularne',
			'settings.downloads' => 'Pobrania',
			'settings.downloadLocationDescription' => 'Wybierz miejsce przechowywania pobranych treści',
			'settings.downloadLocationDefault' => 'Domyślne (pamięć aplikacji)',
			'settings.downloadLocationCustom' => 'Niestandardowa lokalizacja',
			'settings.selectFolder' => 'Wybierz folder',
			'settings.resetToDefault' => 'Przywróć domyślne',
			'settings.currentPath' => ({required Object path}) => 'Bieżąca: ${path}',
			'settings.downloadLocationChanged' => 'Lokalizacja pobierania zmieniona',
			'settings.downloadLocationReset' => 'Lokalizacja pobierania przywrócona do domyślnej',
			'settings.downloadLocationInvalid' => 'Nie można zapisywać w wybranym folderze',
			'settings.downloadLocationPickerUnavailable' => 'Wybór folderu nie jest dostępny na tym urządzeniu',
			'settings.downloadOnWifiOnly' => 'Pobieraj tylko przez Wi-Fi',
			'settings.downloadOnWifiOnlyDescription' => 'Blokuj pobieranie na danych komórkowych',
			'settings.autoRemoveWatchedDownloads' => 'Automatycznie usuwaj obejrzane pobrania',
			'settings.autoRemoveWatchedDownloadsDescription' => 'Automatycznie usuwaj obejrzane pobrania',
			'settings.cellularDownloadBlocked' => 'Pobieranie przez sieć komórkową jest zablokowane. Użyj Wi-Fi lub zmień ustawienie.',
			'settings.maxVolume' => 'Maksymalna głośność',
			'settings.maxVolumeDescription' => 'Pozwól na wzmocnienie głośności powyżej 100% dla cichych multimediów',
			'settings.maxVolumePercent' => ({required Object percent}) => '${percent}%',
			'settings.discordRichPresence' => 'Discord Rich Presence',
			'settings.discordRichPresenceDescription' => 'Pokaż, co oglądasz na Discordzie',
			'settings.services' => 'Usługi',
			'settings.servicesDescription' => 'Połącz Trakt, MyAnimeList, Seerr i inne',
			'settings.manageLibrariesDescription' => 'Zmieniaj kolejność i ukrywaj biblioteki',
			'settings.autoPip' => 'Automatyczny obraz w obrazie',
			'settings.autoPipDescription' => 'Automatycznie włączaj tryb obrazu w obrazie po opuszczeniu aplikacji podczas odtwarzania',
			'settings.matchContentFrameRate' => 'Dopasuj częstotliwość klatek do treści',
			'settings.matchContentFrameRateDescription' => 'Dopasuj częstotliwość odświeżania ekranu do wideo',
			'settings.matchRefreshRate' => 'Dopasuj częstotliwość odświeżania',
			'settings.matchRefreshRateDescription' => 'Dopasuj częstotliwość odświeżania w trybie pełnoekranowym',
			'settings.matchDynamicRange' => 'Dopasuj zakres dynamiki',
			'settings.matchDynamicRangeDescription' => 'Włącz HDR dla treści HDR, potem wróć do SDR',
			'settings.displaySwitchDelay' => 'Opóźnienie przełączania ekranu',
			'settings.tunneledPlayback' => 'Tunelowane odtwarzanie',
			'settings.tunneledPlaybackDescription' => 'Użyj tunelowania wideo. Wyłącz, jeśli HDR pokazuje czarny obraz.',
			'settings.audioPassthrough' => 'Przekazywanie dźwięku',
			'settings.audioPassthroughDescription' => 'Przesyłaj dźwięk Dolby/DTS do amplitunera lub telewizora bez ponownego kodowania, zachowując dźwięk przestrzenny. Wyłącz tę opcję, jeśli nie słychać dźwięku.',
			'settings.audioPassthroughDescriptionAppleTv' => 'Używaj natywnego dekodera Dolby firmy Apple dla Dolby Digital Plus, w tym Atmos. DTS i TrueHD nadal będą odtwarzane jako wielokanałowy dźwięk PCM. Wyłącz tę opcję, jeśli nie słychać dźwięku.',
			'settings.audioDownmix' => 'Miksowanie do stereo',
			'settings.audioDownmixDescription' => 'Miksuje dźwięk przestrzenny do dwóch kanałów dla głośników stereo lub słuchawek',
			'settings.downmixCenterBoost' => 'Wzmocnienie kanału centralnego',
			'settings.downmixCenterBoostValue' => ({required Object db}) => '${db} dB',
			'settings.downmixCenterBoostLabel' => 'Wzmocnienie (dB)',
			'settings.downmixCenterBoostShort' => 'dB',
			'settings.audioDownmixNormalize' => 'Normalizacja głośności przy miksowaniu',
			'settings.audioDownmixNormalizeDescription' => 'Obniża miks, aby zapobiec przesterowaniu. Wyłącz, aby zachować oryginalną głośność (głośne sceny mogą być zniekształcone).',
			'settings.atmosDiagnostics' => 'Test wyjścia Atmos',
			'settings.atmosDiagnosticsDescription' => 'Diagnozuj wyjście Dolby Atmos, odtwarzając sygnały testowe przez odtwarzacz systemowy',
			'settings.atmosTestHlsAtmos' => 'Strumień Atmos Apple',
			'settings.atmosTestHlsAtmosDescription' => 'Sprawdzony strumień Dolby Atmos. Amplituner powinien pokazać Dolby Atmos.',
			'settings.atmosTestHlsControl' => 'Strumień dźwięku przestrzennego Apple',
			'settings.atmosTestHlsControlDescription' => 'Strumień kontrolny bez Atmos. Amplituner powinien wskazywać dźwięk przestrzenny bez Atmos.',
			'settings.atmosTestRawStream' => 'Surowy strumień EAC3',
			'settings.atmosTestRawStreamDescription' => 'Przesyła strumieniowo plik testowy dokładnie tak jak podczas odtwarzania Atmos w odtwarzaczu. Wymaga adresu URL pliku testowego.',
			'settings.atmosTestRawFile' => 'Surowy plik EAC3',
			'settings.atmosTestRawFileDescription' => 'Odtwarza plik testowy o znanej długości. Wymaga URL pliku testowego.',
			'settings.atmosTestAsbarNative' => 'Renderer bufora próbek (natywny)',
			'settings.atmosTestAsbarNativeDescription' => 'Przekazuje nienaruszony skompresowany dźwięk pliku prosto do renderera systemu. Wymaga URL pliku testowego.',
			'settings.atmosTestAsbarGenerated' => 'Renderer bufora próbek (odtworzony)',
			'settings.atmosTestAsbarGeneratedDescription' => 'To samo, ale z opisem dźwięku budowanym tak jak przy odtwarzaniu. Wymaga URL pliku testowego.',
			'settings.atmosTestSessionMode' => 'Użyj trybu odtwarzania filmów',
			'settings.atmosTestSessionModeDescription' => 'Wyłączone używa trybu udokumentowanego przez Dolby. Włączone używa poprzedniego trybu.',
			'settings.atmosTestShowRoutePicker' => 'Wybierz wyjście AirPlay',
			'settings.atmosTestHideRoutePicker' => 'Ukryj wybór wyjścia AirPlay',
			'settings.atmosTestRoutePickerDescription' => 'Wysyła test do odbiornika AirPlay. Tylko AirPlay zgłasza ustalony tryb dźwięku.',
			'settings.atmosTestStop' => 'Zatrzymaj test',
			'settings.atmosTestUrl' => 'Adres URL pliku testowego',
			'settings.atmosTestUrlDescription' => 'Adres URL HTTP surowego pliku Dolby Atmos w formacie .ec3 (np. wyodrębnionego za pomocą ffmpeg)',
			'settings.atmosTestUrlMissing' => 'Najpierw ustaw adres URL pliku testowego',
			'settings.atmosTestStatus' => 'Stan',
			'settings.dvConversionMode' => 'Konwersja Dolby Vision',
			'settings.dvConversionModeDescription' => 'Wybierz, jak ExoPlayer obsługuje pliki Dolby Vision Profile 7.',
			'settings.dvConversionAuto' => 'Automatycznie',
			'settings.dvConversionNative' => 'Natywnie / wyłączone',
			'settings.dvConversionDv81' => 'P7 → P8.1',
			'settings.dvConversionHevcStrip' => 'P7 → HEVC',
			'settings.dvConversionAutoDescription' => 'Wykrywaj możliwości urządzenia i stosuj standardowy mechanizm awaryjny',
			'settings.dvConversionNativeDescription' => 'Wymuś natywne DV7 i wyłącz ponowną próbę konwersji DV',
			'settings.dvConversionDv81Description' => 'Wymuś wbudowaną konwersję RPU do profilu Dolby Vision 8.1',
			'settings.dvConversionHevcStripDescription' => 'Usuń warstwy Dolby Vision RPU/EL i przedstaw zwykłe HEVC',
			'settings.requireProfileSelectionOnOpen' => 'Pytaj o profil przy otwarciu aplikacji',
			'settings.requireProfileSelectionOnOpenDescription' => 'Pokaż wybór profilu za każdym razem, gdy aplikacja jest otwierana',
			'settings.forceTvMode' => 'Wymuś tryb TV',
			'settings.forceTvModeDescription' => 'Wymuś układ telewizyjny na urządzeniach, które nie wykrywają go automatycznie. Wymaga ponownego uruchomienia.',
			'settings.startInFullscreen' => 'Uruchom na pełnym ekranie',
			'settings.startInFullscreenDescription' => 'Otwiera Plezy w trybie pełnoekranowym przy uruchomieniu',
			'settings.exitFullscreenOnPlayerClose' => 'Wyjdź z pełnego ekranu przy zamykaniu odtwarzacza',
			'settings.exitFullscreenOnPlayerCloseDescription' => 'Automatycznie wychodzi z trybu pełnoekranowego po zamknięciu odtwarzacza wideo',
			'settings.autoHidePerformanceOverlay' => 'Automatycznie ukrywaj nakładkę wydajności',
			'settings.autoHidePerformanceOverlayDescription' => 'Wygaszaj nakładkę wydajności wraz z kontrolkami odtwarzania',
			'settings.showNavBarLabels' => 'Pokaż etykiety paska nawigacji',
			'settings.showNavBarLabelsDescription' => 'Wyświetl tekstowe etykiety pod ikonami paska nawigacji',
			'settings.startupSection' => 'Sekcja startowa',
			'settings.display' => 'Ekran',
			'settings.homeScreen' => 'Ekran główny',
			'settings.navigation' => 'Nawigacja',
			'settings.window' => 'Okno',
			'settings.content' => 'Zawartość',
			'settings.player' => 'Odtwarzacz',
			'settings.subtitlesAndConfig' => 'Napisy i konfiguracja',
			'settings.seekAndTiming' => 'Przewijanie i czas',
			'settings.behavior' => 'Zachowanie',
			'search.hint' => 'Szukaj filmów, seriali, muzyki...',
			'search.tryDifferentTerm' => 'Spróbuj innego wyszukiwania',
			'search.searchYourMedia' => 'Przeszukaj swoje media',
			'search.enterTitleActorOrKeyword' => 'Wprowadź tytuł, aktora lub słowo kluczowe',
			'hotkeys.setShortcutFor' => ({required Object actionName}) => 'Ustaw skrót dla ${actionName}',
			'hotkeys.clearShortcut' => 'Wyczyść skrót',
			'hotkeys.noShortcutSet' => 'Brak ustawionego skrótu',
			'hotkeys.currentShortcut' => 'Bieżący skrót:',
			'hotkeys.pressToRecord' => 'Wybierz, aby zapisać skrót klawiszowy',
			'hotkeys.recordingShortcut' => 'Naciśnij teraz skrót klawiszowy',
			'hotkeys.actions.playPause' => 'Odtwórz/Pauza',
			'hotkeys.actions.volumeUp' => 'Głośniej',
			'hotkeys.actions.volumeDown' => 'Ciszej',
			'hotkeys.actions.seekForward' => ({required Object seconds}) => 'Przewiń do przodu (${seconds}s)',
			'hotkeys.actions.seekBackward' => ({required Object seconds}) => 'Przewiń do tyłu (${seconds}s)',
			'hotkeys.actions.fullscreenToggle' => 'Pełny ekran',
			'hotkeys.actions.muteToggle' => 'Wyciszenie',
			'hotkeys.actions.subtitleToggle' => 'Napisy',
			'hotkeys.actions.audioTrackNext' => 'Następna ścieżka audio',
			'hotkeys.actions.subtitleTrackNext' => 'Następna ścieżka napisów',
			'hotkeys.actions.chapterNext' => 'Następny rozdział',
			'hotkeys.actions.chapterPrevious' => 'Poprzedni rozdział',
			'hotkeys.actions.episodeNext' => 'Następny odcinek',
			'hotkeys.actions.episodePrevious' => 'Poprzedni odcinek',
			'hotkeys.actions.speedIncrease' => 'Zwiększ prędkość',
			'hotkeys.actions.speedDecrease' => 'Zmniejsz prędkość',
			'hotkeys.actions.speedReset' => 'Zresetuj prędkość',
			'hotkeys.actions.zoomIn' => 'Powiększ',
			'hotkeys.actions.zoomOut' => 'Pomniejsz',
			'hotkeys.actions.zoomReset' => 'Zresetuj zoom',
			'hotkeys.actions.subSeekNext' => 'Przewiń do następnego napisu',
			'hotkeys.actions.subSeekPrev' => 'Przewiń do poprzedniego napisu',
			'hotkeys.actions.shaderToggle' => 'Przełącz shadery',
			'hotkeys.actions.skipMarker' => 'Pomiń intro/napisy końcowe',
			'hotkeys.actions.screenshot' => 'Zrób zrzut ekranu',
			'fileInfo.title' => 'Informacje o pliku',
			'fileInfo.video' => 'Wideo',
			'fileInfo.audio' => 'Audio',
			'fileInfo.subtitles' => 'Napisy',
			'fileInfo.file' => 'Plik',
			'fileInfo.codec' => 'Kodek',
			'fileInfo.resolution' => 'Rozdzielczość',
			'fileInfo.bitrate' => 'Przepływność',
			'fileInfo.frameRate' => 'Klatki na sekundę',
			'fileInfo.aspectRatio' => 'Proporcje',
			'fileInfo.profile' => 'Profil',
			'fileInfo.bitDepth' => 'Głębia bitowa',
			'fileInfo.colorSpace' => 'Przestrzeń kolorów',
			'fileInfo.colorRange' => 'Zakres kolorów',
			'fileInfo.colorPrimaries' => 'Kolory podstawowe',
			'fileInfo.chromaSubsampling' => 'Podpróbkowanie chrominancji',
			'fileInfo.channels' => 'Kanały',
			'fileInfo.overallBitrate' => 'Całkowita przepływność',
			'fileInfo.path' => 'Ścieżka',
			'fileInfo.size' => 'Rozmiar',
			'fileInfo.container' => 'Kontener',
			'fileInfo.duration' => 'Czas trwania',
			'fileInfo.optimizedForStreaming' => 'Zoptymalizowane do strumieniowania',
			'fileInfo.has64bitOffsets' => 'Przesunięcia 64-bitowe',
			'mediaMenu.markAsWatched' => 'Oznacz jako obejrzane',
			'mediaMenu.markAsUnwatched' => 'Oznacz jako nieobejrzane',
			'mediaMenu.removeFromContinueWatching' => 'Usuń z kontynuowania oglądania',
			'mediaMenu.viewDetails' => 'Pokaż szczegóły',
			'mediaMenu.goToSeries' => 'Przejdź do serialu',
			'mediaMenu.shufflePlay' => 'Odtwarzanie losowe',
			'mediaMenu.shuffleNotAvailableOffline' => 'Odtwarzanie losowe nie jest dostępne offline',
			'mediaMenu.fileInfo' => 'Informacje o pliku',
			'mediaMenu.deleteFromServer' => 'Usuń z serwera',
			'mediaMenu.confirmDelete' => 'Usunąć to medium i jego pliki z serwera?',
			'mediaMenu.deleteMultipleWarning' => 'Obejmuje to wszystkie odcinki i ich pliki.',
			'mediaMenu.mediaDeletedSuccessfully' => 'Usunięto element multimedialny',
			'mediaMenu.mediaFailedToDelete' => 'Nie udało się usunąć elementu multimedialnego',
			'mediaMenu.rate' => 'Oceń',
			'mediaMenu.playFromBeginning' => 'Odtwórz od początku',
			'mediaMenu.playVersion' => 'Odtwórz wersję...',
			'rateSheet.title' => 'Oceń',
			'rateSheet.server' => 'Serwer',
			'rateSheet.favorite' => 'Dodaj do ulubionych',
			'rateSheet.favorited' => 'Dodano do ulubionych',
			'rateSheet.saved' => 'Zapisano',
			'rateSheet.notAvailable' => 'Nie znaleziono dopasowania',
			'rateSheet.noConnectedServices' => 'Połącz usługę w Ustawieniach, aby tam oceniać.',
			'accessibility.mediaCardMovie' => ({required Object title}) => '${title}, film',
			'accessibility.mediaCardShow' => ({required Object title}) => '${title}, serial TV',
			'accessibility.mediaCardEpisode' => ({required Object title, required Object episodeInfo}) => '${title}, ${episodeInfo}',
			'accessibility.mediaCardSeason' => ({required Object title, required Object seasonInfo}) => '${title}, ${seasonInfo}',
			'accessibility.mediaCardWatched' => 'obejrzane',
			'accessibility.mediaCardPartiallyWatched' => ({required Object percent}) => 'obejrzano w ${percent} procentach',
			'accessibility.mediaCardUnwatched' => 'nieobejrzane',
			'accessibility.tapToPlay' => 'Dotknij, aby odtworzyć',
			'accessibility.decrease' => 'Zmniejsz',
			'accessibility.increase' => 'Zwiększ',
			'accessibility.decreaseValue' => ({required Object label}) => 'Zmniejsz ${label}',
			'accessibility.increaseValue' => ({required Object label}) => 'Zwiększ ${label}',
			'accessibility.hue' => 'Odcień',
			'accessibility.saturation' => 'Nasycenie',
			'accessibility.brightness' => 'Jasność',
			'accessibility.hexColor' => 'Kolor szesnastkowy',
			'accessibility.expandText' => 'Rozwiń tekst',
			'accessibility.collapseText' => 'Zwiń tekst',
			'accessibility.alphabetNavigation' => 'Nawigacja alfabetyczna',
			'accessibility.alphabetScrollHint' => 'Przesuń w górę lub w dół, aby przejść o literę',
			'accessibility.rowColumnPosition' => ({required Object row, required Object rowCount, required Object column, required Object columnCount}) => 'Wiersz ${row} z ${rowCount}, kolumna ${column} z ${columnCount}',
			'accessibility.rowPosition' => ({required Object row, required Object rowCount}) => 'Wiersz ${row} z ${rowCount}',
			'tooltips.shufflePlay' => 'Odtwarzanie losowe',
			'tooltips.playTrailer' => 'Odtwórz zwiastun',
			'tooltips.markAsWatched' => 'Oznacz jako obejrzane',
			'tooltips.markAsUnwatched' => 'Oznacz jako nieobejrzane',
			'audioTracks.track' => ({required Object n}) => 'Ścieżka audio ${n}',
			'videoControls.audioLabel' => 'Audio',
			'videoControls.subtitlesLabel' => 'Napisy',
			'videoControls.resetToZero' => 'Zresetuj do 0 ms',
			'videoControls.addTime' => ({required Object amount, required Object unit}) => '+${amount}${unit}',
			'videoControls.minusTime' => ({required Object amount, required Object unit}) => '-${amount}${unit}',
			'videoControls.playsLater' => ({required Object label}) => '${label}: później',
			'videoControls.playsEarlier' => ({required Object label}) => '${label}: wcześniej',
			'videoControls.noOffset' => 'Bez przesunięcia',
			'videoControls.letterbox' => 'Pasy wokół obrazu',
			'videoControls.fillScreen' => 'Wypełnij ekran',
			'videoControls.stretch' => 'Rozciągnij',
			'videoControls.lockRotation' => 'Zablokuj obrót',
			'videoControls.unlockRotation' => 'Odblokuj obrót',
			'videoControls.timerActive' => 'Wyłącznik aktywny',
			'videoControls.playbackWillPauseIn' => ({required Object duration}) => 'Odtwarzanie zatrzyma się za ${duration}',
			'videoControls.sleepTimerEndOfVideo' => 'Koniec bieżącego wideo',
			'videoControls.sleepTimerStopAtHeader' => 'Zatrzymaj o',
			'videoControls.sleepTimerDurationHeader' => 'Minutnik',
			'videoControls.playbackWillPauseAtEnd' => 'Odtwarzanie zatrzyma się na końcu tego wideo',
			'videoControls.stillWatching' => 'Nadal oglądasz?',
			'videoControls.pausingIn' => ({required Object seconds}) => 'Pauza za ${seconds}s',
			'videoControls.continueWatching' => 'Kontynuuj',
			'videoControls.autoPlayNext' => 'Automatycznie odtwórz następny',
			'videoControls.playNext' => 'Odtwórz następny',
			'videoControls.playButton' => 'Odtwórz',
			'videoControls.pauseButton' => 'Pauza',
			'videoControls.showPlaybackControls' => 'Pokaż elementy sterujące odtwarzaniem',
			'videoControls.hidePlaybackControls' => 'Ukryj elementy sterujące odtwarzaniem',
			'videoControls.seekBackwardButton' => ({required Object seconds}) => 'Przewiń do tyłu o ${seconds} sekund',
			'videoControls.seekForwardButton' => ({required Object seconds}) => 'Przewiń do przodu o ${seconds} sekund',
			'videoControls.previousButton' => 'Poprzedni odcinek',
			'videoControls.nextButton' => 'Następny odcinek',
			'videoControls.previousChapterButton' => 'Poprzedni rozdział',
			'videoControls.nextChapterButton' => 'Następny rozdział',
			'videoControls.muteButton' => 'Wycisz',
			'videoControls.unmuteButton' => 'Wyłącz wyciszenie',
			'videoControls.settingsButton' => 'Ustawienia odtwarzania',
			'videoControls.tracksButton' => 'Audio i napisy',
			'videoControls.chaptersButton' => 'Rozdziały',
			'videoControls.versionQualityButton' => 'Wersja i jakość',
			'videoControls.versionColumnHeader' => 'Wersja',
			'videoControls.qualityColumnHeader' => 'Jakość',
			'videoControls.qualityOriginal' => 'Oryginalna',
			'videoControls.qualityPresetLabel' => ({required Object resolution, required Object bitrate}) => '${resolution}p ${bitrate} Mbps',
			'videoControls.transcodeUnavailableFallback' => 'Transkodowanie niedostępne — odtwarzanie w oryginalnej jakości',
			'videoControls.subtitleUnavailableFallback' => 'Nie udało się wczytać wybranych napisów — odtwarzanie jest kontynuowane bez napisów',
			'videoControls.pipButton' => 'Tryb obraz w obrazie',
			'videoControls.aspectRatioButton' => 'Proporcje',
			'videoControls.ambientLighting' => 'Oświetlenie otoczenia',
			'videoControls.rotationLockButton' => 'Blokada obrotu',
			'videoControls.lockScreen' => 'Zablokuj ekran',
			'videoControls.screenLockButton' => 'Blokada ekranu',
			'videoControls.longPressToUnlock' => 'Przytrzymaj, aby odblokować',
			'videoControls.timelineSlider' => 'Oś czasu wideo',
			'videoControls.volumeSlider' => 'Poziom głośności',
			'videoControls.endsAt' => ({required Object time}) => 'Kończy się o ${time}',
			'videoControls.pipActive' => 'Odtwarzanie w trybie obraz w obrazie',
			'videoControls.pipFailed' => 'Nie udało się uruchomić trybu obraz w obrazie',
			'videoControls.screenshotSaved' => 'Zrzut ekranu zapisany',
			'videoControls.zoomPercent' => ({required Object percent}) => 'Powiększenie ${percent}%',
			'videoControls.pipErrors.androidVersion' => 'Wymaga Androida 8.0 lub nowszego',
			'videoControls.pipErrors.iosVersion' => 'Wymaga iOS 15.0 lub nowszego',
			'videoControls.pipErrors.permissionDisabled' => 'Obraz w obrazie jest wyłączony. Włącz go w ustawieniach systemu.',
			'videoControls.pipErrors.notSupported' => 'Urządzenie nie obsługuje trybu obraz w obrazie',
			'videoControls.pipErrors.voSwitchFailed' => 'Nie udało się przełączyć wyjścia wideo dla trybu obraz w obrazie',
			'videoControls.pipErrors.failed' => 'Nie udało się uruchomić trybu obraz w obrazie',
			'videoControls.pipErrors.unknown' => ({required Object error}) => 'Wystąpił błąd: ${error}',
			'videoControls.chapters' => 'Rozdziały',
			'videoControls.noChaptersAvailable' => 'Brak dostępnych rozdziałów',
			'videoControls.queue' => 'Kolejka',
			'videoControls.noQueueItems' => 'Brak elementów w kolejce',
			'messages.markedAsWatched' => 'Oznaczono jako obejrzane',
			'messages.markedAsUnwatched' => 'Oznaczono jako nieobejrzane',
			'messages.markedAsWatchedOffline' => 'Oznaczono jako obejrzane (zsynchronizuje się po połączeniu)',
			'messages.markedAsUnwatchedOffline' => 'Oznaczono jako nieobejrzane (zsynchronizuje się po połączeniu)',
			'messages.autoRemovedWatchedDownload' => ({required Object title}) => 'Automatycznie usunięto: ${title}',
			'messages.autoRemovedWatchedDownloads' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(n, one: 'Automatycznie usunięto ${n} obejrzane pobranie', few: 'Automatycznie usunięto ${n} obejrzane pobrania', many: 'Automatycznie usunięto ${n} obejrzanych pobrań', other: 'Automatycznie usunięto ${n} obejrzanego pobrania', ), 
			'messages.removedFromContinueWatching' => 'Usunięto z kontynuowania oglądania',
			'messages.errorLoading' => ({required Object error}) => 'Błąd: ${error}',
			'messages.streamInterrupted' => 'Strumień został przerwany. Naciśnij odtwarzanie lub przewiń, aby spróbować ponownie.',
			'messages.fileInfoNotAvailable' => 'Informacje o pliku niedostępne',
			'messages.playbackAuthenticationRequired' => 'Zaloguj się ponownie na serwerze multimediów, aby odtworzyć ten element.',
			'messages.playbackServerUnavailable' => 'Serwer multimediów jest niedostępny. Spróbuj ponownie później.',
			'messages.playbackDataInvalid' => 'Serwer zwrócił nieprawidłowe informacje o odtwarzaniu.',
			'messages.playbackCancelled' => 'Odtwarzanie zostało anulowane.',
			'messages.playbackFailed' => 'Nie udało się rozpocząć odtwarzania.',
			'messages.errorLoadingFileInfo' => ({required Object error}) => 'Błąd ładowania informacji o pliku: ${error}',
			'messages.errorLoadingSeries' => 'Błąd ładowania serialu',
			'messages.musicNotSupported' => 'Odtwarzanie muzyki nie jest jeszcze obsługiwane',
			'messages.noDescriptionAvailable' => 'Brak dostępnego opisu',
			'messages.noProfilesAvailable' => 'Brak dostępnych profili',
			'messages.contactAdminForProfiles' => 'Skontaktuj się z administratorem serwera, aby dodać profile',
			'messages.unableToDetermineLibrarySection' => 'Nie można określić sekcji biblioteki dla tego elementu',
			'messages.logsCleared' => 'Logi wyczyszczone',
			'messages.logsCopied' => 'Logi skopiowane do schowka',
			'messages.noLogsAvailable' => 'Brak dostępnych logów',
			_ => null,
		} ?? switch (path) {
			'messages.metadataRefreshing' => ({required Object title}) => 'Odświeżanie metadanych "${title}"...',
			'messages.metadataRefreshStarted' => ({required Object title}) => 'Rozpoczęto odświeżanie metadanych "${title}"',
			'messages.metadataRefreshFailed' => ({required Object error}) => 'Nie udało się odświeżyć metadanych: ${error}',
			'messages.logoutConfirm' => 'Czy na pewno chcesz się wylogować?',
			'messages.noSeasonsFound' => 'Nie znaleziono sezonów',
			'messages.seasonsLoadFailed' => 'Nie udało się załadować sezonów',
			'messages.noEpisodesFound' => 'Nie znaleziono odcinków w pierwszym sezonie',
			'messages.noEpisodesFoundGeneral' => 'Nie znaleziono odcinków',
			'messages.episodesLoadFailed' => 'Nie udało się załadować odcinków',
			'messages.noResultsFound' => 'Nie znaleziono wyników',
			'messages.sleepTimerSet' => ({required Object label}) => 'Wyłącznik czasowy ustawiony na ${label}',
			'messages.noItemsAvailable' => 'Brak dostępnych elementów',
			'messages.failedToCreatePlayQueueNoItems' => 'Nie udało się utworzyć kolejki odtwarzania — brak elementów',
			'messages.failedPlayback' => ({required Object action, required Object error}) => 'Nie udało się ${action}: ${error}',
			'messages.switchingToCompatiblePlayer' => 'Przełączanie na kompatybilny odtwarzacz...',
			'messages.serverLimitTitle' => 'Odtwarzanie nie powiodło się',
			'messages.serverLimitBody' => 'Błąd serwera (HTTP 500). Limit przepustowości/transkodowania prawdopodobnie odrzucił tę sesję. Poproś właściciela o zmianę.',
			'messages.logsUploaded' => 'Logi przesłane',
			'messages.logsUploadFailed' => 'Nie udało się przesłać logów',
			'messages.logId' => 'ID logu',
			'subtitlingStyling.text' => 'Tekst',
			'subtitlingStyling.border' => 'Obramowanie',
			'subtitlingStyling.background' => 'Tło',
			'subtitlingStyling.fontSize' => 'Rozmiar czcionki',
			'subtitlingStyling.textColor' => 'Kolor tekstu',
			'subtitlingStyling.borderSize' => 'Rozmiar obramowania',
			'subtitlingStyling.borderColor' => 'Kolor obramowania',
			'subtitlingStyling.backgroundOpacity' => 'Przezroczystość tła',
			'subtitlingStyling.backgroundColor' => 'Kolor tła',
			'subtitlingStyling.position' => 'Pozycja',
			'subtitlingStyling.assOverride' => 'Nadpisywanie ASS',
			'subtitlingStyling.overrideScale' => 'Skaluj',
			'subtitlingStyling.overrideForce' => 'Wymuś',
			'subtitlingStyling.overrideStrip' => 'Usuń style',
			'subtitlingStyling.positionTop' => 'Góra',
			'subtitlingStyling.positionBottom' => 'Dół',
			'subtitlingStyling.bold' => 'Pogrubienie',
			'subtitlingStyling.italic' => 'Kursywa',
			'subtitlingStyling.renderResolution' => 'Rozdzielczość renderowania',
			'subtitlingStyling.renderResolutionScreen' => 'Rozdzielczość ekranu',
			'subtitlingStyling.renderResolutionVideo' => 'Rozdzielczość wideo',
			'mpvConfig.title' => 'mpv.conf',
			'mpvConfig.description' => 'Zaawansowane ustawienia odtwarzacza wideo',
			'mpvConfig.presets' => 'Ustawienia wstępne',
			'mpvConfig.noPresets' => 'Brak zapisanych ustawień wstępnych',
			'mpvConfig.saveAsPreset' => 'Zapisz jako ustawienie wstępne...',
			'mpvConfig.presetName' => 'Nazwa ustawienia wstępnego',
			'mpvConfig.presetNameHint' => 'Wprowadź nazwę tego ustawienia wstępnego',
			'mpvConfig.loadPreset' => 'Wczytaj',
			'mpvConfig.deletePreset' => 'Usuń',
			'mpvConfig.presetSaved' => 'Zapisano ustawienie wstępne',
			'mpvConfig.presetLoaded' => 'Wczytano ustawienie wstępne',
			'mpvConfig.presetDeleted' => 'Usunięto ustawienie wstępne',
			'mpvConfig.confirmDeletePreset' => 'Czy na pewno chcesz usunąć to ustawienie wstępne?',
			'mpvConfig.configPlaceholder' => 'gpu-api=vulkan\nhwdec=auto\n# comment',
			'dialog.confirmAction' => 'Potwierdź działanie',
			'profiles.addPlezyProfile' => 'Dodaj profil Plezy',
			'profiles.switchingProfile' => 'Przełączanie profilu…',
			'profiles.deleteThisProfileTitle' => 'Usunąć ten profil?',
			'profiles.deleteThisProfileMessage' => ({required Object displayName}) => 'Usuń ${displayName}. Połączenia nie zostaną zmienione.',
			'profiles.active' => 'Aktywny',
			'profiles.manage' => 'Zarządzaj',
			'profiles.delete' => 'Usuń',
			'profiles.sectionTitle' => 'Profile',
			'profiles.summarySingle' => 'Dodaj profile, aby łączyć użytkowników zarządzanych z profilami lokalnymi',
			'profiles.summaryMultipleWithActive' => ({required Object count, required Object activeName}) => 'Liczba profili: ${count} · aktywny: ${activeName}',
			'profiles.summaryMultiple' => ({required Object count}) => 'Liczba profili: ${count}',
			'profiles.removeConnectionTitle' => 'Usunąć połączenie?',
			'profiles.removeConnectionMessage' => ({required Object displayName, required Object connectionLabel}) => 'Usuń dostęp ${displayName} do ${connectionLabel}. Inne profile go zachowają.',
			'profiles.deleteProfileTitle' => 'Usunąć profil?',
			'profiles.deleteProfileMessage' => ({required Object displayName}) => 'Usuń ${displayName} i jego połączenia. Serwery pozostaną dostępne.',
			'profiles.profileNameLabel' => 'Nazwa profilu',
			'profiles.pinProtectionLabel' => 'Ochrona PIN-em',
			'profiles.setPin' => 'Ustaw PIN',
			'profiles.setPinTitle' => 'Ustaw PIN',
			'profiles.confirmPinTitle' => 'Potwierdź PIN',
			'profiles.pinSet' => 'PIN ustawiony',
			'profiles.changePin' => 'Zmień',
			'profiles.removePin' => 'Usuń',
			'profiles.connectionsLabel' => 'Połączenia',
			'profiles.add' => 'Dodaj',
			'profiles.deleteProfileButton' => 'Usuń profil',
			'profiles.noConnectionsHint' => 'Brak połączeń — dodaj jedno, aby używać tego profilu.',
			'profiles.noConnections' => 'Brak połączeń',
			'profiles.connectionDefault' => 'Domyślne',
			'profiles.makeDefault' => 'Ustaw jako domyślne',
			'profiles.removeConnection' => 'Usuń',
			'profiles.profileRenamed' => 'Zmieniono nazwę profilu.',
			'profiles.borrowAddTo' => ({required Object displayName}) => 'Dodaj do ${displayName}',
			'profiles.borrowExplain' => 'Skorzystaj z połączenia innego profilu. Profile chronione PIN-em wymagają podania PIN-u.',
			'profiles.borrowEmpty' => 'Nie ma jeszcze żadnych dostępnych połączeń.',
			'profiles.borrowEmptySubtitle' => 'Najpierw połącz Plex lub Jellyfin z innym profilem.',
			'profiles.borrowLoadFailed' => 'Nie udało się wczytać dostępnych połączeń. Spróbuj ponownie.',
			'profiles.borrowFromProfile' => ({required Object displayName}) => 'Z profilu ${displayName}',
			'profiles.borrowConnectionBorrowed' => 'Dodano połączenie z innego profilu.',
			'profiles.borrowFailed' => 'Nie udało się dodać połączenia z innego profilu.',
			'profiles.incorrectPin' => 'Nieprawidłowy PIN.',
			'profiles.incorrectPinTryAgain' => 'Nieprawidłowy PIN. Spróbuj ponownie.',
			'profiles.newProfile' => 'Nowy profil',
			'profiles.profileNameHint' => 'np. Goście, Dzieci, Salon',
			'profiles.pinProtectionOptional' => 'Ochrona PIN-em (opcjonalnie)',
			'profiles.pinExplain' => 'Do przełączania profili wymagany jest 4-cyfrowy PIN.',
			'profiles.continueButton' => 'Kontynuuj',
			'profiles.pinsDontMatch' => 'PIN-y nie pasują',
			'connections.sectionTitle' => 'Połączenia',
			'connections.addConnection' => 'Dodaj połączenie',
			'connections.addConnectionSubtitleNoProfile' => 'Zaloguj się przez Plex lub połącz serwer Jellyfin',
			'connections.addConnectionSubtitleScoped' => ({required Object displayName}) => 'Dodaj do ${displayName}: Plex, Jellyfin lub połączenie innego profilu',
			'connections.sessionExpiredOne' => ({required Object name}) => 'Sesja wygasła dla ${name}',
			'connections.sessionExpiredMany' => ({required Object count}) => 'Sesja wygasła dla ${count} serwerów',
			'connections.signInAgain' => 'Zaloguj się ponownie',
			'connections.editJellyfinTitle' => 'Edytuj połączenie Jellyfin',
			'connections.editJellyfinIntro' => ({required Object serverName}) => 'Dodaj lub usuń adresy URL dla ${serverName}. Plezy użyje osiągalnego URL-a o najniższym opóźnieniu.',
			'discover.title' => 'Odkryj',
			'discover.noContentAvailable' => 'Brak dostępnych treści',
			'discover.addMediaToLibraries' => 'Dodaj multimedia do swoich bibliotek',
			'discover.continueWatching' => 'Kontynuuj oglądanie',
			'discover.continueWatchingIn' => ({required Object library}) => 'Kontynuuj oglądanie w ${library}',
			'discover.nextUp' => 'Następny odcinek',
			'discover.nextUpIn' => ({required Object library}) => 'Następny odcinek w ${library}',
			'discover.recentlyAdded' => 'Ostatnio dodane',
			'discover.recentlyAddedIn' => ({required Object library}) => 'Ostatnio dodane w ${library}',
			'discover.latestAlbumsIn' => ({required Object library}) => 'Najnowsze albumy w ${library}',
			'discover.recentlyPlayedIn' => ({required Object library}) => 'Ostatnio odtwarzane w ${library}',
			'discover.mostPlayedIn' => ({required Object library}) => 'Najczęściej odtwarzane w ${library}',
			'discover.playEpisode' => ({required Object season, required Object episode}) => 'S${season}E${episode}',
			'discover.cast' => 'Obsada',
			'discover.extras' => 'Zwiastuny i dodatki',
			'discover.studio' => 'Studio',
			'discover.director' => 'Reżyser',
			'discover.directors' => 'Reżyserzy',
			'discover.movie' => 'Film',
			'discover.tvShow' => 'Serial TV',
			'discover.minutesLeft' => ({required Object minutes}) => 'Pozostało ${minutes} min',
			'discover.moreLikeThis' => 'Więcej podobnych',
			'errors.searchFailed' => ({required Object error}) => 'Wyszukiwanie nie powiodło się: ${error}',
			'errors.connectionTimeout' => ({required Object context}) => 'Limit czasu połączenia przy ładowaniu ${context}',
			'errors.connectionFailed' => 'Nie można połączyć się z serwerem multimediów',
			'errors.unableToLoad' => ({required Object context}) => 'Nie udało się załadować ${context}. Spróbuj ponownie.',
			'errors.noClientAvailable' => 'Brak dostępnego klienta',
			'errors.failedToSwitchProfile' => ({required Object displayName}) => 'Nie udało się przełączyć na ${displayName}',
			'errors.failedToDeleteProfile' => ({required Object displayName}) => 'Nie udało się usunąć ${displayName}',
			'errors.failedToRate' => 'Nie udało się zaktualizować oceny',
			'libraries.title' => 'Biblioteki',
			'libraries.fallbackTitle' => 'Biblioteka',
			'libraries.refreshMetadata' => 'Odśwież metadane',
			'libraries.noLibrariesFound' => 'Nie znaleziono bibliotek',
			'libraries.allLibrariesHidden' => 'Wszystkie biblioteki są ukryte',
			'libraries.hiddenLibrariesCount' => ({required Object count}) => 'Ukryte biblioteki (${count})',
			'libraries.thisLibraryIsEmpty' => 'Ta biblioteka jest pusta',
			'libraries.noItemsMatchFilters' => 'Żaden element nie pasuje do aktywnych filtrów',
			'libraries.resetFilters' => 'Resetuj filtry',
			'libraries.all' => 'Wszystkie',
			'libraries.clearAll' => 'Wyczyść wszystko',
			'libraries.refreshMetadataConfirm' => ({required Object title}) => 'Czy na pewno chcesz odświeżyć metadane dla "${title}"?',
			'libraries.manageLibraries' => 'Zarządzaj bibliotekami',
			'libraries.sort' => 'Sortuj',
			'libraries.sortBy' => 'Sortuj wg',
			'libraries.filters' => 'Filtry',
			'libraries.confirmActionMessage' => 'Czy na pewno chcesz wykonać tę operację?',
			'libraries.showLibrary' => 'Pokaż bibliotekę',
			'libraries.hideLibrary' => 'Ukryj bibliotekę',
			'libraries.libraryOptions' => 'Opcje biblioteki',
			'libraries.content' => 'zawartość biblioteki',
			'libraries.selectLibrary' => 'Wybierz bibliotekę',
			'libraries.filtersWithCount' => ({required Object count}) => 'Filtry (${count})',
			'libraries.noRecommendations' => 'Brak dostępnych rekomendacji',
			'libraries.noCollections' => 'Brak kolekcji w tej bibliotece',
			'libraries.noFoldersFound' => 'Nie znaleziono folderów',
			'libraries.folders' => 'foldery',
			'libraries.tabs.recommended' => 'Polecane',
			'libraries.tabs.browse' => 'Przeglądaj',
			'libraries.tabs.collections' => 'Kolekcje',
			'libraries.tabs.playlists' => 'Playlisty',
			'libraries.groupings.title' => 'Grupowanie',
			'libraries.groupings.all' => 'Wszystkie',
			'libraries.groupings.movies' => 'Filmy',
			'libraries.groupings.shows' => 'Seriale TV',
			'libraries.groupings.seasons' => 'Sezony',
			'libraries.groupings.episodes' => 'Odcinki',
			'libraries.groupings.artists' => 'Wykonawcy',
			'libraries.groupings.albums' => 'Albumy',
			'libraries.groupings.tracks' => 'Utwory',
			'libraries.groupings.folders' => 'Foldery',
			'libraries.filterCategories.genre' => 'Gatunek',
			'libraries.filterCategories.year' => 'Rok',
			'libraries.filterCategories.contentRating' => 'Klasyfikacja wiekowa',
			'libraries.filterCategories.tag' => 'Tag',
			'libraries.filterCategories.unwatched' => 'Nieobejrzane',
			'libraries.filterCategories.unplayed' => 'Nieodtworzone',
			'libraries.filterCategories.favorites' => 'Ulubione',
			'libraries.sortLabels.title' => 'Tytuł',
			'libraries.sortLabels.dateAdded' => 'Data dodania',
			'libraries.sortLabels.communityRating' => 'Ocena społeczności',
			'libraries.sortLabels.criticRating' => 'Ocena krytyków',
			'libraries.sortLabels.datePlayed' => 'Data odtworzenia',
			'libraries.sortLabels.playCount' => 'Liczba odtworzeń',
			'libraries.sortLabels.productionYear' => 'Rok produkcji',
			'libraries.sortLabels.runtime' => 'Czas trwania',
			'libraries.sortLabels.officialRating' => 'Oficjalna klasyfikacja',
			'libraries.sortLabels.premiereDate' => 'Data premiery',
			'libraries.sortLabels.startDate' => 'Data rozpoczęcia',
			'libraries.sortLabels.airTime' => 'Godzina emisji',
			'libraries.sortLabels.studio' => 'Studio',
			'libraries.sortLabels.random' => 'Losowo',
			'libraries.sortLabels.lastEpisodeDateAdded' => 'Data dodania ostatniego odcinka',
			'about.title' => 'O aplikacji',
			'about.openSourceLicenses' => 'Licencje oprogramowania open source',
			'about.versionLabel' => ({required Object version}) => 'Wersja ${version}',
			'about.appDescription' => 'Piękny klient Plex i Jellyfin stworzony we Flutterze',
			'about.viewLicensesDescription' => 'Wyświetl licencje bibliotek innych firm',
			'hubDetail.title' => 'Tytuł',
			'hubDetail.releaseYear' => 'Rok premiery',
			'hubDetail.dateAdded' => 'Data dodania',
			'hubDetail.rating' => 'Ocena',
			'hubDetail.noItemsFound' => 'Nie znaleziono elementów',
			'logs.clearLogs' => 'Wyczyść logi',
			'logs.copyLogs' => 'Kopiuj logi',
			'logs.uploadLogs' => 'Prześlij logi',
			'licenses.relatedPackages' => 'Powiązane pakiety',
			'licenses.license' => 'Licencja',
			'licenses.licenseNumber' => ({required Object number}) => 'Licencja ${number}',
			'licenses.licensesCount' => ({required Object count}) => 'Liczba licencji: ${count}',
			'navigation.libraries' => 'Biblioteki',
			'navigation.downloads' => 'Pobrania',
			'navigation.explore' => 'Przeglądaj',
			'explore.title' => 'Przeglądaj',
			'explore.selectSource' => 'Wybierz źródło',
			'explore.rows.watchlist' => 'Lista do obejrzenia',
			'explore.rows.recommendedMovies' => 'Rekomendowane filmy',
			'explore.rows.recommendedShows' => 'Rekomendowane seriale',
			'explore.rows.trendingMovies' => 'Filmy na czasie',
			'explore.rows.trendingShows' => 'Seriale na czasie',
			'explore.rows.popularMovies' => 'Popularne filmy',
			'explore.rows.popularShows' => 'Popularne seriale',
			'explore.rows.trendingAnime' => 'Anime na czasie',
			'explore.rows.suggestedAnime' => 'Sugerowane anime',
			'explore.rows.airingAnime' => 'Najpopularniejsze emitowane anime',
			'explore.rows.popularAnime' => 'Najpopularniejsze anime',
			'explore.rows.trending' => 'Na czasie',
			'explore.rows.upcomingMovies' => 'Nadchodzące filmy',
			'explore.rows.upcomingShows' => 'Nadchodzące seriale',
			'explore.status.airing' => 'W emisji',
			'explore.status.ended' => 'Zakończony',
			'explore.status.canceled' => 'Anulowany',
			'explore.status.upcoming' => 'Nadchodzący',
			'explore.episodeCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(n, one: '${n} odcinek', few: '${n} odcinki', many: '${n} odcinków', other: '${n} odcinka', ), 
			'explore.cast' => 'Obsada',
			'explore.characters' => 'Postacie',
			'explore.addToWatchlist' => 'Dodaj do listy do obejrzenia',
			'explore.removeFromWatchlist' => 'Usuń z listy do obejrzenia',
			'explore.watchlistUpdateFailed' => 'Nie udało się zaktualizować listy do obejrzenia',
			'explore.notInLibrary' => 'Nie ma tego w Twojej bibliotece',
			'explore.inTheseLibraries' => 'W tych bibliotekach',
			'explore.checkingLibrary' => 'Sprawdzanie Twojej biblioteki...',
			'explore.emptyTitle' => 'Jeszcze nic tu nie ma',
			'explore.emptyMessage' => ({required Object source}) => 'Wiersze z ${source} pojawią się tutaj, gdy będą zawierać treści.',
			'explore.searchHint' => ({required Object source}) => 'Szukaj w ${source}',
			'explore.searchEmpty' => ({required Object query}) => 'Brak wyników dla "${query}"',
			'explore.searchPrompt' => ({required Object source}) => 'Szukaj filmów i seriali w ${source}.',
			'explore.searchFailed' => 'Wyszukiwanie nie powiodło się. Sprawdź połączenie i spróbuj ponownie.',
			'collections.title' => 'Kolekcje',
			'collections.collection' => 'Kolekcja',
			'collections.empty' => 'Kolekcja jest pusta',
			'collections.deleteCollection' => 'Usuń kolekcję',
			'collections.deleteConfirm' => ({required Object title}) => 'Usunąć "${title}"? Tego nie można cofnąć.',
			'collections.deleted' => 'Kolekcja usunięta',
			'collections.deleteFailed' => 'Nie udało się usunąć kolekcji',
			'collections.deleteFailedWithError' => ({required Object error}) => 'Nie udało się usunąć kolekcji: ${error}',
			'collections.selectCollection' => 'Wybierz kolekcję',
			'collections.collectionName' => 'Nazwa kolekcji',
			'collections.enterCollectionName' => 'Wprowadź nazwę kolekcji',
			'collections.addedToCollection' => 'Dodano do kolekcji',
			'collections.errorAddingToCollection' => 'Nie udało się dodać do kolekcji',
			'collections.created' => 'Kolekcja utworzona',
			'collections.removeFromCollection' => 'Usuń z kolekcji',
			'collections.removeFromCollectionConfirm' => ({required Object title}) => 'Usunąć "${title}" z tej kolekcji?',
			'collections.removedFromCollection' => 'Usunięto z kolekcji',
			'collections.removeFromCollectionFailed' => 'Nie udało się usunąć z kolekcji',
			'collections.removeFromCollectionError' => ({required Object error}) => 'Błąd usuwania z kolekcji: ${error}',
			'collections.searchCollections' => 'Szukaj kolekcji...',
			'playlists.title' => 'Playlisty',
			'playlists.playlist' => 'Playlista',
			'playlists.noPlaylists' => 'Nie znaleziono playlist',
			'playlists.create' => 'Utwórz playlistę',
			'playlists.playlistName' => 'Nazwa playlisty',
			'playlists.enterPlaylistName' => 'Wprowadź nazwę playlisty',
			'playlists.delete' => 'Usuń playlistę',
			'playlists.removeItem' => 'Usuń z playlisty',
			'playlists.smartPlaylist' => 'Inteligentna playlista',
			'playlists.itemCount' => ({required Object count}) => '${count} elementów',
			'playlists.oneItem' => '1 element',
			'playlists.emptyPlaylist' => 'Ta playlista jest pusta',
			'playlists.deleteConfirm' => 'Usunąć playlistę?',
			'playlists.deleteMessage' => ({required Object name}) => 'Czy na pewno chcesz usunąć "${name}"?',
			'playlists.created' => 'Playlista utworzona',
			'playlists.deleted' => 'Playlista usunięta',
			'playlists.itemAdded' => 'Dodano do playlisty',
			'playlists.itemRemoved' => 'Usunięto z playlisty',
			'playlists.selectPlaylist' => 'Wybierz playlistę',
			'playlists.searchPlaylists' => 'Szukaj playlist...',
			'playlists.errorCreating' => 'Nie udało się utworzyć playlisty',
			'playlists.errorDeleting' => 'Nie udało się usunąć playlisty',
			'playlists.errorLoading' => 'Nie udało się załadować playlist',
			'playlists.errorAdding' => 'Nie udało się dodać do playlisty',
			'playlists.errorReordering' => 'Nie udało się zmienić kolejności elementu playlisty',
			'playlists.errorRemoving' => 'Nie udało się usunąć z playlisty',
			'music.goToAlbum' => 'Przejdź do albumu',
			'music.goToArtist' => 'Przejdź do wykonawcy',
			'music.instantMix' => 'Miks błyskawiczny',
			'music.playNext' => 'Odtwórz następny',
			'music.addToQueue' => 'Dodaj do kolejki',
			'music.discNumber' => ({required Object n}) => 'Płyta ${n}',
			'music.trackCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('pl'))(n, one: '${n} utwór', few: '${n} utwory', many: '${n} utworów', other: '${n} utworu', ), 
			'music.nowPlaying' => 'Teraz odtwarzane',
			'music.playingFrom' => ({required Object title}) => 'Odtwarzanie z ${title}',
			'music.queue' => 'Kolejka',
			'music.clearQueue' => 'Wyczyść kolejkę',
			'music.lyrics' => 'Tekst utworu',
			'music.noLyrics' => 'Brak tekstu utworu',
			'music.sleepTimer' => 'Wyłącznik czasowy',
			'music.sleepTimerEndOfTrack' => 'Koniec utworu',
			'music.sleepTimerMinutes' => ({required Object n}) => '${n} minut',
			'music.stopPlayback' => 'Zatrzymaj odtwarzanie',
			'music.previousTrack' => 'Poprzedni utwór',
			'music.nextTrack' => 'Następny utwór',
			'music.repeat' => 'Powtarzaj',
			'music.repeatAll' => 'Powtarzaj wszystko',
			'music.repeatOne' => 'Powtarzaj jeden',
			'downloads.title' => 'Pobrania',
			'downloads.manage' => 'Zarządzaj',
			'downloads.tvShows' => 'Seriale TV',
			'downloads.movies' => 'Filmy',
			'downloads.music' => 'Muzyka',
			'downloads.tracksQueued' => ({required Object count}) => '${count} utworów w kolejce do pobrania',
			'downloads.noDownloads' => 'Brak pobrań',
			'downloads.noDownloadsDescription' => 'Pobrane treści pojawią się tutaj do oglądania offline',
			'downloads.downloadNow' => 'Pobierz',
			'downloads.deleteDownload' => 'Usuń pobranie',
			'downloads.retryDownload' => 'Ponów pobieranie',
			'downloads.downloadQueued' => 'Pobranie w kolejce',
			'downloads.downloadResumed' => 'Pobieranie wznowione',
			'downloads.serverErrorBitrate' => 'Błąd serwera: plik może przekraczać zdalny limit bitrate',
			'downloads.storageFull' => 'Pobieranie zostało zatrzymane, ponieważ pamięć urządzenia jest pełna. Zwolnij miejsce i spróbuj ponownie.',
			'downloads.episodesQueued' => ({required Object count}) => '${count} odcinków w kolejce pobierania',
			'downloads.downloadDeleted' => 'Pobranie usunięte',
			'downloads.deleteConfirm' => ({required Object title}) => 'Usunąć "${title}" z tego urządzenia?',
			'downloads.cancelledDownloadTitle' => 'Anulowane pobieranie',
			'downloads.cancelledDownloadMessage' => 'To pobieranie zostało anulowane. Co chcesz zrobić?',
			'downloads.allEpisodesAlreadyDownloaded' => 'Wszystkie odcinki są już pobrane',
			'downloads.resumeDownload' => 'Wznów pobieranie',
			'downloads.cancelledDownload' => 'Anulowane pobieranie',
			'downloads.syncingFile' => ({required Object file, required Object status}) => '${file} (synchronizowanie ${status})',
			'downloads.downloadedFileClickToComplete' => ({required Object file}) => 'Pobrano ${file} — kliknij, aby dokończyć',
			'downloads.partialDownloadClickToComplete' => 'Pobrano częściowo — kliknij, aby dokończyć',
			'downloads.deleting' => 'Usuwanie...',
			'downloads.deletingWithProgress' => ({required Object title, required Object current, required Object total}) => 'Usuwanie ${title}... (${current} z ${total})',
			'downloads.queuedTooltip' => 'W kolejce',
			'downloads.queuedFilesTooltip' => ({required Object files}) => 'W kolejce: ${files}',
			'downloads.downloadingTooltip' => 'Pobieranie...',
			'downloads.downloadingFilesTooltip' => ({required Object files}) => 'Pobieranie ${files}',
			'downloads.noDownloadsTree' => 'Brak pobrań',
			'downloads.pauseAll' => 'Wstrzymaj wszystko',
			'downloads.resumeAll' => 'Wznów wszystko',
			'downloads.deleteAll' => 'Usuń wszystko',
			'downloads.selectVersion' => 'Wybierz wersję',
			'downloads.allEpisodes' => 'Wszystkie odcinki',
			'downloads.unwatchedOnly' => 'Tylko nieobejrzane',
			'downloads.nextNUnwatched' => ({required Object count}) => 'Następne ${count} nieobejrzanych',
			'downloads.customAmount' => 'Własna liczba...',
			'downloads.includeSpecials' => 'Uwzględnij odcinki specjalne',
			'downloads.howManyEpisodes' => 'Ile odcinków?',
			'downloads.invalidEpisodeCount' => 'Wprowadź prawidłową liczbę odcinków.',
			'downloads.keepSynced' => 'Synchronizuj na bieżąco',
			'downloads.downloadOnce' => 'Pobierz raz',
			'downloads.keepNUnwatched' => ({required Object count}) => 'Zachowaj ${count} nieobejrzanych',
			'downloads.editSyncRule' => 'Edytuj regułę synchronizacji',
			'downloads.removeSyncRule' => 'Usuń regułę synchronizacji',
			'downloads.removeSyncRuleConfirm' => ({required Object title}) => 'Zatrzymać synchronizację "${title}"? Pobrane odcinki zostaną zachowane.',
			'downloads.syncRuleCreated' => ({required Object count}) => 'Reguła synchronizacji utworzona — zachowywanie ${count} nieobejrzanych odcinków',
			'downloads.syncRuleUpdated' => 'Reguła synchronizacji zaktualizowana',
			'downloads.syncRuleRemoved' => 'Reguła synchronizacji usunięta',
			'downloads.syncedNewEpisodes' => ({required Object count, required Object title}) => 'Zsynchronizowano ${count} nowych odcinków dla ${title}',
			'downloads.activeSyncRules' => 'Reguły synchronizacji',
			'downloads.noSyncRules' => 'Brak reguł synchronizacji',
			'downloads.manageSyncRule' => 'Zarządzaj synchronizacją',
			'downloads.editEpisodeCount' => 'Liczba odcinków',
			'downloads.editSyncFilter' => 'Filtr synchronizacji',
			'downloads.syncAllItems' => 'Synchronizacja wszystkich elementów',
			'downloads.syncUnwatchedItems' => 'Synchronizacja nieobejrzanych elementów',
			'downloads.syncRuleServerContext' => ({required Object server, required Object status}) => 'Serwer: ${server} • ${status}',
			'downloads.syncRuleAvailable' => 'Dostępne',
			'downloads.syncRuleOffline' => 'Brak połączenia',
			'downloads.syncRuleSignInRequired' => 'Wymagane logowanie',
			'downloads.syncRuleNotAvailableForProfile' => 'Niedostępne dla bieżącego profilu',
			'downloads.syncRuleUnknownServer' => 'Nieznany serwer',
			'downloads.syncRuleListCreated' => 'Utworzono regułę synchronizacji',
			'downloads.backgroundWarning.bannerBlocked' => 'Po opuszczeniu aplikacji pobieranie zostanie zatrzymane',
			'downloads.backgroundWarning.bannerDegraded' => 'Pobieranie w tle może być ograniczone',
			'downloads.backgroundWarning.bannerAction' => 'Szczegóły',
			'downloads.backgroundWarning.sheetTitle' => 'Pobieranie w tle jest zablokowane',
			'downloads.backgroundWarning.sheetTitleDegraded' => 'Pobieranie w tle może być ograniczone',
			'downloads.backgroundWarning.sheetIntro' => 'Android uniemożliwia Plezy niezawodne pobieranie plików w tle.',
			'downloads.backgroundWarning.sheetIntroDegraded' => 'Twoje urządzenie ogranicza możliwość pobierania w tle przez Plezy.',
			'downloads.backgroundWarning.reasonBackgroundRestricted' => 'Działanie Plezy w tle jest ograniczone. Ustaw użycie baterii lub działanie w tle na „Bez ograniczeń”.',
			'downloads.backgroundWarning.reasonStandbyRestricted' => 'Android umieścił Plezy w ograniczonym trybie gotowości. Ustaw użycie baterii na „Bez ograniczeń”.',
			'downloads.backgroundWarning.reasonDownloadChannelBlocked' => 'Powiadomienia o pobieraniu są wyłączone, więc postęp i opcje sterowania mogą być niedostępne.',
			'downloads.backgroundWarning.reasonNotificationsDisabled' => 'Powiadomienia są wyłączone. W Android 13 lub nowszym są wymagane przy długim pobieraniu w tle.',
			'downloads.backgroundWarning.reasonDataSaver' => 'Oszczędzanie danych jest włączone, co blokuje pobieranie w tle przez mobilną transmisję danych. Pobieranie powinno nadal działać przez Wi-Fi.',
			'downloads.backgroundWarning.reasonOemUnknown' => 'Pobieranie wielokrotnie przerywało się, gdy Plezy działało w tle. Sprawdź ustawienia baterii lub działania w tle dla Plezy.',
			'downloads.backgroundWarning.openSettings' => 'Otwórz ustawienia',
			'downloads.backgroundWarning.stillNotWorking' => 'Pomoc dla Twojego urządzenia',
			'downloads.backgroundWarning.stillNotWorkingDescription' => 'Zobacz instrukcje dla swojego urządzenia lub, jeśli problem nadal występuje, wyślij log przez Ustawienia › Pokaż logi.',
			'downloads.backgroundWarning.dialogTitle' => 'Pobieranie może się nie zakończyć',
			'downloads.backgroundWarning.dialogDownloadAnyway' => 'Pobierz mimo to',
			'downloads.backgroundWarning.dialogFixFirst' => 'Najpierw rozwiąż problem',
			'downloads.backgroundWarning.statusTile' => 'Pobieranie w tle',
			'downloads.backgroundWarning.statusOk' => 'Działanie w tle jest dozwolone',
			'downloads.backgroundWarning.statusBlocked' => 'Zablokowane przez ustawienia systemu',
			'downloads.backgroundWarning.statusDegraded' => 'Ograniczone przez ustawienia systemu',
			'downloads.backgroundWarning.statusUnknown' => 'Jeszcze nie sprawdzono',
			'downloads.backgroundWarning.settingsUnavailable' => 'Nie udało się otworzyć ustawień systemowych na tym urządzeniu',
			'downloads.backgroundWarning.linkUnavailable' => 'Nie udało się otworzyć dontkillmyapp.com na tym urządzeniu',
			'shaders.title' => 'Shadery',
			'shaders.noShaderDescription' => 'Bez ulepszenia wideo',
			'shaders.nvscalerDescription' => 'Skalowanie obrazu NVIDIA dla ostrzejszego wideo',
			'shaders.artcnnVariantNeutral' => 'Neutralny',
			'shaders.artcnnVariantDenoise' => 'Odszumianie',
			'shaders.artcnnVariantDenoiseSharpen' => 'Odszumianie + wyostrzanie',
			'shaders.qualityFast' => 'Szybki',
			'shaders.qualityHQ' => 'Wysoka jakość',
			'shaders.mode' => 'Tryb',
			'shaders.importShader' => 'Importuj shader',
			'shaders.customShaderDescription' => 'Niestandardowy shader GLSL',
			'shaders.shaderImported' => 'Shader zaimportowany',
			'shaders.shaderImportFailed' => 'Nie udało się zaimportować shadera',
			'shaders.deleteShader' => 'Usuń shader',
			'shaders.deleteShaderConfirm' => ({required Object name}) => 'Usunąć "${name}"?',
			'videoSettings.playbackSpeed' => 'Prędkość odtwarzania',
			'videoSettings.normalSpeed' => 'Normalna',
			'videoSettings.sleepTimerActive' => ({required Object duration}) => 'Aktywny (${duration})',
			'videoSettings.zoom' => 'Powiększenie',
			'videoSettings.sleepTimer' => 'Wyłącznik czasowy',
			'videoSettings.audioSync' => 'Synchronizacja audio',
			'videoSettings.subtitleSync' => 'Synchronizacja napisów',
			'videoSettings.hdr' => 'HDR',
			'videoSettings.audioOutput' => 'Wyjście audio',
			'videoSettings.performanceOverlay' => 'Nakładka wydajności',
			'videoSettings.audioPassthrough' => 'Przekazywanie dźwięku',
			'videoSettings.audioOutputDolbyAtmos' => 'Dolby Atmos',
			'videoSettings.audioOutputDolbyAudio' => 'Dolby Audio',
			'videoSettings.audioOutputSurround' => 'Przestrzenny',
			'videoSettings.audioOutputSpatial' => 'Dźwięk przestrzenny',
			'videoSettings.audioOutputStereo' => 'Stereo',
			'videoSettings.audioNormalization' => 'Normalizacja głośności',
			'videoSettings.audioDownmix' => 'Miksowanie do stereo',
			'performanceOverlay.color' => 'Kolor',
			'performanceOverlay.performance' => 'Wydajność',
			'performanceOverlay.buffer' => 'Bufor',
			'performanceOverlay.app' => 'Aplikacja',
			'performanceOverlay.decoder' => 'Dekoder',
			'performanceOverlay.rawDecoder' => 'Surowy dekoder',
			'performanceOverlay.tunneling' => 'Tunelowanie',
			'performanceOverlay.aspect' => 'Proporcje',
			'performanceOverlay.rotation' => 'Obrót',
			'performanceOverlay.dvSource' => 'Źródło DV',
			'performanceOverlay.dvPath' => 'Ścieżka DV',
			'performanceOverlay.p7Conversion' => 'Konw. P7',
			'performanceOverlay.sampleRate' => 'Częstotliwość próbkowania',
			'performanceOverlay.pixelFormat' => 'Format pikseli',
			'performanceOverlay.hwFormat' => 'Format HW',
			'performanceOverlay.matrix' => 'Macierz',
			'performanceOverlay.primaries' => 'Barwy podstawowe',
			'performanceOverlay.transfer' => 'Charakterystyka przenoszenia',
			'performanceOverlay.renderFps' => 'FPS renderowania',
			'performanceOverlay.displayFps' => 'FPS ekranu',
			'performanceOverlay.avSync' => 'Synchronizacja A/V',
			'performanceOverlay.dropped' => 'Pominięte',
			'performanceOverlay.dvRpus' => 'DV RPU',
			'performanceOverlay.dvRpuAverage' => 'Śr. DV RPU',
			'performanceOverlay.dvSampleAverage' => 'Śr. próbki DV',
			'performanceOverlay.maxLuma' => 'Maks. luma',
			'performanceOverlay.minLuma' => 'Min. luma',
			'performanceOverlay.maxCll' => 'MaxCLL',
			'performanceOverlay.maxFall' => 'MaxFALL',
			'performanceOverlay.cacheUsed' => 'Użyta pamięć podręczna',
			'performanceOverlay.cacheLimit' => 'Limit pamięci podręcznej',
			'performanceOverlay.speed' => 'Szybkość',
			'performanceOverlay.player' => 'Odtwarzacz',
			'performanceOverlay.memory' => 'Pamięć',
			'performanceOverlay.uiFps' => 'UI FPS',
			'externalPlayer.title' => 'Zewnętrzny odtwarzacz',
			'externalPlayer.useExternalPlayer' => 'Użyj zewnętrznego odtwarzacza',
			'externalPlayer.useExternalPlayerDescription' => 'Otwieraj wideo w innej aplikacji',
			'externalPlayer.selectPlayer' => 'Wybierz odtwarzacz',
			'externalPlayer.customPlayers' => 'Niestandardowe odtwarzacze',
			'externalPlayer.systemDefault' => 'Domyślny systemowy',
			'externalPlayer.addCustomPlayer' => 'Dodaj niestandardowy odtwarzacz',
			'externalPlayer.playerName' => 'Nazwa odtwarzacza',
			'externalPlayer.playerNameHint' => 'Mój odtwarzacz',
			'externalPlayer.playerCommand' => 'Polecenie',
			'externalPlayer.playerPackage' => 'Nazwa pakietu',
			'externalPlayer.playerUrlScheme' => 'Schemat URL',
			'externalPlayer.off' => 'Wyłączony',
			'externalPlayer.launchFailed' => 'Nie udało się otworzyć zewnętrznego odtwarzacza',
			'externalPlayer.appNotInstalled' => ({required Object name}) => '${name} nie jest zainstalowany',
			'externalPlayer.playInExternalPlayer' => 'Odtwórz w zewnętrznym odtwarzaczu',
			'metadataEdit.editMetadata' => 'Edytuj...',
			'metadataEdit.screenTitle' => 'Edytuj metadane',
			'metadataEdit.basicInfo' => 'Podstawowe informacje',
			'metadataEdit.artwork' => 'Grafika',
			'metadataEdit.title' => 'Tytuł',
			_ => null,
		} ?? switch (path) {
			'metadataEdit.sortTitle' => 'Tytuł do sortowania',
			'metadataEdit.originalTitle' => 'Tytuł oryginalny',
			'metadataEdit.releaseDate' => 'Data premiery',
			'metadataEdit.contentRating' => 'Klasyfikacja wiekowa',
			'metadataEdit.studio' => 'Studio',
			'metadataEdit.tagline' => 'Slogan',
			'metadataEdit.summary' => 'Opis',
			'metadataEdit.poster' => 'Plakat',
			'metadataEdit.background' => 'Tło',
			'metadataEdit.logo' => 'Logo',
			'metadataEdit.squareArt' => 'Kwadratowy obraz',
			'metadataEdit.selectPoster' => 'Wybierz plakat',
			'metadataEdit.selectBackground' => 'Wybierz tło',
			'metadataEdit.selectLogo' => 'Wybierz logo',
			'metadataEdit.selectSquareArt' => 'Wybierz kwadratowy obraz',
			'metadataEdit.fromUrl' => 'Z URL',
			'metadataEdit.uploadFile' => 'Prześlij plik',
			'metadataEdit.enterImageUrl' => 'Wprowadź URL obrazu',
			'metadataEdit.imageUrl' => 'URL obrazu',
			'metadataEdit.metadataUpdated' => 'Metadane zaktualizowane',
			'metadataEdit.metadataUpdateFailed' => 'Nie udało się zaktualizować metadanych',
			'metadataEdit.artworkUpdated' => 'Grafika zaktualizowana',
			'metadataEdit.artworkUpdateFailed' => 'Nie udało się zaktualizować grafiki',
			'metadataEdit.noArtworkAvailable' => 'Brak dostępnej grafiki',
			'metadataEdit.artworkOption' => ({required Object index}) => 'Opcja grafiki ${index}',
			'metadataEdit.selectedArtworkOption' => ({required Object index}) => 'Opcja grafiki ${index}, wybrana',
			'metadataEdit.notSet' => 'Nie ustawiono',
			'metadataEdit.tags' => 'Tagi',
			'metadataEdit.addTag' => 'Dodaj tag',
			'metadataEdit.genre' => 'Gatunek',
			'metadataEdit.director' => 'Reżyser',
			'metadataEdit.writer' => 'Scenarzysta',
			'metadataEdit.producer' => 'Producent',
			'metadataEdit.country' => 'Kraj',
			'metadataEdit.label' => 'Etykieta',
			'trakt.title' => 'Trakt',
			'trakt.connected' => 'Połączono',
			'trakt.connectedAs' => ({required Object username}) => 'Połączono jako @${username}',
			'trakt.disconnectConfirm' => 'Rozłączyć konto Trakt?',
			'trakt.disconnectConfirmBody' => 'Plezy przestanie wysyłać zdarzenia do serwisu Trakt. Połączenie można przywrócić w dowolnym momencie.',
			'trakt.scrobble' => 'Śledzenie odtwarzania w czasie rzeczywistym',
			'trakt.scrobbleDescription' => 'Wysyłaj do serwisu Trakt zdarzenia odtwarzania, wstrzymania i zatrzymania.',
			'trakt.watchedSync' => 'Synchronizuj stan obejrzenia',
			'trakt.watchedSyncDescription' => 'Gdy oznaczysz element jako obejrzany w Plezy, zostanie on również oznaczony jako obejrzany w serwisie Trakt.',
			'seerr.title' => 'Seerr',
			'seerr.connectTitle' => 'Połącz Seerr',
			'seerr.serverUrl' => 'Adres URL serwera',
			'seerr.serverUrlHelper' => 'Adres Twojej instancji Seerr',
			'seerr.checkServer' => 'Kontynuuj',
			'seerr.signInWithJellyfin' => 'Zaloguj się przez Jellyfin',
			'seerr.signInWithEmby' => 'Zaloguj się przez Emby',
			'seerr.signInWithLocal' => 'Użyj konta lokalnego',
			'seerr.email' => 'E-mail',
			'seerr.noSignInMethods' => 'Ta instancja Seerr nie oferuje metody logowania obsługiwanej przez Plezy.',
			'seerr.instance' => 'Instancja',
			'seerr.disconnectConfirm' => 'Odłączyć Seerr?',
			'seerr.disconnectConfirmBody' => 'Plezy zapomni tę instancję Seerr. Połącz ponownie w dowolnym momencie.',
			'seerr.request' => 'Zamów',
			'seerr.request4k' => 'Zamów w 4K',
			'seerr.seasons' => 'Sezony',
			'seerr.allSeasons' => 'Wszystkie sezony',
			'seerr.advancedOptions' => 'Zaawansowane',
			'seerr.destinationServer' => 'Serwer docelowy',
			'seerr.qualityProfile' => 'Profil jakości',
			'seerr.rootFolder' => 'Folder główny',
			'seerr.languageProfile' => 'Profil językowy',
			'seerr.requestSubmitted' => 'Zamówienie wysłane',
			'seerr.requestFailed' => ({required Object error}) => 'Zamówienie nie powiodło się: ${error}',
			'seerr.requestsLoadFailed' => 'Nie udało się wczytać opcji zamówienia',
			'seerr.nothingToRequest' => 'Wszystko jest już dostępne lub zamówione.',
			'seerr.statusAvailable' => 'Dostępne',
			'seerr.statusPartiallyAvailable' => 'Częściowo dostępne',
			'seerr.statusRequested' => 'Zamówione',
			'seerr.statusProcessing' => 'Przetwarzanie',
			'services.title' => 'Usługi',
			'services.hubSubtitle' => 'Synchronizuj postęp oglądania i zamawiaj nowe tytuły.',
			'services.notConnected' => 'Nie połączono',
			'services.connectedAs' => ({required Object username}) => 'Połączono jako @${username}',
			'services.scrobble' => 'Automatycznie śledź postęp',
			'services.scrobbleDescription' => 'Aktualizuj swoją listę po ukończeniu odcinka lub filmu.',
			'services.disconnectConfirm' => ({required Object service}) => 'Odłączyć ${service}?',
			'services.disconnectConfirmBody' => ({required Object service}) => 'Plezy przestanie aktualizować ${service}. Połącz ponownie w dowolnym momencie.',
			'services.connectFailed' => ({required Object service}) => 'Nie udało się połączyć z ${service}. Spróbuj ponownie.',
			'services.names.mal' => 'MyAnimeList',
			'services.names.anilist' => 'AniList',
			'services.names.simkl' => 'Simkl',
			'services.names.seerr' => 'Seerr',
			'services.deviceCode.title' => ({required Object service}) => 'Aktywuj Plezy w ${service}',
			'services.deviceCode.body' => ({required Object url}) => 'Odwiedź ${url} i wpisz ten kod:',
			'services.deviceCode.openToActivate' => ({required Object service}) => 'Otwórz ${service}, aby aktywować',
			'services.deviceCode.copyCode' => 'Skopiuj kod aktywacyjny',
			'services.deviceCode.waitingForAuthorization' => 'Oczekiwanie na autoryzację…',
			'services.deviceCode.codeCopied' => 'Kod skopiowany',
			'services.oauthProxy.title' => ({required Object service}) => 'Zaloguj się do ${service}',
			'services.oauthProxy.body' => 'Zeskanuj ten kod QR lub otwórz URL na dowolnym urządzeniu.',
			'services.oauthProxy.openToSignIn' => ({required Object service}) => 'Otwórz ${service}, aby się zalogować',
			'services.oauthProxy.copyUrl' => 'Skopiuj adres URL logowania',
			'services.oauthProxy.urlCopied' => 'URL skopiowany',
			'services.libraryFilter.title' => 'Filtr bibliotek',
			'services.libraryFilter.subtitleAllSyncing' => 'Synchronizowanie wszystkich bibliotek',
			'services.libraryFilter.subtitleNoneSyncing' => 'Brak synchronizowanych bibliotek',
			'services.libraryFilter.subtitleBlocked' => ({required Object count}) => '${count} zablokowanych',
			'services.libraryFilter.subtitleAllowed' => ({required Object count}) => '${count} dozwolonych',
			'services.libraryFilter.mode' => 'Tryb filtra',
			'services.libraryFilter.modeBlacklist' => 'Czarna lista',
			'services.libraryFilter.modeWhitelist' => 'Biała lista',
			'services.libraryFilter.modeHintBlacklist' => 'Synchronizuj wszystkie biblioteki oprócz zaznaczonych poniżej.',
			'services.libraryFilter.modeHintWhitelist' => 'Synchronizuj tylko biblioteki zaznaczone poniżej.',
			'services.libraryFilter.libraries' => 'Biblioteki',
			'services.libraryFilter.noLibraries' => 'Brak dostępnych bibliotek',
			'addServer.addJellyfinTitle' => 'Dodaj serwer Jellyfin',
			'addServer.serverUrls' => 'Adresy URL serwera',
			'addServer.serverUrlsHelper' => 'Można podać wiele adresów URL rozdzielonych przecinkami.',
			'addServer.findServer' => 'Znajdź serwer',
			'addServer.searchingLocalServers' => 'Szukanie lokalnych serwerów Jellyfin...',
			'addServer.localServers' => 'Lokalne serwery Jellyfin',
			'addServer.username' => 'Nazwa użytkownika',
			'addServer.password' => 'Hasło',
			'addServer.signIn' => 'Zaloguj się',
			'addServer.change' => 'Zmień',
			'addServer.required' => 'Wymagane',
			'addServer.couldNotReachServer' => ({required Object error}) => 'Nie udało się połączyć z serwerem: ${error}',
			'addServer.signInFailed' => ({required Object error}) => 'Logowanie nie powiodło się: ${error}',
			'addServer.quickConnectFailed' => ({required Object error}) => 'Quick Connect nie powiodło się: ${error}',
			'addServer.enterJellyfinUrlError' => 'Podaj URL serwera Jellyfin',
			'addServer.addConnectionTitle' => 'Dodaj połączenie',
			'addServer.addConnectionTitleScoped' => ({required Object name}) => 'Dodaj do ${name}',
			'addServer.connectToJellyfinCard' => 'Połącz z Jellyfin',
			'addServer.connectToJellyfinCardSubtitle' => 'Wpisz URL serwera, nazwę użytkownika i hasło.',
			'addServer.connectToJellyfinCardSubtitleScoped' => ({required Object name}) => 'Zaloguj się do serwera Jellyfin. Powiązane z ${name}.',
			'addServer.borrowFromAnotherProfile' => 'Pożycz z innego profilu',
			'addServer.borrowFromAnotherProfileSubtitle' => 'Użyj połączenia innego profilu. Profile chronione PIN-em wymagają podania PIN-u.',
			_ => null,
		};
	}
}
