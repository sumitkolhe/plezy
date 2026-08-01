import 'package:flutter_test/flutter_test.dart';
import 'package:plezy/media/media_file_info.dart';
import 'package:plezy/services/jellyfin_client.dart';

void main() {
  group('parseJellyfinFileInfoFromJson', () {
    test('keeps every media source as a one-part version in server order', () {
      final result = parseJellyfinFileInfoFromJson({
        'MediaSources': [
          {'Id': 'source-1', 'Name': 'Original', 'Path': '/media/original.mkv', 'Size': 9000},
          {'Id': 'source-2', 'Name': 'Transcoded', 'Path': '/media/transcoded.mp4', 'Size': '4000'},
        ],
      });

      expect(result, isNotNull);
      expect(result!.versions.map((version) => version.id), ['source-1', 'source-2']);
      expect(result.versions.every((version) => version.parts.length == 1), isTrue);
      expect(result.versions.map((version) => version.parts.single.filePath), [
        '/media/original.mkv',
        '/media/transcoded.mp4',
      ]);
      expect(result.versions.map((version) => version.parts.single.fileSize), [9000, 4000]);
    });

    test('normalizes bitrates and converts ticks into duration fields', () {
      final version = _jellyfinVersions([
        {
          'Id': 'source',
          'Bitrate': 3184421,
          'RunTimeTicks': 50250000000,
          'MediaStreams': [
            {'Type': 'Video', 'BitRate': 1775759},
          ],
        },
      ]).single;

      expect(version.bitrateKbps, 3184);
      expect(version.durationMs, 5025000);
      expect(version.durationFormatted, '1h 23m 45s');
      expect(version.parts.single.durationMs, 5025000);
      expect(version.parts.single.streams.single.bitrateKbps, 1776);
    });

    test('prefers declared aspect ratio then dimensions and otherwise leaves it absent', () {
      final versions = _jellyfinVersions([
        {
          'MediaStreams': [
            {'Type': 'Video', 'AspectRatio': '2.35:1', 'Width': 1920, 'Height': 1080},
          ],
        },
        {
          'MediaStreams': [
            {'Type': 'Video', 'Width': 1920, 'Height': 1080},
          ],
        },
        {
          'MediaStreams': [
            {'Type': 'Video'},
          ],
        },
      ]);

      expect(versions[0].aspectRatio, closeTo(2.35, 0.0001));
      expect(versions[1].aspectRatio, closeTo(16 / 9, 0.0001));
      expect(versions[2].aspectRatio, isNull);
    });

    test('rolls up summary fields from the first video and audio streams', () {
      final version = _jellyfinVersions([
        {
          'MediaStreams': [
            {'Type': 'Video', 'Codec': 'hevc', 'Profile': 'Main 10', 'Width': 3840, 'Height': 1608},
            {'Type': 'Video', 'Codec': 'h264', 'Profile': 'High', 'Width': 1920, 'Height': 1080},
            {'Type': 'Audio', 'Codec': 'eac3', 'Profile': 'Dolby Digital Plus', 'Channels': 6},
            {'Type': 'Audio', 'Codec': 'aac', 'Channels': 2},
          ],
        },
      ]).single;

      expect(version.videoCodec, 'hevc');
      expect(version.videoProfile, 'Main 10');
      expect(version.audioCodec, 'eac3');
      expect(version.audioProfile, 'Dolby Digital Plus');
      expect(version.audioChannels, 6);
      expect(version.videoResolutionLabel, '4k');
    });

    test('maps every VideoRangeType and falls back to VideoRange', () {
      final streams = _jellyfinStreams([
        {'Type': 'Video', 'VideoRangeType': 'SDR'},
        {'Type': 'Video', 'VideoRangeType': 'HDR10'},
        {'Type': 'Video', 'VideoRangeType': 'HDR10Plus'},
        {'Type': 'Video', 'VideoRangeType': 'HLG'},
        {'Type': 'Video', 'VideoRangeType': 'DOVI'},
        {'Type': 'Video', 'VideoRangeType': 'DOVIWithHDR10'},
        {'Type': 'Video', 'VideoRangeType': 'DOVIWithHDR10Plus'},
        {'Type': 'Video', 'VideoRangeType': 'DOVIWithHLG'},
        {'Type': 'Video', 'VideoRangeType': 'Unknown', 'VideoRange': 'HDR'},
        {'Type': 'Video', 'VideoRangeType': 'Unknown', 'VideoRange': 'SDR'},
        {'Type': 'Video'},
      ]);

      expect(streams.map((stream) => stream.videoRange), [
        MediaVideoRange.sdr,
        MediaVideoRange.hdr10,
        MediaVideoRange.hdr10Plus,
        MediaVideoRange.hlg,
        MediaVideoRange.dolbyVision,
        MediaVideoRange.dolbyVisionHdr10,
        MediaVideoRange.dolbyVisionHdr10,
        MediaVideoRange.dolbyVisionHlg,
        MediaVideoRange.hdr,
        MediaVideoRange.sdr,
        MediaVideoRange.unknown,
      ]);
    });

    test('maps Dolby Vision fields only when present', () {
      final streams = _jellyfinStreams([
        {
          'Type': 'Video',
          'DvProfile': 8,
          'DvLevel': '6',
          'DvVersionMajor': 1,
          'DvVersionMinor': 0,
          'DvBlSignalCompatibilityId': 6,
          'BlPresentFlag': true,
          'ElPresentFlag': false,
          'RpuPresentFlag': true,
          'VideoDoViTitle': 'Dolby Vision Profile 8.6',
        },
        {'Type': 'Video', 'Codec': 'h264'},
      ]);

      final dolbyVision = streams.first.dolbyVision!;
      expect(dolbyVision.profile, 8);
      expect(dolbyVision.level, 6);
      expect(dolbyVision.version, '1.0');
      expect(dolbyVision.blCompatibilityId, 6);
      expect(dolbyVision.blPresent, isTrue);
      expect(dolbyVision.elPresent, isFalse);
      expect(dolbyVision.rpuPresent, isTrue);
      expect(dolbyVision.title, 'Dolby Vision Profile 8.6');
      expect(streams.last.dolbyVision, isNull);
    });

    test('derives progressive and interlaced scan types from IsInterlaced', () {
      final streams = _jellyfinStreams([
        {'Type': 'Video', 'IsInterlaced': false},
        {'Type': 'Video', 'IsInterlaced': true},
      ]);

      expect(streams[0].isInterlaced, isFalse);
      expect(streams[0].scanType, 'progressive');
      expect(streams[1].isInterlaced, isTrue);
      expect(streams[1].scanType, 'interlaced');
    });

    test('keeps embedded image and data streams', () {
      final streams = _jellyfinStreams([
        {'Type': 'EmbeddedImage', 'Codec': 'mjpeg'},
        {'Type': 'Data', 'Codec': 'bin_data'},
      ]);

      expect(streams.map((stream) => stream.kind), [MediaStreamKind.image, MediaStreamKind.data]);
      expect(streams.map((stream) => stream.codec), ['mjpeg', 'bin_data']);
    });

    test('maps CodecTag attachments and prefers an explicit Codec', () {
      final version = _jellyfinVersions([
        {
          'MediaAttachments': [
            {'Index': 4, 'FileName': 'OpenSans.ttf', 'MimeType': 'font/ttf', 'CodecTag': 'ttf'},
            {
              'Index': 5,
              'FileName': 'metadata.bin',
              'MimeType': 'application/octet-stream',
              'Codec': 'explicit-codec',
              'CodecTag': 'fallback-tag',
            },
          ],
        },
      ]).single;

      expect(version.attachments, hasLength(2));
      expect(version.attachments.first.index, 4);
      expect(version.attachments.first.fileName, 'OpenSans.ttf');
      expect(version.attachments.first.mimeType, 'font/ttf');
      expect(version.attachments.first.codec, 'ttf');
      expect(version.attachments.last.codec, 'explicit-codec');
    });

    test('returns null for missing empty or non-list MediaSources', () {
      expect(parseJellyfinFileInfoFromJson(const {}), isNull);
      expect(parseJellyfinFileInfoFromJson(const {'MediaSources': []}), isNull);
      expect(
        parseJellyfinFileInfoFromJson(const {
          'MediaSources': {'Id': 'source'},
        }),
        isNull,
      );
    });
  });

  group('Media file-info formatting', () {
    test('formats channel layouts and counts without empty punctuation', () {
      expect(_stream(channels: 6, channelLayout: '5.1').channelsFormatted, '5.1 (6 ch)');
      expect(_stream(channelLayout: '5.1').channelsFormatted, '5.1');
      expect(_stream(channels: 6).channelsFormatted, '6 ch');
      expect(_stream().channelsFormatted, isNull);
    });

    test('formats whole and fractional sample rates in kHz', () {
      expect(_stream(sampleRate: 48000).sampleRateFormatted, '48 kHz');
      expect(_stream(sampleRate: 44100).sampleRateFormatted, '44.1 kHz');
    });

    test('formats whole and fractional frame rates without spurious decimals', () {
      expect(_stream(frameRate: 24.0).frameRateFormatted, '24 fps');
      expect(_stream(frameRate: 23.976).frameRateFormatted, '23.976 fps');
    });

    test('extracts filenames from POSIX and Windows paths', () {
      expect(const MediaFilePart(filePath: '/media/movies/Movie.mkv').fileName, 'Movie.mkv');
      expect(const MediaFilePart(filePath: r'C:\Media\Movies\Movie.mkv').fileName, 'Movie.mkv');
      expect(const MediaFilePart(filePath: '').fileName, isNull);
    });

    test('formats durations at hour minute second boundaries', () {
      expect(formatMediaDuration(5025000), '1h 23m 45s');
      expect(formatMediaDuration(1425000), '23m 45s');
      expect(formatMediaDuration(45000), '45s');
      expect(formatMediaDuration(null), isNull);
    });

    test('headline falls back through display title title language codec and ordinal', () {
      expect(_stream(displayTitle: 'Display', title: 'Title', language: 'English', codec: 'aac').headline, 'Display');
      expect(_stream(title: 'Title', language: 'English', codec: 'aac').headline, 'Title');
      expect(_stream(language: 'English', codec: 'aac').headline, 'English');
      expect(_stream(codec: 'aac').headline, 'aac');
      expect(_stream(ordinal: 7).headline, '#7');
    });
  });
}

List<MediaFileVersion> _jellyfinVersions(List<Map<String, dynamic>> sources) {
  return parseJellyfinFileInfoFromJson({'MediaSources': sources})!.versions;
}

List<MediaStreamDetails> _jellyfinStreams(List<Map<String, dynamic>> streams) {
  return _jellyfinVersions([
    {'MediaStreams': streams},
  ]).single.parts.single.streams;
}

MediaStreamDetails _stream({
  int ordinal = 1,
  String? displayTitle,
  String? title,
  String? language,
  String? codec,
  int? channels,
  String? channelLayout,
  int? sampleRate,
  double? frameRate,
}) {
  return MediaStreamDetails(
    kind: MediaStreamKind.audio,
    ordinal: ordinal,
    displayTitle: displayTitle,
    title: title,
    language: language,
    codec: codec,
    channels: channels,
    channelLayout: channelLayout,
    sampleRate: sampleRate,
    frameRate: frameRate,
  );
}
