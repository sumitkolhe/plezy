import 'dart:ui';

/// The handful of Android system tones Material You is built from.
///
/// Android exposes its wallpaper palette as resources whose suffix counts down
/// from white, so `system_neutral1_900` is M3 tone 10 and `_50` is tone 95.
class DynamicPalette {
  /// neutral1 tone 10 — the darkest tinted neutral Android publishes.
  final Color neutralDark;

  /// neutral1 tone 95.
  final Color neutralLight;

  /// neutral1 tone 100. Untinted, and only a lerp target.
  final Color neutralWhite;

  /// accent1 tone 80, which M3 uses as `primary` on dark schemes.
  final Color accentDark;

  /// accent1 tone 40, which M3 uses as `primary` on light schemes.
  final Color accentLight;

  const DynamicPalette({
    required this.neutralDark,
    required this.neutralLight,
    required this.neutralWhite,
    required this.accentDark,
    required this.accentLight,
  });

  static DynamicPalette? fromChannel(Map<Object?, Object?>? raw) {
    if (raw == null) return null;
    int? argb(String key) => (raw[key] as num?)?.toInt();
    final neutralDark = argb('neutralDark');
    final neutralLight = argb('neutralLight');
    final neutralWhite = argb('neutralWhite');
    final accentDark = argb('accentDark');
    final accentLight = argb('accentLight');
    if (neutralDark == null ||
        neutralLight == null ||
        neutralWhite == null ||
        accentDark == null ||
        accentLight == null) {
      return null;
    }
    return DynamicPalette(
      neutralDark: Color(neutralDark),
      neutralLight: Color(neutralLight),
      neutralWhite: Color(neutralWhite),
      accentDark: Color(accentDark),
      accentLight: Color(accentLight),
    );
  }

  Map<String, int> toJson() => {
    'neutralDark': neutralDark.toARGB32(),
    'neutralLight': neutralLight.toARGB32(),
    'neutralWhite': neutralWhite.toARGB32(),
    'accentDark': accentDark.toARGB32(),
    'accentLight': accentLight.toARGB32(),
  };

  static DynamicPalette? fromJson(Map<String, Object?> json) => fromChannel(json);

  @override
  bool operator ==(Object other) =>
      other is DynamicPalette &&
      other.neutralDark == neutralDark &&
      other.neutralLight == neutralLight &&
      other.neutralWhite == neutralWhite &&
      other.accentDark == accentDark &&
      other.accentLight == accentLight;

  @override
  int get hashCode => Object.hash(neutralDark, neutralLight, neutralWhite, accentDark, accentLight);
}
