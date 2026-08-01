import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plezy/models/external_player_models.dart';

void main() {
  setUp(KnownPlayers.resetForTesting);
  tearDown(KnownPlayers.resetForTesting);

  group('detection failures', () {
    test('a probe that throws lists the player instead of hiding it', () async {
      final installed = await _resolveWith(_FakeProbe.everythingInstalled());
      final failed = await _resolveWith(_FakeProbe(failEveryLookup: true));

      expect(failed, installed);
    });

    test('detection runs once per process', () async {
      final probe = _FakeProbe.everythingInstalled();
      KnownPlayers.probe = probe;

      final first = await KnownPlayers.getForCurrentPlatform();
      final runsAfterFirst = probe.runs.length;
      final second = await KnownPlayers.getForCurrentPlatform();

      expect(second, same(first));
      expect(probe.runs, hasLength(runsAfterFirst));
    });

    test('undetected players keep their declared order', () async {
      final all = await _resolveWith(_FakeProbe.everythingInstalled());
      final none = await _resolveWith(_FakeProbe());

      expect(none.first, 'system_default');
      expect(none, all.where(none.contains));
    });
  });

  // Which detectors run is driven by the probe, so the wiring is exercised on
  // whatever host runs the suite.
  group('detector wiring', () {
    test('iOS asks the same URL-handler question the launcher gates on', () async {
      final probe = _FakeProbe(operatingSystem: 'ios');
      await _resolveWith(probe);

      expect(probe.schemeLookups, unorderedEquals(['vlc://', 'infuse://']));
      expect(probe.runs, isEmpty);
    });

    test('platforms without a detector probe nothing', () async {
      final probe = _FakeProbe(operatingSystem: 'android');
      await _resolveWith(probe);

      expect(probe.runs, isEmpty);
      expect(probe.bundleLookups, isEmpty);
      expect(probe.schemeLookups, isEmpty);
    });
  });
}

Future<List<String>> _resolveWith(PlayerInstallProbe probe) async {
  KnownPlayers.resetForTesting();
  KnownPlayers.probe = probe;
  final players = await KnownPlayers.getForCurrentPlatform();
  return players.map((player) => player.id).toList();
}

/// Answers the host lookups from fixed sets, and records the subprocesses and
/// bundle lookups it is asked for so tests can assert what production issues.
class _FakeProbe extends PlayerInstallProbe {
  _FakeProbe({this.failEveryLookup = false, String? operatingSystem})
    : operatingSystem = operatingSystem ?? Platform.operatingSystem,
      _everything = false;

  _FakeProbe.everythingInstalled()
    : failEveryLookup = false,
      operatingSystem = Platform.operatingSystem,
      _everything = true;

  final bool failEveryLookup;
  final bool _everything;
  final List<List<String>> runs = [];
  final List<String> bundleLookups = [];
  final List<String> schemeLookups = [];

  @override
  final String operatingSystem;

  @override
  Future<ProcessResult> run(String executable, List<String> arguments) async {
    runs.add([executable, ...arguments]);
    fail('no surviving platform probes a subprocess: $executable $arguments');
  }

  @override
  Future<bool> schemeHasHandler(String scheme) async {
    schemeLookups.add(scheme);
    if (failEveryLookup) throw MissingPluginException('no url launcher plugin');
    return _everything;
  }
}
