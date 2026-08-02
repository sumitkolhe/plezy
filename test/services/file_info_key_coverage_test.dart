import 'package:flutter_test/flutter_test.dart';
import 'package:harbor/media/media_file_info.dart';
import 'package:harbor/services/jellyfin_client.dart';

/// Guards the file-info sheet's promise that nothing the server reports is
/// silently dropped.
///
/// The fixtures below enumerate every key observed on the production request
/// shapes — Plex `/library/metadata/{id}?includeChapters=1&includeMarkers=1`
/// `&checkFiles=1&includeStreams=1`, Jellyfin `/Users/{id}/Items/{id}` with
/// the client's detail field set. Each key must be accounted for exactly once:
/// carried onto the model, deliberately folded into another field, or listed
/// in an exclusion set with a reason. Adding a key to a fixture without
/// classifying it fails the suite.
void main() {
  group('Jellyfin key coverage', () {
    test('every populated MediaSource / MediaStream / MediaAttachment key is classified', () {
      final info = parseJellyfinFileInfoFromJson(_jellyfinItem)!;
      final version = info.versions.single;
      final part = version.parts.single;
      final video = part.streamsOfKind(MediaStreamKind.video).single;
      final audio = part.streamsOfKind(MediaStreamKind.audio).single;
      final subtitle = part.streamsOfKind(MediaStreamKind.subtitle).single;
      final image = part.streamsOfKind(MediaStreamKind.image).single;
      final lyric = part.streamsOfKind(MediaStreamKind.lyric).single;
      expect(image.kind, MediaStreamKind.image);
      expect(lyric.kind, MediaStreamKind.lyric);
      final attachment = version.attachments.single;

      _expectClassified(
        observed: _jellyfinSource,
        carried: {
          'Id': version.id,
          'Name': version.title,
          'Container': version.container,
          'Bitrate': version.bitrateKbps,
          'RunTimeTicks': version.durationMs,
          'Path': part.filePath,
          'Size': part.fileSize,
          'ETag': version.eTag,
          'Protocol': version.protocol,
          'VideoType': version.videoType,
          'Type': version.sourceType,
          'IsRemote': version.isRemote,
          'IsInfiniteStream': version.isInfiniteStream,
          'SupportsDirectPlay': version.supportsDirectPlay,
          'SupportsDirectStream': version.supportsDirectStream,
          'SupportsTranscoding': version.supportsTranscoding,
          'DefaultAudioStreamIndex': version.defaultAudioStreamIndex,
          'DefaultSubtitleStreamIndex': version.defaultSubtitleStreamIndex,
          'Timestamp': version.transportStreamTimestamp,
        },
        nested: const {'MediaStreams', 'MediaAttachments'},
        // ffmpeg-input plumbing and transcoder-contract flags: they describe
        // how the server would remux the source, not the file on disk, and
        // were constant across every sampled source.
        excluded: const {
          'IgnoreDts',
          'IgnoreIndex',
          'GenPtsInput',
          'ReadAtNativeFramerate',
          'RequiresOpening',
          'RequiresClosing',
          'RequiresLooping',
          'SupportsProbing',
          'UseMostCompatibleTranscodingProfile',
          'TranscodingSubProtocol',
          'HasSegments',
          'Formats',
          'RequiredHttpHeaders',
        },
        label: 'Jellyfin MediaSource',
      );

      _expectClassified(
        observed: _jellyfinVideoStream,
        carried: {
          'Type': video.kind,
          'Index': video.index,
          'Codec': video.codec,
          'CodecTag': video.codecTag,
          'Profile': video.profile,
          'Level': video.level,
          'Title': video.title,
          'DisplayTitle': video.displayTitle,
          'Language': video.language,
          'BitRate': video.bitrateKbps,
          'BitDepth': video.bitDepth,
          'Width': video.width,
          'Height': video.height,
          'AspectRatio': video.aspectRatio,
          'RealFrameRate': video.frameRate,
          'Rotation': video.rotation,
          'PixelFormat': video.pixelFormat,
          'RefFrames': video.refFrames,
          'IsInterlaced': video.isInterlaced,
          'IsAnamorphic': video.isAnamorphic,
          'IsAVC': video.isAvc,
          'NalLengthSize': video.nalLengthSize,
          'ColorSpace': video.colorSpace,
          'ColorRange': video.colorRange,
          'ColorPrimaries': video.colorPrimaries,
          'ColorTransfer': video.colorTransfer,
          'VideoRangeType': video.videoRange,
          'Hdr10PlusPresentFlag': video.hasHdr10Plus,
          'TimeBase': video.timeBase,
          'IsDefault': video.isDefault,
          'IsForced': video.isForced,
          'IsExternal': video.isExternal,
          'IsHearingImpaired': video.isHearingImpaired,
          'IsTextSubtitleStream': video.isTextSubtitle,
          'SupportsExternalStream': video.supportsExternalStream,
          'AudioSpatialFormat': video.spatialFormat,
          'DvProfile': video.dolbyVision?.profile,
          'DvLevel': video.dolbyVision?.level,
          'DvVersionMajor': video.dolbyVision?.version,
          'DvVersionMinor': video.dolbyVision?.version,
          'DvBlSignalCompatibilityId': video.dolbyVision?.blCompatibilityId,
          'BlPresentFlag': video.dolbyVision?.blPresent,
          'ElPresentFlag': video.dolbyVision?.elPresent,
          'RpuPresentFlag': video.dolbyVision?.rpuPresent,
          'VideoDoViTitle': video.dolbyVision?.title,
        },
        nested: const {},
        // `VideoRange` is the coarse form of `VideoRangeType`; the three
        // frame-rate fields carry the same value and `RealFrameRate` wins.
        excluded: const {'VideoRange', 'AverageFrameRate', 'ReferenceFrameRate'},
        label: 'Jellyfin video stream',
      );

      _expectClassified(
        observed: _jellyfinAudioStream,
        carried: {
          'Type': audio.kind,
          'Index': audio.index,
          'Codec': audio.codec,
          'CodecTag': audio.codecTag,
          'Profile': audio.profile,
          'Level': audio.level,
          'Title': audio.title,
          'DisplayTitle': audio.displayTitle,
          'Language': audio.language,
          'BitRate': audio.bitrateKbps,
          'BitDepth': audio.bitDepth,
          'Channels': audio.channels,
          'ChannelLayout': audio.channelLayout,
          'SampleRate': audio.sampleRate,
          'AudioSpatialFormat': audio.spatialFormat,
          'TimeBase': audio.timeBase,
          'IsDefault': audio.isDefault,
          'IsForced': audio.isForced,
          'IsExternal': audio.isExternal,
          'IsHearingImpaired': audio.isHearingImpaired,
          'IsTextSubtitleStream': audio.isTextSubtitle,
          'SupportsExternalStream': audio.supportsExternalStream,
          'IsInterlaced': audio.isInterlaced,
          'IsAVC': audio.isAvc,
          'VideoRangeType': audio.videoRange,
        },
        nested: const {},
        // `Localized*` are server-rendered captions for flags the sheet
        // already renders as chips.
        excluded: const {'VideoRange', 'LocalizedDefault', 'LocalizedExternal'},
        label: 'Jellyfin audio stream',
      );

      _expectClassified(
        observed: _jellyfinSubtitleStream,
        carried: {
          'Type': subtitle.kind,
          'Index': subtitle.index,
          'Codec': subtitle.codec,
          'CodecTag': subtitle.codecTag,
          'Level': subtitle.level,
          'Title': subtitle.title,
          'DisplayTitle': subtitle.displayTitle,
          'Language': subtitle.language,
          'Width': subtitle.width,
          'Height': subtitle.height,
          'BitRate': subtitle.bitrateKbps,
          'Score': subtitle.score,
          'TimeBase': subtitle.timeBase,
          'DeliveryUrl': subtitle.externalKey,
          'Path': subtitle.filePath,
          'IsDefault': subtitle.isDefault,
          'IsForced': subtitle.isForced,
          'IsExternal': subtitle.isExternal,
          'IsHearingImpaired': subtitle.isHearingImpaired,
          'IsTextSubtitleStream': subtitle.isTextSubtitle,
          'SupportsExternalStream': subtitle.supportsExternalStream,
          'IsInterlaced': subtitle.isInterlaced,
          'IsAVC': subtitle.isAvc,
          'AudioSpatialFormat': subtitle.spatialFormat,
          'VideoRangeType': subtitle.videoRange,
        },
        nested: const {},
        excluded: const {
          'VideoRange',
          'LocalizedDefault',
          'LocalizedExternal',
          'LocalizedForced',
          'LocalizedHearingImpaired',
          'LocalizedUndefined',
        },
        label: 'Jellyfin subtitle stream',
      );

      _expectClassified(
        observed: _jellyfinEmbeddedImageStream,
        carried: {
          'Type': image.kind,
          'Index': image.index,
          'Codec': image.codec,
          'Profile': image.profile,
          'Level': image.level,
          'BitDepth': image.bitDepth,
          'Width': image.width,
          'Height': image.height,
          'AspectRatio': image.aspectRatio,
          'RealFrameRate': image.frameRate,
          'PixelFormat': image.pixelFormat,
          'RefFrames': image.refFrames,
          'IsInterlaced': image.isInterlaced,
          'IsAnamorphic': image.isAnamorphic,
          'IsAVC': image.isAvc,
          'ColorSpace': image.colorSpace,
          'ColorPrimaries': image.colorPrimaries,
          'ColorTransfer': image.colorTransfer,
          'VideoRangeType': image.videoRange,
          'AudioSpatialFormat': image.spatialFormat,
          'TimeBase': image.timeBase,
          'IsDefault': image.isDefault,
          'IsForced': image.isForced,
          'IsExternal': image.isExternal,
          'IsHearingImpaired': image.isHearingImpaired,
          'IsTextSubtitleStream': image.isTextSubtitle,
          'SupportsExternalStream': image.supportsExternalStream,
          'Comment': image.comment,
        },
        nested: const {},
        // `VideoRange` is the coarse form of `VideoRangeType`;
        // `ReferenceFrameRate` duplicates `RealFrameRate`.
        excluded: const {'VideoRange', 'ReferenceFrameRate'},
        label: 'Jellyfin embedded image stream',
      );

      _expectClassified(
        observed: _jellyfinLyricStream,
        carried: {
          'Type': lyric.kind,
          'Index': lyric.index,
          'AudioSpatialFormat': lyric.spatialFormat,
          'IsDefault': lyric.isDefault,
          'IsForced': lyric.isForced,
          'IsExternal': lyric.isExternal,
          'IsHearingImpaired': lyric.isHearingImpaired,
          'IsInterlaced': lyric.isInterlaced,
          'IsTextSubtitleStream': lyric.isTextSubtitle,
          'SupportsExternalStream': lyric.supportsExternalStream,
          'Path': lyric.filePath,
          'VideoRangeType': lyric.videoRange,
        },
        nested: const {},
        // `VideoRange` is the coarse form of `VideoRangeType`.
        excluded: const {'VideoRange'},
        label: 'Jellyfin lyric stream',
      );

      _expectClassified(
        observed: _jellyfinAttachment,
        carried: {
          'Index': attachment.index,
          'FileName': attachment.fileName,
          'MimeType': attachment.mimeType,
          'Codec': attachment.codec,
        },
        nested: const {},
        // Live servers leave `Codec` null and populate `CodecTag`; the parser
        // prefers `Codec` and falls back, so one row covers both.
        excluded: const {'CodecTag'},
        label: 'Jellyfin attachment',
      );
    });

    test('attachment codec prefers Codec and falls back to CodecTag', () {
      final withBoth = parseJellyfinFileInfoFromJson({
        'MediaSources': [
          {
            'MediaAttachments': [
              {'Index': 1, 'FileName': 'a.ttf', 'Codec': 'ttf', 'CodecTag': '[0][0][0][0]'},
              {'Index': 2, 'FileName': 'b.ttf', 'CodecTag': '[0][0][0][0]'},
            ],
          },
        ],
      })!.versions.single.attachments;
      expect(withBoth[0].codec, 'ttf');
      expect(withBoth[1].codec, '[0][0][0][0]');
    });

    test('bool-ish scalars are tolerated the way Plex-shaped payloads are', () {
      // Jellyfin normally sends proper JSON booleans, but proxies and older
      // server builds have been seen echoing 0/1 or "true".
      final stream = parseJellyfinFileInfoFromJson({
        'MediaSources': [
          {
            'IsRemote': 'false',
            'SupportsDirectPlay': 1,
            'MediaStreams': [
              {'Type': 'Subtitle', 'Index': 0, 'IsForced': 'true', 'IsDefault': 0, 'IsTextSubtitleStream': 1},
            ],
          },
        ],
      })!.versions.single;
      expect(stream.isRemote, isFalse);
      expect(stream.supportsDirectPlay, isTrue);
      final subtitle = stream.parts.single.streams.single;
      expect(subtitle.isForced, isTrue);
      expect(subtitle.isDefault, isFalse);
      expect(subtitle.isTextSubtitle, isTrue);
    });

    test('a malformed sibling is skipped instead of sinking the whole sheet', () {
      final info = parseJellyfinFileInfoFromJson({
        'MediaSources': [
          {
            'Id': 'source-1',
            'MediaStreams': [
              {'Type': 'Video', 'Index': 0, 'Codec': 'h264'},
              'not-a-stream',
              {'Type': 'Audio', 'Index': 1, 'Codec': 'aac'},
            ],
            'MediaAttachments': [
              {'Index': 0, 'FileName': 'a.ttf'},
              42,
            ],
          },
          'not-a-source',
          {'Id': 'source-2', 'Container': 'mp4'},
        ],
      })!;

      expect(info.versions.map((version) => version.id), ['source-1', 'source-2']);
      expect(info.versions.first.parts.single.streams.map((stream) => stream.codec), ['h264', 'aac']);
      expect(info.versions.first.attachments.map((attachment) => attachment.fileName), ['a.ttf']);
    });
  });

  test('newly surfaced values keep their distinct semantics', () {
    final jellyfinInfo = parseJellyfinFileInfoFromJson(_jellyfinItem)!;
    final jellyfinPart = jellyfinInfo.versions.single.parts.single;
    final jellyfinVideo = jellyfinPart.streamsOfKind(MediaStreamKind.video).single;
    final jellyfinSubtitle = jellyfinPart.streamsOfKind(MediaStreamKind.subtitle).single;
    expect(jellyfinVideo.rotation, 90);
    expect(jellyfinSubtitle.filePath, '/media/Movies/1917 (2019)/1917 (2019).eng.srt');
    expect(jellyfinSubtitle.externalKey, '/Videos/1/1/Subtitles/2/0/Stream.srt');
  });
}

