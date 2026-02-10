# ~/.config/containers/systemd/wallpaper-loop.sh
#!/bin/sh
#!/bin/sh
until [ -S "$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY" ]; do
  sleep 1
done
swww-daemon &
sleep 1
while true; do
  swww img "$(find /wallpapers -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.jpeg' -o -name '*.webp' \) | shuf -n 1)" \
    --transition-type fade \
    --transition-duration 2 \
    --transition-fps 60
  sleep 600
done
