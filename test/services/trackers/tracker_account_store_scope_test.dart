import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/profiles/profile.dart';
import 'package:harbor/services/base_shared_preferences_service.dart';
import 'package:harbor/services/trackers/tracker_account_store.dart';
import 'package:harbor/services/trackers/tracker_constants.dart';
import 'package:harbor/services/trackers/tracker_session.dart';

import '../../test_helpers/prefs.dart';

const _profileId = 'local-abc';

TrackerSession _session() {
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  return TrackerSession(accessToken: 'a', refreshToken: 'r', expiresAt: now + 86400, createdAt: now);
}

void main() {
  setUp(resetSharedPreferencesForTest);

  group('profile user scoping', () {
    test('profileScopedPrefsKey scopes by profile id, and not at all when empty', () {
      expect(profileScopedPrefsKey(_profileId, 'trakt_session'), 'user_${_profileId}_trakt_session');
      expect(profileScopedPrefsKey('', 'trakt_session'), 'trakt_session');
    });

    test('store writes the profile-scoped key and loads it back', () async {
      final store = trackerAccountStore(TrackerService.trakt);
      await store.save(_profileId, _session());

      final prefs = await BaseSharedPreferencesService.sharedCache();
      expect(prefs.getString('user_${_profileId}_trakt_session'), isNotNull);

      expect(await store.load(_profileId), isNotNull);

      await store.clear(_profileId);
      expect(await store.load(_profileId), isNull);
    });
  });
}
