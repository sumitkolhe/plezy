import 'package:flutter/material.dart';
import 'package:harbor/media/ids.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/media/media_backend.dart';
import 'package:harbor/media/media_kind.dart';
import 'package:harbor/media/media_library.dart';
import 'package:harbor/mixins/library_tab_state.dart';
import 'package:provider/provider.dart';
import 'package:harbor/providers/multi_server_provider.dart';
import 'package:harbor/services/multi_server_manager.dart';

import '../test_helpers/multi_server_fixtures.dart';

class _Probe extends StatefulWidget {
  const _Probe({required this.library, required this.onState});

  final MediaLibrary library;
  final void Function(_ProbeState state) onState;

  @override
  State<_Probe> createState() => _ProbeState();
}

class _ProbeState extends State<_Probe> with LibraryTabStateMixin<_Probe> {
  @override
  MediaLibrary get library => widget.library;

  @override
  Widget build(BuildContext context) {
    // Surface state after the first frame so tests receive a mounted probe.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) widget.onState(this);
    });
    return const SizedBox.shrink();
  }
}

MediaLibrary _lib({ServerId? serverId, String key = '1'}) =>
    MediaLibrary(id: key, backend: MediaBackend.jellyfin, title: 'Movies', kind: MediaKind.movie, serverId: serverId);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('LibraryTabStateMixin', () {
    testWidgets('getMediaClientForLibrary throws when no server matches and no fallback online', (tester) async {
      late _ProbeState state;

      final manager = MultiServerManager();
      final provider = testMultiServerProvider(manager);
      // provider.dispose() cascades to manager.dispose() — only register
      // the outer teardown to avoid a double-close on the manager's stream.
      addTearDown(provider.dispose);

      await tester.pumpWidget(
        ChangeNotifierProvider<MultiServerProvider>.value(
          value: provider,
          child: _Probe(
            library: _lib(serverId: ServerId('srv-missing')),
            onState: (s) => state = s,
          ),
        ),
      );
      await tester.pump();

      expect(() => state.getMediaClientForLibrary(), throwsA(isA<Exception>()));
    });
  });
}
