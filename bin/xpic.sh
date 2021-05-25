#!/bin/bash
# Dependencies: scrot xclip

function _xpic_one() {
    xclip -selection clipboard -target image/png -i "$1"
}
export -f _xpic_one

if [ $# -gt 0 ]; then
    xclip -selection clipboard -target image/png -i "$1"
else
    scrot -s -e 'mv $f /tmp/ && _xpic_one /tmp/$f'
fi
