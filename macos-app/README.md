# Vintage SampleCD Extractor

macOS GUI wrapper for extracting old Akai sampler-format raw images to WAV.

## Features

- Drag one or more `.iso`, `.img`, or `.bin` files into the app.
- Batch extracts each image with bundled `akaiutil` in read-only mode.
- Writes output to `<image name>-WAV` beside the image by default, or to a chosen output folder.
- Fixes extracted directory permissions with `chmod -R u+rwX` so Finder can open the folders.
- Lets the user keep Akai `-L` / `-R` mono WAV pairs, or merge matching pairs into one stereo WAV.
- Stereo merging is implemented inside the app for 16-bit mono PCM WAV files, so users do not need `ffmpeg` or `ffprobe`.
- Builds the app icon from `icons/AppIcon.iconset`.

## Build

The app bundles the `akaiutil` binary, so build that first (from the repo root),
then build and package the app:

```bash
# 1) compile the bundled akaiutil backend (from repo root)
./vse build

# 2) build + package the .app
cd macos-app
AKAIUTIL_PATH=../third_party/akaiutil/akaiutil ./Scripts/package-app.sh
```

The ad-hoc-signed bundle is written to `macos-app/dist/Vintage SampleCD Extractor.app`.
(If `AKAIUTIL_PATH` is unset, the script falls back to `~/akaiutil-build/akaiutil`.)

Requires the Swift toolchain (Xcode / Command Line Tools) and macOS 13+.

## Third-party tool

This app bundles `akaiutil`, an open-source Akai disk utility by Klaus Michael
Indlekofer (GPL-2.0). Its license and notices are placed in
`Contents/Resources/ThirdParty/akaiutil/`, and the **corresponding source** is
included in this repository under [`../third_party/akaiutil`](../third_party/akaiutil),
satisfying the GPL-2.0 source-availability requirement for the bundled binary.
