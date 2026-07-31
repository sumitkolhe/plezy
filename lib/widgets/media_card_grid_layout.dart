import 'package:flutter/widgets.dart';

/// Grid-mode card geometry, shared so `HubSection` can size a rail before any
/// card is laid out without re-deriving what `MediaCard` renders.
@immutable
class MediaCardGridLayout {
  const MediaCardGridLayout._({
    required this.padding,
    required this.captionGap,
    required this.titleSubtitleGap,
    required this.titleStyle,
    required this.subtitleFontSize,
    required this.subtitleHeight,
    required this.focusHeadroom,
  });

  static const MediaCardGridLayout touch = MediaCardGridLayout._(
    padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
    captionGap: 8,
    titleSubtitleGap: 3,
    titleStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, height: 1.25),
    subtitleFontSize: 11,
    subtitleHeight: 1.2,
    focusHeadroom: 0,
  );

  static const MediaCardGridLayout tv = MediaCardGridLayout._(
    padding: EdgeInsets.fromLTRB(3, 3, 3, 1),
    captionGap: 2,
    titleSubtitleGap: 0,
    titleStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, height: 1.1),
    subtitleFontSize: 11,
    subtitleHeight: 1.1,
    focusHeadroom: 15,
  );

  static MediaCardGridLayout of({required bool isTv}) => isTv ? tv : touch;

  final EdgeInsets padding;
  final double captionGap;
  final double titleSubtitleGap;
  final TextStyle titleStyle;
  final double subtitleFontSize;
  final double subtitleHeight;

  /// Slack for the d-pad focus scale, which grows a card in place.
  final double focusHeadroom;

  static double get horizontalInset => touch.padding.horizontal;

  static double posterWidth(double cardWidth) => cardWidth - horizontalInset;

  double get _titleLine => titleStyle.fontSize! * titleStyle.height!;
  double get _subtitleLine => subtitleFontSize * subtitleHeight;

  /// What the caption block actually occupies, excluding [focusHeadroom].
  /// Callers that reserve their own band must not size below this or the
  /// card's Column overflows.
  double get renderedCaptionHeight => padding.vertical + captionGap + _titleLine + titleSubtitleGap + _subtitleLine;

  /// Ceiled so a fractional line box cannot leave the last text row a subpixel
  /// short of its container and trip a paint-time overflow.
  double get captionHeight => (renderedCaptionHeight + focusHeadroom).ceilToDouble();
}
