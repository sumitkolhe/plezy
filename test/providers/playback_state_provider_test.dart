import 'package:flutter_test/flutter_test.dart';
import 'package:plezy/media/media_backend.dart';
import 'package:plezy/media/media_item.dart';
import 'package:plezy/media/media_kind.dart';
import 'package:plezy/media/media_part.dart';
import 'package:plezy/media/media_version.dart';
import 'package:plezy/media/play_queue.dart';
import 'package:plezy/providers/playback_state_provider.dart';
import '../test_helpers/media_items.dart';

JellyfinMediaItem _item(String ratingKey) =>
    JellyfinMediaItem(id: ratingKey, kind: MediaKind.episode, title: 'Episode $ratingKey');

/// Episode queue entry carrying file identity. Episodes of a multi-episode
/// file (`S02E24-E25.mkv`) get *distinct* part ids (`part-<ratingKey>` here,
/// mirroring real servers) but share [file].
JellyfinMediaItem _itemWithFile(String ratingKey, String file) => JellyfinMediaItem(
  id: ratingKey,
  kind: MediaKind.episode,
  title: 'Episode $ratingKey',
  mediaVersions: [
    MediaVersion(
      id: 'v-$ratingKey',
      parts: [MediaPart(id: 'part-$ratingKey', file: file)],
    ),
  ],
);

JellyfinMediaItem _miItem(String id) => JellyfinMediaItem(id: id, kind: MediaKind.episode);

/// Seeds the provider from a client-side queue. Queue ids are the items'
/// positions, so an item's index doubles as its `playQueueItemId`.
void _setQueue(
  PlaybackStateProvider p,
  List<MediaItem> items, {
  int currentIndex = 0,
  bool shuffled = false,
  String? contextKey,
}) {
  p.setPlaybackFromLocalQueue(
    LocalPlayQueue(id: 'q', items: items, backendId: 'jellyfin', currentIndex: currentIndex, shuffled: shuffled),
    contextKey: contextKey,
  );
}

