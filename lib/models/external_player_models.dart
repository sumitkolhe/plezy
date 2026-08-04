import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/app_logger.dart';

typedef PlayerLauncher = Future<bool> Function(String url);

enum CustomPlayerType { command, urlScheme }

/// Host lookups behind [KnownPlayers.getForCurrentPlatform], split out so tests
/// can answer them without touching the real machine.
class PlayerInstallProbe {
  const PlayerInstallProbe();

  /// Drives which detectors run. Values match [Platform.operatingSystem].
  String get operatingSystem => Platform.operatingSystem;

  Map<String, String> get environment => Platform.environment;

  Future<ProcessResult> run(String executable, List<String> arguments) => Process.run(executable, arguments);

  Future<bool> fileExists(String path) => File(path).exists();

  /// macOS Launch Services lookup — the database `open -a` resolves through.
  /// Spotlight is deliberately not consulted: an empty `mdfind` result also
  /// means indexing is off or incomplete, which would hide installed players.
  Future<bool> applicationInstalled(String bundleId) async {
    const channel = MethodChannel('co.sumit.harbor/app_lookup');
    return await channel.invokeMethod<bool>('isApplicationInstalled', {'bundleId': bundleId}) ?? false;
  }

  Future<bool> schemeHasHandler(String scheme) => canLaunchUrl(Uri.parse(scheme));
}

class ExternalPlayer {
  final String id;
  final String name;
  final String? iconAsset;
  final bool isAvailable;
  final PlayerLauncher launch;
  final bool isCustom;
  final String? customValue; // Only for custom player serialization
  final CustomPlayerType? customType;

  ExternalPlayer({
    required this.id,
    required this.name,
    this.iconAsset,
    this.isAvailable = true,
    required this.launch,
    this.isCustom = false,
    this.customValue,
    this.customType,
  });

  factory ExternalPlayer.custom({
    required String id,
    required String name,
    required String value,
    required CustomPlayerType type,
  }) {
    return ExternalPlayer(
      id: id,
      name: name,
      isCustom: true,
      customValue: value,
      customType: type,
      launch: (url) => _launchCustom(value, url, type),
    );
  }

