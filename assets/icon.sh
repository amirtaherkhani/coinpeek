# run from repo root
SRC="icon-1024.png"
DEST="CoinPeek/Assets.xcassets/AppIcon.appiconset"
mkdir -p "$DEST"

for px in 16 32 64 128 256 512 1024; do
  magick "$SRC" -resize ${px}x${px} "$DEST/icon_${px}.png"
done

cat > "$DEST/Contents.json" <<'JSON'
{
  "images" : [
    { "size" : "16x16",   "idiom" : "mac", "scale" : "1x", "filename" : "icon_16.png" },
    { "size" : "16x16",   "idiom" : "mac", "scale" : "2x", "filename" : "icon_32.png" },
    { "size" : "32x32",   "idiom" : "mac", "scale" : "1x", "filename" : "icon_32.png" },
    { "size" : "32x32",   "idiom" : "mac", "scale" : "2x", "filename" : "icon_64.png" },
    { "size" : "128x128", "idiom" : "mac", "scale" : "1x", "filename" : "icon_128.png" },
    { "size" : "128x128", "idiom" : "mac", "scale" : "2x", "filename" : "icon_256.png" },
    { "size" : "256x256", "idiom" : "mac", "scale" : "1x", "filename" : "icon_256.png" },
    { "size" : "256x256", "idiom" : "mac", "scale" : "2x", "filename" : "icon_512.png" },
    { "size" : "512x512", "idiom" : "mac", "scale" : "1x", "filename" : "icon_512.png" },
    { "size" : "512x512", "idiom" : "mac", "scale" : "2x", "filename" : "icon_1024.png" }
  ],
  "info" : { "version" : 1, "author" : "xcode" }
}
JSON

echo "App icon images written to $DEST"
