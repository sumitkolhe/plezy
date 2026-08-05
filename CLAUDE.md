# Harbor

Android-only Jellyfin client, forked from plezy. Personal project.

Everything below is either non-obvious or was learned the hard way. Things the
code already tells you are deliberately not repeated here.

## Ground rules

- **Android only.** iOS/desktop/TV code paths still exist in places; do not add
  more, and do not spend effort on them.
- **Comments explain why, never what.** A comment that restates the line below
  it should not be written. One line, or nothing.
- **No line that does not do work.** No unused parameters, no recomputed values,
  no flags with a single hardcoded caller. If a change leaves something with no
  users, delete it in the same change.
- Commits are grouped by responsibility. Do not add a Co-Authored-By trailer.
  Do not push.

## Build and install

```bash
export JAVA_HOME=/opt/homebrew/opt/openjdk@21
flutter build apk --release --split-per-abi --target-platform android-arm64
adb -t <transport_id> install -r build/app/outputs/flutter-apk/app-arm64-v8a-release.apk
```

`--split-per-abi` is **required**, and this is the trap: without it Gradle writes
`app-release.apk` with versionCode **125**, while a split build writes
`app-arm64-v8a-release.apk` with **2125** (the +2000 ABI offset is only applied
when splitting). The device carries 2125, so a non-split APK cannot install over
it — and worse, a stale split APK from an earlier build sits at the same path and
installs happily, so you ship nothing and `adb` still says `Success`.

**Never treat `Success` as proof.** Confirm the install actually landed:

```bash
adb -t <id> shell dumpsys package co.sumit.harbor | grep -E "versionCode|lastUpdateTime"
```

`lastUpdateTime` must be seconds old. Wireless adb drops constantly; re-read the
transport id from `adb devices -l` before every command rather than reusing one.

## Gates — all four must pass before committing

```bash
flutter analyze lib test                       # zero warnings, not just zero errors
flutter test                                   # ~3,780 tests
python3 scripts/clean_translations.py --check --strict
dart run dart_code_linter:metrics check-unused-code lib
dart run dart_code_linter:metrics check-unused-files lib
```

## Formatting

`analysis_options.yaml` sets `page_width: 120`, but ~34 files under `lib/` do not
match what the current `dart format` produces — the repo was written against a
different formatter version, and CI does not check formatting.

**Never run `dart format lib/`.** It rewrites three dozen unrelated files and
buries the real change. Format only files you already edited, and check
`git diff --stat` afterwards for churn you did not intend.

## Sheets and drawers

Every overlay drawer shares one structure. This was rebuilt from scratch after
several rounds of near-misses; do not reintroduce a second way of doing it.

- **One header:** `BottomSheetHeader` — `titleMedium`, padding `(16, 4, 16, 8)`,
  no border, **no close button**. The drag handle, the scrim and Back already
  dismiss a sheet. `onBack` is navigation to a parent page, not a way out.
- **One row:** `AppMenuItemTile` / `AppMenuList`, 56dp, label at `bodyMedium`
  (14sp), text on a 56dp inset. `ListTile` renders its title at `bodyLarge`
  (16sp) — mixing the two is what made drawers look magnified for weeks.
  `test/widgets/drawer_row_consistency_test.dart` fails if a drawer file reaches
  for `FocusableListTile` or a `*ListTile` variant again.
- **One row height.** There is no separate two-line height; a label plus its
  secondary line measure 36dp and fit the 56dp row.
- **Selection is a check plus a bolded label**, never a filled pill.
- `showDragHandle` defaults to **true**; do not pass it.
- **Titles are optional and often wrong.** A title earns its place only when the
  rows cannot say it themselves — which track type, which sub-page, which filter,
  which item you pressed. If the screen is already about that item, pass
  `showItemTitle: false` (context menus) or omit the title. Rate, Chapters, both
  Queues, Select library and Seerr request have no title by design.
- `FocusableListTile` stays for **settings screens and dialogs** — they are
  scanned, not picked from. It is not a drawer widget.

## Widget tests

Any test that builds a production widget must use `monoTheme(dark: true)`:

```dart
MaterialApp(theme: monoTheme(dark: true), home: Scaffold(body: ...))
```

A bare `MaterialApp` has no `MonoTokens` theme extension, so `tokens(context)`
throws a null-check error. Several tests only passed because `ListTile` happens
not to read the extension; they broke the moment the widget under test did.

Two more traps: `showAdaptiveAppMenu` renders an anchored popup with **no title**
unless the platform is Android/iOS, so a test asserting a sheet title needs
`.copyWith(platform: TargetPlatform.android)`. And a sheet route outlives
`pumpWidget`, so pump a `SizedBox` between two cases in one test.

## i18n

22 locales, slang-generated. Placeholders are Dart-style `${name}`, **not**
`{name}` — the wrong form silently generates a getter instead of a method and
every call site fails to compile.

Removing a string means deleting the key from all 22 JSON files and running
`dart run slang`. The strict translation gate catches an orphan immediately.

## Services

`*arr` integration (Sonarr/Radarr/qBittorrent) lives in `lib/services/arr/`:

- Radarr keys on **tmdbId**, Sonarr on **tvdbId**. Not interchangeable; the wrong
  id returns an empty result rather than an error.
- An *arr queue item's `downloadId` **is** the download client's hash — that join
  is what lets a transfer show both its *arr stage and its client progress.
- qBittorrent: a bad password is HTTP **200** with body `Fails.`, an expired
  session is **403**, hashes are lowercased, and `eta: 8640000` means unknown.
- Sonarr's `statistics.episodeCount` counts aired episodes; `totalEpisodeCount`
  includes unaired ones.
