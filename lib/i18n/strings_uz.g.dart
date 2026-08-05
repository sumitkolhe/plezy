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
class TranslationsUz extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsUz({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.uz,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <uz>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsUz _root = this; // ignore: unused_field

	@override 
	TranslationsUz $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsUz(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$app$uz app = _Translations$app$uz._(_root);
	@override late final _Translations$auth$uz auth = _Translations$auth$uz._(_root);
	@override late final _Translations$common$uz common = _Translations$common$uz._(_root);
	@override late final _Translations$screens$uz screens = _Translations$screens$uz._(_root);
	@override late final _Translations$settings$uz settings = _Translations$settings$uz._(_root);
	@override late final _Translations$search$uz search = _Translations$search$uz._(_root);
	@override late final _Translations$hotkeys$uz hotkeys = _Translations$hotkeys$uz._(_root);
	@override late final _Translations$fileInfo$uz fileInfo = _Translations$fileInfo$uz._(_root);
	@override late final _Translations$mediaMenu$uz mediaMenu = _Translations$mediaMenu$uz._(_root);
	@override late final _Translations$rateSheet$uz rateSheet = _Translations$rateSheet$uz._(_root);
	@override late final _Translations$accessibility$uz accessibility = _Translations$accessibility$uz._(_root);
	@override late final _Translations$tooltips$uz tooltips = _Translations$tooltips$uz._(_root);
	@override late final _Translations$audioTracks$uz audioTracks = _Translations$audioTracks$uz._(_root);
	@override late final _Translations$videoControls$uz videoControls = _Translations$videoControls$uz._(_root);
	@override late final _Translations$messages$uz messages = _Translations$messages$uz._(_root);
	@override late final _Translations$subtitlingStyling$uz subtitlingStyling = _Translations$subtitlingStyling$uz._(_root);
	@override late final _Translations$mpvConfig$uz mpvConfig = _Translations$mpvConfig$uz._(_root);
	@override late final _Translations$dialog$uz dialog = _Translations$dialog$uz._(_root);
	@override late final _Translations$profiles$uz profiles = _Translations$profiles$uz._(_root);
	@override late final _Translations$connections$uz connections = _Translations$connections$uz._(_root);
	@override late final _Translations$discover$uz discover = _Translations$discover$uz._(_root);
	@override late final _Translations$errors$uz errors = _Translations$errors$uz._(_root);
	@override late final _Translations$libraries$uz libraries = _Translations$libraries$uz._(_root);
	@override late final _Translations$about$uz about = _Translations$about$uz._(_root);
	@override late final _Translations$hubDetail$uz hubDetail = _Translations$hubDetail$uz._(_root);
	@override late final _Translations$logs$uz logs = _Translations$logs$uz._(_root);
	@override late final _Translations$licenses$uz licenses = _Translations$licenses$uz._(_root);
	@override late final _Translations$navigation$uz navigation = _Translations$navigation$uz._(_root);
	@override late final _Translations$explore$uz explore = _Translations$explore$uz._(_root);
	@override late final _Translations$collections$uz collections = _Translations$collections$uz._(_root);
	@override late final _Translations$playlists$uz playlists = _Translations$playlists$uz._(_root);
	@override late final _Translations$music$uz music = _Translations$music$uz._(_root);
	@override late final _Translations$downloads$uz downloads = _Translations$downloads$uz._(_root);
	@override late final _Translations$shaders$uz shaders = _Translations$shaders$uz._(_root);
	@override late final _Translations$videoSettings$uz videoSettings = _Translations$videoSettings$uz._(_root);
	@override late final _Translations$performanceOverlay$uz performanceOverlay = _Translations$performanceOverlay$uz._(_root);
	@override late final _Translations$externalPlayer$uz externalPlayer = _Translations$externalPlayer$uz._(_root);
	@override late final _Translations$metadataEdit$uz metadataEdit = _Translations$metadataEdit$uz._(_root);
	@override late final _Translations$trakt$uz trakt = _Translations$trakt$uz._(_root);
	@override late final _Translations$seerr$uz seerr = _Translations$seerr$uz._(_root);
	@override late final _Translations$services$uz services = _Translations$services$uz._(_root);
	@override late final _Translations$addServer$uz addServer = _Translations$addServer$uz._(_root);
}

// Path: app
class _Translations$app$uz extends Translations$app$en {
	_Translations$app$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Harbor';
}

// Path: auth
class _Translations$auth$uz extends Translations$auth$en {
	_Translations$auth$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get connectToJellyfin => 'Jellyfin-ga ulanish';
	@override String get useQuickConnect => 'Tezkor ulanishdan foydalanish';
	@override String get quickConnectInstructions => 'Jellyfin-da Tezkor ulanishni oching va ushbu kodni kiriting.';
	@override String get quickConnectWaiting => 'Tasdiq kutilmoqda…';
	@override String get quickConnectCancel => 'Bekor qilish';
	@override String get quickConnectExpired => 'Tezkor ulanish vaqti tugadi. Qaytadan urinib koʻring.';
}

// Path: common
class _Translations$common$uz extends Translations$common$en {
	_Translations$common$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get cancel => 'Bekor qilish';
	@override String get save => 'Saqlash';
	@override String get close => 'Yopish';
	@override String get clear => 'Tozalash';
	@override String get reset => 'Qayta oʻrnatish';
	@override String get submit => 'Yuborish';
	@override String get confirm => 'Tasdiqlash';
	@override String get retry => 'Qaytadan urinish';
	@override String get logout => 'Chiqish';
	@override String get unknown => 'Nomaʼlum';
	@override String get refresh => 'Yangilash';
	@override String get yes => 'Ha';
	@override String get no => 'Yoʻq';
	@override String get delete => 'Oʻchirish';
	@override String get edit => 'Tahrirlash';
	@override String get shuffle => 'Aralashtirish';
	@override String get addTo => 'Qoʻshish...';
	@override String get createNew => 'Yangi yaratish';
	@override String get disconnect => 'Uzilish';
	@override String get play => 'Ijro etish';
	@override String get pause => 'Pauza';
	@override String get resume => 'Davom ettirish';
	@override String get error => 'Xatolik';
	@override String get search => 'Qidiruv';
	@override String get home => 'Bosh sahifa';
	@override String get back => 'Orqaga';
	@override String get settings => 'Sozlamalar';
	@override String get ok => 'Tushunarli';
	@override String get off => 'Oʻchirilgan';
	@override String seasonNumber({required Object number}) => '${number}-mavsum';
	@override String episodeNumberTitle({required Object number, required Object title}) => '${number}-qism - ${title}';
	@override String chapterNumber({required Object number}) => '${number}-boʻlim';
	@override String get reconnect => 'Qayta ulanish';
	@override String get viewAll => 'Barchasini koʻrish';
	@override String get checkingNetwork => 'Tarmoq tekshirilmoqda...';
	@override String get loadingServers => 'Serverlar yuklanmoqda...';
	@override String get connectingToServers => 'Serverlarga ulanmoqda...';
	@override String get startingOfflineMode => 'Oflayn rejim ishga tushmoqda...';
	@override String get loading => 'Yuklanmoqda...';
	@override String get pressBackAgainToExit => 'Chiqish uchun orqaga tugmasini yana bir bor bosing';
	@override String get next => 'Keyingi';
}

// Path: screens
class _Translations$screens$uz extends Translations$screens$en {
	_Translations$screens$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get licenses => 'Litsenziyalar';
	@override String get switchProfile => 'Profilni almashtirish';
	@override String get subtitleStyling => 'Subtitr sozlamalari';
	@override String get mpvConfig => 'mpv.conf';
	@override String get logs => 'Jurnallar';
}

// Path: settings
class _Translations$settings$uz extends Translations$settings$en {
	_Translations$settings$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sozlamalar';
	@override String get language => 'Til';
	@override String get theme => 'Mavzu';
	@override String get appearance => 'Tashqi koʻrinish';
	@override String get videoPlayback => 'Video ijrosi';
	@override String get videoPlaybackDescription => 'Ijro parametrlarini sozlang';
	@override String get advanced => 'Kengaytirilgan';
	@override String get episodePosterMode => 'Qism poster stili';
	@override String get seriesPoster => 'Serial posteri';
	@override String get seasonPoster => 'Mavsum posteri';
	@override String get episodeThumbnail => 'Kadr koʻrinishi';
	@override String get showHeroSectionDescription => 'Bosh sahifada tanlangan kontent karuselini koʻrsatish';
	@override String get secondsLabel => 'Soniya';
	@override String get minutesLabel => 'Daqiqa';
	@override String get secondsShort => 'son';
	@override String get minutesShort => 'daq';
	@override String durationHint({required Object min, required Object max}) => 'Vaqtni kiriting (${min}-${max})';
	@override String get systemTheme => 'Tizim sozlamasi';
	@override String get lightTheme => 'Yorugʻ';
	@override String get darkTheme => 'Toʻq';
	@override String get oledTheme => 'OLED';
	@override String get libraryDensity => 'Kutubxona zichligi';
	@override String get compact => 'Ixcham';
	@override String get comfortable => 'Qulay';
	@override String get tvCornerSpotlightBackdrop => 'Burchak yoritish foni';
	@override String get tvCornerSpotlightBackdropDescription => 'Fonni toʻliq ekran oʻrniga yuqori oʻng burchakda koʻrsatish';
	@override String get viewMode => 'Koʻrish rejimi';
	@override String get gridView => 'Toʻrsimon';
	@override String get listView => 'Roʻyxat';
	@override String get showHeroSection => 'Asosiy boʻlimni koʻrsatish';
	@override String get continueWatchingAction => '"Tomoshani davom ettirish" harakati';
	@override String get continueWatchingPlay => 'Ijro etish';
	@override String get continueWatchingDetails => 'Tafsilotlarni ochish';
	@override String get episodeAction => 'Qism harakati';
	@override String get episodePlay => 'Ijro etish';
	@override String get episodeDetails => 'Tafsilotlarni ochish';
	@override String get showServerNameOnHubs => 'Boʻlimlarda server nomini koʻrsatish';
	@override String get showServerNameOnHubsDescription => 'Boʻlim sarlavhalarida har doim server nomini koʻrsatish.';
	@override String get groupLibrariesByServer => 'Kutubxonalarni server boʻyicha guruhlash';
	@override String get groupLibrariesByServerDescription => 'Yon menyudagi kutubxonalarni serverlar boʻyicha guruhlash.';
	@override String get alwaysKeepSidebarOpen => 'Yon menyuni har doim ochiq saqlash';
	@override String get alwaysKeepSidebarOpenDescription => 'Yon menyu ochiq holatda qoladi';
	@override String get showUnwatchedCount => 'Koʻrilmaganlar sonini koʻrsatish';
	@override String get showUnwatchedCountDescription => 'Seriallar va mavsumlarda koʻrilmagan qismlar sonini koʻrsatish';
	@override String get showEpisodeNumberOnCards => 'Kartochkalarda qism raqamini koʻrsatish';
	@override String get showEpisodeNumberOnCardsDescription => 'Qism kartochkalarida mavsum va qism raqamini koʻrsatish';
	@override String get showSeasonPostersOnTabs => 'Varaqlarda mavsum posterlarini koʻrsatish';
	@override String get showSeasonPostersOnTabsDescription => 'Har bir mavsum posterini oʻz boʻlimida koʻrsatish';
	@override String get tvFullCardLayout => 'Toʻliq TV kartochkalari';
	@override String get tvFullCardLayoutDescription => 'Faqat rasmdan iborat TV kartochkalaridan foydalanish';
	@override String get focusGlow => 'Fokus nuri';
	@override String get focusGlowDescription => 'Tanlangan kartochka atrofida yumshoq nur koʻrsatish';
	@override String get visualEffects => 'Vizual effektlar';
	@override String get visualEffectsAuto => 'Avtomatik';
	@override String get visualEffectsAutoDescription => 'Kuchsiz qurilmalarda effektlarni avtomatik kamaytirish';
	@override String get visualEffectsFull => 'Toʻliq';
	@override String get visualEffectsReduced => 'Kamaytirilgan';
	@override String get visualEffectsReducedDescription => 'Kamroq animatsiya va pastroq sifatli rasmlar';
	@override String get hideSpoilers => 'Koʻrilmagan qismlar uchun spoylerlarni yashirish';
	@override String get hideSpoilersDescription => 'Koʻrilmagan qismlar rasmlari va tavsiflarini xiralashtirish';
	@override String get playerBackend => 'Pleyer infratuzilmasi';
	@override String get exoPlayer => 'ExoPlayer';
	@override String get mpv => 'mpv';
	@override String get hardwareDecoding => 'Apparatli dekodlash';
	@override String get hardwareDecodingDescription => 'Imkon qadar apparatli tezlashtirishdan foydalanish';
	@override String get bufferSize => 'Bufer hajmi';
	@override String bufferSizeMB({required Object size}) => '${size} MB';
	@override String get bufferSizeAuto => 'Avtomatik (Tavsiya etilgan)';
	@override String bufferSizeWarning({required Object heap, required Object size}) => '${heap} MB Xotira mavjud. ${size} MB bufer ijroga taʼsir qilishi mumkin.';
	@override String get defaultQualityTitle => 'Standart sifat';
	@override String get musicQualityTitle => 'Musiqa sifati';
	@override String get subtitleStyling => 'Subtitr sozlamalari';
	@override String get subtitleStylingDescription => 'Subtitrlar koʻrinishini moslashtiring';
	@override String get smallSkipDuration => 'Kichik oʻtkazish vaqti';
	@override String get largeSkipDuration => 'Katta oʻtkazish vaqti';
	@override String get rewindOnResume => 'Davom ettirganda orqaga qaytarish';
	@override String secondsUnit({required Object seconds}) => '${seconds} soniya';
	@override String get defaultSleepTimer => 'Standart uyqu taymeri';
	@override String minutesUnit({required Object minutes}) => '${minutes} daqiqa';
	@override String get rememberTrackSelections => 'Har bir film/serial uchun ovoz/subtitr tanlovini eslab qolish';
	@override String get rememberTrackSelectionsDescription => 'Har bir media uchun ovoz va subtitr sozlamalarini saqlash';
	@override String get followServerTrackSelections => 'Har bir epizod uchun serverdagi tanlovlardan foydalanish';
	@override String get followServerTrackSelectionsDescription => 'Epizod almashganda joriy tanlovni ko\'chirish o\'rniga serverda tanlangan ovoz va subtitrni qo\'llash';
	@override String get showChapterMarkersOnTimeline => 'Vaqt shkalasida boʻlim belgilarini koʻrsatish';
	@override String get showChapterMarkersOnTimelineDescription => 'Vaqt shkalasini boʻlimlarga boʻlish';
	@override String get clickVideoTogglesPlayback => 'Ijro/pauza uchun videoga bosing';
	@override String get clickVideoTogglesPlaybackDescription => 'Boshqaruv tugmalarini koʻrsatish oʻrniga videoni ijro etish yoki pauza qilish';
	@override String get videoPlayerControls => 'Video pleyer boshqaruv elementlari';
	@override String get keyboardShortcuts => 'Klaviatura tugmalari';
	@override String get keyboardShortcutsDescription => 'Klaviatura tugmalarini moslashtiring';
	@override String get videoPlayerNavigation => 'Video pleyer navigatsiyasi';
	@override String get videoPlayerNavigationDescription => 'Pleyerni boshqarish uchun yoʻnalish tugmalaridan foydalaning';
	@override String get debugLogging => 'Nosozliklarni aniqlash jurnali';
	@override String get debugLoggingDescription => 'Muammolarni hal qilish uchun batafsil jurnal yuritishni yoqing';
	@override String get viewLogs => 'Jurnallarni koʻrish';
	@override String get viewLogsDescription => 'Ilova jurnallarini koʻrish';
	@override String get clearImageCache => 'Rasm keshini tozalash';
	@override String get clearImageCacheDescription => 'Keshlangan rasm va eskizlarni tozalaydi. Qayta yuklab olinmaguncha rasmlar sekinroq ochilishi mumkin.';
	@override String get clearImageCacheSuccess => 'Rasm keshi muvaffaqiyatli tozalandi';
	@override String get resetSettings => 'Sozlamalarni qayta oʻrnatish';
	@override String get resetSettingsDescription => 'Standart sozlamalarni tiklash. Bu amalni ortga qaytarib boʻlmaydi.';
	@override String get resetSettingsSuccess => 'Sozlamalar muvaffaqiyatli qayta oʻrnatildi';
	@override String get backup => 'Zahira nusxa';
	@override String get exportSettings => 'Sozlamalarni eksport qilish';
	@override String get exportSettingsDescription => 'Parametrlaringizni faylga saqlang';
	@override String get exportSettingsSuccess => 'Sozlamalar eksport qilindi';
	@override String get importSettings => 'Sozlamalarni import qilish';
	@override String get importSettingsDescription => 'Parametrlarni fayldan tiklang';
	@override String get importSettingsConfirm => 'Bu joriy sozlamalaringiz ustidan yoziladi. Davom etasizmi?';
	@override String get importSettingsSuccess => 'Sozlamalar import qilindi';
	@override String get importSettingsInvalidFile => 'Ushbu fayl toʻgʻri Harbor sozlamalar fayli emas';
	@override String get importSettingsNoUser => 'Sozlamalarni import qilishdan oldin tizimga kiring';
	@override String get shortcutsReset => 'Tugmalar birlashmasi standart holatga qaytarildi';
	@override String get about => 'Dastur haqida';
	@override String get aboutDescription => 'Ilova haqida maʼlumot va litsenziyalar';
	@override String get validationErrorEnterNumber => 'Toʻgʻri raqam kiriting';
	@override String validationErrorDuration({required Object min, required Object max, required Object unit}) => 'Vaqt ${min} va ${max} ${unit} orasida boʻlishi kerak';
	@override String shortcutAlreadyAssigned({required Object action}) => 'Bu birlashma ${action} harakatiga biriktirilgan';
	@override String shortcutUpdated({required Object action}) => '${action} uchun tugmalar birlashmasi yangilandi';
	@override String get saveFailed => 'Oʻzgarishlar saqlanmadi. Qaytadan urinib koʻring.';
	@override String get autoSkip => 'Avtomatik oʻtkazib yuborish';
	@override String get autoSkipIntro => 'Kirish qismini (Intro) avtomatik oʻtkazish';
	@override String get autoSkipIntroDescription => 'Bir necha soniyadan soʻng kirish qismlarini avtomatik oʻtkazish';
	@override String get autoSkipCredits => 'Titrlarni avtomatik oʻtkazish';
	@override String get autoSkipCreditsDescription => 'Titrlarni oʻtkazib yuborish va keyingi qismni ijro etish';
	@override String get forceSkipMarkerFallback => 'Zahira belgilarini majburlash';
	@override String get forceSkipMarkerFallbackDescription => 'Plex belgilari boʻlsa ham boʻlim sarlavhasi shablonlaridan foydalanish';
	@override String get autoSkipDelay => 'Avtomatik oʻtkazish kechikishi';
	@override String autoSkipDelayDescription({required Object seconds}) => 'Avtomatik oʻtkazishdan oldin ${seconds} soniya kutilsin';
	@override String get introPattern => 'Kirish qismi belgisi shabloni';
	@override String get introPatternDescription => 'Boʻlim sarlavhalarida introni topish uchun Regex shabloni';
	@override String get creditsPattern => 'Titr belgisi shabloni';
	@override String get creditsPatternDescription => 'Boʻlim sarlavhalarida titrlarni topish uchun Regex shabloni';
	@override String get invalidRegex => 'Notoʻgʻri muntazam ifoda (Regex)';
	@override String get regex => 'Muntazam ifoda (Regex)';
	@override String get downloads => 'Yuklamalar';
	@override String get downloadLocationDescription => 'Yuklangan fayllar saqlanadigan joyni tanlang';
	@override String get downloadLocationDefault => 'Standart (Ilova xotirasi)';
	@override String get downloadLocationCustom => 'Boshqa joy';
	@override String get selectFolder => 'Jildni tanlash';
	@override String get resetToDefault => 'Standart holatga qaytarish';
	@override String currentPath({required Object path}) => 'Joriy: ${path}';
	@override String get downloadLocationChanged => 'Yuklash joyi oʻzgartirildi';
	@override String get downloadLocationReset => 'Yuklash joyi standart holatga qaytarildi';
	@override String get downloadLocationInvalid => 'Tanlangan jildga yozib boʻlmadi';
	@override String get downloadLocationPickerUnavailable => 'Ushbu qurilmada jildni tanlash imkoniyati yoʻq';
	@override String get downloadOnWifiOnly => 'Faqat Wi-Fi orqali yuklash';
	@override String get downloadOnWifiOnlyDescription => 'Mobil tarmoqdan foydalanilganda yuklashni toʻxtatib turish';
	@override String get autoRemoveWatchedDownloads => 'Koʻrilgan yuklamalarni avtomatik oʻchirish';
	@override String get autoRemoveWatchedDownloadsDescription => 'Koʻrib boʻlingan yuklamalarni avtomatik oʻchirish';
	@override String get cellularDownloadBlocked => 'Mobil tarmoqda yuklash taqiqlangan. Wi-Fi-dan foydalaning.';
	@override String get maxVolume => 'Maksimal ovoz';
	@override String get maxVolumeDescription => 'Pastroq ovozli videolar uchun ovozni 100%-dan oshirishga ruxsat berish';
	@override String maxVolumePercent({required Object percent}) => '%${percent}';
	@override String get services => 'Xizmatlar';
	@override String get servicesDescription => 'Trakt, MyAnimeList, Seerr va boshqalarni ulang';
	@override String get manageLibrariesDescription => 'Kutubxonalarni tartiblash va yashirish';
	@override String get autoPip => 'Avtomatik Rasm ichida rasm (PiP)';
	@override String get autoPipDescription => 'Video ijro etilayotganda ilovadan chiqilganda avto-PiP rejimiga oʻtish';
	@override String get matchContentFrameRate => 'Kadrlar chastotasini moslashtirish';
	@override String get matchContentFrameRateDescription => 'Ekran chastotasini video kontentiga moslashtirish';
	@override String get matchRefreshRate => 'Yangilanish chastotasini moslashtirish';
	@override String get matchRefreshRateDescription => 'Toʻliq ekranda ekran chastotasini moslashtirish';
	@override String get matchDynamicRange => 'Dinamik diapazonni moslashtirish';
	@override String get matchDynamicRangeDescription => 'HDR kontent uchun HDR-ni yoqish, soʻng SDR-ga qaytish';
	@override String get displaySwitchDelay => 'Ekranni almashtirish kechikishi';
	@override String get tunneledPlayback => 'Tunnelli ijro';
	@override String get tunneledPlaybackDescription => 'Video tunnellashdan foydalanish. HDR ijrosida ekran qora boʻlsa, oʻchiring.';
	@override String get audioPassthrough => 'Ovozni toʻgʻridan-toʻgʻri oʻtkazish (Passthrough)';
	@override String get audioPassthroughDescription => 'Dolby/DTS ovozini qayta kodlamasdan resiver yoki televizoringizga yuboradi va atroflicha ovozni saqlaydi. Ovoz boʻlmasa, oʻchiring.';
	@override String get audioPassthroughDescriptionAppleTv => 'Dolby Digital Plus uchun Apple dekoderidan foydalanish.';
	@override String get audioDownmix => 'Stereoga oʻtkazish (Downmix)';
	@override String get audioDownmixDescription => 'Koʻp kanalli ovozni stereo dinamiklar uchun ikki kanalga tushirish';
	@override String get downmixCenterBoost => 'Markaziy kanalni kuchaytirish';
	@override String downmixCenterBoostValue({required Object db}) => '${db} dB';
	@override String get downmixCenterBoostLabel => 'Kuchaytirish (dB)';
	@override String get downmixCenterBoostShort => 'dB';
	@override String get audioDownmixNormalize => 'Oʻtkazishda ovozni meʼyorlashtirish';
	@override String get audioDownmixNormalizeDescription => 'Ovoz buzilishining oldini olish uchun darajani tushirish.';
	@override String get atmosDiagnostics => 'Atmos chiqishini tekshirish';
	@override String get atmosDiagnosticsDescription => 'Dolby Atmos chiqishini tekshirish';
	@override String get atmosTestHlsAtmos => 'Apple Atmos oqimi';
	@override String get atmosTestHlsAtmosDescription => 'Toʻgʻri ishlaydigan Dolby Atmos oqimi.';
	@override String get atmosTestHlsControl => 'Apple atroflicha ovoz oqimi';
	@override String get atmosTestHlsControlDescription => 'Atmos boʻlmagan nazorat oqimi.';
	@override String get atmosTestRawStream => 'Ishlov berilmagan EAC3 oqimi';
	@override String get atmosTestRawStreamDescription => 'Test faylini ichki Atmos sifatida uzatish.';
	@override String get atmosTestRawFile => 'Ishlov berilmagan EAC3 fayli';
	@override String get atmosTestRawFileDescription => 'Test faylini ijro etish.';
	@override String get atmosTestAsbarNative => 'Sempl-bufer renderer (nativ)';
	@override String get atmosTestAsbarNativeDescription => 'Faylning oʻzgartirilmagan siqilgan audiosini toʻgʻridan-toʻgʻri tizim rendereriga uzatadi. Test fayli URL-manzili kerak.';
	@override String get atmosTestAsbarGenerated => 'Sempl-bufer renderer (qayta qurilgan)';
	@override String get atmosTestAsbarGeneratedDescription => 'Xuddi shu, lekin audio tavsifi ijro paytida qanday qurilsa, shunday qayta quriladi. Test fayli URL-manzili kerak.';
	@override String get atmosTestSessionMode => 'Film ijrosi seansi rejimidan foydalanish';
	@override String get atmosTestSessionModeDescription => 'Oʻchirilgan holatda Dolby hujjatlashtirgan rejim qoʻllanadi. Yoqilgan holatda avval ishlatilgan rejim qoʻllanadi.';
	@override String get atmosTestShowRoutePicker => 'AirPlay chiqishini tanlash';
	@override String get atmosTestHideRoutePicker => 'AirPlay chiqishi tanlagichini yashirish';
	@override String get atmosTestRoutePickerDescription => 'Testni AirPlay qabul qilgichiga yuboradi. Aniqlangan audio rejimi haqida faqat AirPlay xabar beradi.';
	@override String get atmosTestStop => 'Testni toʻxtatish';
	@override String get atmosTestUrl => 'Test fayli URL-manzili';
	@override String get atmosTestUrlDescription => 'Ishlov berilmagan .ec3 faylining HTTP URL-manzili';
	@override String get atmosTestUrlMissing => 'Avval test fayli URL-manzilini oʻrnating';
	@override String get atmosTestStatus => 'Holati';
	@override String get dvConversionMode => 'Dolby Vision oʻtkazmasi';
	@override String get dvConversionModeDescription => 'ExoPlayer-ning Dolby Vision Profile 7 fayllarini qayta ishlash rejimini tanlang.';
	@override String get dvConversionAuto => 'Avtomatik';
	@override String get dvConversionNative => 'Ichki / Oʻchirilgan';
	@override String get dvConversionDv81 => 'P7 → P8.1';
	@override String get dvConversionHevcStrip => 'P7 → HEVC';
	@override String get dvConversionAutoDescription => 'Qurilma imkoniyatlaridan foydalanish';
	@override String get dvConversionNativeDescription => 'Ichki DV7 rejimini majburlash';
	@override String get dvConversionDv81Description => 'Dolby Vision profile 8.1 formatiga oʻtkazish';
	@override String get dvConversionHevcStripDescription => 'Dolby Vision qatlamlarini olib tashlash va HEVC sifatida koʻrsatish';
	@override String get requireProfileSelectionOnOpen => 'Ochilganda profilni soʻrash';
	@override String get requireProfileSelectionOnOpenDescription => 'Ilova ochilgan har safar profilni tanlashni koʻrsatish';
	@override String get forceTvMode => 'TV rejimini majburlash';
	@override String get forceTvModeDescription => 'TV interfeysini majburiy yoqish.';
	@override String get autoHidePerformanceOverlay => 'Unumdorlik panelini avto-yashirish';
	@override String get autoHidePerformanceOverlayDescription => 'Unumdorlik panelini boshqaruv tugmalari bilan birga yashirish';
	@override String get showNavBarLabels => 'Navigatsiya paneli matnlarini koʻrsatish';
	@override String get showNavBarLabelsDescription => 'Navigatsiya belgilarining ostida matnni koʻrsatish';
	@override String get startupSection => 'Boshlangʻich boʻlim';
	@override String get display => 'Displey';
	@override String get homeScreen => 'Bosh ekran';
	@override String get navigation => 'Navigatsiya';
	@override String get content => 'Kontent';
	@override String get player => 'Pleyer';
	@override String get subtitlesAndConfig => 'Subtitrlar va konfiguratsiya';
	@override String get seekAndTiming => 'Oʻtkazish va vaqt sozlamalari';
	@override String get behavior => 'Xatti-harakat';
}

// Path: search
class _Translations$search$uz extends Translations$search$en {
	_Translations$search$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get hint => 'Filmlar, seriallar, musiqa qidirish...';
	@override String get tryDifferentTerm => 'Boshqa qidiruv soʻzini kiriting';
	@override String get searchYourMedia => 'Medialaringizdan qidiring';
	@override String get enterTitleActorOrKeyword => 'Nomini, aktyorni yoki kalit soʻzni kiriting';
}

// Path: hotkeys
class _Translations$hotkeys$uz extends Translations$hotkeys$en {
	_Translations$hotkeys$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String setShortcutFor({required Object actionName}) => '${actionName} uchun tugmalar birlashmasini oʻrnatish';
	@override String get clearShortcut => 'Birlashmani tozalash';
	@override String get noShortcutSet => 'Tugmalar birlashmasi oʻrnatilmagan';
	@override String get currentShortcut => 'Joriy birlashma:';
	@override String get pressToRecord => 'Birlashmani yozib olish uchun bosing';
	@override String get recordingShortcut => 'Endi tugmalarni bosing';
	@override late final _Translations$hotkeys$actions$uz actions = _Translations$hotkeys$actions$uz._(_root);
}

// Path: fileInfo
class _Translations$fileInfo$uz extends Translations$fileInfo$en {
	_Translations$fileInfo$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fayl haqida maʼlumot';
	@override String get video => 'Video';
	@override String get audio => 'Audio';
	@override String get subtitles => 'Subtitrlar';
	@override String get file => 'Fayl';
	@override String get codec => 'Kodek';
	@override String get resolution => 'Oʻlchamlari (Resolution)';
	@override String get bitrate => 'Bitreyt (Bitrate)';
	@override String get frameRate => 'Kadrlar chastotasi';
	@override String get aspectRatio => 'Tomonlar nisbati';
	@override String get profile => 'Profil';
	@override String get bitDepth => 'Bit chuqurligi';
	@override String get colorSpace => 'Rang makoni';
	@override String get colorRange => 'Rang diapazoni';
	@override String get colorPrimaries => 'Asosiy ranglar';
	@override String get chromaSubsampling => 'Rangli subdiskretlash';
	@override String get channels => 'Kanallar';
	@override String get overallBitrate => 'Umumiy bitreyt';
	@override String get path => 'Yoʻl';
	@override String get size => 'Hajmi';
	@override String get container => 'Konteyner';
	@override String get duration => 'Davomiyligi';
	@override String get optimizedForStreaming => 'Oqimli uzatish uchun optimallashtirilgan';
	@override String get has64bitOffsets => '64-bitli siljishlar';
}

// Path: mediaMenu
class _Translations$mediaMenu$uz extends Translations$mediaMenu$en {
	_Translations$mediaMenu$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get markAsWatched => 'Koʻrilgan deb belgilash';
	@override String get markAsUnwatched => 'Koʻrilmagan deb belgilash';
	@override String get viewDetails => 'Batafsil koʻrish';
	@override String get goToSeries => 'Serialga oʻtish';
	@override String get shufflePlay => 'Aralashtirib ijro etish';
	@override String get shuffleNotAvailableOffline => 'Aralashtirib ijro etish oflayn rejimda mavjud emas';
	@override String get fileInfo => 'Fayl haqida maʼlumot';
	@override String get deleteFromServer => 'Serverdan oʻchirish';
	@override String get confirmDelete => 'Ushbu media va fayllar serverdan oʻchirilsinmi?';
	@override String get deleteMultipleWarning => 'Bu barcha qismlar va fayllarga taʼsir qiladi.';
	@override String get mediaDeletedSuccessfully => 'Media elementi muvaffaqiyatli oʻchirildi';
	@override String get mediaFailedToDelete => 'Media elementini oʻchirib boʻlmadi';
	@override String get rate => 'Baho berish';
	@override String get playFromBeginning => 'Boshidan ijro etish';
	@override String get playVersion => 'Versiyani ijro etish...';
}

// Path: rateSheet
class _Translations$rateSheet$uz extends Translations$rateSheet$en {
	_Translations$rateSheet$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get server => 'Server';
	@override String get favorite => 'Tanlangan';
	@override String get favorited => 'Tanlanganlarga qoʻshildi';
	@override String get saved => 'Saqlandi';
	@override String get notAvailable => 'Moslik topilmadi';
	@override String get noConnectedServices => 'Baho berish uchun Sozlamalardan xizmatni ulang.';
}

// Path: accessibility
class _Translations$accessibility$uz extends Translations$accessibility$en {
	_Translations$accessibility$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String mediaCardMovie({required Object title}) => '${title}, film';
	@override String mediaCardShow({required Object title}) => '${title}, TV shou';
	@override String mediaCardEpisode({required Object title, required Object episodeInfo}) => '${title}, ${episodeInfo}';
	@override String mediaCardSeason({required Object title, required Object seasonInfo}) => '${title}, ${seasonInfo}';
	@override String get mediaCardWatched => 'koʻrilgan';
	@override String mediaCardPartiallyWatched({required Object percent}) => '%${percent} koʻrilgan';
	@override String get mediaCardUnwatched => 'koʻrilmagan';
	@override String get tapToPlay => 'Ijro etish uchun bosing';
	@override String get decrease => 'Kamaytirish';
	@override String get increase => 'Oshirish';
	@override String decreaseValue({required Object label}) => '${label} qiymatini kamaytirish';
	@override String increaseValue({required Object label}) => '${label} qiymatini oshirish';
	@override String get hue => 'Rang jilosi';
	@override String get saturation => 'Toʻyinganlik';
	@override String get brightness => 'Yorqinlik';
	@override String get hexColor => 'Hex rangi';
	@override String get expandText => 'Matnni yoyish';
	@override String get collapseText => 'Matnni yigʻish';
	@override String get alphabetNavigation => 'Alifboli navigatsiya';
	@override String get alphabetScrollHint => 'Harflar boʻyicha oʻtish uchun yuqoriga yoki pastga suring';
	@override String rowColumnPosition({required Object row, required Object rowCount, required Object column, required Object columnCount}) => 'Qator ${row} / ${rowCount}, ustun ${column} / ${columnCount}';
	@override String rowPosition({required Object row, required Object rowCount}) => 'Qator ${row} / ${rowCount}';
}

// Path: tooltips
class _Translations$tooltips$uz extends Translations$tooltips$en {
	_Translations$tooltips$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get shufflePlay => 'Aralashtirib ijro etish';
	@override String get playTrailer => 'Treylerni koʻrish';
	@override String get markAsWatched => 'Koʻrilgan deb belgilash';
	@override String get markAsUnwatched => 'Koʻrilmagan deb belgilash';
}

// Path: audioTracks
class _Translations$audioTracks$uz extends Translations$audioTracks$en {
	_Translations$audioTracks$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String track({required Object n}) => 'Audio yoʻlak ${n}';
}

// Path: videoControls
class _Translations$videoControls$uz extends Translations$videoControls$en {
	_Translations$videoControls$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get audioLabel => 'Ovoz';
	@override String get subtitlesLabel => 'Subtitr';
	@override String get resetToZero => '0ms-ga qaytarish';
	@override String addTime({required Object amount, required Object unit}) => '+${amount}${unit}';
	@override String minusTime({required Object amount, required Object unit}) => '-${amount}${unit}';
	@override String playsLater({required Object label}) => '${label} keyinroq ijro etiladi';
	@override String playsEarlier({required Object label}) => '${label} ilgariroq ijro etiladi';
	@override String get noOffset => 'Siljishsiz';
	@override String get letterbox => 'Keng ekran (Letterbox)';
	@override String get fillScreen => 'Ekranni toʻldirish';
	@override String get stretch => 'Choʻzish';
	@override String get lockRotation => 'Aylanishni qulflash';
	@override String get unlockRotation => 'Aylanish qulfini ochish';
	@override String get timerActive => 'Taymer faol';
	@override String playbackWillPauseIn({required Object duration}) => 'Ijro ${duration}-dan keyin toʻxtatiladi';
	@override String get sleepTimerEndOfVideo => 'Joriy videoning oxiri';
	@override String get sleepTimerStopAtHeader => 'Toʻxtash vaqti';
	@override String get sleepTimerDurationHeader => 'Taymer';
	@override String get playbackWillPauseAtEnd => 'Ijro ushbu videoning oxirida toʻxtatiladi';
	@override String get stillWatching => 'Hali ham tomosha qilyapsizmi?';
	@override String pausingIn({required Object seconds}) => '${seconds}son-dan keyin toʻxtatiladi';
	@override String get continueWatching => 'Davom ettirish';
	@override String get autoPlayNext => 'Keyingisini avtomatik ijro etish';
	@override String get playNext => 'Keyingisini ijro etish';
	@override String get playButton => 'Ijro etish';
	@override String get pauseButton => 'Pauza';
	@override String get showPlaybackControls => 'Boshqaruv tugmalarini koʻrsatish';
	@override String get hidePlaybackControls => 'Boshqaruv tugmalarini yashirish';
	@override String seekBackwardButton({required Object seconds}) => '${seconds} soniya orqaga oʻtkazish';
	@override String seekForwardButton({required Object seconds}) => '${seconds} soniya oldinga oʻtkazish';
	@override String get previousButton => 'Oldingi qism';
	@override String get nextButton => 'Keyingi qism';
	@override String get previousChapterButton => 'Oldingi boʻlimcha';
	@override String get nextChapterButton => 'Keyingi boʻlimcha';
	@override String get muteButton => 'Ovozni oʻchirish';
	@override String get unmuteButton => 'Ovozni yoqish';
	@override String get settingsButton => 'Ijro sozlamalari';
	@override String get tracksButton => 'Ovoz va subtitrlar';
	@override String get chaptersButton => 'Boʻlimlar';
	@override String get versionQualityButton => 'Versiya va sifat';
	@override String get versionColumnHeader => 'Versiya';
	@override String get qualityColumnHeader => 'Sifat';
	@override String get qualityOriginal => 'Asl nusxa';
	@override String qualityPresetLabel({required Object resolution, required Object bitrate}) => '${resolution}p ${bitrate} Mbps';
	@override String get transcodeUnavailableFallback => 'Qayta kodlash mavjud emas — asl sifatda ijro etiladi';
	@override String get subtitleUnavailableFallback => 'Tanlangan subtitr yuklanmadi';
	@override String get pipButton => 'Rasm ichida rasm rejimi';
	@override String get aspectRatioButton => 'Tomonlar nisbati';
	@override String get ambientLighting => 'Atrof-muhit yoritilishi';
	@override String get rotationLockButton => 'Aylanish qulfi';
	@override String get lockScreen => 'Ekranni qulflash';
	@override String get screenLockButton => 'Ekran qulfi';
	@override String get longPressToUnlock => 'Qulfdan chiqarish uchun bosib turing';
	@override String get timelineSlider => 'Video vaqt shkalasi';
	@override String get volumeSlider => 'Ovoz balandligi';
	@override String endsAt({required Object time}) => 'Tugash vaqti: ${time}';
	@override String get pipActive => 'Rasm ichida rasm rejimida ijro etilmoqda';
	@override String get pipFailed => 'PiP rejimini ishga tushirishda xatolik';
	@override String get screenshotSaved => 'Ekran tasviri saqlandi';
	@override String zoomPercent({required Object percent}) => 'Masshtab %${percent}';
	@override late final _Translations$videoControls$pipErrors$uz pipErrors = _Translations$videoControls$pipErrors$uz._(_root);
	@override String get chapters => 'Boʻlimlar';
	@override String get noChaptersAvailable => 'Boʻlimlar mavjud emas';
	@override String get queue => 'Navbat';
	@override String get noQueueItems => 'Navbatda elementlar yoʻq';
}

// Path: messages
class _Translations$messages$uz extends Translations$messages$en {
	_Translations$messages$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get markedAsWatched => 'Koʻrilgan deb belgilandi';
	@override String get markedAsUnwatched => 'Koʻrilmagan deb belgilandi';
	@override String get markedAsWatchedOffline => 'Koʻrilgan deb belgilandi (tarmoqqa ulanganda sinxronlanadi)';
	@override String get markedAsUnwatchedOffline => 'Koʻrilmagan deb belgilandi (tarmoqqa ulanganda sinxronlanadi)';
	@override String autoRemovedWatchedDownload({required Object title}) => 'Avtomatik oʻchirildi: ${title}';
	@override String autoRemovedWatchedDownloads({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uz'))(n,
		one: 'Koʻrilgan ${n} yuklama avtomatik oʻchirildi',
		other: 'Koʻrilgan ${n} yuklama avtomatik oʻchirildi',
	);
	@override String errorLoading({required Object error}) => 'Xatolik: ${error}';
	@override String get searchPartialResults => 'Baʼzi media serverlarda qidiruv amalga oshmadi. Mavjud natijalar koʻrsatilmoqda.';
	@override String get streamInterrupted => 'Oqim uzildi. Qayta urinish uchun ijro tugmasini bosing.';
	@override String get fileInfoNotAvailable => 'Fayl haqida maʼlumot mavjud emas';
	@override String get playbackAuthenticationRequired => 'Ushbu elementni ijro etish uchun serverga qaytadan kiring.';
	@override String get playbackServerUnavailable => 'Media serveri mavjud emas. Keyinroq qaytadan urinib koʻring.';
	@override String get playbackDataInvalid => 'Server notoʻgʻri ijro maʼlumotlarini qaytardi.';
	@override String get playbackCancelled => 'Ijro bekor qilindi.';
	@override String get playbackFailed => 'Ijroni ishga tushirishda xatolik.';
	@override String errorLoadingFileInfo({required Object error}) => 'Fayl maʼlumotlarini yuklashda xatolik: ${error}';
	@override String get errorLoadingSeries => 'Serialni yuklashda xatolik';
	@override String get musicNotSupported => 'Musiqa ijrosi hali qoʻllab-quvvatlanmaydi';
	@override String get noDescriptionAvailable => 'Tavsif mavjud emas';
	@override String get noProfilesAvailable => 'Profillar yoʻq';
	@override String get contactAdminForProfiles => 'Profil qoʻshish uchun administratorga murojaat qiling';
	@override String get unableToDetermineLibrarySection => 'Kutubxona boʻlimini aniqlab boʻlmadi';
	@override String get logsCleared => 'Jurnallar tozalandi';
	@override String get logsCopied => 'Jurnallar nusxalandi';
	@override String get noLogsAvailable => 'Jurnallar yoʻq';
	@override String metadataRefreshing({required Object title}) => '"${title}" uchun metamaʼlumotlar yangilanmoqda...';
	@override String metadataRefreshStarted({required Object title}) => '"${title}" uchun metamaʼlumotlarni yangilash boshlandi';
	@override String metadataRefreshFailed({required Object error}) => 'Metamaʼlumotlarni yangilab boʻlmadi: ${error}';
	@override String get logoutConfirm => 'Haqiqatan ham chiqmoqchimisiz?';
	@override String get noSeasonsFound => 'Mavsumlar topilmadi';
	@override String get seasonsLoadFailed => 'Mavsumlarni yuklab boʻlmadi';
	@override String get noEpisodesFound => 'Birinchi mavsumda qismlar topilmadi';
	@override String get noEpisodesFoundGeneral => 'Qismlar topilmadi';
	@override String get episodesLoadFailed => 'Qismlarni yuklab boʻlmadi';
	@override String get noResultsFound => 'Natijalar topilmadi';
	@override String sleepTimerSet({required Object label}) => 'Uyqu taymeri ${label} vaqtiga oʻrnatildi';
	@override String get noItemsAvailable => 'Elementlar yoʻq';
	@override String get failedToCreatePlayQueueNoItems => 'Ijro navbatini yaratib boʻlmadi — elementlar yoʻq';
	@override String failedPlayback({required Object action, required Object error}) => '${action} muvaffaqiyatsiz tugadi: ${error}';
	@override String get switchingToCompatiblePlayer => 'Mos keluvchi pleyerga oʻtilmoqda...';
	@override String get serverLimitTitle => 'Ijro etishda xatolik';
	@override String get serverLimitBody => 'Server xatoligi (HTTP 500). Cheklov ushbu seansni rad etdi.';
}

// Path: subtitlingStyling
class _Translations$subtitlingStyling$uz extends Translations$subtitlingStyling$en {
	_Translations$subtitlingStyling$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get text => 'Matn';
	@override String get border => 'Hoshiya';
	@override String get background => 'Fon';
	@override String get fontSize => 'Shrift oʻlchami';
	@override String get textColor => 'Matn rangi';
	@override String get borderSize => 'Hoshiya oʻlchami';
	@override String get borderColor => 'Hoshiya rangi';
	@override String get backgroundOpacity => 'Fon shaffofligi';
	@override String get backgroundColor => 'Fon rangi';
	@override String get position => 'Joylashuvi';
	@override String get assOverride => 'ASS qayta aniqlash';
	@override String get overrideScale => 'Masshtablash';
	@override String get overrideForce => 'Majburlash';
	@override String get overrideStrip => 'Formatlashni olib tashlash';
	@override String get positionTop => 'Yuqori';
	@override String get positionBottom => 'Pastki';
	@override String get bold => 'Qalin';
	@override String get italic => 'Qiya';
	@override String get renderResolution => 'Renderlash oʻlchamlari';
	@override String get renderResolutionScreen => 'Ekran oʻlchamlari';
	@override String get renderResolutionVideo => 'Video oʻlchamlari';
}

// Path: mpvConfig
class _Translations$mpvConfig$uz extends Translations$mpvConfig$en {
	_Translations$mpvConfig$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'mpv.conf';
	@override String get description => 'Kengaytirilgan video pleyer sozlamalari';
	@override String get presets => 'Tayyor sozlamalar';
	@override String get noPresets => 'Saqlangan sozlamalar yoʻq';
	@override String get saveAsPreset => 'Sozlama sifatida saqlash...';
	@override String get presetName => 'Sozlama nomi';
	@override String get presetNameHint => 'Ushbu sozlama uchun nom kiriting';
	@override String get loadPreset => 'Yuklash';
	@override String get deletePreset => 'Oʻchirish';
	@override String get presetSaved => 'Sozlama saqlandi';
	@override String get presetLoaded => 'Sozlama yuklandi';
	@override String get presetDeleted => 'Sozlama oʻchirildi';
	@override String get confirmDeletePreset => 'Ushbu sozlamani oʻchirishga ishonchingiz komilmi?';
	@override String get configPlaceholder => 'gpu-api=vulkan\nhwdec=auto\n# izoh';
}

// Path: dialog
class _Translations$dialog$uz extends Translations$dialog$en {
	_Translations$dialog$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get confirmAction => 'Harakatni tasdiqlash';
}

// Path: profiles
class _Translations$profiles$uz extends Translations$profiles$en {
	_Translations$profiles$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get addLocalProfile => 'Harbor profilini qoʻshish';
	@override String get switchingProfile => 'Profil almashtirilmoqda…';
	@override String get deleteThisProfileTitle => 'Ushbu profil oʻchirilsinmi?';
	@override String deleteThisProfileMessage({required Object displayName}) => '${displayName} oʻchiriladi. Ulanishlarga taʼsir qilmaydi.';
	@override String get active => 'Faol';
	@override String get manage => 'Boshqarish';
	@override String get delete => 'Oʻchirish';
	@override String get sectionTitle => 'Profillar';
	@override String get summarySingle => 'Boshqariladigan foydalanuvchilarni birlashtirish uchun profillar qoʻshing';
	@override String summaryMultipleWithActive({required Object count, required Object activeName}) => '${count} profil · faol: ${activeName}';
	@override String summaryMultiple({required Object count}) => '${count} profil';
	@override String get removeConnectionTitle => 'Ulanish oʻchirilsinmi?';
	@override String removeConnectionMessage({required Object displayName, required Object connectionLabel}) => '${displayName} foydalanuvchisining ${connectionLabel} kirish huquqi oʻchiriladi.';
	@override String get deleteProfileTitle => 'Profil oʻchirilsinmi?';
	@override String deleteProfileMessage({required Object displayName}) => '${displayName} va uning ulanishlari oʻchiriladi.';
	@override String get profileNameLabel => 'Profil nomi';
	@override String get pinProtectionLabel => 'PIN himoyasi';
	@override String get setPin => 'PIN oʻrnatish';
	@override String get setPinTitle => 'PIN oʻrnatish';
	@override String get confirmPinTitle => 'PIN kodni tasdiqlash';
	@override String get pinSet => 'PIN oʻrnatildi';
	@override String get changePin => 'Oʻzgartirish';
	@override String get removePin => 'Oʻchirish';
	@override String get connectionsLabel => 'Ulanishlar';
	@override String get add => 'Qoʻshish';
	@override String get deleteProfileButton => 'Profilni oʻchirish';
	@override String get noConnectionsHint => 'Ulanishlar yoʻq — ushbu profildan foydalanish uchun ulanish qoʻshing.';
	@override String get noConnections => 'Ulanishlar yoʻq';
	@override String get connectionDefault => 'Standart';
	@override String get makeDefault => 'Standart qilish';
	@override String get removeConnection => 'Oʻchirish';
	@override String get profileRenamed => 'Profil nomi oʻzgartirildi.';
	@override String borrowAddTo({required Object displayName}) => '${displayName} profiliga qoʻshish';
	@override String get borrowExplain => 'Boshqa profilning ulanishidan foydalaning.';
	@override String get borrowEmpty => 'Hali foydalanadigan hech narsa yoʻq.';
	@override String get borrowEmptySubtitle => 'Avval boshqa profilga Plex yoki Jellyfin ulang.';
	@override String get borrowLoadFailed => 'Mavjud ulanishlarni yuklab boʻlmadi.';
	@override String borrowFromProfile({required Object displayName}) => '${displayName} profilidan';
	@override String get borrowConnectionBorrowed => 'Ulanishdan foydalanildi.';
	@override String get borrowFailed => 'Ulanishdan foydalanib boʻlmadi.';
	@override String get incorrectPin => 'Notoʻgʻri PIN kod.';
	@override String get incorrectPinTryAgain => 'Notoʻgʻri PIN kod. Qaytadan urinib koʻring.';
	@override String get newProfile => 'Yangi profil';
	@override String get profileNameHint => 'masalan, Mehmonlar, Bolalar';
	@override String get pinProtectionOptional => 'PIN himoyasi (ixtiyoriy)';
	@override String get pinExplain => 'Profillar orasida oʻtish uchun 4 xonali PIN kod talab qilinadi.';
	@override String get continueButton => 'Davom ettirish';
	@override String get pinsDontMatch => 'PIN kodlar mos kelmadi';
}

// Path: connections
class _Translations$connections$uz extends Translations$connections$en {
	_Translations$connections$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get sectionTitle => 'Ulanishlar';
	@override String get addConnection => 'Ulanish qoʻshish';
	@override String get addConnectionSubtitleNoProfile => 'Plex orqali kiring yoki Jellyfin serveriga ulaning';
	@override String addConnectionSubtitleScoped({required Object displayName}) => '${displayName} profiliga qoʻshish';
	@override String sessionExpiredOne({required Object name}) => '${name} uchun seans vaqti tugadi';
	@override String sessionExpiredMany({required Object count}) => '${count} server uchun seans vaqti tugadi';
	@override String get signInAgain => 'Qaytadan kirish';
	@override String get editJellyfinTitle => 'Jellyfin ulanishini tahrirlash';
	@override String editJellyfinIntro({required Object serverName}) => '${serverName} uchun URL manzilini qoʻshing yoki oʻchiring.';
}

// Path: discover
class _Translations$discover$uz extends Translations$discover$en {
	_Translations$discover$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kashf qilish';
	@override String get noContentAvailable => 'Kontent mavjud emas';
	@override String get addMediaToLibraries => 'Kutubxonalaringizga media qoʻshing';
	@override String get continueWatching => 'Tomoshani davom ettirish';
	@override String continueWatchingIn({required Object library}) => '${library} ichida tomoshani davom ettirish';
	@override String nextUpIn({required Object library}) => '${library} ichida navbatda';
	@override String recentlyAddedIn({required Object library}) => '${library} ichida yaqinda qoʻshilganlar';
	@override String latestAlbumsIn({required Object library}) => '${library} ichida soʻnggi albomlar';
	@override String recentlyPlayedIn({required Object library}) => '${library} ichida yaqinda eshitilganlar';
	@override String mostPlayedIn({required Object library}) => '${library} ichida eng koʻp eshitilganlar';
	@override String playEpisode({required Object season, required Object episode}) => 'M${season}Q${episode}';
	@override String get cast => 'Aktyorlar';
	@override String get extras => 'Treylerlar va qoʻshimchalar';
	@override String get studio => 'Studiya';
	@override String get director => 'Rejissyor';
	@override String get directors => 'Rejissyorlar';
	@override String get movie => 'Film';
	@override String get tvShow => 'TV Shou';
	@override String minutesLeft({required Object minutes}) => '${minutes} daq qoldi';
	@override String get moreLikeThis => 'Oʻxshashlar';
}

// Path: errors
class _Translations$errors$uz extends Translations$errors$en {
	_Translations$errors$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String searchFailed({required Object error}) => 'Qidiruv xatoligi: ${error}';
	@override String get searchUnavailable => 'Qidiruv hech bir media serverga ulana olmadi.';
	@override String connectionTimeout({required Object context}) => '${context} yuklanish vaqti tugadi';
	@override String get connectionFailed => 'Media serveriga ulanib boʻlmadi';
	@override String unableToLoad({required Object context}) => '${context} yuklab boʻlmadi.';
	@override String get noClientAvailable => 'Mavjud mijoz yoʻq';
	@override String failedToSwitchProfile({required Object displayName}) => '${displayName} profiliga oʻtib boʻlmadi';
	@override String failedToDeleteProfile({required Object displayName}) => '${displayName} profilini oʻchirib boʻlmadi';
	@override String get failedToRate => 'Reytingni yangilab boʻlmadi';
}

// Path: libraries
class _Translations$libraries$uz extends Translations$libraries$en {
	_Translations$libraries$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kutubxonalar';
	@override String get fallbackTitle => 'Kutubxona';
	@override String get refreshMetadata => 'Metamaʼlumotlarni yangilash';
	@override String get noLibrariesFound => 'Kutubxonalar topilmadi';
	@override String get allLibrariesHidden => 'Barcha kutubxonalar yashirilgan';
	@override String hiddenLibrariesCount({required Object count}) => 'Yashirin kutubxonalar (${count})';
	@override String get thisLibraryIsEmpty => 'Ushbu kutubxona boʻsh';
	@override String get noItemsMatchFilters => 'Filtrlarga mos keladigan elementlar topilmadi';
	@override String get resetFilters => 'Filtrlarni qayta oʻrnatish';
	@override String get all => 'Barchasi';
	@override String get clearAll => 'Barchasini tozalash';
	@override String refreshMetadataConfirm({required Object title}) => '"${title}" metamaʼlumotlarini yangilaysizmi?';
	@override String get manageLibraries => 'Kutubxonalarni boshqarish';
	@override String get sort => 'Saralash';
	@override String get sortBy => 'Saralash mezonlari';
	@override String get filters => 'Filtrlar';
	@override String get confirmActionMessage => 'Ushbu harakatni bajarmoqchimisiz?';
	@override String get showLibrary => 'Kutubxonani koʻrsatish';
	@override String get hideLibrary => 'Kutubxonani yashirish';
	@override String get libraryOptions => 'Kutubxona parametrlari';
	@override String get content => 'kutubxona tarkibi';
	@override String get selectLibrary => 'Kutubxonani tanlash';
	@override String filtersWithCount({required Object count}) => 'Filtrlar (${count})';
	@override String get noCollections => 'Ushbu kutubxonada toʻplamlar yoʻq';
	@override String get noFoldersFound => 'Jildlar topilmadi';
	@override String get folders => 'jildlar';
	@override late final _Translations$libraries$groupings$uz groupings = _Translations$libraries$groupings$uz._(_root);
	@override late final _Translations$libraries$filterCategories$uz filterCategories = _Translations$libraries$filterCategories$uz._(_root);
	@override late final _Translations$libraries$sortLabels$uz sortLabels = _Translations$libraries$sortLabels$uz._(_root);
}

// Path: about
class _Translations$about$uz extends Translations$about$en {
	_Translations$about$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Dastur haqida';
	@override String get openSourceLicenses => 'Ochiq kodli litsenziyalar';
	@override String versionLabel({required Object version}) => 'Versiya ${version}';
	@override String get appDescription => 'Flutter asosidagi qulay Plex va Jellyfin mijozi';
	@override String get viewLicensesDescription => 'Uchinchi tomon kutubxonalarining litsenziyalarini koʻrish';
}

// Path: hubDetail
class _Translations$hubDetail$uz extends Translations$hubDetail$en {
	_Translations$hubDetail$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nomi';
	@override String get releaseYear => 'Chiqqan yili';
	@override String get dateAdded => 'Qoʻshilgan sanasi';
	@override String get rating => 'Reyting';
	@override String get noItemsFound => 'Elementlar topilmadi';
}

// Path: logs
class _Translations$logs$uz extends Translations$logs$en {
	_Translations$logs$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get clearLogs => 'Jurnallarni tozalash';
	@override String get copyLogs => 'Jurnallarni nusxalash';
}

// Path: licenses
class _Translations$licenses$uz extends Translations$licenses$en {
	_Translations$licenses$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get relatedPackages => 'Bogʻliq paketlar';
	@override String get license => 'Litsenziya';
	@override String licenseNumber({required Object number}) => 'Litsenziya ${number}';
	@override String licensesCount({required Object count}) => '${count} litsenziya';
}

// Path: navigation
class _Translations$navigation$uz extends Translations$navigation$en {
	_Translations$navigation$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get libraries => 'Kutubxonalar';
	@override String get downloads => 'Yuklamalar';
	@override String get explore => 'Kashf qilish';
}

// Path: explore
class _Translations$explore$uz extends Translations$explore$en {
	_Translations$explore$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kashf qilish';
	@override String get selectSource => 'Manbani tanlang';
	@override late final _Translations$explore$rows$uz rows = _Translations$explore$rows$uz._(_root);
	@override late final _Translations$explore$status$uz status = _Translations$explore$status$uz._(_root);
	@override String episodeCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uz'))(n,
		one: '${n} qism',
		other: '${n} qism',
	);
	@override String get cast => 'Aktyorlar';
	@override String get characters => 'Qahramonlar';
	@override String get addToWatchlist => 'Tomosha roʻyxatiga qoʻshish';
	@override String get removeFromWatchlist => 'Tomosha roʻyxatidan oʻchirish';
	@override String get watchlistUpdateFailed => 'Tomosha roʻyxatini yangilab boʻlmadi';
	@override String get notInLibrary => 'Kutubxonangizda yoʻq';
	@override String get inTheseLibraries => 'Ushbu kutubxonalarda bor';
	@override String get checkingLibrary => 'Kutubxona tekshirilmoqda...';
	@override String get emptyTitle => 'Hali bu yerda hech narsa yoʻq';
	@override String emptyMessage({required Object source}) => '${source} manbasidan olingan qatorlar bu yerda koʻrinadi.';
	@override String searchHint({required Object source}) => '${source} ichidan qidirish';
	@override String searchEmpty({required Object query}) => '"${query}" boʻyicha natija topilmadi';
	@override String searchPrompt({required Object source}) => '${source} orqali filmlar va seriallarni qidiring.';
	@override String get searchFailed => 'Qidiruv xatoligi. Ulanishni tekshiring.';
}

// Path: collections
class _Translations$collections$uz extends Translations$collections$en {
	_Translations$collections$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get collection => 'Toʻplam';
	@override String get empty => 'Toʻplam boʻsh';
	@override String get deleteCollection => 'Toʻplamni oʻchirish';
	@override String deleteConfirm({required Object title}) => '"${title}" oʻchirilsinmi?';
	@override String get deleted => 'Toʻplam oʻchirildi';
	@override String get deleteFailed => 'Toʻplamni oʻchirib boʻlmadi';
	@override String deleteFailedWithError({required Object error}) => 'Toʻplamni oʻchirish xatoligi: ${error}';
	@override String get selectCollection => 'Toʻplamni tanlash';
	@override String get collectionName => 'Toʻplam nomi';
	@override String get enterCollectionName => 'Toʻplam nomini kiriting';
	@override String get addedToCollection => 'Toʻplamga qoʻshildi';
	@override String get errorAddingToCollection => 'Toʻplamga qoʻshib boʻlmadi';
	@override String get created => 'Toʻplam yaratildi';
	@override String get removeFromCollection => 'Toʻplamdan oʻchirish';
	@override String removeFromCollectionConfirm({required Object title}) => '"${title}" ushbu toʻplamdan oʻchirilsinmi?';
	@override String get removedFromCollection => 'Toʻplamdan oʻchirildi';
	@override String get removeFromCollectionFailed => 'Toʻplamdan oʻchirib boʻlmadi';
	@override String removeFromCollectionError({required Object error}) => 'Oʻchirish xatoligi: ${error}';
	@override String get searchCollections => 'Toʻplamlardan qidirish...';
}

// Path: playlists
class _Translations$playlists$uz extends Translations$playlists$en {
	_Translations$playlists$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get playlist => 'Ijro roʻyxati';
	@override String get noPlaylists => 'Ijro roʻyxatlari topilmadi';
	@override String get create => 'Ijro roʻyxatini yaratish';
	@override String get playlistName => 'Ijro roʻyxati nomi';
	@override String get enterPlaylistName => 'Roʻyxat nomini kiriting';
	@override String get delete => 'Ijro roʻyxatini oʻchirish';
	@override String get removeItem => 'Roʻyxatdan oʻchirish';
	@override String get smartPlaylist => 'Aqlli ijro roʻyxati';
	@override String itemCount({required Object count}) => '${count} element';
	@override String get oneItem => '1 element';
	@override String get emptyPlaylist => 'Ushbu roʻyxat boʻsh';
	@override String get deleteConfirm => 'Ijro roʻyxati oʻchirilsinmi?';
	@override String deleteMessage({required Object name}) => '"${name}" oʻchirilsinmi?';
	@override String get created => 'Ijro roʻyxati yaratildi';
	@override String get deleted => 'Ijro roʻyxati oʻchirildi';
	@override String get itemAdded => 'Roʻyxatga qoʻshildi';
	@override String get itemRemoved => 'Roʻyxatdan oʻchirildi';
	@override String get selectPlaylist => 'Roʻyxatni tanlash';
	@override String get searchPlaylists => 'Ijro roʻyxatlaridan qidirish...';
	@override String get errorCreating => 'Roʻyxatni yaratib boʻlmadi';
	@override String get errorDeleting => 'Roʻyxatni oʻchirib boʻlmadi';
	@override String get errorLoading => 'Roʻyxatlarni yuklab boʻlmadi';
	@override String get errorAdding => 'Roʻyxatga qoʻshib boʻlmadi';
	@override String get errorReordering => 'Qayta tartiblab boʻlmadi';
	@override String get errorRemoving => 'Roʻyxatdan oʻchirib boʻlmadi';
}

// Path: music
class _Translations$music$uz extends Translations$music$en {
	_Translations$music$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get goToAlbum => 'Albomga oʻtish';
	@override String get goToArtist => 'Ijrochiga oʻtish';
	@override String get instantMix => 'Tezkor miks';
	@override String get playNext => 'Keyingisini ijro etish';
	@override String get addToQueue => 'Navbatga qoʻshish';
	@override String discNumber({required Object n}) => '${n}-disk';
	@override String trackCount({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uz'))(n,
		one: '${n} tarona',
		other: '${n} tarona',
	);
	@override String get nowPlaying => 'Hozir ijro etilmoqda';
	@override String playingFrom({required Object title}) => '${title} manbasidan';
	@override String get queue => 'Navbat';
	@override String get clearQueue => 'Navbatni tozalash';
	@override String get lyrics => 'Musiqa matni';
	@override String get noLyrics => 'Musiqa matni yoʻq';
	@override String get sleepTimer => 'Uyqu taymeri';
	@override String get sleepTimerEndOfTrack => 'Taronaning oxiri';
	@override String sleepTimerMinutes({required Object n}) => '${n} daqiqa';
	@override String get stopPlayback => 'Ijroni toʻxtatish';
	@override String get previousTrack => 'Oldingi tarona';
	@override String get nextTrack => 'Keyingi tarona';
	@override String get repeat => 'Takrorlash';
	@override String get repeatAll => 'Barchasini takrorlash';
	@override String get repeatOne => 'Birtasini takrorlash';
}

// Path: downloads
class _Translations$downloads$uz extends Translations$downloads$en {
	_Translations$downloads$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Yuklamalar';
	@override String get manage => 'Boshqarish';
	@override String get tvShows => 'TV Shoular';
	@override String get movies => 'Filmlar';
	@override String get music => 'Musiqa';
	@override String tracksQueued({required Object count}) => '${count} tarona yuklash navbatiga qoʻshildi';
	@override String get noDownloads => 'Hali yuklamalar yoʻq';
	@override String get noDownloadsDescription => 'Yuklangan fayllar oflayn koʻrish uchun bu yerda koʻrinadi';
	@override String get downloadNow => 'Yuklab olish';
	@override String get deleteDownload => 'Yuklamani oʻchirish';
	@override String get retryDownload => 'Yuklashni qaytadan urinish';
	@override String get downloadQueued => 'Yuklash navbatga qoʻyildi';
	@override String get downloadResumed => 'Yuklash davom ettirildi';
	@override String get serverErrorBitrate => 'Server xatoligi: fayl tezlik cheklovidan oshgan boʻlishi mumkin';
	@override String get storageFull => 'Xotira toʻlganligi sababli yuklash toʻxtatildi.';
	@override String episodesQueued({required Object count}) => '${count} qism yuklash navbatiga qoʻshildi';
	@override String get downloadDeleted => 'Yuklama oʻchirildi';
	@override String deleteConfirm({required Object title}) => '"${title}" ushbu qurilmadan oʻchirilsinmi?';
	@override String get cancelledDownloadTitle => 'Toʻxtatilgan yuklama';
	@override String get cancelledDownloadMessage => 'Ushbu yuklash toʻxtatildi.';
	@override String get allEpisodesAlreadyDownloaded => 'Barcha qismlar avvaldan yuklab olingan';
	@override String get resumeDownload => 'Yuklashni davom ettirish';
	@override String get cancelledDownload => 'Toʻxtatilgan yuklama';
	@override String syncingFile({required Object file, required Object status}) => '${file} (${status} sinxronlanmoqda)';
	@override String downloadedFileClickToComplete({required Object file}) => 'Yuklab olindi ${file} - Yakunlash uchun bosing';
	@override String get partialDownloadClickToComplete => 'Qisman yuklandi - Yakunlash uchun bosing';
	@override String get deleting => 'Oʻchirilmoqda...';
	@override String deletingWithProgress({required Object title, required Object current, required Object total}) => '${title} oʻchirilmoqda... (${current} / ${total})';
	@override String get queuedTooltip => 'Navbatda';
	@override String queuedFilesTooltip({required Object files}) => 'Navbatdagi fayllar: ${files}';
	@override String get downloadingTooltip => 'Yuklanmoqda...';
	@override String downloadingFilesTooltip({required Object files}) => 'Yuklanayotgan fayllar: ${files}';
	@override String get noDownloadsTree => 'Yuklamalar yoʻq';
	@override String get pauseAll => 'Barchasini toʻxtatib turish';
	@override String get resumeAll => 'Barchasini davom ettirish';
	@override String get deleteAll => 'Barchasini oʻchirish';
	@override String get selectVersion => 'Versiyani tanlash';
	@override String get allEpisodes => 'Barcha qismlar';
	@override String get unwatchedOnly => 'Faqat koʻrilmaganlar';
	@override String nextNUnwatched({required Object count}) => 'Keyingi ${count} koʻrilmagan';
	@override String get customAmount => 'Boshqa miqdor...';
	@override String get includeSpecials => 'Maxsus qismlarni qoʻshish';
	@override String get howManyEpisodes => 'Nechta qism?';
	@override String get invalidEpisodeCount => 'Toʻgʻri qismlar sonini kiriting.';
	@override String get keepSynced => 'Sinxronlangan holatda ushlash';
	@override String get downloadOnce => 'Bir marta yuklab olish';
	@override String keepNUnwatched({required Object count}) => '${count} koʻrilmagan qismni saqlash';
	@override String get editSyncRule => 'Sinxronlash qoidasini tahrirlash';
	@override String get removeSyncRule => 'Sinxronlash qoidasini oʻchirish';
	@override String removeSyncRuleConfirm({required Object title}) => '"${title}" sinxronlashi toʻxtatilsinmi? Yuklab olingan qismlar saqlanadi.';
	@override String removeListSyncRuleConfirm({required Object title}) => '"${title}" sinxronlashi toʻxtatilsinmi?';
	@override String get deleteSyncRuleDownloads => 'Bogʻliq yuklamalar ham oʻchirilsin';
	@override String get deleteSyncRuleDownloadsDescription => 'Boshqa sinxronlash qoidasi yoki profil ishlatayotgan yuklamalar saqlanadi.';
	@override String syncRuleCreated({required Object count}) => 'Sinxronlash qoidasi yaratildi — ${count} koʻrilmagan qism saqlanadi';
	@override String get syncRuleUpdated => 'Sinxronlash qoidasi yangilandi';
	@override String get syncRuleRemoved => 'Sinxronlash qoidasi oʻchirildi';
	@override String get syncRuleAndDownloadsRemoved => 'Sinxronlash qoidasi va bogʻliq yuklamalar oʻchirildi';
	@override String get syncRuleCleanupBusy => 'Sinxronlash qoidalari hozir yangilanmoqda. Bir ozdan soʻng qayta urinib koʻring.';
	@override String get syncRuleCleanupUnavailable => 'Bogʻliq yuklamalarni xavfsiz aniqlab boʻlmadi. Serverga qayta ulanib koʻring yoki yuklamalarni oʻchirmasdan qoidani olib tashlang.';
	@override String syncedNewEpisodes({required Object title, required Object count}) => '${title} uchun ${count} yangi qism sinxronlandi';
	@override String get activeSyncRules => 'Faol sinxronlash qoidalari';
	@override String get noSyncRules => 'Sinxronlash qoidalari yoʻq';
	@override String get manageSyncRule => 'Sinxronlashni boshqarish';
	@override String get editEpisodeCount => 'Qismlar soni';
	@override String get editSyncFilter => 'Sinxronlash filtri';
	@override String get syncAllItems => 'Barcha elementlar sinxronlanadi';
	@override String get syncUnwatchedItems => 'Koʻrilmagan elementlar sinxronlanadi';
	@override String syncRuleServerContext({required Object server, required Object status}) => 'Server: ${server} • ${status}';
	@override String get syncRuleAvailable => 'Mavjud';
	@override String get syncRuleOffline => 'Oflayn';
	@override String get syncRuleSignInRequired => 'Kirish talab etiladi';
	@override String get syncRuleNotAvailableForProfile => 'Joriy profil uchun mavjud emas';
	@override String get syncRuleUnknownServer => 'Nomaʼlum server';
	@override String get syncRuleListCreated => 'Sinxronlash qoidasi yaratildi';
	@override late final _Translations$downloads$backgroundWarning$uz backgroundWarning = _Translations$downloads$backgroundWarning$uz._(_root);
}

// Path: shaders
class _Translations$shaders$uz extends Translations$shaders$en {
	_Translations$shaders$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sheyderlar';
	@override String get noShaderDescription => 'Video yaxshilash oʻchirilgan';
	@override String get nvscalerDescription => 'Aniqroq video uchun NVIDIA masshtabi';
	@override String get artcnnVariantNeutral => 'Neytral';
	@override String get artcnnVariantDenoise => 'Shovqinni kamaytirish';
	@override String get artcnnVariantDenoiseSharpen => 'Shovqinni kamaytirish + Aniqlik';
	@override String get qualityFast => 'Tezkor';
	@override String get qualityHQ => 'Yuqori sifat';
	@override String get mode => 'Rejim';
	@override String get importShader => 'Sheyderni import qilish';
	@override String get customShaderDescription => 'Maxsus GLSL sheyderi';
	@override String get shaderImported => 'Sheyder import qilindi';
	@override String get shaderImportFailed => 'Sheyderni import qilib boʻlmadi';
	@override String get deleteShader => 'Sheyderni oʻchirish';
	@override String deleteShaderConfirm({required Object name}) => '"${name}" oʻchirilsinmi?';
}

// Path: videoSettings
class _Translations$videoSettings$uz extends Translations$videoSettings$en {
	_Translations$videoSettings$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get playbackSpeed => 'Ijro tezligi';
	@override String get normalSpeed => 'Normal';
	@override String sleepTimerActive({required Object duration}) => 'Faol (${duration})';
	@override String get zoom => 'Masshtab';
	@override String get sleepTimer => 'Uyqu taymeri';
	@override String get audioSync => 'Audio sinxronlash';
	@override String get subtitleSync => 'Subtitr sinxronlash';
	@override String get hdr => 'HDR';
	@override String get audioOutput => 'Audio chiqishi';
	@override String get performanceOverlay => 'Unumdorlik paneli';
	@override String get audioPassthrough => 'Ovozni toʻgʻridan-toʻgʻri oʻtkazish';
	@override String get audioOutputDolbyAtmos => 'Dolby Atmos';
	@override String get audioOutputDolbyAudio => 'Dolby Audio';
	@override String get audioOutputSurround => 'Surround';
	@override String get audioOutputSpatial => 'Fazoviy audio';
	@override String get audioOutputStereo => 'Stereo';
	@override String get audioNormalization => 'Ovoz balandligini meʼyorlashtirish';
	@override String get audioDownmix => 'Stereoga oʻtkazish';
}

// Path: performanceOverlay
class _Translations$performanceOverlay$uz extends Translations$performanceOverlay$en {
	_Translations$performanceOverlay$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get color => 'Rang';
	@override String get performance => 'Unumdorlik';
	@override String get buffer => 'Bufer';
	@override String get app => 'Ilova';
	@override String get decoder => 'Dekoder';
	@override String get rawDecoder => 'Ishlov berilmagan dekoder';
	@override String get tunneling => 'Tunnellash';
	@override String get aspect => 'Nisbat';
	@override String get rotation => 'Aylanish';
	@override String get dvSource => 'DV manbasi';
	@override String get dvPath => 'DV yoʻli';
	@override String get p7Conversion => 'P7 oʻtkazmasi';
	@override String get sampleRate => 'Diskretlash chastotasi';
	@override String get pixelFormat => 'Piksel formati';
	@override String get hwFormat => 'HW formati';
	@override String get matrix => 'Matritsa';
	@override String get primaries => 'Asosiy ranglar';
	@override String get transfer => 'Uzatish';
	@override String get renderFps => 'Render FPS';
	@override String get displayFps => 'Displey FPS';
	@override String get avSync => 'A/V sinxronlash';
	@override String get dropped => 'Tushirib qoldirilgan kadrlar';
	@override String get dvRpus => 'DV RPU-lar';
	@override String get dvRpuAverage => 'DV RPU Oʻrt.';
	@override String get dvSampleAverage => 'DV Namuna Oʻrt.';
	@override String get maxLuma => 'Maks Luma';
	@override String get minLuma => 'Min Luma';
	@override String get maxCll => 'MaxCLL';
	@override String get maxFall => 'MaxFALL';
	@override String get cacheUsed => 'Foydalanilgan kesh';
	@override String get cacheLimit => 'Kesh chegarasi';
	@override String get speed => 'Tezlik';
	@override String get player => 'Pleyer';
	@override String get memory => 'Xotira';
	@override String get uiFps => 'Interfeys (UI) FPS';
}

// Path: externalPlayer
class _Translations$externalPlayer$uz extends Translations$externalPlayer$en {
	_Translations$externalPlayer$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tashqi pleyer';
	@override String get useExternalPlayer => 'Tashqi pleyerdan foydalanish';
	@override String get useExternalPlayerDescription => 'Videolarni boshqa ilovada ochish';
	@override String get selectPlayer => 'Pleyerni tanlash';
	@override String get customPlayers => 'Maxsus pleyerlar';
	@override String get systemDefault => 'Tizim standarti';
	@override String get addCustomPlayer => 'Maxsus pleyer qoʻshish';
	@override String get playerName => 'Pleyer nomi';
	@override String get playerNameHint => 'Mening pleyerim';
	@override String get playerCommand => 'Buyruq';
	@override String get playerPackage => 'Paket nomi';
	@override String get playerUrlScheme => 'URL sxemasi';
	@override String get off => 'Oʻchirilgan';
	@override String get launchFailed => 'Tashqi pleyerni ishga tushirib boʻlmadi';
	@override String appNotInstalled({required Object name}) => '${name} oʻrnatilmagan';
	@override String get playInExternalPlayer => 'Tashqi pleyerda ijro etish';
}

// Path: metadataEdit
class _Translations$metadataEdit$uz extends Translations$metadataEdit$en {
	_Translations$metadataEdit$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get editMetadata => 'Tahrirlash...';
	@override String get screenTitle => 'Metamaʼlumotlarni tahrirlash';
	@override String get basicInfo => 'Asosiy maʼlumotlar';
	@override String get artwork => 'Rasmlar/Posterlar';
	@override String get title => 'Nomi';
	@override String get sortTitle => 'Saralash nomi';
	@override String get originalTitle => 'Asl nomi';
	@override String get releaseDate => 'Chiqqan sanasi';
	@override String get contentRating => 'Kontent reytingi';
	@override String get studio => 'Studiya';
	@override String get tagline => 'Shior/Slogan';
	@override String get summary => 'Tavsif/Qisqacha';
	@override String get poster => 'Poster';
	@override String get background => 'Fon';
	@override String get logo => 'Logotip';
	@override String get squareArt => 'Kvadrat rasm';
	@override String get selectPoster => 'Posterni tanlash';
	@override String get selectBackground => 'Fonni tanlash';
	@override String get selectLogo => 'Logotipni tanlash';
	@override String get selectSquareArt => 'Kvadrat rasm tanlash';
	@override String get fromUrl => 'URL orqali';
	@override String get uploadFile => 'Fayl yuklash';
	@override String get enterImageUrl => 'Rasm URL-manzilini kiriting';
	@override String get imageUrl => 'Rasm URL-manzili';
	@override String get metadataUpdated => 'Metamaʼlumotlar yangilandi';
	@override String get metadataUpdateFailed => 'Metamaʼlumotlarni yangilab boʻlmadi';
	@override String get artworkUpdated => 'Rasmlar yangilandi';
	@override String get artworkUpdateFailed => 'Rasmlarni yangilab boʻlmadi';
	@override String get noArtworkAvailable => 'Rasm mavjud emas';
	@override String artworkOption({required Object index}) => 'Rasm opsiyasi ${index}';
	@override String selectedArtworkOption({required Object index}) => 'Rasm opsiyasi ${index}, tanlandi';
	@override String get notSet => 'Oʻrnatilmagan';
	@override String get tags => 'Teglar';
	@override String get addTag => 'Teg qoʻshish';
	@override String get genre => 'Janr';
	@override String get director => 'Rejissyor';
	@override String get writer => 'Ssenarist';
	@override String get producer => 'Prodyuser';
	@override String get country => 'Mamlakat';
	@override String get label => 'Yorliq';
}

// Path: trakt
class _Translations$trakt$uz extends Translations$trakt$en {
	_Translations$trakt$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Trakt';
	@override String get connected => 'Ulandi';
	@override String connectedAs({required Object username}) => '@${username} sifatida ulandi';
	@override String get disconnectConfirm => 'Trakt uzilsinmi?';
	@override String get disconnectConfirmBody => 'Harbor Trakt-ga maʼlumot yuborishni toʻxtatadi.';
	@override String get scrobble => 'Real vaqt rejimida kuzatish';
	@override String get scrobbleDescription => 'Ijro paytida Trakt-ga maʼlumot yuborish.';
	@override String get watchedSync => 'Koʻrish holatini sinxronlash';
	@override String get watchedSyncDescription => 'Harbor-da belgilanganda Trakt-da ham belgilanadi.';
}

// Path: seerr
class _Translations$seerr$uz extends Translations$seerr$en {
	_Translations$seerr$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Seerr';
	@override String get connectTitle => 'Seerr ulash';
	@override String get serverUrl => 'Server URL-i';
	@override String get serverUrlHelper => 'Seerr manzilingiz';
	@override String get checkServer => 'Davom ettirish';
	@override String get signInWithJellyfin => 'Jellyfin orqali kirish';
	@override String get signInWithEmby => 'Emby orqali kirish';
	@override String get signInWithLocal => 'Mahalliy hisobdan foydalanish';
	@override String get email => 'Elektron pochta';
	@override String get noSignInMethods => 'Ushbu Seerr qoʻllab-quvvatlanadigan kirish usulini taklif qilmaydi.';
	@override String get instance => 'Instansiya';
	@override String get disconnectConfirm => 'Seerr uzilsinmi?';
	@override String get disconnectConfirmBody => 'Harbor ushbu Seerr manzilini oʻchiradi.';
	@override String get request => 'Soʻrov yuborish';
	@override String get request4k => '4K soʻrov yuborish';
	@override String get seasons => 'Mavsumlar';
	@override String get allSeasons => 'Barcha mavsumlar';
	@override String get advancedOptions => 'Kengaytirilgan';
	@override String get destinationServer => 'Moʻljal server';
	@override String get qualityProfile => 'Sifat profili';
	@override String get rootFolder => 'Asosiy jild';
	@override String get languageProfile => 'Til profili';
	@override String get requestSubmitted => 'Soʻrov yuborildi';
	@override String requestFailed({required Object error}) => 'Soʻrov xatoligi: ${error}';
	@override String get requestsLoadFailed => 'Parametrlarni yuklab boʻlmadi';
	@override String get nothingToRequest => 'Barchasi avvaldan bor yoki soʻralgan.';
	@override String get statusAvailable => 'Mavjud';
	@override String get statusPartiallyAvailable => 'Qisman mavjud';
	@override String get statusRequested => 'Soʻraldi';
	@override String get statusProcessing => 'Ishlanmoqda';
}

// Path: services
class _Translations$services$uz extends Translations$services$en {
	_Translations$services$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Xizmatlar';
	@override String get hubSubtitle => 'Koʻrish jarayonini sinxronlang va yangi kontent soʻrang.';
	@override String get notConnected => 'Ulanmagan';
	@override String connectedAs({required Object username}) => '@${username} sifatida ulandi';
	@override String connectFailed({required Object service}) => '${service} ulana olmadi. Qaytadan urinib koʻring.';
	@override late final _Translations$services$names$uz names = _Translations$services$names$uz._(_root);
	@override late final _Translations$services$deviceCode$uz deviceCode = _Translations$services$deviceCode$uz._(_root);
	@override late final _Translations$services$libraryFilter$uz libraryFilter = _Translations$services$libraryFilter$uz._(_root);
}

// Path: addServer
class _Translations$addServer$uz extends Translations$addServer$en {
	_Translations$addServer$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get addJellyfinTitle => 'Jellyfin serverini qoʻshish';
	@override String get serverUrls => 'Server URL-lari';
	@override String get serverUrlsHelper => 'Vergul bilan ajratilgan bir nechta URL manziliga ruxsat beriladi.';
	@override String get findServer => 'Serverni topish';
	@override String get searchingLocalServers => 'Mahalliy Jellyfin serverlari qidirilmoqda...';
	@override String get localServers => 'Mahalliy Jellyfin serverlari';
	@override String get username => 'Foydalanuvchi nomi';
	@override String get password => 'Parol';
	@override String get signIn => 'Kirish';
	@override String get change => 'Oʻzgartirish';
	@override String get required => 'Talab qilinadi';
	@override String couldNotReachServer({required Object error}) => 'Serverga ulanib boʻlmadi: ${error}';
	@override String signInFailed({required Object error}) => 'Kirish xatoligi: ${error}';
	@override String quickConnectFailed({required Object error}) => 'Tezkor ulanish xatoligi: ${error}';
	@override String get enterJellyfinUrlError => 'Jellyfin server URL-ini kiriting';
	@override String get addConnectionTitle => 'Ulanish qoʻshish';
	@override String addConnectionTitleScoped({required Object name}) => '${name} profiliga qoʻshish';
	@override String get connectToJellyfinCard => 'Jellyfin-ga ulanish';
	@override String get connectToJellyfinCardSubtitle => 'Server URL, foydalanuvchi nomi va parolingizni kiriting.';
	@override String connectToJellyfinCardSubtitleScoped({required Object name}) => 'Jellyfin serveriga kiring. ${name} profiliga ulanmoqda.';
	@override String get borrowFromAnotherProfile => 'Boshqa profildan olish';
	@override String get borrowFromAnotherProfileSubtitle => 'Boshqa profilning ulanishidan qayta foydalaning.';
}

// Path: hotkeys.actions
class _Translations$hotkeys$actions$uz extends Translations$hotkeys$actions$en {
	_Translations$hotkeys$actions$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get playPause => 'Ijro/Pauza';
	@override String get volumeUp => 'Ovozni balandlatish';
	@override String get volumeDown => 'Ovozni pastlatish';
	@override String seekForward({required Object seconds}) => 'Oldinga oʻtkazish (${seconds}son)';
	@override String seekBackward({required Object seconds}) => 'Orqaga oʻtkazish (${seconds}son)';
	@override String get fullscreenToggle => 'Toʻliq ekranga oʻtish/chiqish';
	@override String get muteToggle => 'Ovozni oʻchirish/yoqish';
	@override String get subtitleToggle => 'Subtitrni yoqish/oʻchirish';
	@override String get audioTrackNext => 'Keyingi audio yoʻlak';
	@override String get subtitleTrackNext => 'Keyingi subtitr yoʻlagi';
	@override String get chapterNext => 'Keyingi boʻlim';
	@override String get chapterPrevious => 'Oldingi boʻlim';
	@override String get episodeNext => 'Keyingi qism';
	@override String get episodePrevious => 'Oldingi qism';
	@override String get speedIncrease => 'Tezlikni oshirish';
	@override String get speedDecrease => 'Tezlikni kamaytirish';
	@override String get speedReset => 'Tezlikni qayta oʻrnatish';
	@override String get zoomIn => 'Yaqinlashtirish';
	@override String get zoomOut => 'Uzoqlashtirish';
	@override String get zoomReset => 'Masshtabni qayta oʻrnatish';
	@override String get subSeekNext => 'Keyingi subtitrga oʻtish';
	@override String get subSeekPrev => 'Oldingi subtitrga oʻtish';
	@override String get shaderToggle => 'Sheyderlarni yoqish/oʻchirish';
	@override String get skipMarker => 'Intro/Titrlarni oʻtkazib yuborish';
	@override String get screenshot => 'Ekran tasvirini olish';
}

// Path: videoControls.pipErrors
class _Translations$videoControls$pipErrors$uz extends Translations$videoControls$pipErrors$en {
	_Translations$videoControls$pipErrors$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get androidVersion => 'Android 8.0 yoki undan yangisi talab qilinadi';
	@override String get iosVersion => 'iOS 15.0 yoki undan yangisi talab qilinadi';
	@override String get permissionDisabled => 'PiP rejimi oʻchirilgan. Tizim sozlamalaridan yoqing.';
	@override String get notSupported => 'Qurilma PiP rejimini qoʻllab-quvvatlamaydi';
	@override String get voSwitchFailed => 'PiP uchun video chiqishini almashtirib boʻlmadi';
	@override String get failed => 'PiP rejimini ishga tushirishda xatolik';
	@override String unknown({required Object error}) => 'Xatolik yuz berdi: ${error}';
}

// Path: libraries.groupings
class _Translations$libraries$groupings$uz extends Translations$libraries$groupings$en {
	_Translations$libraries$groupings$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Guruhlash';
	@override String get all => 'Barchasi';
	@override String get movies => 'Filmlar';
	@override String get shows => 'TV Shoular';
	@override String get seasons => 'Mavsumlar';
	@override String get episodes => 'Qismlar';
	@override String get artists => 'Ijrochilar';
	@override String get albums => 'Albomlar';
	@override String get tracks => 'Taronalar';
	@override String get folders => 'Jildlar';
}

// Path: libraries.filterCategories
class _Translations$libraries$filterCategories$uz extends Translations$libraries$filterCategories$en {
	_Translations$libraries$filterCategories$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get genre => 'Janr';
	@override String get year => 'Yil';
	@override String get contentRating => 'Kontent reytingi';
	@override String get tag => 'Teg';
	@override String get unwatched => 'Koʻrilmagan';
	@override String get unplayed => 'Eshitilmagan';
	@override String get favorites => 'Tanlanganlar';
}

// Path: libraries.sortLabels
class _Translations$libraries$sortLabels$uz extends Translations$libraries$sortLabels$en {
	_Translations$libraries$sortLabels$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Nomi';
	@override String get dateAdded => 'Qoʻshilgan sanasi';
	@override String get communityRating => 'Hamjamiyat reytingi';
	@override String get criticRating => 'Muntaqidlar reytingi';
	@override String get datePlayed => 'Ijro etilgan sanasi';
	@override String get playCount => 'Ijrolar soni';
	@override String get productionYear => 'Ishlab chiqarilgan yili';
	@override String get runtime => 'Davomiyligi';
	@override String get officialRating => 'Rasmiy reyting';
	@override String get premiereDate => 'Premyera sanasi';
	@override String get startDate => 'Boshlangan sanasi';
	@override String get airTime => 'Efir vaqti';
	@override String get studio => 'Studiya';
	@override String get random => 'Tasodifiy';
	@override String get lastEpisodeDateAdded => 'Soʻnggi qoʻshilgan qism sanasi';
}

// Path: explore.rows
class _Translations$explore$rows$uz extends Translations$explore$rows$en {
	_Translations$explore$rows$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get watchlist => 'Tomosha roʻyxati';
	@override String get recommendedMovies => 'Tavsiya etilgan filmlar';
	@override String get recommendedShows => 'Tavsiya etilgan seriallar';
	@override String get trendingMovies => 'Ommabop filmlar';
	@override String get trendingShows => 'Ommabop seriallar';
	@override String get popularMovies => 'Mashhur filmlar';
	@override String get popularShows => 'Mashhur seriallar';
	@override String get trendingAnime => 'Ommabop anime';
	@override String get suggestedAnime => 'Tavsiya etilgan anime';
	@override String get airingAnime => 'Efirga uzatilayotgan eng yaxshi anime';
	@override String get popularAnime => 'Eng mashhur anime';
	@override String get trending => 'Ommaboplar';
	@override String get upcomingMovies => 'Kutilayotgan filmlar';
	@override String get upcomingShows => 'Kutilayotgan seriallar';
}

// Path: explore.status
class _Translations$explore$status$uz extends Translations$explore$status$en {
	_Translations$explore$status$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get airing => 'Efirda';
	@override String get ended => 'Tugallandi';
	@override String get canceled => 'Bekor qilindi';
	@override String get upcoming => 'Kutilmoqda';
}

// Path: downloads.backgroundWarning
class _Translations$downloads$backgroundWarning$uz extends Translations$downloads$backgroundWarning$en {
	_Translations$downloads$backgroundWarning$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get bannerBlocked => 'Ilovadan chiqqaningizda yuklamalar toʻxtaydi';
	@override String get bannerDegraded => 'Fondagi yuklamalar cheklangan boʻlishi mumkin';
	@override String get bannerAction => 'Batafsil';
	@override String get sheetTitle => 'Fondagi yuklamalar bloklangan';
	@override String get sheetTitleDegraded => 'Fondagi yuklamalar cheklangan boʻlishi mumkin';
	@override String get sheetIntro => 'Android Harbor-ning fonda ishonchli yuklab olishiga toʻsqinlik qilmoqda.';
	@override String get sheetIntroDegraded => 'Qurilmangiz Harbor fonda qachon yuklay olishini cheklamoqda.';
	@override String get reasonBackgroundRestricted => 'Harbor-ning fondagi faoliyati cheklangan. Batareya yoki fondagi foydalanishni "Cheklanmagan" qilib belgilang.';
	@override String get reasonStandbyRestricted => 'Android Harbor-ni cheklangan kutish holatiga oʻtkazdi. Batareya foydalanishini "Cheklanmagan" qilib belgilang.';
	@override String get reasonDownloadChannelBlocked => 'Yuklash bildirishnomalari oʻchirilgan, shuning uchun jarayon koʻrsatkichi va boshqaruv elementlari mavjud boʻlmasligi mumkin.';
	@override String get reasonNotificationsDisabled => 'Bildirishnomalar oʻchirilgan. Android 13 va undan yangi versiyalarda uzoq davom etadigan fondagi yuklamalar uchun ular talab qilinadi.';
	@override String get reasonDataSaver => 'Trafik tejash yoqilgan, bu mobil internetda fondagi yuklamalarni bloklaydi. Wi-Fi orqali yuklamalar ishlashi kerak.';
	@override String get reasonOemUnknown => 'Harbor fonda boʻlganida yuklamalar bir necha marta toʻxtadi. Harbor-ning batareya yoki fondagi foydalanish sozlamalarini tekshiring.';
	@override String get openSettings => 'Sozlamalarni ochish';
	@override String get stillNotWorking => 'Qurilmaga oid yordam';
	@override String get stillNotWorkingDescription => 'Qurilmangiz uchun qadamlarni koʻring yoki muammo davom etsa Sozlamalar › Jurnallarni koʻrish boʻlimidan jurnal yuboring.';
	@override String get dialogTitle => 'Yuklamalar tugamasligi mumkin';
	@override String get dialogDownloadAnyway => 'Baribir yuklash';
	@override String get dialogFixFirst => 'Avval buni tuzatish';
	@override String get statusTile => 'Fondagi yuklamalar';
	@override String get statusOk => 'Fonda ishlashga ruxsat berilgan';
	@override String get statusBlocked => 'Tizim sozlamalari tomonidan bloklangan';
	@override String get statusDegraded => 'Tizim sozlamalari tomonidan cheklangan';
	@override String get statusUnknown => 'Hali tekshirilmagan';
	@override String get settingsUnavailable => 'Bu qurilmada tizim sozlamalarini ochib boʻlmadi';
	@override String get linkUnavailable => 'Bu qurilmada dontkillmyapp.com-ni ochib boʻlmadi';
}

// Path: services.names
class _Translations$services$names$uz extends Translations$services$names$en {
	_Translations$services$names$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get seerr => 'Seerr';
}

// Path: services.deviceCode
class _Translations$services$deviceCode$uz extends Translations$services$deviceCode$en {
	_Translations$services$deviceCode$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String title({required Object service}) => 'Harbor-ni ${service} xizmatida faollashtiring';
	@override String body({required Object url}) => '${url} manziliga oʻting va ushbu kodni kiriting:';
	@override String openToActivate({required Object service}) => 'Faollashtirish uchun ${service} xizmatini oching';
	@override String get copyCode => 'Faollashtirish kodini nusxalash';
	@override String get waitingForAuthorization => 'Avtorizatsiya kutilmoqda…';
	@override String get codeCopied => 'Kod nusxalandi';
}

// Path: services.libraryFilter
class _Translations$services$libraryFilter$uz extends Translations$services$libraryFilter$en {
	_Translations$services$libraryFilter$uz._(TranslationsUz root) : this._root = root, super.internal(root);

	final TranslationsUz _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kutubxona filtri';
	@override String get subtitleAllSyncing => 'Barcha kutubxonalar sinxronlanmoqda';
	@override String get subtitleNoneSyncing => 'Hech narsa sinxronlanmaydi';
	@override String subtitleBlocked({required Object count}) => '${count} bloklandi';
	@override String subtitleAllowed({required Object count}) => '${count} ruxsat berildi';
	@override String get mode => 'Filtr rejimi';
	@override String get modeBlacklist => 'Qora roʻyxat';
	@override String get modeWhitelist => 'Oq roʻyxat';
	@override String get modeHintBlacklist => 'Quyida tanlanganlardan tashqari barcha kutubxonalarni sinxronlash.';
	@override String get modeHintWhitelist => 'Faqat quyida tanlangan kutubxonalarni sinxronlash.';
	@override String get libraries => 'Kutubxonalar';
	@override String get noLibraries => 'Kutubxonalar yoʻq';
}

/// The flat map containing all translations for locale <uz>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsUz {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.title' => 'Harbor',
			'auth.connectToJellyfin' => 'Jellyfin-ga ulanish',
			'auth.useQuickConnect' => 'Tezkor ulanishdan foydalanish',
			'auth.quickConnectInstructions' => 'Jellyfin-da Tezkor ulanishni oching va ushbu kodni kiriting.',
			'auth.quickConnectWaiting' => 'Tasdiq kutilmoqda…',
			'auth.quickConnectCancel' => 'Bekor qilish',
			'auth.quickConnectExpired' => 'Tezkor ulanish vaqti tugadi. Qaytadan urinib koʻring.',
			'common.cancel' => 'Bekor qilish',
			'common.save' => 'Saqlash',
			'common.close' => 'Yopish',
			'common.clear' => 'Tozalash',
			'common.reset' => 'Qayta oʻrnatish',
			'common.submit' => 'Yuborish',
			'common.confirm' => 'Tasdiqlash',
			'common.retry' => 'Qaytadan urinish',
			'common.logout' => 'Chiqish',
			'common.unknown' => 'Nomaʼlum',
			'common.refresh' => 'Yangilash',
			'common.yes' => 'Ha',
			'common.no' => 'Yoʻq',
			'common.delete' => 'Oʻchirish',
			'common.edit' => 'Tahrirlash',
			'common.shuffle' => 'Aralashtirish',
			'common.addTo' => 'Qoʻshish...',
			'common.createNew' => 'Yangi yaratish',
			'common.disconnect' => 'Uzilish',
			'common.play' => 'Ijro etish',
			'common.pause' => 'Pauza',
			'common.resume' => 'Davom ettirish',
			'common.error' => 'Xatolik',
			'common.search' => 'Qidiruv',
			'common.home' => 'Bosh sahifa',
			'common.back' => 'Orqaga',
			'common.settings' => 'Sozlamalar',
			'common.ok' => 'Tushunarli',
			'common.off' => 'Oʻchirilgan',
			'common.seasonNumber' => ({required Object number}) => '${number}-mavsum',
			'common.episodeNumberTitle' => ({required Object number, required Object title}) => '${number}-qism - ${title}',
			'common.chapterNumber' => ({required Object number}) => '${number}-boʻlim',
			'common.reconnect' => 'Qayta ulanish',
			'common.viewAll' => 'Barchasini koʻrish',
			'common.checkingNetwork' => 'Tarmoq tekshirilmoqda...',
			'common.loadingServers' => 'Serverlar yuklanmoqda...',
			'common.connectingToServers' => 'Serverlarga ulanmoqda...',
			'common.startingOfflineMode' => 'Oflayn rejim ishga tushmoqda...',
			'common.loading' => 'Yuklanmoqda...',
			'common.pressBackAgainToExit' => 'Chiqish uchun orqaga tugmasini yana bir bor bosing',
			'common.next' => 'Keyingi',
			'screens.licenses' => 'Litsenziyalar',
			'screens.switchProfile' => 'Profilni almashtirish',
			'screens.subtitleStyling' => 'Subtitr sozlamalari',
			'screens.mpvConfig' => 'mpv.conf',
			'screens.logs' => 'Jurnallar',
			'settings.title' => 'Sozlamalar',
			'settings.language' => 'Til',
			'settings.theme' => 'Mavzu',
			'settings.appearance' => 'Tashqi koʻrinish',
			'settings.videoPlayback' => 'Video ijrosi',
			'settings.videoPlaybackDescription' => 'Ijro parametrlarini sozlang',
			'settings.advanced' => 'Kengaytirilgan',
			'settings.episodePosterMode' => 'Qism poster stili',
			'settings.seriesPoster' => 'Serial posteri',
			'settings.seasonPoster' => 'Mavsum posteri',
			'settings.episodeThumbnail' => 'Kadr koʻrinishi',
			'settings.showHeroSectionDescription' => 'Bosh sahifada tanlangan kontent karuselini koʻrsatish',
			'settings.secondsLabel' => 'Soniya',
			'settings.minutesLabel' => 'Daqiqa',
			'settings.secondsShort' => 'son',
			'settings.minutesShort' => 'daq',
			'settings.durationHint' => ({required Object min, required Object max}) => 'Vaqtni kiriting (${min}-${max})',
			'settings.systemTheme' => 'Tizim sozlamasi',
			'settings.lightTheme' => 'Yorugʻ',
			'settings.darkTheme' => 'Toʻq',
			'settings.oledTheme' => 'OLED',
			'settings.libraryDensity' => 'Kutubxona zichligi',
			'settings.compact' => 'Ixcham',
			'settings.comfortable' => 'Qulay',
			'settings.tvCornerSpotlightBackdrop' => 'Burchak yoritish foni',
			'settings.tvCornerSpotlightBackdropDescription' => 'Fonni toʻliq ekran oʻrniga yuqori oʻng burchakda koʻrsatish',
			'settings.viewMode' => 'Koʻrish rejimi',
			'settings.gridView' => 'Toʻrsimon',
			'settings.listView' => 'Roʻyxat',
			'settings.showHeroSection' => 'Asosiy boʻlimni koʻrsatish',
			'settings.continueWatchingAction' => '"Tomoshani davom ettirish" harakati',
			'settings.continueWatchingPlay' => 'Ijro etish',
			'settings.continueWatchingDetails' => 'Tafsilotlarni ochish',
			'settings.episodeAction' => 'Qism harakati',
			'settings.episodePlay' => 'Ijro etish',
			'settings.episodeDetails' => 'Tafsilotlarni ochish',
			'settings.showServerNameOnHubs' => 'Boʻlimlarda server nomini koʻrsatish',
			'settings.showServerNameOnHubsDescription' => 'Boʻlim sarlavhalarida har doim server nomini koʻrsatish.',
			'settings.groupLibrariesByServer' => 'Kutubxonalarni server boʻyicha guruhlash',
			'settings.groupLibrariesByServerDescription' => 'Yon menyudagi kutubxonalarni serverlar boʻyicha guruhlash.',
			'settings.alwaysKeepSidebarOpen' => 'Yon menyuni har doim ochiq saqlash',
			'settings.alwaysKeepSidebarOpenDescription' => 'Yon menyu ochiq holatda qoladi',
			'settings.showUnwatchedCount' => 'Koʻrilmaganlar sonini koʻrsatish',
			'settings.showUnwatchedCountDescription' => 'Seriallar va mavsumlarda koʻrilmagan qismlar sonini koʻrsatish',
			'settings.showEpisodeNumberOnCards' => 'Kartochkalarda qism raqamini koʻrsatish',
			'settings.showEpisodeNumberOnCardsDescription' => 'Qism kartochkalarida mavsum va qism raqamini koʻrsatish',
			'settings.showSeasonPostersOnTabs' => 'Varaqlarda mavsum posterlarini koʻrsatish',
			'settings.showSeasonPostersOnTabsDescription' => 'Har bir mavsum posterini oʻz boʻlimida koʻrsatish',
			'settings.tvFullCardLayout' => 'Toʻliq TV kartochkalari',
			'settings.tvFullCardLayoutDescription' => 'Faqat rasmdan iborat TV kartochkalaridan foydalanish',
			'settings.focusGlow' => 'Fokus nuri',
			'settings.focusGlowDescription' => 'Tanlangan kartochka atrofida yumshoq nur koʻrsatish',
			'settings.visualEffects' => 'Vizual effektlar',
			'settings.visualEffectsAuto' => 'Avtomatik',
			'settings.visualEffectsAutoDescription' => 'Kuchsiz qurilmalarda effektlarni avtomatik kamaytirish',
			'settings.visualEffectsFull' => 'Toʻliq',
			'settings.visualEffectsReduced' => 'Kamaytirilgan',
			'settings.visualEffectsReducedDescription' => 'Kamroq animatsiya va pastroq sifatli rasmlar',
			'settings.hideSpoilers' => 'Koʻrilmagan qismlar uchun spoylerlarni yashirish',
			'settings.hideSpoilersDescription' => 'Koʻrilmagan qismlar rasmlari va tavsiflarini xiralashtirish',
			'settings.playerBackend' => 'Pleyer infratuzilmasi',
			'settings.exoPlayer' => 'ExoPlayer',
			'settings.mpv' => 'mpv',
			'settings.hardwareDecoding' => 'Apparatli dekodlash',
			'settings.hardwareDecodingDescription' => 'Imkon qadar apparatli tezlashtirishdan foydalanish',
			'settings.bufferSize' => 'Bufer hajmi',
			'settings.bufferSizeMB' => ({required Object size}) => '${size} MB',
			'settings.bufferSizeAuto' => 'Avtomatik (Tavsiya etilgan)',
			'settings.bufferSizeWarning' => ({required Object heap, required Object size}) => '${heap} MB Xotira mavjud. ${size} MB bufer ijroga taʼsir qilishi mumkin.',
			'settings.defaultQualityTitle' => 'Standart sifat',
			'settings.musicQualityTitle' => 'Musiqa sifati',
			'settings.subtitleStyling' => 'Subtitr sozlamalari',
			'settings.subtitleStylingDescription' => 'Subtitrlar koʻrinishini moslashtiring',
			'settings.smallSkipDuration' => 'Kichik oʻtkazish vaqti',
			'settings.largeSkipDuration' => 'Katta oʻtkazish vaqti',
			'settings.rewindOnResume' => 'Davom ettirganda orqaga qaytarish',
			'settings.secondsUnit' => ({required Object seconds}) => '${seconds} soniya',
			'settings.defaultSleepTimer' => 'Standart uyqu taymeri',
			'settings.minutesUnit' => ({required Object minutes}) => '${minutes} daqiqa',
			'settings.rememberTrackSelections' => 'Har bir film/serial uchun ovoz/subtitr tanlovini eslab qolish',
			'settings.rememberTrackSelectionsDescription' => 'Har bir media uchun ovoz va subtitr sozlamalarini saqlash',
			'settings.followServerTrackSelections' => 'Har bir epizod uchun serverdagi tanlovlardan foydalanish',
			'settings.followServerTrackSelectionsDescription' => 'Epizod almashganda joriy tanlovni ko\'chirish o\'rniga serverda tanlangan ovoz va subtitrni qo\'llash',
			'settings.showChapterMarkersOnTimeline' => 'Vaqt shkalasida boʻlim belgilarini koʻrsatish',
			'settings.showChapterMarkersOnTimelineDescription' => 'Vaqt shkalasini boʻlimlarga boʻlish',
			'settings.clickVideoTogglesPlayback' => 'Ijro/pauza uchun videoga bosing',
			'settings.clickVideoTogglesPlaybackDescription' => 'Boshqaruv tugmalarini koʻrsatish oʻrniga videoni ijro etish yoki pauza qilish',
			'settings.videoPlayerControls' => 'Video pleyer boshqaruv elementlari',
			'settings.keyboardShortcuts' => 'Klaviatura tugmalari',
			'settings.keyboardShortcutsDescription' => 'Klaviatura tugmalarini moslashtiring',
			'settings.videoPlayerNavigation' => 'Video pleyer navigatsiyasi',
			'settings.videoPlayerNavigationDescription' => 'Pleyerni boshqarish uchun yoʻnalish tugmalaridan foydalaning',
			'settings.debugLogging' => 'Nosozliklarni aniqlash jurnali',
			'settings.debugLoggingDescription' => 'Muammolarni hal qilish uchun batafsil jurnal yuritishni yoqing',
			'settings.viewLogs' => 'Jurnallarni koʻrish',
			'settings.viewLogsDescription' => 'Ilova jurnallarini koʻrish',
			'settings.clearImageCache' => 'Rasm keshini tozalash',
			'settings.clearImageCacheDescription' => 'Keshlangan rasm va eskizlarni tozalaydi. Qayta yuklab olinmaguncha rasmlar sekinroq ochilishi mumkin.',
			'settings.clearImageCacheSuccess' => 'Rasm keshi muvaffaqiyatli tozalandi',
			'settings.resetSettings' => 'Sozlamalarni qayta oʻrnatish',
			'settings.resetSettingsDescription' => 'Standart sozlamalarni tiklash. Bu amalni ortga qaytarib boʻlmaydi.',
			'settings.resetSettingsSuccess' => 'Sozlamalar muvaffaqiyatli qayta oʻrnatildi',
			'settings.backup' => 'Zahira nusxa',
			'settings.exportSettings' => 'Sozlamalarni eksport qilish',
			'settings.exportSettingsDescription' => 'Parametrlaringizni faylga saqlang',
			'settings.exportSettingsSuccess' => 'Sozlamalar eksport qilindi',
			'settings.importSettings' => 'Sozlamalarni import qilish',
			'settings.importSettingsDescription' => 'Parametrlarni fayldan tiklang',
			'settings.importSettingsConfirm' => 'Bu joriy sozlamalaringiz ustidan yoziladi. Davom etasizmi?',
			'settings.importSettingsSuccess' => 'Sozlamalar import qilindi',
			'settings.importSettingsInvalidFile' => 'Ushbu fayl toʻgʻri Harbor sozlamalar fayli emas',
			'settings.importSettingsNoUser' => 'Sozlamalarni import qilishdan oldin tizimga kiring',
			'settings.shortcutsReset' => 'Tugmalar birlashmasi standart holatga qaytarildi',
			'settings.about' => 'Dastur haqida',
			'settings.aboutDescription' => 'Ilova haqida maʼlumot va litsenziyalar',
			'settings.validationErrorEnterNumber' => 'Toʻgʻri raqam kiriting',
			'settings.validationErrorDuration' => ({required Object min, required Object max, required Object unit}) => 'Vaqt ${min} va ${max} ${unit} orasida boʻlishi kerak',
			'settings.shortcutAlreadyAssigned' => ({required Object action}) => 'Bu birlashma ${action} harakatiga biriktirilgan',
			'settings.shortcutUpdated' => ({required Object action}) => '${action} uchun tugmalar birlashmasi yangilandi',
			'settings.saveFailed' => 'Oʻzgarishlar saqlanmadi. Qaytadan urinib koʻring.',
			'settings.autoSkip' => 'Avtomatik oʻtkazib yuborish',
			'settings.autoSkipIntro' => 'Kirish qismini (Intro) avtomatik oʻtkazish',
			'settings.autoSkipIntroDescription' => 'Bir necha soniyadan soʻng kirish qismlarini avtomatik oʻtkazish',
			'settings.autoSkipCredits' => 'Titrlarni avtomatik oʻtkazish',
			'settings.autoSkipCreditsDescription' => 'Titrlarni oʻtkazib yuborish va keyingi qismni ijro etish',
			'settings.forceSkipMarkerFallback' => 'Zahira belgilarini majburlash',
			'settings.forceSkipMarkerFallbackDescription' => 'Plex belgilari boʻlsa ham boʻlim sarlavhasi shablonlaridan foydalanish',
			'settings.autoSkipDelay' => 'Avtomatik oʻtkazish kechikishi',
			'settings.autoSkipDelayDescription' => ({required Object seconds}) => 'Avtomatik oʻtkazishdan oldin ${seconds} soniya kutilsin',
			'settings.introPattern' => 'Kirish qismi belgisi shabloni',
			'settings.introPatternDescription' => 'Boʻlim sarlavhalarida introni topish uchun Regex shabloni',
			'settings.creditsPattern' => 'Titr belgisi shabloni',
			'settings.creditsPatternDescription' => 'Boʻlim sarlavhalarida titrlarni topish uchun Regex shabloni',
			'settings.invalidRegex' => 'Notoʻgʻri muntazam ifoda (Regex)',
			'settings.regex' => 'Muntazam ifoda (Regex)',
			'settings.downloads' => 'Yuklamalar',
			'settings.downloadLocationDescription' => 'Yuklangan fayllar saqlanadigan joyni tanlang',
			'settings.downloadLocationDefault' => 'Standart (Ilova xotirasi)',
			'settings.downloadLocationCustom' => 'Boshqa joy',
			'settings.selectFolder' => 'Jildni tanlash',
			'settings.resetToDefault' => 'Standart holatga qaytarish',
			'settings.currentPath' => ({required Object path}) => 'Joriy: ${path}',
			'settings.downloadLocationChanged' => 'Yuklash joyi oʻzgartirildi',
			'settings.downloadLocationReset' => 'Yuklash joyi standart holatga qaytarildi',
			'settings.downloadLocationInvalid' => 'Tanlangan jildga yozib boʻlmadi',
			'settings.downloadLocationPickerUnavailable' => 'Ushbu qurilmada jildni tanlash imkoniyati yoʻq',
			'settings.downloadOnWifiOnly' => 'Faqat Wi-Fi orqali yuklash',
			'settings.downloadOnWifiOnlyDescription' => 'Mobil tarmoqdan foydalanilganda yuklashni toʻxtatib turish',
			'settings.autoRemoveWatchedDownloads' => 'Koʻrilgan yuklamalarni avtomatik oʻchirish',
			'settings.autoRemoveWatchedDownloadsDescription' => 'Koʻrib boʻlingan yuklamalarni avtomatik oʻchirish',
			'settings.cellularDownloadBlocked' => 'Mobil tarmoqda yuklash taqiqlangan. Wi-Fi-dan foydalaning.',
			'settings.maxVolume' => 'Maksimal ovoz',
			'settings.maxVolumeDescription' => 'Pastroq ovozli videolar uchun ovozni 100%-dan oshirishga ruxsat berish',
			'settings.maxVolumePercent' => ({required Object percent}) => '%${percent}',
			'settings.services' => 'Xizmatlar',
			'settings.servicesDescription' => 'Trakt, MyAnimeList, Seerr va boshqalarni ulang',
			'settings.manageLibrariesDescription' => 'Kutubxonalarni tartiblash va yashirish',
			'settings.autoPip' => 'Avtomatik Rasm ichida rasm (PiP)',
			'settings.autoPipDescription' => 'Video ijro etilayotganda ilovadan chiqilganda avto-PiP rejimiga oʻtish',
			'settings.matchContentFrameRate' => 'Kadrlar chastotasini moslashtirish',
			'settings.matchContentFrameRateDescription' => 'Ekran chastotasini video kontentiga moslashtirish',
			'settings.matchRefreshRate' => 'Yangilanish chastotasini moslashtirish',
			'settings.matchRefreshRateDescription' => 'Toʻliq ekranda ekran chastotasini moslashtirish',
			'settings.matchDynamicRange' => 'Dinamik diapazonni moslashtirish',
			'settings.matchDynamicRangeDescription' => 'HDR kontent uchun HDR-ni yoqish, soʻng SDR-ga qaytish',
			'settings.displaySwitchDelay' => 'Ekranni almashtirish kechikishi',
			'settings.tunneledPlayback' => 'Tunnelli ijro',
			'settings.tunneledPlaybackDescription' => 'Video tunnellashdan foydalanish. HDR ijrosida ekran qora boʻlsa, oʻchiring.',
			'settings.audioPassthrough' => 'Ovozni toʻgʻridan-toʻgʻri oʻtkazish (Passthrough)',
			'settings.audioPassthroughDescription' => 'Dolby/DTS ovozini qayta kodlamasdan resiver yoki televizoringizga yuboradi va atroflicha ovozni saqlaydi. Ovoz boʻlmasa, oʻchiring.',
			'settings.audioPassthroughDescriptionAppleTv' => 'Dolby Digital Plus uchun Apple dekoderidan foydalanish.',
			'settings.audioDownmix' => 'Stereoga oʻtkazish (Downmix)',
			'settings.audioDownmixDescription' => 'Koʻp kanalli ovozni stereo dinamiklar uchun ikki kanalga tushirish',
			'settings.downmixCenterBoost' => 'Markaziy kanalni kuchaytirish',
			'settings.downmixCenterBoostValue' => ({required Object db}) => '${db} dB',
			'settings.downmixCenterBoostLabel' => 'Kuchaytirish (dB)',
			'settings.downmixCenterBoostShort' => 'dB',
			'settings.audioDownmixNormalize' => 'Oʻtkazishda ovozni meʼyorlashtirish',
			'settings.audioDownmixNormalizeDescription' => 'Ovoz buzilishining oldini olish uchun darajani tushirish.',
			'settings.atmosDiagnostics' => 'Atmos chiqishini tekshirish',
			'settings.atmosDiagnosticsDescription' => 'Dolby Atmos chiqishini tekshirish',
			'settings.atmosTestHlsAtmos' => 'Apple Atmos oqimi',
			'settings.atmosTestHlsAtmosDescription' => 'Toʻgʻri ishlaydigan Dolby Atmos oqimi.',
			'settings.atmosTestHlsControl' => 'Apple atroflicha ovoz oqimi',
			'settings.atmosTestHlsControlDescription' => 'Atmos boʻlmagan nazorat oqimi.',
			'settings.atmosTestRawStream' => 'Ishlov berilmagan EAC3 oqimi',
			'settings.atmosTestRawStreamDescription' => 'Test faylini ichki Atmos sifatida uzatish.',
			'settings.atmosTestRawFile' => 'Ishlov berilmagan EAC3 fayli',
			'settings.atmosTestRawFileDescription' => 'Test faylini ijro etish.',
			'settings.atmosTestAsbarNative' => 'Sempl-bufer renderer (nativ)',
			'settings.atmosTestAsbarNativeDescription' => 'Faylning oʻzgartirilmagan siqilgan audiosini toʻgʻridan-toʻgʻri tizim rendereriga uzatadi. Test fayli URL-manzili kerak.',
			'settings.atmosTestAsbarGenerated' => 'Sempl-bufer renderer (qayta qurilgan)',
			'settings.atmosTestAsbarGeneratedDescription' => 'Xuddi shu, lekin audio tavsifi ijro paytida qanday qurilsa, shunday qayta quriladi. Test fayli URL-manzili kerak.',
			'settings.atmosTestSessionMode' => 'Film ijrosi seansi rejimidan foydalanish',
			'settings.atmosTestSessionModeDescription' => 'Oʻchirilgan holatda Dolby hujjatlashtirgan rejim qoʻllanadi. Yoqilgan holatda avval ishlatilgan rejim qoʻllanadi.',
			'settings.atmosTestShowRoutePicker' => 'AirPlay chiqishini tanlash',
			'settings.atmosTestHideRoutePicker' => 'AirPlay chiqishi tanlagichini yashirish',
			'settings.atmosTestRoutePickerDescription' => 'Testni AirPlay qabul qilgichiga yuboradi. Aniqlangan audio rejimi haqida faqat AirPlay xabar beradi.',
			'settings.atmosTestStop' => 'Testni toʻxtatish',
			'settings.atmosTestUrl' => 'Test fayli URL-manzili',
			'settings.atmosTestUrlDescription' => 'Ishlov berilmagan .ec3 faylining HTTP URL-manzili',
			'settings.atmosTestUrlMissing' => 'Avval test fayli URL-manzilini oʻrnating',
			'settings.atmosTestStatus' => 'Holati',
			'settings.dvConversionMode' => 'Dolby Vision oʻtkazmasi',
			'settings.dvConversionModeDescription' => 'ExoPlayer-ning Dolby Vision Profile 7 fayllarini qayta ishlash rejimini tanlang.',
			'settings.dvConversionAuto' => 'Avtomatik',
			'settings.dvConversionNative' => 'Ichki / Oʻchirilgan',
			'settings.dvConversionDv81' => 'P7 → P8.1',
			'settings.dvConversionHevcStrip' => 'P7 → HEVC',
			'settings.dvConversionAutoDescription' => 'Qurilma imkoniyatlaridan foydalanish',
			'settings.dvConversionNativeDescription' => 'Ichki DV7 rejimini majburlash',
			'settings.dvConversionDv81Description' => 'Dolby Vision profile 8.1 formatiga oʻtkazish',
			'settings.dvConversionHevcStripDescription' => 'Dolby Vision qatlamlarini olib tashlash va HEVC sifatida koʻrsatish',
			'settings.requireProfileSelectionOnOpen' => 'Ochilganda profilni soʻrash',
			'settings.requireProfileSelectionOnOpenDescription' => 'Ilova ochilgan har safar profilni tanlashni koʻrsatish',
			'settings.forceTvMode' => 'TV rejimini majburlash',
			'settings.forceTvModeDescription' => 'TV interfeysini majburiy yoqish.',
			'settings.autoHidePerformanceOverlay' => 'Unumdorlik panelini avto-yashirish',
			'settings.autoHidePerformanceOverlayDescription' => 'Unumdorlik panelini boshqaruv tugmalari bilan birga yashirish',
			'settings.showNavBarLabels' => 'Navigatsiya paneli matnlarini koʻrsatish',
			'settings.showNavBarLabelsDescription' => 'Navigatsiya belgilarining ostida matnni koʻrsatish',
			'settings.startupSection' => 'Boshlangʻich boʻlim',
			'settings.display' => 'Displey',
			'settings.homeScreen' => 'Bosh ekran',
			'settings.navigation' => 'Navigatsiya',
			'settings.content' => 'Kontent',
			'settings.player' => 'Pleyer',
			'settings.subtitlesAndConfig' => 'Subtitrlar va konfiguratsiya',
			'settings.seekAndTiming' => 'Oʻtkazish va vaqt sozlamalari',
			'settings.behavior' => 'Xatti-harakat',
			'search.hint' => 'Filmlar, seriallar, musiqa qidirish...',
			'search.tryDifferentTerm' => 'Boshqa qidiruv soʻzini kiriting',
			'search.searchYourMedia' => 'Medialaringizdan qidiring',
			'search.enterTitleActorOrKeyword' => 'Nomini, aktyorni yoki kalit soʻzni kiriting',
			'hotkeys.setShortcutFor' => ({required Object actionName}) => '${actionName} uchun tugmalar birlashmasini oʻrnatish',
			'hotkeys.clearShortcut' => 'Birlashmani tozalash',
			'hotkeys.noShortcutSet' => 'Tugmalar birlashmasi oʻrnatilmagan',
			'hotkeys.currentShortcut' => 'Joriy birlashma:',
			'hotkeys.pressToRecord' => 'Birlashmani yozib olish uchun bosing',
			'hotkeys.recordingShortcut' => 'Endi tugmalarni bosing',
			'hotkeys.actions.playPause' => 'Ijro/Pauza',
			'hotkeys.actions.volumeUp' => 'Ovozni balandlatish',
			'hotkeys.actions.volumeDown' => 'Ovozni pastlatish',
			'hotkeys.actions.seekForward' => ({required Object seconds}) => 'Oldinga oʻtkazish (${seconds}son)',
			'hotkeys.actions.seekBackward' => ({required Object seconds}) => 'Orqaga oʻtkazish (${seconds}son)',
			'hotkeys.actions.fullscreenToggle' => 'Toʻliq ekranga oʻtish/chiqish',
			'hotkeys.actions.muteToggle' => 'Ovozni oʻchirish/yoqish',
			'hotkeys.actions.subtitleToggle' => 'Subtitrni yoqish/oʻchirish',
			'hotkeys.actions.audioTrackNext' => 'Keyingi audio yoʻlak',
			'hotkeys.actions.subtitleTrackNext' => 'Keyingi subtitr yoʻlagi',
			'hotkeys.actions.chapterNext' => 'Keyingi boʻlim',
			'hotkeys.actions.chapterPrevious' => 'Oldingi boʻlim',
			'hotkeys.actions.episodeNext' => 'Keyingi qism',
			'hotkeys.actions.episodePrevious' => 'Oldingi qism',
			'hotkeys.actions.speedIncrease' => 'Tezlikni oshirish',
			'hotkeys.actions.speedDecrease' => 'Tezlikni kamaytirish',
			'hotkeys.actions.speedReset' => 'Tezlikni qayta oʻrnatish',
			'hotkeys.actions.zoomIn' => 'Yaqinlashtirish',
			'hotkeys.actions.zoomOut' => 'Uzoqlashtirish',
			'hotkeys.actions.zoomReset' => 'Masshtabni qayta oʻrnatish',
			'hotkeys.actions.subSeekNext' => 'Keyingi subtitrga oʻtish',
			'hotkeys.actions.subSeekPrev' => 'Oldingi subtitrga oʻtish',
			'hotkeys.actions.shaderToggle' => 'Sheyderlarni yoqish/oʻchirish',
			'hotkeys.actions.skipMarker' => 'Intro/Titrlarni oʻtkazib yuborish',
			'hotkeys.actions.screenshot' => 'Ekran tasvirini olish',
			'fileInfo.title' => 'Fayl haqida maʼlumot',
			'fileInfo.video' => 'Video',
			'fileInfo.audio' => 'Audio',
			'fileInfo.subtitles' => 'Subtitrlar',
			'fileInfo.file' => 'Fayl',
			'fileInfo.codec' => 'Kodek',
			'fileInfo.resolution' => 'Oʻlchamlari (Resolution)',
			'fileInfo.bitrate' => 'Bitreyt (Bitrate)',
			'fileInfo.frameRate' => 'Kadrlar chastotasi',
			'fileInfo.aspectRatio' => 'Tomonlar nisbati',
			'fileInfo.profile' => 'Profil',
			'fileInfo.bitDepth' => 'Bit chuqurligi',
			'fileInfo.colorSpace' => 'Rang makoni',
			'fileInfo.colorRange' => 'Rang diapazoni',
			'fileInfo.colorPrimaries' => 'Asosiy ranglar',
			'fileInfo.chromaSubsampling' => 'Rangli subdiskretlash',
			'fileInfo.channels' => 'Kanallar',
			'fileInfo.overallBitrate' => 'Umumiy bitreyt',
			'fileInfo.path' => 'Yoʻl',
			'fileInfo.size' => 'Hajmi',
			'fileInfo.container' => 'Konteyner',
			'fileInfo.duration' => 'Davomiyligi',
			'fileInfo.optimizedForStreaming' => 'Oqimli uzatish uchun optimallashtirilgan',
			'fileInfo.has64bitOffsets' => '64-bitli siljishlar',
			'mediaMenu.markAsWatched' => 'Koʻrilgan deb belgilash',
			'mediaMenu.markAsUnwatched' => 'Koʻrilmagan deb belgilash',
			'mediaMenu.viewDetails' => 'Batafsil koʻrish',
			'mediaMenu.goToSeries' => 'Serialga oʻtish',
			'mediaMenu.shufflePlay' => 'Aralashtirib ijro etish',
			'mediaMenu.shuffleNotAvailableOffline' => 'Aralashtirib ijro etish oflayn rejimda mavjud emas',
			'mediaMenu.fileInfo' => 'Fayl haqida maʼlumot',
			'mediaMenu.deleteFromServer' => 'Serverdan oʻchirish',
			'mediaMenu.confirmDelete' => 'Ushbu media va fayllar serverdan oʻchirilsinmi?',
			'mediaMenu.deleteMultipleWarning' => 'Bu barcha qismlar va fayllarga taʼsir qiladi.',
			'mediaMenu.mediaDeletedSuccessfully' => 'Media elementi muvaffaqiyatli oʻchirildi',
			'mediaMenu.mediaFailedToDelete' => 'Media elementini oʻchirib boʻlmadi',
			'mediaMenu.rate' => 'Baho berish',
			'mediaMenu.playFromBeginning' => 'Boshidan ijro etish',
			'mediaMenu.playVersion' => 'Versiyani ijro etish...',
			'rateSheet.server' => 'Server',
			'rateSheet.favorite' => 'Tanlangan',
			'rateSheet.favorited' => 'Tanlanganlarga qoʻshildi',
			'rateSheet.saved' => 'Saqlandi',
			'rateSheet.notAvailable' => 'Moslik topilmadi',
			'rateSheet.noConnectedServices' => 'Baho berish uchun Sozlamalardan xizmatni ulang.',
			'accessibility.mediaCardMovie' => ({required Object title}) => '${title}, film',
			'accessibility.mediaCardShow' => ({required Object title}) => '${title}, TV shou',
			'accessibility.mediaCardEpisode' => ({required Object title, required Object episodeInfo}) => '${title}, ${episodeInfo}',
			'accessibility.mediaCardSeason' => ({required Object title, required Object seasonInfo}) => '${title}, ${seasonInfo}',
			'accessibility.mediaCardWatched' => 'koʻrilgan',
			'accessibility.mediaCardPartiallyWatched' => ({required Object percent}) => '%${percent} koʻrilgan',
			'accessibility.mediaCardUnwatched' => 'koʻrilmagan',
			'accessibility.tapToPlay' => 'Ijro etish uchun bosing',
			'accessibility.decrease' => 'Kamaytirish',
			'accessibility.increase' => 'Oshirish',
			'accessibility.decreaseValue' => ({required Object label}) => '${label} qiymatini kamaytirish',
			'accessibility.increaseValue' => ({required Object label}) => '${label} qiymatini oshirish',
			'accessibility.hue' => 'Rang jilosi',
			'accessibility.saturation' => 'Toʻyinganlik',
			'accessibility.brightness' => 'Yorqinlik',
			'accessibility.hexColor' => 'Hex rangi',
			'accessibility.expandText' => 'Matnni yoyish',
			'accessibility.collapseText' => 'Matnni yigʻish',
			'accessibility.alphabetNavigation' => 'Alifboli navigatsiya',
			'accessibility.alphabetScrollHint' => 'Harflar boʻyicha oʻtish uchun yuqoriga yoki pastga suring',
			'accessibility.rowColumnPosition' => ({required Object row, required Object rowCount, required Object column, required Object columnCount}) => 'Qator ${row} / ${rowCount}, ustun ${column} / ${columnCount}',
			'accessibility.rowPosition' => ({required Object row, required Object rowCount}) => 'Qator ${row} / ${rowCount}',
			'tooltips.shufflePlay' => 'Aralashtirib ijro etish',
			'tooltips.playTrailer' => 'Treylerni koʻrish',
			'tooltips.markAsWatched' => 'Koʻrilgan deb belgilash',
			'tooltips.markAsUnwatched' => 'Koʻrilmagan deb belgilash',
			'audioTracks.track' => ({required Object n}) => 'Audio yoʻlak ${n}',
			'videoControls.audioLabel' => 'Ovoz',
			'videoControls.subtitlesLabel' => 'Subtitr',
			'videoControls.resetToZero' => '0ms-ga qaytarish',
			'videoControls.addTime' => ({required Object amount, required Object unit}) => '+${amount}${unit}',
			'videoControls.minusTime' => ({required Object amount, required Object unit}) => '-${amount}${unit}',
			'videoControls.playsLater' => ({required Object label}) => '${label} keyinroq ijro etiladi',
			'videoControls.playsEarlier' => ({required Object label}) => '${label} ilgariroq ijro etiladi',
			'videoControls.noOffset' => 'Siljishsiz',
			'videoControls.letterbox' => 'Keng ekran (Letterbox)',
			'videoControls.fillScreen' => 'Ekranni toʻldirish',
			'videoControls.stretch' => 'Choʻzish',
			'videoControls.lockRotation' => 'Aylanishni qulflash',
			'videoControls.unlockRotation' => 'Aylanish qulfini ochish',
			'videoControls.timerActive' => 'Taymer faol',
			'videoControls.playbackWillPauseIn' => ({required Object duration}) => 'Ijro ${duration}-dan keyin toʻxtatiladi',
			'videoControls.sleepTimerEndOfVideo' => 'Joriy videoning oxiri',
			'videoControls.sleepTimerStopAtHeader' => 'Toʻxtash vaqti',
			'videoControls.sleepTimerDurationHeader' => 'Taymer',
			'videoControls.playbackWillPauseAtEnd' => 'Ijro ushbu videoning oxirida toʻxtatiladi',
			'videoControls.stillWatching' => 'Hali ham tomosha qilyapsizmi?',
			'videoControls.pausingIn' => ({required Object seconds}) => '${seconds}son-dan keyin toʻxtatiladi',
			'videoControls.continueWatching' => 'Davom ettirish',
			'videoControls.autoPlayNext' => 'Keyingisini avtomatik ijro etish',
			'videoControls.playNext' => 'Keyingisini ijro etish',
			'videoControls.playButton' => 'Ijro etish',
			'videoControls.pauseButton' => 'Pauza',
			'videoControls.showPlaybackControls' => 'Boshqaruv tugmalarini koʻrsatish',
			'videoControls.hidePlaybackControls' => 'Boshqaruv tugmalarini yashirish',
			'videoControls.seekBackwardButton' => ({required Object seconds}) => '${seconds} soniya orqaga oʻtkazish',
			'videoControls.seekForwardButton' => ({required Object seconds}) => '${seconds} soniya oldinga oʻtkazish',
			'videoControls.previousButton' => 'Oldingi qism',
			'videoControls.nextButton' => 'Keyingi qism',
			'videoControls.previousChapterButton' => 'Oldingi boʻlimcha',
			'videoControls.nextChapterButton' => 'Keyingi boʻlimcha',
			'videoControls.muteButton' => 'Ovozni oʻchirish',
			'videoControls.unmuteButton' => 'Ovozni yoqish',
			'videoControls.settingsButton' => 'Ijro sozlamalari',
			'videoControls.tracksButton' => 'Ovoz va subtitrlar',
			'videoControls.chaptersButton' => 'Boʻlimlar',
			'videoControls.versionQualityButton' => 'Versiya va sifat',
			'videoControls.versionColumnHeader' => 'Versiya',
			'videoControls.qualityColumnHeader' => 'Sifat',
			'videoControls.qualityOriginal' => 'Asl nusxa',
			'videoControls.qualityPresetLabel' => ({required Object resolution, required Object bitrate}) => '${resolution}p ${bitrate} Mbps',
			'videoControls.transcodeUnavailableFallback' => 'Qayta kodlash mavjud emas — asl sifatda ijro etiladi',
			'videoControls.subtitleUnavailableFallback' => 'Tanlangan subtitr yuklanmadi',
			'videoControls.pipButton' => 'Rasm ichida rasm rejimi',
			'videoControls.aspectRatioButton' => 'Tomonlar nisbati',
			'videoControls.ambientLighting' => 'Atrof-muhit yoritilishi',
			'videoControls.rotationLockButton' => 'Aylanish qulfi',
			'videoControls.lockScreen' => 'Ekranni qulflash',
			'videoControls.screenLockButton' => 'Ekran qulfi',
			'videoControls.longPressToUnlock' => 'Qulfdan chiqarish uchun bosib turing',
			'videoControls.timelineSlider' => 'Video vaqt shkalasi',
			'videoControls.volumeSlider' => 'Ovoz balandligi',
			'videoControls.endsAt' => ({required Object time}) => 'Tugash vaqti: ${time}',
			'videoControls.pipActive' => 'Rasm ichida rasm rejimida ijro etilmoqda',
			'videoControls.pipFailed' => 'PiP rejimini ishga tushirishda xatolik',
			'videoControls.screenshotSaved' => 'Ekran tasviri saqlandi',
			'videoControls.zoomPercent' => ({required Object percent}) => 'Masshtab %${percent}',
			'videoControls.pipErrors.androidVersion' => 'Android 8.0 yoki undan yangisi talab qilinadi',
			'videoControls.pipErrors.iosVersion' => 'iOS 15.0 yoki undan yangisi talab qilinadi',
			'videoControls.pipErrors.permissionDisabled' => 'PiP rejimi oʻchirilgan. Tizim sozlamalaridan yoqing.',
			'videoControls.pipErrors.notSupported' => 'Qurilma PiP rejimini qoʻllab-quvvatlamaydi',
			'videoControls.pipErrors.voSwitchFailed' => 'PiP uchun video chiqishini almashtirib boʻlmadi',
			'videoControls.pipErrors.failed' => 'PiP rejimini ishga tushirishda xatolik',
			'videoControls.pipErrors.unknown' => ({required Object error}) => 'Xatolik yuz berdi: ${error}',
			'videoControls.chapters' => 'Boʻlimlar',
			'videoControls.noChaptersAvailable' => 'Boʻlimlar mavjud emas',
			'videoControls.queue' => 'Navbat',
			'videoControls.noQueueItems' => 'Navbatda elementlar yoʻq',
			'messages.markedAsWatched' => 'Koʻrilgan deb belgilandi',
			'messages.markedAsUnwatched' => 'Koʻrilmagan deb belgilandi',
			'messages.markedAsWatchedOffline' => 'Koʻrilgan deb belgilandi (tarmoqqa ulanganda sinxronlanadi)',
			'messages.markedAsUnwatchedOffline' => 'Koʻrilmagan deb belgilandi (tarmoqqa ulanganda sinxronlanadi)',
			'messages.autoRemovedWatchedDownload' => ({required Object title}) => 'Avtomatik oʻchirildi: ${title}',
			'messages.autoRemovedWatchedDownloads' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uz'))(n, one: 'Koʻrilgan ${n} yuklama avtomatik oʻchirildi', other: 'Koʻrilgan ${n} yuklama avtomatik oʻchirildi', ), 
			'messages.errorLoading' => ({required Object error}) => 'Xatolik: ${error}',
			'messages.searchPartialResults' => 'Baʼzi media serverlarda qidiruv amalga oshmadi. Mavjud natijalar koʻrsatilmoqda.',
			'messages.streamInterrupted' => 'Oqim uzildi. Qayta urinish uchun ijro tugmasini bosing.',
			'messages.fileInfoNotAvailable' => 'Fayl haqida maʼlumot mavjud emas',
			'messages.playbackAuthenticationRequired' => 'Ushbu elementni ijro etish uchun serverga qaytadan kiring.',
			'messages.playbackServerUnavailable' => 'Media serveri mavjud emas. Keyinroq qaytadan urinib koʻring.',
			'messages.playbackDataInvalid' => 'Server notoʻgʻri ijro maʼlumotlarini qaytardi.',
			'messages.playbackCancelled' => 'Ijro bekor qilindi.',
			'messages.playbackFailed' => 'Ijroni ishga tushirishda xatolik.',
			'messages.errorLoadingFileInfo' => ({required Object error}) => 'Fayl maʼlumotlarini yuklashda xatolik: ${error}',
			'messages.errorLoadingSeries' => 'Serialni yuklashda xatolik',
			'messages.musicNotSupported' => 'Musiqa ijrosi hali qoʻllab-quvvatlanmaydi',
			'messages.noDescriptionAvailable' => 'Tavsif mavjud emas',
			'messages.noProfilesAvailable' => 'Profillar yoʻq',
			'messages.contactAdminForProfiles' => 'Profil qoʻshish uchun administratorga murojaat qiling',
			'messages.unableToDetermineLibrarySection' => 'Kutubxona boʻlimini aniqlab boʻlmadi',
			'messages.logsCleared' => 'Jurnallar tozalandi',
			'messages.logsCopied' => 'Jurnallar nusxalandi',
			'messages.noLogsAvailable' => 'Jurnallar yoʻq',
			'messages.metadataRefreshing' => ({required Object title}) => '"${title}" uchun metamaʼlumotlar yangilanmoqda...',
			'messages.metadataRefreshStarted' => ({required Object title}) => '"${title}" uchun metamaʼlumotlarni yangilash boshlandi',
			'messages.metadataRefreshFailed' => ({required Object error}) => 'Metamaʼlumotlarni yangilab boʻlmadi: ${error}',
			'messages.logoutConfirm' => 'Haqiqatan ham chiqmoqchimisiz?',
			'messages.noSeasonsFound' => 'Mavsumlar topilmadi',
			'messages.seasonsLoadFailed' => 'Mavsumlarni yuklab boʻlmadi',
			'messages.noEpisodesFound' => 'Birinchi mavsumda qismlar topilmadi',
			'messages.noEpisodesFoundGeneral' => 'Qismlar topilmadi',
			'messages.episodesLoadFailed' => 'Qismlarni yuklab boʻlmadi',
			'messages.noResultsFound' => 'Natijalar topilmadi',
			'messages.sleepTimerSet' => ({required Object label}) => 'Uyqu taymeri ${label} vaqtiga oʻrnatildi',
			'messages.noItemsAvailable' => 'Elementlar yoʻq',
			'messages.failedToCreatePlayQueueNoItems' => 'Ijro navbatini yaratib boʻlmadi — elementlar yoʻq',
			'messages.failedPlayback' => ({required Object action, required Object error}) => '${action} muvaffaqiyatsiz tugadi: ${error}',
			'messages.switchingToCompatiblePlayer' => 'Mos keluvchi pleyerga oʻtilmoqda...',
			'messages.serverLimitTitle' => 'Ijro etishda xatolik',
			'messages.serverLimitBody' => 'Server xatoligi (HTTP 500). Cheklov ushbu seansni rad etdi.',
			'subtitlingStyling.text' => 'Matn',
			'subtitlingStyling.border' => 'Hoshiya',
			'subtitlingStyling.background' => 'Fon',
			'subtitlingStyling.fontSize' => 'Shrift oʻlchami',
			'subtitlingStyling.textColor' => 'Matn rangi',
			'subtitlingStyling.borderSize' => 'Hoshiya oʻlchami',
			'subtitlingStyling.borderColor' => 'Hoshiya rangi',
			'subtitlingStyling.backgroundOpacity' => 'Fon shaffofligi',
			'subtitlingStyling.backgroundColor' => 'Fon rangi',
			_ => null,
		} ?? switch (path) {
			'subtitlingStyling.position' => 'Joylashuvi',
			'subtitlingStyling.assOverride' => 'ASS qayta aniqlash',
			'subtitlingStyling.overrideScale' => 'Masshtablash',
			'subtitlingStyling.overrideForce' => 'Majburlash',
			'subtitlingStyling.overrideStrip' => 'Formatlashni olib tashlash',
			'subtitlingStyling.positionTop' => 'Yuqori',
			'subtitlingStyling.positionBottom' => 'Pastki',
			'subtitlingStyling.bold' => 'Qalin',
			'subtitlingStyling.italic' => 'Qiya',
			'subtitlingStyling.renderResolution' => 'Renderlash oʻlchamlari',
			'subtitlingStyling.renderResolutionScreen' => 'Ekran oʻlchamlari',
			'subtitlingStyling.renderResolutionVideo' => 'Video oʻlchamlari',
			'mpvConfig.title' => 'mpv.conf',
			'mpvConfig.description' => 'Kengaytirilgan video pleyer sozlamalari',
			'mpvConfig.presets' => 'Tayyor sozlamalar',
			'mpvConfig.noPresets' => 'Saqlangan sozlamalar yoʻq',
			'mpvConfig.saveAsPreset' => 'Sozlama sifatida saqlash...',
			'mpvConfig.presetName' => 'Sozlama nomi',
			'mpvConfig.presetNameHint' => 'Ushbu sozlama uchun nom kiriting',
			'mpvConfig.loadPreset' => 'Yuklash',
			'mpvConfig.deletePreset' => 'Oʻchirish',
			'mpvConfig.presetSaved' => 'Sozlama saqlandi',
			'mpvConfig.presetLoaded' => 'Sozlama yuklandi',
			'mpvConfig.presetDeleted' => 'Sozlama oʻchirildi',
			'mpvConfig.confirmDeletePreset' => 'Ushbu sozlamani oʻchirishga ishonchingiz komilmi?',
			'mpvConfig.configPlaceholder' => 'gpu-api=vulkan\nhwdec=auto\n# izoh',
			'dialog.confirmAction' => 'Harakatni tasdiqlash',
			'profiles.addLocalProfile' => 'Harbor profilini qoʻshish',
			'profiles.switchingProfile' => 'Profil almashtirilmoqda…',
			'profiles.deleteThisProfileTitle' => 'Ushbu profil oʻchirilsinmi?',
			'profiles.deleteThisProfileMessage' => ({required Object displayName}) => '${displayName} oʻchiriladi. Ulanishlarga taʼsir qilmaydi.',
			'profiles.active' => 'Faol',
			'profiles.manage' => 'Boshqarish',
			'profiles.delete' => 'Oʻchirish',
			'profiles.sectionTitle' => 'Profillar',
			'profiles.summarySingle' => 'Boshqariladigan foydalanuvchilarni birlashtirish uchun profillar qoʻshing',
			'profiles.summaryMultipleWithActive' => ({required Object count, required Object activeName}) => '${count} profil · faol: ${activeName}',
			'profiles.summaryMultiple' => ({required Object count}) => '${count} profil',
			'profiles.removeConnectionTitle' => 'Ulanish oʻchirilsinmi?',
			'profiles.removeConnectionMessage' => ({required Object displayName, required Object connectionLabel}) => '${displayName} foydalanuvchisining ${connectionLabel} kirish huquqi oʻchiriladi.',
			'profiles.deleteProfileTitle' => 'Profil oʻchirilsinmi?',
			'profiles.deleteProfileMessage' => ({required Object displayName}) => '${displayName} va uning ulanishlari oʻchiriladi.',
			'profiles.profileNameLabel' => 'Profil nomi',
			'profiles.pinProtectionLabel' => 'PIN himoyasi',
			'profiles.setPin' => 'PIN oʻrnatish',
			'profiles.setPinTitle' => 'PIN oʻrnatish',
			'profiles.confirmPinTitle' => 'PIN kodni tasdiqlash',
			'profiles.pinSet' => 'PIN oʻrnatildi',
			'profiles.changePin' => 'Oʻzgartirish',
			'profiles.removePin' => 'Oʻchirish',
			'profiles.connectionsLabel' => 'Ulanishlar',
			'profiles.add' => 'Qoʻshish',
			'profiles.deleteProfileButton' => 'Profilni oʻchirish',
			'profiles.noConnectionsHint' => 'Ulanishlar yoʻq — ushbu profildan foydalanish uchun ulanish qoʻshing.',
			'profiles.noConnections' => 'Ulanishlar yoʻq',
			'profiles.connectionDefault' => 'Standart',
			'profiles.makeDefault' => 'Standart qilish',
			'profiles.removeConnection' => 'Oʻchirish',
			'profiles.profileRenamed' => 'Profil nomi oʻzgartirildi.',
			'profiles.borrowAddTo' => ({required Object displayName}) => '${displayName} profiliga qoʻshish',
			'profiles.borrowExplain' => 'Boshqa profilning ulanishidan foydalaning.',
			'profiles.borrowEmpty' => 'Hali foydalanadigan hech narsa yoʻq.',
			'profiles.borrowEmptySubtitle' => 'Avval boshqa profilga Plex yoki Jellyfin ulang.',
			'profiles.borrowLoadFailed' => 'Mavjud ulanishlarni yuklab boʻlmadi.',
			'profiles.borrowFromProfile' => ({required Object displayName}) => '${displayName} profilidan',
			'profiles.borrowConnectionBorrowed' => 'Ulanishdan foydalanildi.',
			'profiles.borrowFailed' => 'Ulanishdan foydalanib boʻlmadi.',
			'profiles.incorrectPin' => 'Notoʻgʻri PIN kod.',
			'profiles.incorrectPinTryAgain' => 'Notoʻgʻri PIN kod. Qaytadan urinib koʻring.',
			'profiles.newProfile' => 'Yangi profil',
			'profiles.profileNameHint' => 'masalan, Mehmonlar, Bolalar',
			'profiles.pinProtectionOptional' => 'PIN himoyasi (ixtiyoriy)',
			'profiles.pinExplain' => 'Profillar orasida oʻtish uchun 4 xonali PIN kod talab qilinadi.',
			'profiles.continueButton' => 'Davom ettirish',
			'profiles.pinsDontMatch' => 'PIN kodlar mos kelmadi',
			'connections.sectionTitle' => 'Ulanishlar',
			'connections.addConnection' => 'Ulanish qoʻshish',
			'connections.addConnectionSubtitleNoProfile' => 'Plex orqali kiring yoki Jellyfin serveriga ulaning',
			'connections.addConnectionSubtitleScoped' => ({required Object displayName}) => '${displayName} profiliga qoʻshish',
			'connections.sessionExpiredOne' => ({required Object name}) => '${name} uchun seans vaqti tugadi',
			'connections.sessionExpiredMany' => ({required Object count}) => '${count} server uchun seans vaqti tugadi',
			'connections.signInAgain' => 'Qaytadan kirish',
			'connections.editJellyfinTitle' => 'Jellyfin ulanishini tahrirlash',
			'connections.editJellyfinIntro' => ({required Object serverName}) => '${serverName} uchun URL manzilini qoʻshing yoki oʻchiring.',
			'discover.title' => 'Kashf qilish',
			'discover.noContentAvailable' => 'Kontent mavjud emas',
			'discover.addMediaToLibraries' => 'Kutubxonalaringizga media qoʻshing',
			'discover.continueWatching' => 'Tomoshani davom ettirish',
			'discover.continueWatchingIn' => ({required Object library}) => '${library} ichida tomoshani davom ettirish',
			'discover.nextUpIn' => ({required Object library}) => '${library} ichida navbatda',
			'discover.recentlyAddedIn' => ({required Object library}) => '${library} ichida yaqinda qoʻshilganlar',
			'discover.latestAlbumsIn' => ({required Object library}) => '${library} ichida soʻnggi albomlar',
			'discover.recentlyPlayedIn' => ({required Object library}) => '${library} ichida yaqinda eshitilganlar',
			'discover.mostPlayedIn' => ({required Object library}) => '${library} ichida eng koʻp eshitilganlar',
			'discover.playEpisode' => ({required Object season, required Object episode}) => 'M${season}Q${episode}',
			'discover.cast' => 'Aktyorlar',
			'discover.extras' => 'Treylerlar va qoʻshimchalar',
			'discover.studio' => 'Studiya',
			'discover.director' => 'Rejissyor',
			'discover.directors' => 'Rejissyorlar',
			'discover.movie' => 'Film',
			'discover.tvShow' => 'TV Shou',
			'discover.minutesLeft' => ({required Object minutes}) => '${minutes} daq qoldi',
			'discover.moreLikeThis' => 'Oʻxshashlar',
			'errors.searchFailed' => ({required Object error}) => 'Qidiruv xatoligi: ${error}',
			'errors.searchUnavailable' => 'Qidiruv hech bir media serverga ulana olmadi.',
			'errors.connectionTimeout' => ({required Object context}) => '${context} yuklanish vaqti tugadi',
			'errors.connectionFailed' => 'Media serveriga ulanib boʻlmadi',
			'errors.unableToLoad' => ({required Object context}) => '${context} yuklab boʻlmadi.',
			'errors.noClientAvailable' => 'Mavjud mijoz yoʻq',
			'errors.failedToSwitchProfile' => ({required Object displayName}) => '${displayName} profiliga oʻtib boʻlmadi',
			'errors.failedToDeleteProfile' => ({required Object displayName}) => '${displayName} profilini oʻchirib boʻlmadi',
			'errors.failedToRate' => 'Reytingni yangilab boʻlmadi',
			'libraries.title' => 'Kutubxonalar',
			'libraries.fallbackTitle' => 'Kutubxona',
			'libraries.refreshMetadata' => 'Metamaʼlumotlarni yangilash',
			'libraries.noLibrariesFound' => 'Kutubxonalar topilmadi',
			'libraries.allLibrariesHidden' => 'Barcha kutubxonalar yashirilgan',
			'libraries.hiddenLibrariesCount' => ({required Object count}) => 'Yashirin kutubxonalar (${count})',
			'libraries.thisLibraryIsEmpty' => 'Ushbu kutubxona boʻsh',
			'libraries.noItemsMatchFilters' => 'Filtrlarga mos keladigan elementlar topilmadi',
			'libraries.resetFilters' => 'Filtrlarni qayta oʻrnatish',
			'libraries.all' => 'Barchasi',
			'libraries.clearAll' => 'Barchasini tozalash',
			'libraries.refreshMetadataConfirm' => ({required Object title}) => '"${title}" metamaʼlumotlarini yangilaysizmi?',
			'libraries.manageLibraries' => 'Kutubxonalarni boshqarish',
			'libraries.sort' => 'Saralash',
			'libraries.sortBy' => 'Saralash mezonlari',
			'libraries.filters' => 'Filtrlar',
			'libraries.confirmActionMessage' => 'Ushbu harakatni bajarmoqchimisiz?',
			'libraries.showLibrary' => 'Kutubxonani koʻrsatish',
			'libraries.hideLibrary' => 'Kutubxonani yashirish',
			'libraries.libraryOptions' => 'Kutubxona parametrlari',
			'libraries.content' => 'kutubxona tarkibi',
			'libraries.selectLibrary' => 'Kutubxonani tanlash',
			'libraries.filtersWithCount' => ({required Object count}) => 'Filtrlar (${count})',
			'libraries.noCollections' => 'Ushbu kutubxonada toʻplamlar yoʻq',
			'libraries.noFoldersFound' => 'Jildlar topilmadi',
			'libraries.folders' => 'jildlar',
			'libraries.groupings.title' => 'Guruhlash',
			'libraries.groupings.all' => 'Barchasi',
			'libraries.groupings.movies' => 'Filmlar',
			'libraries.groupings.shows' => 'TV Shoular',
			'libraries.groupings.seasons' => 'Mavsumlar',
			'libraries.groupings.episodes' => 'Qismlar',
			'libraries.groupings.artists' => 'Ijrochilar',
			'libraries.groupings.albums' => 'Albomlar',
			'libraries.groupings.tracks' => 'Taronalar',
			'libraries.groupings.folders' => 'Jildlar',
			'libraries.filterCategories.genre' => 'Janr',
			'libraries.filterCategories.year' => 'Yil',
			'libraries.filterCategories.contentRating' => 'Kontent reytingi',
			'libraries.filterCategories.tag' => 'Teg',
			'libraries.filterCategories.unwatched' => 'Koʻrilmagan',
			'libraries.filterCategories.unplayed' => 'Eshitilmagan',
			'libraries.filterCategories.favorites' => 'Tanlanganlar',
			'libraries.sortLabels.title' => 'Nomi',
			'libraries.sortLabels.dateAdded' => 'Qoʻshilgan sanasi',
			'libraries.sortLabels.communityRating' => 'Hamjamiyat reytingi',
			'libraries.sortLabels.criticRating' => 'Muntaqidlar reytingi',
			'libraries.sortLabels.datePlayed' => 'Ijro etilgan sanasi',
			'libraries.sortLabels.playCount' => 'Ijrolar soni',
			'libraries.sortLabels.productionYear' => 'Ishlab chiqarilgan yili',
			'libraries.sortLabels.runtime' => 'Davomiyligi',
			'libraries.sortLabels.officialRating' => 'Rasmiy reyting',
			'libraries.sortLabels.premiereDate' => 'Premyera sanasi',
			'libraries.sortLabels.startDate' => 'Boshlangan sanasi',
			'libraries.sortLabels.airTime' => 'Efir vaqti',
			'libraries.sortLabels.studio' => 'Studiya',
			'libraries.sortLabels.random' => 'Tasodifiy',
			'libraries.sortLabels.lastEpisodeDateAdded' => 'Soʻnggi qoʻshilgan qism sanasi',
			'about.title' => 'Dastur haqida',
			'about.openSourceLicenses' => 'Ochiq kodli litsenziyalar',
			'about.versionLabel' => ({required Object version}) => 'Versiya ${version}',
			'about.appDescription' => 'Flutter asosidagi qulay Plex va Jellyfin mijozi',
			'about.viewLicensesDescription' => 'Uchinchi tomon kutubxonalarining litsenziyalarini koʻrish',
			'hubDetail.title' => 'Nomi',
			'hubDetail.releaseYear' => 'Chiqqan yili',
			'hubDetail.dateAdded' => 'Qoʻshilgan sanasi',
			'hubDetail.rating' => 'Reyting',
			'hubDetail.noItemsFound' => 'Elementlar topilmadi',
			'logs.clearLogs' => 'Jurnallarni tozalash',
			'logs.copyLogs' => 'Jurnallarni nusxalash',
			'licenses.relatedPackages' => 'Bogʻliq paketlar',
			'licenses.license' => 'Litsenziya',
			'licenses.licenseNumber' => ({required Object number}) => 'Litsenziya ${number}',
			'licenses.licensesCount' => ({required Object count}) => '${count} litsenziya',
			'navigation.libraries' => 'Kutubxonalar',
			'navigation.downloads' => 'Yuklamalar',
			'navigation.explore' => 'Kashf qilish',
			'explore.title' => 'Kashf qilish',
			'explore.selectSource' => 'Manbani tanlang',
			'explore.rows.watchlist' => 'Tomosha roʻyxati',
			'explore.rows.recommendedMovies' => 'Tavsiya etilgan filmlar',
			'explore.rows.recommendedShows' => 'Tavsiya etilgan seriallar',
			'explore.rows.trendingMovies' => 'Ommabop filmlar',
			'explore.rows.trendingShows' => 'Ommabop seriallar',
			'explore.rows.popularMovies' => 'Mashhur filmlar',
			'explore.rows.popularShows' => 'Mashhur seriallar',
			'explore.rows.trendingAnime' => 'Ommabop anime',
			'explore.rows.suggestedAnime' => 'Tavsiya etilgan anime',
			'explore.rows.airingAnime' => 'Efirga uzatilayotgan eng yaxshi anime',
			'explore.rows.popularAnime' => 'Eng mashhur anime',
			'explore.rows.trending' => 'Ommaboplar',
			'explore.rows.upcomingMovies' => 'Kutilayotgan filmlar',
			'explore.rows.upcomingShows' => 'Kutilayotgan seriallar',
			'explore.status.airing' => 'Efirda',
			'explore.status.ended' => 'Tugallandi',
			'explore.status.canceled' => 'Bekor qilindi',
			'explore.status.upcoming' => 'Kutilmoqda',
			'explore.episodeCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uz'))(n, one: '${n} qism', other: '${n} qism', ), 
			'explore.cast' => 'Aktyorlar',
			'explore.characters' => 'Qahramonlar',
			'explore.addToWatchlist' => 'Tomosha roʻyxatiga qoʻshish',
			'explore.removeFromWatchlist' => 'Tomosha roʻyxatidan oʻchirish',
			'explore.watchlistUpdateFailed' => 'Tomosha roʻyxatini yangilab boʻlmadi',
			'explore.notInLibrary' => 'Kutubxonangizda yoʻq',
			'explore.inTheseLibraries' => 'Ushbu kutubxonalarda bor',
			'explore.checkingLibrary' => 'Kutubxona tekshirilmoqda...',
			'explore.emptyTitle' => 'Hali bu yerda hech narsa yoʻq',
			'explore.emptyMessage' => ({required Object source}) => '${source} manbasidan olingan qatorlar bu yerda koʻrinadi.',
			'explore.searchHint' => ({required Object source}) => '${source} ichidan qidirish',
			'explore.searchEmpty' => ({required Object query}) => '"${query}" boʻyicha natija topilmadi',
			'explore.searchPrompt' => ({required Object source}) => '${source} orqali filmlar va seriallarni qidiring.',
			'explore.searchFailed' => 'Qidiruv xatoligi. Ulanishni tekshiring.',
			'collections.collection' => 'Toʻplam',
			'collections.empty' => 'Toʻplam boʻsh',
			'collections.deleteCollection' => 'Toʻplamni oʻchirish',
			'collections.deleteConfirm' => ({required Object title}) => '"${title}" oʻchirilsinmi?',
			'collections.deleted' => 'Toʻplam oʻchirildi',
			'collections.deleteFailed' => 'Toʻplamni oʻchirib boʻlmadi',
			'collections.deleteFailedWithError' => ({required Object error}) => 'Toʻplamni oʻchirish xatoligi: ${error}',
			'collections.selectCollection' => 'Toʻplamni tanlash',
			'collections.collectionName' => 'Toʻplam nomi',
			'collections.enterCollectionName' => 'Toʻplam nomini kiriting',
			'collections.addedToCollection' => 'Toʻplamga qoʻshildi',
			'collections.errorAddingToCollection' => 'Toʻplamga qoʻshib boʻlmadi',
			'collections.created' => 'Toʻplam yaratildi',
			'collections.removeFromCollection' => 'Toʻplamdan oʻchirish',
			'collections.removeFromCollectionConfirm' => ({required Object title}) => '"${title}" ushbu toʻplamdan oʻchirilsinmi?',
			'collections.removedFromCollection' => 'Toʻplamdan oʻchirildi',
			'collections.removeFromCollectionFailed' => 'Toʻplamdan oʻchirib boʻlmadi',
			'collections.removeFromCollectionError' => ({required Object error}) => 'Oʻchirish xatoligi: ${error}',
			'collections.searchCollections' => 'Toʻplamlardan qidirish...',
			'playlists.playlist' => 'Ijro roʻyxati',
			'playlists.noPlaylists' => 'Ijro roʻyxatlari topilmadi',
			'playlists.create' => 'Ijro roʻyxatini yaratish',
			'playlists.playlistName' => 'Ijro roʻyxati nomi',
			'playlists.enterPlaylistName' => 'Roʻyxat nomini kiriting',
			'playlists.delete' => 'Ijro roʻyxatini oʻchirish',
			'playlists.removeItem' => 'Roʻyxatdan oʻchirish',
			'playlists.smartPlaylist' => 'Aqlli ijro roʻyxati',
			'playlists.itemCount' => ({required Object count}) => '${count} element',
			'playlists.oneItem' => '1 element',
			'playlists.emptyPlaylist' => 'Ushbu roʻyxat boʻsh',
			'playlists.deleteConfirm' => 'Ijro roʻyxati oʻchirilsinmi?',
			'playlists.deleteMessage' => ({required Object name}) => '"${name}" oʻchirilsinmi?',
			'playlists.created' => 'Ijro roʻyxati yaratildi',
			'playlists.deleted' => 'Ijro roʻyxati oʻchirildi',
			'playlists.itemAdded' => 'Roʻyxatga qoʻshildi',
			'playlists.itemRemoved' => 'Roʻyxatdan oʻchirildi',
			'playlists.selectPlaylist' => 'Roʻyxatni tanlash',
			'playlists.searchPlaylists' => 'Ijro roʻyxatlaridan qidirish...',
			'playlists.errorCreating' => 'Roʻyxatni yaratib boʻlmadi',
			'playlists.errorDeleting' => 'Roʻyxatni oʻchirib boʻlmadi',
			'playlists.errorLoading' => 'Roʻyxatlarni yuklab boʻlmadi',
			'playlists.errorAdding' => 'Roʻyxatga qoʻshib boʻlmadi',
			'playlists.errorReordering' => 'Qayta tartiblab boʻlmadi',
			'playlists.errorRemoving' => 'Roʻyxatdan oʻchirib boʻlmadi',
			'music.goToAlbum' => 'Albomga oʻtish',
			'music.goToArtist' => 'Ijrochiga oʻtish',
			'music.instantMix' => 'Tezkor miks',
			'music.playNext' => 'Keyingisini ijro etish',
			'music.addToQueue' => 'Navbatga qoʻshish',
			'music.discNumber' => ({required Object n}) => '${n}-disk',
			'music.trackCount' => ({required num n}) => (_root.$meta.cardinalResolver ?? PluralResolvers.cardinal('uz'))(n, one: '${n} tarona', other: '${n} tarona', ), 
			'music.nowPlaying' => 'Hozir ijro etilmoqda',
			'music.playingFrom' => ({required Object title}) => '${title} manbasidan',
			'music.queue' => 'Navbat',
			'music.clearQueue' => 'Navbatni tozalash',
			'music.lyrics' => 'Musiqa matni',
			'music.noLyrics' => 'Musiqa matni yoʻq',
			'music.sleepTimer' => 'Uyqu taymeri',
			'music.sleepTimerEndOfTrack' => 'Taronaning oxiri',
			'music.sleepTimerMinutes' => ({required Object n}) => '${n} daqiqa',
			'music.stopPlayback' => 'Ijroni toʻxtatish',
			'music.previousTrack' => 'Oldingi tarona',
			'music.nextTrack' => 'Keyingi tarona',
			'music.repeat' => 'Takrorlash',
			'music.repeatAll' => 'Barchasini takrorlash',
			'music.repeatOne' => 'Birtasini takrorlash',
			'downloads.title' => 'Yuklamalar',
			'downloads.manage' => 'Boshqarish',
			'downloads.tvShows' => 'TV Shoular',
			'downloads.movies' => 'Filmlar',
			'downloads.music' => 'Musiqa',
			'downloads.tracksQueued' => ({required Object count}) => '${count} tarona yuklash navbatiga qoʻshildi',
			'downloads.noDownloads' => 'Hali yuklamalar yoʻq',
			'downloads.noDownloadsDescription' => 'Yuklangan fayllar oflayn koʻrish uchun bu yerda koʻrinadi',
			'downloads.downloadNow' => 'Yuklab olish',
			'downloads.deleteDownload' => 'Yuklamani oʻchirish',
			'downloads.retryDownload' => 'Yuklashni qaytadan urinish',
			'downloads.downloadQueued' => 'Yuklash navbatga qoʻyildi',
			'downloads.downloadResumed' => 'Yuklash davom ettirildi',
			'downloads.serverErrorBitrate' => 'Server xatoligi: fayl tezlik cheklovidan oshgan boʻlishi mumkin',
			'downloads.storageFull' => 'Xotira toʻlganligi sababli yuklash toʻxtatildi.',
			'downloads.episodesQueued' => ({required Object count}) => '${count} qism yuklash navbatiga qoʻshildi',
			'downloads.downloadDeleted' => 'Yuklama oʻchirildi',
			'downloads.deleteConfirm' => ({required Object title}) => '"${title}" ushbu qurilmadan oʻchirilsinmi?',
			'downloads.cancelledDownloadTitle' => 'Toʻxtatilgan yuklama',
			'downloads.cancelledDownloadMessage' => 'Ushbu yuklash toʻxtatildi.',
			'downloads.allEpisodesAlreadyDownloaded' => 'Barcha qismlar avvaldan yuklab olingan',
			'downloads.resumeDownload' => 'Yuklashni davom ettirish',
			'downloads.cancelledDownload' => 'Toʻxtatilgan yuklama',
			'downloads.syncingFile' => ({required Object file, required Object status}) => '${file} (${status} sinxronlanmoqda)',
			'downloads.downloadedFileClickToComplete' => ({required Object file}) => 'Yuklab olindi ${file} - Yakunlash uchun bosing',
			'downloads.partialDownloadClickToComplete' => 'Qisman yuklandi - Yakunlash uchun bosing',
			'downloads.deleting' => 'Oʻchirilmoqda...',
			'downloads.deletingWithProgress' => ({required Object title, required Object current, required Object total}) => '${title} oʻchirilmoqda... (${current} / ${total})',
			'downloads.queuedTooltip' => 'Navbatda',
			'downloads.queuedFilesTooltip' => ({required Object files}) => 'Navbatdagi fayllar: ${files}',
			'downloads.downloadingTooltip' => 'Yuklanmoqda...',
			'downloads.downloadingFilesTooltip' => ({required Object files}) => 'Yuklanayotgan fayllar: ${files}',
			'downloads.noDownloadsTree' => 'Yuklamalar yoʻq',
			'downloads.pauseAll' => 'Barchasini toʻxtatib turish',
			'downloads.resumeAll' => 'Barchasini davom ettirish',
			'downloads.deleteAll' => 'Barchasini oʻchirish',
			'downloads.selectVersion' => 'Versiyani tanlash',
			'downloads.allEpisodes' => 'Barcha qismlar',
			'downloads.unwatchedOnly' => 'Faqat koʻrilmaganlar',
			'downloads.nextNUnwatched' => ({required Object count}) => 'Keyingi ${count} koʻrilmagan',
			'downloads.customAmount' => 'Boshqa miqdor...',
			'downloads.includeSpecials' => 'Maxsus qismlarni qoʻshish',
			'downloads.howManyEpisodes' => 'Nechta qism?',
			'downloads.invalidEpisodeCount' => 'Toʻgʻri qismlar sonini kiriting.',
			'downloads.keepSynced' => 'Sinxronlangan holatda ushlash',
			'downloads.downloadOnce' => 'Bir marta yuklab olish',
			'downloads.keepNUnwatched' => ({required Object count}) => '${count} koʻrilmagan qismni saqlash',
			'downloads.editSyncRule' => 'Sinxronlash qoidasini tahrirlash',
			'downloads.removeSyncRule' => 'Sinxronlash qoidasini oʻchirish',
			'downloads.removeSyncRuleConfirm' => ({required Object title}) => '"${title}" sinxronlashi toʻxtatilsinmi? Yuklab olingan qismlar saqlanadi.',
			'downloads.removeListSyncRuleConfirm' => ({required Object title}) => '"${title}" sinxronlashi toʻxtatilsinmi?',
			'downloads.deleteSyncRuleDownloads' => 'Bogʻliq yuklamalar ham oʻchirilsin',
			'downloads.deleteSyncRuleDownloadsDescription' => 'Boshqa sinxronlash qoidasi yoki profil ishlatayotgan yuklamalar saqlanadi.',
			'downloads.syncRuleCreated' => ({required Object count}) => 'Sinxronlash qoidasi yaratildi — ${count} koʻrilmagan qism saqlanadi',
			'downloads.syncRuleUpdated' => 'Sinxronlash qoidasi yangilandi',
			'downloads.syncRuleRemoved' => 'Sinxronlash qoidasi oʻchirildi',
			'downloads.syncRuleAndDownloadsRemoved' => 'Sinxronlash qoidasi va bogʻliq yuklamalar oʻchirildi',
			'downloads.syncRuleCleanupBusy' => 'Sinxronlash qoidalari hozir yangilanmoqda. Bir ozdan soʻng qayta urinib koʻring.',
			'downloads.syncRuleCleanupUnavailable' => 'Bogʻliq yuklamalarni xavfsiz aniqlab boʻlmadi. Serverga qayta ulanib koʻring yoki yuklamalarni oʻchirmasdan qoidani olib tashlang.',
			'downloads.syncedNewEpisodes' => ({required Object title, required Object count}) => '${title} uchun ${count} yangi qism sinxronlandi',
			'downloads.activeSyncRules' => 'Faol sinxronlash qoidalari',
			'downloads.noSyncRules' => 'Sinxronlash qoidalari yoʻq',
			'downloads.manageSyncRule' => 'Sinxronlashni boshqarish',
			'downloads.editEpisodeCount' => 'Qismlar soni',
			'downloads.editSyncFilter' => 'Sinxronlash filtri',
			'downloads.syncAllItems' => 'Barcha elementlar sinxronlanadi',
			'downloads.syncUnwatchedItems' => 'Koʻrilmagan elementlar sinxronlanadi',
			'downloads.syncRuleServerContext' => ({required Object server, required Object status}) => 'Server: ${server} • ${status}',
			'downloads.syncRuleAvailable' => 'Mavjud',
			'downloads.syncRuleOffline' => 'Oflayn',
			'downloads.syncRuleSignInRequired' => 'Kirish talab etiladi',
			'downloads.syncRuleNotAvailableForProfile' => 'Joriy profil uchun mavjud emas',
			'downloads.syncRuleUnknownServer' => 'Nomaʼlum server',
			'downloads.syncRuleListCreated' => 'Sinxronlash qoidasi yaratildi',
			'downloads.backgroundWarning.bannerBlocked' => 'Ilovadan chiqqaningizda yuklamalar toʻxtaydi',
			'downloads.backgroundWarning.bannerDegraded' => 'Fondagi yuklamalar cheklangan boʻlishi mumkin',
			'downloads.backgroundWarning.bannerAction' => 'Batafsil',
			'downloads.backgroundWarning.sheetTitle' => 'Fondagi yuklamalar bloklangan',
			'downloads.backgroundWarning.sheetTitleDegraded' => 'Fondagi yuklamalar cheklangan boʻlishi mumkin',
			'downloads.backgroundWarning.sheetIntro' => 'Android Harbor-ning fonda ishonchli yuklab olishiga toʻsqinlik qilmoqda.',
			'downloads.backgroundWarning.sheetIntroDegraded' => 'Qurilmangiz Harbor fonda qachon yuklay olishini cheklamoqda.',
			'downloads.backgroundWarning.reasonBackgroundRestricted' => 'Harbor-ning fondagi faoliyati cheklangan. Batareya yoki fondagi foydalanishni "Cheklanmagan" qilib belgilang.',
			'downloads.backgroundWarning.reasonStandbyRestricted' => 'Android Harbor-ni cheklangan kutish holatiga oʻtkazdi. Batareya foydalanishini "Cheklanmagan" qilib belgilang.',
			'downloads.backgroundWarning.reasonDownloadChannelBlocked' => 'Yuklash bildirishnomalari oʻchirilgan, shuning uchun jarayon koʻrsatkichi va boshqaruv elementlari mavjud boʻlmasligi mumkin.',
			'downloads.backgroundWarning.reasonNotificationsDisabled' => 'Bildirishnomalar oʻchirilgan. Android 13 va undan yangi versiyalarda uzoq davom etadigan fondagi yuklamalar uchun ular talab qilinadi.',
			'downloads.backgroundWarning.reasonDataSaver' => 'Trafik tejash yoqilgan, bu mobil internetda fondagi yuklamalarni bloklaydi. Wi-Fi orqali yuklamalar ishlashi kerak.',
			'downloads.backgroundWarning.reasonOemUnknown' => 'Harbor fonda boʻlganida yuklamalar bir necha marta toʻxtadi. Harbor-ning batareya yoki fondagi foydalanish sozlamalarini tekshiring.',
			'downloads.backgroundWarning.openSettings' => 'Sozlamalarni ochish',
			'downloads.backgroundWarning.stillNotWorking' => 'Qurilmaga oid yordam',
			'downloads.backgroundWarning.stillNotWorkingDescription' => 'Qurilmangiz uchun qadamlarni koʻring yoki muammo davom etsa Sozlamalar › Jurnallarni koʻrish boʻlimidan jurnal yuboring.',
			'downloads.backgroundWarning.dialogTitle' => 'Yuklamalar tugamasligi mumkin',
			'downloads.backgroundWarning.dialogDownloadAnyway' => 'Baribir yuklash',
			'downloads.backgroundWarning.dialogFixFirst' => 'Avval buni tuzatish',
			'downloads.backgroundWarning.statusTile' => 'Fondagi yuklamalar',
			'downloads.backgroundWarning.statusOk' => 'Fonda ishlashga ruxsat berilgan',
			'downloads.backgroundWarning.statusBlocked' => 'Tizim sozlamalari tomonidan bloklangan',
			'downloads.backgroundWarning.statusDegraded' => 'Tizim sozlamalari tomonidan cheklangan',
			'downloads.backgroundWarning.statusUnknown' => 'Hali tekshirilmagan',
			'downloads.backgroundWarning.settingsUnavailable' => 'Bu qurilmada tizim sozlamalarini ochib boʻlmadi',
			'downloads.backgroundWarning.linkUnavailable' => 'Bu qurilmada dontkillmyapp.com-ni ochib boʻlmadi',
			'shaders.title' => 'Sheyderlar',
			'shaders.noShaderDescription' => 'Video yaxshilash oʻchirilgan',
			'shaders.nvscalerDescription' => 'Aniqroq video uchun NVIDIA masshtabi',
			'shaders.artcnnVariantNeutral' => 'Neytral',
			'shaders.artcnnVariantDenoise' => 'Shovqinni kamaytirish',
			'shaders.artcnnVariantDenoiseSharpen' => 'Shovqinni kamaytirish + Aniqlik',
			'shaders.qualityFast' => 'Tezkor',
			'shaders.qualityHQ' => 'Yuqori sifat',
			'shaders.mode' => 'Rejim',
			'shaders.importShader' => 'Sheyderni import qilish',
			'shaders.customShaderDescription' => 'Maxsus GLSL sheyderi',
			'shaders.shaderImported' => 'Sheyder import qilindi',
			'shaders.shaderImportFailed' => 'Sheyderni import qilib boʻlmadi',
			'shaders.deleteShader' => 'Sheyderni oʻchirish',
			'shaders.deleteShaderConfirm' => ({required Object name}) => '"${name}" oʻchirilsinmi?',
			'videoSettings.playbackSpeed' => 'Ijro tezligi',
			'videoSettings.normalSpeed' => 'Normal',
			'videoSettings.sleepTimerActive' => ({required Object duration}) => 'Faol (${duration})',
			'videoSettings.zoom' => 'Masshtab',
			'videoSettings.sleepTimer' => 'Uyqu taymeri',
			'videoSettings.audioSync' => 'Audio sinxronlash',
			'videoSettings.subtitleSync' => 'Subtitr sinxronlash',
			'videoSettings.hdr' => 'HDR',
			'videoSettings.audioOutput' => 'Audio chiqishi',
			'videoSettings.performanceOverlay' => 'Unumdorlik paneli',
			'videoSettings.audioPassthrough' => 'Ovozni toʻgʻridan-toʻgʻri oʻtkazish',
			'videoSettings.audioOutputDolbyAtmos' => 'Dolby Atmos',
			'videoSettings.audioOutputDolbyAudio' => 'Dolby Audio',
			'videoSettings.audioOutputSurround' => 'Surround',
			'videoSettings.audioOutputSpatial' => 'Fazoviy audio',
			'videoSettings.audioOutputStereo' => 'Stereo',
			'videoSettings.audioNormalization' => 'Ovoz balandligini meʼyorlashtirish',
			'videoSettings.audioDownmix' => 'Stereoga oʻtkazish',
			'performanceOverlay.color' => 'Rang',
			'performanceOverlay.performance' => 'Unumdorlik',
			'performanceOverlay.buffer' => 'Bufer',
			'performanceOverlay.app' => 'Ilova',
			'performanceOverlay.decoder' => 'Dekoder',
			'performanceOverlay.rawDecoder' => 'Ishlov berilmagan dekoder',
			'performanceOverlay.tunneling' => 'Tunnellash',
			'performanceOverlay.aspect' => 'Nisbat',
			'performanceOverlay.rotation' => 'Aylanish',
			'performanceOverlay.dvSource' => 'DV manbasi',
			'performanceOverlay.dvPath' => 'DV yoʻli',
			'performanceOverlay.p7Conversion' => 'P7 oʻtkazmasi',
			'performanceOverlay.sampleRate' => 'Diskretlash chastotasi',
			'performanceOverlay.pixelFormat' => 'Piksel formati',
			'performanceOverlay.hwFormat' => 'HW formati',
			'performanceOverlay.matrix' => 'Matritsa',
			'performanceOverlay.primaries' => 'Asosiy ranglar',
			'performanceOverlay.transfer' => 'Uzatish',
			'performanceOverlay.renderFps' => 'Render FPS',
			'performanceOverlay.displayFps' => 'Displey FPS',
			'performanceOverlay.avSync' => 'A/V sinxronlash',
			'performanceOverlay.dropped' => 'Tushirib qoldirilgan kadrlar',
			'performanceOverlay.dvRpus' => 'DV RPU-lar',
			'performanceOverlay.dvRpuAverage' => 'DV RPU Oʻrt.',
			'performanceOverlay.dvSampleAverage' => 'DV Namuna Oʻrt.',
			'performanceOverlay.maxLuma' => 'Maks Luma',
			'performanceOverlay.minLuma' => 'Min Luma',
			'performanceOverlay.maxCll' => 'MaxCLL',
			'performanceOverlay.maxFall' => 'MaxFALL',
			'performanceOverlay.cacheUsed' => 'Foydalanilgan kesh',
			'performanceOverlay.cacheLimit' => 'Kesh chegarasi',
			'performanceOverlay.speed' => 'Tezlik',
			'performanceOverlay.player' => 'Pleyer',
			'performanceOverlay.memory' => 'Xotira',
			'performanceOverlay.uiFps' => 'Interfeys (UI) FPS',
			'externalPlayer.title' => 'Tashqi pleyer',
			'externalPlayer.useExternalPlayer' => 'Tashqi pleyerdan foydalanish',
			'externalPlayer.useExternalPlayerDescription' => 'Videolarni boshqa ilovada ochish',
			'externalPlayer.selectPlayer' => 'Pleyerni tanlash',
			'externalPlayer.customPlayers' => 'Maxsus pleyerlar',
			'externalPlayer.systemDefault' => 'Tizim standarti',
			'externalPlayer.addCustomPlayer' => 'Maxsus pleyer qoʻshish',
			'externalPlayer.playerName' => 'Pleyer nomi',
			'externalPlayer.playerNameHint' => 'Mening pleyerim',
			'externalPlayer.playerCommand' => 'Buyruq',
			'externalPlayer.playerPackage' => 'Paket nomi',
			'externalPlayer.playerUrlScheme' => 'URL sxemasi',
			'externalPlayer.off' => 'Oʻchirilgan',
			'externalPlayer.launchFailed' => 'Tashqi pleyerni ishga tushirib boʻlmadi',
			'externalPlayer.appNotInstalled' => ({required Object name}) => '${name} oʻrnatilmagan',
			'externalPlayer.playInExternalPlayer' => 'Tashqi pleyerda ijro etish',
			'metadataEdit.editMetadata' => 'Tahrirlash...',
			'metadataEdit.screenTitle' => 'Metamaʼlumotlarni tahrirlash',
			'metadataEdit.basicInfo' => 'Asosiy maʼlumotlar',
			'metadataEdit.artwork' => 'Rasmlar/Posterlar',
			'metadataEdit.title' => 'Nomi',
			'metadataEdit.sortTitle' => 'Saralash nomi',
			'metadataEdit.originalTitle' => 'Asl nomi',
			'metadataEdit.releaseDate' => 'Chiqqan sanasi',
			'metadataEdit.contentRating' => 'Kontent reytingi',
			'metadataEdit.studio' => 'Studiya',
			'metadataEdit.tagline' => 'Shior/Slogan',
			'metadataEdit.summary' => 'Tavsif/Qisqacha',
			'metadataEdit.poster' => 'Poster',
			'metadataEdit.background' => 'Fon',
			'metadataEdit.logo' => 'Logotip',
			'metadataEdit.squareArt' => 'Kvadrat rasm',
			'metadataEdit.selectPoster' => 'Posterni tanlash',
			'metadataEdit.selectBackground' => 'Fonni tanlash',
			'metadataEdit.selectLogo' => 'Logotipni tanlash',
			'metadataEdit.selectSquareArt' => 'Kvadrat rasm tanlash',
			'metadataEdit.fromUrl' => 'URL orqali',
			'metadataEdit.uploadFile' => 'Fayl yuklash',
			'metadataEdit.enterImageUrl' => 'Rasm URL-manzilini kiriting',
			'metadataEdit.imageUrl' => 'Rasm URL-manzili',
			'metadataEdit.metadataUpdated' => 'Metamaʼlumotlar yangilandi',
			'metadataEdit.metadataUpdateFailed' => 'Metamaʼlumotlarni yangilab boʻlmadi',
			'metadataEdit.artworkUpdated' => 'Rasmlar yangilandi',
			'metadataEdit.artworkUpdateFailed' => 'Rasmlarni yangilab boʻlmadi',
			'metadataEdit.noArtworkAvailable' => 'Rasm mavjud emas',
			'metadataEdit.artworkOption' => ({required Object index}) => 'Rasm opsiyasi ${index}',
			'metadataEdit.selectedArtworkOption' => ({required Object index}) => 'Rasm opsiyasi ${index}, tanlandi',
			'metadataEdit.notSet' => 'Oʻrnatilmagan',
			'metadataEdit.tags' => 'Teglar',
			'metadataEdit.addTag' => 'Teg qoʻshish',
			'metadataEdit.genre' => 'Janr',
			'metadataEdit.director' => 'Rejissyor',
			'metadataEdit.writer' => 'Ssenarist',
			_ => null,
		} ?? switch (path) {
			'metadataEdit.producer' => 'Prodyuser',
			'metadataEdit.country' => 'Mamlakat',
			'metadataEdit.label' => 'Yorliq',
			'trakt.title' => 'Trakt',
			'trakt.connected' => 'Ulandi',
			'trakt.connectedAs' => ({required Object username}) => '@${username} sifatida ulandi',
			'trakt.disconnectConfirm' => 'Trakt uzilsinmi?',
			'trakt.disconnectConfirmBody' => 'Harbor Trakt-ga maʼlumot yuborishni toʻxtatadi.',
			'trakt.scrobble' => 'Real vaqt rejimida kuzatish',
			'trakt.scrobbleDescription' => 'Ijro paytida Trakt-ga maʼlumot yuborish.',
			'trakt.watchedSync' => 'Koʻrish holatini sinxronlash',
			'trakt.watchedSyncDescription' => 'Harbor-da belgilanganda Trakt-da ham belgilanadi.',
			'seerr.title' => 'Seerr',
			'seerr.connectTitle' => 'Seerr ulash',
			'seerr.serverUrl' => 'Server URL-i',
			'seerr.serverUrlHelper' => 'Seerr manzilingiz',
			'seerr.checkServer' => 'Davom ettirish',
			'seerr.signInWithJellyfin' => 'Jellyfin orqali kirish',
			'seerr.signInWithEmby' => 'Emby orqali kirish',
			'seerr.signInWithLocal' => 'Mahalliy hisobdan foydalanish',
			'seerr.email' => 'Elektron pochta',
			'seerr.noSignInMethods' => 'Ushbu Seerr qoʻllab-quvvatlanadigan kirish usulini taklif qilmaydi.',
			'seerr.instance' => 'Instansiya',
			'seerr.disconnectConfirm' => 'Seerr uzilsinmi?',
			'seerr.disconnectConfirmBody' => 'Harbor ushbu Seerr manzilini oʻchiradi.',
			'seerr.request' => 'Soʻrov yuborish',
			'seerr.request4k' => '4K soʻrov yuborish',
			'seerr.seasons' => 'Mavsumlar',
			'seerr.allSeasons' => 'Barcha mavsumlar',
			'seerr.advancedOptions' => 'Kengaytirilgan',
			'seerr.destinationServer' => 'Moʻljal server',
			'seerr.qualityProfile' => 'Sifat profili',
			'seerr.rootFolder' => 'Asosiy jild',
			'seerr.languageProfile' => 'Til profili',
			'seerr.requestSubmitted' => 'Soʻrov yuborildi',
			'seerr.requestFailed' => ({required Object error}) => 'Soʻrov xatoligi: ${error}',
			'seerr.requestsLoadFailed' => 'Parametrlarni yuklab boʻlmadi',
			'seerr.nothingToRequest' => 'Barchasi avvaldan bor yoki soʻralgan.',
			'seerr.statusAvailable' => 'Mavjud',
			'seerr.statusPartiallyAvailable' => 'Qisman mavjud',
			'seerr.statusRequested' => 'Soʻraldi',
			'seerr.statusProcessing' => 'Ishlanmoqda',
			'services.title' => 'Xizmatlar',
			'services.hubSubtitle' => 'Koʻrish jarayonini sinxronlang va yangi kontent soʻrang.',
			'services.notConnected' => 'Ulanmagan',
			'services.connectedAs' => ({required Object username}) => '@${username} sifatida ulandi',
			'services.connectFailed' => ({required Object service}) => '${service} ulana olmadi. Qaytadan urinib koʻring.',
			'services.names.seerr' => 'Seerr',
			'services.deviceCode.title' => ({required Object service}) => 'Harbor-ni ${service} xizmatida faollashtiring',
			'services.deviceCode.body' => ({required Object url}) => '${url} manziliga oʻting va ushbu kodni kiriting:',
			'services.deviceCode.openToActivate' => ({required Object service}) => 'Faollashtirish uchun ${service} xizmatini oching',
			'services.deviceCode.copyCode' => 'Faollashtirish kodini nusxalash',
			'services.deviceCode.waitingForAuthorization' => 'Avtorizatsiya kutilmoqda…',
			'services.deviceCode.codeCopied' => 'Kod nusxalandi',
			'services.libraryFilter.title' => 'Kutubxona filtri',
			'services.libraryFilter.subtitleAllSyncing' => 'Barcha kutubxonalar sinxronlanmoqda',
			'services.libraryFilter.subtitleNoneSyncing' => 'Hech narsa sinxronlanmaydi',
			'services.libraryFilter.subtitleBlocked' => ({required Object count}) => '${count} bloklandi',
			'services.libraryFilter.subtitleAllowed' => ({required Object count}) => '${count} ruxsat berildi',
			'services.libraryFilter.mode' => 'Filtr rejimi',
			'services.libraryFilter.modeBlacklist' => 'Qora roʻyxat',
			'services.libraryFilter.modeWhitelist' => 'Oq roʻyxat',
			'services.libraryFilter.modeHintBlacklist' => 'Quyida tanlanganlardan tashqari barcha kutubxonalarni sinxronlash.',
			'services.libraryFilter.modeHintWhitelist' => 'Faqat quyida tanlangan kutubxonalarni sinxronlash.',
			'services.libraryFilter.libraries' => 'Kutubxonalar',
			'services.libraryFilter.noLibraries' => 'Kutubxonalar yoʻq',
			'addServer.addJellyfinTitle' => 'Jellyfin serverini qoʻshish',
			'addServer.serverUrls' => 'Server URL-lari',
			'addServer.serverUrlsHelper' => 'Vergul bilan ajratilgan bir nechta URL manziliga ruxsat beriladi.',
			'addServer.findServer' => 'Serverni topish',
			'addServer.searchingLocalServers' => 'Mahalliy Jellyfin serverlari qidirilmoqda...',
			'addServer.localServers' => 'Mahalliy Jellyfin serverlari',
			'addServer.username' => 'Foydalanuvchi nomi',
			'addServer.password' => 'Parol',
			'addServer.signIn' => 'Kirish',
			'addServer.change' => 'Oʻzgartirish',
			'addServer.required' => 'Talab qilinadi',
			'addServer.couldNotReachServer' => ({required Object error}) => 'Serverga ulanib boʻlmadi: ${error}',
			'addServer.signInFailed' => ({required Object error}) => 'Kirish xatoligi: ${error}',
			'addServer.quickConnectFailed' => ({required Object error}) => 'Tezkor ulanish xatoligi: ${error}',
			'addServer.enterJellyfinUrlError' => 'Jellyfin server URL-ini kiriting',
			'addServer.addConnectionTitle' => 'Ulanish qoʻshish',
			'addServer.addConnectionTitleScoped' => ({required Object name}) => '${name} profiliga qoʻshish',
			'addServer.connectToJellyfinCard' => 'Jellyfin-ga ulanish',
			'addServer.connectToJellyfinCardSubtitle' => 'Server URL, foydalanuvchi nomi va parolingizni kiriting.',
			'addServer.connectToJellyfinCardSubtitleScoped' => ({required Object name}) => 'Jellyfin serveriga kiring. ${name} profiliga ulanmoqda.',
			'addServer.borrowFromAnotherProfile' => 'Boshqa profildan olish',
			'addServer.borrowFromAnotherProfileSubtitle' => 'Boshqa profilning ulanishidan qayta foydalaning.',
			_ => null,
		};
	}
}
