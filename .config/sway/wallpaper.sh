#!/bin/bash
# ~/.config/sway/wallpaper.sh

INTERVAL=300
DB=~/.config/sway/wallpaper.db

pkill -f "wallpaper\.sh" -o 2>/dev/null

[[ ! -f "$DB" ]] && exit 1

# Get all unique batch dirs from db
mapfile -t BATCHES < <(cut -d'|' -f1 "$DB" | sort -u)
[[ ${#BATCHES[@]} -eq 0 ]] && exit 1

# Pick random batch
CHOSEN="${BATCHES[RANDOM % ${#BATCHES[@]}]}"

# Pull images for that batch — already indexed, instant
mapfile -t IMGS < <(grep "^${CHOSEN}|" "$DB" | cut -d'|' -f2 | shuf)
[[ ${#IMGS[@]} -eq 0 ]] && exit 1

OLD_PID=$(pgrep -o swaybg)

i=0
while true; do
    swaybg -i "${IMGS[$i]}" -m fill &
    NEW_PID=$!
    sleep 1
    [[ -n "$OLD_PID" ]] && kill "$OLD_PID" 2>/dev/null
    OLD_PID=$NEW_PID
    sleep "$INTERVAL"
    i=$(( (i + 1) % ${#IMGS[@]} ))
done
