# Harbor

Android-only Jellyfin client. Personal project.

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

## One active server

Only one server is active at a time. Do not design features that query several
at once, and do not add UI that names which server something came from.

This is a constraint on *concurrency*, not on identity: a user can still have
more than one server configured and switch between them, so `serverId` remains
meaningful for cache keys, downloads and offline state. What is going away is
the aggregation — fanning out to `onlineClients`, `searchAcrossServers`, and the
server-name suffixes and group-by-server affordances that exist to disambiguate
results from several servers at once.

Profile management is being reworked, and the aggregation layer should be
dismantled as part of that rather than ahead of it.

## Design consistency

The app must read as one app. Before writing any UI, find what already renders
this shape and use it — a shared widget if there is one, otherwise the shared
constant or style it is built from. Two implementations of the same thing will
drift, and every round of "why doesn't this match?" has traced back to a second
one being written rather than the first being reused.

Concretely, do not hand-write a value that a shared source already owns:

| Shape | Comes from |
|---|---|
| Sheet header | `BottomSheetHeader` |
| Sheet / menu row | `AppMenuItemTile`, `AppMenuList` |
| Shelf heading | `HubLayoutConstants.sectionHeading` |
| Shelf gaps and insets | `HubLayoutConstants` |
| Card caption type and gaps | `MediaCardGridLayout` |
| Colours, radii, durations | `MonoTokens` via `tokens(context)` |
| Pills and chips | `MetaPill`, `StatChip` |

Reuse the component, not the numbers: copying `fontSize: 18` out of
`sectionHeading` looks identical today and drifts the next time that constant
moves. If a component nearly fits, extend it (an optional parameter, a wider
constraint) rather than forking it — that is what `AppMenuItem.trailing` and
the 24dp-minimum leading are for.

Do not bend a component badly out of shape to force reuse. When something is
genuinely a different thing — the two-column track sheet, a chapter card with a
thumbnail — build it, and still take its type, spacing and colours from the
tables above so it belongs to the same family.

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

## Gates — all must pass before committing

```bash
dart format --line-length 120 lib test scripts # see Formatting below
flutter analyze lib test                       # zero warnings, not just zero errors
flutter test                                   # ~3,780 tests
python3 scripts/clean_translations.py --check --strict
dart run dart_code_linter:metrics check-unused-code lib
dart run dart_code_linter:metrics check-unused-files lib
```

Nothing enforces these in CI; they are the standard regardless.

## Formatting

**Format before every commit:**

```bash
dart format --line-length 120 lib test scripts
```

The whole tree is formatted, so this is a no-op unless you changed something —
it will only ever touch files you edited. Leave `packages/` alone; those are
vendored plugin forks that track upstream.

Do not skip it and do not format selectively. The repo previously disagreed with
the `page_width: 120` its own `analysis_options.yaml` sets, across 47 files, and
the moment a formatted file met an unformatted one the diff filled with churn
nobody could review. Keeping the tree formatted is what stops that returning.

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
