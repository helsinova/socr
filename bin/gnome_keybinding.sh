#! /bin/bash
# See actuation:
# dconf watch /

KEY='org.gnome.settings-daemon.plugins.media-keys.custom-keybinding'
SPATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

function set_keybinding() {
	local slot=$1
	local name=$2
	local cmd=$3
	local binding="${4}"
	local path="$SPATH/custom${slot}/"
	gsettings reset ${KEY}:${path} name
	gsettings reset ${KEY}:${path} command

	gsettings set ${KEY}:${path} binding ${binding}
	gsettings set ${KEY}:${path} name ${name}
	gsettings set ${KEY}:${path} command ${cmd}
}

set_keybinding $@
