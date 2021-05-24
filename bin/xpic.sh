#!/bin/bash
# Dependencies: xclip

xclip -selection clipboard -target image/png -i "$1"

exit $?
