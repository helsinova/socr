#!/bin/bash
# Dependencies: scrot tesseract-ocr imagemagick

function _xocr_one() {
    echo "$1"
    local _fn_prefix="$HOME/Documents/Translate/temp"
    mkdir -p $(dirname $_fn_prefix)

    #should increase detection rate
    mogrify -modulate 100,0 -resize 400% "$1"

    tesseract "$1" $_fn_prefix -psm 100 -l jpn

    #you can only scan one character at a time
    cat $_fn_prefix.txt | xclip -selection clipboard
}
export -f _xocr_one


if [ $# -gt 0 ]; then
    _xocr_one $1
else
    scrot -s -e 'mv $f /tmp/ && _xocr_one /tmp/$f'
fi