/// Fails when [observed] carries a key that is neither projected onto the
/// model, recursed into, nor explicitly excluded — and when a key claimed as
/// carried did not actually survive the parse.
void _expectClassified({
  required Map<String, dynamic> observed,
  required Map<String, Object?> carried,
  required Set<String> nested,
  required Set<String> excluded,
  required String label,
}) {
  final classified = {...carried.keys, ...nested, ...excluded};
  final unclassified = observed.keys.where((key) => !classified.contains(key)).toList()..sort();
  expect(
    unclassified,
    isEmpty,
    reason:
        '$label exposes ${unclassified.join(', ')}. Map it onto MediaFileInfo, '
        'fold it into an existing field, or add it to the exclusion set with a reason.',
  );

  final dropped = carried.entries.where((entry) => observed[entry.key] != null && entry.value == null).toList();
  expect(
    dropped.map((entry) => entry.key).toList()..sort(),
    isEmpty,
    reason: '$label claims to carry ${dropped.map((e) => e.key).join(', ')} but the parsed value is null.',
  );
}

// --- Jellyfin fixture ------------------------------------------------------

const _jellyfinVideoStream = <String, dynamic>{
  'Type': 'Video',
  'Index': 0,
  'Codec': 'hevc',
  'CodecTag': 'hvc1',
  'Profile': 'Main 10',
  'Level': 153,
  'Title': 'Remux',
  'DisplayTitle': '4K HEVC Dolby Vision Profile 8.1 (HDR10)',
  'Language': 'eng',
  'BitRate': 31800000,
  'BitDepth': 10,
  'Width': 3840,
  'Height': 1604,
  'AspectRatio': '2.40:1',
  'AverageFrameRate': 23.976,
  'RealFrameRate': 23.976,
  'ReferenceFrameRate': 23.976,
  'Rotation': 90,
  'PixelFormat': 'yuv420p10le',
  'RefFrames': 1,
  'IsInterlaced': false,
  'IsAnamorphic': false,
  'IsAVC': false,
  'NalLengthSize': 4,
  'ColorSpace': 'bt2020nc',
  'ColorRange': 'tv',
  'ColorPrimaries': 'bt2020',
  'ColorTransfer': 'smpte2084',
  'VideoRange': 'HDR',
  'VideoRangeType': 'DOVIWithHDR10Plus',
  'Hdr10PlusPresentFlag': true,
  'AudioSpatialFormat': 'None',
  'TimeBase': '1/24000',
  'IsDefault': true,
  'IsForced': false,
  'IsExternal': false,
  'IsHearingImpaired': false,
  'IsTextSubtitleStream': false,
  'SupportsExternalStream': false,
  'DvProfile': 8,
  'DvLevel': 10,
  'DvVersionMajor': 1,
  'DvVersionMinor': 0,
  'DvBlSignalCompatibilityId': 1,
  'BlPresentFlag': true,
  'ElPresentFlag': false,
  'RpuPresentFlag': true,
  'VideoDoViTitle': 'Dolby Vision Profile 8.1 (HDR10)',
};

