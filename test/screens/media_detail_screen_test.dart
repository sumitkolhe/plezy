import 'dart:async';
import 'package:drift/native.dart';
import 'package:harbor/media/ids.dart';

import 'dart:ui' show Tristate;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:harbor/database/app_database.dart';
import 'package:harbor/focus/focusable_action_bar.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/media/library_query.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_hub.dart';
import 'package:harbor/media/media_item.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_server_client.dart';
import 'package:harbor/providers/download_provider.dart';
import 'package:harbor/providers/multi_server_provider.dart';
import 'package:harbor/providers/watch_state_store.dart';
import 'package:harbor/screens/media_detail/season_picker.dart';
import 'package:harbor/screens/media_detail_screen.dart';

import '../test_helpers/paged_fakes.dart';
import 'package:harbor/services/download_manager_service.dart';
import 'package:harbor/services/download_storage_service.dart';
import 'package:harbor/services/jellyfin_api_cache.dart';
import 'package:harbor/services/multi_server_manager.dart';
import 'package:harbor/services/offline_watch_sync_service.dart';
import 'package:harbor/services/settings_service.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/utils/layout_constants.dart';
import 'package:harbor/utils/media_server_http_client.dart';
import 'package:harbor/utils/platform_detector.dart';
import 'package:harbor/utils/watch_state_notifier.dart';
import 'package:harbor/utils/video_player_navigation.dart';
import 'package:harbor/widgets/collapsible_text.dart';
import 'package:harbor/widgets/cycling_media_backdrop.dart';
import 'package:harbor/widgets/episode_card.dart';
import 'package:harbor/widgets/tv_browse_rail.dart';
import 'package:provider/provider.dart';

