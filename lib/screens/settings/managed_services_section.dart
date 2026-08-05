import 'dart:async';

import 'package:flutter/material.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:provider/provider.dart';

import '../../i18n/strings.g.dart';
import '../../models/arr/managed_service.dart';
import '../../providers/managed_services_provider.dart';
import '../../theme/mono_tokens.dart';
import '../../utils/dialogs.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_menu.dart';
import '../../widgets/focusable_list_tile.dart';
import '../../widgets/settings_section.dart';
import 'managed_service_connect_screen.dart';
import 'managed_service_labels.dart';

/// The media-server half of the Services hub, one row per instance.
class ManagedServicesSection extends StatelessWidget {
  const ManagedServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ManagedServicesProvider>(
      builder: (context, provider, _) {
        final connections = provider.connections;
        return SettingsGroup(
          title: t.managedServices.sectionTitle,
          children: [
            for (final connection in connections)
              _InstanceRow(connection: connection, health: provider.healthFor(connection.id)),
            FocusableListTile(
              listItemMetrics: true,
              leading: const AppIcon(PhosphorIcons.plus, size: 22),
              title: Text(t.managedServices.add),
              onTap: () => unawaited(_addService(context)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addService(BuildContext context) async {
    final kind = await showAdaptiveAppMenu<ManagedServiceKind>(
      context,
      title: t.managedServices.addTitle,
      entries: [
        for (final kind in ManagedServiceKind.values)
          AppMenuItem<ManagedServiceKind>(
            value: kind,
            icon: managedServiceIcon(kind),
            label: managedServiceName(kind),
            subtitle: managedServiceHint(kind),
          ),
      ],
    );
    if (kind == null || !context.mounted) return;
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => ManagedServiceConnectScreen(kind: kind)));
  }
}

class _InstanceRow extends StatelessWidget {
  final ManagedServiceConnection connection;
  final ManagedServiceHealth health;

  const _InstanceRow({required this.connection, required this.health});

  Color _stateColor(BuildContext context) => switch (health) {
    ManagedServiceHealth.reachable => Colors.green,
    ManagedServiceHealth.unauthorized => Colors.amber,
    ManagedServiceHealth.unreachable => Theme.of(context).colorScheme.error,
    ManagedServiceHealth.unknown => tokens(context).textMuted,
  };

  @override
  Widget build(BuildContext context) {
    final tokensRef = tokens(context);
    final color = _stateColor(context);

    return FocusableListTile(
      listItemMetrics: true,
      leading: AppIcon(managedServiceIcon(connection.kind), size: 22),
      title: Text(connection.displayName),
      subtitle: Text(
        '${managedServiceName(connection.kind)}  ·  ${Uri.tryParse(connection.baseUrl)?.host ?? connection.baseUrl}',
        maxLines: 1,
        overflow: .ellipsis,
      ),
      trailing: Row(
        mainAxisSize: .min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 7),
          Text(
            managedServiceHealthLabel(health),
            style: TextStyle(fontSize: 11.5, fontWeight: .w600, color: color),
          ),
        ],
      ),
      onTap: () => unawaited(_openActions(context, tokensRef)),
    );
  }

  Future<void> _openActions(BuildContext context, MonoTokens tokensRef) async {
    final provider = context.read<ManagedServicesProvider>();
    final action = await showAdaptiveAppMenu<String>(
      context,
      title: connection.displayName,
      entries: [
        AppMenuItem<String>(value: 'recheck', icon: PhosphorIcons.arrowsClockwise, label: t.managedServices.recheck),
        AppMenuItem<String>(value: 'edit', icon: PhosphorIcons.pencilSimple, label: t.managedServices.apiKeyLabel),
        AppMenuItem<String>(
          value: 'remove',
          icon: PhosphorIcons.trash,
          label: t.managedServices.remove,
          destructive: true,
        ),
      ],
    );
    if (action == null || !context.mounted) return;

    switch (action) {
      case 'recheck':
        await provider.probe(connection.id);
      case 'edit':
        await Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => ManagedServiceConnectScreen(kind: connection.kind, existing: connection),
          ),
        );
      case 'remove':
        final confirmed = await showConfirmDialog(
          context,
          title: t.managedServices.removeConfirm(name: connection.displayName),
          message: t.managedServices.removeConfirmBody,
          confirmText: t.managedServices.remove,
          isDestructive: true,
        );
        if (confirmed) await provider.disconnect(connection.id);
    }
  }
}
