#!/bin/bash
cache="/tmp/hypr-last-player"

show_icon() {
    case "$1" in
        prev)   printf '\U000f04ae' ;;
        toggle) printf '\U000f040e' ;;
        next)   printf '\U000f04ad' ;;
    esac
}

for player in $(playerctl -l 2>/dev/null); do
    if [ "$(playerctl -p "$player" status 2>/dev/null)" = "Playing" ]; then
        echo "$player" > "$cache"
        show_icon "$1"
        exit 0
    fi
done

if [ -f "$cache" ]; then
    last=$(cat "$cache")
    if [ "$(playerctl -p "$last" status 2>/dev/null)" = "Paused" ]; then
        show_icon "$1"
    fi
fi
