import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:harbor/database/app_database.dart';
import 'package:harbor/focus/focusable_wrapper.dart';
import 'package:harbor/i18n/strings.g.dart';
import 'package:harbor/media/ids.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_item.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_server_client.dart';
import 'package:harbor/metadata_edit/metadata_edit_models.dart';
import 'package:harbor/providers/multi_server_provider.dart';
import 'package:harbor/screens/metadata_edit_screen.dart';
import 'package:harbor/services/file_picker_service.dart';
import 'package:harbor/services/jellyfin_api_cache.dart';
import 'package:harbor/services/multi_server_manager.dart';
import 'package:harbor/theme/mono_palette.dart';
import 'package:harbor/theme/mono_theme.dart';
import 'package:harbor/widgets/dialog_action_button.dart';
import 'package:harbor/widgets/focusable_list_tile.dart';
import 'package:harbor/widgets/loading_indicator_box.dart';
import 'package:provider/provider.dart';

import '../test_helpers/backend_client_fixtures.dart';
import '../test_helpers/http_fixtures.dart';
import '../test_helpers/media_items.dart';
import '../test_helpers/multi_server_fixtures.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('save posts the edited field over the untouched server payload', (tester) async {
    final requests = _JellyfinMetadataRequests();
    final harness = await _pumpEditor(tester, requests);
    await _editTitle(tester, 'Renamed show');

    await tester.tap(find.byTooltip('Save'));
    await tester.pumpAndSettle();

    expect(requests.updateCalls, 1);
    final payload = requests.updatePayloads.single;
    expect(payload['Name'], 'Renamed show');
    expect(payload['Genres'], ['Drama']);
    expect(payload['ProviderIds'], {'Tmdb': '42'});
    // Trickplay tile data is megabytes of round-tripped noise the server
    // regenerates itself, so the adapter must not echo it back.
    expect(payload.containsKey('Trickplay'), isFalse);

    expect(find.byType(MetadataEditScreen), findsNothing);
    expect(find.text('Metadata updated'), findsOneWidget);

    await harness.dispose();
  });

  testWidgets('save rejects duplicate submit and back then recovers after failure', (tester) async {
    final requests = _JellyfinMetadataRequests();
    final harness = await _pumpEditor(tester, requests);
    await _editTitle(tester, 'Updated title');
    final save = requests.holdNextUpdate();

    final saveAction = find.byTooltip('Save');
    await tester.tap(saveAction);
    await tester.tap(saveAction);
    await tester.pump();

    expect(requests.updateCalls, 1);
    expect(find.byTooltip('Save'), findsNothing);
    expect(find.byType(LoadingIndicatorBox), findsOneWidget);

    await tester.tap(_fieldTile('Title'), warnIfMissed: false);
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(MetadataEditScreen), findsOneWidget);

    save.complete(_response(500));
    await tester.pumpAndSettle();
    expect(find.byType(MetadataEditScreen), findsOneWidget);
    expect(find.text('Failed to update metadata'), findsOneWidget);
    expect(_tileText('Title', 'Updated title'), findsOneWidget);
    expect(find.byTooltip('Save'), findsOneWidget);

    await harness.dispose();
  });

  testWidgets('late save completion cannot pop a replacement media editor', (tester) async {
    final requests = _JellyfinMetadataRequests();
    final harness = await _pumpEditor(tester, requests);
    await _editTitle(tester, 'Updated first title');
    final save = requests.holdNextUpdate();

    await tester.tap(find.byTooltip('Save'));
    await tester.pump();
    expect(requests.updateCalls, 1);

    // Bare pumps, not pumpAndSettle: settling would advance the fake clock past
    // the in-flight POST's request timeout and resolve it for us.
    harness.metadata.value = _show(id: 'show-2', title: 'Second show');
    await tester.pump();
    await tester.pump();
    expect(_tileText('Title', 'Second show'), findsOneWidget);

    save.complete(_ok());
    await tester.pumpAndSettle();
    expect(find.byType(MetadataEditScreen), findsOneWidget);
    expect(_tileText('Title', 'Second show'), findsOneWidget);
    expect(find.text('Metadata updated'), findsNothing);

    await harness.dispose();
  });

  testWidgets('unsupported kinds render the failure state without loading a draft', (tester) async {
    final requests = _JellyfinMetadataRequests();
    final harness = await _pumpEditor(
      tester,
      requests,
      item: testMediaItem(id: 'artist-1', kind: MediaKind.artist, title: 'Band', serverId: 'server-1', thumbPath: ''),
    );

    expect(requests.fetchCalls, 0);
    expect(find.byType(FocusableListTile), findsNothing);
    expect(find.text('Failed to update metadata'), findsOneWidget);

    await harness.dispose();
  });

  testWidgets('artwork mutation blocks cancel, back, actions, and duplicate options until success', (tester) async {
    final apply = Completer<bool>();
    final adapter = _ArtworkAdapter()..applyResult = apply.future;
    final result = _DialogResult();
    await _pumpArtworkDialog(tester, adapter, result);

    await tester.tap(_artworkOption());
    await tester.pump();
    expect(adapter.applyCalls, 1);
    expect(_dialogButton(tester, 'From URL').onPressed, isNull);
    expect(_dialogButton(tester, 'Upload File').onPressed, isNull);
    expect(_dialogButton(tester, 'Cancel').onPressed, isNull);

    await tester.tap(find.text('Cancel'), warnIfMissed: false);
    await tester.tap(_artworkOption(), warnIfMissed: false);
    await tester.binding.handlePopRoute();
    await tester.pump();
    expect(find.byType(ArtworkPickerDialog), findsOneWidget);
    expect(adapter.applyCalls, 1);
    expect(result.completions, 0);

    apply.complete(true);
    await tester.pumpAndSettle();
    expect(find.byType(ArtworkPickerDialog), findsNothing);
    expect(result.completions, 1);
    expect(result.value, isTrue);
    expect(find.text('Artwork updated'), findsOneWidget);
  });

  testWidgets('upload failure keeps artwork dialog mounted and restores cancellation', (tester) async {
    final picker = _FakeFilePicker()
      ..queueResult(
        FilePickerResult([
          PlatformFile(name: 'poster.png', size: 3, bytes: Uint8List.fromList([1, 2, 3])),
        ]),
      );
    FilePickerService.setDelegateForTesting(picker);
    addTearDown(() => FilePickerService.setDelegateForTesting(null));

    final adapter = _ArtworkAdapter()..uploadResult = Future<bool>.value(false);
    final result = _DialogResult();
    await _pumpArtworkDialog(tester, adapter, result);

    await tester.tap(find.text('Upload File'));
    await tester.pumpAndSettle();

    expect(adapter.uploadCalls, 1);
    expect(find.byType(ArtworkPickerDialog), findsOneWidget);
    expect(find.text('Failed to update artwork'), findsOneWidget);
    expect(_dialogButton(tester, 'Cancel').onPressed, isNotNull);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(result.completions, 1);
    expect(result.value, isNull);
  });

  testWidgets('picker cancellation and stale picker completion never start an upload', (tester) async {
    final picker = _FakeFilePicker()..queueResult(null);
    FilePickerService.setDelegateForTesting(picker);
    addTearDown(() => FilePickerService.setDelegateForTesting(null));

    final adapter = _ArtworkAdapter();
    final firstResult = _DialogResult();
    await _pumpArtworkDialog(tester, adapter, firstResult);

    await tester.tap(find.text('Upload File'));
    await tester.pumpAndSettle();
    expect(adapter.uploadCalls, 0);
    expect(find.byType(ArtworkPickerDialog), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    final pendingPicker = Completer<FilePickerResult?>();
    picker.queueFuture(pendingPicker.future);
    final staleResult = _DialogResult();
    await _pumpArtworkDialog(tester, adapter, staleResult);
    await tester.tap(find.text('Upload File'));
    await tester.pump();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    pendingPicker.complete(
      FilePickerResult([
        PlatformFile(name: 'stale.png', size: 1, bytes: Uint8List.fromList([1])),
      ]),
    );
    await tester.pumpAndSettle();

    expect(adapter.uploadCalls, 0);
    expect(staleResult.completions, 1);
    expect(staleResult.value, isNull);
    expect(find.text('Artwork updated'), findsNothing);
  });
}

