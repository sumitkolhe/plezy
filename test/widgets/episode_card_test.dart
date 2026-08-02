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
import 'package:harbor/services/download_manager_service.dart';
import 'package:harbor/services/download_storage_service.dart';
import 'package:harbor/services/jellyfin_api_cache.dart';
import 'package:harbor/services/settings_service.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/utils/platform_detector.dart';
import 'package:harbor/widgets/episode_card.dart';
import 'package:provider/provider.dart';

import '../test_helpers/media_items.dart';
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
    expect(summaryText.maxLines, 2);
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

  testWidgets('the fact line wraps rather than hiding what does not fit', (tester) async {
    final episode = testMediaItem(
      id: 'wrapping_meta_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Aftermath',
      index: 12,
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

    final meta = tester.widgetList<Text>(find.byType(Text)).firstWhere(
      (text) => (text.textSpan?.toPlainText() ?? '').contains('1.50 GB'),
    );
    expect(meta.maxLines, 2);
    final facts = meta.textSpan!.toPlainText();
    for (final fact in ['E12', '52:00', '1080p', 'EAC3 5.1', '1.50 GB']) {
      expect(facts, contains(fact));
    }
  });

  testWidgets('summary sits under the fact line in the text column', (tester) async {
    const summary = 'A quiet episode in which very little happens and everyone talks about it afterwards.';
    final episode = testMediaItem(
      id: 'ordered_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Aftermath',
      index: 5,
      summary: summary,
      durationMs: 42 * 60 * 1000,
    );

    await _pumpEpisodeCard(tester, episode);

    final title = tester.getRect(find.text('Aftermath'));
    final summaryRect = tester.getRect(find.text(summary));
    final still = tester.getRect(find.byType(AspectRatio).first);

    // Same column as the title, below it, and clear of the still.
    expect(summaryRect.left, title.left);
    expect(summaryRect.top, greaterThan(title.bottom));
    expect(summaryRect.left, greaterThan(still.right));
  });

  testWidgets('shows file size alongside media quality labels', (tester) async {
    final episode = testMediaItem(
      id: 'sized_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'A Large Episode',
      index: 4,
      durationMs: 52 * 60 * 1000,
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

    // One mono line rather than a wrap of separate chips.
    final meta = tester
        .widgetList<Text>(find.byType(Text))
        .map((text) => text.data ?? text.textSpan?.toPlainText() ?? '')
        .firstWhere((value) => value.contains('1.50 GB'));
    expect(meta, contains('EAC3 5.1'));
  });
}

Future<void> _pumpEpisodeCard(WidgetTester tester, MediaItem episode) async {
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
      child: ChangeNotifierProvider<DownloadProvider>.value(
        value: downloadProvider,
        child: MaterialApp(
          theme: monoTheme(dark: true),
          home: Scaffold(
            body: SizedBox(
              width: 360,
              child: EpisodeCard(episode: episode, isOffline: true, onTap: () {}),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}
