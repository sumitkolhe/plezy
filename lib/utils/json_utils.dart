/// Parse a value that may be [int], [num], or [String] to [int].
/// Used as `@JsonKey(fromJson: flexibleInt)` and in manual `fromJson` factories
/// to handle Plex API responses where numeric fields may arrive as strings
/// (XML-to-JSON conversion).
int? flexibleInt(Object? v) => switch (v) {
  final num n => n.toInt(),
  final String s => int.tryParse(s),
  _ => null,
};

String stringOrEmpty(Object? v) => (v ?? '').toString();

/// Parse a value that may be [bool], [int] (0/1), or [String] ('1'/'true'/'false') to [bool].
/// Returns `null` for `null` or unsupported non-string values; legacy string
/// values other than `'1'`/`'true'` map to `false`.
bool? flexibleBoolNullable(Object? v) => switch (v) {
  final bool b => b,
  final int n => n == 1,
  final String s => s == '1' || s.toLowerCase() == 'true',
  _ => null,
};

/// Parse a value that may be [double], [num], or [String] to [double].
double? flexibleDouble(Object? v) => switch (v) {
  final num n => n.toDouble(),
  final String s => double.tryParse(s),
  _ => null,
};

/// `@JsonKey(readValue:)` adapter — coerces the named field to a String via
/// `toString()` before the generated cast. Use for required `String` fields
/// that Plex may return as int in some endpoints.
Object? readStringField(Map json, String key) => json[key]?.toString();

List<String>? stringListFromRaw(Object? raw, {String? mapKey, bool stringify = false, bool nullIfEmpty = false}) {
  if (raw is! List) return null;
  final result = <String>[];
  for (final value in raw) {
    final source = mapKey != null && value is Map ? value[mapKey] : value;
    final string = stringify
        ? source?.toString()
        : source is String
        ? source
        : null;
    if (string != null) result.add(string);
  }
  if (result.isEmpty && nullIfEmpty) return null;
  return result;
}

List<T>? nullIfEmptyList<T>(List<T> values) => values.isEmpty ? null : values;

/// First entry that is neither null nor blank after trimming, else null.
///
/// Remote APIs distinguish "absent" from "present but empty" inconsistently.
/// TMDB in particular answers a `language=` query for an untranslated title or
/// overview with an empty string rather than omitting the field, so `??`
/// fallback chains silently select the blank. Use this where a localized value
/// must degrade to an untranslated one.
String? firstNonBlank(Iterable<String?> values) {
  for (final value in values) {
    final trimmed = value?.trim();
    if (trimmed != null && trimmed.isNotEmpty) return trimmed;
  }
  return null;
}
