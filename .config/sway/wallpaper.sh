#!/bin/bash
# Reads playlist, rotates, requests new batch when done

INTERVAL=300
CURRENT=~/.config/sway/wallpaper.current
DBSCRIPT=~/.config/sway/wallpaper-db.sh

pkill -f "wallpaper\.sh" -o 2>/dev/null

# Build first playlist if none exists
[[ ! -f "$CURRENT" ]] && "$DBSCRIPT"

OLD_PID=$(pgrep -o swaybg)

while true; do
    # Read playlist
    mapfile -t IMGS < "$CURRENT"

    # Empty or missing — rebuild
    if [[ ${#IMGS[@]} -eq 0 ]]; then
        "$DBSCRIPT"
        continue
    fi

    for img in "${IMGS[@]}"; do
        [[ ! -f "$img" ]] && continue
        swaybg -i "$img" -m fill &
        NEW_PID=$!
        sleep 1
        [[ -n "$OLD_PID" ]] && kill "$OLD_PID" 2>/dev/null
        OLD_PID=$NEW_PID
        sleep "$INTERVAL"
    done

    # Batch exhausted — pick new batch
    "$DBSCRIPT"
done
