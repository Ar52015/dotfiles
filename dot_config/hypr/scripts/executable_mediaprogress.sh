#!/bin/bash
cache="/tmp/hypr-last-player"

show_progress() {
    local p="$1"
    pos=$(playerctl -p "$p" position 2>/dev/null)
    len=$(playerctl -p "$p" metadata mpris:length 2>/dev/null)
    if [ -n "$pos" ] && [ -n "$len" ] && [ "$len" -gt 0 ]; then
        pos_int=${pos%.*}
        len_sec=$((len / 1000000))
        bar_width=20
        filled=$((pos_int * bar_width / len_sec))
        bar=""
        for ((i=0; i<bar_width; i++)); do
            if [ $i -lt $filled ]; then
                bar+="▓"
            else
                bar+="░"
            fi
        done
        printf "%s  %d:%02d / %d:%02d" "$bar" $((pos_int/60)) $((pos_int%60)) $((len_sec/60)) $((len_sec%60))
    fi
}

for player in $(playerctl -l 2>/dev/null); do
    if [ "$(playerctl -p "$player" status 2>/dev/null)" = "Playing" ]; then
        echo "$player" > "$cache"
        show_progress "$player"
        exit 0
    fi
done

if [ -f "$cache" ]; then
    last=$(cat "$cache")
    if [ "$(playerctl -p "$last" status 2>/dev/null)" = "Paused" ]; then
        show_progress "$last"
    fi
fi
