#!/bin/sh
# matugen generates the palettes, pywalfox pushes them into Firefox.
# Without both, the templates in .config/matugen have nothing to drive them.

missing=""
for pkg in matugen python-pywalfox; do
	pacman -Qq "$pkg" >/dev/null 2>&1 || missing="$missing $pkg"
done

if [ -n "$missing" ]; then
	echo "installing:$missing"
	if command -v yay >/dev/null 2>&1; then
		# shellcheck disable=SC2086
		yay -S --needed $missing
	else
		echo "yay not found, install manually:$missing" >&2
		exit 1
	fi
fi

# The native host manifest ships with python-pywalfox at
# /usr/lib/mozilla/native-messaging-hosts/pywalfox.json, but the Pywalfox
# browser extension still has to be installed by hand from addons.mozilla.org.
if [ ! -e "$HOME/.mozilla/firefox" ]; then
	echo "warning: ~/.mozilla/firefox missing - pywalfox looks there, not the XDG path" >&2
fi