import '../test_helpers/prefs.dart';
import '../test_helpers/profile_navigation.dart';
import '../test_helpers/media_items.dart';
import '../test_helpers/multi_server_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase scopeDb;
  late DownloadManagerService scopeManager;
  late DownloadProvider scopeDownloads;

  setUp(() {
    resetSharedPreferencesForTest();
    SettingsService.resetForTesting();
    TvDetectionService.debugSetAppleTVOverride(true);
    LocaleSettings.setLocaleSync(AppLocale.en);
    // Android TV offers downloads, so the detail screen's action bar resolves
    // a DownloadProvider on every pump.
    scopeDb = AppDatabase.forTesting(NativeDatabase.memory());
    scopeManager = DownloadManagerService(
      database: scopeDb,
      storageService: DownloadStorageService.instance,
      clientResolver: (serverId, {clientScopeId}) => null,
    )..recoveryFuture = Future<void>.value();
    scopeDownloads = DownloadProvider.forTesting(downloadManager: scopeManager, database: scopeDb);
  });

  tearDown(() async {
    TvDetectionService.debugSetAppleTVOverride(null);
    scopeDownloads.dispose();
    scopeManager.dispose();
    await scopeDb.close();
  });

  Widget scope({required Widget child}) => ChangeNotifierProvider<DownloadProvider>.value(
    value: scopeDownloads,
    child: withProfileNavigationScope(child: child),
  );

  testWidgets('TV detail scales fallback title to fit logo bounds', (tester) async {
    await SettingsService.getInstance();
    tester.view.physicalSize = const Size(800, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const title = 'The Surprisingly Long Movie Title That Needs Two Whole Lines';
    final movie = testMediaItem(
      id: 'movie_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.movie,
      title: title,
      summary: 'A compact viewport should make the fallback title shrink before it can overlap the detail text.',
    );

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: monoTheme(dark: true),
          home: scope(child: MediaDetailScreen(metadata: movie)),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();

    final titleText = tester.widget<Text>(find.text(title));
    final baseFontSize = 56 * TvLayoutConstants.scaleForSize(const Size(800, 480));
    expect(titleText.style?.fontSize, isNotNull);
    expect(titleText.style!.fontSize!, lessThan(baseFontSize));
  });

  testWidgets('TV detail exposes hero information as one semantic node', (tester) async {
    final semantics = tester.ensureSemantics();
    await SettingsService.getInstance();
    tester.view.physicalSize = const Size(1280, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final movie = testMediaItem(
      id: 'semantic_movie',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.movie,
      title: 'Semantic Movie',
      summary: 'One concise detail announcement.',
      year: 2025,
      genres: ['Drama', 'Mystery'],
    );

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: monoTheme(dark: true),
          home: scope(child: MediaDetailScreen(metadata: movie)),
        ),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    final information = find.bySemanticsIdentifier('tv_detail_information');
    expect(information, findsOneWidget);
    final node = tester.getSemantics(information);
    expect(node.label, contains('Semantic Movie'));
    expect(node.label, contains('Movie'));
    expect(node.label, contains('2025'));
    expect(node.label, contains('Drama, Mystery'));
    expect(node.label, contains('One concise detail announcement.'));
    expect(node.getSemanticsData().hasAction(SemanticsAction.tap), isFalse);
    expect(tester.widget<Semantics>(information).properties.onTap, isNull);

    // Visual content and the separate action row remain present.
    expect(find.text('Semantic Movie'), findsOneWidget);
    expect(find.text('One concise detail announcement.'), findsOneWidget);
    expect(find.byType(FocusableActionBar), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('TV detail reveals without waiting for directional input', (tester) async {
    await SettingsService.getInstance();

    final movie = testMediaItem(
      id: 'movie_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.movie,
      title: 'Idle Reveal Movie',
      summary: 'The detail foreground should appear without needing a D-pad frame.',
    );

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: monoTheme(dark: true),
          home: scope(child: MediaDetailScreen(metadata: movie)),
        ),
      ),
    );

    final revealGate = find.byWidgetPredicate(
      (widget) => widget is AnimatedOpacity && widget.duration == const Duration(milliseconds: 160),
      description: 'TV detail reveal AnimatedOpacity',
    );
    expect(revealGate, findsOneWidget);
    expect(tester.widget<AnimatedOpacity>(revealGate).opacity, 0);

    await tester.pump();

    expect(tester.widget<AnimatedOpacity>(revealGate).opacity, 1);
  });

  testWidgets('TV detail defaults to first regular season when specials precede it', (tester) async {
    await SettingsService.getInstance();

    final show = testMediaItem(
      id: 'show_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.show,
      title: 'The Show',
      serverId: 'server_1',
      serverName: 'Server',
    );
    final specials = testMediaItem(
      id: 'season_0',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.season,
      title: 'Specials',
      index: 0,
      parentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final season1 = testMediaItem(
      id: 'season_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.season,
      title: 'Season 1',
      index: 1,
      parentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final specialEpisode = testMediaItem(
      id: 'episode_special_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Special 1',
      index: 1,
      parentId: specials.id,
      parentIndex: specials.index,
      grandparentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final episode1 = testMediaItem(
      id: 'episode_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Episode 1',
      index: 1,
      parentId: season1.id,
      parentIndex: season1.index,
      grandparentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );

    final descendantsCompleter = Completer<List<MediaItem>>();
    final client = _FakeMediaServerClient(
      show: show,
      childrenByParent: {
        show.id: [specials, season1],
        specials.id: [specialEpisode],
        season1.id: [episode1],
      },
      pendingPlayableDescendants: descendantsCompleter.future,
    );
    final manager = MultiServerManager()..debugRegisterClientForTesting(client);
    final provider = testMultiServerProvider(manager);
    addTearDown(provider.dispose);

    await tester.pumpWidget(
      TranslationProvider(
        child: ChangeNotifierProvider<MultiServerProvider>.value(
          value: provider,
          child: MaterialApp(
            theme: monoTheme(dark: true),
            home: scope(
              child: SizedBox(width: 1280, height: 720, child: MediaDetailScreen(metadata: show)),
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Season 1'), findsOneWidget);
    expect(find.text('Specials'), findsNothing);
    expect(find.text('S1E1'), findsOneWidget);
  });

  testWidgets('TV detail summary uses light theme foreground color', (tester) async {
    await SettingsService.getInstance();
    tester.view.physicalSize = const Size(1280, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const summary = 'Light theme detail text should stay readable.';
    final movie = testMediaItem(
      id: 'movie_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.movie,
      title: 'Readable Movie',
      summary: summary,
    );
    final theme = monoTheme(dark: false);

    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          theme: theme,
          home: scope(child: MediaDetailScreen(metadata: movie)),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    final summaryText = tester.widget<Text>(find.text(summary));
    expect(summaryText.style?.color, theme.colorScheme.onSurface.withValues(alpha: 0.78));
  });

  testWidgets('TV detail shows every season tab and prefetches adjacent first page', (tester) async {
    await SettingsService.getInstance();

    final show = testMediaItem(
      id: 'show_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.show,
      title: 'The Show',
      serverId: 'server_1',
      serverName: 'Server',
    );
    final season1 = testMediaItem(
      id: 'season_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.season,
      title: 'Season 1',
      index: 1,
      parentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final season2 = testMediaItem(
      id: 'season_2',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.season,
      title: 'Season 2',
      index: 2,
      parentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final episode1 = testMediaItem(
      id: 'episode_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Episode 1',
      index: 1,
      parentId: season1.id,
      parentIndex: season1.index,
      grandparentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final episode2 = testMediaItem(
      id: 'episode_2',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Episode 2',
      index: 1,
      parentId: season2.id,
      parentIndex: season2.index,
      grandparentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );

    final client = _FakeMediaServerClient(
      show: show,
      childrenByParent: {
        show.id: [season1, season2],
        season1.id: [episode1],
        season2.id: [episode2],
      },
    );
    final manager = MultiServerManager()..debugRegisterClientForTesting(client);
    final provider = testMultiServerProvider(manager);
    addTearDown(provider.dispose);

    await tester.pumpWidget(
      TranslationProvider(
        child: ChangeNotifierProvider<MultiServerProvider>.value(
          value: provider,
          child: MaterialApp(
            theme: monoTheme(dark: true),
            home: scope(
              child: SizedBox(width: 1280, height: 720, child: MediaDetailScreen(metadata: show)),
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    // Every season tab is derived from the season list, so both appear
    // immediately. TV warms only the selected first page plus the adjacent first
    // page; it still does not walk the whole show or load page 2+.
    expect(find.text('Season 1'), findsOneWidget);
    expect(find.text('Season 2'), findsOneWidget);
    expect(client.childrenPageCalls.map((call) => call.parentId), containsAll([season1.id, season2.id]));
    expect(client.childrenPageCalls.every((call) => call.start == 0 && call.size == 200), isTrue);
  });

  testWidgets('TV detail keeps every season tab when a season episode load fails', (tester) async {
    await SettingsService.getInstance();

    final show = testMediaItem(
      id: 'show_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.show,
      title: 'The Show',
      serverId: 'server_1',
      serverName: 'Server',
    );
    final season1 = testMediaItem(
      id: 'season_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.season,
      title: 'Season 1',
      index: 1,
      parentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final season2 = testMediaItem(
      id: 'season_2',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.season,
      title: 'Season 2',
      index: 2,
      parentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final episode1 = testMediaItem(
      id: 'episode_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Episode 1',
      index: 1,
      parentId: season1.id,
      parentIndex: season1.index,
      grandparentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final episode2 = testMediaItem(
      id: 'episode_2',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Episode 2',
      index: 1,
      parentId: season2.id,
      parentIndex: season2.index,
      grandparentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );

    final client = _FakeMediaServerClient(
      show: show,
      childrenByParent: {
        show.id: [season1, season2],
        season1.id: [episode1],
        season2.id: [episode2],
      },
      childrenPageErrors: {season1.id: Exception('season cache failed')},
    );
    final manager = MultiServerManager()..debugRegisterClientForTesting(client);
    final provider = testMultiServerProvider(manager);
    addTearDown(provider.dispose);

    await tester.pumpWidget(
      TranslationProvider(
        child: ChangeNotifierProvider<MultiServerProvider>.value(
          value: provider,
          child: MaterialApp(
            theme: monoTheme(dark: true),
            home: scope(
              child: SizedBox(width: 1280, height: 720, child: MediaDetailScreen(metadata: show)),
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Season 1'), findsOneWidget);
    expect(find.text('Season 2'), findsOneWidget);
  });

  testWidgets('TV detail completes adjacent prefetch after focus moves to that season', (tester) async {
    await SettingsService.getInstance();

    final show = testMediaItem(
      id: 'show_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.show,
      title: 'The Show',
      serverId: 'server_1',
      serverName: 'Server',
    );
    final season1 = testMediaItem(
      id: 'season_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.season,
      title: 'Season 1',
      index: 1,
      parentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final season2 = testMediaItem(
      id: 'season_2',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.season,
      title: 'Season 2',
      index: 2,
      parentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final episode1 = testMediaItem(
      id: 'episode_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Episode 1',
      index: 1,
      parentId: season1.id,
      parentIndex: season1.index,
      grandparentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final episode2 = testMediaItem(
      id: 'episode_2',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Episode 2',
      index: 1,
      parentId: season2.id,
      parentIndex: season2.index,
      grandparentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final season2Completer = Completer<List<MediaItem>>();
    final client = _FakeMediaServerClient(
      show: show,
      childrenByParent: {
        show.id: [season1, season2],
        season1.id: [episode1],
      },
      childrenPageFutures: {season2.id: season2Completer.future},
    );
    final manager = MultiServerManager()..debugRegisterClientForTesting(client);
    final provider = testMultiServerProvider(manager);
    addTearDown(provider.dispose);

    await tester.pumpWidget(
      TranslationProvider(
        child: ChangeNotifierProvider<MultiServerProvider>.value(
          value: provider,
          child: MaterialApp(
            theme: monoTheme(dark: true),
            home: scope(
              child: SizedBox(width: 1280, height: 720, child: MediaDetailScreen(metadata: show)),
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));
    tester.state<TvBrowseRailState>(find.byType(TvBrowseRail)).requestFocus();
    await tester.pump();

    await tester.sendKeyDownEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    await tester.sendKeyUpEvent(LogicalKeyboardKey.arrowDown);
    await tester.pump();
    expect(find.text('Episode 2'), findsNothing);

    season2Completer.complete([episode2]);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Episode 2'), findsOneWidget);
  });

  testWidgets('TV detail episode activation bypasses the open-details preference', (tester) async {
    final settings = await SettingsService.getInstance();
    await settings.write(SettingsService.episodeAction, EpisodeAction.details);
    tester.view.physicalSize = const Size(1280, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final show = testMediaItem(
      id: 'show_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.show,
      title: 'The Show',
      serverId: 'server_1',
      serverName: 'Server',
    );
    final season = testMediaItem(
      id: 'season_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.season,
      title: 'Season 1',
      index: 1,
      parentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final episode = testMediaItem(
      id: 'episode_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Episode 1',
      index: 1,
      parentId: season.id,
      parentIndex: season.index,
      grandparentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );
    final client = _FakeMediaServerClient(
      show: show,
      childrenByParent: {
        show.id: [season],
        season.id: [episode],
      },
    );
    final database = AppDatabase.forTesting(NativeDatabase.memory());
    JellyfinApiCache.initialize(database);
    final manager = MultiServerManager()..debugRegisterClientForTesting(client);
    final multiServerProvider = testMultiServerProvider(manager);
    final offlineWatch = OfflineWatchSyncService(database: database, serverManager: manager);
    final downloadManager = DownloadManagerService(
      database: database,
      storageService: DownloadStorageService.instance,
      clientResolver: (serverId, {clientScopeId}) => null,
    )..recoveryFuture = Future<void>.value();
    final downloadProvider = DownloadProvider.forTesting(downloadManager: downloadManager, database: database);
    await downloadProvider.ensureInitialized();
    addTearDown(() async {
      downloadProvider.dispose();
      downloadManager.dispose();
      offlineWatch.dispose();
      multiServerProvider.dispose();
      manager.dispose();
      await database.close();
    });

    final navigatorKey = GlobalKey<NavigatorState>();
    final observer = _RecordingNavigatorObserver(popVideoPlayerImmediately: true);
    await tester.pumpWidget(
      TranslationProvider(
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<MultiServerProvider>.value(value: multiServerProvider),
            ChangeNotifierProvider<DownloadProvider>.value(value: downloadProvider),
            ChangeNotifierProvider<OfflineWatchSyncService>.value(value: offlineWatch),
          ],
          child: MaterialApp(
            navigatorKey: navigatorKey,
            navigatorObservers: [observer],
            theme: monoTheme(dark: true),
            home: scope(
              child: SizedBox(width: 1280, height: 720, child: MediaDetailScreen(metadata: show)),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Episode 1'), findsOneWidget);
    observer.pushedRouteNames.clear();
    tester.state<TvBrowseRailState>(find.byType(TvBrowseRail)).requestFocus();
    await tester.pump();
    await tester.sendKeyDownEvent(LogicalKeyboardKey.enter);
    await tester.pump();
    await tester.sendKeyUpEvent(LogicalKeyboardKey.enter);
    await tester.pump();

    expect(observer.pushedRouteNames, contains(kVideoPlayerRouteName));
  });

  group('phone layout', () {
    MediaItem buildShow({String? summary}) => testMediaItem(
      id: 'show_1',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.show,
      title: 'The Show',
      summary: summary,
      leafCount: 4,
      viewedLeafCount: 0,
      serverId: 'server_1',
      serverName: 'Server',
    );

    MediaItem buildSeason(MediaItem show, int index) => testMediaItem(
      id: 'season_$index',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.season,
      title: 'Season $index',
      index: index,
      leafCount: 2,
      viewedLeafCount: 0,
      parentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );

    MediaItem buildEpisode(MediaItem show, MediaItem season, int index) => testMediaItem(
      id: '${season.id}_episode_$index',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Episode S${season.index}E$index',
      index: index,
      durationMs: 30 * 60 * 1000,
      parentId: season.id,
      parentIndex: season.index,
      grandparentId: show.id,
      serverId: show.serverId,
      serverName: show.serverName,
    );

    /// Switch seasons the way touch does: tap the season's pill in the row
    /// under the Episodes heading. [label] is the compact form, e.g. `S2`.
    Future<void> pickSeason(WidgetTester tester, String label) async {
      final pill = find.descendant(of: find.byType(SeasonSelector), matching: find.text(label));
      await tester.ensureVisible(pill);
      await tester.pumpAndSettle();
      await tester.tap(pill);
      await tester.pumpAndSettle();
    }

    Future<void> pumpPhoneDetail(
      WidgetTester tester,
      _FakeMediaServerClient client,
      MediaItem show, {
      String? initialSeasonId,
      int? initialSeasonIndex,
      String? initialEpisodeId,
    }) async {
      TvDetectionService.debugSetAppleTVOverride(false);
      await SettingsService.getInstance();
      tester.view.physicalSize = const Size(1100, 2400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final db = AppDatabase.forTesting(NativeDatabase.memory());
      JellyfinApiCache.initialize(db);
      final downloadManager = DownloadManagerService(
        database: db,
        storageService: DownloadStorageService.instance,
        clientResolver: (serverId, {clientScopeId}) => null,
      );
      downloadManager.recoveryFuture = Future<void>.value();
      final downloadProvider = DownloadProvider.forTesting(downloadManager: downloadManager, database: db);
      await downloadProvider.ensureInitialized();

      final manager = MultiServerManager()..debugRegisterClientForTesting(client);
      final multiServerProvider = testMultiServerProvider(manager);
      final watchStateOverlay = WatchStateStore();

      addTearDown(() async {
        watchStateOverlay.dispose();
        downloadProvider.dispose();
        downloadManager.dispose();
        multiServerProvider.dispose();
        await db.close();
      });

      await tester.pumpWidget(
        TranslationProvider(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider<MultiServerProvider>.value(value: multiServerProvider),
              ChangeNotifierProvider<DownloadProvider>.value(value: downloadProvider),
              ChangeNotifierProvider<WatchStateStore>.value(value: watchStateOverlay),
            ],
            child: MaterialApp(
              theme: monoTheme(dark: true),
              home: scope(
                child: MediaDetailScreen(
                  metadata: show,
                  initialSeasonId: initialSeasonId,
                  initialSeasonIndex: initialSeasonIndex,
                  initialEpisodeId: initialEpisodeId,
                ),
              ),
            ),
          ),
        ),
      );

      await tester.pump();
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
    }

    Finder episodeCardFor(String title) => find.ancestor(of: find.text(title), matching: find.byType(EpisodeCard));

    bool episodeRowWatched(WidgetTester tester, String title) {
      final card = episodeCardFor(title);
      expect(card, findsOneWidget, reason: 'episode row "$title" should be visible');
      return tester.any(find.descendant(of: card, matching: find.byIcon(Symbols.check_rounded)));
    }

    bool episodeRowHasProgress(WidgetTester tester, String title) {
      final card = episodeCardFor(title);
      expect(card, findsOneWidget, reason: 'episode row "$title" should be visible');
      return tester.any(find.descendant(of: card, matching: find.byType(LinearProgressIndicator)));
    }

    Future<void> emit(WidgetTester tester, void Function() send) async {
      send();
      await tester.pump();
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 100));
    }

    _FakeMediaServerClient singleSeasonClient(MediaItem show) {
      final season = buildSeason(show, 1);
      return _FakeMediaServerClient(
        show: show,
        childrenByParent: {
          show.id: [season],
          season.id: [buildEpisode(show, season, 1)],
        },
      );
    }

    testWidgets('shows directors when they are the only additional info', (tester) async {
      final movie = testMediaItem(
        id: 'director_only',
        backend: MediaBackend.jellyfin,
        kind: MediaKind.movie,
        title: 'Director-only metadata',
        directors: ['Jane Director'],
        serverId: 'server_1',
        serverName: 'Server',
      );
      final client = _FakeMediaServerClient(show: movie, childrenByParent: const {});

      await pumpPhoneDetail(tester, client, movie);

      expect(find.text('Director'), findsOneWidget);
      expect(find.text('Jane Director'), findsOneWidget);
    });

    testWidgets('omits the director row for an empty list', (tester) async {
      final movie = testMediaItem(
        id: 'no_directors',
        backend: MediaBackend.jellyfin,
        kind: MediaKind.movie,
        title: 'No directors',
        studio: 'Example Studio',
        directors: const [],
        serverId: 'server_1',
        serverName: 'Server',
      );
      final client = _FakeMediaServerClient(show: movie, childrenByParent: const {});

      await pumpPhoneDetail(tester, client, movie);

      expect(find.text('Example Studio'), findsOneWidget);
      expect(find.text('Director'), findsNothing);
    });

    testWidgets('portrait phone hero shows square art instead of the cropped backdrop', (tester) async {
      final movie = testMediaItem(
        id: 'square_hero',
        backend: MediaBackend.jellyfin,
        kind: MediaKind.movie,
        title: 'Square hero',
        artPath: '/library/metadata/square_hero/art',
        backgroundSquarePath: '/library/metadata/square_hero/squareBg',
        serverId: 'server_1',
        serverName: 'Server',
      );
      final client = _FakeMediaServerClient(show: movie, childrenByParent: const {});

      await pumpPhoneDetail(tester, client, movie);

      final backdrop = find.byType(CyclingMediaBackdrop);
      expect(backdrop, findsOneWidget);
      // A fallback is reached only once every rotating path has failed, so the
      // square background has to be in the rotation set. Listed behind a
      // servable wide backdrop it would never be shown at all.
      final widget = tester.widget<CyclingMediaBackdrop>(backdrop);
      expect(widget.imagePaths, ['/library/metadata/square_hero/squareBg']);
      expect(widget.fallbackImagePaths, contains('/library/metadata/square_hero/art'));
      expect(client.thumbnailPaths.first, '/library/metadata/square_hero/squareBg');
    });

    FocusNode overviewFocusNode(WidgetTester tester) {
      final overviewFocus = find.byWidgetPredicate(
        (widget) => widget is Focus && widget.focusNode?.debugLabel == 'overview',
        description: 'overview focus widget',
      );
      expect(overviewFocus, findsOneWidget);
      return tester.widget<Focus>(overviewFocus).focusNode!;
    }

    testWidgets('overflowing overview DOWN reaches the first real section', (tester) async {
      const summary =
          'A deliberately extensive overview repeats enough concrete detail to exceed the collapsed line limit. '
          'It describes the setting, the characters, the central conflict, and the consequences in full. '
          'A second passage adds more background, more context, and more narrative detail for the viewer. '
          'A third passage ensures the overview remains overflowing even across a wide phone test viewport. '
          'Finally, another complete passage keeps the text beyond four generous lines without relying on font timing.';
      final show = buildShow(summary: summary);

      await pumpPhoneDetail(tester, singleSeasonClient(show), show);

      final overviewText = tester.widget<Text>(
        find.descendant(of: find.byType(CollapsibleText), matching: find.byType(Text)).first,
      );
      expect(overviewText.textSpan, isNotNull);
      expect(overviewText.textSpan!.toPlainText(), isNot(summary));

      final overviewNode = overviewFocusNode(tester);
      overviewNode.requestFocus();
      await tester.pump();
      expect(overviewNode.hasFocus, isTrue);

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();

      expect(FocusManager.instance.primaryFocus?.debugLabel, 'first_episode');
    });

    testWidgets('short overview accepts focus and preserves DOWN then episode UP navigation', (tester) async {
      const summary = 'A short overview.';
      final show = buildShow(summary: summary);

      await pumpPhoneDetail(tester, singleSeasonClient(show), show);

      expect(find.text(summary), findsOneWidget);
      final overviewNode = overviewFocusNode(tester);
      expect(overviewNode.context, isNotNull);
      overviewNode.requestFocus();
      await tester.pump();
      expect(overviewNode.hasFocus, isTrue);

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      expect(FocusManager.instance.primaryFocus?.debugLabel, 'first_episode');

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowUp);
      await tester.pump();
      expect(FocusManager.instance.primaryFocus?.debugLabel, 'overview');
    });

    testWidgets('phone detail opens on the requested season', (tester) async {
      final show = buildShow();
      final season1 = buildSeason(show, 1);
      final season2 = buildSeason(show, 2);
      final client = _FakeMediaServerClient(
        show: show,
        childrenByParent: {
          show.id: [season1, season2],
          season1.id: [buildEpisode(show, season1, 1)],
          season2.id: [buildEpisode(show, season2, 1)],
        },
      );

      await pumpPhoneDetail(tester, client, show, initialSeasonId: season2.id);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Episode S2E1'), findsOneWidget);
      // The row marks which season is showing without needing a tap.
      final handle = tester.ensureSemantics();
      final pill = tester.getSemantics(
        find.descendant(of: find.byType(SeasonSelector), matching: find.text('S2')),
      );
      expect(pill.flagsCollection.isSelected, Tristate.isTrue);
      handle.dispose();
    });

    testWidgets('phone detail focuses requested episode row', (tester) async {
      final show = buildShow();
      final season1 = buildSeason(show, 1);
      final season2 = buildSeason(show, 2);
      final episode2 = buildEpisode(show, season2, 2);
      final client = _FakeMediaServerClient(
        show: show,
        childrenByParent: {
          show.id: [season1, season2],
          season1.id: [buildEpisode(show, season1, 1)],
          season2.id: [buildEpisode(show, season2, 1), episode2, buildEpisode(show, season2, 3)],
        },
      );

      await pumpPhoneDetail(
        tester,
        client,
        show,
        initialSeasonId: season2.id,
        initialSeasonIndex: season2.index,
        initialEpisodeId: episode2.id,
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      expect(find.text('Episode S2E2'), findsOneWidget);
      expect(FocusManager.instance.primaryFocus?.debugLabel, 'initial_episode');
    });

    testWidgets('phone detail keeps the first-episode role node when it is the target', (tester) async {
      final show = buildShow();
      final season1 = buildSeason(show, 1);
      final season2 = buildSeason(show, 2);
      final episode1 = buildEpisode(show, season2, 1);
      final client = _FakeMediaServerClient(
        show: show,
        childrenByParent: {
          show.id: [season1, season2],
          season1.id: [buildEpisode(show, season1, 1)],
          season2.id: [episode1, buildEpisode(show, season2, 2), buildEpisode(show, season2, 3)],
        },
      );

      await pumpPhoneDetail(
        tester,
        client,
        show,
        initialSeasonId: season2.id,
        initialSeasonIndex: season2.index,
        initialEpisodeId: episode1.id,
      );
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 200));

      // The first row keeps _firstEpisodeFocusNode (so season-tab DOWN keeps
      // working) and the initial focus lands on that node instead.
      expect(find.text('Episode S2E1'), findsOneWidget);
      expect(FocusManager.instance.primaryFocus?.debugLabel, 'first_episode');
    });

    testWidgets('container mark overrides an older per-episode patch', (tester) async {
      final show = buildShow();
      final season1 = buildSeason(show, 1);
      final episode1 = buildEpisode(show, season1, 1);
      final episode2 = buildEpisode(show, season1, 2);
      final client = _FakeMediaServerClient(
        show: show,
        childrenByParent: {
          show.id: [season1, buildSeason(show, 2)],
          season1.id: [episode1, episode2],
        },
      );

      await pumpPhoneDetail(tester, client, show);

      // Seed a session patch for one episode (e.g. user toggled it earlier).
      await emit(tester, () => WatchStateNotifier().notifyWatched(item: episode1, isNowWatched: false));
      expect(episodeRowWatched(tester, 'Episode S1E1'), isFalse);

      await emit(tester, () => WatchStateNotifier().notifyWatched(item: show, isNowWatched: true));

      expect(episodeRowWatched(tester, 'Episode S1E1'), isTrue);
      expect(episodeRowWatched(tester, 'Episode S1E2'), isTrue);
    });

    testWidgets('marking a season watched flips its episode rows', (tester) async {
      final show = buildShow();
      final season1 = buildSeason(show, 1);
      final season2 = buildSeason(show, 2);
      final client = _FakeMediaServerClient(
        show: show,
        childrenByParent: {
          show.id: [season1, season2],
          season1.id: [buildEpisode(show, season1, 1), buildEpisode(show, season1, 2)],
          season2.id: [buildEpisode(show, season2, 1)],
        },
      );

      await pumpPhoneDetail(tester, client, show);

      await emit(tester, () => WatchStateNotifier().notifyWatched(item: season1, isNowWatched: true));

      expect(episodeRowWatched(tester, 'Episode S1E1'), isTrue);
      expect(episodeRowWatched(tester, 'Episode S1E2'), isTrue);
    });

    testWidgets('container mark clears progress, including after a season round-trip', (tester) async {
      final show = buildShow();
      final season1 = buildSeason(show, 1);
      final season2 = buildSeason(show, 2);
      final episode1 = buildEpisode(show, season1, 1);
      final client = _FakeMediaServerClient(
        show: show,
        childrenByParent: {
          show.id: [season1, season2],
          season1.id: [episode1, buildEpisode(show, season1, 2)],
          season2.id: [buildEpisode(show, season2, 1)],
        },
      );

      await pumpPhoneDetail(tester, client, show);

      // Played partway earlier in the session.
      await emit(
        tester,
        () => WatchStateNotifier().notifyProgress(item: episode1, viewOffset: 600000, duration: 1800000),
      );
      expect(episodeRowHasProgress(tester, 'Episode S1E1'), isTrue);

      await emit(tester, () => WatchStateNotifier().notifyWatched(item: show, isNowWatched: true));
      expect(episodeRowHasProgress(tester, 'Episode S1E1'), isFalse);
      expect(episodeRowWatched(tester, 'Episode S1E1'), isTrue);

      // Round-trip through another season; the cached page restore must not
      // resurrect the dead progress offset.
      await pickSeason(tester, 'S2');
      await pickSeason(tester, 'S1');

      expect(episodeRowHasProgress(tester, 'Episode S1E1'), isFalse);
      expect(episodeRowWatched(tester, 'Episode S1E1'), isTrue);
    });
  });
}

class _FakeMediaServerClient implements MediaServerClient {
  final MediaItem show;
  final Map<String, List<MediaItem>> childrenByParent;
  final Map<String, Future<List<MediaItem>>> childrenPageFutures;
  final Map<String, Object> childrenPageErrors;
  final Future<List<MediaItem>>? pendingPlayableDescendants;
  final childrenPageCalls = <({String parentId, int? start, int? size})>[];
  final thumbnailPaths = <String?>[];

  _FakeMediaServerClient({
    required this.show,
    required this.childrenByParent,
    this.childrenPageFutures = const {},
    this.childrenPageErrors = const {},
    this.pendingPlayableDescendants,
  });

  @override
  ServerId get serverId => ServerId('server_1');

  @override
  String? get serverName => 'Server';

  @override
  MediaBackend get backend => MediaBackend.jellyfin;


  @override
  Future<({MediaItem? item, MediaItem? onDeckEpisode})> fetchItemWithOnDeck(String id) async {
    return (item: show, onDeckEpisode: null);
  }

  @override
  Future<MediaItem?> fetchItem(String id) async {
    if (show.id == id) return show;
    for (final items in childrenByParent.values) {
      for (final item in items) {
        if (item.id == id) return item;
      }
    }
    return null;
  }

  @override
  Future<List<MediaItem>> fetchChildren(String parentId) async {
    return childrenByParent[parentId] ?? const [];
  }

  @override
  Future<LibraryPage<MediaItem>> fetchChildrenPage(
    String parentId, {
    int? start,
    int? size,
    AbortController? abort,
  }) async {
    childrenPageCalls.add((parentId: parentId, start: start, size: size));
    final error = childrenPageErrors[parentId];
    if (error != null) throw error;
    final all =
        await (childrenPageFutures[parentId] ?? Future.value(childrenByParent[parentId] ?? const <MediaItem>[]));
    return fakeLibraryPage(all, start: start, size: size);
  }

  @override
  Future<LibraryPage<MediaItem>> fetchPlayableDescendantsPage(
    String parentId, {
    int? start,
    int? size,
    AbortController? abort,
  }) async {
    final items = await pendingPlayableDescendants!;
    return LibraryPage(items: items, totalCount: items.length, offset: start ?? 0);
  }

  @override
  Future<List<MediaHub>> fetchRelatedHubs(String id, {int count = 10}) async => const [];

  @override
  String thumbnailUrl(String? path, {int? width, int? height, bool cover = true}) {
    thumbnailPaths.add(path);
    return '';
  }

  @override
  void close() {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RecordingNavigatorObserver extends NavigatorObserver {
  _RecordingNavigatorObserver({this.popVideoPlayerImmediately = false});

  final bool popVideoPlayerImmediately;
  final pushedRouteNames = <String?>[];

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    pushedRouteNames.add(route.settings.name);
    if (popVideoPlayerImmediately && route.settings.name == kVideoPlayerRouteName) {
      scheduleMicrotask(() => navigator?.pop());
    }
  }
}
