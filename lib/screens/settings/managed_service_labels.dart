import 'package:harbor/theme/phosphor_icons.dart';
import 'package:flutter/widgets.dart';

import '../../i18n/strings.g.dart';
import '../../models/arr/managed_service.dart';

/// Product names stay untranslated; what each is for, and its state, do not.
String managedServiceName(ManagedServiceKind kind) => switch (kind) {
  ManagedServiceKind.radarr => t.managedServices.kinds.radarr,
  ManagedServiceKind.sonarr => t.managedServices.kinds.sonarr,
  ManagedServiceKind.qbittorrent => t.managedServices.kinds.qbittorrent,
};

String managedServiceHint(ManagedServiceKind kind) => switch (kind) {
  ManagedServiceKind.radarr => t.managedServices.kindHints.radarr,
  ManagedServiceKind.sonarr => t.managedServices.kindHints.sonarr,
  ManagedServiceKind.qbittorrent => t.managedServices.kindHints.qbittorrent,
};

IconData managedServiceIcon(ManagedServiceKind kind) => switch (kind) {
  ManagedServiceKind.radarr => PhosphorIcons.filmSlate,
  ManagedServiceKind.sonarr => PhosphorIcons.television,
  ManagedServiceKind.qbittorrent => PhosphorIcons.download,
};

String managedServiceHealthLabel(ManagedServiceHealth health) => switch (health) {
  ManagedServiceHealth.reachable => t.managedServices.connected,
  ManagedServiceHealth.unauthorized => t.managedServices.reconnect,
  ManagedServiceHealth.unreachable => t.managedServices.unreachable,
  ManagedServiceHealth.unknown => t.managedServices.checking,
};
