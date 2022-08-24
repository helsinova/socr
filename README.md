#socr - clipart 2 ocr

Screen-to-clipboard utilities

## X based (newer)

These scripts are less dependant of which window system you're running than
the older Gnome based. I.e. they should work with i3/fvwm etc.

* xocr - takes a cut of screen, OCR:s it and place final text into clipboard
* xpic - takes a cut of screen directly into clipboard

## Gnome based (older)
These scripts **may** work on you system if you have gnome installed but running
another window system. If you don't run Gnome, consider using the newer scripts
(see above) instead.

* socr - takes a cut of screen, OCR:s it and place final text into clipboard
* spic - takes a cut of screen directly into clipboard

## Trace actuation:

```bash
dconf watch /
```

## Caveats

Adding a shortcut to a slot before it has once been occupied using
gnome-config does not work

Utilizing `dconf watch /` reveals that the following is missing when running
`gnome-keybinding`:

```
/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings
  ['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/',
  '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/']
```


## Inspiration

* [StackExchange thread](https://askubuntu.com/questions/280475/how-can-instantaneously-extract-text-from-a-screen-area-using-ocr-tools)

* How can I change the mouse pointer theme from the command line?
 A DBase based solution using gsettings and dconf:
  [ask ubunty](https://askubuntu.com/questions/933073/how-can-i-change-the-mouse-pointer-theme-from-the-command-line)

* Arch Wiki about cursor themes and the XTEST protocol:
[](https://wiki.archlinux.org/index.php/Cursor_themes)
