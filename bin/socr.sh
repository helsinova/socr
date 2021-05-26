#! /bin/bash
# Dependencies: tesseract-ocr imagemagick gnome-screenshot xclip

SCR="$HOME/Documents/Translate/temp"
mkdir -p $(dirname $SCR)
ORIG_MICON=$(gsettings get org.gnome.desktop.interface cursor-theme)
BUSY_MICON='redglass'

TESSERACT_LANG=${TESSERACT_LANG-"swe"}
gnome-screenshot -a -f $SCR.png

gsettings set org.gnome.desktop.interface cursor-theme $BUSY_MICON

mogrify -modulate 100,0 -resize 400% $SCR.png
#should increase detection rate

tesseract $SCR.png $SCR --dpi 100 -l "$TESSERACT_LANG"
rc=$?

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

gsettings set org.gnome.desktop.interface cursor-theme $ORIG_MICON

exit $rc
