#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONFIG="${1:-release}"
APP_NAME="Vintage SampleCD Extractor.app"
APP_DIR="$ROOT/dist/$APP_NAME"
EXECUTABLE="$ROOT/.build/$CONFIG/AkaiBatchExtractor"
AKAIUTIL_SRC="${AKAIUTIL_PATH:-$HOME/akaiutil-build/akaiutil}"
ICONSET="$ROOT/icons/AppIcon.iconset"
ICON_FILE="AppIcon.icns"

cd "$ROOT"
swift build -c "$CONFIG"

if [ ! -x "$AKAIUTIL_SRC" ]; then
  echo "error: akaiutil binary not found or not executable: $AKAIUTIL_SRC" >&2
  echo "Set AKAIUTIL_PATH=/path/to/akaiutil and run again." >&2
  exit 1
fi

rm -rf "$APP_DIR"
mkdir -p "$APP_DIR/Contents/MacOS" "$APP_DIR/Contents/Resources/Tools"
mkdir -p "$APP_DIR/Contents/Resources/ThirdParty/akaiutil"
cp "$ROOT/AppResources/Info.plist" "$APP_DIR/Contents/Info.plist"
cp "$EXECUTABLE" "$APP_DIR/Contents/MacOS/AkaiBatchExtractor"
cp "$AKAIUTIL_SRC" "$APP_DIR/Contents/Resources/Tools/akaiutil"
chmod +x "$APP_DIR/Contents/MacOS/AkaiBatchExtractor" "$APP_DIR/Contents/Resources/Tools/akaiutil"

if [ -d "$ICONSET" ]; then
  iconutil -c icns "$ICONSET" -o "$APP_DIR/Contents/Resources/$ICON_FILE"
fi

AKAIUTIL_DIR="$(cd "$(dirname "$AKAIUTIL_SRC")" && pwd)"
for notice in "$AKAIUTIL_DIR/gpl-2.0.txt" "$AKAIUTIL_DIR/README.md"; do
  if [ -f "$notice" ]; then
    cp "$notice" "$APP_DIR/Contents/Resources/ThirdParty/akaiutil/"
  fi
done

if command -v codesign >/dev/null 2>&1; then
  codesign --force --deep --sign - "$APP_DIR" >/dev/null
fi

echo "Built: $APP_DIR"
