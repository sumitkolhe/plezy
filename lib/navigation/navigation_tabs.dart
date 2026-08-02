import 'package:flutter/material.dart';
import 'package:harbor/widgets/app_icon.dart';
import 'package:harbor/theme/phosphor_icons.dart';

import '../i18n/strings.g.dart';
import '../utils/platform_detector.dart';

/// Navigation tab identifiers
enum NavigationTabId { discover, explore, libraries, downloads, settings }

/// Represents a navigation tab with its configuration
class NavigationTab {
  final NavigationTabId id;
  final bool onlineOnly;
  final IconData icon;
  final String Function() getLabel;

  const NavigationTab({required this.id, required this.onlineOnly, required this.icon, required this.getLabel});

  NavigationDestination toDestination() {
    return NavigationDestination(icon: AppIcon(icon), selectedIcon: AppIcon(icon), label: getLabel());
  }

  /// Get tabs filtered by offline mode and feature availability
  static List<NavigationTab> getVisibleTabs({required bool isOffline, bool hasExplore = false}) {
    return allNavigationTabs.where((tab) {
      if (isOffline && tab.onlineOnly) return false;
      if (tab.id == NavigationTabId.explore && !hasExplore) return false;
      if (tab.id == NavigationTabId.downloads && PlatformDetector.isAppleTV()) return false;
      return true;
    }).toList();
  }

  /// Resolve which tab the app should open to on launch.
  ///
  /// Offline mode prefers Downloads when available. Online, honours the user's
  /// [preferredStartup] section when it is currently visible, otherwise falls
  /// back to the first visible tab (Home).
  static NavigationTabId resolveDefaultTab({
    required bool isOffline,
    bool hasExplore = false,
    required NavigationTabId? preferredStartup,
  }) {
    final tabs = getVisibleTabs(isOffline: isOffline, hasExplore: hasExplore);
    if (isOffline && tabs.any((t) => t.id == NavigationTabId.downloads)) {
      return NavigationTabId.downloads;
    }
    if (preferredStartup != null && tabs.any((t) => t.id == preferredStartup)) {
      return preferredStartup;
    }
    return tabs.first.id;
  }
}

// Label getters (must be top-level for const constructor)
String _getHomeLabel() => t.common.home;
String _getExploreLabel() => t.navigation.explore;
String _getLibrariesLabel() => t.navigation.libraries;
String _getDownloadsLabel() => t.navigation.downloads;
String _getSettingsLabel() => t.common.settings;

/// All navigation tabs in display order
const allNavigationTabs = [
  NavigationTab(
    id: NavigationTabId.discover,
    onlineOnly: true,
    icon: PhosphorIconsDuotone.house,
    getLabel: _getHomeLabel,
  ),
  NavigationTab(
    id: NavigationTabId.libraries,
    onlineOnly: true,
    icon: PhosphorIconsDuotone.filmStrip,
    getLabel: _getLibrariesLabel,
  ),
  NavigationTab(
    id: NavigationTabId.explore,
    onlineOnly: true,
    icon: PhosphorIconsDuotone.compass,
    getLabel: _getExploreLabel,
  ),
  NavigationTab(
    id: NavigationTabId.downloads,
    onlineOnly: false,
    icon: PhosphorIconsDuotone.download,
    getLabel: _getDownloadsLabel,
  ),
  NavigationTab(
    id: NavigationTabId.settings,
    onlineOnly: false,
    icon: PhosphorIconsDuotone.gear,
    getLabel: _getSettingsLabel,
  ),
];