const _jellyfinAudioStream = <String, dynamic>{
  'Type': 'Audio',
  'Index': 1,
  'Codec': 'truehd',
  'CodecTag': 'ac-3',
  'Profile': 'Dolby TrueHD + Dolby Atmos',
  'Level': 4,
  'Title': 'Surround 7.1',
  'DisplayTitle': 'Surround 7.1 - English - Dolby TrueHD + Dolby Atmos - Default',
  'Language': 'eng',
  'BitRate': 4500000,
  'BitDepth': 24,
  'Channels': 8,
  'ChannelLayout': '7.1',
  'SampleRate': 48000,
  'AudioSpatialFormat': 'DolbyAtmos',
  'TimeBase': '1/1000',
  'IsDefault': true,
  'IsForced': false,
  'IsExternal': false,
  'IsHearingImpaired': false,
  'IsInterlaced': false,
  'IsAVC': false,
  'IsTextSubtitleStream': false,
  'SupportsExternalStream': false,
  'VideoRange': 'Unknown',
  'VideoRangeType': 'Unknown',
  'LocalizedDefault': 'Default',
  'LocalizedExternal': 'External',
};

const _jellyfinSubtitleStream = <String, dynamic>{
  'Type': 'Subtitle',
  'Index': 2,
  'Codec': 'SUBRIP',
  'CodecTag': '[0][0][0][0]',
  'Level': 0,
  'Title': 'English',
  'DisplayTitle': 'English - SUBRIP',
  'Language': 'eng',
  'BitRate': 128000,
  'Width': 1920,
  'Height': 1080,
  'Score': 121211,
  'TimeBase': '1/1000',
  'DeliveryUrl': '/Videos/1/1/Subtitles/2/0/Stream.srt',
  'Path': '/media/Movies/1917 (2019)/1917 (2019).eng.srt',
  'IsDefault': false,
  'IsForced': false,
  'IsExternal': true,
  'IsHearingImpaired': false,
  'IsInterlaced': false,
  'IsAVC': false,
  'IsTextSubtitleStream': true,
  'SupportsExternalStream': true,
  'AudioSpatialFormat': 'None',
  'VideoRange': 'Unknown',
  'VideoRangeType': 'Unknown',
  'LocalizedDefault': 'Default',
  'LocalizedExternal': 'External',
  'LocalizedForced': 'Forced',
  'LocalizedHearingImpaired': 'Hearing Impaired',
  'LocalizedUndefined': 'Undefined',
};

