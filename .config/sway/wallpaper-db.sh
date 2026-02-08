#!/bin/bash
# ~/.config/sway/wallpaper-db.sh

WALLDIR=~/Pictures/Wallpapers
DB=~/.config/sway/wallpaper.db

mkdir -p "$(dirname "$DB")"
> "$DB"

# Auto-tag Batch dirs missing batch_* files
while IFS= read -r dir; do
    basename=$(basename "$dir")
    tag=$(echo "$basename" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
    if ! ls "$dir"/batch_* &>/dev/null; then
        touch "$dir/$tag"
    fi
done < <(find "$WALLDIR" -mindepth 1 -maxdepth 1 -type d -iname 'Batch*')

# Build database: BATCH_DIR|image_path per line
while IFS= read -r dir; do
    find "$dir" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.bmp' \) -print | while read -r img; do
        echo "$dir|$img" >> "$DB"
    done
done < <(find "$WALLDIR" -mindepth 1 -maxdepth 1 -name 'batch_*' -printf '%h\n' | sort -u)