Finder _fieldTile(String label) => find.widgetWithText(FocusableListTile, label);

Finder _tileText(String label, String value) {
  return find.descendant(of: _fieldTile(label), matching: find.text(value));
}

Finder _artworkOption() {
  return find.descendant(of: find.byType(GridView), matching: find.byType(FocusableWrapper)).first;
}

DialogActionButton _dialogButton(WidgetTester tester, String label) {
  return tester.widget<DialogActionButton>(find.widgetWithText(DialogActionButton, label));
}

Future<void> _editTitle(WidgetTester tester, String title) async {
  final tile = _fieldTile('Title');
  await tester.ensureVisible(tile);
  await tester.tap(tile);
  await tester.pumpAndSettle();
  await tester.enterText(find.byType(TextField), title);
  await tester.tap(find.widgetWithText(DialogActionButton, 'Save'));
  await tester.pumpAndSettle();
  expect(_tileText('Title', title), findsOneWidget);
}

Future<_EditorHarness> _pumpEditor(WidgetTester tester, _JellyfinMetadataRequests requests, {MediaItem? item}) async {
  tester.view.physicalSize = const Size(1280, 720);
  tester.view.devicePixelRatio = 1;

  final database = AppDatabase.forTesting(NativeDatabase.memory());
  JellyfinApiCache.initialize(database);
  final client = testClientForServer(ServerId('server-1'), handler: requests.handle);
  final manager = MultiServerManager()..debugRegisterClientForTesting(client);
  final provider = testMultiServerProvider(manager);
  final metadata = ValueNotifier<MediaItem>(item ?? _show());

  await tester.pumpWidget(
    TranslationProvider(
      child: ChangeNotifierProvider<MultiServerProvider>.value(
        value: provider,
        child: MaterialApp(
          theme: monoTheme(MonoPalette.dark),
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => ValueListenableBuilder<MediaItem>(
                          valueListenable: metadata,
                          builder: (context, item, _) => MetadataEditScreen(metadata: item),
                        ),
                      ),
                    );
                  },
                  child: const Text('Open editor'),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open editor'));
  await tester.pumpAndSettle();
  expect(find.byType(MetadataEditScreen), findsOneWidget);

  return _EditorHarness(tester: tester, database: database, manager: manager, provider: provider, metadata: metadata);
}

MediaItem _show({String id = 'show-1', String title = 'First show'}) => testMediaItem(
  id: id,
  kind: MediaKind.show,
  title: title,
  originalTitle: 'Original $title',
  summary: 'Summary',
  libraryId: '1',
  serverId: 'server-1',
  thumbPath: '',
);

class _EditorHarness {
  final WidgetTester tester;
  final AppDatabase database;
  final MultiServerManager manager;
  final MultiServerProvider provider;
  final ValueNotifier<MediaItem> metadata;

  const _EditorHarness({
    required this.tester,
    required this.database,
    required this.manager,
    required this.provider,
    required this.metadata,
  });

  Future<void> dispose() async {
    await tester.pumpWidget(const SizedBox.shrink());
    provider.dispose();
    manager.dispose();
    metadata.dispose();
    await database.close();
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  }
}

class _JellyfinMetadataRequests {
  final Map<String, Map<String, dynamic>> items = {
    'show-1': _rawShow('show-1', 'First show'),
    'show-2': _rawShow('show-2', 'Second show'),
  };
  final Queue<Future<http.Response>> _updateResponses = Queue();
  final List<Map<String, dynamic>> updatePayloads = [];
  int fetchCalls = 0;
  int updateCalls = 0;

  Completer<http.Response> holdNextUpdate() {
    final completer = Completer<http.Response>();
    _updateResponses.add(completer.future);
    return completer;
  }

  Future<http.Response> handle(http.Request request) async {
    final segments = request.url.pathSegments;
    if (request.method == 'GET' && segments.length == 4 && segments[0] == 'Users' && segments[2] == 'Items') {
      fetchCalls++;
      final raw = items[segments[3]];
      return raw == null ? _response(404) : jsonResponse(raw);
    }

    if (request.method == 'POST' && segments.length == 2 && segments[0] == 'Items') {
      updateCalls++;
      updatePayloads.add(jsonDecode(request.body) as Map<String, dynamic>);
      return _updateResponses.isEmpty ? _ok() : await _updateResponses.removeFirst();
    }

    return _response(404);
  }
}

Map<String, dynamic> _rawShow(String id, String name) => {
  'Id': id,
  'Name': name,
  'Type': 'Series',
  'Overview': 'Summary',
  'Genres': ['Drama'],
  'Tags': <String>[],
  'Studios': [
    {'Name': 'Studio A', 'Id': 'studio-a'},
  ],
  'People': [
    {'Name': 'Dana', 'Type': 'Director'},
  ],
  'ProviderIds': {'Tmdb': '42'},
  'LockedFields': <String>[],
  'LockData': false,
  'Trickplay': {'1080': <String, dynamic>{}},
};

Future<void> _pumpArtworkDialog(WidgetTester tester, _ArtworkAdapter adapter, _DialogResult result) async {
  tester.view.physicalSize = const Size(900, 700);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    TranslationProvider(
      child: MaterialApp(
        theme: monoTheme(MonoPalette.dark),
        home: Builder(
          builder: (context) => Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () async {
                  final value = await showDialog<bool>(
                    context: context,
                    builder: (_) => ArtworkPickerDialog(adapter: adapter, draft: adapter.draft, field: adapter.field),
                  );
                  result.value = value;
                  result.completions++;
                },
                child: const Text('Open artwork'),
              ),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('Open artwork'));
  await tester.pumpAndSettle();
  expect(find.byType(ArtworkPickerDialog), findsOneWidget);
}

class _DialogResult {
  int completions = 0;
  bool? value;
}

class _ArtworkAdapter extends MetadataEditAdapter {
  final MediaServerClient _client = _NoopMediaClient();
  late final MetadataEditDraft draft = MetadataEditDraft(
    sourceItem: _show(),
    currentItem: _show(),
    values: {'artwork:Primary': ''},
  );
  late final MetadataEditField field = const MetadataEditField(
    id: 'artwork:Primary',
    label: 'Poster',
    type: MetadataEditFieldType.artwork,
    saveMode: MetadataEditSaveMode.immediate,
    artwork: MetadataArtworkConfig(
      key: 'Primary',
      selectTitle: 'Select Poster',
      previewWidth: 40,
      previewHeight: 60,
      gridColumns: 2,
      gridAspectRatio: 2 / 3,
    ),
  );
  Future<bool> applyResult = Future.value(true);
  Future<bool> uploadResult = Future.value(true);
  int applyCalls = 0;
  int uploadCalls = 0;

  @override
  MediaBackend get backend => MediaBackend.jellyfin;

  @override
  MediaServerClient get mediaClient => _client;

  @override
  bool supportsKind(MediaKind kind) => true;

  @override
  Future<MetadataEditDraft> load(MediaItem item) async => draft;

  @override
  List<MetadataEditSection> buildSchema(MetadataEditDraft draft) => const [];

  @override
  Future<bool> save(MetadataEditDraft draft) async => true;

  @override
  Future<List<MetadataArtworkOption>> fetchArtwork(MetadataEditDraft draft, MetadataEditField field) async {
    return const [MetadataArtworkOption(id: 'option-1', thumbnailPath: '', sourceUrl: 'option-1')];
  }

  @override
  Future<bool> applyArtworkOption(MetadataEditDraft draft, MetadataEditField field, MetadataArtworkOption option) {
    applyCalls++;
    return applyResult;
  }

  @override
  Future<bool> applyArtworkFromUrl(MetadataEditDraft draft, MetadataEditField field, String url) async => true;

  @override
  Future<bool> uploadArtwork(MetadataEditDraft draft, MetadataEditField field, List<int> bytes, {String? fileName}) {
    uploadCalls++;
    return uploadResult;
  }
}

class _NoopMediaClient implements MediaServerClient {
  @override
  MediaBackend get backend => MediaBackend.jellyfin;

  @override
  ServerId get serverId => ServerId('server-1');

  @override
  String? get serverName => 'Server';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeFilePicker implements FilePickerDelegate {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

  final Queue<Future<FilePickerResult?>> _results = Queue();

  void queueResult(FilePickerResult? result) {
    _results.add(Future.value(result));
  }

  void queueFuture(Future<FilePickerResult?> result) {
    _results.add(result);
  }

  @override
  Future<FilePickerResult?> pickFiles({
    String? dialogTitle,
    String? initialDirectory,
    FileType type = FileType.any,
    List<String>? allowedExtensions,
    Function(FilePickerStatus)? onFileLoading,
    bool allowCompression = false,
    int compressionQuality = 0,
    bool allowMultiple = false,
    bool withData = false,
    bool withReadStream = false,
    bool lockParentWindow = false,
    bool readSequential = false,
  }) {
    return _results.removeFirst();
  }
}

http.Response _ok() => _response(200);

http.Response _response(int statusCode) {
  return http.Response('{}', statusCode, headers: const {'content-type': 'application/json'});
}
