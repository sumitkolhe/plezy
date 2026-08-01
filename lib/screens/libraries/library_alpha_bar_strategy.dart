import '../../media/library_first_character.dart';
import '../../media/media_backend.dart';
import 'alpha_jump_helper.dart';

/// Backend-specific alpha-jump-bar behaviour.
///
/// Plex libraries use real per-letter counts from
/// `/library/sections/{id}/firstCharacter`, so the bar is scroll-position
/// driven — tapping a letter scrolls to that letter's cumulative offset and
/// the highlighted letter follows the visible row.
///
/// Jellyfin libraries have no per-letter count endpoint. The bar synthesises
/// the 27-letter alphabet (`#`, `A`–`Z`) and acts as a name-prefix filter
/// that refetches the page when the user picks a letter (matches the JF web
/// client's UX).
abstract class LibraryAlphaBarStrategy {
  /// Whether the bar should be rendered at all. Implementations consider
  /// total item count, sort key, and current filter state.
  bool shouldShow({
    required int totalItemCount,
    required int loadedCharacterCount,
    required String? sortKey,
    required bool isFolderGrouping,
    required String? jellyfinAlphaPrefix,
    required bool isPhone,
  });

  /// Load the first-character buckets for the current filter state.
  /// Returns the new helper plus the synthesised character list — the caller
  /// stores both in widget state.
  Future<({List<LibraryFirstCharacter> chars, AlphaJumpHelper helper})> loadCharacters({
    required Map<String, String> filters,
    required int? typeId,
    required bool descending,
  });

  /// Letter to highlight given the current scroll-derived index. Plex maps
  /// the index back through the cumulative offsets; Jellyfin echoes back
  /// whatever filter is active.
  String currentLetter(int index, AlphaJumpHelper helper, {String? jellyfinAlphaPrefix});

  /// Handle a tap on the letter at [targetIndex]. Plex strategies invoke
  /// [onSectionJump] with the cumulative item index for in-grid scrolling;
  /// Jellyfin strategies invoke [onJellyfinPrefixChange] with the next
  /// `NameStartsWith` prefix (or `null` to clear the filter when the user
  /// re-taps the active letter). Each strategy ignores the callback that
  /// doesn't apply to its UX, so callers can wire both unconditionally.
  void onLetterPressed(
    int targetIndex,
    AlphaJumpHelper helper, {
    required String? currentJellyfinPrefix,
    required void Function(int index) onSectionJump,
    required void Function(String? nextPrefix) onJellyfinPrefixChange,
  });

  /// Construct the right strategy for [backend].
  factory LibraryAlphaBarStrategy.forBackend(MediaBackend backend) => const JellyfinAlphaBarStrategy();
}

/// Jellyfin strategy — synthesises the 27-letter alphabet locally and uses
/// the bar as a `NameStartsWith` filter.
class JellyfinAlphaBarStrategy implements LibraryAlphaBarStrategy {
  static const _letters = [
    '#',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  const JellyfinAlphaBarStrategy();

  @override
  bool shouldShow({
    required int totalItemCount,
    required int loadedCharacterCount,
    required String? sortKey,
    required bool isFolderGrouping,
    required String? jellyfinAlphaPrefix,
    required bool isPhone,
  }) {
    if (isPhone) return false;
    if (isFolderGrouping) return false;
    if (loadedCharacterCount == 0) return false;
    return totalItemCount >= 80 || jellyfinAlphaPrefix != null;
  }

  @override
  Future<({List<LibraryFirstCharacter> chars, AlphaJumpHelper helper})> loadCharacters({
    required Map<String, String> filters,
    required int? typeId,
    required bool descending,
  }) async {
    final synthetic = [for (final l in _letters) LibraryFirstCharacter(key: l, title: l, size: 1)];
    return (chars: synthetic, helper: AlphaJumpHelper(synthetic, descending: descending));
  }

  @override
  String currentLetter(int index, AlphaJumpHelper helper, {String? jellyfinAlphaPrefix}) => jellyfinAlphaPrefix ?? '';

  /// Jellyfin reuses the alpha bar as a `NameStartsWith` filter. We map the
  /// bar offset back to a letter (the synthesised `size: 1` entries make
  /// offset == position in [helper.letters]) and toggle the filter — re-tap
  /// the active letter to clear, otherwise set the new prefix.
  @override
  void onLetterPressed(
    int targetIndex,
    AlphaJumpHelper helper, {
    required String? currentJellyfinPrefix,
    required void Function(int index) onSectionJump,
    required void Function(String? nextPrefix) onJellyfinPrefixChange,
  }) {
    if (targetIndex < 0 || targetIndex >= helper.letters.length) return;
    final letter = helper.letters[targetIndex];
    final next = (currentJellyfinPrefix == letter) ? null : letter;
    onJellyfinPrefixChange(next);
  }
}
