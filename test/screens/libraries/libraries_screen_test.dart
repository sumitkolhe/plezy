import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:harbor/services/arr/arr_client.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/focus/input_mode_tracker.dart';
import 'package:harbor/models/arr/managed_service.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_library.dart';
import 'package:harbor/mixins/refreshable.dart';
import 'package:harbor/providers/managed_services_provider.dart';
import 'package:harbor/providers/server_activity_provider.dart';
import 'package:harbor/providers/hidden_libraries_provider.dart';
import 'package:harbor/providers/libraries_provider.dart';
import 'package:harbor/providers/multi_server_provider.dart';
import 'package:harbor/screens/libraries/libraries_screen.dart';
import 'package:harbor/screens/libraries/tabs/library_browse_tab.dart';
import 'package:harbor/screens/libraries/tabs/library_missing_tab.dart';
import 'package:harbor/services/multi_server_manager.dart';
import 'package:harbor/services/settings_service.dart';
import 'package:harbor/services/storage_service.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/utils/platform_detector.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';
import 'package:shared_preferences_platform_interface/types.dart';

import '../../test_helpers/arr_fixtures.dart';
import '../../test_helpers/multi_server_fixtures.dart';
import '../../test_helpers/prefs.dart';

const _libraryA = MediaLibrary(
  id: 'movies',
  backend: MediaBackend.jellyfin,
  title: 'Library A',
  kind: MediaKind.movie,
  serverId: 'server',
);
const _libraryB = MediaLibrary(
  id: 'shows',
  backend: MediaBackend.jellyfin,
  title: 'Library B',
  kind: MediaKind.show,
  serverId: 'server',
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    resetSharedPreferencesForTest();
    TvDetectionService.debugSetAppleTVOverride(false);
  });

  tearDown(() => TvDetectionService.debugSetAppleTVOverride(null));

  testWidgets('a saved selection is restored, and a stale one falls back', (tester) async {
    // The selector stores what it chose; a name from a build that had pills, or
    // a view since deleted, resolves to the library's own contents rather than
    // throwing or showing nothing.
    final harness = await _Harness.create(
      _GatedPreferences({
        'selected_library_key': _libraryB.globalKey,
        'library_tab_${_libraryB.globalKey}': 'missing',
        'library_tab_${_libraryA.globalKey}': 'playlists',
      }),
      withArr: true,
    );
    addTearDown(harness.dispose);

    await harness.pump(tester);
    await tester.pumpAndSettle();
    expect(find.byType(LibraryMissingTab), findsOneWidget, reason: 'library B saved missing');

    final loadable = tester.state(find.byType(LibrariesScreen)) as LibraryLoadable;
    loadable.loadLibraryByKey(_libraryA.globalKey);
    await tester.pumpAndSettle();

    expect(find.byType(LibraryMissingTab), findsNothing);
    expect(find.byType(LibraryBrowseTab), findsOneWidget, reason: 'an unresolvable name falls back');
  });

  testWidgets('disposal rejects a pending saved-tab continuation', (tester) async {
    final preferences = _GatedPreferences({
      'selected_library_key': _libraryB.globalKey,
      'library_tab_${_libraryA.globalKey}': 'playlists',
    });
    final harness = await _Harness.create(preferences, withArr: true);
    addTearDown(harness.dispose);

    await harness.pump(tester);
    preferences.blockNextSelectedLibraryWrite(_libraryA.globalKey);
    final loadable = tester.state(find.byType(LibrariesScreen)) as LibraryLoadable;
    loadable.loadLibraryByKey(_libraryA.globalKey);
    await preferences.blocked;

    await tester.pumpWidget(const SizedBox());
    preferences.release();
    await tester.pump();

    expect(tester.takeException(), isNull);
  });
}

final class _Harness {
  _Harness({
    required this.libraries,
    required this.hiddenLibraries,
    required this.multiServer,
    required this.managedServices,
    required this.serverActivity,
  });

