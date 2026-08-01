#!/usr/bin/env bash

# Android raster icon generator.
#
# The adaptive launcher icon (mipmap-anydpi-v26) and its monochrome layer are
# hand-maintained VectorDrawables in res/drawable — this script only produces
# the bitmaps Android still requires:
#   • mipmap-*/ic_launcher.png        legacy launcher, pre-API-26 (minSdk is 25)
#   • drawable-*/ic_stat_notification.png  white silhouette; notification small
#                                     icons stay bitmaps because VectorDrawable
#                                     in RemoteViews is unreliable on older OEMs
#   • drawable-*/tv_banner.png        Android TV home-screen banner
#
# Usage: ./scripts/generate_android_icons.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

SVG_SOURCE="assets/harbor.svg"
ANDROID_RES="android/app/src/main/res"
TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

[ -f "$SVG_SOURCE" ] || { echo "Error: $SVG_SOURCE not found" >&2; exit 1; }
command -v rsvg-convert >/dev/null || {
  echo "Error: rsvg-convert not found. Install with: brew install librsvg" >&2; exit 1; }

# The mark's own path data, lifted from the source so the variants below stay
# in sync with it. Everything is composed as SVG and rendered once — no raster
# post-processing, so no ImageMagick dependency.
TOWER=$(grep -o 'd="M7\.746[^"]*"' "$SVG_SOURCE" | head -1 | sed 's/^d="//;s/"$//')
BEAMS=$(grep -o 'd="M3\.293[^"]*"' "$SVG_SOURCE" | head -1 | sed 's/^d="//;s/"$//')

emit_svg() {
  # $1 tower fill, $2 beams fill, $3 optional <defs>
  cat <<SVG
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
${3:-}
  <path fill="$1" fill-rule="evenodd" clip-rule="evenodd" d="$TOWER"/>
  <path fill="$2" d="$BEAMS"/>
</svg>
SVG
}

BRAND_DEFS='  <defs><linearGradient id="g" x1="0" y1="1" x2="1" y2="0">
    <stop offset="0" stop-color="#AB543A"/><stop offset="1" stop-color="#FF7E57"/>
  </linearGradient></defs>'

emit_svg 'url(#g)' 'url(#g)' "$BRAND_DEFS" > "$TEMP_DIR/brand.svg"
emit_svg '#ffffff' '#ffffff' > "$TEMP_DIR/white.svg"

echo "Generating Android raster icons from $SVG_SOURCE"

echo "  legacy launcher (mipmap-*/ic_launcher.png)"
for pair in mdpi:48 hdpi:72 xhdpi:96 xxhdpi:144 xxxhdpi:192; do
  density="${pair%%:*}"; size="${pair##*:}"
  mkdir -p "$ANDROID_RES/mipmap-$density"
  rsvg-convert -w "$size" -h "$size" "$TEMP_DIR/brand.svg" \
    -o "$ANDROID_RES/mipmap-$density/ic_launcher.png"
done

echo "  notification (drawable-*/ic_stat_notification.png)"
for pair in mdpi:24 hdpi:36 xhdpi:48 xxhdpi:72 xxxhdpi:96; do
  density="${pair%%:*}"; size="${pair##*:}"
  mkdir -p "$ANDROID_RES/drawable-$density"
  rsvg-convert -w "$size" -h "$size" "$TEMP_DIR/white.svg" \
    -o "$ANDROID_RES/drawable-$density/ic_stat_notification.png"
done

echo "  TV banner (drawable-*/tv_banner.png)"
# 16:9 with the mark centred, on the same dark gradient the banner used before.
cat > "$TEMP_DIR/banner.svg" <<SVG
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 320 180" width="320" height="180">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0" stop-color="#191919"/><stop offset="1" stop-color="#000000"/>
    </linearGradient>
    <linearGradient id="g" x1="0" y1="1" x2="1" y2="0">
      <stop offset="0" stop-color="#AB543A"/><stop offset="1" stop-color="#FF7E57"/>
    </linearGradient>
  </defs>
  <rect width="320" height="180" fill="url(#bg)"/>
  <g transform="translate(103.7 35.8) scale(4.7)">
    <path fill="url(#g)" fill-rule="evenodd" clip-rule="evenodd" d="$TOWER"/>
    <path fill="url(#g)" d="$BEAMS"/>
  </g>
</svg>
SVG
for pair in xhdpi:320x180 xxhdpi:480x270 xxxhdpi:640x360; do
  density="${pair%%:*}"; dims="${pair##*:}"
  mkdir -p "$ANDROID_RES/drawable-$density"
  rsvg-convert -w "${dims%%x*}" -h "${dims##*x}" "$TEMP_DIR/banner.svg" \
    -o "$ANDROID_RES/drawable-$density/tv_banner.png"
done

echo "Done. Rebuild to apply: flutter clean && flutter build apk"
