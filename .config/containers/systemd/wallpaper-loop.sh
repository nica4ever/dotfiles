# ~/.config/containers/systemd/wallpaper-loop.sh
#!/bin/sh
until [ -S "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; do
  sleep 1
done
swww-daemon &
sleep 1

while true; do
  if ! pidof swaylock > /dev/null 2>&1; then
    WALL="$(find /wallpapers -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.webp' \) | shuf -n 1)"
    swww img "$WALL" \
      --transition-type fade \
      --transition-duration 3 \
      --transition-fps 60 \
      --transition-bezier .42,0,.58,1
  fi
  sleep 600
done
