# Vintage SampleCD Extractor — App Icon

**Chosen direction: A · Classic Faceplate** — 8-bit Akai S1000 sampler on the classic
beige-grey faceplate, with a green VFD waveform, red AKAI wordmark, and an optical disc
rising from the center drive bay. Smooth macOS squircle, fine pixel-art interior.

## Files
- `icon-pixels.js` — the pixel-art rendering engine (vector → nearest-neighbour pixel grid → squircle).
- `Vintage SampleCD Extractor Icon.html` — presentation of the final icon.
- `Icon Studies.html` — the original A/B/C exploration.
- `icons/icon_1024.png` — master 1024×1024 PNG.
- `icons/AppIcon.iconset/` — full macOS icon set (16 → 1024, incl. @2x).

## Build the .icns (macOS)
```sh
cd icons
iconutil -c icns AppIcon.iconset      # → AppIcon.icns
```
Drop `AppIcon.icns` into your Xcode project, or set it as the bundle icon in
`Info.plist` (`CFBundleIconFile`).
