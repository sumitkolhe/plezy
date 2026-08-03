import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:provider/provider.dart';

import '../../i18n/strings.g.dart';
import '../../models/trackers/device_code.dart';
import '../../providers/trackers_provider.dart';
import '../../services/trackers/simkl/simkl_tracker.dart';
import '../../services/trackers/tracker_constants.dart';
import '../../services/settings_service.dart';
import '../../utils/dialogs.dart';
import '../../widgets/device_code_dialog.dart';
import '../../widgets/settings_page.dart';
import 'tracker_account_settings_body.dart';
import 'tracker_connect_launcher.dart';

Future<void> startSimklConnection(BuildContext context) {
  final account = context.read<TrackersProvider>();
  final name = t.services.names.simkl;
  return launchTrackerConnect<DeviceCode>(
    context,
    isBusyOrConnected: account.isConnecting(TrackerService.simkl) || account.isSimklConnected,
    serviceName: name,
    connect: (cb) => account.connectSimkl(onCodeReady: cb),
    onCancel: account.cancelConnect,
    buildDialog: (p, cancel) => DeviceCodeDialog(code: p, serviceName: name, onCancel: cancel),
    urlFor: (p) => p.verificationUrlComplete ?? p.verificationUrl,
  );
}

/// Per-service wiring for [TrackerSettingsScreen]. Keeps tracker-specific
/// method names out of the shared screen body.
class TrackerConfig {
  final TrackerService service;
  final String displayName;
  final bool Function(TrackersProvider) isConnected;
  final String? Function(TrackersProvider) username;
  final Future<void> Function(bool) onScrobbleChanged;
  final Future<void> Function(TrackersProvider) disconnect;

  const TrackerConfig({
    required this.service,
    required this.displayName,
    required this.isConnected,
    required this.username,
    required this.onScrobbleChanged,
    required this.disconnect,
  });

  Pref<bool> get scrobblePref => SettingsService.scrobblePref(service);

  static TrackerConfig simkl() => TrackerConfig(
    service: TrackerService.simkl,
    displayName: t.services.names.simkl,
    isConnected: (a) => a.isSimklConnected,
    username: (a) => a.simklUsername,
    onScrobbleChanged: SimklTracker.instance.setEnabled,
    disconnect: (a) => a.disconnectSimkl(),
  );
}

/// Shared settings screen for the device-code trackers. Only reachable while
/// connected — if the session drops (refresh failure, back-nav race) we pop
/// back to the hub.
class TrackerSettingsScreen extends StatelessWidget {
  final TrackerConfig config;
  const TrackerSettingsScreen({super.key, required this.config});

  Future<void> _disconnect(BuildContext context, TrackersProvider account) async {
    final confirmed = await showConfirmDialog(
      context,
      title: t.services.disconnectConfirm(service: config.displayName),
      message: t.services.disconnectConfirmBody(service: config.displayName),
      confirmText: t.common.disconnect,
      isDestructive: true,
    );
    if (!confirmed) return;
    await config.disconnect(account);
  }

  @override
  Widget build(BuildContext context) {
    final title = Text(config.displayName);

    return Consumer<TrackersProvider>(
      builder: (context, account, _) {
        if (!config.isConnected(account)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) Navigator.of(context).pop();
          });
          return SettingsPage.slivers(
            title: title,
            slivers: const [SliverFillRemaining(child: SizedBox.shrink())],
          );
        }

        final username = config.username(account);
        return TrackerAccountSettingsBody(
          title: title,
          accountTitle: username != null ? t.services.connectedAs(username: username) : config.displayName,
          service: config.service,
          toggles: [
            TrackerSettingsToggle(
              pref: config.scrobblePref,
              icon: PhosphorIcons.timer,
              title: t.services.scrobble,
              subtitle: t.services.scrobbleDescription,
              onAfterWrite: config.onScrobbleChanged,
            ),
          ],
          onDisconnect: () => _disconnect(context, account),
        );
      },
    );
  }
}
