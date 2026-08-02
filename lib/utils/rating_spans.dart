import 'package:flutter/widgets.dart';
import 'package:harbor/theme/phosphor_icons.dart';

import '../widgets/app_icon.dart';
import 'content_utils.dart';
import 'formatters.dart';

/// Inline star + value for a rating inside a dot-separated metadata line.
///
/// The literal `★` (U+2605) is absent from the bundled app font, so it rendered
/// from a platform fallback at a different weight and size than the text around
/// it. An icon span inherits the surrounding style instead.
InlineSpan ratingSpan(double rating, {required double iconSize, String suffix = ''}) {
  return TextSpan(
    children: [
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.only(right: 3),
          child: AppIcon(PhosphorIconsDuotone.star, fill: 1, size: iconSize),
        ),
      ),
      TextSpan(text: '${formatRating(rating)}$suffix'),
    ],
  );
}

/// Joins [parts] with ` • `, dropping nulls.
const String dotSeparator = ' • ';

List<InlineSpan> dotSeparatedSpans(List<InlineSpan?> parts) {
  final kept = parts.whereType<InlineSpan>().toList();
  return [
    for (var i = 0; i < kept.length; i++) ...[if (i > 0) const TextSpan(text: dotSeparator), kept[i]],
  ];
}

List<InlineSpan> heroMetadataSpans({
  required String contentTypeLabel,
  required double? rating,
  required String? contentRating,
  required int? year,
  required double iconSize,
}) {
  return dotSeparatedSpans([
    TextSpan(text: contentTypeLabel),
    if (rating != null) ratingSpan(rating, iconSize: iconSize),
    if (contentRating != null) TextSpan(text: formatContentRating(contentRating)),
    if (year != null) TextSpan(text: '$year'),
  ]);
}