const _jellyfinEmbeddedImageStream = <String, dynamic>{
  'Type': 'EmbeddedImage',
  'Index': 3,
  'Codec': 'mjpeg',
  'Profile': 'Baseline',
  'Level': 31,
  'BitDepth': 8,
  'Width': 600,
  'Height': 900,
  'AspectRatio': '2:3',
  'RealFrameRate': 0.1,
  'ReferenceFrameRate': 0.1,
  'PixelFormat': 'yuvj420p',
  'RefFrames': 1,
  'IsInterlaced': false,
  'IsAnamorphic': false,
  'IsAVC': false,
  'ColorSpace': 'bt470bg',
  'ColorPrimaries': 'bt709',
  'ColorTransfer': 'bt709',
  'VideoRange': 'SDR',
  'VideoRangeType': 'SDR',
  'AudioSpatialFormat': 'None',
  'TimeBase': '1/90000',
  'IsDefault': false,
  'IsForced': false,
  'IsExternal': false,
  'IsHearingImpaired': false,
  'IsTextSubtitleStream': false,
  'SupportsExternalStream': false,
  'Comment': 'Cover (front)',
};

const _jellyfinLyricStream = <String, dynamic>{
  'Type': 'Lyric',
  'Index': 4,
  'AudioSpatialFormat': 'None',
  'IsDefault': false,
  'IsForced': false,
  'IsExternal': true,
  'IsHearingImpaired': false,
  'IsInterlaced': false,
  'IsTextSubtitleStream': true,
  'SupportsExternalStream': true,
  'Path': '/media/Movies/1917 (2019)/1917 (2019).lrc',
  'VideoRange': 'Unknown',
  'VideoRangeType': 'Unknown',
};

