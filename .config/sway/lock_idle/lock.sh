#!/bin/sh
pidof swaylock && exit
grim /tmp/lockscreen.png && \
magick /tmp/lockscreen.png -blur 0x5 -fill black -colorize 25% /tmp/lockscreen.png && \
swaylock -f --config ~/.config/sway/lock_idle/swaylock.conf --image /tmp/lockscreen.png
