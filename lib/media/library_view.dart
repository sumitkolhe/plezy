import 'dart:convert';

import 'package:flutter/foundation.dart';

/// A named set of filters over one library.
///
/// Filters only, deliberately. A view answers what is in the list; sort and
/// grouping answer how it is arranged, and stay live controls that apply to
/// whichever view is showing. Folding all three into a view meant a view had to
/// pin the sort and suppress every write-back to keep from overwriting plain
/// browse, which in turn meant a view could not be re-sorted while you looked
/// at it.
@immutable
class LibraryView {
  const LibraryView({required this.name, this.filters = const {}});

  final String name;

  /// The filter map as the filters sheet produces it.
  final Map<String, String> filters;

  Map<String, dynamic> toJson() => {'name': name, if (filters.isNotEmpty) 'filters': filters};

  /// Null for a row that cannot name itself, so one unreadable entry costs
  /// only itself.
  static LibraryView? fromJson(Map<String, dynamic> json) {
    final name = (json['name'] as String?)?.trim() ?? '';
    if (name.isEmpty) return null;

    final rawFilters = json['filters'];
    return LibraryView(
      name: name,
      filters: rawFilters is Map
          ? {
              for (final entry in rawFilters.entries)
                if (entry.key is String && entry.value != null) entry.key as String: '${entry.value}',
            }
          : const {},
    );
  }

  static String encodeList(List<LibraryView> views) => jsonEncode([for (final view in views) view.toJson()]);

  static List<LibraryView> decodeList(String? raw) {
    if (raw == null || raw.isEmpty) return const [];
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const [];
    return [
      for (final entry in decoded)
        if (entry is Map<String, dynamic>) ?fromJson(entry),
    ];
  }

  LibraryView copyWith({String? name, Map<String, String>? filters}) =>
      LibraryView(name: name ?? this.name, filters: filters ?? this.filters);

  /// Whether the library is currently filtered to this view.
  bool matches(Map<String, String> filters) => mapEquals(this.filters, filters);
}
