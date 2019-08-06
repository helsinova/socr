#! /bin/bash

CUSTOM='custom0'
BINDING='<Shift><Alt>o'
NAME='socr'
CMD='socr'

KEY='org.gnome.settings-daemon.plugins.media-keys.custom-keybinding'
SPATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/${CUSTOM}/"

gsettings reset ${KEY}:${SPATH} name
gsettings reset ${KEY}:${SPATH} command

gsettings set ${KEY}:${SPATH} name ${NAME}
gsettings set ${KEY}:${SPATH} command ${CMD}
gsettings set ${KEY}:${SPATH} binding ${BINDING}

