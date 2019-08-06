#!/bin/bash
# Dependencies: tesseract-ocr imagemagick gnome-screenshot xclip

SCR="$HOME/Documents/Translate/temp"
mkdir -p $(dirname $SCR)

gnome-screenshot -a -f $SCR.png

mogrify -modulate 100,0 -resize 400% $SCR.png
#should increase detection rate

tesseract $SCR.png $SCR -psm 100 -l jpn
#cat $SCR.txt | awk '{printf $0}" "' | xclip -selection clipboard
cat $SCR.txt |
	tr '\n' ' ' |
	sed -e 's/  /\n/g' |
	sed -e 's/- //g' |
	awk '/[^.][:space:]*$/{
		printf("\n");
	}{
		print $0
	}' |
	xclip -selection clipboard
#you can only scan one character at a time

exit
