import 'dart:async';
import 'dart:collection';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/connection/connection_registry.dart';
import 'package:harbor/database/app_database.dart';
import 'package:harbor/focus/input_mode_tracker.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/profiles/profile.dart';
import 'package:harbor/profiles/profile_connection.dart';
import 'package:harbor/profiles/profile_connection_registry.dart';
import 'package:harbor/profiles/profile_registry.dart';
import 'package:harbor/screens/profile/borrow_connection_screen.dart';
import 'package:harbor/services/storage_service.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:provider/provider.dart';

import '../../test_helpers/prefs.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    resetSharedPreferencesForTest();
    LocaleSettings.setLocaleSync(AppLocale.en);
  });

  testWidgets('load failure has retry and remains distinct from successful empty state', (tester) async {
    final db = AppDatabase.forTesting(NativeDatabase.memory());
    final connections = ConnectionRegistry(db);
    final profileConnections = _ControlledJoinRegistry(db);
    final profiles = ProfileRegistry(db);
    await StorageService.getInstance();
    addTearDown(db.close);

    final target = Profile.local(id: 'target', displayName: 'Target', createdAt: DateTime(2026));

    await tester.pumpWidget(
      TranslationProvider(
        child: MultiProvider(
          providers: [
            Provider<ProfileConnectionRegistry>.value(value: profileConnections),
            Provider<ConnectionRegistry>.value(value: connections),
            Provider<ProfileRegistry>.value(value: profiles),
          ],
          child: InputModeTracker(
            child: MaterialApp(
              theme: monoTheme(dark: true),
              home: BorrowConnectionScreen(targetProfile: target),
            ),
          ),
        ),
      ),
    );

    expect(profileConnections.loads, hasLength(1));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    profileConnections.loads.first.completeError(StateError('load failed'));
    await tester.pumpAndSettle();

    expect(find.text(t.profiles.borrowLoadFailed), findsOneWidget);
    expect(find.text(t.common.retry), findsOneWidget);
    expect(find.text(t.profiles.borrowEmpty), findsNothing);

    await tester.tap(find.text(t.common.retry));
    await tester.pump();

    expect(profileConnections.loads, hasLength(2));
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.text(t.profiles.borrowLoadFailed), findsNothing);

    profileConnections.loads.last.complete(const []);
    await tester.pumpAndSettle();

    expect(find.text(t.profiles.borrowEmpty), findsOneWidget);
    expect(find.text(t.profiles.borrowLoadFailed), findsNothing);
  });
}

/// Gates the candidate load so the test can hold it pending, fail it, and
/// retry it — the screen awaits every registry read in one Future.wait.
class _ControlledJoinRegistry extends ProfileConnectionRegistry {
  _ControlledJoinRegistry(super.db);

  final Queue<Completer<List<ProfileConnection>>> loads = Queue();

  @override
  Future<List<ProfileConnection>> listAll() {
    final completer = Completer<List<ProfileConnection>>();
    loads.add(completer);
    return completer.future;
  }
}
