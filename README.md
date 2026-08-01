<h1>
  <img src="assets/harbor.svg" alt="" height="24" style="vertical-align: middle;" />
  Harbor
</h1>

A Jellyfin client for Android, built with Flutter.

A personal fork of [Plezy](https://github.com/edde746/plezy), narrowed to one
backend and one platform: the Plex client, the desktop and tvOS targets, Live
TV and Watch Together have all been removed.

## Features

### Browse & Discover
- Libraries, collections, and playlists
- Discover hub — Continue Watching, Next Up, trending, and recommendations
- Cross-server search
- Filtering, sorting, and alphabetical jump navigation
- Extras — trailers, deleted scenes, behind-the-scenes

### Playback
- Wide codec support (HEVC, AV1, VP9, and more)
- HDR and Dolby Vision
- Full ASS/SSA subtitles with customizable styling
- Audio & subtitle choices remembered per title
- Progress sync and resume
- Auto-play next episode with skip intro / skip credits
- Chapter navigation with thumbnail scrub previews
- Playback speed, audio sync offset, sleep timer
- Ambient lighting and GLSL shader presets
- Picture-in-Picture
- Refresh-rate matching
- External player launch (VLC, MX Player, mpv, Just Player)

### Downloads & Offline
- Download media for offline viewing
- Background queue with pause / resume
- Sync rules for automatic downloads
- Offline browsing with watch state sync-back on reconnect

### Integrations
- Trakt, MyAnimeList, AniList, and Simkl tracking & rating
- Jellyseerr / Overseerr requests
- Watch Next row

### Platform & Customization
- Phone, tablet and Android TV — full D-pad and gamepad support
- Metadata and artwork editing
- Settings import/export
- Localized in English plus 21 translations

## Building from Source

### Prerequisites
- Flutter SDK 3.38.4+
- A Jellyfin server with user credentials

### Setup

```bash
flutter pub get
scripts/codegen.sh
flutter run
```

### Code Generation

After modifying model classes or other generated sources:

```bash
scripts/codegen.sh
```

After modifying translations:

```bash
dart run slang
```

### Icons

The adaptive launcher icon and its monochrome layer are hand-maintained
VectorDrawables in `android/app/src/main/res/drawable`. The bitmaps Android
still needs — legacy launcher, notification, TV banner — regenerate from
`assets/harbor.svg`:

```bash
scripts/generate_android_icons.sh   # needs: brew install librsvg
```

### Local Checks

```bash
scripts/ci_checks.sh
```

To install the same pre-commit checks locally:

```bash
scripts/setup_hooks.sh
```

## License

Harbor inherits Plezy's [GPL-3.0](LICENSE) license.

## Acknowledgments

- Forked from [Plezy](https://github.com/edde746/plezy) by edde746
- Built with [Flutter](https://flutter.dev)
- Supports [Jellyfin](https://jellyfin.org)
- Playback powered by [mpv](https://mpv.io), Android [ExoPlayer](https://developer.android.com/media/media3/exoplayer), [libass-android](https://github.com/peerless2012/libass-android), and [libmpv-android](https://github.com/jarnedemeulemeester/libmpv-android)
- Lighthouse mark from [Mingcute](https://github.com/Richard9394/MingCute) (MIT)
