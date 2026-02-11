# ~/.config/containers/systemd/wallpaper-loop.sh
#!/bin/sh
until [ -S "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; do
  sleep 1
done
swww-daemon &
sleep 1

while true; do
  swww img "$(find /wallpapers -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.webp' \) | shuf -n 1)" \
  --transition-type fade \
  --transition-duration 3 \
  --transition-fps 60 \
  --transition-bezier .42,0,.58,1
  sleep 600
done
