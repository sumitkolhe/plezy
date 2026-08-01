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
class TranslationsAz extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAz({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.az,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <az>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsAz _root = this; // ignore: unused_field

	@override 
	TranslationsAz $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAz(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$az app = _Translations$app$az._(_root);
	@override late final _Translations$auth$az auth = _Translations$auth$az._(_root);
	@override late final _Translations$common$az common = _Translations$common$az._(_root);
	@override late final _Translations$screens$az screens = _Translations$screens$az._(_root);
	@override late final _Translations$update$az update = _Translations$update$az._(_root);
	@override late final _Translations$settings$az settings = _Translations$settings$az._(_root);
	@override late final _Translations$search$az search = _Translations$search$az._(_root);
	@override late final _Translations$hotkeys$az hotkeys = _Translations$hotkeys$az._(_root);
	@override late final _Translations$fileInfo$az fileInfo = _Translations$fileInfo$az._(_root);
	@override late final _Translations$mediaMenu$az mediaMenu = _Translations$mediaMenu$az._(_root);
	@override late final _Translations$rateSheet$az rateSheet = _Translations$rateSheet$az._(_root);
	@override late final _Translations$accessibility$az accessibility = _Translations$accessibility$az._(_root);
	@override late final _Translations$tooltips$az tooltips = _Translations$tooltips$az._(_root);
	@override late final _Translations$audioTracks$az audioTracks = _Translations$audioTracks$az._(_root);
	@override late final _Translations$videoControls$az videoControls = _Translations$videoControls$az._(_root);
	@override late final _Translations$messages$az messages = _Translations$messages$az._(_root);
	@override late final _Translations$subtitlingStyling$az subtitlingStyling = _Translations$subtitlingStyling$az._(_root);
	@override late final _Translations$mpvConfig$az mpvConfig = _Translations$mpvConfig$az._(_root);
	@override late final _Translations$dialog$az dialog = _Translations$dialog$az._(_root);
	@override late final _Translations$profiles$az profiles = _Translations$profiles$az._(_root);
	@override late final _Translations$connections$az connections = _Translations$connections$az._(_root);
	@override late final _Translations$discover$az discover = _Translations$discover$az._(_root);
	@override late final _Translations$errors$az errors = _Translations$errors$az._(_root);
	@override late final _Translations$libraries$az libraries = _Translations$libraries$az._(_root);
	@override late final _Translations$about$az about = _Translations$about$az._(_root);
	@override late final _Translations$hubDetail$az hubDetail = _Translations$hubDetail$az._(_root);
	@override late final _Translations$logs$az logs = _Translations$logs$az._(_root);
	@override late final _Translations$licenses$az licenses = _Translations$licenses$az._(_root);
	@override late final _Translations$navigation$az navigation = _Translations$navigation$az._(_root);
	@override late final _Translations$explore$az explore = _Translations$explore$az._(_root);
	@override late final _Translations$collections$az collections = _Translations$collections$az._(_root);
	@override late final _Translations$playlists$az playlists = _Translations$playlists$az._(_root);
	@override late final _Translations$music$az music = _Translations$music$az._(_root);
	@override late final _Translations$downloads$az downloads = _Translations$downloads$az._(_root);
	@override late final _Translations$shaders$az shaders = _Translations$shaders$az._(_root);
	@override late final _Translations$videoSettings$az videoSettings = _Translations$videoSettings$az._(_root);
	@override late final _Translations$performanceOverlay$az performanceOverlay = _Translations$performanceOverlay$az._(_root);
	@override late final _Translations$externalPlayer$az externalPlayer = _Translations$externalPlayer$az._(_root);
	@override late final _Translations$metadataEdit$az metadataEdit = _Translations$metadataEdit$az._(_root);
	@override late final _Translations$trakt$az trakt = _Translations$trakt$az._(_root);
	@override late final _Translations$seerr$az seerr = _Translations$seerr$az._(_root);
	@override late final _Translations$services$az services = _Translations$services$az._(_root);
	@override late final _Translations$addServer$az addServer = _Translations$addServer$az._(_root);
}

// Path: app
class _Translations$app$az extends Translations$app$en {
	_Translations$app$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Plezy';
}

// Path: auth
class _Translations$auth$az extends Translations$auth$en {
	_Translations$auth$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get connectToJellyfin => 'Jellyfin-ə qoşul';
	@override String get useQuickConnect => 'Sürətli Qoşulmanı istifadə et';
	@override String get quickConnectInstructions => 'Jellyfin-də Sürətli Qoşulmanı açın və bu kodu daxil edin.';
	@override String get quickConnectWaiting => 'Təsdiq gözlənilir…';
	@override String get quickConnectCancel => 'Ləğv et';
	@override String get quickConnectExpired => 'Sürətli Qoşulmanın vaxtı bitdi. Təzədən cəhd edin.';
	@override String get localDataRecoveryRequired => 'Plezy yerli daxil olma və gözləyən oxutma məlumatlarını təhlükəsiz bərpa edə bilmədi. Lütfən təzədən daxil olun.';
}

// Path: common
class _Translations$common$az extends Translations$common$en {
	_Translations$common$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Ləğv et';
	@override String get save => 'Yadda saxla';
	@override String get close => 'Bağla';
	@override String get clear => 'Təmizlə';
	@override String get reset => 'Sıfırla';
	@override String get later => 'Sonra';
	@override String get submit => 'Göndər';
	@override String get confirm => 'Təsdiqlə';
	@override String get retry => 'Təzədən cəhd et';
	@override String get logout => 'Çıxış et';
	@override String get unknown => 'Məlum deyil';
	@override String get refresh => 'Yenilə';
	@override String get yes => 'Bəli';
	@override String get no => 'Xeyr';
	@override String get delete => 'Sil';
	@override String get edit => 'Düzəliş et';
	@override String get shuffle => 'Qarışdır';
	@override String get addTo => 'Əlavə et...';
	@override String get createNew => 'Yenisini yarat';
	@override String get disconnect => 'Əlaqəni kəs';
	@override String get play => 'Oynat';
	@override String get pause => 'Fasilə';
	@override String get resume => 'Davam et';
	@override String get error => 'Xəta';
	@override String get search => 'Axtar';
	@override String get home => 'Ana səhifə';
	@override String get back => 'Geri';
	@override String get settings => 'Tənzimləmələr';
	@override String get ok => 'Oldu';
	@override String get off => 'Söndürülüb';
	@override String seasonNumber({required Object number}) => 'Mövsüm ${number}';
	@override String episodeNumberTitle({required Object number, required Object title}) => 'Seriya ${number} - ${title}';
	@override String chapterNumber({required Object number}) => 'Hissə ${number}';
	@override String get reconnect => 'Yenidən qoşul';
	@override String get viewAll => 'Hamısına bax';
	@override String get checkingNetwork => 'Şəbəkə yoxlanılır...';
	@override String get loadingServers => 'Serverlər yüklənir...';
	@override String get connectingToServers => 'Serverlərə qoşulunur...';
	@override String get startingOfflineMode => 'Oflayn rejim başladılır...';
	@override String get loading => 'Yüklənir...';
	@override String get fullscreen => 'Tam ekran';
	@override String get exitFullscreen => 'Tam ekrandan çıx';
	@override String get pressBackAgainToExit => 'Çıxmaq üçün geri düyməsinə bir daha basın';
	@override String get next => 'Növbəti';
}

// Path: screens
class _Translations$screens$az extends Translations$screens$en {
	_Translations$screens$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get licenses => 'Lisenziyalar';
	@override String get switchProfile => 'Profili dəyiş';
	@override String get subtitleStyling => 'Altyazı tənzimləmələri';
	@override String get mpvConfig => 'mpv.conf';
	@override String get logs => 'Jurnallar';
}

// Path: update
class _Translations$update$az extends Translations$update$en {
	_Translations$update$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get available => 'Yenilənmə var';
	@override String versionAvailable({required Object version}) => '${version} versiyası əlçatandır';
	@override String currentVersion({required Object version}) => 'Cari: ${version}';
	@override String get skipVersion => 'Bu versiyanı ötür';
	@override String get viewRelease => 'Buraxılışa bax';
	@override String get latestVersion => 'Siz ən son versiyadasınız';
	@override String get checkFailed => 'Yenilənmələr yoxlanıla bilmədi';
}

// Path: settings
class _Translations$settings$az extends Translations$settings$en {
	_Translations$settings$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tənzimləmələr';
	@override String get supportDeveloper => 'Plezy-yə dəstək ol';
	@override String get supportDeveloperDescription => 'İnkişafı maliyyələşdirmək üçün Liberapay vasitəsilə iyanə edin';
	@override String get language => 'Dil';
	@override String get theme => 'Mövzu';
	@override String get appearance => 'Görünüş';
	@override String get videoPlayback => 'Video oynatma';
	@override String get videoPlaybackDescription => 'Oynatma davranışını tənzimləyin';
	@override String get advanced => 'Təkmilləşdirilmiş';
	@override String get episodePosterMode => 'Seriya poster stili';
	@override String get seriesPoster => 'Serial posteri';
	@override String get seasonPoster => 'Mövsüm posteri';
	@override String get episodeThumbnail => 'Kadr önizləməsi';
	@override String get showHeroSectionDescription => 'Ana səhifədə xüsusi məzmun karuselini göstər';
	@override String get secondsLabel => 'Saniyə';
	@override String get minutesLabel => 'Dəqiqə';
	@override String get secondsShort => 'san';
	@override String get minutesShort => 'dəq';
	@override String durationHint({required Object min, required Object max}) => 'Müddəti daxil edin (${min}-${max})';
	@override String get systemTheme => 'Sistem';
	@override String get lightTheme => 'Açıq';
	@override String get darkTheme => 'Tünd';
	@override String get oledTheme => 'OLED';
	@override String get libraryDensity => 'Kitabxana sıxlığı';
	@override String get compact => 'Sıx';
	@override String get comfortable => 'Rəhat';
	@override String get tvCornerSpotlightBackdrop => 'Künc işıqlandırma fonu';
	@override String get tvCornerSpotlightBackdropDescription => 'Arxa fonu ekranı örtmək əvəzinə sağ üst küncdə göstər';
	@override String get viewMode => 'Baxış rejimi';
	@override String get gridView => 'Tor';
	@override String get listView => 'Siyahı';
	@override String get showHeroSection => 'Xüsusi bölməni göstər';
	@override String get continueWatchingAction => 'İzləməyə davam et əməliyyatı';
	@override String get continueWatchingPlay => 'Oynat';
	@override String get continueWatchingDetails => 'Ətraflı aç';
	@override String get episodeAction => 'Seriya əməliyyatı';
	@override String get episodePlay => 'Oynat';
	@override String get episodeDetails => 'Ətraflı aç';
	@override String get useGlobalHubs => 'Ana səhifə quruluşunu istifadə et';
	@override String get useGlobalHubsDescription => 'Birləşdirilmiş ana səhifə bölmələrini göstər. Əks halda kitabxana tövsiyələrini istifadə edir.';
	@override String get showServerNameOnHubs => 'Bölmələrdə server adını göstər';
	@override String get showServerNameOnHubsDescription => 'Bölmə başlıqlarında həmişə server adlarını göstər.';
	@override String get groupLibrariesByServer => 'Kitabxanaları serverə görə qrupla';
	@override String get groupLibrariesByServerDescription => 'Yan menyu kitabxanalarını hər media serverinin altında qruplaşdır.';
	@override String get alwaysKeepSidebarOpen => 'Yan menyunu həmişə açıq saxla';
	@override String get alwaysKeepSidebarOpenDescription => 'Yan menyu genişlənmiş qalır və məzmun sahəsi buna uyğunlaşır';
	@override String get showUnwatchedCount => 'Baxılmamış sayını göstər';
	@override String get showUnwatchedCountDescription => 'Seriallarda və mövsümlərdə baxılmamış seriya sayını göstər';
	@override String get showEpisodeNumberOnCards => 'Kartlarda seriya nömrəsini göstər';
	@override String get showEpisodeNumberOnCardsDescription => 'Seriya kartlarında mövsüm və seriya nömrəsini göstər';
	@override String get showSeasonPostersOnTabs => 'Mərhələlərdə mövsüm posterlərini göstər';
	@override String get showSeasonPostersOnTabsDescription => 'Hər mövsümün posterini öz bölməsinin üstündə göstər';
	@override String get tvFullCardLayout => 'Tam TV kartları';
	@override String get tvFullCardLayoutDescription => 'Aktyor adları üstündə olan yalnız şəkil tərkibli TV kartları istifadə et';
	@override String get focusGlow => 'Fokus parıltısı';
	@override String get focusGlowDescription => 'Fokuslanmış kartın ətrafında yumşaq parıltı çək';
	@override String get visualEffects => 'Vizual effektlər';
	@override String get visualEffectsAuto => 'Avtomatik';
	@override String get visualEffectsAutoDescription => 'Zəif cihazlarda effektləri avtomatik olaraq azalt';
	@override String get visualEffectsFull => 'Tam';
	@override String get visualEffectsReduced => 'Azaldılmış';
	@override String get visualEffectsReducedDescription => 'Daha az animasiya və daha aşağı keyfiyyətli şəkillər';
	@override String get hideSpoilers => 'Baxılmamış seriyalar üçün spoylerləri gizlə';
	@override String get hideSpoilersDescription => 'Baxılmamış seriyalar üçün miniatürləri və təsvirləri bulanıqlaşdır';
	@override String get playerBackend => 'Oynadıcı infrastrukturu';
	@override String get exoPlayer => 'ExoPlayer';
	@override String get mpv => 'mpv';
	@override String get hardwareDecoding => 'Avadanlıq kod açılması';
	@override String get hardwareDecodingDescription => 'Mümkün olduqda avadanlıq sürətləndirməsini istifadə et';
	@override String get bufferSize => 'Bufer həcmi';
	@override String bufferSizeMB({required Object size}) => '${size}MB';
	@override String get bufferSizeAuto => 'Avtomatik (Tövsiyə olunan)';
	@override String bufferSizeWarning({required Object heap, required Object size}) => '${heap}MB yaddaş əlçatandır. ${size}MB bufer oynatmaya təsir edə bilər.';
	@override String get defaultQualityTitle => 'Defolt keyfiyyət';
	@override String get musicQualityTitle => 'Musiqi keyfiyyəti';
	@override String get subtitleStyling => 'Altyazı tənzimləmələri';
	@override String get subtitleStylingDescription => 'Altyazı görünüşünü özünüləşdirin';
	@override String get smallSkipDuration => 'Kiçik ötürmə müddəti';
	@override String get largeSkipDuration => 'Böyük ötürmə müddəti';
	@override String get rewindOnResume => 'Davam edərkən geri sar';
	@override String secondsUnit({required Object seconds}) => '${seconds} saniyə';
	@override String get defaultSleepTimer => 'Defolt yuxu taymeri';
	@override String minutesUnit({required Object minutes}) => '${minutes} dəqiqə';
	@override String get rememberTrackSelections => 'Hər film/serial üçün səs/altyazı seçimlərini xatırla';
	@override String get rememberTrackSelectionsDescription => 'Hər məzmun üçün səs və altyazı seçimlərini yadda saxla';
	@override String get followServerTrackSelections => 'Hər epizod üçün serverin trek seçimlərini istifadə et';
	@override String get followServerTrackSelectionsDescription => 'Epizod dəyişəndə cari seçimi köçürmək əvəzinə serverdə seçilmiş səs və altyazını tətbiq et';
	@override String get showChapterMarkersOnTimeline => 'Zaman çubuğunda hissə işarələrini göstər';
	@override String get showChapterMarkersOnTimelineDescription => 'Zaman çubuğunu hissə sərhədlərinə böl';
	@override String get clickVideoTogglesPlayback => 'Oynat/fasilə üçün videoya toxun';
	@override String get clickVideoTogglesPlaybackDescription => 'İdarəetməni göstərmək əvəzinə oynatmaq/fasilə etmək üçün videoya toxun.';
	@override String get videoPlayerControls => 'Video oynadıcı idarəetmələri';
	@override String get keyboardShortcuts => 'Klaviatura qısayolları';
	@override String get keyboardShortcutsDescription => 'Klaviatura qısayollarını özünüləşdirin';
	@override String get videoPlayerNavigation => 'Video oynadıcı naviqasiyası';
	@override String get videoPlayerNavigationDescription => 'Oynadıcı idarəetmələrində hərəkət etmək üçün ox düymələrini istifadə edin';
	@override String get crashReporting => 'Xəta hesabatı';
	@override String get crashReportingDescription => 'Tətbiqi təkmilləşdirməyə kömək etmək üçün xəta hesabatları göndərin';
	@override String get debugLogging => 'Xəta saxlama jurnalı';
	@override String get debugLoggingDescription => 'Problemləri həll etmək üçün ətraflı jurnal qeydiyyatını aktivləşdirin';
	@override String get viewLogs => 'Jurnallara bax';
	@override String get viewLogsDescription => 'Tətbiq jurnallarına baxın';
	@override String get clearImageCache => 'Şəkil keşini təmizlə';
	@override String get clearImageCacheDescription => 'Keşlənmiş şəkilləri təmizləyir. Yenidən yüklənənədək şəkillər daha yavaş yüklənə bilər.';
	@override String get clearImageCacheSuccess => 'Şəkil keşi uğurla təmizləndi';
	@override String get resetSettings => 'Tənzimləmələri sıfırla';
	@override String get resetSettingsDescription => 'Defolt tənzimləmələri bərpa edin. Bu əməliyyat geri qaytarıla bilməz.';
	@override String get resetSettingsSuccess => 'Tənzimləmələr uğurla sıfırlandı';
	@override String get backup => 'Ehtiyat nüsxə';
	@override String get exportSettings => 'Tənzimləmələri ixrac et';
	@override String get exportSettingsDescription => 'Seçimlərinizi fayla yadda saxlayın';
	@override String get exportSettingsSuccess => 'Tənzimləmələr ixrac edildi';
	@override String get importSettings => 'Tənzimləmələri idxal et';
	@override String get importSettingsDescription => 'Seçimləri fayldan bərpa edin';
	@override String get importSettingsConfirm => 'Bu cari tənzimləmələrinizin üzərinə yazacaq. Davam edilsin?';
	@override String get importSettingsSuccess => 'Tənzimləmələr idxal edildi';
	@override String get importSettingsInvalidFile => 'Bu fayl düzgün Plezy tənzimləmələr faylı deyil';
	@override String get importSettingsNoUser => 'Tənzimləmələri idxal etməzdən əvvəl daxil olun';
	@override String get shortcutsReset => 'Qısayollar defolt vəziyyətə sıfırlandı';
	@override String get about => 'Haqqında';
	@override String get aboutDescription => 'Tətbiq məlumatı və lisenziyalar';
	@override String get updates => 'Yenilənmələr';
	@override String get updateAvailable => 'Yenilənmə var';
	@override String get checkForUpdates => 'Yenilənmələri yoxla';
	@override String get autoCheckUpdatesOnStartup => 'Açılışda yenilənmələri avtomatik yoxla';
	@override String get autoCheckUpdatesOnStartupDescription => 'Açılışda yenilənmə olduqda xəbərdar et';
	@override String get validationErrorEnterNumber => 'Lütfən düzgün rəqəm daxil edin';
	@override String validationErrorDuration({required Object min, required Object max, required Object unit}) => 'Müddət ${min} və ${max} ${unit} arasında olmalıdır';
	@override String shortcutAlreadyAssigned({required Object action}) => 'Qısayol artıq ${action} üçün təyin edilib';
	@override String shortcutUpdated({required Object action}) => '${action} üçün qısayol yeniləndi';
	@override String get saveFailed => 'Dəyişikliklər yadda saxlanıla bilmədi. Təzədən cəhd edin.';
	@override String get autoSkip => 'Avtomatik ötür';
	@override String get autoSkipIntro => 'Girişi avtomatik ötür';
	@override String get autoSkipIntroDescription => 'Bir neçə saniyədən sonra giriş işarələrini avtomatik ötür';
	@override String get autoSkipCredits => 'Titrləri avtomatik ötür';
	@override String get autoSkipCreditsDescription => 'Titrləri avtomatik ötür və növbəti seriyanı oynat';
	@override String get forceSkipMarkerFallback => 'Ehtiyat işarələri məcburi et';
	@override String get forceSkipMarkerFallbackDescription => 'Plex işarələri olsa belə hissə başlığı şablonlarını istifadə et';
	@override String get autoSkipDelay => 'Avtomatik ötürmə ləngiməsi';
	@override String autoSkipDelayDescription({required Object seconds}) => 'Avtomatik ötürməzdən əvvəl ${seconds} saniyə gözlə';
	@override String get introPattern => 'Giriş işarəsi şablonu';
	@override String get introPatternDescription => 'Hissə başlıqlarında giriş işarələrini tapmaq üçün Regex şablonu';
	@override String get creditsPattern => 'Titr işarəsi şablonu';
	@override String get creditsPatternDescription => 'Hissə başlıqlarında titr işarələrini tapmaq üçün Regex şablonu';
	@override String get invalidRegex => 'Səhv requlyar ifadə (Regex)';
	@override String get regex => 'Requlyar ifadə (Regex)';
	@override String get downloads => 'Yükləmələr';
	@override String get downloadLocationDescription => 'Yüklənmiş məzmunun harada saxlanacağını seçin';
	@override String get downloadLocationDefault => 'Defolt (Tətbiq yaddaşı)';
	@override String get downloadLocationCustom => 'Xüsusi məkan';
	@override String get selectFolder => 'Qovluq seç';
	@override String get resetToDefault => 'Defolt vəziyyətə sıfırla';
	@override String currentPath({required Object path}) => 'Cari: ${path}';
	@override String get downloadLocationChanged => 'Yükləmə məkanı dəyişdirildi';
	@override String get downloadLocationReset => 'Yükləmə məkanı defolt vəziyyətə sıfırlandı';
	@override String get downloadLocationInvalid => 'Seçilmiş qovluğa yazmaq olmur';
	@override String get downloadLocationPickerUnavailable => 'Qovluq seçimi bu cihazda əlçatan deyil';
	@override String get downloadOnWifiOnly => 'Yalnız Wi-Fi ilə yüklə';
	@override String get downloadOnWifiOnlyDescription => 'Mobil məlumat istifadə edildikdə yükləmələri dayandır';
	@override String get autoRemoveWatchedDownloads => 'Baxılmış yükləmələri avtomatik sil';
	@override String get autoRemoveWatchedDownloadsDescription => 'Baxılmış yükləmələri avtomatik olaraq sil';
	@override String get cellularDownloadBlocked => 'Mobil şəbəkədə yükləmələr bloklanıb. Wi-Fi istifadə edin və ya tənzimləməni dəyişin.';
	@override String get maxVolume => 'Maksimal səs';
	@override String get maxVolumeDescription => 'Sakit videolar üçün səsin 100%-dən yuxarı qalxmasına icazə ver';
	@override String maxVolumePercent({required Object percent}) => '%${percent}';
	@override String get discordRichPresence => 'Discord Rich Presence';
	@override String get discordRichPresenceDescription => 'Discord-da nəyə baxdığınızı göstərin';
	@override String get services => 'Xidmətlər';
	@override String get servicesDescription => 'Trakt, MyAnimeList, Seerr və daha çoxunu qoşun';
	@override String get manageLibrariesDescription => 'Kitabxanaları yenidən sıralayın və gizlədin';
	@override String get autoPip => 'Avtomatik Pəncərə daxilində Pəncərə (PiP)';
	@override String get autoPipDescription => 'Oynatma zamanı tətbiqdən çıxdıqda avtomatik PiP rejiminə keç';
	@override String get matchContentFrameRate => 'Kadr tezliyini uyğunlaşdır';
	@override String get matchContentFrameRateDescription => 'Ekran yenilənmə tezliyini video məzmununa uyğunlaşdır';
	@override String get matchRefreshRate => 'Yenilənmə tezliyini uyğunlaşdır';
	@override String get matchRefreshRateDescription => 'Tam ekranda ekran yenilənmə tezliyini uyğunlaşdır';
	@override String get matchDynamicRange => 'Dinamik diapazonu uyğunlaşdır';
	@override String get matchDynamicRangeDescription => 'HDR məzmun üçün HDR-ı açın, sonra SDR-a qayıdın';
	@override String get displaySwitchDelay => 'Ekran dəyişmə ləngiməsi';
	@override String get tunneledPlayback => 'Tünellənmiş oynatma';
	@override String get tunneledPlaybackDescription => 'Video tünelləməni istifadə et. HDR oynatdıqda qara ekran görünürsə söndürün.';
	@override String get audioPassthrough => 'Səsin birbaşa ötürülməsi (Passthrough)';
	@override String get audioPassthroughDescription => 'Dolby/DTS səslərini yenidən kodlamadan TV və ya resiverə göndərir. Səs gəlmirsə söndürün.';
	@override String get audioPassthroughDescriptionAppleTv => 'Atmos daxil olmaqla Dolby Digital Plus üçün Apple-ın daxili dekoderini istifadə edin. DTS və TrueHD yenə də çoxkanallı PCM kimi oynadılır. Səs gəlmirsə söndürün.';
	@override String get audioDownmix => 'Stereo-ya çevir (Downmix)';
	@override String get audioDownmixDescription => 'Çoxkanallı səsi stereo dinamiklər və ya qulaqlıqlar üçün iki kanala endirir';
	@override String get downmixCenterBoost => 'Mərkəz kanal gücləndirilməsi';
	@override String downmixCenterBoostValue({required Object db}) => '${db} dB';
	@override String get downmixCenterBoostLabel => 'Gücləndirmə (dB)';
	@override String get downmixCenterBoostShort => 'dB';
	@override String get audioDownmixNormalize => 'Çevirmədə səsi normallaşdır';
	@override String get audioDownmixNormalizeDescription => 'Səs kəsilmələrinin qarşısını almaq üçün səviyyəni endirin.';
	@override String get atmosDiagnostics => 'Atmos çıxış testi';
	@override String get atmosDiagnosticsDescription => 'Sistem oynadıcısı vasitəsilə test siqnalları çalan Dolby Atmos çıxışını yoxlayın';
	@override String get atmosTestHlsAtmos => 'Apple Atmos axını';
	@override String get atmosTestHlsAtmosDescription => 'Düzgün işlədiyi məlum olan Dolby Atmos axını. Qəbuledici Dolby Atmos göstərməlidir.';
	@override String get atmosTestHlsControl => 'Apple əhatəli səs axını';
	@override String get atmosTestHlsControlDescription => 'Atmos olmayan idarəetmə axını.';
	@override String get atmosTestRawStream => 'Xam EAC3 axını';
	@override String get atmosTestRawStreamDescription => 'Test faylını eynilə oynadıcı daxili Atmos kimi yayımlayır.';
	@override String get atmosTestRawFile => 'Xam EAC3 faylı';
	@override String get atmosTestRawFileDescription => 'Məlum uzunluqda test faylını oynadır.';
	@override String get atmosTestAsbarNative => 'Nümunə bufer rendereri (daxili)';
	@override String get atmosTestAsbarNativeDescription => 'Faylın dəyişdirilməmiş sıxılmış səsini birbaşa sistem rendererinə ötürür. Test faylının URL-i tələb olunur.';
	@override String get atmosTestAsbarGenerated => 'Nümunə bufer rendereri (yenidən qurulmuş)';
	@override String get atmosTestAsbarGeneratedDescription => 'Eyni, lakin səs təsviri oynatmanın qurduğu kimi yenidən qurulur. Test faylının URL-i tələb olunur.';
	@override String get atmosTestSessionMode => 'Film oynatma seansı rejimindən istifadə et';
	@override String get atmosTestSessionModeDescription => 'Söndürüldükdə Dolby-nin sənədləşdirdiyi rejim işlədilir. Yandırıldıqda oynatmanın əvvəl istifadə etdiyi rejim işlədilir.';
	@override String get atmosTestShowRoutePicker => 'AirPlay çıxışını seç';
	@override String get atmosTestHideRoutePicker => 'AirPlay çıxış seçicisini gizlət';
	@override String get atmosTestRoutePickerDescription => 'Testi AirPlay qəbuledicisinə göndərir. Müəyyən edilmiş səs rejimini yalnız AirPlay bildirir.';
	@override String get atmosTestStop => 'Testi saxla';
	@override String get atmosTestUrl => 'Test faylı URL-i';
	@override String get atmosTestUrlDescription => 'Xam .ec3 Dolby Atmos faylının HTTP URL-i';
	@override String get atmosTestUrlMissing => 'Əvvəlcə test faylı URL-ini təyin edin';
	@override String get atmosTestStatus => 'Status';
	@override String get dvConversionMode => 'Dolby Vision çevrilməsi';
	@override String get dvConversionModeDescription => 'ExoPlayer-in Dolby Vision Profile 7 fayllarını necə emal edəcəyini seçin.';
	@override String get dvConversionAuto => 'Avtomatik';
	@override String get dvConversionNative => 'Daxili / Söndürülüb';
	@override String get dvConversionDv81 => 'P7 → P8.1';
	@override String get dvConversionHevcStrip => 'P7 → HEVC';
	@override String get dvConversionAutoDescription => 'Cihaz imkanlarının təyini və normal davranışdan istifadə et';
	@override String get dvConversionNativeDescription => 'Daxili DV7-ni məcburi et';
	@override String get dvConversionDv81Description => 'Dolby Vision profile 8.1-ə çevrilməni məcburi et';
	@override String get dvConversionHevcStripDescription => 'Dolby Vision təbəqələrini sil və sadə HEVC kimi təqdim et';
	@override String get requireProfileSelectionOnOpen => 'Açılışda profil soruş';
	@override String get requireProfileSelectionOnOpenDescription => 'Tətbiq hər dəfə açıldıqda profil seçimini göstər';
	@override String get forceTvMode => 'TV rejimini məcburi et';
	@override String get forceTvModeDescription => 'TV interfeysini məcburi et. Avtomatik təyin etməyən cihazlar üçündür.';
	@override String get startInFullscreen => 'Tam ekranda başlat';
	@override String get startInFullscreenDescription => 'Plezy-ni açılışda tam ekran rejimində aç';
	@override String get exitFullscreenOnPlayerClose => 'Oynadıcı bağlandıqda tam ekrandan çıx';
	@override String get exitFullscreenOnPlayerCloseDescription => 'Video oynadıcını bağlayarkən avtomatik tam ekrandan çıx';
	@override String get autoHidePerformanceOverlay => 'Məhsuldarlıq paneli avtomatik gizlənsin';
	@override String get autoHidePerformanceOverlayDescription => 'Məhsuldarlıq panelini oynatıcı idarəetmələri ilə birlikdə gizlət';
	@override String get showNavBarLabels => 'Naviqasiya paneli yazılarını göstər';
	@override String get showNavBarLabelsDescription => 'Naviqasiya paneli ikonlarının altında mətni göstər';
	@override String get startupSection => 'Başlanğıc bölməsi';
	@override String get display => 'Ekran';
	@override String get homeScreen => 'Ana ekran';
	@override String get navigation => 'Naviqasiya';
	@override String get window => 'Pəncərə';
	@override String get content => 'Məzmun';
	@override String get player => 'Oynadıcı';
	@override String get subtitlesAndConfig => 'Altyazılar və konfiqurasiya';
	@override String get seekAndTiming => 'Sarğı və vaxt tənzimləməsi';
	@override String get behavior => 'Davranış';
}

// Path: search
class _Translations$search$az extends Translations$search$en {
	_Translations$search$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Kino, serial, musiqi axtar...';
	@override String get tryDifferentTerm => 'Fərqli axtarış sözü cəhd edin';
	@override String get searchYourMedia => 'Mediyanızda axtarın';
	@override String get enterTitleActorOrKeyword => 'Ad, aktyor və ya açar söz daxil edin';
}

// Path: hotkeys
class _Translations$hotkeys$az extends Translations$hotkeys$en {
	_Translations$hotkeys$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String setShortcutFor({required Object actionName}) => '${actionName} üçün qısayol təyin et';
	@override String get clearShortcut => 'Qısayolu təmizlə';
	@override String get noShortcutSet => 'Qısayol təyin edilməyib';
	@override String get currentShortcut => 'Cari qısayol:';
	@override String get pressToRecord => 'Qısayol yazmaq üçün seçin';
	@override String get recordingShortcut => 'İndi qısayol düymələrinə basın';
	@override late final _Translations$hotkeys$actions$az actions = _Translations$hotkeys$actions$az._(_root);
}

// Path: fileInfo
class _Translations$fileInfo$az extends Translations$fileInfo$en {
	_Translations$fileInfo$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fayl məlumatı';
	@override String get video => 'Video';
	@override String get audio => 'Səs';
	@override String get subtitles => 'Altyazılar';
	@override String get file => 'Fayl';
	@override String get codec => 'Kodek';
	@override String get resolution => 'Ayırdetmə';
	@override String get bitrate => 'Bit sürəti (Bitrate)';
	@override String get frameRate => 'Kadr tezliyi';
	@override String get aspectRatio => 'Tərəf nisbəti';
	@override String get profile => 'Profil';
	@override String get bitDepth => 'Bit dərinliyi';
	@override String get colorSpace => 'Rəng sahəsi';
	@override String get colorRange => 'Rəng diapazonu';
	@override String get colorPrimaries => 'Əsas rənglər';
	@override String get chromaSubsampling => 'Rəng alt-diskretləşdirməsi';
	@override String get channels => 'Kanallar';
	@override String get overallBitrate => 'Ümumi bit sürəti';
	@override String get path => 'Yol';
	@override String get size => 'Həcm';
	@override String get container => 'Konteyner';
	@override String get duration => 'Müddət';
	@override String get optimizedForStreaming => 'Yayım üçün optimallaşdırılıb';
	@override String get has64bitOffsets => '64-bit ofsetlər';
}

// Path: mediaMenu
class _Translations$mediaMenu$az extends Translations$mediaMenu$en {
	_Translations$mediaMenu$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get markAsWatched => 'Baxıldı olaraq işarələ';
	@override String get markAsUnwatched => 'Baxılmadı olaraq işarələ';
	@override String get removeFromContinueWatching => 'İzləməyə davam et-dən sil';
	@override String get viewDetails => 'Ətraflı bax';
	@override String get goToSeries => 'Seriala keç';
	@override String get shufflePlay => 'Qarışıq oynat';
	@override String get shuffleNotAvailableOffline => 'Qarışıq oynatma oflayn rejimdə əlçatan deyil';
	@override String get fileInfo => 'Fayl məlumatı';
	@override String get deleteFromServer => 'Serverdən sil';
	@override String get confirmDelete => 'Bu media və faylları serverinizdən silinsin?';
	@override String get deleteMultipleWarning => 'Bu bütün seriyaları və faylları əhatə edir.';
	@override String get mediaDeletedSuccessfully => 'Media elementi uğurla silindi';
	@override String get mediaFailedToDelete => 'Media elementi silinə bilmədi';
	@override String get rate => 'Qiymətləndir';
	@override String get playFromBeginning => 'Əvvəldən oynat';
	@override String get playVersion => 'Versiyanı oynat...';
}

// Path: rateSheet
class _Translations$rateSheet$az extends Translations$rateSheet$en {
	_Translations$rateSheet$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Qiymətləndir';
	@override String get server => 'Server';
	@override String get favorite => 'Sevimli';
	@override String get favorited => 'Sevimlilərə əlavə edildi';
	@override String get saved => 'Yadda saxlanıldı';
	@override String get notAvailable => 'Uyğunluq tapılmadı';
	@override String get noConnectedServices => 'Orada qiymətləndirmək üçün Tənzimləmələrdən xidmət qoşun.';
}

// Path: accessibility
class _Translations$accessibility$az extends Translations$accessibility$en {
	_Translations$accessibility$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String mediaCardMovie({required Object title}) => '${title}, kino';
	@override String mediaCardShow({required Object title}) => '${title}, TV şou';
	@override String mediaCardEpisode({required Object title, required Object episodeInfo}) => '${title}, ${episodeInfo}';
	@override String mediaCardSeason({required Object title, required Object seasonInfo}) => '${title}, ${seasonInfo}';
	@override String get mediaCardWatched => 'baxılıb';
	@override String mediaCardPartiallyWatched({required Object percent}) => '%${percent} baxılıb';
	@override String get mediaCardUnwatched => 'baxılmayıb';
	@override String get tapToPlay => 'Oynatmaq üçün toxunun';
	@override String get decrease => 'Azalt';
	@override String get increase => 'Artır';
	@override String decreaseValue({required Object label}) => '${label} dəyərini azalt';
	@override String increaseValue({required Object label}) => '${label} dəyərini artır';
	@override String get hue => 'Rəng çaları';
	@override String get saturation => 'Doyğunluq';
	@override String get brightness => 'Parlaqlıq';
	@override String get hexColor => 'Hex rəngi';
	@override String get expandText => 'Mətni genişləndir';
	@override String get collapseText => 'Mətni yığ';
	@override String get alphabetNavigation => 'Əlifba naviqasiyası';
	@override String get alphabetScrollHint => 'Hərflərə görə keçmək üçün yuxarı və ya aşağı sürüşdürün';
	@override String rowColumnPosition({required Object row, required Object rowCount, required Object column, required Object columnCount}) => 'Sətir ${row} / ${rowCount}, sütun ${column} / ${columnCount}';
	@override String rowPosition({required Object row, required Object rowCount}) => 'Sətir ${row} / ${rowCount}';
}

// Path: tooltips
class _Translations$tooltips$az extends Translations$tooltips$en {
	_Translations$tooltips$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get shufflePlay => 'Qarışıq oynat';
	@override String get playTrailer => 'Treyleri oynat';
	@override String get markAsWatched => 'Baxıldı olaraq işarələ';
	@override String get markAsUnwatched => 'Baxılmadı olaraq işarələ';
}

// Path: audioTracks
class _Translations$audioTracks$az extends Translations$audioTracks$en {
	_Translations$audioTracks$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String track({required Object n}) => 'Səs zolağı ${n}';
}

// Path: videoControls
class _Translations$videoControls$az extends Translations$videoControls$en {
	_Translations$videoControls$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get audioLabel => 'Səs';
	@override String get subtitlesLabel => 'Altyazı';
	@override String get resetToZero => '0ms-yə sıfırla';
	@override String addTime({required Object amount, required Object unit}) => '+${amount}${unit}';
	@override String minusTime({required Object amount, required Object unit}) => '-${amount}${unit}';
	@override String playsLater({required Object label}) => '${label} sonra oynadılır';
	@override String playsEarlier({required Object label}) => '${label} əvvəl oynadılır';
	@override String get noOffset => 'Ofset yoxdur';
	@override String get letterbox => 'Geniş ekran (Letterbox)';
	@override String get fillScreen => 'Ekrana doldur';
	@override String get stretch => 'Gərmək';
	@override String get lockRotation => 'Dönməni kilidlə';
	@override String get unlockRotation => 'Dönmə kilidini aç';
	@override String get timerActive => 'Taymer aktivdir';
	@override String playbackWillPauseIn({required Object duration}) => 'Oynatma ${duration} sonra fasilə olunacaq';
	@override String get sleepTimerEndOfVideo => 'Cari videonun sonu';
	@override String get sleepTimerStopAtHeader => 'Dayanma vaxtı';
	@override String get sleepTimerDurationHeader => 'Taymer';
	@override String get playbackWillPauseAtEnd => 'Oynatma bu videonun sonunda fasilə olunacaq';
	@override String get stillWatching => 'Hələ də baxırsınız?';
	@override String pausingIn({required Object seconds}) => '${seconds}san sonra fasilə edilir';
	@override String get continueWatching => 'Davam et';
	@override String get autoPlayNext => 'Növbətini avtomatik oynat';
	@override String get playNext => 'Növbətini oynat';
	@override String get playButton => 'Oynat';
	@override String get pauseButton => 'Fasilə';
	@override String get showPlaybackControls => 'Oynatma idarəetmələrini göstər';
	@override String get hidePlaybackControls => 'Oynatma idarəetmələrini gizlət';
	@override String seekBackwardButton({required Object seconds}) => '${seconds} saniyə geri sar';
	@override String seekForwardButton({required Object seconds}) => '${seconds} saniyə irəli sar';
	@override String get previousButton => 'Əvvəlki seriya';
	@override String get nextButton => 'Növbəti seriya';
	@override String get previousChapterButton => 'Əvvəlki hissə';
	@override String get nextChapterButton => 'Növbəti hissə';
	@override String get muteButton => 'Səsi söndür';
	@override String get unmuteButton => 'Səsi aç';
	@override String get settingsButton => 'Oynatma tənzimləmələri';
	@override String get tracksButton => 'Səs və Altyazılar';
	@override String get chaptersButton => 'Hissələr';
	@override String get versionQualityButton => 'Versiya və Keyfiyyət';
	@override String get versionColumnHeader => 'Versiya';
	@override String get qualityColumnHeader => 'Keyfiyyət';
	@override String get qualityOriginal => 'Orijinal';
	@override String qualityPresetLabel({required Object resolution, required Object bitrate}) => '${resolution}p ${bitrate} Mbps';
	@override String get transcodeUnavailableFallback => 'Kod dəyişmə əlçatan deyil — orijinal keyfiyyətdə oynadılır';
	@override String get subtitleUnavailableFallback => 'Seçilmiş altyazı yüklənə bilmədi — altyazısız davam edilir';
	@override String get pipButton => 'Pəncərə daxilində pəncərə rejimi';
	@override String get aspectRatioButton => 'Tərəf nisbəti';
	@override String get ambientLighting => 'Ətraf işıqlandırması';
	@override String get fullscreenButton => 'Tam ekrana keç';
	@override String get exitFullscreenButton => 'Tam ekrandan çıx';
	@override String get alwaysOnTopButton => 'Həmişə üstə';
	@override String get rotationLockButton => 'Dönmə kilidi';
	@override String get lockScreen => 'Ekranı kilidlə';
	@override String get screenLockButton => 'Ekran kilidi';
	@override String get longPressToUnlock => 'Kilidi açmaq üçün uzun basın';
	@override String get timelineSlider => 'Video zaman çubuğu';
	@override String get volumeSlider => 'Səs səviyyəsi';
	@override String endsAt({required Object time}) => 'Bitiş vaxtı: ${time}';
	@override String get pipActive => 'Pəncərə daxilində pəncərə rejimində oynadılır';
	@override String get pipFailed => 'PiP rejimi başladılarkən xəta';
	@override String get screenshotSaved => 'Ekran şəkli yadda saxlanıldı';
	@override String zoomPercent({required Object percent}) => 'Miqyas %${percent}';
	@override late final _Translations$videoControls$pipErrors$az pipErrors = _Translations$videoControls$pipErrors$az._(_root);
	@override String get chapters => 'Hissələr';
	@override String get noChaptersAvailable => 'Hissələr əlçatan deyil';
	@override String get queue => 'Növbə';
	@override String get noQueueItems => 'Növbədə element yoxdur';
}

// Path: messages
class _Translations$messages$az extends Translations$messages$en {
	_Translations$messages$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get markedAsWatched => 'Baxıldı olaraq işarələndi';
	@override String get markedAsUnwatched => 'Baxılmadı olaraq işarələndi';
	@override String get markedAsWatchedOffline => 'Baxıldı olaraq işarələndi (onlayn olduqda eyniləşdiriləcək)';
	@override String get markedAsUnwatchedOffline => 'Baxılmadı olaraq işarələndi (onlayn olduqda eyniləşdiriləcək)';
	@override String autoRemovedWatchedDownload({required Object title}) => 'Avtomatik silindi: ${title}';
	@override String autoRemovedWatchedDownloads({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('az'))(n,
		one: 'Baxılmış ${n} yükləmə avtomatik silindi',
		other: 'Baxılmış ${n} yükləmə avtomatik silindi',
	);
	@override String get removedFromContinueWatching => 'İzləməyə davam et-dən silindi';
	@override String errorLoading({required Object error}) => 'Xəta: ${error}';
	@override String get searchPartialResults => 'Bəzi media serverlərində axtarış aparıla bilmədi. Mövcud nəticələr göstərilir.';
	@override String get streamInterrupted => 'Yayım kəsildi. Təzədən cəhd etmək üçün oynat düyməsinə basın.';
	@override String get fileInfoNotAvailable => 'Fayl məlumatı əlçatan deyil';
	@override String get playbackAuthenticationRequired => 'Bu elementi oynatmaq üçün media serverinə yenidən daxil olun.';
	@override String get playbackServerUnavailable => 'Media serveri əlçatan deyil. Sonra təzədən cəhd edin.';
	@override String get playbackDataInvalid => 'Server yanlış oynatma məlumatı qaytardı.';
	@override String get playbackCancelled => 'Oynatma ləğv edildi.';
	@override String get playbackFailed => 'Oynatma başladılarkən xəta.';
	@override String errorLoadingFileInfo({required Object error}) => 'Fayl məlumatı yüklənərkən xəta: ${error}';
	@override String get errorLoadingSeries => 'Serial yüklənərkən xəta';
	@override String get musicNotSupported => 'Musiqi oynatması hələ dəstəklənmir';
	@override String get noDescriptionAvailable => 'Təsvir əlçatan deyil';
	@override String get noProfilesAvailable => 'Profil yoxdur';
	@override String get contactAdminForProfiles => 'Profil əlavə etmək üçün server inzibatçınızla əlaqə saxlayın';
	@override String get unableToDetermineLibrarySection => 'Bu element üçün kitabxana bölməsi müəyyən edilə bilmədi';
	@override String get logsCleared => 'Jurnallar təmizləndi';
	@override String get logsCopied => 'Jurnallar buferə kopyalandı';
	@override String get noLogsAvailable => 'Jurnal yoxdur';
	@override String metadataRefreshing({required Object title}) => '"${title}" üçün meta-məlumatlar yenilənir...';
	@override String metadataRefreshStarted({required Object title}) => '"${title}" üçün meta-məlumat yenilənməsi başladı';
	@override String metadataRefreshFailed({required Object error}) => 'Meta-məlumatlar yenilənə bilmədi: ${error}';
	@override String get logoutConfirm => 'Çıxış etmək istədiyinizdən əminsiniz?';
	@override String get noSeasonsFound => 'Mövsüm tapılmadı';
	@override String get seasonsLoadFailed => 'Mövsümlər yüklənə bilmədi';
	@override String get noEpisodesFound => 'Birinci mövsümdə seriya tapılmadı';
	@override String get noEpisodesFoundGeneral => 'Seriya tapılmadı';
	@override String get episodesLoadFailed => 'Seriyalar yüklənə bilmədi';
	@override String get noResultsFound => 'Nəticə tapılmadı';
	@override String sleepTimerSet({required Object label}) => 'Yuxu taymeri ${label} üçün təyin edildi';
	@override String get noItemsAvailable => 'Element yoxdur';
	@override String get failedToCreatePlayQueueNoItems => 'Oynatma növbəsi yaradıla bilmədi — element yoxdur';
	@override String failedPlayback({required Object action, required Object error}) => '${action} uğursuz oldu: ${error}';
	@override String get switchingToCompatiblePlayer => 'Uyğun oynadıcıya keçilir...';
	@override String get serverLimitTitle => 'Oynatma uğursuz oldu';
	@override String get serverLimitBody => 'Server xətası (HTTP 500). Məhdudiyyət bu seansı rədd etdi.';
	@override String get logsUploaded => 'Jurnallar yükləndi';
	@override String get logsUploadFailed => 'Jurnallar yüklənə bilmədi';
	@override String get logId => 'Jurnal ID-si';
}

// Path: subtitlingStyling
class _Translations$subtitlingStyling$az extends Translations$subtitlingStyling$en {
	_Translations$subtitlingStyling$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get text => 'Mətn';
	@override String get border => 'Haşiyə';
	@override String get background => 'Arxa fon';
	@override String get fontSize => 'Şrift ölçüsü';
	@override String get textColor => 'Mətn rəngi';
	@override String get borderSize => 'Haşiyə ölçüsü';
	@override String get borderColor => 'Haşiyə rəngi';
	@override String get backgroundOpacity => 'Arxa fon şəffaflığı';
	@override String get backgroundColor => 'Arxa fon rəngi';
	@override String get position => 'Mövqe';
	@override String get assOverride => 'ASS ləğvi';
	@override String get overrideScale => 'Miqyasla';
	@override String get overrideForce => 'Məcburi et';
	@override String get overrideStrip => 'Formatlaşdırmanı sil';
	@override String get positionTop => 'Yuxarı';
	@override String get positionBottom => 'Aşağı';
	@override String get bold => 'Qalın';
	@override String get italic => 'Kursiv';
	@override String get renderResolution => 'Emal imkanı (Resolution)';
	@override String get renderResolutionScreen => 'Ekran imkanı';
	@override String get renderResolutionVideo => 'Video imkanı';
}

// Path: mpvConfig
class _Translations$mpvConfig$az extends Translations$mpvConfig$en {
	_Translations$mpvConfig$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'mpv.conf';
	@override String get description => 'Təkmilləşdirilmiş video oynatıcı tənzimləmələri';
	@override String get presets => 'Ön ayarlar';
	@override String get noPresets => 'Yadda saxlanılmış ön ayar yoxdur';
	@override String get saveAsPreset => 'Ön ayar kimi yadda saxla...';
	@override String get presetName => 'Ön ayar adı';
	@override String get presetNameHint => 'Bu ön ayar üçün ad daxil edin';
	@override String get loadPreset => 'Yüklə';
	@override String get deletePreset => 'Sil';
	@override String get presetSaved => 'Ön ayar yadda saxlanıldı';
	@override String get presetLoaded => 'Ön ayar yükləndi';
	@override String get presetDeleted => 'Ön ayar silindi';
	@override String get confirmDeletePreset => 'Bu ön ayarı silmək istədiyinizə əminsiniz?';
	@override String get configPlaceholder => 'gpu-api=vulkan\nhwdec=auto\n# şərh';
}

// Path: dialog
class _Translations$dialog$az extends Translations$dialog$en {
	_Translations$dialog$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get confirmAction => 'Əməliyyatı təsdiqlə';
}

// Path: profiles
class _Translations$profiles$az extends Translations$profiles$en {
	_Translations$profiles$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get addPlezyProfile => 'Plezy profili əlavə et';
	@override String get switchingProfile => 'Profil dəyişdirilir…';
	@override String get deleteThisProfileTitle => 'Bu profil silinsin?';
	@override String deleteThisProfileMessage({required Object displayName}) => '${displayName} silinəcək. Qoşulmalar təsirlənmir.';
	@override String get active => 'Aktiv';
	@override String get manage => 'İdarə et';
	@override String get delete => 'Sil';
	@override String get signOut => 'Çıxış et';
	@override String get signOutPlexTitle => 'Plex-dən çıxılsın?';
	@override String signOutPlexMessage({required Object displayName}) => '${displayName} və bütün Plex Ev istifadəçiləri silinsin?';
	@override String get signedOutPlex => 'Plex-dən çıxıldı.';
	@override String get signOutFailed => 'Çıxış uğursuz oldu.';
	@override String get sectionTitle => 'Profillər';
	@override String get summarySingle => 'İdarə olunan istifadəçiləri və yerli kimlikləri qarışdırmaq üçün profillər əlavə edin';
	@override String summaryMultipleWithActive({required Object count, required Object activeName}) => '${count} profil · aktiv: ${activeName}';
	@override String summaryMultiple({required Object count}) => '${count} profil';
	@override String get removeConnectionTitle => 'Qoşulma silinsin?';
	@override String removeConnectionMessage({required Object displayName, required Object connectionLabel}) => '${displayName} istifadəçisinin ${connectionLabel} giriş hüququ silinəcək. Digər profillərdə qalacaq.';
	@override String get deleteProfileTitle => 'Profil silinsin?';
	@override String deleteProfileMessage({required Object displayName}) => '${displayName} və onun qoşulmaları silinəcək. Serverlər əlçatan qalır.';
	@override String get profileNameLabel => 'Profil adı';
	@override String get pinProtectionLabel => 'PIN mühafizəsi';
	@override String get setPin => 'PIN təyin et';
	@override String get setPinTitle => 'PIN təyin et';
	@override String get confirmPinTitle => 'PIN-i təsdiqlə';
	@override String get pinSet => 'PIN təyin edildi';
	@override String get changePin => 'Dəyişdir';
	@override String get removePin => 'Sil';
	@override String get connectionsLabel => 'Qoşulmalar';
	@override String get add => 'Əlavə et';
	@override String get deleteProfileButton => 'Profili sil';
	@override String get noConnectionsHint => 'Qoşulma yoxdur — bu profili istifadə etmək üçün birini əlavə edin.';
	@override String get noConnections => 'Qoşulma yoxdur';
	@override String get connectionDefault => 'Defolt';
	@override String connectionAs({required Object displayName}) => '${displayName} olaraq';
	@override String get makeDefault => 'Defolt et';
	@override String get removeConnection => 'Sil';
	@override String get profileRenamed => 'Profil adı dəyişdirildi.';
	@override String borrowAddTo({required Object displayName}) => '${displayName} profilinə əlavə et';
	@override String get borrowExplain => 'Başqa profilin qoşulmasını istifadə edin. PIN ilə qorunan profillər PIN tələb edir.';
	@override String get borrowEmpty => 'Hələ istifadə ediləcək bir şey yoxdur.';
	@override String get borrowEmptySubtitle => 'Əvvəlcə başqa bir profile Plex və ya Jellyfin qoşun.';
	@override String get borrowLoadFailed => 'Əlçatan qoşulmalar yüklənə bilmədi. Təzədən cəhd edin.';
	@override String borrowFromProfile({required Object displayName}) => '${displayName} profilindən';
	@override String get borrowConnectionBorrowed => 'Qoşulma istifadə edildi.';
	@override String get borrowFailed => 'Qoşulma istifadə edilə bilmədi.';
	@override String get incorrectPin => 'Səhv PIN.';
	@override String get incorrectPinTryAgain => 'Səhv PIN. Lütfən təzədən cəhd edin.';
	@override String get newProfile => 'Yeni profil';
	@override String get profileNameHint => 'məs. Qonaqlar, Uşaqlar, Qonaq otağı';
	@override String get pinProtectionOptional => 'PIN mühafizəsi (istəyə bağlı)';
	@override String get pinExplain => 'Profillər arası keçid üçün 4 rəqəmli PIN tələb olunur.';
	@override String get continueButton => 'Davam et';
	@override String get pinsDontMatch => 'PIN-lər uyğun gəlmir';
}

// Path: connections
class _Translations$connections$az extends Translations$connections$en {
	_Translations$connections$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get sectionTitle => 'Qoşulmalar';
	@override String get addConnection => 'Qoşulma əlavə et';
	@override String get addConnectionSubtitleNoProfile => 'Plex ilə daxil olun və ya Jellyfin serverinə qoşulun';
	@override String addConnectionSubtitleScoped({required Object displayName}) => '${displayName} profilinə əlavə et: Plex, Jellyfin və ya başqa profil qoşulması';
	@override String sessionExpiredOne({required Object name}) => '${name} üçün seansın vaxtı bitdi';
	@override String sessionExpiredMany({required Object count}) => '${count} server üçün seansın vaxtı bitdi';
	@override String get signInAgain => 'Yenidən daxil ol';
	@override String get editJellyfinTitle => 'Jellyfin qoşulmasını dəyişdir';
	@override String editJellyfinIntro({required Object serverName}) => '${serverName} üçün URL əlavə edin və ya silin.';
}

// Path: discover
class _Translations$discover$az extends Translations$discover$en {
	_Translations$discover$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kəşf et';
	@override String get noContentAvailable => 'Məzmun əlçatan deyil';
	@override String get addMediaToLibraries => 'Kitabxanalarınıza bir az media əlavə edin';
	@override String get continueWatching => 'İzləməyə davam et';
	@override String continueWatchingIn({required Object library}) => '${library} daxilində İzləməyə davam et';
	@override String get nextUp => 'Sırada';
	@override String nextUpIn({required Object library}) => '${library} daxilində Sırada';
	@override String get recentlyAdded => 'Son əlavə olunanlar';
	@override String recentlyAddedIn({required Object library}) => '${library} daxilində Son əlavə olunanlar';
	@override String latestAlbumsIn({required Object library}) => '${library} daxilində Son albomlar';
	@override String recentlyPlayedIn({required Object library}) => '${library} daxilində Son oynadılanlar';
	@override String mostPlayedIn({required Object library}) => '${library} daxilində Ən çox oynadılanlar';
	@override String playEpisode({required Object season, required Object episode}) => 'M${season}S${episode}';
	@override String get cast => 'Aktyorlar';
	@override String get extras => 'Treylerlər və Əlavələr';
	@override String get studio => 'Studiya';
	@override String get director => 'Rejissor';
	@override String get directors => 'Rejissorlar';
	@override String get movie => 'Kino';
	@override String get tvShow => 'TV Şou';
	@override String minutesLeft({required Object minutes}) => '${minutes} dəq qaldı';
	@override String get moreLikeThis => 'Buna bənzərlər';
}

// Path: errors
class _Translations$errors$az extends Translations$errors$en {
	_Translations$errors$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String searchFailed({required Object error}) => 'Axtarış uğursuz oldu: ${error}';
	@override String get searchUnavailable => 'Axtarış heç bir media serverinə çata bilmədi.';
	@override String connectionTimeout({required Object context}) => '${context} yüklənərkən vaxt bitdi';
	@override String get connectionFailed => 'Media serverinə qoşulmaq olmur';
	@override String unableToLoad({required Object context}) => '${context} yüklənə bilmədi. Lütfən təzədən cəhd edin.';
	@override String get noClientAvailable => 'Əlçatan klient yoxdur';
	@override String failedToSwitchProfile({required Object displayName}) => '${displayName} profilinə keçilə bilmədi';
	@override String failedToDeleteProfile({required Object displayName}) => '${displayName} profili silinə bilmədi';
	@override String get failedToRate => 'Reytinq yenilənə bilmədi';
}

// Path: libraries
class _Translations$libraries$az extends Translations$libraries$en {
	_Translations$libraries$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kitabxanalar';
	@override String get fallbackTitle => 'Kitabxana';
	@override String get refreshMetadata => 'Meta-məlumatları yenilə';
	@override String get noLibrariesFound => 'Kitabxana tapılmadı';
	@override String get allLibrariesHidden => 'Bütün kitabxanalar gizlədilib';
	@override String hiddenLibrariesCount({required Object count}) => 'Gizli kitabxanalar (${count})';
	@override String get thisLibraryIsEmpty => 'Bu kitabxana boşdur';
	@override String get noItemsMatchFilters => 'Filtrlərə uyğun element tapılmadı';
	@override String get resetFilters => 'Filtrləri sıfırla';
	@override String get all => 'Hamısı';
	@override String get clearAll => 'Hamısını təmizlə';
	@override String refreshMetadataConfirm({required Object title}) => '"${title}" üçün meta-məlumatları yeniləmək istədiyinizdən əminsiniz?';
	@override String get manageLibraries => 'Kitabxanaları idarə et';
	@override String get sort => 'Sırala';
	@override String get sortBy => 'Sıralama meyarı';
	@override String get filters => 'Filtrlər';
	@override String get confirmActionMessage => 'Bu əməliyyatı yerinə yetirmək istədiyinizdən əminsiniz?';
	@override String get showLibrary => 'Kitabxananı göstər';
	@override String get hideLibrary => 'Kitabxananı gizlət';
	@override String get libraryOptions => 'Kitabxana seçimləri';
	@override String get content => 'kitabxana məzmunu';
	@override String get selectLibrary => 'Kitabxana seç';
	@override String filtersWithCount({required Object count}) => 'Filtrlər (${count})';
	@override String get noRecommendations => 'Tövsiyə yoxdur';
	@override String get noCollections => 'Bu kitabxanada kolleksiya yoxdur';
	@override String get noFoldersFound => 'Qovluq tapılmadı';
	@override String get folders => 'qovluqlar';
	@override late final _Translations$libraries$tabs$az tabs = _Translations$libraries$tabs$az._(_root);
	@override late final _Translations$libraries$groupings$az groupings = _Translations$libraries$groupings$az._(_root);
	@override late final _Translations$libraries$filterCategories$az filterCategories = _Translations$libraries$filterCategories$az._(_root);
	@override late final _Translations$libraries$sortLabels$az sortLabels = _Translations$libraries$sortLabels$az._(_root);
}

// Path: about
class _Translations$about$az extends Translations$about$en {
	_Translations$about$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Haqqında';
	@override String get openSourceLicenses => 'Açıq mənbə lisenziyaları';
	@override String versionLabel({required Object version}) => 'Versiya ${version}';
	@override String get appDescription => 'Flutter üçün gözəl bir Plex və Jellyfin klienti';
	@override String get viewLicensesDescription => 'Üçüncü tərəf kitabxanalarının lisenziyalarına baxın';
}

// Path: hubDetail
class _Translations$hubDetail$az extends Translations$hubDetail$en {
	_Translations$hubDetail$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Başlıq';
	@override String get releaseYear => 'Buraxılış ili';
	@override String get dateAdded => 'Əlavə olunma tarixi';
	@override String get rating => 'Reytinq';
	@override String get noItemsFound => 'Element tapılmadı';
}

// Path: logs
class _Translations$logs$az extends Translations$logs$en {
	_Translations$logs$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get clearLogs => 'Jurnalları təmizlə';
	@override String get copyLogs => 'Jurnalları kopyala';
	@override String get uploadLogs => 'Jurnalları yüklə';
}

// Path: licenses
class _Translations$licenses$az extends Translations$licenses$en {
	_Translations$licenses$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get relatedPackages => 'Əlaqəli paketlər';
	@override String get license => 'Lisenziya';
	@override String licenseNumber({required Object number}) => 'Lisenziya ${number}';
	@override String licensesCount({required Object count}) => '${count} lisenziya';
}

// Path: navigation
class _Translations$navigation$az extends Translations$navigation$en {
	_Translations$navigation$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get libraries => 'Kitabxanalar';
	@override String get downloads => 'Yükləmələr';
	@override String get explore => 'Kəşf et';
}

// Path: explore
class _Translations$explore$az extends Translations$explore$en {
	_Translations$explore$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kəşf et';
	@override String get selectSource => 'Mənbə seçin';
	@override late final _Translations$explore$rows$az rows = _Translations$explore$rows$az._(_root);
	@override late final _Translations$explore$status$az status = _Translations$explore$status$az._(_root);
	@override String episodeCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('az'))(n,
		one: '${n} seriya',
		other: '${n} seriya',
	);
	@override String get cast => 'Aktyorlar';
	@override String get characters => 'Personajlar';
	@override String get addToWatchlist => 'İzləmə siyahısına əlavə et';
	@override String get removeFromWatchlist => 'İzləmə siyahısından sil';
	@override String get watchlistUpdateFailed => 'İzləmə siyahısı yenilənə bilmədi';
	@override String get notInLibrary => 'Kitabxananızda yoxdur';
	@override String get inTheseLibraries => 'Bu kitabxanalarda var';
	@override String get checkingLibrary => 'Kitabxananız yoxlanılır...';
	@override String get emptyTitle => 'Hələlik burada heç nə yoxdur';
	@override String emptyMessage({required Object source}) => '${source} mənbəsindən olan sətirlər burada görünəcək.';
	@override String searchHint({required Object source}) => '${source} daxilində axtar';
	@override String searchEmpty({required Object query}) => '"${query}" üçün nəticə tapılmadı';
	@override String searchPrompt({required Object source}) => '${source} vasitəsilə kino və seriallar axtarın.';
	@override String get searchFailed => 'Axtarış uğursuz oldu. Bağlantınızı yoxlayın.';
}

// Path: collections
class _Translations$collections$az extends Translations$collections$en {
	_Translations$collections$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kolleksiyalar';
	@override String get collection => 'Kolleksiya';
	@override String get empty => 'Kolleksiya boşdur';
	@override String get deleteCollection => 'Kolleksiyanı sil';
	@override String deleteConfirm({required Object title}) => '"${title}" silinsin? Bu əməliyyat geri qaytarıla bilməz.';
	@override String get deleted => 'Kolleksiya silindi';
	@override String get deleteFailed => 'Kolleksiya silinə bilmədi';
	@override String deleteFailedWithError({required Object error}) => 'Kolleksiya silinə bilmədi: ${error}';
	@override String get selectCollection => 'Kolleksiya seç';
	@override String get collectionName => 'Kolleksiya adı';
	@override String get enterCollectionName => 'Kolleksiya adını daxil edin';
	@override String get addedToCollection => 'Kolleksiyaya əlavə edildi';
	@override String get errorAddingToCollection => 'Kolleksiyaya əlavə edilə bilmədi';
	@override String get created => 'Kolleksiya yaradıldı';
	@override String get removeFromCollection => 'Kolleksiyadan sil';
	@override String removeFromCollectionConfirm({required Object title}) => '"${title}" bu kolleksiyadan silinsin?';
	@override String get removedFromCollection => 'Kolleksiyadan silindi';
	@override String get removeFromCollectionFailed => 'Kolleksiyadan silinə bilmədi';
	@override String removeFromCollectionError({required Object error}) => 'Kolleksiyadan silinərkən xəta: ${error}';
	@override String get searchCollections => 'Kolleksiyalarda axtar...';
}

// Path: playlists
class _Translations$playlists$az extends Translations$playlists$en {
	_Translations$playlists$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Oynatma siyahıları';
	@override String get playlist => 'Oynatma siyahısı';
	@override String get noPlaylists => 'Oynatma siyahısı tapılmadı';
	@override String get create => 'Oynatma siyahısı yarat';
	@override String get playlistName => 'Oynatma siyahısı adı';
	@override String get enterPlaylistName => 'Oynatma siyahısı adını daxil edin';
	@override String get delete => 'Oynatma siyahısını sil';
	@override String get removeItem => 'Oynatma siyahısından sil';
	@override String get smartPlaylist => 'Ağıllı oynatma siyahısı';
	@override String itemCount({required Object count}) => '${count} element';
	@override String get oneItem => '1 element';
	@override String get emptyPlaylist => 'Bu oynatma siyahısı boşdur';
	@override String get deleteConfirm => 'Oynatma siyahısı silinsin?';
	@override String deleteMessage({required Object name}) => '"${name}" siyahısını silmək istədiyinizdən əminsiniz?';
	@override String get created => 'Oynatma siyahısı yaradıldı';
	@override String get deleted => 'Oynatma siyahısı silindi';
	@override String get itemAdded => 'Oynatma siyahısına əlavə edildi';
	@override String get itemRemoved => 'Oynatma siyahısından silindi';
	@override String get selectPlaylist => 'Oynatma siyahısı seç';
	@override String get searchPlaylists => 'Oynatma siyahılarında axtar...';
	@override String get errorCreating => 'Oynatma siyahısı yaradıla bilmədi';
	@override String get errorDeleting => 'Oynatma siyahısı silinə bilmədi';
	@override String get errorLoading => 'Oynatma siyahıları yüklənə bilmədi';
	@override String get errorAdding => 'Oynatma siyahısına əlavə edilə bilmədi';
	@override String get errorReordering => 'Element yenidən sıralana bilmədi';
	@override String get errorRemoving => 'Oynatma siyahısından silinə bilmədi';
}

// Path: music
class _Translations$music$az extends Translations$music$en {
	_Translations$music$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get goToAlbum => 'Alboma keç';
	@override String get goToArtist => 'İfaçıya keç';
	@override String get instantMix => 'Anında qarışıq';
	@override String get playNext => 'Növbətini oynat';
	@override String get addToQueue => 'Növbəyə əlavə et';
	@override String discNumber({required Object n}) => 'Disk ${n}';
	@override String trackCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('az'))(n,
		one: '${n} mahnı',
		other: '${n} mahnı',
	);
	@override String get nowPlaying => 'İndi oynadılır';
	@override String playingFrom({required Object title}) => '${title} mənbəsindən oynadılır';
	@override String get queue => 'Növbə';
	@override String get clearQueue => 'Növbəni təmizlə';
	@override String get lyrics => 'Mahnı sözləri';
	@override String get noLyrics => 'Mahnı sözləri yoxdur';
	@override String get sleepTimer => 'Yuxu taymeri';
	@override String get sleepTimerEndOfTrack => 'Mahnının sonu';
	@override String sleepTimerMinutes({required Object n}) => '${n} dəqiqə';
	@override String get stopPlayback => 'Oynatmanı saxla';
	@override String get previousTrack => 'Əvvəlki mahnı';
	@override String get nextTrack => 'Növbəti mahnı';
	@override String get repeat => 'Təkrarla';
	@override String get repeatAll => 'Hamısını təkrarla';
	@override String get repeatOne => 'Birini təkrarla';
}

// Path: downloads
class _Translations$downloads$az extends Translations$downloads$en {
	_Translations$downloads$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Yükləmələr';
	@override String get manage => 'İdarə et';
	@override String get tvShows => 'TV Şoular';
	@override String get movies => 'Kinolar';
	@override String get music => 'Musiqi';
	@override String tracksQueued({required Object count}) => 'Yükləmə üçün ${count} mahnı növbəyə alındı';
	@override String get noDownloads => 'Hələlik yükləmə yoxdur';
	@override String get noDownloadsDescription => 'Yüklənmiş məzmun oflayn baxış üçün burada görünəcək';
	@override String get downloadNow => 'Yüklə';
	@override String get deleteDownload => 'Yükləməni sil';
	@override String get retryDownload => 'Yükləməni təzədən cəhd et';
	@override String get downloadQueued => 'Yükləmə növbəyə alındı';
	@override String get downloadResumed => 'Yükləmə davam etdirildi';
	@override String get serverErrorBitrate => 'Server xətası: fayl sürət limitini aşa bilər';
	@override String get storageFull => 'Cihaz yaddaşı dolu olduğu üçün yükləmə dayandırıldı.';
	@override String episodesQueued({required Object count}) => 'Yükləmə üçün ${count} seriya növbəyə alındı';
	@override String get downloadDeleted => 'Yükləmə silindi';
	@override String deleteConfirm({required Object title}) => '"${title}" bu cihazdan silinsin?';
	@override String get cancelledDownloadTitle => 'Ləğv edilmiş yükləmə';
	@override String get cancelledDownloadMessage => 'Bu yükləmə ləğv edildi. Nə etmək istərdiniz?';
	@override String get allEpisodesAlreadyDownloaded => 'Bütün seriyalar artıq yüklənib';
	@override String get resumeDownload => 'Yükləməni davam etdir';
	@override String get cancelledDownload => 'Ləğv edilmiş yükləmə';
	@override String syncingFile({required Object file, required Object status}) => '${file} (${status} eyniləşdirilir)';
	@override String downloadedFileClickToComplete({required Object file}) => 'Yükləndi ${file} - Tamamlamaq üçün toxunun';
	@override String get partialDownloadClickToComplete => 'Hissəvi yükləndi - Tamamlamaq üçün toxunun';
	@override String get deleting => 'Silinir...';
	@override String deletingWithProgress({required Object title, required Object current, required Object total}) => '${title} silinir... (${current} / ${total})';
	@override String get queuedTooltip => 'Növbədədir';
	@override String queuedFilesTooltip({required Object files}) => 'Növbəyə alınan fayllar: ${files}';
	@override String get downloadingTooltip => 'Yüklənir...';
	@override String downloadingFilesTooltip({required Object files}) => 'Yüklənən fayllar: ${files}';
	@override String get noDownloadsTree => 'Yükləmə yoxdur';
	@override String get pauseAll => 'Hamısını fasilə et';
	@override String get resumeAll => 'Hamısını davam etdir';
	@override String get deleteAll => 'Hamısını sil';
	@override String get selectVersion => 'Versiya seç';
	@override String get allEpisodes => 'Bütün seriyalar';
	@override String get unwatchedOnly => 'Yalnız baxılmayanlar';
	@override String nextNUnwatched({required Object count}) => 'Növbəti ${count} baxılmayan';
	@override String get customAmount => 'Xüsusi miqdar...';
	@override String get includeSpecials => 'Xüsusi seriyaları daxil et';
	@override String get howManyEpisodes => 'Neçə seriya?';
	@override String get invalidEpisodeCount => 'Düzgün seriya sayı daxil edin.';
	@override String get keepSynced => 'Eyniləşdirilmiş saxla';
	@override String get downloadOnce => 'Bir dəfə yüklə';
	@override String keepNUnwatched({required Object count}) => '${count} baxılmayan seriyanı saxla';
	@override String get editSyncRule => 'Eyniləşdirmə qaydasını dəyişdir';
	@override String get removeSyncRule => 'Eyniləşdirmə qaydasını sil';
	@override String removeSyncRuleConfirm({required Object title}) => '"${title}" eyniləşdirməsi dayandırılsın? Yüklənmiş seriyalar saxlanılacaq.';
	@override String removeListSyncRuleConfirm({required Object title}) => '"${title}" eyniləşdirməsi dayandırılsın?';
	@override String get deleteSyncRuleDownloads => 'Əlaqəli yükləmələri də sil';
	@override String get deleteSyncRuleDownloadsDescription => 'Başqa eyniləşdirmə qaydası və ya profil tərəfindən istifadə olunan yükləmələr saxlanılacaq.';
	@override String syncRuleCreated({required Object count}) => 'Eyniləşdirmə qaydası yaradıldı — ${count} baxılmayan seriya saxlanılır';
	@override String get syncRuleUpdated => 'Eyniləşdirmə qaydası yeniləndi';
	@override String get syncRuleRemoved => 'Eyniləşdirmə qaydası silindi';
	@override String get syncRuleAndDownloadsRemoved => 'Eyniləşdirmə qaydası və əlaqəli yükləmələr silindi';
	@override String get syncRuleCleanupBusy => 'Eyniləşdirmə qaydaları hazırda yenilənir. Bir azdan təzədən cəhd edin.';
	@override String get syncRuleCleanupUnavailable => 'Əlaqəli yükləmələr təhlükəsiz şəkildə müəyyən edilə bilmədi. Serverə yenidən qoşulub cəhd edin və ya qaydanı yükləmələri silmədən silin.';
	@override String syncedNewEpisodes({required Object title, required Object count}) => '${title} üçün ${count} yeni seriya eyniləşdirildi';
	@override String get activeSyncRules => 'Eyniləşdirmə qaydaları';
	@override String get noSyncRules => 'Eyniləşdirmə qaydası yoxdur';
	@override String get manageSyncRule => 'Eyniləşdirməni idarə et';
	@override String get editEpisodeCount => 'Seriya sayı';
	@override String get editSyncFilter => 'Eyniləşdirmə filtri';
	@override String get syncAllItems => 'Bütün elementlər eyniləşdirilir';
	@override String get syncUnwatchedItems => 'Baxılmayan elementlər eyniləşdirilir';
	@override String syncRuleServerContext({required Object server, required Object status}) => 'Server: ${server} • ${status}';
	@override String get syncRuleAvailable => 'Əlçatandır';
	@override String get syncRuleOffline => 'Oflayn';
	@override String get syncRuleSignInRequired => 'Daxil olmaq tələb olunur';
	@override String get syncRuleNotAvailableForProfile => 'Cari profil üçün əlçatan deyil';
	@override String get syncRuleUnknownServer => 'Bilinməyən server';
	@override String get syncRuleListCreated => 'Eyniləşdirmə qaydası yaradıldı';
	@override late final _Translations$downloads$backgroundWarning$az backgroundWarning = _Translations$downloads$backgroundWarning$az._(_root);
}

// Path: shaders
class _Translations$shaders$az extends Translations$shaders$en {
	_Translations$shaders$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Şeyderlər';
	@override String get noShaderDescription => 'Video təkmilləşdirməsi yoxdur';
	@override String get nvscalerDescription => 'Daha kəskin video üçün NVIDIA miqyaslaması';
	@override String get artcnnVariantNeutral => 'Neytral';
	@override String get artcnnVariantDenoise => 'Küyün aradan qaldırılması';
	@override String get artcnnVariantDenoiseSharpen => 'Küyün aradan qaldırılması + Kəskinləşdirmə';
	@override String get qualityFast => 'Sürətli';
	@override String get qualityHQ => 'Yüksək keyfiyyət';
	@override String get mode => 'Rejim';
	@override String get importShader => 'Şeyder idxal et';
	@override String get customShaderDescription => 'Xüsusi GLSL şeyderi';
	@override String get shaderImported => 'Şeyder idxal edildi';
	@override String get shaderImportFailed => 'Şeyder idxal edilə bilmədi';
	@override String get deleteShader => 'Şeyderi sil';
	@override String deleteShaderConfirm({required Object name}) => '"${name}" silinsin?';
}

// Path: videoSettings
class _Translations$videoSettings$az extends Translations$videoSettings$en {
	_Translations$videoSettings$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get playbackSpeed => 'Oynatma sürəti';
	@override String get normalSpeed => 'Normal';
	@override String sleepTimerActive({required Object duration}) => 'Aktivdir (${duration})';
	@override String get zoom => 'Miqyas';
	@override String get sleepTimer => 'Yuxu taymeri';
	@override String get audioSync => 'Səs sinxronizasiyası';
	@override String get subtitleSync => 'Altyazı sinxronizasiyası';
	@override String get hdr => 'HDR';
	@override String get audioOutput => 'Səs çıxışı';
	@override String get performanceOverlay => 'Məhsuldarlıq paneli';
	@override String get audioPassthrough => 'Səsin birbaşa ötürülməsi';
	@override String get audioOutputDolbyAtmos => 'Dolby Atmos';
	@override String get audioOutputDolbyAudio => 'Dolby Audio';
	@override String get audioOutputSurround => 'Əhatəli səs';
	@override String get audioOutputSpatial => 'Məkan səsi';
	@override String get audioOutputStereo => 'Stereo';
	@override String get audioNormalization => 'Səsin gurluğunu normallaşdır';
	@override String get audioDownmix => 'Stereo-ya çevir';
}

// Path: performanceOverlay
class _Translations$performanceOverlay$az extends Translations$performanceOverlay$en {
	_Translations$performanceOverlay$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get color => 'Rəng';
	@override String get performance => 'Məhsuldarlıq';
	@override String get buffer => 'Bufer';
	@override String get app => 'Tətbiq';
	@override String get decoder => 'Çözücü';
	@override String get rawDecoder => 'Xam çözücü';
	@override String get tunneling => 'Tünelləmə';
	@override String get aspect => 'Nisbət';
	@override String get rotation => 'Dönmə';
	@override String get dvSource => 'DV mənbəyi';
	@override String get dvPath => 'DV yolu';
	@override String get p7Conversion => 'P7 çevrilməsi';
	@override String get sampleRate => 'Diskretləşdirmə tezliyi';
	@override String get pixelFormat => 'Piksel formatı';
	@override String get hwFormat => 'HW formatı';
	@override String get matrix => 'Matrisa';
	@override String get primaries => 'Əsas rənglər';
	@override String get transfer => 'Ötürmə';
	@override String get renderFps => 'Emal FPS-i';
	@override String get displayFps => 'Ekran FPS-i';
	@override String get avSync => 'A/V Eyniləşdirilməsi';
	@override String get dropped => 'İtirilmiş kadrlar';
	@override String get dvRpus => 'DV RPU-ları';
	@override String get dvRpuAverage => 'DV RPU Ort.';
	@override String get dvSampleAverage => 'DV Nümunə Ort.';
	@override String get maxLuma => 'Maks Luma';
	@override String get minLuma => 'Min Luma';
	@override String get maxCll => 'MaxCLL';
	@override String get maxFall => 'MaxFALL';
	@override String get cacheUsed => 'İstifadə olunan keş';
	@override String get cacheLimit => 'Keş limiti';
	@override String get speed => 'Sürət';
	@override String get player => 'Oynadıcı';
	@override String get memory => 'Yaddaş';
	@override String get uiFps => 'Arayüz (UI) FPS-i';
}

// Path: externalPlayer
class _Translations$externalPlayer$az extends Translations$externalPlayer$en {
	_Translations$externalPlayer$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Xarici oynadıcı';
	@override String get useExternalPlayer => 'Xarici oynadıcı istifadə et';
	@override String get useExternalPlayerDescription => 'Videoları başqa tətbiqdə açın';
	@override String get selectPlayer => 'Oynadıcı seç';
	@override String get customPlayers => 'Xüsusi oynadıcılar';
	@override String get systemDefault => 'Sistem defoltu';
	@override String get addCustomPlayer => 'Xüsusi oynadıcı əlavə et';
	@override String get playerName => 'Oynadıcı adı';
	@override String get playerNameHint => 'Mənim oynadıcım';
	@override String get playerCommand => 'Əmr';
	@override String get playerPackage => 'Paket adı';
	@override String get playerUrlScheme => 'URL sxemi';
	@override String get off => 'Söndürülüb';
	@override String get launchFailed => 'Xarici oynadıcı açıla bilmədi';
	@override String appNotInstalled({required Object name}) => '${name} quraşdırılmayıb';
	@override String get playInExternalPlayer => 'Xarici oynadıcıda oynat';
}

// Path: metadataEdit
class _Translations$metadataEdit$az extends Translations$metadataEdit$en {
	_Translations$metadataEdit$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get editMetadata => 'Düzəliş et...';
	@override String get screenTitle => 'Meta-məlumatlara düzəliş et';
	@override String get basicInfo => 'Əsas məlumatlar';
	@override String get artwork => 'Şəkillər/Posterlər';
	@override String get title => 'Başlıq';
	@override String get sortTitle => 'Sıralama başlığı';
	@override String get originalTitle => 'Orijinal başlıq';
	@override String get releaseDate => 'Buraxılış tarixi';
	@override String get contentRating => 'Məzmun reytinqi';
	@override String get studio => 'Studiya';
	@override String get tagline => 'Deviz/Slogan';
	@override String get summary => 'Məzmun/Xülasə';
	@override String get poster => 'Poster';
	@override String get background => 'Arxa fon';
	@override String get logo => 'Loqo';
	@override String get squareArt => 'Kvadrat şəkil';
	@override String get selectPoster => 'Poster seç';
	@override String get selectBackground => 'Arxa fon seç';
	@override String get selectLogo => 'Loqo seç';
	@override String get selectSquareArt => 'Kvadrat şəkil seç';
	@override String get fromUrl => 'URL-dən';
	@override String get uploadFile => 'Fayl yüklə';
	@override String get enterImageUrl => 'Şəkil URL-i daxil edin';
	@override String get imageUrl => 'Şəkil URL-i';
	@override String get metadataUpdated => 'Meta-məlumatlar yeniləndi';
	@override String get metadataUpdateFailed => 'Meta-məlumatlar yenilənə bilmədi';
	@override String get artworkUpdated => 'Şəkillər yeniləndi';
	@override String get artworkUpdateFailed => 'Şəkillər yenilənə bilmədi';
	@override String get noArtworkAvailable => 'Şəkil əlçatan deyil';
	@override String artworkOption({required Object index}) => 'Şəkil seçimi ${index}';
	@override String selectedArtworkOption({required Object index}) => 'Şəkil seçimi ${index}, seçildi';
	@override String get notSet => 'Təyin edilməyib';
	@override String get tags => 'Teqlər';
	@override String get addTag => 'Teq əlavə et';
	@override String get genre => 'Janr';
	@override String get director => 'Rejissor';
	@override String get writer => 'Ssenarist';
	@override String get producer => 'Prodüser';
	@override String get country => 'Ölkə';
	@override String get label => 'Etiket';
}

// Path: trakt
class _Translations$trakt$az extends Translations$trakt$en {
	_Translations$trakt$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Trakt';
	@override String get connected => 'Qoşuldu';
	@override String connectedAs({required Object username}) => '@${username} olaraq qoşuldu';
	@override String get disconnectConfirm => 'Trakt hesabı ayırılsın?';
	@override String get disconnectConfirmBody => 'Plezy Trakt-a məlumat göndərməyi dayandıracaq.';
	@override String get scrobble => 'Real vaxt rejimində izləmə';
	@override String get scrobbleDescription => 'Oynatma zamanı Trakt-a məlumat göndər.';
	@override String get watchedSync => 'Baxış statusunu eyniləşdir';
	@override String get watchedSyncDescription => 'Plezy-də baxıldı işarələdikdə Trakt-da da işarələnsin.';
}

// Path: seerr
class _Translations$seerr$az extends Translations$seerr$en {
	_Translations$seerr$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seerr';
	@override String get connectTitle => 'Seerr qoş';
	@override String get serverUrl => 'Server URL-i';
	@override String get serverUrlHelper => 'Seerr ünvanınız';
	@override String get checkServer => 'Davam et';
	@override String get signInWithJellyfin => 'Jellyfin ilə daxil ol';
	@override String get signInWithEmby => 'Emby ilə daxil ol';
	@override String get signInWithLocal => 'Yerli hesab istifadə et';
	@override String get email => 'E-poçt';
	@override String get noSignInMethods => 'Bu Seerr dəstəklənən daxil olma üsulu təklif etmir.';
	@override String get instance => 'Nüsxə';
	@override String get disconnectConfirm => 'Seerr ayırılsın?';
	@override String get disconnectConfirmBody => 'Plezy bu Seerr ünvanını unudacaq.';
	@override String get request => 'Sorğu göndər';
	@override String get request4k => '4K sorğu göndər';
	@override String get seasons => 'Mövsümlər';
	@override String get allSeasons => 'Bütün mövsümlər';
	@override String get advancedOptions => 'Təkmilləşdirilmiş';
	@override String get destinationServer => 'Hədəf server';
	@override String get qualityProfile => 'Keyfiyyət profili';
	@override String get rootFolder => 'Kök qovluq';
	@override String get languageProfile => 'Dil profili';
	@override String get requestSubmitted => 'Sorğu göndərildi';
	@override String requestFailed({required Object error}) => 'Sorğu uğursuz oldu: ${error}';
	@override String get requestsLoadFailed => 'Seçimlər yüklənə bilmədi';
	@override String get nothingToRequest => 'Hər şey artıq var və ya sorğu göndərilib.';
	@override String get statusAvailable => 'Əlçatandır';
	@override String get statusPartiallyAvailable => 'Hissəvi əlçatandır';
	@override String get statusRequested => 'Sorğu göndərildi';
	@override String get statusProcessing => 'Emal edilir';
}

// Path: services
class _Translations$services$az extends Translations$services$en {
	_Translations$services$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Xidmətlər';
	@override String get hubSubtitle => 'İzləmə tərəqqisini eyniləşdirin və yeni başlıqlar sorğulayın.';
	@override String get notConnected => 'Qoşulmayıb';
	@override String connectedAs({required Object username}) => '@${username} olaraq qoşuldu';
	@override String get scrobble => 'Tərəqqini avtomatik izlə';
	@override String get scrobbleDescription => 'Siyahınızı avtomatik yeniləyin.';
	@override String disconnectConfirm({required Object service}) => '${service} ayırılsın?';
	@override String disconnectConfirmBody({required Object service}) => 'Plezy ${service} yeniləməyi dayandıracaq.';
	@override String connectFailed({required Object service}) => '${service} qoşula bilmədi. Təzədən cəhd edin.';
	@override late final _Translations$services$names$az names = _Translations$services$names$az._(_root);
	@override late final _Translations$services$deviceCode$az deviceCode = _Translations$services$deviceCode$az._(_root);
	@override late final _Translations$services$oauthProxy$az oauthProxy = _Translations$services$oauthProxy$az._(_root);
	@override late final _Translations$services$libraryFilter$az libraryFilter = _Translations$services$libraryFilter$az._(_root);
}

// Path: addServer
class _Translations$addServer$az extends Translations$addServer$en {
	_Translations$addServer$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get addJellyfinTitle => 'Jellyfin serveri əlavə et';
	@override String get serverUrls => 'Server URL-ləri';
	@override String get serverUrlsHelper => 'Vergüllə ayrılmış bir neçə URL-ə icazə verilir.';
	@override String get findServer => 'Server tap';
	@override String get searchingLocalServers => 'Yerli Jellyfin serverləri axtarılır...';
	@override String get localServers => 'Yerli Jellyfin serverləri';
	@override String get username => 'İstifadəçi adı';
	@override String get password => 'Şifrə';
	@override String get signIn => 'Daxil ol';
	@override String get change => 'Dəyişdir';
	@override String get required => 'Tələb olunur';
	@override String couldNotReachServer({required Object error}) => 'Serverə çatmaq olmadı: ${error}';
	@override String signInFailed({required Object error}) => 'Daxil olma uğursuz oldu: ${error}';
	@override String quickConnectFailed({required Object error}) => 'Sürətli Qoşulma uğursuz oldu: ${error}';
	@override String get enterJellyfinUrlError => 'Jellyfin server URL-inizi daxil edin';
	@override String get addConnectionTitle => 'Qoşulma əlavə et';
	@override String addConnectionTitleScoped({required Object name}) => '${name} profilinə əlavə et';
	@override String get connectToJellyfinCard => 'Jellyfin-ə qoşul';
	@override String get connectToJellyfinCardSubtitle => 'Server URL, istifadəçi adı və şifrənizi daxil edin.';
	@override String connectToJellyfinCardSubtitleScoped({required Object name}) => 'Jellyfin serverinə daxil olun. ${name} profilinə bağlanır.';
	@override String get borrowFromAnotherProfile => 'Başqa profildən götür';
	@override String get borrowFromAnotherProfileSubtitle => 'Başqa profilin qoşulmasını yenidən istifadə edin.';
}

// Path: hotkeys.actions
class _Translations$hotkeys$actions$az extends Translations$hotkeys$actions$en {
	_Translations$hotkeys$actions$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get playPause => 'Oynat/Fasilə';
	@override String get volumeUp => 'Səsi artır';
	@override String get volumeDown => 'Səsi azalt';
	@override String seekForward({required Object seconds}) => 'İrəli sar (${seconds}san)';
	@override String seekBackward({required Object seconds}) => 'Geri sar (${seconds}san)';
	@override String get fullscreenToggle => 'Tam ekranı dəyişdir';
	@override String get muteToggle => 'Səsi aç/bağla';
	@override String get subtitleToggle => 'Altyazını aç/bağla';
	@override String get audioTrackNext => 'Növbəti səs zolağı';
	@override String get subtitleTrackNext => 'Növbəti altyazı zolağı';
	@override String get chapterNext => 'Növbəti hissə';
	@override String get chapterPrevious => 'Əvvəlki hissə';
	@override String get episodeNext => 'Növbəti seriya';
	@override String get episodePrevious => 'Əvvəlki seriya';
	@override String get speedIncrease => 'Sürəti artır';
	@override String get speedDecrease => 'Sürəti azalt';
	@override String get speedReset => 'Sürəti sıfırla';
	@override String get zoomIn => 'Yaxınlaşdır';
	@override String get zoomOut => 'Uzaqlaşdır';
	@override String get zoomReset => 'Miqyası sıfırla';
	@override String get subSeekNext => 'Növbəti altyazıya sar';
	@override String get subSeekPrev => 'Əvvəlki altyazıya sar';
	@override String get shaderToggle => 'Şeyderləri aç/bağla';
	@override String get skipMarker => 'Girişi/Titrləri ötür';
	@override String get screenshot => 'Ekran şəkli çək';
}

// Path: videoControls.pipErrors
class _Translations$videoControls$pipErrors$az extends Translations$videoControls$pipErrors$en {
	_Translations$videoControls$pipErrors$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get androidVersion => 'Android 8.0 və ya daha yenisini tələb edir';
	@override String get iosVersion => 'iOS 15.0 və ya daha yenisini tələb edir';
	@override String get permissionDisabled => 'PiP rejimi söndürülüb. Sistem tənzimləmələrindən aktivləşdirin.';
	@override String get notSupported => 'Cihaz PiP rejimini dəstəkləmir';
	@override String get voSwitchFailed => 'PiP üçün video çıxışı dəyişdirilə bilmədi';
	@override String get failed => 'PiP rejimi başladılarkən xəta';
	@override String unknown({required Object error}) => 'Xəta baş verdi: ${error}';
}

// Path: libraries.tabs
class _Translations$libraries$tabs$az extends Translations$libraries$tabs$en {
	_Translations$libraries$tabs$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get recommended => 'Tövsiyə olunanlar';
	@override String get browse => 'Baxış';
	@override String get collections => 'Kolleksiyalar';
	@override String get playlists => 'Oynatma siyahıları';
}

// Path: libraries.groupings
class _Translations$libraries$groupings$az extends Translations$libraries$groupings$en {
	_Translations$libraries$groupings$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Qruplaşdırma';
	@override String get all => 'Hamısı';
	@override String get movies => 'Kinolar';
	@override String get shows => 'TV Şoular';
	@override String get seasons => 'Mövsümlər';
	@override String get episodes => 'Seriyalar';
	@override String get artists => 'Müğənnilər/Müəlliflər';
	@override String get albums => 'Albomlar';
	@override String get tracks => 'Mahnılar';
	@override String get folders => 'Qovluqlar';
}

// Path: libraries.filterCategories
class _Translations$libraries$filterCategories$az extends Translations$libraries$filterCategories$en {
	_Translations$libraries$filterCategories$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get genre => 'Janr';
	@override String get year => 'İl';
	@override String get contentRating => 'Məzmun reytinqi';
	@override String get tag => 'Teq';
	@override String get unwatched => 'Baxılmayıb';
	@override String get unplayed => 'Oynadılmayıb';
	@override String get favorites => 'Sevimlilər';
}

// Path: libraries.sortLabels
class _Translations$libraries$sortLabels$az extends Translations$libraries$sortLabels$en {
	_Translations$libraries$sortLabels$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Ad';
	@override String get dateAdded => 'Əlavə olunma tarixi';
	@override String get communityRating => 'İcma reytinqi';
	@override String get criticRating => 'Tənqidçi reytinqi';
	@override String get datePlayed => 'Oynadılma tarixi';
	@override String get playCount => 'Oynadılma sayı';
	@override String get productionYear => 'İstehsal ili';
	@override String get runtime => 'Müddət';
	@override String get officialRating => 'Rəsmi reytinq';
	@override String get premiereDate => 'Premyera tarixi';
	@override String get startDate => 'Başlanğıc tarixi';
	@override String get airTime => 'Yayımlanma vaxtı';
	@override String get studio => 'Studiya';
	@override String get random => 'Təsadüfi';
	@override String get lastEpisodeDateAdded => 'Əlavə olunan son seriya tarixi';
}

// Path: explore.rows
class _Translations$explore$rows$az extends Translations$explore$rows$en {
	_Translations$explore$rows$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get watchlist => 'İzləmə siyahısı';
	@override String get recommendedMovies => 'Tövsiyə olunan kinolar';
	@override String get recommendedShows => 'Tövsiyə olunan seriallar';
	@override String get trendingMovies => 'Trend kinolar';
	@override String get trendingShows => 'Trend seriallar';
	@override String get popularMovies => 'Məşhur kinolar';
	@override String get popularShows => 'Məşhur seriallar';
	@override String get trendingAnime => 'Trend animelər';
	@override String get suggestedAnime => 'Tövsiyə olunan animelər';
	@override String get airingAnime => 'Ən yaxşı yayımlanan animelər';
	@override String get popularAnime => 'Ən məşhur animelər';
	@override String get trending => 'Trendlər';
	@override String get upcomingMovies => 'Gələcək kinolar';
	@override String get upcomingShows => 'Gələcək seriallar';
}

// Path: explore.status
class _Translations$explore$status$az extends Translations$explore$status$en {
	_Translations$explore$status$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get airing => 'Yayımlanır';
	@override String get ended => 'Bitdi';
	@override String get canceled => 'Ləğv edildi';
	@override String get upcoming => 'Gələcək';
}

// Path: downloads.backgroundWarning
class _Translations$downloads$backgroundWarning$az extends Translations$downloads$backgroundWarning$en {
	_Translations$downloads$backgroundWarning$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get bannerBlocked => 'Tətbiqdən çıxdıqda yükləmələr dayanacaq';
	@override String get bannerDegraded => 'Arxa fonda yükləmələr məhdudlaşdırıla bilər';
	@override String get bannerAction => 'Ətraflı';
	@override String get sheetTitle => 'Arxa fonda yükləmələr bloklanıb';
	@override String get sheetTitleDegraded => 'Arxa fonda yükləmələr məhdudlaşdırıla bilər';
	@override String get sheetIntro => 'Android Plezy-nin arxa fonda etibarlı şəkildə yükləməsinə mane olur.';
	@override String get sheetIntroDegraded => 'Cihazınız Plezy-nin arxa fonda nə vaxt yükləyə biləcəyini məhdudlaşdırır.';
	@override String get reasonBackgroundRestricted => 'Plezy-nin arxa fon istifadəsi məhdudlaşdırılıb. Batareya və ya arxa fon istifadəsini "Məhdudiyyətsiz" edin.';
	@override String get reasonStandbyRestricted => 'Android Plezy-ni məhdud gözləmə rejiminə salıb. Batareya istifadəsini "Məhdudiyyətsiz" edin.';
	@override String get reasonDownloadChannelBlocked => 'Yükləmə bildirişləri söndürülüb, ona görə gedişat və idarəetmələr əlçatan olmaya bilər.';
	@override String get reasonNotificationsDisabled => 'Bildirişlər söndürülüb. Android 13 və daha yeni versiyalarda uzun arxa fon yükləmələri üçün onlar tələb olunur.';
	@override String get reasonDataSaver => 'Data Saver aktivdir və bu, mobil internetdə arxa fon yükləmələrini bloklayır. Wi-Fi ilə yükləmələr işləməlidir.';
	@override String get reasonOemUnknown => 'Plezy arxa fonda olarkən yükləmələr dəfələrlə dayandı. Plezy-nin batareya və ya arxa fon istifadəsi tənzimləmələrini yoxlayın.';
	@override String get openSettings => 'Tənzimləmələri aç';
	@override String get stillNotWorking => 'Cihaza özəl kömək';
	@override String get stillNotWorkingDescription => 'Cihazınız üçün addımlara baxın və ya problem davam edərsə Tənzimləmələr › Jurnallara bax bölməsindən jurnal göndərin.';
	@override String get dialogTitle => 'Yükləmələr tamamlanmaya bilər';
	@override String get dialogDownloadAnyway => 'Yenə də yüklə';
	@override String get dialogFixFirst => 'Əvvəlcə bunu düzəlt';
	@override String get statusTile => 'Arxa fonda yükləmələr';
	@override String get statusOk => 'Arxa fonda işləməyə icazə verilir';
	@override String get statusBlocked => 'Sistem tənzimləmələri ilə bloklanıb';
	@override String get statusDegraded => 'Sistem tənzimləmələri ilə məhdudlaşdırılıb';
	@override String get statusUnknown => 'Hələ yoxlanılmayıb';
	@override String get settingsUnavailable => 'Bu cihazda sistem tənzimləmələri açıla bilmədi';
	@override String get linkUnavailable => 'Bu cihazda dontkillmyapp.com açıla bilmədi';
}

// Path: services.names
class _Translations$services$names$az extends Translations$services$names$en {
	_Translations$services$names$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get mal => 'MyAnimeList';
	@override String get anilist => 'AniList';
	@override String get simkl => 'Simkl';
	@override String get seerr => 'Seerr';
}

// Path: services.deviceCode
class _Translations$services$deviceCode$az extends Translations$services$deviceCode$en {
	_Translations$services$deviceCode$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String title({required Object service}) => 'Plezy-ni ${service} üzərində aktivləşdirin';
	@override String body({required Object url}) => '${url} ünvanına keçin və bu kodu daxil edin:';
	@override String openToActivate({required Object service}) => 'Aktivləşdirmək üçün ${service} açın';
	@override String get copyCode => 'Aktivləşdirmə kodunu kopyala';
	@override String get waitingForAuthorization => 'Səlahiyyət gözlənilir…';
	@override String get codeCopied => 'Kod kopyalandı';
}

// Path: services.oauthProxy
class _Translations$services$oauthProxy$az extends Translations$services$oauthProxy$en {
	_Translations$services$oauthProxy$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String title({required Object service}) => '${service} xidmətinə daxil olun';
	@override String get body => 'Bu QR kodu skan edin və ya URL-i açın.';
	@override String openToSignIn({required Object service}) => 'Daxil olmaq üçün ${service} açın';
	@override String get copyUrl => 'Daxil olma URL-ini kopyala';
	@override String get urlCopied => 'URL kopyalandı';
}

// Path: services.libraryFilter
class _Translations$services$libraryFilter$az extends Translations$services$libraryFilter$en {
	_Translations$services$libraryFilter$az._(TranslationsAz root) : this._root = root, super.internal(root);

	final TranslationsAz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kitabxana filtri';
	@override String get subtitleAllSyncing => 'Bütün kitabxanalar eyniləşdirilir';
	@override String get subtitleNoneSyncing => 'Heç nə eyniləşdirilmir';
	@override String subtitleBlocked({required Object count}) => '${count} bloklandı';
	@override String subtitleAllowed({required Object count}) => '${count} icazə verildi';
	@override String get mode => 'Filtr rejimi';
	@override String get modeBlacklist => 'Qara siyahı';
	@override String get modeWhitelist => 'Ağ siyahı';
	@override String get modeHintBlacklist => 'Aşağıda seçilənlərdən başqa bütün kitabxanaları eyniləşdir.';
	@override String get modeHintWhitelist => 'Yalnız aşağıda seçilən kitabxanaları eyniləşdir.';
	@override String get libraries => 'Kitabxanalar';
	@override String get noLibraries => 'Kitabxana yoxdur';
}

/// The flat map containing all translations for locale <az>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAz {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Plezy',
			'auth.connectToJellyfin' => 'Jellyfin-ə qoşul',
			'auth.useQuickConnect' => 'Sürətli Qoşulmanı istifadə et',
			'auth.quickConnectInstructions' => 'Jellyfin-də Sürətli Qoşulmanı açın və bu kodu daxil edin.',
			'auth.quickConnectWaiting' => 'Təsdiq gözlənilir…',
			'auth.quickConnectCancel' => 'Ləğv et',
			'auth.quickConnectExpired' => 'Sürətli Qoşulmanın vaxtı bitdi. Təzədən cəhd edin.',
			'auth.localDataRecoveryRequired' => 'Plezy yerli daxil olma və gözləyən oxutma məlumatlarını təhlükəsiz bərpa edə bilmədi. Lütfən təzədən daxil olun.',
			'common.cancel' => 'Ləğv et',
			'common.save' => 'Yadda saxla',
			'common.close' => 'Bağla',
			'common.clear' => 'Təmizlə',
			'common.reset' => 'Sıfırla',
			'common.later' => 'Sonra',
			'common.submit' => 'Göndər',
			'common.confirm' => 'Təsdiqlə',
			'common.retry' => 'Təzədən cəhd et',
			'common.logout' => 'Çıxış et',
			'common.unknown' => 'Məlum deyil',
			'common.refresh' => 'Yenilə',
			'common.yes' => 'Bəli',
			'common.no' => 'Xeyr',
			'common.delete' => 'Sil',
			'common.edit' => 'Düzəliş et',
			'common.shuffle' => 'Qarışdır',
			'common.addTo' => 'Əlavə et...',
			'common.createNew' => 'Yenisini yarat',
			'common.disconnect' => 'Əlaqəni kəs',
			'common.play' => 'Oynat',
			'common.pause' => 'Fasilə',
			'common.resume' => 'Davam et',
			'common.error' => 'Xəta',
			'common.search' => 'Axtar',
			'common.home' => 'Ana səhifə',
			'common.back' => 'Geri',
			'common.settings' => 'Tənzimləmələr',
			'common.ok' => 'Oldu',
			'common.off' => 'Söndürülüb',
			'common.seasonNumber' => ({required Object number}) => 'Mövsüm ${number}',
			'common.episodeNumberTitle' => ({required Object number, required Object title}) => 'Seriya ${number} - ${title}',
			'common.chapterNumber' => ({required Object number}) => 'Hissə ${number}',
			'common.reconnect' => 'Yenidən qoşul',
			'common.viewAll' => 'Hamısına bax',
			'common.checkingNetwork' => 'Şəbəkə yoxlanılır...',
			'common.loadingServers' => 'Serverlər yüklənir...',
			'common.connectingToServers' => 'Serverlərə qoşulunur...',
			'common.startingOfflineMode' => 'Oflayn rejim başladılır...',
			'common.loading' => 'Yüklənir...',
			'common.fullscreen' => 'Tam ekran',
			'common.exitFullscreen' => 'Tam ekrandan çıx',
			'common.pressBackAgainToExit' => 'Çıxmaq üçün geri düyməsinə bir daha basın',
			'common.next' => 'Növbəti',
			'screens.licenses' => 'Lisenziyalar',
			'screens.switchProfile' => 'Profili dəyiş',
			'screens.subtitleStyling' => 'Altyazı tənzimləmələri',
			'screens.mpvConfig' => 'mpv.conf',
			'screens.logs' => 'Jurnallar',
			'update.available' => 'Yenilənmə var',
			'update.versionAvailable' => ({required Object version}) => '${version} versiyası əlçatandır',
			'update.currentVersion' => ({required Object version}) => 'Cari: ${version}',
			'update.skipVersion' => 'Bu versiyanı ötür',
			'update.viewRelease' => 'Buraxılışa bax',
			'update.latestVersion' => 'Siz ən son versiyadasınız',
			'update.checkFailed' => 'Yenilənmələr yoxlanıla bilmədi',
			'settings.title' => 'Tənzimləmələr',
			'settings.supportDeveloper' => 'Plezy-yə dəstək ol',
			'settings.supportDeveloperDescription' => 'İnkişafı maliyyələşdirmək üçün Liberapay vasitəsilə iyanə edin',
			'settings.language' => 'Dil',
			'settings.theme' => 'Mövzu',
			'settings.appearance' => 'Görünüş',
			'settings.videoPlayback' => 'Video oynatma',
			'settings.videoPlaybackDescription' => 'Oynatma davranışını tənzimləyin',
			'settings.advanced' => 'Təkmilləşdirilmiş',
			'settings.episodePosterMode' => 'Seriya poster stili',
			'settings.seriesPoster' => 'Serial posteri',
			'settings.seasonPoster' => 'Mövsüm posteri',
			'settings.episodeThumbnail' => 'Kadr önizləməsi',
			'settings.showHeroSectionDescription' => 'Ana səhifədə xüsusi məzmun karuselini göstər',
			'settings.secondsLabel' => 'Saniyə',
			'settings.minutesLabel' => 'Dəqiqə',
			'settings.secondsShort' => 'san',
			'settings.minutesShort' => 'dəq',
			'settings.durationHint' => ({required Object min, required Object max}) => 'Müddəti daxil edin (${min}-${max})',
			'settings.systemTheme' => 'Sistem',
			'settings.lightTheme' => 'Açıq',
			'settings.darkTheme' => 'Tünd',
			'settings.oledTheme' => 'OLED',
			'settings.libraryDensity' => 'Kitabxana sıxlığı',
			'settings.compact' => 'Sıx',
			'settings.comfortable' => 'Rəhat',
			'settings.tvCornerSpotlightBackdrop' => 'Künc işıqlandırma fonu',
			'settings.tvCornerSpotlightBackdropDescription' => 'Arxa fonu ekranı örtmək əvəzinə sağ üst küncdə göstər',
			'settings.viewMode' => 'Baxış rejimi',
			'settings.gridView' => 'Tor',
			'settings.listView' => 'Siyahı',
			'settings.showHeroSection' => 'Xüsusi bölməni göstər',
			'settings.continueWatchingAction' => 'İzləməyə davam et əməliyyatı',
			'settings.continueWatchingPlay' => 'Oynat',
			'settings.continueWatchingDetails' => 'Ətraflı aç',
			'settings.episodeAction' => 'Seriya əməliyyatı',
			'settings.episodePlay' => 'Oynat',
			'settings.episodeDetails' => 'Ətraflı aç',
			'settings.useGlobalHubs' => 'Ana səhifə quruluşunu istifadə et',
			'settings.useGlobalHubsDescription' => 'Birləşdirilmiş ana səhifə bölmələrini göstər. Əks halda kitabxana tövsiyələrini istifadə edir.',
			'settings.showServerNameOnHubs' => 'Bölmələrdə server adını göstər',
			'settings.showServerNameOnHubsDescription' => 'Bölmə başlıqlarında həmişə server adlarını göstər.',
			'settings.groupLibrariesByServer' => 'Kitabxanaları serverə görə qrupla',
			'settings.groupLibrariesByServerDescription' => 'Yan menyu kitabxanalarını hər media serverinin altında qruplaşdır.',
			'settings.alwaysKeepSidebarOpen' => 'Yan menyunu həmişə açıq saxla',
			'settings.alwaysKeepSidebarOpenDescription' => 'Yan menyu genişlənmiş qalır və məzmun sahəsi buna uyğunlaşır',
			'settings.showUnwatchedCount' => 'Baxılmamış sayını göstər',
			'settings.showUnwatchedCountDescription' => 'Seriallarda və mövsümlərdə baxılmamış seriya sayını göstər',
			'settings.showEpisodeNumberOnCards' => 'Kartlarda seriya nömrəsini göstər',
			'settings.showEpisodeNumberOnCardsDescription' => 'Seriya kartlarında mövsüm və seriya nömrəsini göstər',
			'settings.showSeasonPostersOnTabs' => 'Mərhələlərdə mövsüm posterlərini göstər',
			'settings.showSeasonPostersOnTabsDescription' => 'Hər mövsümün posterini öz bölməsinin üstündə göstər',
			'settings.tvFullCardLayout' => 'Tam TV kartları',
			'settings.tvFullCardLayoutDescription' => 'Aktyor adları üstündə olan yalnız şəkil tərkibli TV kartları istifadə et',
			'settings.focusGlow' => 'Fokus parıltısı',
			'settings.focusGlowDescription' => 'Fokuslanmış kartın ətrafında yumşaq parıltı çək',
			'settings.visualEffects' => 'Vizual effektlər',
			'settings.visualEffectsAuto' => 'Avtomatik',
			'settings.visualEffectsAutoDescription' => 'Zəif cihazlarda effektləri avtomatik olaraq azalt',
			'settings.visualEffectsFull' => 'Tam',
			'settings.visualEffectsReduced' => 'Azaldılmış',
			'settings.visualEffectsReducedDescription' => 'Daha az animasiya və daha aşağı keyfiyyətli şəkillər',
			'settings.hideSpoilers' => 'Baxılmamış seriyalar üçün spoylerləri gizlə',
			'settings.hideSpoilersDescription' => 'Baxılmamış seriyalar üçün miniatürləri və təsvirləri bulanıqlaşdır',
			'settings.playerBackend' => 'Oynadıcı infrastrukturu',
			'settings.exoPlayer' => 'ExoPlayer',
			'settings.mpv' => 'mpv',
			'settings.hardwareDecoding' => 'Avadanlıq kod açılması',
			'settings.hardwareDecodingDescription' => 'Mümkün olduqda avadanlıq sürətləndirməsini istifadə et',
			'settings.bufferSize' => 'Bufer həcmi',
			'settings.bufferSizeMB' => ({required Object size}) => '${size}MB',
			'settings.bufferSizeAuto' => 'Avtomatik (Tövsiyə olunan)',
			'settings.bufferSizeWarning' => ({required Object heap, required Object size}) => '${heap}MB yaddaş əlçatandır. ${size}MB bufer oynatmaya təsir edə bilər.',
			'settings.defaultQualityTitle' => 'Defolt keyfiyyət',
			'settings.musicQualityTitle' => 'Musiqi keyfiyyəti',
			'settings.subtitleStyling' => 'Altyazı tənzimləmələri',
			'settings.subtitleStylingDescription' => 'Altyazı görünüşünü özünüləşdirin',
			'settings.smallSkipDuration' => 'Kiçik ötürmə müddəti',
			'settings.largeSkipDuration' => 'Böyük ötürmə müddəti',
			'settings.rewindOnResume' => 'Davam edərkən geri sar',
			'settings.secondsUnit' => ({required Object seconds}) => '${seconds} saniyə',
			'settings.defaultSleepTimer' => 'Defolt yuxu taymeri',
			'settings.minutesUnit' => ({required Object minutes}) => '${minutes} dəqiqə',
			'settings.rememberTrackSelections' => 'Hər film/serial üçün səs/altyazı seçimlərini xatırla',
			'settings.rememberTrackSelectionsDescription' => 'Hər məzmun üçün səs və altyazı seçimlərini yadda saxla',
			'settings.followServerTrackSelections' => 'Hər epizod üçün serverin trek seçimlərini istifadə et',
			'settings.followServerTrackSelectionsDescription' => 'Epizod dəyişəndə cari seçimi köçürmək əvəzinə serverdə seçilmiş səs və altyazını tətbiq et',
			'settings.showChapterMarkersOnTimeline' => 'Zaman çubuğunda hissə işarələrini göstər',
			'settings.showChapterMarkersOnTimelineDescription' => 'Zaman çubuğunu hissə sərhədlərinə böl',
			'settings.clickVideoTogglesPlayback' => 'Oynat/fasilə üçün videoya toxun',
			'settings.clickVideoTogglesPlaybackDescription' => 'İdarəetməni göstərmək əvəzinə oynatmaq/fasilə etmək üçün videoya toxun.',
			'settings.videoPlayerControls' => 'Video oynadıcı idarəetmələri',
			'settings.keyboardShortcuts' => 'Klaviatura qısayolları',
			'settings.keyboardShortcutsDescription' => 'Klaviatura qısayollarını özünüləşdirin',
			'settings.videoPlayerNavigation' => 'Video oynadıcı naviqasiyası',
			'settings.videoPlayerNavigationDescription' => 'Oynadıcı idarəetmələrində hərəkət etmək üçün ox düymələrini istifadə edin',
			'settings.crashReporting' => 'Xəta hesabatı',
			'settings.crashReportingDescription' => 'Tətbiqi təkmilləşdirməyə kömək etmək üçün xəta hesabatları göndərin',
			'settings.debugLogging' => 'Xəta saxlama jurnalı',
			'settings.debugLoggingDescription' => 'Problemləri həll etmək üçün ətraflı jurnal qeydiyyatını aktivləşdirin',
			'settings.viewLogs' => 'Jurnallara bax',
			'settings.viewLogsDescription' => 'Tətbiq jurnallarına baxın',
			'settings.clearImageCache' => 'Şəkil keşini təmizlə',
			'settings.clearImageCacheDescription' => 'Keşlənmiş şəkilləri təmizləyir. Yenidən yüklənənədək şəkillər daha yavaş yüklənə bilər.',
			'settings.clearImageCacheSuccess' => 'Şəkil keşi uğurla təmizləndi',
			'settings.resetSettings' => 'Tənzimləmələri sıfırla',
			'settings.resetSettingsDescription' => 'Defolt tənzimləmələri bərpa edin. Bu əməliyyat geri qaytarıla bilməz.',
			'settings.resetSettingsSuccess' => 'Tənzimləmələr uğurla sıfırlandı',
			'settings.backup' => 'Ehtiyat nüsxə',
			'settings.exportSettings' => 'Tənzimləmələri ixrac et',
			'settings.exportSettingsDescription' => 'Seçimlərinizi fayla yadda saxlayın',
			'settings.exportSettingsSuccess' => 'Tənzimləmələr ixrac edildi',
			'settings.importSettings' => 'Tənzimləmələri idxal et',
			'settings.importSettingsDescription' => 'Seçimləri fayldan bərpa edin',
			'settings.importSettingsConfirm' => 'Bu cari tənzimləmələrinizin üzərinə yazacaq. Davam edilsin?',
			'settings.importSettingsSuccess' => 'Tənzimləmələr idxal edildi',
			'settings.importSettingsInvalidFile' => 'Bu fayl düzgün Plezy tənzimləmələr faylı deyil',
			'settings.importSettingsNoUser' => 'Tənzimləmələri idxal etməzdən əvvəl daxil olun',
			'settings.shortcutsReset' => 'Qısayollar defolt vəziyyətə sıfırlandı',
			'settings.about' => 'Haqqında',
			'settings.aboutDescription' => 'Tətbiq məlumatı və lisenziyalar',
			'settings.updates' => 'Yenilənmələr',
			'settings.updateAvailable' => 'Yenilənmə var',
			'settings.checkForUpdates' => 'Yenilənmələri yoxla',
			'settings.autoCheckUpdatesOnStartup' => 'Açılışda yenilənmələri avtomatik yoxla',
			'settings.autoCheckUpdatesOnStartupDescription' => 'Açılışda yenilənmə olduqda xəbərdar et',
			'settings.validationErrorEnterNumber' => 'Lütfən düzgün rəqəm daxil edin',
			'settings.validationErrorDuration' => ({required Object min, required Object max, required Object unit}) => 'Müddət ${min} və ${max} ${unit} arasında olmalıdır',
			'settings.shortcutAlreadyAssigned' => ({required Object action}) => 'Qısayol artıq ${action} üçün təyin edilib',
			'settings.shortcutUpdated' => ({required Object action}) => '${action} üçün qısayol yeniləndi',
			'settings.saveFailed' => 'Dəyişikliklər yadda saxlanıla bilmədi. Təzədən cəhd edin.',
			'settings.autoSkip' => 'Avtomatik ötür',
			'settings.autoSkipIntro' => 'Girişi avtomatik ötür',
			'settings.autoSkipIntroDescription' => 'Bir neçə saniyədən sonra giriş işarələrini avtomatik ötür',
			'settings.autoSkipCredits' => 'Titrləri avtomatik ötür',
			'settings.autoSkipCreditsDescription' => 'Titrləri avtomatik ötür və növbəti seriyanı oynat',
			'settings.forceSkipMarkerFallback' => 'Ehtiyat işarələri məcburi et',
			'settings.forceSkipMarkerFallbackDescription' => 'Plex işarələri olsa belə hissə başlığı şablonlarını istifadə et',
			'settings.autoSkipDelay' => 'Avtomatik ötürmə ləngiməsi',
			'settings.autoSkipDelayDescription' => ({required Object seconds}) => 'Avtomatik ötürməzdən əvvəl ${seconds} saniyə gözlə',
			'settings.introPattern' => 'Giriş işarəsi şablonu',
			'settings.introPatternDescription' => 'Hissə başlıqlarında giriş işarələrini tapmaq üçün Regex şablonu',
			'settings.creditsPattern' => 'Titr işarəsi şablonu',
			'settings.creditsPatternDescription' => 'Hissə başlıqlarında titr işarələrini tapmaq üçün Regex şablonu',
			'settings.invalidRegex' => 'Səhv requlyar ifadə (Regex)',
			'settings.regex' => 'Requlyar ifadə (Regex)',
			'settings.downloads' => 'Yükləmələr',
			'settings.downloadLocationDescription' => 'Yüklənmiş məzmunun harada saxlanacağını seçin',
			'settings.downloadLocationDefault' => 'Defolt (Tətbiq yaddaşı)',
			'settings.downloadLocationCustom' => 'Xüsusi məkan',
			'settings.selectFolder' => 'Qovluq seç',
			'settings.resetToDefault' => 'Defolt vəziyyətə sıfırla',
			'settings.currentPath' => ({required Object path}) => 'Cari: ${path}',
			'settings.downloadLocationChanged' => 'Yükləmə məkanı dəyişdirildi',
			'settings.downloadLocationReset' => 'Yükləmə məkanı defolt vəziyyətə sıfırlandı',
			'settings.downloadLocationInvalid' => 'Seçilmiş qovluğa yazmaq olmur',
			'settings.downloadLocationPickerUnavailable' => 'Qovluq seçimi bu cihazda əlçatan deyil',
			'settings.downloadOnWifiOnly' => 'Yalnız Wi-Fi ilə yüklə',
			'settings.downloadOnWifiOnlyDescription' => 'Mobil məlumat istifadə edildikdə yükləmələri dayandır',
			'settings.autoRemoveWatchedDownloads' => 'Baxılmış yükləmələri avtomatik sil',
			'settings.autoRemoveWatchedDownloadsDescription' => 'Baxılmış yükləmələri avtomatik olaraq sil',
			'settings.cellularDownloadBlocked' => 'Mobil şəbəkədə yükləmələr bloklanıb. Wi-Fi istifadə edin və ya tənzimləməni dəyişin.',
			'settings.maxVolume' => 'Maksimal səs',
			'settings.maxVolumeDescription' => 'Sakit videolar üçün səsin 100%-dən yuxarı qalxmasına icazə ver',
			'settings.maxVolumePercent' => ({required Object percent}) => '%${percent}',
			'settings.discordRichPresence' => 'Discord Rich Presence',
			'settings.discordRichPresenceDescription' => 'Discord-da nəyə baxdığınızı göstərin',
			'settings.services' => 'Xidmətlər',
			'settings.servicesDescription' => 'Trakt, MyAnimeList, Seerr və daha çoxunu qoşun',
			'settings.manageLibrariesDescription' => 'Kitabxanaları yenidən sıralayın və gizlədin',
			'settings.autoPip' => 'Avtomatik Pəncərə daxilində Pəncərə (PiP)',
			'settings.autoPipDescription' => 'Oynatma zamanı tətbiqdən çıxdıqda avtomatik PiP rejiminə keç',
			'settings.matchContentFrameRate' => 'Kadr tezliyini uyğunlaşdır',
			'settings.matchContentFrameRateDescription' => 'Ekran yenilənmə tezliyini video məzmununa uyğunlaşdır',
			'settings.matchRefreshRate' => 'Yenilənmə tezliyini uyğunlaşdır',
			'settings.matchRefreshRateDescription' => 'Tam ekranda ekran yenilənmə tezliyini uyğunlaşdır',
			'settings.matchDynamicRange' => 'Dinamik diapazonu uyğunlaşdır',
			'settings.matchDynamicRangeDescription' => 'HDR məzmun üçün HDR-ı açın, sonra SDR-a qayıdın',
			'settings.displaySwitchDelay' => 'Ekran dəyişmə ləngiməsi',
			'settings.tunneledPlayback' => 'Tünellənmiş oynatma',
			'settings.tunneledPlaybackDescription' => 'Video tünelləməni istifadə et. HDR oynatdıqda qara ekran görünürsə söndürün.',
			'settings.audioPassthrough' => 'Səsin birbaşa ötürülməsi (Passthrough)',
			'settings.audioPassthroughDescription' => 'Dolby/DTS səslərini yenidən kodlamadan TV və ya resiverə göndərir. Səs gəlmirsə söndürün.',
			'settings.audioPassthroughDescriptionAppleTv' => 'Atmos daxil olmaqla Dolby Digital Plus üçün Apple-ın daxili dekoderini istifadə edin. DTS və TrueHD yenə də çoxkanallı PCM kimi oynadılır. Səs gəlmirsə söndürün.',
			'settings.audioDownmix' => 'Stereo-ya çevir (Downmix)',
			'settings.audioDownmixDescription' => 'Çoxkanallı səsi stereo dinamiklər və ya qulaqlıqlar üçün iki kanala endirir',
			'settings.downmixCenterBoost' => 'Mərkəz kanal gücləndirilməsi',
			'settings.downmixCenterBoostValue' => ({required Object db}) => '${db} dB',
			'settings.downmixCenterBoostLabel' => 'Gücləndirmə (dB)',
			'settings.downmixCenterBoostShort' => 'dB',
			'settings.audioDownmixNormalize' => 'Çevirmədə səsi normallaşdır',
			'settings.audioDownmixNormalizeDescription' => 'Səs kəsilmələrinin qarşısını almaq üçün səviyyəni endirin.',
			'settings.atmosDiagnostics' => 'Atmos çıxış testi',
			'settings.atmosDiagnosticsDescription' => 'Sistem oynadıcısı vasitəsilə test siqnalları çalan Dolby Atmos çıxışını yoxlayın',
			'settings.atmosTestHlsAtmos' => 'Apple Atmos axını',
			'settings.atmosTestHlsAtmosDescription' => 'Düzgün işlədiyi məlum olan Dolby Atmos axını. Qəbuledici Dolby Atmos göstərməlidir.',
			'settings.atmosTestHlsControl' => 'Apple əhatəli səs axını',
			'settings.atmosTestHlsControlDescription' => 'Atmos olmayan idarəetmə axını.',
			'settings.atmosTestRawStream' => 'Xam EAC3 axını',
			'settings.atmosTestRawStreamDescription' => 'Test faylını eynilə oynadıcı daxili Atmos kimi yayımlayır.',
			'settings.atmosTestRawFile' => 'Xam EAC3 faylı',
			'settings.atmosTestRawFileDescription' => 'Məlum uzunluqda test faylını oynadır.',
			'settings.atmosTestAsbarNative' => 'Nümunə bufer rendereri (daxili)',
			'settings.atmosTestAsbarNativeDescription' => 'Faylın dəyişdirilməmiş sıxılmış səsini birbaşa sistem rendererinə ötürür. Test faylının URL-i tələb olunur.',
			'settings.atmosTestAsbarGenerated' => 'Nümunə bufer rendereri (yenidən qurulmuş)',
			'settings.atmosTestAsbarGeneratedDescription' => 'Eyni, lakin səs təsviri oynatmanın qurduğu kimi yenidən qurulur. Test faylının URL-i tələb olunur.',
			'settings.atmosTestSessionMode' => 'Film oynatma seansı rejimindən istifadə et',
			'settings.atmosTestSessionModeDescription' => 'Söndürüldükdə Dolby-nin sənədləşdirdiyi rejim işlədilir. Yandırıldıqda oynatmanın əvvəl istifadə etdiyi rejim işlədilir.',
			'settings.atmosTestShowRoutePicker' => 'AirPlay çıxışını seç',
			'settings.atmosTestHideRoutePicker' => 'AirPlay çıxış seçicisini gizlət',
			'settings.atmosTestRoutePickerDescription' => 'Testi AirPlay qəbuledicisinə göndərir. Müəyyən edilmiş səs rejimini yalnız AirPlay bildirir.',
			'settings.atmosTestStop' => 'Testi saxla',
			'settings.atmosTestUrl' => 'Test faylı URL-i',
			'settings.atmosTestUrlDescription' => 'Xam .ec3 Dolby Atmos faylının HTTP URL-i',
			'settings.atmosTestUrlMissing' => 'Əvvəlcə test faylı URL-ini təyin edin',
			'settings.atmosTestStatus' => 'Status',
			'settings.dvConversionMode' => 'Dolby Vision çevrilməsi',
			'settings.dvConversionModeDescription' => 'ExoPlayer-in Dolby Vision Profile 7 fayllarını necə emal edəcəyini seçin.',
			'settings.dvConversionAuto' => 'Avtomatik',
			'settings.dvConversionNative' => 'Daxili / Söndürülüb',
			'settings.dvConversionDv81' => 'P7 → P8.1',
			'settings.dvConversionHevcStrip' => 'P7 → HEVC',
			'settings.dvConversionAutoDescription' => 'Cihaz imkanlarının təyini və normal davranışdan istifadə et',
			'settings.dvConversionNativeDescription' => 'Daxili DV7-ni məcburi et',
			'settings.dvConversionDv81Description' => 'Dolby Vision profile 8.1-ə çevrilməni məcburi et',
			'settings.dvConversionHevcStripDescription' => 'Dolby Vision təbəqələrini sil və sadə HEVC kimi təqdim et',
			'settings.requireProfileSelectionOnOpen' => 'Açılışda profil soruş',
			'settings.requireProfileSelectionOnOpenDescription' => 'Tətbiq hər dəfə açıldıqda profil seçimini göstər',
			'settings.forceTvMode' => 'TV rejimini məcburi et',
			'settings.forceTvModeDescription' => 'TV interfeysini məcburi et. Avtomatik təyin etməyən cihazlar üçündür.',
			'settings.startInFullscreen' => 'Tam ekranda başlat',
			'settings.startInFullscreenDescription' => 'Plezy-ni açılışda tam ekran rejimində aç',
			'settings.exitFullscreenOnPlayerClose' => 'Oynadıcı bağlandıqda tam ekrandan çıx',
			'settings.exitFullscreenOnPlayerCloseDescription' => 'Video oynadıcını bağlayarkən avtomatik tam ekrandan çıx',
			'settings.autoHidePerformanceOverlay' => 'Məhsuldarlıq paneli avtomatik gizlənsin',
			'settings.autoHidePerformanceOverlayDescription' => 'Məhsuldarlıq panelini oynatıcı idarəetmələri ilə birlikdə gizlət',
			'settings.showNavBarLabels' => 'Naviqasiya paneli yazılarını göstər',
			'settings.showNavBarLabelsDescription' => 'Naviqasiya paneli ikonlarının altında mətni göstər',
			'settings.startupSection' => 'Başlanğıc bölməsi',
			'settings.display' => 'Ekran',
			'settings.homeScreen' => 'Ana ekran',
			'settings.navigation' => 'Naviqasiya',
			'settings.window' => 'Pəncərə',
			'settings.content' => 'Məzmun',
			'settings.player' => 'Oynadıcı',
			'settings.subtitlesAndConfig' => 'Altyazılar və konfiqurasiya',
			'settings.seekAndTiming' => 'Sarğı və vaxt tənzimləməsi',
			'settings.behavior' => 'Davranış',
			'search.hint' => 'Kino, serial, musiqi axtar...',
			'search.tryDifferentTerm' => 'Fərqli axtarış sözü cəhd edin',
			'search.searchYourMedia' => 'Mediyanızda axtarın',
			'search.enterTitleActorOrKeyword' => 'Ad, aktyor və ya açar söz daxil edin',
			'hotkeys.setShortcutFor' => ({required Object actionName}) => '${actionName} üçün qısayol təyin et',
			'hotkeys.clearShortcut' => 'Qısayolu təmizlə',
			'hotkeys.noShortcutSet' => 'Qısayol təyin edilməyib',
			'hotkeys.currentShortcut' => 'Cari qısayol:',
			'hotkeys.pressToRecord' => 'Qısayol yazmaq üçün seçin',
			'hotkeys.recordingShortcut' => 'İndi qısayol düymələrinə basın',
			'hotkeys.actions.playPause' => 'Oynat/Fasilə',
			'hotkeys.actions.volumeUp' => 'Səsi artır',
			'hotkeys.actions.volumeDown' => 'Səsi azalt',
			'hotkeys.actions.seekForward' => ({required Object seconds}) => 'İrəli sar (${seconds}san)',
			'hotkeys.actions.seekBackward' => ({required Object seconds}) => 'Geri sar (${seconds}san)',
			'hotkeys.actions.fullscreenToggle' => 'Tam ekranı dəyişdir',
			'hotkeys.actions.muteToggle' => 'Səsi aç/bağla',
			'hotkeys.actions.subtitleToggle' => 'Altyazını aç/bağla',
			'hotkeys.actions.audioTrackNext' => 'Növbəti səs zolağı',
			'hotkeys.actions.subtitleTrackNext' => 'Növbəti altyazı zolağı',
			'hotkeys.actions.chapterNext' => 'Növbəti hissə',
			'hotkeys.actions.chapterPrevious' => 'Əvvəlki hissə',
			'hotkeys.actions.episodeNext' => 'Növbəti seriya',
			'hotkeys.actions.episodePrevious' => 'Əvvəlki seriya',
			'hotkeys.actions.speedIncrease' => 'Sürəti artır',
			'hotkeys.actions.speedDecrease' => 'Sürəti azalt',
			'hotkeys.actions.speedReset' => 'Sürəti sıfırla',
			'hotkeys.actions.zoomIn' => 'Yaxınlaşdır',
			'hotkeys.actions.zoomOut' => 'Uzaqlaşdır',
			'hotkeys.actions.zoomReset' => 'Miqyası sıfırla',
			'hotkeys.actions.subSeekNext' => 'Növbəti altyazıya sar',
			'hotkeys.actions.subSeekPrev' => 'Əvvəlki altyazıya sar',
			'hotkeys.actions.shaderToggle' => 'Şeyderləri aç/bağla',
			'hotkeys.actions.skipMarker' => 'Girişi/Titrləri ötür',
			'hotkeys.actions.screenshot' => 'Ekran şəkli çək',
			'fileInfo.title' => 'Fayl məlumatı',
			'fileInfo.video' => 'Video',
			'fileInfo.audio' => 'Səs',
			'fileInfo.subtitles' => 'Altyazılar',
			'fileInfo.file' => 'Fayl',
			'fileInfo.codec' => 'Kodek',
			'fileInfo.resolution' => 'Ayırdetmə',
			'fileInfo.bitrate' => 'Bit sürəti (Bitrate)',
			'fileInfo.frameRate' => 'Kadr tezliyi',
			'fileInfo.aspectRatio' => 'Tərəf nisbəti',
			'fileInfo.profile' => 'Profil',
			'fileInfo.bitDepth' => 'Bit dərinliyi',
			'fileInfo.colorSpace' => 'Rəng sahəsi',
			'fileInfo.colorRange' => 'Rəng diapazonu',
			'fileInfo.colorPrimaries' => 'Əsas rənglər',
			'fileInfo.chromaSubsampling' => 'Rəng alt-diskretləşdirməsi',
			'fileInfo.channels' => 'Kanallar',
			'fileInfo.overallBitrate' => 'Ümumi bit sürəti',
			'fileInfo.path' => 'Yol',
			'fileInfo.size' => 'Həcm',
			'fileInfo.container' => 'Konteyner',
			'fileInfo.duration' => 'Müddət',
			'fileInfo.optimizedForStreaming' => 'Yayım üçün optimallaşdırılıb',
			'fileInfo.has64bitOffsets' => '64-bit ofsetlər',
			'mediaMenu.markAsWatched' => 'Baxıldı olaraq işarələ',
			'mediaMenu.markAsUnwatched' => 'Baxılmadı olaraq işarələ',
			'mediaMenu.removeFromContinueWatching' => 'İzləməyə davam et-dən sil',
			'mediaMenu.viewDetails' => 'Ətraflı bax',
			'mediaMenu.goToSeries' => 'Seriala keç',
			'mediaMenu.shufflePlay' => 'Qarışıq oynat',
			'mediaMenu.shuffleNotAvailableOffline' => 'Qarışıq oynatma oflayn rejimdə əlçatan deyil',
			'mediaMenu.fileInfo' => 'Fayl məlumatı',
			'mediaMenu.deleteFromServer' => 'Serverdən sil',
			'mediaMenu.confirmDelete' => 'Bu media və faylları serverinizdən silinsin?',
			'mediaMenu.deleteMultipleWarning' => 'Bu bütün seriyaları və faylları əhatə edir.',
			'mediaMenu.mediaDeletedSuccessfully' => 'Media elementi uğurla silindi',
			'mediaMenu.mediaFailedToDelete' => 'Media elementi silinə bilmədi',
			'mediaMenu.rate' => 'Qiymətləndir',
			'mediaMenu.playFromBeginning' => 'Əvvəldən oynat',
			'mediaMenu.playVersion' => 'Versiyanı oynat...',
			'rateSheet.title' => 'Qiymətləndir',
			'rateSheet.server' => 'Server',
			'rateSheet.favorite' => 'Sevimli',
			'rateSheet.favorited' => 'Sevimlilərə əlavə edildi',
			'rateSheet.saved' => 'Yadda saxlanıldı',
			'rateSheet.notAvailable' => 'Uyğunluq tapılmadı',
			'rateSheet.noConnectedServices' => 'Orada qiymətləndirmək üçün Tənzimləmələrdən xidmət qoşun.',
			'accessibility.mediaCardMovie' => ({required Object title}) => '${title}, kino',
			'accessibility.mediaCardShow' => ({required Object title}) => '${title}, TV şou',
			'accessibility.mediaCardEpisode' => ({required Object title, required Object episodeInfo}) => '${title}, ${episodeInfo}',
			'accessibility.mediaCardSeason' => ({required Object title, required Object seasonInfo}) => '${title}, ${seasonInfo}',
			'accessibility.mediaCardWatched' => 'baxılıb',
			'accessibility.mediaCardPartiallyWatched' => ({required Object percent}) => '%${percent} baxılıb',
			'accessibility.mediaCardUnwatched' => 'baxılmayıb',
			'accessibility.tapToPlay' => 'Oynatmaq üçün toxunun',
			'accessibility.decrease' => 'Azalt',
			'accessibility.increase' => 'Artır',
			'accessibility.decreaseValue' => ({required Object label}) => '${label} dəyərini azalt',
			'accessibility.increaseValue' => ({required Object label}) => '${label} dəyərini artır',
			'accessibility.hue' => 'Rəng çaları',
			'accessibility.saturation' => 'Doyğunluq',
			'accessibility.brightness' => 'Parlaqlıq',
			'accessibility.hexColor' => 'Hex rəngi',
			'accessibility.expandText' => 'Mətni genişləndir',
			'accessibility.collapseText' => 'Mətni yığ',
			'accessibility.alphabetNavigation' => 'Əlifba naviqasiyası',
			'accessibility.alphabetScrollHint' => 'Hərflərə görə keçmək üçün yuxarı və ya aşağı sürüşdürün',
			'accessibility.rowColumnPosition' => ({required Object row, required Object rowCount, required Object column, required Object columnCount}) => 'Sətir ${row} / ${rowCount}, sütun ${column} / ${columnCount}',
			'accessibility.rowPosition' => ({required Object row, required Object rowCount}) => 'Sətir ${row} / ${rowCount}',
			'tooltips.shufflePlay' => 'Qarışıq oynat',
			'tooltips.playTrailer' => 'Treyleri oynat',
			'tooltips.markAsWatched' => 'Baxıldı olaraq işarələ',
			'tooltips.markAsUnwatched' => 'Baxılmadı olaraq işarələ',
			'audioTracks.track' => ({required Object n}) => 'Səs zolağı ${n}',
			'videoControls.audioLabel' => 'Səs',
			'videoControls.subtitlesLabel' => 'Altyazı',
			'videoControls.resetToZero' => '0ms-yə sıfırla',
			'videoControls.addTime' => ({required Object amount, required Object unit}) => '+${amount}${unit}',
			'videoControls.minusTime' => ({required Object amount, required Object unit}) => '-${amount}${unit}',
			'videoControls.playsLater' => ({required Object label}) => '${label} sonra oynadılır',
			'videoControls.playsEarlier' => ({required Object label}) => '${label} əvvəl oynadılır',
			'videoControls.noOffset' => 'Ofset yoxdur',
			'videoControls.letterbox' => 'Geniş ekran (Letterbox)',
			'videoControls.fillScreen' => 'Ekrana doldur',
			'videoControls.stretch' => 'Gərmək',
			'videoControls.lockRotation' => 'Dönməni kilidlə',
			'videoControls.unlockRotation' => 'Dönmə kilidini aç',
			'videoControls.timerActive' => 'Taymer aktivdir',
			'videoControls.playbackWillPauseIn' => ({required Object duration}) => 'Oynatma ${duration} sonra fasilə olunacaq',
			'videoControls.sleepTimerEndOfVideo' => 'Cari videonun sonu',
			'videoControls.sleepTimerStopAtHeader' => 'Dayanma vaxtı',
			'videoControls.sleepTimerDurationHeader' => 'Taymer',
			'videoControls.playbackWillPauseAtEnd' => 'Oynatma bu videonun sonunda fasilə olunacaq',
			'videoControls.stillWatching' => 'Hələ də baxırsınız?',
			'videoControls.pausingIn' => ({required Object seconds}) => '${seconds}san sonra fasilə edilir',
			'videoControls.continueWatching' => 'Davam et',
			'videoControls.autoPlayNext' => 'Növbətini avtomatik oynat',
			'videoControls.playNext' => 'Növbətini oynat',
			'videoControls.playButton' => 'Oynat',
			'videoControls.pauseButton' => 'Fasilə',
			'videoControls.showPlaybackControls' => 'Oynatma idarəetmələrini göstər',
			'videoControls.hidePlaybackControls' => 'Oynatma idarəetmələrini gizlət',
			'videoControls.seekBackwardButton' => ({required Object seconds}) => '${seconds} saniyə geri sar',
			'videoControls.seekForwardButton' => ({required Object seconds}) => '${seconds} saniyə irəli sar',
			'videoControls.previousButton' => 'Əvvəlki seriya',
			'videoControls.nextButton' => 'Növbəti seriya',
			'videoControls.previousChapterButton' => 'Əvvəlki hissə',
			'videoControls.nextChapterButton' => 'Növbəti hissə',
			'videoControls.muteButton' => 'Səsi söndür',
			'videoControls.unmuteButton' => 'Səsi aç',
			'videoControls.settingsButton' => 'Oynatma tənzimləmələri',
			'videoControls.tracksButton' => 'Səs və Altyazılar',
			'videoControls.chaptersButton' => 'Hissələr',
			'videoControls.versionQualityButton' => 'Versiya və Keyfiyyət',
			'videoControls.versionColumnHeader' => 'Versiya',
			'videoControls.qualityColumnHeader' => 'Keyfiyyət',
			'videoControls.qualityOriginal' => 'Orijinal',
			'videoControls.qualityPresetLabel' => ({required Object resolution, required Object bitrate}) => '${resolution}p ${bitrate} Mbps',
			'videoControls.transcodeUnavailableFallback' => 'Kod dəyişmə əlçatan deyil — orijinal keyfiyyətdə oynadılır',
			'videoControls.subtitleUnavailableFallback' => 'Seçilmiş altyazı yüklənə bilmədi — altyazısız davam edilir',
			'videoControls.pipButton' => 'Pəncərə daxilində pəncərə rejimi',
			'videoControls.aspectRatioButton' => 'Tərəf nisbəti',
			'videoControls.ambientLighting' => 'Ətraf işıqlandırması',
			'videoControls.fullscreenButton' => 'Tam ekrana keç',
			'videoControls.exitFullscreenButton' => 'Tam ekrandan çıx',
			'videoControls.alwaysOnTopButton' => 'Həmişə üstə',
			'videoControls.rotationLockButton' => 'Dönmə kilidi',
			'videoControls.lockScreen' => 'Ekranı kilidlə',
			'videoControls.screenLockButton' => 'Ekran kilidi',
			'videoControls.longPressToUnlock' => 'Kilidi açmaq üçün uzun basın',
			'videoControls.timelineSlider' => 'Video zaman çubuğu',
			'videoControls.volumeSlider' => 'Səs səviyyəsi',
			'videoControls.endsAt' => ({required Object time}) => 'Bitiş vaxtı: ${time}',
			'videoControls.pipActive' => 'Pəncərə daxilində pəncərə rejimində oynadılır',
			'videoControls.pipFailed' => 'PiP rejimi başladılarkən xəta',
			'videoControls.screenshotSaved' => 'Ekran şəkli yadda saxlanıldı',
			'videoControls.zoomPercent' => ({required Object percent}) => 'Miqyas %${percent}',
			'videoControls.pipErrors.androidVersion' => 'Android 8.0 və ya daha yenisini tələb edir',
			'videoControls.pipErrors.iosVersion' => 'iOS 15.0 və ya daha yenisini tələb edir',
			'videoControls.pipErrors.permissionDisabled' => 'PiP rejimi söndürülüb. Sistem tənzimləmələrindən aktivləşdirin.',
			'videoControls.pipErrors.notSupported' => 'Cihaz PiP rejimini dəstəkləmir',
			'videoControls.pipErrors.voSwitchFailed' => 'PiP üçün video çıxışı dəyişdirilə bilmədi',
			'videoControls.pipErrors.failed' => 'PiP rejimi başladılarkən xəta',
			'videoControls.pipErrors.unknown' => ({required Object error}) => 'Xəta baş verdi: ${error}',
			'videoControls.chapters' => 'Hissələr',
			'videoControls.noChaptersAvailable' => 'Hissələr əlçatan deyil',
			'videoControls.queue' => 'Növbə',
			'videoControls.noQueueItems' => 'Növbədə element yoxdur',
			'messages.markedAsWatched' => 'Baxıldı olaraq işarələndi',
			'messages.markedAsUnwatched' => 'Baxılmadı olaraq işarələndi',
			'messages.markedAsWatchedOffline' => 'Baxıldı olaraq işarələndi (onlayn olduqda eyniləşdiriləcək)',
			'messages.markedAsUnwatchedOffline' => 'Baxılmadı olaraq işarələndi (onlayn olduqda eyniləşdiriləcək)',
			'messages.autoRemovedWatchedDownload' => ({required Object title}) => 'Avtomatik silindi: ${title}',
			'messages.autoRemovedWatchedDownloads' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('az'))(n, one: 'Baxılmış ${n} yükləmə avtomatik silindi', other: 'Baxılmış ${n} yükləmə avtomatik silindi', ), 
			'messages.removedFromContinueWatching' => 'İzləməyə davam et-dən silindi',
			'messages.errorLoading' => ({required Object error}) => 'Xəta: ${error}',
			'messages.searchPartialResults' => 'Bəzi media serverlərində axtarış aparıla bilmədi. Mövcud nəticələr göstərilir.',
			'messages.streamInterrupted' => 'Yayım kəsildi. Təzədən cəhd etmək üçün oynat düyməsinə basın.',
			'messages.fileInfoNotAvailable' => 'Fayl məlumatı əlçatan deyil',
			'messages.playbackAuthenticationRequired' => 'Bu elementi oynatmaq üçün media serverinə yenidən daxil olun.',
			'messages.playbackServerUnavailable' => 'Media serveri əlçatan deyil. Sonra təzədən cəhd edin.',
			'messages.playbackDataInvalid' => 'Server yanlış oynatma məlumatı qaytardı.',
			'messages.playbackCancelled' => 'Oynatma ləğv edildi.',
			'messages.playbackFailed' => 'Oynatma başladılarkən xəta.',
			'messages.errorLoadingFileInfo' => ({required Object error}) => 'Fayl məlumatı yüklənərkən xəta: ${error}',
			_ => null,
		} ?? switch (path) {
			'messages.errorLoadingSeries' => 'Serial yüklənərkən xəta',
			'messages.musicNotSupported' => 'Musiqi oynatması hələ dəstəklənmir',
			'messages.noDescriptionAvailable' => 'Təsvir əlçatan deyil',
			'messages.noProfilesAvailable' => 'Profil yoxdur',
			'messages.contactAdminForProfiles' => 'Profil əlavə etmək üçün server inzibatçınızla əlaqə saxlayın',
			'messages.unableToDetermineLibrarySection' => 'Bu element üçün kitabxana bölməsi müəyyən edilə bilmədi',
			'messages.logsCleared' => 'Jurnallar təmizləndi',
			'messages.logsCopied' => 'Jurnallar buferə kopyalandı',
			'messages.noLogsAvailable' => 'Jurnal yoxdur',
			'messages.metadataRefreshing' => ({required Object title}) => '"${title}" üçün meta-məlumatlar yenilənir...',
			'messages.metadataRefreshStarted' => ({required Object title}) => '"${title}" üçün meta-məlumat yenilənməsi başladı',
			'messages.metadataRefreshFailed' => ({required Object error}) => 'Meta-məlumatlar yenilənə bilmədi: ${error}',
			'messages.logoutConfirm' => 'Çıxış etmək istədiyinizdən əminsiniz?',
			'messages.noSeasonsFound' => 'Mövsüm tapılmadı',
			'messages.seasonsLoadFailed' => 'Mövsümlər yüklənə bilmədi',
			'messages.noEpisodesFound' => 'Birinci mövsümdə seriya tapılmadı',
			'messages.noEpisodesFoundGeneral' => 'Seriya tapılmadı',
			'messages.episodesLoadFailed' => 'Seriyalar yüklənə bilmədi',
			'messages.noResultsFound' => 'Nəticə tapılmadı',
			'messages.sleepTimerSet' => ({required Object label}) => 'Yuxu taymeri ${label} üçün təyin edildi',
			'messages.noItemsAvailable' => 'Element yoxdur',
			'messages.failedToCreatePlayQueueNoItems' => 'Oynatma növbəsi yaradıla bilmədi — element yoxdur',
			'messages.failedPlayback' => ({required Object action, required Object error}) => '${action} uğursuz oldu: ${error}',
			'messages.switchingToCompatiblePlayer' => 'Uyğun oynadıcıya keçilir...',
			'messages.serverLimitTitle' => 'Oynatma uğursuz oldu',
			'messages.serverLimitBody' => 'Server xətası (HTTP 500). Məhdudiyyət bu seansı rədd etdi.',
			'messages.logsUploaded' => 'Jurnallar yükləndi',
			'messages.logsUploadFailed' => 'Jurnallar yüklənə bilmədi',
			'messages.logId' => 'Jurnal ID-si',
			'subtitlingStyling.text' => 'Mətn',
			'subtitlingStyling.border' => 'Haşiyə',
			'subtitlingStyling.background' => 'Arxa fon',
			'subtitlingStyling.fontSize' => 'Şrift ölçüsü',
			'subtitlingStyling.textColor' => 'Mətn rəngi',
			'subtitlingStyling.borderSize' => 'Haşiyə ölçüsü',
			'subtitlingStyling.borderColor' => 'Haşiyə rəngi',
			'subtitlingStyling.backgroundOpacity' => 'Arxa fon şəffaflığı',
			'subtitlingStyling.backgroundColor' => 'Arxa fon rəngi',
			'subtitlingStyling.position' => 'Mövqe',
			'subtitlingStyling.assOverride' => 'ASS ləğvi',
			'subtitlingStyling.overrideScale' => 'Miqyasla',
			'subtitlingStyling.overrideForce' => 'Məcburi et',
			'subtitlingStyling.overrideStrip' => 'Formatlaşdırmanı sil',
			'subtitlingStyling.positionTop' => 'Yuxarı',
			'subtitlingStyling.positionBottom' => 'Aşağı',
			'subtitlingStyling.bold' => 'Qalın',
			'subtitlingStyling.italic' => 'Kursiv',
			'subtitlingStyling.renderResolution' => 'Emal imkanı (Resolution)',
			'subtitlingStyling.renderResolutionScreen' => 'Ekran imkanı',
			'subtitlingStyling.renderResolutionVideo' => 'Video imkanı',
			'mpvConfig.title' => 'mpv.conf',
			'mpvConfig.description' => 'Təkmilləşdirilmiş video oynatıcı tənzimləmələri',
			'mpvConfig.presets' => 'Ön ayarlar',
			'mpvConfig.noPresets' => 'Yadda saxlanılmış ön ayar yoxdur',
			'mpvConfig.saveAsPreset' => 'Ön ayar kimi yadda saxla...',
			'mpvConfig.presetName' => 'Ön ayar adı',
			'mpvConfig.presetNameHint' => 'Bu ön ayar üçün ad daxil edin',
			'mpvConfig.loadPreset' => 'Yüklə',
			'mpvConfig.deletePreset' => 'Sil',
			'mpvConfig.presetSaved' => 'Ön ayar yadda saxlanıldı',
			'mpvConfig.presetLoaded' => 'Ön ayar yükləndi',
			'mpvConfig.presetDeleted' => 'Ön ayar silindi',
			'mpvConfig.confirmDeletePreset' => 'Bu ön ayarı silmək istədiyinizə əminsiniz?',
			'mpvConfig.configPlaceholder' => 'gpu-api=vulkan\nhwdec=auto\n# şərh',
			'dialog.confirmAction' => 'Əməliyyatı təsdiqlə',
			'profiles.addPlezyProfile' => 'Plezy profili əlavə et',
			'profiles.switchingProfile' => 'Profil dəyişdirilir…',
			'profiles.deleteThisProfileTitle' => 'Bu profil silinsin?',
			'profiles.deleteThisProfileMessage' => ({required Object displayName}) => '${displayName} silinəcək. Qoşulmalar təsirlənmir.',
			'profiles.active' => 'Aktiv',
			'profiles.manage' => 'İdarə et',
			'profiles.delete' => 'Sil',
			'profiles.signOut' => 'Çıxış et',
			'profiles.signOutPlexTitle' => 'Plex-dən çıxılsın?',
			'profiles.signOutPlexMessage' => ({required Object displayName}) => '${displayName} və bütün Plex Ev istifadəçiləri silinsin?',
			'profiles.signedOutPlex' => 'Plex-dən çıxıldı.',
			'profiles.signOutFailed' => 'Çıxış uğursuz oldu.',
			'profiles.sectionTitle' => 'Profillər',
			'profiles.summarySingle' => 'İdarə olunan istifadəçiləri və yerli kimlikləri qarışdırmaq üçün profillər əlavə edin',
			'profiles.summaryMultipleWithActive' => ({required Object count, required Object activeName}) => '${count} profil · aktiv: ${activeName}',
			'profiles.summaryMultiple' => ({required Object count}) => '${count} profil',
			'profiles.removeConnectionTitle' => 'Qoşulma silinsin?',
			'profiles.removeConnectionMessage' => ({required Object displayName, required Object connectionLabel}) => '${displayName} istifadəçisinin ${connectionLabel} giriş hüququ silinəcək. Digər profillərdə qalacaq.',
			'profiles.deleteProfileTitle' => 'Profil silinsin?',
			'profiles.deleteProfileMessage' => ({required Object displayName}) => '${displayName} və onun qoşulmaları silinəcək. Serverlər əlçatan qalır.',
			'profiles.profileNameLabel' => 'Profil adı',
			'profiles.pinProtectionLabel' => 'PIN mühafizəsi',
			'profiles.setPin' => 'PIN təyin et',
			'profiles.setPinTitle' => 'PIN təyin et',
			'profiles.confirmPinTitle' => 'PIN-i təsdiqlə',
			'profiles.pinSet' => 'PIN təyin edildi',
			'profiles.changePin' => 'Dəyişdir',
			'profiles.removePin' => 'Sil',
			'profiles.connectionsLabel' => 'Qoşulmalar',
			'profiles.add' => 'Əlavə et',
			'profiles.deleteProfileButton' => 'Profili sil',
			'profiles.noConnectionsHint' => 'Qoşulma yoxdur — bu profili istifadə etmək üçün birini əlavə edin.',
			'profiles.noConnections' => 'Qoşulma yoxdur',
			'profiles.connectionDefault' => 'Defolt',
			'profiles.connectionAs' => ({required Object displayName}) => '${displayName} olaraq',
			'profiles.makeDefault' => 'Defolt et',
			'profiles.removeConnection' => 'Sil',
			'profiles.profileRenamed' => 'Profil adı dəyişdirildi.',
			'profiles.borrowAddTo' => ({required Object displayName}) => '${displayName} profilinə əlavə et',
			'profiles.borrowExplain' => 'Başqa profilin qoşulmasını istifadə edin. PIN ilə qorunan profillər PIN tələb edir.',
			'profiles.borrowEmpty' => 'Hələ istifadə ediləcək bir şey yoxdur.',
			'profiles.borrowEmptySubtitle' => 'Əvvəlcə başqa bir profile Plex və ya Jellyfin qoşun.',
			'profiles.borrowLoadFailed' => 'Əlçatan qoşulmalar yüklənə bilmədi. Təzədən cəhd edin.',
			'profiles.borrowFromProfile' => ({required Object displayName}) => '${displayName} profilindən',
			'profiles.borrowConnectionBorrowed' => 'Qoşulma istifadə edildi.',
			'profiles.borrowFailed' => 'Qoşulma istifadə edilə bilmədi.',
			'profiles.incorrectPin' => 'Səhv PIN.',
			'profiles.incorrectPinTryAgain' => 'Səhv PIN. Lütfən təzədən cəhd edin.',
			'profiles.newProfile' => 'Yeni profil',
			'profiles.profileNameHint' => 'məs. Qonaqlar, Uşaqlar, Qonaq otağı',
			'profiles.pinProtectionOptional' => 'PIN mühafizəsi (istəyə bağlı)',
			'profiles.pinExplain' => 'Profillər arası keçid üçün 4 rəqəmli PIN tələb olunur.',
			'profiles.continueButton' => 'Davam et',
			'profiles.pinsDontMatch' => 'PIN-lər uyğun gəlmir',
			'connections.sectionTitle' => 'Qoşulmalar',
			'connections.addConnection' => 'Qoşulma əlavə et',
			'connections.addConnectionSubtitleNoProfile' => 'Plex ilə daxil olun və ya Jellyfin serverinə qoşulun',
			'connections.addConnectionSubtitleScoped' => ({required Object displayName}) => '${displayName} profilinə əlavə et: Plex, Jellyfin və ya başqa profil qoşulması',
			'connections.sessionExpiredOne' => ({required Object name}) => '${name} üçün seansın vaxtı bitdi',
			'connections.sessionExpiredMany' => ({required Object count}) => '${count} server üçün seansın vaxtı bitdi',
			'connections.signInAgain' => 'Yenidən daxil ol',
			'connections.editJellyfinTitle' => 'Jellyfin qoşulmasını dəyişdir',
			'connections.editJellyfinIntro' => ({required Object serverName}) => '${serverName} üçün URL əlavə edin və ya silin.',
			'discover.title' => 'Kəşf et',
			'discover.noContentAvailable' => 'Məzmun əlçatan deyil',
			'discover.addMediaToLibraries' => 'Kitabxanalarınıza bir az media əlavə edin',
			'discover.continueWatching' => 'İzləməyə davam et',
			'discover.continueWatchingIn' => ({required Object library}) => '${library} daxilində İzləməyə davam et',
			'discover.nextUp' => 'Sırada',
			'discover.nextUpIn' => ({required Object library}) => '${library} daxilində Sırada',
			'discover.recentlyAdded' => 'Son əlavə olunanlar',
			'discover.recentlyAddedIn' => ({required Object library}) => '${library} daxilində Son əlavə olunanlar',
			'discover.latestAlbumsIn' => ({required Object library}) => '${library} daxilində Son albomlar',
			'discover.recentlyPlayedIn' => ({required Object library}) => '${library} daxilində Son oynadılanlar',
			'discover.mostPlayedIn' => ({required Object library}) => '${library} daxilində Ən çox oynadılanlar',
			'discover.playEpisode' => ({required Object season, required Object episode}) => 'M${season}S${episode}',
			'discover.cast' => 'Aktyorlar',
			'discover.extras' => 'Treylerlər və Əlavələr',
			'discover.studio' => 'Studiya',
			'discover.director' => 'Rejissor',
			'discover.directors' => 'Rejissorlar',
			'discover.movie' => 'Kino',
			'discover.tvShow' => 'TV Şou',
			'discover.minutesLeft' => ({required Object minutes}) => '${minutes} dəq qaldı',
			'discover.moreLikeThis' => 'Buna bənzərlər',
			'errors.searchFailed' => ({required Object error}) => 'Axtarış uğursuz oldu: ${error}',
			'errors.searchUnavailable' => 'Axtarış heç bir media serverinə çata bilmədi.',
			'errors.connectionTimeout' => ({required Object context}) => '${context} yüklənərkən vaxt bitdi',
			'errors.connectionFailed' => 'Media serverinə qoşulmaq olmur',
			'errors.unableToLoad' => ({required Object context}) => '${context} yüklənə bilmədi. Lütfən təzədən cəhd edin.',
			'errors.noClientAvailable' => 'Əlçatan klient yoxdur',
			'errors.failedToSwitchProfile' => ({required Object displayName}) => '${displayName} profilinə keçilə bilmədi',
			'errors.failedToDeleteProfile' => ({required Object displayName}) => '${displayName} profili silinə bilmədi',
			'errors.failedToRate' => 'Reytinq yenilənə bilmədi',
			'libraries.title' => 'Kitabxanalar',
			'libraries.fallbackTitle' => 'Kitabxana',
			'libraries.refreshMetadata' => 'Meta-məlumatları yenilə',
			'libraries.noLibrariesFound' => 'Kitabxana tapılmadı',
			'libraries.allLibrariesHidden' => 'Bütün kitabxanalar gizlədilib',
			'libraries.hiddenLibrariesCount' => ({required Object count}) => 'Gizli kitabxanalar (${count})',
			'libraries.thisLibraryIsEmpty' => 'Bu kitabxana boşdur',
			'libraries.noItemsMatchFilters' => 'Filtrlərə uyğun element tapılmadı',
			'libraries.resetFilters' => 'Filtrləri sıfırla',
			'libraries.all' => 'Hamısı',
			'libraries.clearAll' => 'Hamısını təmizlə',
			'libraries.refreshMetadataConfirm' => ({required Object title}) => '"${title}" üçün meta-məlumatları yeniləmək istədiyinizdən əminsiniz?',
			'libraries.manageLibraries' => 'Kitabxanaları idarə et',
			'libraries.sort' => 'Sırala',
			'libraries.sortBy' => 'Sıralama meyarı',
			'libraries.filters' => 'Filtrlər',
			'libraries.confirmActionMessage' => 'Bu əməliyyatı yerinə yetirmək istədiyinizdən əminsiniz?',
			'libraries.showLibrary' => 'Kitabxananı göstər',
			'libraries.hideLibrary' => 'Kitabxananı gizlət',
			'libraries.libraryOptions' => 'Kitabxana seçimləri',
			'libraries.content' => 'kitabxana məzmunu',
			'libraries.selectLibrary' => 'Kitabxana seç',
			'libraries.filtersWithCount' => ({required Object count}) => 'Filtrlər (${count})',
			'libraries.noRecommendations' => 'Tövsiyə yoxdur',
			'libraries.noCollections' => 'Bu kitabxanada kolleksiya yoxdur',
			'libraries.noFoldersFound' => 'Qovluq tapılmadı',
			'libraries.folders' => 'qovluqlar',
			'libraries.tabs.recommended' => 'Tövsiyə olunanlar',
			'libraries.tabs.browse' => 'Baxış',
			'libraries.tabs.collections' => 'Kolleksiyalar',
			'libraries.tabs.playlists' => 'Oynatma siyahıları',
			'libraries.groupings.title' => 'Qruplaşdırma',
			'libraries.groupings.all' => 'Hamısı',
			'libraries.groupings.movies' => 'Kinolar',
			'libraries.groupings.shows' => 'TV Şoular',
			'libraries.groupings.seasons' => 'Mövsümlər',
			'libraries.groupings.episodes' => 'Seriyalar',
			'libraries.groupings.artists' => 'Müğənnilər/Müəlliflər',
			'libraries.groupings.albums' => 'Albomlar',
			'libraries.groupings.tracks' => 'Mahnılar',
			'libraries.groupings.folders' => 'Qovluqlar',
			'libraries.filterCategories.genre' => 'Janr',
			'libraries.filterCategories.year' => 'İl',
			'libraries.filterCategories.contentRating' => 'Məzmun reytinqi',
			'libraries.filterCategories.tag' => 'Teq',
			'libraries.filterCategories.unwatched' => 'Baxılmayıb',
			'libraries.filterCategories.unplayed' => 'Oynadılmayıb',
			'libraries.filterCategories.favorites' => 'Sevimlilər',
			'libraries.sortLabels.title' => 'Ad',
			'libraries.sortLabels.dateAdded' => 'Əlavə olunma tarixi',
			'libraries.sortLabels.communityRating' => 'İcma reytinqi',
			'libraries.sortLabels.criticRating' => 'Tənqidçi reytinqi',
			'libraries.sortLabels.datePlayed' => 'Oynadılma tarixi',
			'libraries.sortLabels.playCount' => 'Oynadılma sayı',
			'libraries.sortLabels.productionYear' => 'İstehsal ili',
			'libraries.sortLabels.runtime' => 'Müddət',
			'libraries.sortLabels.officialRating' => 'Rəsmi reytinq',
			'libraries.sortLabels.premiereDate' => 'Premyera tarixi',
			'libraries.sortLabels.startDate' => 'Başlanğıc tarixi',
			'libraries.sortLabels.airTime' => 'Yayımlanma vaxtı',
			'libraries.sortLabels.studio' => 'Studiya',
			'libraries.sortLabels.random' => 'Təsadüfi',
			'libraries.sortLabels.lastEpisodeDateAdded' => 'Əlavə olunan son seriya tarixi',
			'about.title' => 'Haqqında',
			'about.openSourceLicenses' => 'Açıq mənbə lisenziyaları',
			'about.versionLabel' => ({required Object version}) => 'Versiya ${version}',
			'about.appDescription' => 'Flutter üçün gözəl bir Plex və Jellyfin klienti',
			'about.viewLicensesDescription' => 'Üçüncü tərəf kitabxanalarının lisenziyalarına baxın',
			'hubDetail.title' => 'Başlıq',
			'hubDetail.releaseYear' => 'Buraxılış ili',
			'hubDetail.dateAdded' => 'Əlavə olunma tarixi',
			'hubDetail.rating' => 'Reytinq',
			'hubDetail.noItemsFound' => 'Element tapılmadı',
			'logs.clearLogs' => 'Jurnalları təmizlə',
			'logs.copyLogs' => 'Jurnalları kopyala',
			'logs.uploadLogs' => 'Jurnalları yüklə',
			'licenses.relatedPackages' => 'Əlaqəli paketlər',
			'licenses.license' => 'Lisenziya',
			'licenses.licenseNumber' => ({required Object number}) => 'Lisenziya ${number}',
			'licenses.licensesCount' => ({required Object count}) => '${count} lisenziya',
			'navigation.libraries' => 'Kitabxanalar',
			'navigation.downloads' => 'Yükləmələr',
			'navigation.explore' => 'Kəşf et',
			'explore.title' => 'Kəşf et',
			'explore.selectSource' => 'Mənbə seçin',
			'explore.rows.watchlist' => 'İzləmə siyahısı',
			'explore.rows.recommendedMovies' => 'Tövsiyə olunan kinolar',
			'explore.rows.recommendedShows' => 'Tövsiyə olunan seriallar',
			'explore.rows.trendingMovies' => 'Trend kinolar',
			'explore.rows.trendingShows' => 'Trend seriallar',
			'explore.rows.popularMovies' => 'Məşhur kinolar',
			'explore.rows.popularShows' => 'Məşhur seriallar',
			'explore.rows.trendingAnime' => 'Trend animelər',
			'explore.rows.suggestedAnime' => 'Tövsiyə olunan animelər',
			'explore.rows.airingAnime' => 'Ən yaxşı yayımlanan animelər',
			'explore.rows.popularAnime' => 'Ən məşhur animelər',
			'explore.rows.trending' => 'Trendlər',
			'explore.rows.upcomingMovies' => 'Gələcək kinolar',
			'explore.rows.upcomingShows' => 'Gələcək seriallar',
			'explore.status.airing' => 'Yayımlanır',
			'explore.status.ended' => 'Bitdi',
			'explore.status.canceled' => 'Ləğv edildi',
			'explore.status.upcoming' => 'Gələcək',
			'explore.episodeCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('az'))(n, one: '${n} seriya', other: '${n} seriya', ), 
			'explore.cast' => 'Aktyorlar',
			'explore.characters' => 'Personajlar',
			'explore.addToWatchlist' => 'İzləmə siyahısına əlavə et',
			'explore.removeFromWatchlist' => 'İzləmə siyahısından sil',
			'explore.watchlistUpdateFailed' => 'İzləmə siyahısı yenilənə bilmədi',
			'explore.notInLibrary' => 'Kitabxananızda yoxdur',
			'explore.inTheseLibraries' => 'Bu kitabxanalarda var',
			'explore.checkingLibrary' => 'Kitabxananız yoxlanılır...',
			'explore.emptyTitle' => 'Hələlik burada heç nə yoxdur',
			'explore.emptyMessage' => ({required Object source}) => '${source} mənbəsindən olan sətirlər burada görünəcək.',
			'explore.searchHint' => ({required Object source}) => '${source} daxilində axtar',
			'explore.searchEmpty' => ({required Object query}) => '"${query}" üçün nəticə tapılmadı',
			'explore.searchPrompt' => ({required Object source}) => '${source} vasitəsilə kino və seriallar axtarın.',
			'explore.searchFailed' => 'Axtarış uğursuz oldu. Bağlantınızı yoxlayın.',
			'collections.title' => 'Kolleksiyalar',
			'collections.collection' => 'Kolleksiya',
			'collections.empty' => 'Kolleksiya boşdur',
			'collections.deleteCollection' => 'Kolleksiyanı sil',
			'collections.deleteConfirm' => ({required Object title}) => '"${title}" silinsin? Bu əməliyyat geri qaytarıla bilməz.',
			'collections.deleted' => 'Kolleksiya silindi',
			'collections.deleteFailed' => 'Kolleksiya silinə bilmədi',
			'collections.deleteFailedWithError' => ({required Object error}) => 'Kolleksiya silinə bilmədi: ${error}',
			'collections.selectCollection' => 'Kolleksiya seç',
			'collections.collectionName' => 'Kolleksiya adı',
			'collections.enterCollectionName' => 'Kolleksiya adını daxil edin',
			'collections.addedToCollection' => 'Kolleksiyaya əlavə edildi',
			'collections.errorAddingToCollection' => 'Kolleksiyaya əlavə edilə bilmədi',
			'collections.created' => 'Kolleksiya yaradıldı',
			'collections.removeFromCollection' => 'Kolleksiyadan sil',
			'collections.removeFromCollectionConfirm' => ({required Object title}) => '"${title}" bu kolleksiyadan silinsin?',
			'collections.removedFromCollection' => 'Kolleksiyadan silindi',
			'collections.removeFromCollectionFailed' => 'Kolleksiyadan silinə bilmədi',
			'collections.removeFromCollectionError' => ({required Object error}) => 'Kolleksiyadan silinərkən xəta: ${error}',
			'collections.searchCollections' => 'Kolleksiyalarda axtar...',
			'playlists.title' => 'Oynatma siyahıları',
			'playlists.playlist' => 'Oynatma siyahısı',
			'playlists.noPlaylists' => 'Oynatma siyahısı tapılmadı',
			'playlists.create' => 'Oynatma siyahısı yarat',
			'playlists.playlistName' => 'Oynatma siyahısı adı',
			'playlists.enterPlaylistName' => 'Oynatma siyahısı adını daxil edin',
			'playlists.delete' => 'Oynatma siyahısını sil',
			'playlists.removeItem' => 'Oynatma siyahısından sil',
			'playlists.smartPlaylist' => 'Ağıllı oynatma siyahısı',
			'playlists.itemCount' => ({required Object count}) => '${count} element',
			'playlists.oneItem' => '1 element',
			'playlists.emptyPlaylist' => 'Bu oynatma siyahısı boşdur',
			'playlists.deleteConfirm' => 'Oynatma siyahısı silinsin?',
			'playlists.deleteMessage' => ({required Object name}) => '"${name}" siyahısını silmək istədiyinizdən əminsiniz?',
			'playlists.created' => 'Oynatma siyahısı yaradıldı',
			'playlists.deleted' => 'Oynatma siyahısı silindi',
			'playlists.itemAdded' => 'Oynatma siyahısına əlavə edildi',
			'playlists.itemRemoved' => 'Oynatma siyahısından silindi',
			'playlists.selectPlaylist' => 'Oynatma siyahısı seç',
			'playlists.searchPlaylists' => 'Oynatma siyahılarında axtar...',
			'playlists.errorCreating' => 'Oynatma siyahısı yaradıla bilmədi',
			'playlists.errorDeleting' => 'Oynatma siyahısı silinə bilmədi',
			'playlists.errorLoading' => 'Oynatma siyahıları yüklənə bilmədi',
			'playlists.errorAdding' => 'Oynatma siyahısına əlavə edilə bilmədi',
			'playlists.errorReordering' => 'Element yenidən sıralana bilmədi',
			'playlists.errorRemoving' => 'Oynatma siyahısından silinə bilmədi',
			'music.goToAlbum' => 'Alboma keç',
			'music.goToArtist' => 'İfaçıya keç',
			'music.instantMix' => 'Anında qarışıq',
			'music.playNext' => 'Növbətini oynat',
			'music.addToQueue' => 'Növbəyə əlavə et',
			'music.discNumber' => ({required Object n}) => 'Disk ${n}',
			'music.trackCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('az'))(n, one: '${n} mahnı', other: '${n} mahnı', ), 
			'music.nowPlaying' => 'İndi oynadılır',
			'music.playingFrom' => ({required Object title}) => '${title} mənbəsindən oynadılır',
			'music.queue' => 'Növbə',
			'music.clearQueue' => 'Növbəni təmizlə',
			'music.lyrics' => 'Mahnı sözləri',
			'music.noLyrics' => 'Mahnı sözləri yoxdur',
			'music.sleepTimer' => 'Yuxu taymeri',
			'music.sleepTimerEndOfTrack' => 'Mahnının sonu',
			'music.sleepTimerMinutes' => ({required Object n}) => '${n} dəqiqə',
			'music.stopPlayback' => 'Oynatmanı saxla',
			'music.previousTrack' => 'Əvvəlki mahnı',
			'music.nextTrack' => 'Növbəti mahnı',
			'music.repeat' => 'Təkrarla',
			'music.repeatAll' => 'Hamısını təkrarla',
			'music.repeatOne' => 'Birini təkrarla',
			'downloads.title' => 'Yükləmələr',
			'downloads.manage' => 'İdarə et',
			'downloads.tvShows' => 'TV Şoular',
			'downloads.movies' => 'Kinolar',
			'downloads.music' => 'Musiqi',
			'downloads.tracksQueued' => ({required Object count}) => 'Yükləmə üçün ${count} mahnı növbəyə alındı',
			'downloads.noDownloads' => 'Hələlik yükləmə yoxdur',
			'downloads.noDownloadsDescription' => 'Yüklənmiş məzmun oflayn baxış üçün burada görünəcək',
			'downloads.downloadNow' => 'Yüklə',
			'downloads.deleteDownload' => 'Yükləməni sil',
			'downloads.retryDownload' => 'Yükləməni təzədən cəhd et',
			'downloads.downloadQueued' => 'Yükləmə növbəyə alındı',
			'downloads.downloadResumed' => 'Yükləmə davam etdirildi',
			'downloads.serverErrorBitrate' => 'Server xətası: fayl sürət limitini aşa bilər',
			'downloads.storageFull' => 'Cihaz yaddaşı dolu olduğu üçün yükləmə dayandırıldı.',
			'downloads.episodesQueued' => ({required Object count}) => 'Yükləmə üçün ${count} seriya növbəyə alındı',
			'downloads.downloadDeleted' => 'Yükləmə silindi',
			'downloads.deleteConfirm' => ({required Object title}) => '"${title}" bu cihazdan silinsin?',
			'downloads.cancelledDownloadTitle' => 'Ləğv edilmiş yükləmə',
			'downloads.cancelledDownloadMessage' => 'Bu yükləmə ləğv edildi. Nə etmək istərdiniz?',
			'downloads.allEpisodesAlreadyDownloaded' => 'Bütün seriyalar artıq yüklənib',
			'downloads.resumeDownload' => 'Yükləməni davam etdir',
			'downloads.cancelledDownload' => 'Ləğv edilmiş yükləmə',
			'downloads.syncingFile' => ({required Object file, required Object status}) => '${file} (${status} eyniləşdirilir)',
			'downloads.downloadedFileClickToComplete' => ({required Object file}) => 'Yükləndi ${file} - Tamamlamaq üçün toxunun',
			'downloads.partialDownloadClickToComplete' => 'Hissəvi yükləndi - Tamamlamaq üçün toxunun',
			'downloads.deleting' => 'Silinir...',
			'downloads.deletingWithProgress' => ({required Object title, required Object current, required Object total}) => '${title} silinir... (${current} / ${total})',
			'downloads.queuedTooltip' => 'Növbədədir',
			'downloads.queuedFilesTooltip' => ({required Object files}) => 'Növbəyə alınan fayllar: ${files}',
			'downloads.downloadingTooltip' => 'Yüklənir...',
			'downloads.downloadingFilesTooltip' => ({required Object files}) => 'Yüklənən fayllar: ${files}',
			'downloads.noDownloadsTree' => 'Yükləmə yoxdur',
			'downloads.pauseAll' => 'Hamısını fasilə et',
			'downloads.resumeAll' => 'Hamısını davam etdir',
			'downloads.deleteAll' => 'Hamısını sil',
			'downloads.selectVersion' => 'Versiya seç',
			'downloads.allEpisodes' => 'Bütün seriyalar',
			'downloads.unwatchedOnly' => 'Yalnız baxılmayanlar',
			'downloads.nextNUnwatched' => ({required Object count}) => 'Növbəti ${count} baxılmayan',
			'downloads.customAmount' => 'Xüsusi miqdar...',
			'downloads.includeSpecials' => 'Xüsusi seriyaları daxil et',
			'downloads.howManyEpisodes' => 'Neçə seriya?',
			'downloads.invalidEpisodeCount' => 'Düzgün seriya sayı daxil edin.',
			'downloads.keepSynced' => 'Eyniləşdirilmiş saxla',
			'downloads.downloadOnce' => 'Bir dəfə yüklə',
			'downloads.keepNUnwatched' => ({required Object count}) => '${count} baxılmayan seriyanı saxla',
			'downloads.editSyncRule' => 'Eyniləşdirmə qaydasını dəyişdir',
			'downloads.removeSyncRule' => 'Eyniləşdirmə qaydasını sil',
			'downloads.removeSyncRuleConfirm' => ({required Object title}) => '"${title}" eyniləşdirməsi dayandırılsın? Yüklənmiş seriyalar saxlanılacaq.',
			'downloads.removeListSyncRuleConfirm' => ({required Object title}) => '"${title}" eyniləşdirməsi dayandırılsın?',
			'downloads.deleteSyncRuleDownloads' => 'Əlaqəli yükləmələri də sil',
			'downloads.deleteSyncRuleDownloadsDescription' => 'Başqa eyniləşdirmə qaydası və ya profil tərəfindən istifadə olunan yükləmələr saxlanılacaq.',
			'downloads.syncRuleCreated' => ({required Object count}) => 'Eyniləşdirmə qaydası yaradıldı — ${count} baxılmayan seriya saxlanılır',
			'downloads.syncRuleUpdated' => 'Eyniləşdirmə qaydası yeniləndi',
			'downloads.syncRuleRemoved' => 'Eyniləşdirmə qaydası silindi',
			'downloads.syncRuleAndDownloadsRemoved' => 'Eyniləşdirmə qaydası və əlaqəli yükləmələr silindi',
			'downloads.syncRuleCleanupBusy' => 'Eyniləşdirmə qaydaları hazırda yenilənir. Bir azdan təzədən cəhd edin.',
			'downloads.syncRuleCleanupUnavailable' => 'Əlaqəli yükləmələr təhlükəsiz şəkildə müəyyən edilə bilmədi. Serverə yenidən qoşulub cəhd edin və ya qaydanı yükləmələri silmədən silin.',
			'downloads.syncedNewEpisodes' => ({required Object title, required Object count}) => '${title} üçün ${count} yeni seriya eyniləşdirildi',
			'downloads.activeSyncRules' => 'Eyniləşdirmə qaydaları',
			'downloads.noSyncRules' => 'Eyniləşdirmə qaydası yoxdur',
			'downloads.manageSyncRule' => 'Eyniləşdirməni idarə et',
			'downloads.editEpisodeCount' => 'Seriya sayı',
			'downloads.editSyncFilter' => 'Eyniləşdirmə filtri',
			'downloads.syncAllItems' => 'Bütün elementlər eyniləşdirilir',
			'downloads.syncUnwatchedItems' => 'Baxılmayan elementlər eyniləşdirilir',
			'downloads.syncRuleServerContext' => ({required Object server, required Object status}) => 'Server: ${server} • ${status}',
			'downloads.syncRuleAvailable' => 'Əlçatandır',
			'downloads.syncRuleOffline' => 'Oflayn',
			'downloads.syncRuleSignInRequired' => 'Daxil olmaq tələb olunur',
			'downloads.syncRuleNotAvailableForProfile' => 'Cari profil üçün əlçatan deyil',
			'downloads.syncRuleUnknownServer' => 'Bilinməyən server',
			'downloads.syncRuleListCreated' => 'Eyniləşdirmə qaydası yaradıldı',
			'downloads.backgroundWarning.bannerBlocked' => 'Tətbiqdən çıxdıqda yükləmələr dayanacaq',
			'downloads.backgroundWarning.bannerDegraded' => 'Arxa fonda yükləmələr məhdudlaşdırıla bilər',
			'downloads.backgroundWarning.bannerAction' => 'Ətraflı',
			'downloads.backgroundWarning.sheetTitle' => 'Arxa fonda yükləmələr bloklanıb',
			'downloads.backgroundWarning.sheetTitleDegraded' => 'Arxa fonda yükləmələr məhdudlaşdırıla bilər',
			'downloads.backgroundWarning.sheetIntro' => 'Android Plezy-nin arxa fonda etibarlı şəkildə yükləməsinə mane olur.',
			'downloads.backgroundWarning.sheetIntroDegraded' => 'Cihazınız Plezy-nin arxa fonda nə vaxt yükləyə biləcəyini məhdudlaşdırır.',
			'downloads.backgroundWarning.reasonBackgroundRestricted' => 'Plezy-nin arxa fon istifadəsi məhdudlaşdırılıb. Batareya və ya arxa fon istifadəsini "Məhdudiyyətsiz" edin.',
			'downloads.backgroundWarning.reasonStandbyRestricted' => 'Android Plezy-ni məhdud gözləmə rejiminə salıb. Batareya istifadəsini "Məhdudiyyətsiz" edin.',
			'downloads.backgroundWarning.reasonDownloadChannelBlocked' => 'Yükləmə bildirişləri söndürülüb, ona görə gedişat və idarəetmələr əlçatan olmaya bilər.',
			'downloads.backgroundWarning.reasonNotificationsDisabled' => 'Bildirişlər söndürülüb. Android 13 və daha yeni versiyalarda uzun arxa fon yükləmələri üçün onlar tələb olunur.',
			'downloads.backgroundWarning.reasonDataSaver' => 'Data Saver aktivdir və bu, mobil internetdə arxa fon yükləmələrini bloklayır. Wi-Fi ilə yükləmələr işləməlidir.',
			'downloads.backgroundWarning.reasonOemUnknown' => 'Plezy arxa fonda olarkən yükləmələr dəfələrlə dayandı. Plezy-nin batareya və ya arxa fon istifadəsi tənzimləmələrini yoxlayın.',
			'downloads.backgroundWarning.openSettings' => 'Tənzimləmələri aç',
			'downloads.backgroundWarning.stillNotWorking' => 'Cihaza özəl kömək',
			'downloads.backgroundWarning.stillNotWorkingDescription' => 'Cihazınız üçün addımlara baxın və ya problem davam edərsə Tənzimləmələr › Jurnallara bax bölməsindən jurnal göndərin.',
			'downloads.backgroundWarning.dialogTitle' => 'Yükləmələr tamamlanmaya bilər',
			'downloads.backgroundWarning.dialogDownloadAnyway' => 'Yenə də yüklə',
			'downloads.backgroundWarning.dialogFixFirst' => 'Əvvəlcə bunu düzəlt',
			'downloads.backgroundWarning.statusTile' => 'Arxa fonda yükləmələr',
			'downloads.backgroundWarning.statusOk' => 'Arxa fonda işləməyə icazə verilir',
			'downloads.backgroundWarning.statusBlocked' => 'Sistem tənzimləmələri ilə bloklanıb',
			'downloads.backgroundWarning.statusDegraded' => 'Sistem tənzimləmələri ilə məhdudlaşdırılıb',
			'downloads.backgroundWarning.statusUnknown' => 'Hələ yoxlanılmayıb',
			'downloads.backgroundWarning.settingsUnavailable' => 'Bu cihazda sistem tənzimləmələri açıla bilmədi',
			'downloads.backgroundWarning.linkUnavailable' => 'Bu cihazda dontkillmyapp.com açıla bilmədi',
			'shaders.title' => 'Şeyderlər',
			'shaders.noShaderDescription' => 'Video təkmilləşdirməsi yoxdur',
			'shaders.nvscalerDescription' => 'Daha kəskin video üçün NVIDIA miqyaslaması',
			'shaders.artcnnVariantNeutral' => 'Neytral',
			'shaders.artcnnVariantDenoise' => 'Küyün aradan qaldırılması',
			'shaders.artcnnVariantDenoiseSharpen' => 'Küyün aradan qaldırılması + Kəskinləşdirmə',
			'shaders.qualityFast' => 'Sürətli',
			'shaders.qualityHQ' => 'Yüksək keyfiyyət',
			'shaders.mode' => 'Rejim',
			'shaders.importShader' => 'Şeyder idxal et',
			'shaders.customShaderDescription' => 'Xüsusi GLSL şeyderi',
			'shaders.shaderImported' => 'Şeyder idxal edildi',
			'shaders.shaderImportFailed' => 'Şeyder idxal edilə bilmədi',
			'shaders.deleteShader' => 'Şeyderi sil',
			'shaders.deleteShaderConfirm' => ({required Object name}) => '"${name}" silinsin?',
			'videoSettings.playbackSpeed' => 'Oynatma sürəti',
			'videoSettings.normalSpeed' => 'Normal',
			'videoSettings.sleepTimerActive' => ({required Object duration}) => 'Aktivdir (${duration})',
			'videoSettings.zoom' => 'Miqyas',
			'videoSettings.sleepTimer' => 'Yuxu taymeri',
			'videoSettings.audioSync' => 'Səs sinxronizasiyası',
			'videoSettings.subtitleSync' => 'Altyazı sinxronizasiyası',
			'videoSettings.hdr' => 'HDR',
			'videoSettings.audioOutput' => 'Səs çıxışı',
			'videoSettings.performanceOverlay' => 'Məhsuldarlıq paneli',
			'videoSettings.audioPassthrough' => 'Səsin birbaşa ötürülməsi',
			'videoSettings.audioOutputDolbyAtmos' => 'Dolby Atmos',
			'videoSettings.audioOutputDolbyAudio' => 'Dolby Audio',
			'videoSettings.audioOutputSurround' => 'Əhatəli səs',
			'videoSettings.audioOutputSpatial' => 'Məkan səsi',
			'videoSettings.audioOutputStereo' => 'Stereo',
			'videoSettings.audioNormalization' => 'Səsin gurluğunu normallaşdır',
			'videoSettings.audioDownmix' => 'Stereo-ya çevir',
			'performanceOverlay.color' => 'Rəng',
			'performanceOverlay.performance' => 'Məhsuldarlıq',
			'performanceOverlay.buffer' => 'Bufer',
			'performanceOverlay.app' => 'Tətbiq',
			'performanceOverlay.decoder' => 'Çözücü',
			'performanceOverlay.rawDecoder' => 'Xam çözücü',
			'performanceOverlay.tunneling' => 'Tünelləmə',
			'performanceOverlay.aspect' => 'Nisbət',
			'performanceOverlay.rotation' => 'Dönmə',
			'performanceOverlay.dvSource' => 'DV mənbəyi',
			'performanceOverlay.dvPath' => 'DV yolu',
			'performanceOverlay.p7Conversion' => 'P7 çevrilməsi',
			'performanceOverlay.sampleRate' => 'Diskretləşdirmə tezliyi',
			'performanceOverlay.pixelFormat' => 'Piksel formatı',
			'performanceOverlay.hwFormat' => 'HW formatı',
			'performanceOverlay.matrix' => 'Matrisa',
			'performanceOverlay.primaries' => 'Əsas rənglər',
			'performanceOverlay.transfer' => 'Ötürmə',
			'performanceOverlay.renderFps' => 'Emal FPS-i',
			'performanceOverlay.displayFps' => 'Ekran FPS-i',
			'performanceOverlay.avSync' => 'A/V Eyniləşdirilməsi',
			'performanceOverlay.dropped' => 'İtirilmiş kadrlar',
			'performanceOverlay.dvRpus' => 'DV RPU-ları',
			'performanceOverlay.dvRpuAverage' => 'DV RPU Ort.',
			'performanceOverlay.dvSampleAverage' => 'DV Nümunə Ort.',
			'performanceOverlay.maxLuma' => 'Maks Luma',
			'performanceOverlay.minLuma' => 'Min Luma',
			'performanceOverlay.maxCll' => 'MaxCLL',
			'performanceOverlay.maxFall' => 'MaxFALL',
			'performanceOverlay.cacheUsed' => 'İstifadə olunan keş',
			'performanceOverlay.cacheLimit' => 'Keş limiti',
			'performanceOverlay.speed' => 'Sürət',
			'performanceOverlay.player' => 'Oynadıcı',
			'performanceOverlay.memory' => 'Yaddaş',
			_ => null,
		} ?? switch (path) {
			'performanceOverlay.uiFps' => 'Arayüz (UI) FPS-i',
			'externalPlayer.title' => 'Xarici oynadıcı',
			'externalPlayer.useExternalPlayer' => 'Xarici oynadıcı istifadə et',
			'externalPlayer.useExternalPlayerDescription' => 'Videoları başqa tətbiqdə açın',
			'externalPlayer.selectPlayer' => 'Oynadıcı seç',
			'externalPlayer.customPlayers' => 'Xüsusi oynadıcılar',
			'externalPlayer.systemDefault' => 'Sistem defoltu',
			'externalPlayer.addCustomPlayer' => 'Xüsusi oynadıcı əlavə et',
			'externalPlayer.playerName' => 'Oynadıcı adı',
			'externalPlayer.playerNameHint' => 'Mənim oynadıcım',
			'externalPlayer.playerCommand' => 'Əmr',
			'externalPlayer.playerPackage' => 'Paket adı',
			'externalPlayer.playerUrlScheme' => 'URL sxemi',
			'externalPlayer.off' => 'Söndürülüb',
			'externalPlayer.launchFailed' => 'Xarici oynadıcı açıla bilmədi',
			'externalPlayer.appNotInstalled' => ({required Object name}) => '${name} quraşdırılmayıb',
			'externalPlayer.playInExternalPlayer' => 'Xarici oynadıcıda oynat',
			'metadataEdit.editMetadata' => 'Düzəliş et...',
			'metadataEdit.screenTitle' => 'Meta-məlumatlara düzəliş et',
			'metadataEdit.basicInfo' => 'Əsas məlumatlar',
			'metadataEdit.artwork' => 'Şəkillər/Posterlər',
			'metadataEdit.title' => 'Başlıq',
			'metadataEdit.sortTitle' => 'Sıralama başlığı',
			'metadataEdit.originalTitle' => 'Orijinal başlıq',
			'metadataEdit.releaseDate' => 'Buraxılış tarixi',
			'metadataEdit.contentRating' => 'Məzmun reytinqi',
			'metadataEdit.studio' => 'Studiya',
			'metadataEdit.tagline' => 'Deviz/Slogan',
			'metadataEdit.summary' => 'Məzmun/Xülasə',
			'metadataEdit.poster' => 'Poster',
			'metadataEdit.background' => 'Arxa fon',
			'metadataEdit.logo' => 'Loqo',
			'metadataEdit.squareArt' => 'Kvadrat şəkil',
			'metadataEdit.selectPoster' => 'Poster seç',
			'metadataEdit.selectBackground' => 'Arxa fon seç',
			'metadataEdit.selectLogo' => 'Loqo seç',
			'metadataEdit.selectSquareArt' => 'Kvadrat şəkil seç',
			'metadataEdit.fromUrl' => 'URL-dən',
			'metadataEdit.uploadFile' => 'Fayl yüklə',
			'metadataEdit.enterImageUrl' => 'Şəkil URL-i daxil edin',
			'metadataEdit.imageUrl' => 'Şəkil URL-i',
			'metadataEdit.metadataUpdated' => 'Meta-məlumatlar yeniləndi',
			'metadataEdit.metadataUpdateFailed' => 'Meta-məlumatlar yenilənə bilmədi',
			'metadataEdit.artworkUpdated' => 'Şəkillər yeniləndi',
			'metadataEdit.artworkUpdateFailed' => 'Şəkillər yenilənə bilmədi',
			'metadataEdit.noArtworkAvailable' => 'Şəkil əlçatan deyil',
			'metadataEdit.artworkOption' => ({required Object index}) => 'Şəkil seçimi ${index}',
			'metadataEdit.selectedArtworkOption' => ({required Object index}) => 'Şəkil seçimi ${index}, seçildi',
			'metadataEdit.notSet' => 'Təyin edilməyib',
			'metadataEdit.tags' => 'Teqlər',
			'metadataEdit.addTag' => 'Teq əlavə et',
			'metadataEdit.genre' => 'Janr',
			'metadataEdit.director' => 'Rejissor',
			'metadataEdit.writer' => 'Ssenarist',
			'metadataEdit.producer' => 'Prodüser',
			'metadataEdit.country' => 'Ölkə',
			'metadataEdit.label' => 'Etiket',
			'trakt.title' => 'Trakt',
			'trakt.connected' => 'Qoşuldu',
			'trakt.connectedAs' => ({required Object username}) => '@${username} olaraq qoşuldu',
			'trakt.disconnectConfirm' => 'Trakt hesabı ayırılsın?',
			'trakt.disconnectConfirmBody' => 'Plezy Trakt-a məlumat göndərməyi dayandıracaq.',
			'trakt.scrobble' => 'Real vaxt rejimində izləmə',
			'trakt.scrobbleDescription' => 'Oynatma zamanı Trakt-a məlumat göndər.',
			'trakt.watchedSync' => 'Baxış statusunu eyniləşdir',
			'trakt.watchedSyncDescription' => 'Plezy-də baxıldı işarələdikdə Trakt-da da işarələnsin.',
			'seerr.title' => 'Seerr',
			'seerr.connectTitle' => 'Seerr qoş',
			'seerr.serverUrl' => 'Server URL-i',
			'seerr.serverUrlHelper' => 'Seerr ünvanınız',
			'seerr.checkServer' => 'Davam et',
			'seerr.signInWithJellyfin' => 'Jellyfin ilə daxil ol',
			'seerr.signInWithEmby' => 'Emby ilə daxil ol',
			'seerr.signInWithLocal' => 'Yerli hesab istifadə et',
			'seerr.email' => 'E-poçt',
			'seerr.noSignInMethods' => 'Bu Seerr dəstəklənən daxil olma üsulu təklif etmir.',
			'seerr.instance' => 'Nüsxə',
			'seerr.disconnectConfirm' => 'Seerr ayırılsın?',
			'seerr.disconnectConfirmBody' => 'Plezy bu Seerr ünvanını unudacaq.',
			'seerr.request' => 'Sorğu göndər',
			'seerr.request4k' => '4K sorğu göndər',
			'seerr.seasons' => 'Mövsümlər',
			'seerr.allSeasons' => 'Bütün mövsümlər',
			'seerr.advancedOptions' => 'Təkmilləşdirilmiş',
			'seerr.destinationServer' => 'Hədəf server',
			'seerr.qualityProfile' => 'Keyfiyyət profili',
			'seerr.rootFolder' => 'Kök qovluq',
			'seerr.languageProfile' => 'Dil profili',
			'seerr.requestSubmitted' => 'Sorğu göndərildi',
			'seerr.requestFailed' => ({required Object error}) => 'Sorğu uğursuz oldu: ${error}',
			'seerr.requestsLoadFailed' => 'Seçimlər yüklənə bilmədi',
			'seerr.nothingToRequest' => 'Hər şey artıq var və ya sorğu göndərilib.',
			'seerr.statusAvailable' => 'Əlçatandır',
			'seerr.statusPartiallyAvailable' => 'Hissəvi əlçatandır',
			'seerr.statusRequested' => 'Sorğu göndərildi',
			'seerr.statusProcessing' => 'Emal edilir',
			'services.title' => 'Xidmətlər',
			'services.hubSubtitle' => 'İzləmə tərəqqisini eyniləşdirin və yeni başlıqlar sorğulayın.',
			'services.notConnected' => 'Qoşulmayıb',
			'services.connectedAs' => ({required Object username}) => '@${username} olaraq qoşuldu',
			'services.scrobble' => 'Tərəqqini avtomatik izlə',
			'services.scrobbleDescription' => 'Siyahınızı avtomatik yeniləyin.',
			'services.disconnectConfirm' => ({required Object service}) => '${service} ayırılsın?',
			'services.disconnectConfirmBody' => ({required Object service}) => 'Plezy ${service} yeniləməyi dayandıracaq.',
			'services.connectFailed' => ({required Object service}) => '${service} qoşula bilmədi. Təzədən cəhd edin.',
			'services.names.mal' => 'MyAnimeList',
			'services.names.anilist' => 'AniList',
			'services.names.simkl' => 'Simkl',
			'services.names.seerr' => 'Seerr',
			'services.deviceCode.title' => ({required Object service}) => 'Plezy-ni ${service} üzərində aktivləşdirin',
			'services.deviceCode.body' => ({required Object url}) => '${url} ünvanına keçin və bu kodu daxil edin:',
			'services.deviceCode.openToActivate' => ({required Object service}) => 'Aktivləşdirmək üçün ${service} açın',
			'services.deviceCode.copyCode' => 'Aktivləşdirmə kodunu kopyala',
			'services.deviceCode.waitingForAuthorization' => 'Səlahiyyət gözlənilir…',
			'services.deviceCode.codeCopied' => 'Kod kopyalandı',
			'services.oauthProxy.title' => ({required Object service}) => '${service} xidmətinə daxil olun',
			'services.oauthProxy.body' => 'Bu QR kodu skan edin və ya URL-i açın.',
			'services.oauthProxy.openToSignIn' => ({required Object service}) => 'Daxil olmaq üçün ${service} açın',
			'services.oauthProxy.copyUrl' => 'Daxil olma URL-ini kopyala',
			'services.oauthProxy.urlCopied' => 'URL kopyalandı',
			'services.libraryFilter.title' => 'Kitabxana filtri',
			'services.libraryFilter.subtitleAllSyncing' => 'Bütün kitabxanalar eyniləşdirilir',
			'services.libraryFilter.subtitleNoneSyncing' => 'Heç nə eyniləşdirilmir',
			'services.libraryFilter.subtitleBlocked' => ({required Object count}) => '${count} bloklandı',
			'services.libraryFilter.subtitleAllowed' => ({required Object count}) => '${count} icazə verildi',
			'services.libraryFilter.mode' => 'Filtr rejimi',
			'services.libraryFilter.modeBlacklist' => 'Qara siyahı',
			'services.libraryFilter.modeWhitelist' => 'Ağ siyahı',
			'services.libraryFilter.modeHintBlacklist' => 'Aşağıda seçilənlərdən başqa bütün kitabxanaları eyniləşdir.',
			'services.libraryFilter.modeHintWhitelist' => 'Yalnız aşağıda seçilən kitabxanaları eyniləşdir.',
			'services.libraryFilter.libraries' => 'Kitabxanalar',
			'services.libraryFilter.noLibraries' => 'Kitabxana yoxdur',
			'addServer.addJellyfinTitle' => 'Jellyfin serveri əlavə et',
			'addServer.serverUrls' => 'Server URL-ləri',
			'addServer.serverUrlsHelper' => 'Vergüllə ayrılmış bir neçə URL-ə icazə verilir.',
			'addServer.findServer' => 'Server tap',
			'addServer.searchingLocalServers' => 'Yerli Jellyfin serverləri axtarılır...',
			'addServer.localServers' => 'Yerli Jellyfin serverləri',
			'addServer.username' => 'İstifadəçi adı',
			'addServer.password' => 'Şifrə',
			'addServer.signIn' => 'Daxil ol',
			'addServer.change' => 'Dəyişdir',
			'addServer.required' => 'Tələb olunur',
			'addServer.couldNotReachServer' => ({required Object error}) => 'Serverə çatmaq olmadı: ${error}',
			'addServer.signInFailed' => ({required Object error}) => 'Daxil olma uğursuz oldu: ${error}',
			'addServer.quickConnectFailed' => ({required Object error}) => 'Sürətli Qoşulma uğursuz oldu: ${error}',
			'addServer.enterJellyfinUrlError' => 'Jellyfin server URL-inizi daxil edin',
			'addServer.addConnectionTitle' => 'Qoşulma əlavə et',
			'addServer.addConnectionTitleScoped' => ({required Object name}) => '${name} profilinə əlavə et',
			'addServer.connectToJellyfinCard' => 'Jellyfin-ə qoşul',
			'addServer.connectToJellyfinCardSubtitle' => 'Server URL, istifadəçi adı və şifrənizi daxil edin.',
			'addServer.connectToJellyfinCardSubtitleScoped' => ({required Object name}) => 'Jellyfin serverinə daxil olun. ${name} profilinə bağlanır.',
			'addServer.borrowFromAnotherProfile' => 'Başqa profildən götür',
			'addServer.borrowFromAnotherProfileSubtitle' => 'Başqa profilin qoşulmasını yenidən istifadə edin.',
			_ => null,
		};
	}
}
