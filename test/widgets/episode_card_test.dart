import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/database/app_database.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_item.dart';
import 'package:harbor/media/media_part.dart';
import 'package:harbor/media/media_stream.dart';
import 'package:harbor/media/media_version.dart';
import 'package:harbor/providers/download_provider.dart';
import 'package:harbor/providers/multi_server_provider.dart';
import 'package:harbor/services/download_manager_service.dart';
import 'package:harbor/services/download_storage_service.dart';
import 'package:harbor/services/jellyfin_api_cache.dart';
import 'package:harbor/services/settings_service.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/utils/rating_spans.dart';
import 'package:harbor/utils/platform_detector.dart';
import 'package:harbor/widgets/episode_card.dart';
import 'package:harbor/widgets/episode_detail_sheet.dart';
import 'package:provider/provider.dart';

import '../test_helpers/media_items.dart';
import '../test_helpers/multi_server_fixtures.dart';
import '../test_helpers/prefs.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    resetSharedPreferencesForTest();
    SettingsService.resetForTesting();
    TvDetectionService.debugSetAppleTVOverride(false);
    LocaleSettings.setLocaleSync(AppLocale.en);
    await SettingsService.getInstance();
  });

  tearDown(() {
    TvDetectionService.debugSetAppleTVOverride(null);
  });

  testWidgets('overflowing summary stays in card semantics without an Expand label', (tester) async {
    final semantics = tester.ensureSemantics();
    const summary =
        'The expedition follows a careful team through an unfamiliar landscape while each discovery changes their plans.';
    final episode = testMediaItem(
      id: 'semantic_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'A Difficult Crossing',
      index: 3,
      summary: summary,
      durationMs: 42 * 60 * 1000,
    );

    await _pumpEpisodeCard(tester, episode);

    // Clamped in place of the old expandable text: rows stay a uniform height,
    // and the full summary still reaches semantics.
    final summaryText = tester.widget<Text>(find.text(summary));
    expect(summaryText.maxLines, isNotNull);
    expect(summaryText.overflow, TextOverflow.ellipsis);

    final semanticNodes = <SemanticsNode>[];
    void collectSemantics(SemanticsNode node) {
      semanticNodes.add(node);
      node.visitChildren((child) {
        collectSemantics(child);
        return true;
      });
    }

    collectSemantics(tester.binding.renderViews.single.owner!.semanticsOwner!.rootSemanticsNode!);
    final cardSemantics = semanticNodes.singleWhere((node) => node.label.contains('A Difficult Crossing'));
    expect(cardSemantics.label, contains('The expedition follows a careful team'));
    expect(cardSemantics.label, isNot(contains('Expand')));
    expect(cardSemantics.getSemanticsData().hasAction(SemanticsAction.tap), isTrue);
    semantics.dispose();
  });

  testWidgets('the row is exactly as tall as its still, however long the text', (tester) async {
    final episode = testMediaItem(
      id: 'clamped_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'A Title Long Enough To Wrap Onto A Second Line On A Phone',
      index: 12,
      summary: 'C' * 600,
      durationMs: 42 * 60 * 1000,
    );

    await _pumpEpisodeCard(tester, episode);

    final still = tester.getSize(find.byType(AspectRatio).first);
    final row = tester.getSize(find.descendant(of: find.byType(EpisodeCard), matching: find.byType(Row)).first);
    expect(row.height, still.height);
    expect(tester.widget<Text>(find.text('C' * 600)).overflow, TextOverflow.ellipsis);
  });

  testWidgets('the still plays and the rest of the row opens the details', (tester) async {
    const summary = 'A quiet episode in which very little happens and everyone talks about it afterwards.';
    var plays = 0;
    final episode = testMediaItem(
      id: 'split_target_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Aftermath',
      index: 5,
      summary: summary,
      durationMs: 42 * 60 * 1000,
    );

    await _pumpEpisodeCard(tester, episode, onTap: () => plays++);

    await tester.tap(find.byType(AspectRatio).first);
    await tester.pumpAndSettle();
    expect(plays, 1);
    expect(find.byType(EpisodeDetailSheet), findsNothing);

    await tester.tap(find.text('E5${dotSeparator}Aftermath'));
    await tester.pumpAndSettle();
    expect(find.byType(EpisodeDetailSheet), findsOneWidget);
    expect(plays, 1, reason: 'opening the details must not start playback');
  });

  testWidgets('the details sheet carries the summary the row had to clamp', (tester) async {
    final summary = 'Long enough to clamp. ${'Detail sentence. ' * 20}';
    final episode = testMediaItem(
      id: 'sheet_summary_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Aftermath',
      index: 5,
      summary: summary,
      durationMs: 42 * 60 * 1000,
    );

    await _pumpEpisodeCard(tester, episode);
    expect(tester.widget<Text>(find.text(summary)).maxLines, 2);

    await tester.tap(find.text('E5${dotSeparator}Aftermath'));
    await tester.pumpAndSettle();

    final inSheet = find.descendant(of: find.byType(EpisodeDetailSheet), matching: find.text(summary));
    expect(tester.widget<Text>(inSheet).maxLines, isNull);
  });

  testWidgets('the sheet lists every fact as its own pill', (tester) async {
    final episode = testMediaItem(
      id: 'faceted_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'A Large Episode',
      index: 4,
      durationMs: 52 * 60 * 1000,
      originallyAvailableAt: '2019-04-14',
      mediaVersions: const [
        MediaVersion(
          id: 'source',
          videoResolution: '1080',
          parts: [
            MediaPart(
              id: 'part-1',
              sizeBytes: 1536 * 1024 * 1024,
              streams: [
                MediaStream(id: 'audio', kind: MediaStreamKind.audio, codec: 'eac3', channels: 6, selected: true),
              ],
            ),
          ],
        ),
      ],
    );

    await _pumpEpisodeCard(tester, episode);

    // The row itself no longer carries them.
    expect(find.text('1.50 GB'), findsNothing);

    await tester.tap(find.text('E4${dotSeparator}A Large Episode'));
    await tester.pumpAndSettle();

    final sheet = find.byType(EpisodeDetailSheet);
    for (final labelled in [
      (t.fileInfo.duration, '52:00'),
      (t.fileInfo.video, '1080p'),
      (t.fileInfo.audio, 'EAC3 5.1'),
      (t.fileInfo.size, '1.50 GB'),
    ]) {
      expect(
        find.descendant(of: sheet, matching: find.text(labelled.$2)),
        findsOneWidget,
        reason: '"${labelled.$2}" should have its own pill',
      );
      expect(
        find.descendant(of: sheet, matching: find.text(labelled.$1)),
        findsOneWidget,
        reason: '"${labelled.$2}" should say what it is',
      );
    }
    expect(find.descendant(of: sheet, matching: find.text(t.metadataEdit.releaseDate)), findsOneWidget);
  });

  testWidgets('the details sheet offers the primary actions as circles under Play', (tester) async {
    final episode = testMediaItem(
      id: 'action_pill_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Downstream',
      index: 7,
      durationMs: 30 * 60 * 1000,
    );

    // Narrow enough that the preferred diameter cannot fit, since the sheet
    // spans the surface rather than the card.
    await tester.binding.setSurfaceSize(const Size(300, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await _pumpEpisodeCard(tester, episode);
    await tester.tap(find.text('E7${dotSeparator}Downstream'));
    await tester.pumpAndSettle();

    final sheet = find.byType(EpisodeDetailSheet);
    // Unlabelled, so the label has to survive as the tooltip.
    for (final label in [t.mediaMenu.rate, t.downloads.downloadNow, t.mediaMenu.fileInfo, t.tooltips.moreOptions]) {
      expect(find.descendant(of: sheet, matching: find.byTooltip(label)), findsOneWidget, reason: label);
    }
    // Reachable behind the options circle rather than promoted to one.
    expect(find.descendant(of: sheet, matching: find.byTooltip(t.mediaMenu.markAsWatched)), findsNothing);

    // Below Play, not above it.
    expect(
      tester.getTopLeft(find.byTooltip(t.mediaMenu.rate)).dy,
      greaterThan(tester.getBottomLeft(find.text(t.common.play)).dy),
    );

    // One row: at the preferred diameter these overrun a phone's width, and a
    // lone wrapped circle reads as a mistake.
    final tops = [
      for (final label in [t.mediaMenu.rate, t.downloads.downloadNow, t.mediaMenu.fileInfo, t.tooltips.moreOptions])
        tester.getTopLeft(find.byTooltip(label)).dy,
    ];
    expect(tops, everyElement(closeTo(tops.first, 0.01)));
    expect(tester.getSize(find.byTooltip(t.tooltips.moreOptions)).width, lessThan(58));

    // Selecting one closes the sheet, the way choosing from the menu does.
    await tester.tap(find.byTooltip(t.mediaMenu.rate));
    await tester.pumpAndSettle();
    expect(sheet, findsNothing);
  });

  testWidgets('the options circle reaches the actions the circles left out', (tester) async {
    final episode = testMediaItem(
      id: 'options_circle_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Overflow',
      index: 8,
      durationMs: 30 * 60 * 1000,
    );

    await _pumpEpisodeCard(tester, episode);
    await tester.tap(find.text('E8${dotSeparator}Overflow'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip(t.tooltips.moreOptions));
    await tester.pumpAndSettle();

    // The menu holds an open-guard until the sheet's result is dispatched, so
    // this only appears if the reopen waited for that.
    expect(find.byType(EpisodeDetailSheet), findsNothing);
    expect(find.text(t.mediaMenu.markAsWatched), findsOneWidget);
  });
}

Future<void> _pumpEpisodeCard(WidgetTester tester, MediaItem episode, {VoidCallback? onTap}) async {
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
  addTearDown(() async {
    downloadProvider.dispose();
    downloadManager.dispose();
    await db.close();
  });

  await tester.pumpWidget(
    TranslationProvider(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<DownloadProvider>.value(value: downloadProvider),
          // The details sheet offers the long-press action set, which is gated
          // on the item's server.
          ChangeNotifierProvider<MultiServerProvider>.value(value: testMultiServer().provider),
        ],
        child: MaterialApp(
          theme: monoTheme(dark: true),
          home: Scaffold(
            body: SizedBox(
              width: 360,
              child: EpisodeCard(episode: episode, isOffline: true, onTap: onTap ?? () {}),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}
