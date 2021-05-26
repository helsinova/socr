# !/bin/bash
# Dependencies: scrot tesseract-ocr imagemagick Bash (not Dash)

[ -z $BASH_VERSION ] && echo "This scrip runs only under Bash" && exit 1 >&2
# Perhaps run dpkg-reconfigure dash ?

function _xocr_one() {
    local TESSERACT_LANG=${TESSERACT_LANG-"swe"}

    local _fn_prefix="$HOME/Documents/Translate/temp"
    mkdir -p $(dirname $_fn_prefix)

    #should increase detection rate
    mogrify -modulate 100,0 -resize 400% "$1"

    tesseract "$1" $_fn_prefix --dpi 100 -l "$TESSERACT_LANG"

    #you can only scan one character at a time
    cat $_fn_prefix.txt | xclip -selection clipboard
}
export -f _xocr_one


if [ $# -gt 0 ]; then
    _xocr_one $1
else
    scrot -s -e 'mv $f /tmp/ && _xocr_one /tmp/$f'
fi
