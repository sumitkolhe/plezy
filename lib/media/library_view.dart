import 'dart:convert';

import 'package:flutter/foundation.dart';

/// A named way of looking at one library: what is listed, in what order, with
/// what filtered out.
///
/// Those three already persist per library — a view is that same triple kept
/// under a name so several can exist side by side, instead of the one the
/// library happens to be showing.
@immutable
class LibraryView {
  const LibraryView({
    required this.name,
    required this.grouping,
    this.filters = const {},
    this.sortKey,
    this.descending = false,
  });

  final String name;

  /// A `browseGrouping*` value: what the view lists.
  final String grouping;

  /// The filter map as the filters sheet produces it.
  final Map<String, String> filters;

  /// Null means the library's own default order.
  final String? sortKey;
  final bool descending;

  Map<String, dynamic> toJson() => {
    'name': name,
    'grouping': grouping,
    if (filters.isNotEmpty) 'filters': filters,
    if (sortKey != null) 'sortKey': sortKey,
    if (descending) 'descending': true,
  };

  /// Null for a row that cannot name or scope itself, so one unreadable entry
  /// costs only itself.
  static LibraryView? fromJson(Map<String, dynamic> json) {
    final name = (json['name'] as String?)?.trim() ?? '';
    final grouping = (json['grouping'] as String?)?.trim() ?? '';
    if (name.isEmpty || grouping.isEmpty) return null;

    final rawFilters = json['filters'];
    return LibraryView(
      name: name,
      grouping: grouping,
      filters: rawFilters is Map
          ? {
              for (final entry in rawFilters.entries)
                if (entry.key is String && entry.value != null) entry.key as String: '${entry.value}',
            }
          : const {},
      sortKey: (json['sortKey'] as String?)?.trim(),
      descending: json['descending'] == true,
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

  /// Whether the library is currently showing this view.
  bool matches({
    required String grouping,
    required String? sortKey,
    required bool descending,
    required Map<String, String> filters,
  }) {
    return this.grouping == grouping &&
        this.sortKey == sortKey &&
        this.descending == descending &&
        mapEquals(this.filters, filters);
  }
}