  factory ExternalPlayer.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String;
    final known = KnownPlayers.findById(id);
    if (known != null) return known;
    return ExternalPlayer.custom(
      id: id,
      name: json['name'] as String,
      value: json['customValue'] as String? ?? '',
      type: json['customType'] == 'urlScheme' ? CustomPlayerType.urlScheme : CustomPlayerType.command,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    if (isCustom) 'isCustom': true,
    if (customValue != null) 'customValue': customValue,
    if (customType != null) 'customType': customType == CustomPlayerType.urlScheme ? 'urlScheme' : 'command',
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is ExternalPlayer && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

Future<bool> _launchWithUrl(String url) {
  return launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
}

Future<bool> _launchAndroidIntent(String url, {required String package, bool fallbackToUrl = true}) async {
  final intentUri = Uri.parse(
    'intent:$url#Intent;'
    'action=android.intent.action.VIEW;'
    'type=video/*;'
    'package=$package;'
    'end',
  );
  try {
    return await launchUrl(intentUri, mode: LaunchMode.externalApplication);
  } catch (_) {
    return fallbackToUrl ? _launchWithUrl(url) : false;
  }
}

Future<bool> _launchAndroidIntentCandidates(String url, Iterable<String> packages) async {
  for (final package in packages) {
    if (await _launchAndroidIntent(url, package: package, fallbackToUrl: false)) return true;
  }
  return _launchWithUrl(url);
}

Future<bool> _launchUrlScheme(String scheme, String url) async {
  final playerUrl = scheme.contains('url=') ? '$scheme${Uri.encodeComponent(url)}' : '$scheme$url';
  final uri = Uri.parse(playerUrl);
  if (await canLaunchUrl(uri)) {
    return launchUrl(uri, mode: LaunchMode.externalApplication);
  }
  return false;
}

Future<bool> _launchCustom(String value, String url, CustomPlayerType type) async {
  if (type == CustomPlayerType.urlScheme) {
    return _launchUrlScheme(value, url);
  }
  return _launchAndroidIntent(url, package: value);
}

class KnownPlayers {
  static final systemDefault = ExternalPlayer(id: 'system_default', name: 'System Default', launch: _launchWithUrl);

  static const _androidPackageMap = <String, List<String>>{
    'vlc': ['org.videolan.vlc'],
    'mpv': ['is.xyz.mpv'],
    'mx_player': ['com.mxtech.videoplayer.ad', 'com.mxtech.videoplayer.pro'],
    'just_player': ['com.brouken.player'],
  };

  static List<String> _androidPackageCandidatesForId(String id) {
    return _androidPackageMap[id] ?? const [];
  }

  static List<String> androidPackageCandidates(ExternalPlayer player) {
    final knownPackages = _androidPackageCandidatesForId(player.id);
    if (knownPackages.isNotEmpty) return knownPackages;
    if (player.isCustom && player.customType == CustomPlayerType.command) {
      final package = player.customValue?.trim();
      return package == null || package.isEmpty ? const [] : [package];
    }
    return const [];
  }

  static final _allPlayers = <ExternalPlayer>[
    systemDefault,
    ExternalPlayer(
      id: 'vlc',
      name: 'VLC',
      iconAsset: 'assets/player_icons/vlc.svg',
      isAvailable: Platform.isAndroid || Platform.isIOS,
      launch: (url) => Platform.isAndroid
          ? _launchAndroidIntentCandidates(url, _androidPackageCandidatesForId('vlc'))
          : _launchUrlScheme('vlc://', url),
    ),
    ExternalPlayer(
      id: 'mpv',
      name: 'mpv',
      iconAsset: 'assets/player_icons/mpv.svg',
      isAvailable: Platform.isAndroid,
      launch: (url) => _launchAndroidIntentCandidates(url, _androidPackageCandidatesForId('mpv')),
    ),
    ExternalPlayer(
      id: 'mx_player',
      name: 'MX Player',
      iconAsset: 'assets/player_icons/mx_player.svg',
      isAvailable: Platform.isAndroid,
      launch: (url) => _launchAndroidIntentCandidates(url, _androidPackageCandidatesForId('mx_player')),
    ),
    ExternalPlayer(
      id: 'just_player',
      name: 'Just Player',
      iconAsset: 'assets/player_icons/just_player.png',
      isAvailable: Platform.isAndroid,
      launch: (url) => _launchAndroidIntentCandidates(url, _androidPackageCandidatesForId('just_player')),
    ),
    ExternalPlayer(
      id: 'infuse',
      name: 'Infuse',
      iconAsset: 'assets/player_icons/infuse.png',
      isAvailable: Platform.isIOS,
      launch: (url) => _launchUrlScheme('infuse://x-callback-url/play?url=', url),
    ),
  ];

  /// Host lookups used to decide whether a supported player is actually
  /// installed. Overridden in tests; production talks to the real process,
  /// filesystem and URL-handler APIs.
  @visibleForTesting
  static PlayerInstallProbe probe = const PlayerInstallProbe();

  static Future<List<ExternalPlayer>>? _installedPlayers;

  /// Players supported on this platform, minus the ones we can positively tell
  /// are not installed.
  ///
  /// Detection calls out over platform channels, so it is asynchronous and
  /// memoised: it runs once per process and a player installed while the app
  /// is running only appears after a restart. Android is left unprobed —
  /// where there is no reliable check the player stays listed, because hiding
  /// a working player is worse than listing a missing one.
  static Future<List<ExternalPlayer>> getForCurrentPlatform() {
    return _installedPlayers ??= _resolveForCurrentPlatform();
  }

  @visibleForTesting
  static void resetForTesting() {
    probe = const PlayerInstallProbe();
    _installedPlayers = null;
  }

  static Future<List<ExternalPlayer>> _resolveForCurrentPlatform() async {
    final supported = [
      for (final player in _allPlayers)
        if (player.isAvailable) player,
    ];

    // Each detector must answer the same question its launcher asks, so a
    // listed player is one we can actually start.
    final detectors = <String, Future<bool> Function()>{};
    switch (probe.operatingSystem) {
      case 'ios':
        // Same predicate _launchUrlScheme gates on, so detection can never
        // hide a player the handoff would have reached. Both schemes are
        // declared in LSApplicationQueriesSchemes.
        detectors['vlc'] = () => probe.schemeHasHandler('vlc://');
        detectors['infuse'] = () => probe.schemeHasHandler('infuse://');
    }
    if (detectors.isEmpty) return supported;

    final ids = detectors.keys.toList(growable: false);
    final found = await Future.wait(ids.map((id) => _detect(id, detectors[id]!)));
    final missing = <String>{
      for (var i = 0; i < ids.length; i++)
        if (!found[i]) ids[i],
    };
    if (missing.isEmpty) return supported;

    return [
      for (final player in supported)
        if (!missing.contains(player.id)) player,
    ];
  }

  /// Runs one detector, failing open: a probe that blows up must not hide a
  /// player the user may well have installed.
  static Future<bool> _detect(String id, Future<bool> Function() detector) async {
    try {
      return await detector();
    } catch (e, stackTrace) {
      appLogger.w('External player detection failed for $id; listing it anyway', error: e, stackTrace: stackTrace);
      return true;
    }
  }

  /// Find a known player by ID
  static ExternalPlayer? findById(String id) {
    try {
      return _allPlayers.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }
}
