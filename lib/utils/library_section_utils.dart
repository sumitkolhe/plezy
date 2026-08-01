final RegExp librarySectionPathPattern = RegExp(r'/(?:library|hubs)/sections/(\d+)');

/// Matches a section id carried in a query string rather than the path, e.g.
/// `/hubs/home/recentlyAdded?type=2&sectionID=2`. The `[?&]` anchor keeps it from
/// false-matching a path segment; the alternation also accepts `librarySectionID=`.
final RegExp librarySectionQueryPattern = RegExp(r'[?&](?:librarySectionID|sectionID)=(\d+)');

int? librarySectionIdFromString(String? value) {
  if (value == null || value == 'shared') return null;
  final direct = int.tryParse(value);
  if (direct != null) return direct;
  final pathMatch = librarySectionPathPattern.firstMatch(value);
  if (pathMatch != null) return int.tryParse(pathMatch.group(1)!);
  final queryMatch = librarySectionQueryPattern.firstMatch(value);
  return queryMatch == null ? null : int.tryParse(queryMatch.group(1)!);
}