void main() {
  group('PlaybackStateProvider', () {
    test('starts in idle state with no queue', () {
      final p = PlaybackStateProvider();
      expect(p.isQueueActive, isFalse);
      expect(p.isPlaylistActive, isFalse);
      expect(p.isShuffleActive, isFalse);
      expect(p.playQueueId, isNull);
      expect(p.currentPlayQueueItemID, isNull);
      expect(p.shuffleContextKey, isNull);
      expect(p.loadedItems, isEmpty);
      p.dispose();
    });

    test('setPlaybackFromLocalQueue populates state and notifies', () async {
      final p = PlaybackStateProvider();
      var notified = 0;
      p.addListener(() => notified++);

      final items = [_item('100'), _item('101'), _item('102')];

      _setQueue(p, items, currentIndex: 1, shuffled: true, contextKey: 'show-key');

      expect(p.currentPlayQueueItemID, 1);
      expect(p.isShuffleActive, isTrue);
      expect(p.isPlaylistActive, isTrue);
      expect(p.isQueueActive, isTrue);
      expect(p.shuffleContextKey, 'show-key');
      expect(p.loadedItems, hasLength(3));
      expect(notified, 1);

      p.dispose();
    });

    test('clearShuffle resets all state and notifies', () async {
      final p = PlaybackStateProvider();
      _setQueue(p, [_item('a'), _item('b')], contextKey: 'context-1');
      expect(p.isQueueActive, isTrue);

      var notified = 0;
      p.addListener(() => notified++);

      p.clearShuffle();
      expect(p.isQueueActive, isFalse);
      expect(p.isPlaylistActive, isFalse);
      expect(p.isShuffleActive, isFalse);
      expect(p.playQueueId, isNull);
      expect(p.currentPlayQueueItemID, isNull);
      expect(p.shuffleContextKey, isNull);
      expect(p.loadedItems, isEmpty);
      expect(notified, 1);

      p.dispose();
    });

    test('setCurrentItem updates the cursor only for validated queue members', () async {
      final p = PlaybackStateProvider();

      var notified = 0;
      p.addListener(() => notified++);
      p.setCurrentItem(_miItem('a'));
      expect(p.currentPlayQueueItemID, isNull);
      expect(notified, 0);

      _setQueue(p, [_item('a'), _item('b')]);
      final preNotify = notified;

      // A fresh copy of a real loaded member is accepted.
      p.setCurrentItem(_item('b'));
      expect(p.currentPlayQueueItemID, 1);
      expect(notified, preNotify + 1);

      // An item outside this queue cannot poison the cursor.
      p.setCurrentItem(_miItem('outsider'));
      expect(p.currentPlayQueueItemID, 1);
      expect(notified, preNotify + 1);

      p.dispose();
    });

    test('getNextEpisode returns next loaded item when current is mid-window', () async {
      final p = PlaybackStateProvider();
      _setQueue(p, [_item('a'), _item('b'), _item('c')], currentIndex: 1);

      final next = await p.getNextEpisode('b');
      expect(next.status, QueueNavigationStatus.found);
      expect(next.item!.id, 'c');

      // currentPlayQueueItemID is NOT updated by getNextEpisode (setCurrentItem does that).
      expect(p.currentPlayQueueItemID, 1);

      p.dispose();
    });

    test('getNextEpisode reports the queue boundary at the end', () async {
      final p = PlaybackStateProvider();
      _setQueue(p, [_item('a'), _item('b')], currentIndex: 1);

      final next = await p.getNextEpisode('b');
      expect(next.status, QueueNavigationStatus.boundary);
      expect(next.item, isNull);

      p.dispose();
    });

    test('getNextEpisode anchors on the supplied media key instead of a stale cursor', () async {
      final p = PlaybackStateProvider();
      addTearDown(p.dispose);
      _setQueue(p, [_item('a'), _item('b'), _item('c')]);

      final next = await p.getNextEpisode('b');

      expect(next.status, QueueNavigationStatus.found);
      expect(next.item!.id, 'c');
      expect(p.currentPlayQueueItemID, 0, reason: 'read-only lookup must not move the playback cursor');
    });

    test('getNextEpisode reports unavailable with no active queue', () async {
      final p = PlaybackStateProvider();
      final next = await p.getNextEpisode('any-key');
      expect(next.status, QueueNavigationStatus.unavailable);
      expect(next.item, isNull);
      p.dispose();
    });

    test('getPreviousEpisode returns previous loaded item when current is mid-window', () async {
      final p = PlaybackStateProvider();
      _setQueue(p, [_item('a'), _item('b'), _item('c')], currentIndex: 1);

      final previous = await p.getPreviousEpisode('b');
      expect(previous.status, QueueNavigationStatus.found);
      expect(previous.item!.id, 'a');

      p.dispose();
    });

    test('getPreviousEpisode at index 0 returns null', () async {
      final p = PlaybackStateProvider();
      _setQueue(p, [_item('a'), _item('b')]);

      final previous = await p.getPreviousEpisode('a');
      expect(previous.status, QueueNavigationStatus.boundary);
      expect(previous.item, isNull);

      p.dispose();
    });

    test('getPreviousEpisode without queue mode returns null', () async {
      final p = PlaybackStateProvider();
      final previous = await p.getPreviousEpisode('any-key');
      expect(previous.status, QueueNavigationStatus.unavailable);
      expect(previous.item, isNull);
      p.dispose();
    });

    test('loadedItems getter is unmodifiable', () async {
      final p = PlaybackStateProvider();
      _setQueue(p, [_item('a')]);
      expect(() => p.loadedItems.add(_miItem('mutated')), throwsUnsupportedError);
      p.dispose();
    });

    test('safeNotifyListeners after dispose is a no-op', () async {
      final p = PlaybackStateProvider();
      p.dispose();
      // clearShuffle and queue seeding both notify; must not throw.
      p.clearShuffle();
      _setQueue(p, [_item('a')]);
    });

    test('playQueueItemIdFor returns synthetic ids for Jellyfin local queue items', () {
      // Anchor: VideoPlayerScreen.initState and `_ensurePlayQueue` both gate
      // on `isItemInActiveQueue(meta)` (which delegates to `playQueueItemIdFor`)
      // so a Jellyfin playlist queue survives entry into the player. If this
      // returns null for queue members, the player wipes the launcher-set
      // queue and prev/next walks the show instead of the playlist.
      final p = PlaybackStateProvider();
      addTearDown(p.dispose);

      final ep1 = testMediaItem(id: 'ep1', backend: MediaBackend.jellyfin, kind: MediaKind.episode);
      final ep2 = testMediaItem(id: 'ep2', backend: MediaBackend.jellyfin, kind: MediaKind.episode);
      final outsider = testMediaItem(id: 'ep-other', backend: MediaBackend.jellyfin, kind: MediaKind.episode);

      p.setPlaybackFromLocalQueue(
        LocalPlayQueue(id: 'jellyfin:playlist-X', items: [ep1, ep2], currentIndex: 0, backendId: 'jellyfin'),
        contextKey: 'playlist-X',
      );

      expect(p.playQueueItemIdFor(ep1), 0);
      expect(p.playQueueItemIdFor(ep2), 1);
      expect(p.playQueueItemIdFor(outsider), isNull);
      expect(p.isItemInActiveQueue(ep1), isTrue);
      expect(p.isItemInActiveQueue(outsider), isFalse);
    });

    test('isItemInActiveQueue keeps playlist/collection queues alive', () async {
      // Anchor (Plex side): `_ensurePlayQueue` in episode_queue.dart gates
      // its "preserve vs. clobber" decision on `isItemInActiveQueue`. A
      // Plex playlist queue's contextKey is the playlist id (not the show),
      // so a context-key-only check would wipe it. Membership via the
      // server-stamped `playQueueItemId` is the right signal — see gh #978.
      final p = PlaybackStateProvider();
      addTearDown(p.dispose);

      final inQueue = _item('ep-in-playlist');
      // A real-world non-queue item (e.g. tapped from media detail) is not a
      // member — that's how the helper distinguishes it from a launcher-seeded
      // queue member.
      final outsider = JellyfinMediaItem(id: 'ep-different-show', kind: MediaKind.episode);

      // contextKey is the playlist id, deliberately != grandparentId of any item
      _setQueue(p, [inQueue, _item('ep-other-in-playlist')], contextKey: 'playlist-Z');

      expect(p.isItemInActiveQueue(inQueue), isTrue);
      expect(p.isItemInActiveQueue(outsider), isFalse);
    });

    test('isItemInActiveQueue rejects items outside the queue', () async {
      final p = PlaybackStateProvider();
      addTearDown(p.dispose);
      _setQueue(p, [_item('ep-in-queue')], contextKey: 'playlist-Z');

      expect(p.isItemInActiveQueue(_item('ep-in-queue')), isTrue);
      expect(p.isItemInActiveQueue(_item('foreign')), isFalse);
    });

    test('isItemInActiveQueue is false when no queue is active', () {
      final p = PlaybackStateProvider();
      addTearDown(p.dispose);

      final ep = _item('ep1');
      expect(p.isQueueActive, isFalse);
      expect(p.isItemInActiveQueue(ep), isFalse);
    });
  });

  group('multi-episode files (#1500)', () {
    // Plex lists each episode of a multi-episode file (S02E24-E25.mkv) as
    // its own queue entry with a distinct ratingKey AND a distinct part id,
    // but the same Part.file. e24/e25 share a file; e23 and e26 don't.
    const fileA = '/tv/S02E24-E25.mkv';
    Future<PlaybackStateProvider> queueWithMultiEpisodeFile({int currentIndex = 1}) async {
      final p = PlaybackStateProvider();
      final items = [
        _itemWithFile('e23', '/tv/S02E23.mkv'),
        _itemWithFile('e24', fileA),
        _itemWithFile('e25', fileA),
        _itemWithFile('e26', '/tv/S02E26-E27.mkv'),
      ];
      _setQueue(p, items, currentIndex: currentIndex);
      return p;
    }

    test('getNextEpisode skips the same-file sibling using playedPartId', () async {
      final p = await queueWithMultiEpisodeFile();
      addTearDown(p.dispose);

      final next = await p.getNextEpisode('e24', playedPartId: 'part-e24');
      expect(next.status, QueueNavigationStatus.found);
      expect(next.item!.id, 'e26');
    });

    test('getNextEpisode skips the same-file sibling via file intersection without playedPartId', () async {
      final p = await queueWithMultiEpisodeFile();
      addTearDown(p.dispose);

      final next = await p.getNextEpisode('e24');
      expect(next.status, QueueNavigationStatus.found);
      expect(next.item!.id, 'e26');
    });

    test('getNextEpisode skips multiple siblings of a triple-episode file', () async {
      final p = PlaybackStateProvider();
      addTearDown(p.dispose);
      _setQueue(p, [
        _itemWithFile('e1', fileA),
        _itemWithFile('e2', fileA),
        _itemWithFile('e3', fileA),
        _itemWithFile('e4', '/tv/S02E26-E27.mkv'),
      ]);

      final next = await p.getNextEpisode('e1', playedPartId: 'part-e1');
      expect(next.status, QueueNavigationStatus.found);
      expect(next.item!.id, 'e4');
    });

    test('getNextEpisode returns null when only same-file siblings remain', () async {
      final p = PlaybackStateProvider();
      addTearDown(p.dispose);
      _setQueue(p, [_itemWithFile('e24', fileA), _itemWithFile('e25', fileA)]);

      expect((await p.getNextEpisode('e24', playedPartId: 'part-e24')).status, QueueNavigationStatus.boundary);
    });

    test('items without file data keep positional behavior even with playedPartId', () async {
      final p = PlaybackStateProvider();
      addTearDown(p.dispose);
      _setQueue(p, [_item('a'), _item('b')]);

      final next = await p.getNextEpisode('a', playedPartId: 'part-a');
      expect(next.status, QueueNavigationStatus.found);
      expect(next.item!.id, 'b');
    });

    test('getPreviousEpisode collapses to the first episode of the same-file group', () async {
      final p = await queueWithMultiEpisodeFile(currentIndex: 3);
      addTearDown(p.dispose);

      // From e26, previous is the e24-e25 file, entered at e24 (not e25).
      final previous = await p.getPreviousEpisode('e26', playedPartId: 'part-e26');
      expect(previous.status, QueueNavigationStatus.found);
      expect(previous.item!.id, 'e24');
    });

    test('getPreviousEpisode skips same-file siblings of the playing item', () async {
      final p = await queueWithMultiEpisodeFile(currentIndex: 2);
      addTearDown(p.dispose);

      // Playing the file as e25: previous must not land inside the same file.
      final previous = await p.getPreviousEpisode('e25', playedPartId: 'part-e25');
      expect(previous.status, QueueNavigationStatus.found);
      expect(previous.item!.id, 'e23');
    });

    test('sameFileSiblings returns the other episodes of the playing file', () async {
      final p = await queueWithMultiEpisodeFile();
      addTearDown(p.dispose);

      final current = p.loadedItems[1]; // e24
      final siblings = p.sameFileSiblings(current, playedPartId: 'part-e24');
      expect(siblings.map((s) => s.id), ['e25']);

      // Distinct-file episode has no siblings.
      expect(p.sameFileSiblings(p.loadedItems.first, playedPartId: 'part-e23'), isEmpty);
    });

    test('sameFileSiblings is empty without an active queue', () {
      final p = PlaybackStateProvider();
      addTearDown(p.dispose);
      expect(p.sameFileSiblings(_itemWithFile('e24', fileA), playedPartId: 'part-e24'), isEmpty);
    });
  });
}
