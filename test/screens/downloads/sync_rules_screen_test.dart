import 'dart:async';
import 'package:drift/native.dart';
import 'package:harbor/media/ids.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:harbor/connection/connection.dart';
import 'package:harbor/connection/connection_registry.dart';
import 'package:harbor/database/app_database.dart';
import 'package:harbor/focus/input_mode_tracker.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_item.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/providers/download_provider.dart';
import 'package:harbor/providers/multi_server_provider.dart';
import 'package:harbor/screens/downloads/sync_rules_screen.dart';
import 'package:harbor/services/data_aggregation_service.dart';
import 'package:harbor/services/download_manager_service.dart';
import 'package:harbor/services/download_storage_service.dart';
import 'package:harbor/services/jellyfin_api_cache.dart';
import 'package:harbor/services/jellyfin_client.dart';
import 'package:harbor/services/multi_server_manager.dart';
import 'package:provider/provider.dart';

import '../../test_helpers/prefs.dart';
import '../../test_helpers/media_items.dart';
import '../../test_helpers/multi_server_fixtures.dart';

JellyfinConnection _jellyfinConnection({
  required String machineId,
  required String userId,
  required String serverName,
}) {
  return JellyfinConnection(
    id: '$machineId/$userId',
    baseUrl: 'https://jf.example.com',
    serverName: serverName,
    serverMachineId: machineId,
    userId: userId,
    userName: userId,
    accessToken: 'token-$userId',
    deviceId: 'device',
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );
}

JellyfinClient _jellyfinClient(JellyfinConnection connection) {
  return JellyfinClient.forTesting(
    connection: connection,
    httpClient: MockClient((_) async => http.Response('{}', 200)),
  );
}

MediaItem _show(ServerId serverId, String ratingKey, String title) {
  return testMediaItem(
    id: ratingKey,
    backend: MediaBackend.jellyfin,
    kind: MediaKind.show,
    title: title,
    serverId: serverId,
  );
}

MediaItem _playlist(ServerId serverId, String ratingKey, String title) {
  return testMediaItem(
    id: ratingKey,
    backend: MediaBackend.jellyfin,
    kind: MediaKind.playlist,
    title: title,
    serverId: serverId,
  );
}

class _FakeConnectionRegistry extends ConnectionRegistry {
  _FakeConnectionRegistry(super.db, this.connections);

  final List<Connection> connections;
  int watchCalls = 0;