const _jellyfinAttachment = <String, dynamic>{
  'Index': 6,
  'FileName': 'akbar.ttf',
  'MimeType': 'font/ttf',
  'Codec': 'ttf',
  'CodecTag': '[0][0][0][0]',
};

const _jellyfinSource = <String, dynamic>{
  'Id': '5deccd65b8114bdab312be160437eecb',
  'Name': '1917 (2019)',
  'Path': '/media/Movies/1917 (2019)/1917 (2019).mkv',
  'Container': 'mkv',
  'Size': 28372183040,
  'ETag': '4581fa214aba4b58ce02ca1e29ea5e0e',
  'Timestamp': 'Valid',
  'Bitrate': 36400000,
  'RunTimeTicks': 71390000000,
  'Protocol': 'File',
  'Type': 'Default',
  'VideoType': 'VideoFile',
  'IsRemote': false,
  'IsInfiniteStream': false,
  'SupportsDirectPlay': true,
  'SupportsDirectStream': true,
  'SupportsTranscoding': true,
  'DefaultAudioStreamIndex': 1,
  'DefaultSubtitleStreamIndex': 2,
  'IgnoreDts': false,
  'IgnoreIndex': false,
  'GenPtsInput': false,
  'ReadAtNativeFramerate': false,
  'RequiresOpening': false,
  'RequiresClosing': false,
  'RequiresLooping': false,
  'SupportsProbing': true,
  'UseMostCompatibleTranscodingProfile': false,
  'TranscodingSubProtocol': 'http',
  'HasSegments': false,
  'Formats': <dynamic>[],
  'RequiredHttpHeaders': <String, dynamic>{},
  'MediaStreams': [
    _jellyfinVideoStream,
    _jellyfinAudioStream,
    _jellyfinSubtitleStream,
    _jellyfinEmbeddedImageStream,
    _jellyfinLyricStream,
  ],
  'MediaAttachments': [_jellyfinAttachment],
};

const _jellyfinItem = <String, dynamic>{
  'MediaSources': [_jellyfinSource],
};
