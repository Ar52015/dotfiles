#!/bin/bash
action="$1"
cache="/tmp/hypr-last-player"

# try the currently playing player first
for player in $(playerctl -l 2>/dev/null); do
    if [ "$(playerctl -p "$player" status 2>/dev/null)" = "Playing" ]; then
        echo "$player" > "$cache"
        playerctl -p "$player" "$action"
        exit 0
    fi
done

# nothing playing — use the last known player
if [ -f "$cache" ]; then
    last=$(cat "$cache")
    playerctl -p "$last" "$action" 2>/dev/null
fi
