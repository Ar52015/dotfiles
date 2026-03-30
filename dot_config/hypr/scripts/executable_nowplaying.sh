#!/bin/bash
cache="/tmp/hypr-last-player"

show_info() {
    local p="$1"
    case "$p" in
        spotify*)   icon=$(printf '\uf1bc') ;;
        firefox*)   icon=$(printf '\ue745') ;;
        vlc*)       icon=$(printf '\U000f057c') ;;
        mpv*)       icon=$(printf '\uf008') ;;
        *)          icon=$(printf '\uf001') ;;
    esac
    info=$(playerctl -p "$p" metadata --format '{{artist}} — {{title}}' 2>/dev/null)
    [ -n "$info" ] && printf '%s %s\n' "$icon" "$info"
}

# prefer the currently playing player
for player in $(playerctl -l 2>/dev/null); do
    if [ "$(playerctl -p "$player" status 2>/dev/null)" = "Playing" ]; then
        echo "$player" > "$cache"
        show_info "$player"
        exit 0
    fi
done

# nothing playing — show last known if paused
if [ -f "$cache" ]; then
    last=$(cat "$cache")
    if [ "$(playerctl -p "$last" status 2>/dev/null)" = "Paused" ]; then
        show_info "$last"
    fi
fi
