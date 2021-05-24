#!/bin/bash
# Dependencies: tesseract-ocr imagemagick

SCR="$HOME/Documents/Translate/temp"
mkdir -p $(dirname $SCR)

#should increase detection rate
mogrify -modulate 100,0 -resize 400% "$1"

tesseract "$1" $SCR -psm 100 -l jpn

#you can only scan one character at a time
cat $SCR.txt | xclip -selection clipboard

exit
