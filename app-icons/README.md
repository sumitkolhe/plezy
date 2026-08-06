# Store assets

Not the app icon. The launcher icon is a vector —
`android/app/src/main/res/drawable/ic_launcher_foreground.xml` and its
monochrome twin — so there are no PNG icon sets to keep in step here.

- `play-store-512.png` — the Play Console listing icon. 512×512, 32-bit, opaque,
  which is what the Console requires.
- `play-tv-banner-1280x720.png` — the Android TV listing banner, required
  because the manifest declares `LEANBACK_LAUNCHER`. Not the same asset as the
  in-app `drawable-*/tv_banner.png`, which is the launcher tile.
- `master-1024.png` — the source the 512 was cut from, for whatever a future
  listing needs.

Still missing for a listing: the 1024×500 feature graphic, phone screenshots,
and 1920×1080 TV screenshots.
