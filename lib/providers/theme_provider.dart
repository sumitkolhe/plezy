import 'dart:async' show unawaited;
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import '../mixins/disposable_change_notifier_mixin.dart';
import '../services/settings_binding_owner.dart';
import '../services/settings_service.dart' as settings;
import '../theme/dynamic_palette.dart';
import '../theme/mono_palette.dart';
import '../theme/mono_theme.dart';

class ThemeProvider extends ChangeNotifier with DisposableChangeNotifierMixin, WidgetsBindingObserver {
  late final SettingsBindingOwner _settingsBinding;
  settings.ThemeMode _themeMode = settings.ThemeMode.system;
  late Brightness _systemBrightness;
  DynamicPalette? _palette;

  ThemeProvider() {
    _systemBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    // Seed synchronously when settings are already loaded (main() initializes
    // them before runApp) so the first frame paints the persisted theme; the
    // async path below lands a microtask too late for the first build.
    final loaded = settings.SettingsService.instanceOrNull;
    if (loaded != null) {
      _themeMode = loaded.read(settings.SettingsService.themeMode);
      _palette = DynamicPalette.fromJson(loaded.read(settings.SettingsService.dynamicPalette));
    }
    _settingsBinding = SettingsBindingOwner(
      prefs: const [settings.SettingsService.themeMode],
      onRefresh: (service) => _syncThemeMode(service.read(settings.SettingsService.themeMode)),
    );
    unawaited(_settingsBinding.bind());
    WidgetsBinding.instance.addObserver(this);
    if (_themeMode == settings.ThemeMode.materialYou) unawaited(_refreshPalette());
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // The wallpaper can change while the app is away, and Android does not tell
    // Flutter when it does.
    if (state == AppLifecycleState.resumed && _themeMode == settings.ThemeMode.materialYou) {
      unawaited(_refreshPalette());
    }
  }

  @override
  void didChangePlatformBrightness() {
    _systemBrightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (_themeMode == settings.ThemeMode.system || _themeMode == settings.ThemeMode.materialYou) {
      safeNotifyListeners();
    }
  }

  @override
  void dispose() {
    _settingsBinding.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _syncThemeMode(settings.ThemeMode mode, {bool forceNotify = false}) {
    final changed = _themeMode != mode;
    _themeMode = mode;
    _updateSplashTheme(mode);
    if (changed && mode == settings.ThemeMode.materialYou) unawaited(_refreshPalette());
    if (changed || forceNotify) safeNotifyListeners();
  }

  /// Reads Android's wallpaper tones. Returns without touching the theme when
  /// the platform has none to give (below Android 12, or not Android at all),
  /// which leaves Material You rendering as the plain system theme.
  Future<void> _refreshPalette() async {
    if (!Platform.isAndroid) return;
    try {
      final raw = await _themeChannel.invokeMethod<Map<Object?, Object?>>('getDynamicPalette');
      final palette = DynamicPalette.fromChannel(raw);
      if (palette == null || palette == _palette || isDisposed) return;
      _palette = palette;
      final service = _settingsBinding.settings ?? settings.SettingsService.instanceOrNull;
      if (service != null) {
        unawaited(service.write(settings.SettingsService.dynamicPalette, palette.toJson()));
      }
      safeNotifyListeners();
    } on PlatformException {
      return;
    } on MissingPluginException {
      return;
    }
  }

  DynamicPalette? get _activePalette => _themeMode == settings.ThemeMode.materialYou ? _palette : null;

  settings.ThemeMode get themeMode => _themeMode;

  /// The one place that decides which scheme a mode means.
  ///
  /// OLED is checked before the wallpaper because the two are exclusive: a
  /// tinted pure black is not a thing this app offers. A Material You palette
  /// that failed to load leaves [_activePalette] null and falls through to the
  /// plain scheme, which is how that mode degrades below Android 12.
  MonoPalette _paletteFor({required bool dark}) {
    if (dark && _themeMode == settings.ThemeMode.oled) return MonoPalette.oled;
    final dynamicPalette = _activePalette;
    if (dynamicPalette != null) return MonoPalette.fromDynamic(dynamicPalette, dark: dark);
    return dark ? MonoPalette.dark : MonoPalette.light;
  }

  ThemeData get lightTheme => monoTheme(_paletteFor(dark: false));
  ThemeData get darkTheme => monoTheme(_paletteFor(dark: true));

  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case settings.ThemeMode.light:
        return ThemeMode.light;
      case settings.ThemeMode.dark:
        return ThemeMode.dark;
      case settings.ThemeMode.oled:
        return ThemeMode.dark;
      case settings.ThemeMode.system:
      case settings.ThemeMode.materialYou:
        return ThemeMode.system;
    }
  }

  bool get isDarkMode {
    switch (_themeMode) {
      case settings.ThemeMode.light:
        return false;
      case settings.ThemeMode.dark:
        return true;
      case settings.ThemeMode.oled:
        return true;
      case settings.ThemeMode.system:
      case settings.ThemeMode.materialYou:
        return _systemBrightness == Brightness.dark;
    }
  }

  static const _themeChannel = MethodChannel('co.sumit.harbor/theme');

  @visibleForTesting
  Future<void> setThemeMode(settings.ThemeMode mode) async {
    if (_themeMode == mode) return;
    final service = _settingsBinding.settings ?? await settings.SettingsService.getInstance();
    await service.write(settings.SettingsService.themeMode, mode);
    if (_settingsBinding.settings == null) _syncThemeMode(mode);
  }

  Future<void> reload() async {
    await _settingsBinding.bind();
    final service = _settingsBinding.settings;
    if (service != null) _syncThemeMode(service.read(settings.SettingsService.themeMode), forceNotify: true);
  }

  void _updateSplashTheme(settings.ThemeMode mode) {
    if (!Platform.isAndroid) return;
    final name = switch (mode) {
      settings.ThemeMode.dark => 'dark',
      settings.ThemeMode.oled => 'oled',
      settings.ThemeMode.light => 'light',
      settings.ThemeMode.system => 'system',
      // Material You follows the OS, and so does the default splash.
      settings.ThemeMode.materialYou => 'system',
    };
    _themeChannel.invokeMethod('setSplashTheme', {'mode': name});
  }

  IconData get themeModeIcon {
    switch (_themeMode) {
      case settings.ThemeMode.light:
        return PhosphorIcons.sun;
      case settings.ThemeMode.dark:
        return PhosphorIcons.moon;
      case settings.ThemeMode.oled:
        return PhosphorIcons.circleHalf;
      case settings.ThemeMode.system:
        return PhosphorIcons.sun;
      case settings.ThemeMode.materialYou:
        return PhosphorIcons.palette;
    }
  }
}
