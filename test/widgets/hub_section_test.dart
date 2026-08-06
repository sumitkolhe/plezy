import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/theme/phosphor_icons.dart';
import 'package:harbor/focus/input_mode_tracker.dart';
import 'package:harbor/focus/locked_hub_controller.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_hub.dart';
import 'package:harbor/media/media_item.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/services/settings_service.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/utils/platform_detector.dart';
import 'package:harbor/widgets/media_card.dart';
import 'package:harbor/widgets/hub_section.dart';

import '../test_helpers/media_items.dart';
import '../test_helpers/prefs.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    LocaleSettings.setLocaleSync(AppLocale.en);
    resetSharedPreferencesForTest();
    SettingsService.resetForTesting();
    await SettingsService.getInstance();
  });

  tearDown(() {
    TvDetectionService.debugSetAppleTVOverride(null);
  });

  testWidgets('custom item callbacks own pointer actions', (tester) async {
    final item = testMediaItem(
      id: 'pointer_item',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.movie,
      title: 'Pointer Movie',
    );
    MediaItem? tappedItem;
    MediaItem? longPressedItem;

    await tester.pumpWidget(
      _TestApp(
        child: HubSection(
          hub: _hubWith(item),
          focusMemory: HubFocusMemory(),
          icon: PhosphorIcons.television,
          onItemTap: (value) => tappedItem = value,
          onItemLongPress: (value) => longPressedItem = value,
        ),
      ),
    );

    await tester.tap(find.text('Pointer Movie'));
    expect(tappedItem, same(item));

    await tester.longPress(find.text('Pointer Movie'));
    expect(longPressedItem, same(item));
  });

  testWidgets('custom item callbacks own D-pad actions', (tester) async {
    final item = testMediaItem(
      id: 'dpad_item',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.movie,
      title: 'D-pad Movie',
    );
    final hubKey = GlobalKey<HubSectionState>();
    MediaItem? tappedItem;
    MediaItem? longPressedItem;

    await tester.pumpWidget(
      InputModeTracker(
        child: _TestApp(
          child: HubSection(
            key: hubKey,
            hub: _hubWith(item),
            focusMemory: HubFocusMemory(),
            icon: PhosphorIcons.television,
            onItemTap: (value) => tappedItem = value,
            onItemLongPress: (value) => longPressedItem = value,
          ),
        ),
      ),
    );

    hubKey.currentState!.requestFocusAt(0);
    await tester.pump();

    await tester.sendKeyEvent(LogicalKeyboardKey.select);
    expect(tappedItem, same(item));

    await tester.sendKeyEvent(LogicalKeyboardKey.contextMenu);
    expect(longPressedItem, same(item));
  });

  testWidgets('grid poster override uses dense 2:3 TV geometry', (tester) async {
    TvDetectionService.debugSetAppleTVOverride(true);
    await SettingsService.instance.write(SettingsService.cardOrientation, CardOrientation.portrait);
    final item = testMediaItem(
      id: 'poster_episode',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.episode,
      title: 'Poster Episode',
      parentIndex: 1,
      index: 2,
      thumbPath: '/episode-thumb.jpg',
      grandparentThumbPath: '/series-poster.jpg',
    );

    await tester.pumpWidget(
      _TestApp(
        child: HubSection(
          hub: _hubWith(item),
          focusMemory: HubFocusMemory(),
          icon: PhosphorIcons.television,
          cardSizing: HubCardSizing.grid,
          episodePosterModeOverride: EpisodePosterMode.seriesPoster,
        ),
      ),
    );

    final mediaCard = tester.widget<MediaCard>(find.byType(MediaCard));
    expect(mediaCard.episodePosterModeOverride, EpisodePosterMode.seriesPoster);

    final poster = find.descendant(of: find.byType(MediaCard), matching: find.byType(ClipRRect)).first;
    final posterSize = tester.getSize(poster);
    expect(posterSize.height / posterSize.width, closeTo(1.5, 0.001));

    final outerPadding = tester.widget<Padding>(
      find.descendant(of: find.byType(HubSection), matching: find.byType(Padding)).first,
    );
    expect(outerPadding.padding.resolve(TextDirection.ltr).bottom, 0);
  });

  testWidgets('the caret marks the end of the header rather than trailing the title', (tester) async {
    final item = testMediaItem(
      id: 'counted_item',
      backend: MediaBackend.jellyfin,
      kind: MediaKind.movie,
      title: 'Counted Movie',
    );
    final hub = MediaHub(id: 'counted_hub', title: 'Popular', type: 'mixed', items: [item], size: 237, more: true);

    await tester.pumpWidget(
      _TestApp(
        child: HubSection(hub: hub, focusMemory: HubFocusMemory(), icon: PhosphorIcons.filmSlate),
      ),
    );

    final section = tester.getRect(find.byType(HubSection));
    final caret = tester.getRect(find.byIcon(PhosphorIcons.caretRight));
    final title = tester.getRect(find.text('Popular'));

    expect(section.right - caret.right, lessThan(24), reason: 'the caret belongs at the row end');
    expect(title.left, lessThan(40), reason: 'the title stays at the row start');
  });

  testWidgets('restores within one owner but resets for a fresh owner', (tester) async {
    final items = [
      for (var index = 0; index < 3; index++)
        testMediaItem(id: 'item_$index', backend: MediaBackend.jellyfin, kind: MediaKind.movie, title: 'Item $index'),
    ];
    MediaHub hub(String id) => MediaHub(id: id, title: id, type: 'movie', items: items, size: items.length);

    final ownerA = HubFocusMemory();
    final ownerB = HubFocusMemory();
    String? focusedItemId;

    Future<void> mount({
      required HubFocusMemory owner,
      required String hubId,
      required GlobalKey<HubSectionState> key,
    }) async {
      await tester.pumpWidget(
        _TestApp(
          child: HubSection(
            key: key,
            hub: hub(hubId),
            focusMemory: owner,
            icon: PhosphorIcons.filmSlate,
            onFocusedItemChanged: (item) => focusedItemId = item.id,
          ),
        ),
      );
    }

    final firstMountKey = GlobalKey<HubSectionState>();
    await mount(owner: ownerA, hubId: 'detail_episodes', key: firstMountKey);
    firstMountKey.currentState!.requestFocusAt(2);
    await tester.pumpAndSettle();
    expect(focusedItemId, 'item_2');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();

    final remountKey = GlobalKey<HubSectionState>();
    await mount(owner: ownerA, hubId: 'detail_episodes', key: remountKey);
    remountKey.currentState!.requestFocusFromMemory();
    await tester.pumpAndSettle();
    expect(focusedItemId, 'item_2');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();

    final secondHubKey = GlobalKey<HubSectionState>();
    await mount(owner: ownerA, hubId: 'detail_extras', key: secondHubKey);
    secondHubKey.currentState!.requestFocusFromMemory();
    await tester.pumpAndSettle();
    expect(focusedItemId, 'item_2');

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();

    final freshOwnerKey = GlobalKey<HubSectionState>();
    await mount(owner: ownerB, hubId: 'detail_episodes', key: freshOwnerKey);
    freshOwnerKey.currentState!.requestFocusFromMemory();
    await tester.pumpAndSettle();
    expect(focusedItemId, 'item_0');
  });
}

MediaHub _hubWith(MediaItem item) {
  return MediaHub(id: 'live_tv_hub', title: 'Live TV', type: 'mixed', items: [item], size: 1, serverId: item.serverId);
}

class _TestApp extends StatelessWidget {
  final Widget child;

  const _TestApp({required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: monoTheme(MonoPalette.dark),
      home: Scaffold(body: ListView(children: [child])),
    );
  }
}
