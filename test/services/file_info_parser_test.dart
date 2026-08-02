import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/services/file_info_parser.dart';

/// Unit tests for the stream walker: its accounting (single video pointer,
/// every audio + sub tracked, raw video stream retained once) and the
/// reader's mapping from raw JSON to the neutral track classes.
void main() {
  group('walkStreams (Jellyfin reader)', () {
    const reader = JellyfinFileInfoStreamReader();

    test('captures the first video stream and accumulates audio + subs', () {
      final streams = [
        {'Type': 'Video', 'Index': 0, 'RealFrameRate': 23.976, 'ColorSpace': 'bt709'},
        {
          'Type': 'Audio',
          'Index': 1,
          'Codec': 'eac3',
          'Language': 'eng',
          'Channels': 6,
          'IsDefault': true,
          'DisplayTitle': 'English (EAC3 5.1)',
        },
        {'Type': 'Audio', 'Index': 2, 'Codec': 'aac', 'Language': 'fre', 'Channels': 2, 'IsDefault': false},
        {'Type': 'Subtitle', 'Index': 3, 'Codec': 'srt', 'Language': 'eng', 'IsDefault': false, 'IsForced': false},
      ];

      final out = walkStreams(streams, reader);

      expect(out.videoStream?['Index'], 0);
      expect(out.audioStream?['Index'], 1);
      expect(out.videoStream?['RealFrameRate'], closeTo(23.976, 1e-6));
      expect(out.audioTracks.map((t) => t.id), [1, 2]);
      expect(out.audioTracks[0].selected, isTrue);
      expect(out.audioTracks[0].languageCode, 'eng');
      expect(out.subtitleTracks, hasLength(1));
      expect(out.subtitleTracks.first.id, 3);
    });

    test('falls back to autoIndex when Index is null', () {
      final streams = [
        {'Type': 'Audio', 'Codec': 'aac'}, // no Index
        {'Type': 'Audio', 'Index': 7, 'Codec': 'eac3'},
        {'Type': 'Audio', 'Codec': 'opus'}, // no Index
      ];
      final out = walkStreams(streams, reader);
      // autoIndex is 1-based and increments per audio entry: 1, 2 (overridden by 7), 3.
      expect(out.audioTracks.map((t) => t.id), [1, 7, 3]);
    });

    test('captures video stream when only AverageFrameRate is present', () {
      final streams = [
        {'Type': 'Video', 'AverageFrameRate': 25.0},
      ];
      final out = walkStreams(streams, reader);
      expect(out.videoStream?['AverageFrameRate'], 25.0);
    });

    test('skips streams with unknown Type', () {
      final streams = [
        {'Type': 'EmbeddedImage', 'Index': 0}, // unsupported
        {'Type': 'audio', 'Codec': 'aac'}, // case-insensitive
      ];
      final out = walkStreams(streams, reader);
      expect(out.videoStream, isNull);
      expect(out.audioTracks, hasLength(1));
    });
  });
}
