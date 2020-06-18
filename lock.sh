#!/bin/sh


FAKE_BACKGROUND="/home/sgilgen/Pictures/screenshot_2.png"

# Turn dpms off
xset dpms 0 0 0

# Lock the screen
i3lock -n -f -e -i $FAKE_BACKGROUND

# # Clear left-overs
# rm -f $FAKE_BACKGROUND $TMP_BACKGROUND
