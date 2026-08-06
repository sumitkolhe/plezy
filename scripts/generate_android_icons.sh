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

SVG_SOURCE="assets/harbor_mark.svg"
ANDROID_RES="android/app/src/main/res"
TEMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TEMP_DIR"' EXIT

[ -f "$SVG_SOURCE" ] || { echo "Error: $SVG_SOURCE not found" >&2; exit 1; }
command -v rsvg-convert >/dev/null || {
  echo "Error: rsvg-convert not found. Install with: brew install librsvg" >&2; exit 1; }

# The mark's path data, lifted from the source so the variants below stay in
# sync with it. Everything is composed as SVG and rendered once — no raster
# post-processing, so no ImageMagick dependency.
MAINSAIL=$(grep -o 'd="M29 10[^"]*"' "$SVG_SOURCE" | head -1 | sed 's/^d="//;s/"$//')
JIB=$(grep -o 'd="M35 20[^"]*"' "$SVG_SOURCE" | head -1 | sed 's/^d="//;s/"$//')
WATERLINE=$(grep -o 'd="M10 52[^"]*"' "$SVG_SOURCE" | head -1 | sed 's/^d="//;s/"$//')

[ -n "$MAINSAIL" ] && [ -n "$JIB" ] && [ -n "$WATERLINE" ] || {
  echo "Error: could not lift the sail paths out of $SVG_SOURCE" >&2; exit 1; }

# Legacy launcher: the brand sheet's app icon — white sail on Harbor blue.
cat > "$TEMP_DIR/brand.svg" <<SVG
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" width="64" height="64">
  <rect width="64" height="64" rx="14" fill="#2ca8e0"/>
  <g transform="translate(9.6 9.6) scale(0.7)">
    <path fill="#ffffff" d="$MAINSAIL"/>
    <path fill="#0a0a0b" d="$JIB"/>
    <path stroke="#0a0a0b" stroke-width="4.5" stroke-linecap="round" d="$WATERLINE"/>
  </g>
</svg>
SVG

# Notification icons are a silhouette the system tints, so the jib is dropped:
# at 24dp the two sails merge into a blob.
cat > "$TEMP_DIR/white.svg" <<SVG
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 64 64" width="64" height="64">
  <path fill="#ffffff" d="$MAINSAIL"/>
  <path stroke="#ffffff" stroke-width="5" stroke-linecap="round" d="$WATERLINE"/>
</svg>
SVG

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
      <stop offset="0" stop-color="#12181c"/><stop offset="1" stop-color="#0a0a0b"/>
    </linearGradient>
  </defs>
  <rect width="320" height="180" fill="url(#bg)"/>
  <g transform="translate(115 25) scale(1.72)">
    <path fill="#ffffff" d="$MAINSAIL"/>
    <path fill="#2ca8e0" d="$JIB"/>
    <path stroke="#ffffff" stroke-width="4.5" stroke-linecap="round" d="$WATERLINE"/>
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