  final LibrariesProvider libraries;
  final HiddenLibrariesProvider hiddenLibraries;
  final MultiServerProvider multiServer;
  final ManagedServicesProvider managedServices;
  final ServerActivityProvider serverActivity;

  /// [withArr] seeds a Radarr and a Sonarr, which is what gives every library a
  /// Missing tab — and so a second tab for the saved-tab machinery to restore.
  static Future<_Harness> create(_GatedPreferences preferences, {bool withArr = false}) async {
    SharedPreferencesAsyncPlatform.instance = preferences;
    await SettingsService.getInstance();
    await StorageService.getInstance();
    final libraries = LibrariesProvider();
    await libraries.updateLibraryOrder(const [_libraryA, _libraryB]);
    final hiddenLibraries = HiddenLibrariesProvider();
    await hiddenLibraries.ensureInitialized();
    final manager = MultiServerManager();
    final multiServer = testMultiServerProvider(manager);
    final managedServices = ManagedServicesProvider();
    if (withArr) {
      // With a client that answers, the tab settles on its empty state instead
      // of spinning on a lookup that never returns.
      for (final kind in [ManagedServiceKind.radarr, ManagedServiceKind.sonarr]) {
        final connection = ManagedServiceConnection(kind: kind, baseUrl: 'http://${kind.name}', secret: 'k');
        managedServices.debugAddServiceForTesting(
          connection,
          client: ArrClient(
            kind: kind,
            baseUrl: connection.baseUrl,
            apiKey: connection.secret,
            httpClient: MockClient(
              (_) async => http.Response(
                jsonEncode({'records': <Object>[]}),
                200,
                headers: {'content-type': 'application/json'},
              ),
            ),
          ),
        );
      }
    }
    return _Harness(
      serverActivity: ServerActivityProvider(managedServices, service: IdleServerActivityService()),
      libraries: libraries,
      hiddenLibraries: hiddenLibraries,
      multiServer: multiServer,
      managedServices: managedServices,
    );
  }

  Future<void> pump(WidgetTester tester, {ValueChanged<String>? onLibrarySelected}) async {
    tester.view.physicalSize = const Size(1280, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<LibrariesProvider>.value(value: libraries),
          ChangeNotifierProvider<HiddenLibrariesProvider>.value(value: hiddenLibraries),
          ChangeNotifierProvider<MultiServerProvider>.value(value: multiServer),
          // The tab row asks whether an *arr can answer for this library's kind.
          ChangeNotifierProvider<ManagedServicesProvider>.value(value: managedServices),
          // The Missing tab reads this the moment it mounts.
          ChangeNotifierProvider<ServerActivityProvider>.value(value: serverActivity),
        ],
        child: InputModeTracker(
          child: MaterialApp(
            theme: monoTheme(dark: true),
            home: LibrariesScreen(onLibrarySelected: onLibrarySelected),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  void dispose() {
    libraries.dispose();
    hiddenLibraries.dispose();
    multiServer.dispose();
    serverActivity.dispose();
    managedServices.dispose();
  }
}

final class _GatedPreferences extends InMemorySharedPreferencesAsync {
  _GatedPreferences(super.data) : super.withData();

  String? _blockedValue;
  Completer<void>? _entered;
  Completer<void>? _release;

  Future<void> get blocked => _entered!.future;

  void blockNextSelectedLibraryWrite(String value) {
    _blockedValue = value;
    _entered = Completer<void>();
    _release = Completer<void>();
  }

  void release() {
    final release = _release;
    if (release != null && !release.isCompleted) release.complete();
  }

  @override
  Future<bool> setString(String key, String value, SharedPreferencesOptions options) async {
    final result = await super.setString(key, value, options);
    if (key.endsWith('selected_library_key') && value == _blockedValue) {
      _blockedValue = null;
      _entered!.complete();
      await _release!.future;
    }
    return result;
  }
}