  @override
  Stream<List<Connection>> watchConnections() {
    watchCalls++;
    return Stream.value(connections);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;
  late DownloadProvider downloadProvider;
  late DownloadManagerService downloadManager;
  late MultiServerManager serverManager;
  MultiServerProvider? multiServerProvider;
  late _FakeConnectionRegistry connectionRegistry;
  late List<Connection> connections;

  setUp(() async {
    resetSharedPreferencesForTest();
    db = AppDatabase.forTesting(NativeDatabase.memory());
    JellyfinApiCache.initialize(db);
    downloadManager = DownloadManagerService(
      database: db,
      storageService: DownloadStorageService.instance,
      clientResolver: (serverId, {clientScopeId}) => null,
    );
    downloadProvider = DownloadProvider.forTesting(downloadManager: downloadManager, database: db);
    await downloadProvider.ensureInitialized();
    serverManager = MultiServerManager();
    connections = [];
    connectionRegistry = _FakeConnectionRegistry(db, connections);
  });

  tearDown(() async {
    downloadProvider.dispose();
    multiServerProvider?.dispose();
    await db.close();
  });

  Future<void> insertRule(ServerId serverId, String ratingKey) {
    return downloadProvider.createSyncRule(
      serverId: serverId,
      ratingKey: ratingKey,
      targetType: 'show',
      episodeCount: 5,
    );
  }

  Future<void> insertPlaylistRule(ServerId serverId, String ratingKey) {
    return downloadProvider.createSyncRule(
      serverId: serverId,
      ratingKey: ratingKey,
      targetType: 'playlist',
      episodeCount: 0,
    );
  }

  Future<void> pumpScreen(WidgetTester tester, {bool keyboardMode = false}) async {
    downloadProvider.debugSeedState(
      metadata: {
        'unbound-jf:show-1': _show(ServerId('unbound-jf'), 'show-1', 'Unbound Show'),
        'jf-machine:show-2': _show(ServerId('jf-machine'), 'show-2', 'Jellyfin Show'),
        'auth-jf:show-3': _show(ServerId('auth-jf'), 'show-3', 'Auth Show'),
        'unknown-srv:show-4': _show(ServerId('unknown-srv'), 'show-4', 'Unknown Show'),
        'playlist-srv:playlist-1': _playlist(ServerId('playlist-srv'), 'playlist-1', 'Road Trip'),
      },
    );

    Widget buildScreen() => MultiProvider(
      providers: [
        Provider<ConnectionRegistry>.value(value: connectionRegistry),
        ChangeNotifierProvider<DownloadProvider>.value(value: downloadProvider),
        ChangeNotifierProvider<MultiServerProvider>.value(value: multiServerProvider!),
      ],
      child: const MaterialApp(home: SyncRulesScreen()),
    );

    if (!keyboardMode) {
      await tester.pumpWidget(buildScreen());
      await tester.pump();
      return;
    }

    final showScreen = ValueNotifier(false);
    addTearDown(showScreen.dispose);
    await tester.pumpWidget(
      InputModeTracker(
        child: ValueListenableBuilder<bool>(
          valueListenable: showScreen,
          builder: (context, show, _) => show ? buildScreen() : const MaterialApp(home: SizedBox.shrink()),
        ),
      ),
    );

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    showScreen.value = true;
    await tester.pumpAndSettle();
  }

  String? primaryFocusLabel() => FocusManager.instance.primaryFocus?.debugLabel;

  testWidgets('shows server context and active-profile availability for device sync rules', (tester) async {
    // Known to the registry but never registered on the manager: the label
    // resolves while availability does not.
    connections.add(_jellyfinConnection(machineId: 'unbound-jf', userId: 'user-z', serverName: 'Living Room'));

    final availableJellyfin = _jellyfinConnection(
      machineId: 'jf-machine',
      userId: 'user-a',
      serverName: 'Shared Jellyfin',
    );
    connections.add(availableJellyfin);
    final availableClient = _jellyfinClient(availableJellyfin);
    addTearDown(availableClient.close);
    serverManager.debugRegisterJellyfinClientForTesting(availableClient);

    final authJellyfin = _jellyfinConnection(machineId: 'auth-jf', userId: 'user-b', serverName: 'Auth Jellyfin');
    connections.add(authJellyfin);
    final authClient = _jellyfinClient(authJellyfin);
    addTearDown(authClient.close);
    serverManager.debugRegisterJellyfinClientForTesting(authClient, online: false);
    serverManager.debugMarkAuthErrorForTesting(ServerId('auth-jf'));
    multiServerProvider = testMultiServerProvider(serverManager);

    await insertRule(ServerId('unbound-jf'), 'show-1');
    await insertRule(ServerId('jf-machine'), 'show-2');
    await insertRule(ServerId('auth-jf'), 'show-3');
    await insertRule(ServerId('unknown-srv'), 'show-4');

    await pumpScreen(tester);

    expect(find.text('Unbound Show'), findsOneWidget);
    expect(find.text('Server: Living Room • Not available for current profile'), findsOneWidget);
    expect(find.text('Jellyfin Show'), findsOneWidget);
    expect(find.text('Server: Shared Jellyfin • Available'), findsOneWidget);
    expect(find.text('Auth Show'), findsOneWidget);
    expect(find.text('Server: Auth Jellyfin • Sign in required'), findsOneWidget);
    expect(find.text('Unknown Show'), findsOneWidget);
    expect(find.text('Server: unknown-srv • Unknown server'), findsOneWidget);
  });

  testWidgets('removes orphaned sync rules from the sync rules screen', (tester) async {
    multiServerProvider = testMultiServerProvider(serverManager);
    await insertRule(ServerId('orphan-srv'), '76672');

    await pumpScreen(tester);

    expect(find.text('76672'), findsOneWidget);

    await tester.drag(find.text('76672'), const Offset(-140, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('sync_rule_swipe_delete')));
    await tester.pumpAndSettle();

    expect(find.text('Stop syncing "76672"? Downloaded episodes will be kept.'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Remove sync rule'));
    await tester.pumpAndSettle();

    expect(downloadProvider.syncRules, isEmpty);
    expect(find.text('76672'), findsNothing);
    expect(find.text('No sync rules'), findsOneWidget);
  });

  testWidgets('playlist rule removal exposes and runs the destructive cleanup choice', (tester) async {
    multiServerProvider = MultiServerProvider(serverManager, DataAggregationService(serverManager));
    await insertPlaylistRule(ServerId('playlist-srv'), 'playlist-1');
    final ruleKey = downloadProvider.syncRuleKeyFor(ServerId('playlist-srv'), 'playlist-1');
    await db.markSyncRuleDownloadLinksInitialized(ruleKey);

    await pumpScreen(tester);
    await tester.drag(find.text('Road Trip'), const Offset(-140, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const ValueKey('sync_rule_swipe_delete')));
    await tester.pumpAndSettle();

    expect(find.text('Stop syncing "Road Trip"?'), findsOneWidget);
    final toggle = tester.widget<SwitchListTile>(
      find.descendant(
        of: find.byKey(const ValueKey('delete_sync_rule_downloads')),
        matching: find.byType(SwitchListTile),
      ),
    );
    expect(toggle.value, isFalse);

    final removalCompleted = Completer<void>();
    void handleRemoval() {
      if (!downloadProvider.hasSyncRule(ruleKey) && !removalCompleted.isCompleted) {
        removalCompleted.complete();
      }
    }

    downloadProvider.addListener(handleRemoval);
    addTearDown(() => downloadProvider.removeListener(handleRemoval));

    await tester.tap(find.byKey(const ValueKey('delete_sync_rule_downloads')));
    await tester.pump();
    expect(
      tester
          .widget<SwitchListTile>(
            find.descendant(
              of: find.byKey(const ValueKey('delete_sync_rule_downloads')),
              matching: find.byType(SwitchListTile),
            ),
          )
          .value,
      isTrue,
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Remove sync rule'));
    await tester.runAsync(() => removalCompleted.future.timeout(const Duration(seconds: 5)));
    await tester.pumpAndSettle();

    expect(await db.getSyncRule(ruleKey), isNull);
    expect(find.text('Sync rule and associated downloads removed'), findsOneWidget);
  });

  testWidgets('provider rebuilds reuse the connection stream subscription', (tester) async {
    multiServerProvider = testMultiServerProvider(serverManager);
    await insertRule(ServerId('orphan-srv'), '76672');
    await pumpScreen(tester);

    expect(connectionRegistry.watchCalls, 1);
    await downloadProvider.updateSyncRuleCount(downloadProvider.syncRules.keys.single, 6);
    await tester.pump();

    expect(connectionRegistry.watchCalls, 1);
  });

  testWidgets('does not autofocus the first sync rule in pointer mode', (tester) async {
    multiServerProvider = testMultiServerProvider(serverManager);
    await insertRule(ServerId('orphan-srv'), '76672');
    FocusManager.instance.primaryFocus?.unfocus();

    await pumpScreen(tester);
    await tester.pumpAndSettle();

    expect(primaryFocusLabel(), isNot('sync_rule_row'));
  });

  testWidgets('keyboard navigation reaches and toggles the sync rule switch', (tester) async {
    multiServerProvider = testMultiServerProvider(serverManager);
    await insertRule(ServerId('orphan-srv'), '76672');

    await pumpScreen(tester, keyboardMode: true);

    expect(primaryFocusLabel(), 'sync_rule_row');

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pumpAndSettle();
    expect(primaryFocusLabel(), 'sync_rule_switch');

    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();

    expect(downloadProvider.syncRules.values.single.enabled, isFalse);
  });

  testWidgets('setting sync rule count to zero removes the rule', (tester) async {
    multiServerProvider = testMultiServerProvider(serverManager);
    await insertRule(ServerId('orphan-srv'), '76672');

    await pumpScreen(tester, keyboardMode: true);
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '0');
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();

    expect(find.text('Stop syncing "76672"? Downloaded episodes will be kept.'), findsOneWidget);

    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.pumpAndSettle();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();

    expect(downloadProvider.syncRules, isEmpty);
    expect(find.text('No sync rules'), findsOneWidget);
  });
}
