#!/bin/bash
# Builds database and picks next batch

WALLDIR=~/Pictures/Wallpapers
DB=~/.config/sway/wallpaper.db
STATE=~/.config/sway/wallpaper.state
CURRENT=~/.config/sway/wallpaper.current

mkdir -p "$(dirname "$DB")"

# Auto-tag
while IFS= read -r dir; do
    tag=$(basename "$dir" | tr '[:upper:]' '[:lower:]' | tr ' ' '_')
    ls "$dir"/batch_* &>/dev/null || touch "$dir/$tag"
done < <(find "$WALLDIR" -mindepth 1 -maxdepth 1 -type d -iname 'Batch*')

# Get all batch dirs
mapfile -t BATCHES < <(find "$WALLDIR" -mindepth 1 -maxdepth 1 -name 'batch_*' -printf '%h\n' | sort -u)
[[ ${#BATCHES[@]} -eq 0 ]] && exit 1

# Read previous batch
PREV=""
[[ -f "$STATE" ]] && PREV=$(head -1 "$STATE")

# Pick next batch: different from previous if possible
if [[ ${#BATCHES[@]} -gt 1 ]]; then
    CANDIDATES=()
    for b in "${BATCHES[@]}"; do
        [[ "$b" != "$PREV" ]] && CANDIDATES+=("$b")
    done
    CHOSEN="${CANDIDATES[RANDOM % ${#CANDIDATES[@]}]}"
else
    CHOSEN="${BATCHES[0]}"
fi

# Save chosen batch
echo "$CHOSEN" > "$STATE"

# Write shuffled playlist for this batch
find "$CHOSEN" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' -o -iname '*.bmp' \) | shuf > "$CURRENT"
