#!/bin/bash
countfile="/tmp/hypr-notif-count"
count=$(cat "$countfile" 2>/dev/null)
if [ -n "$count" ] && [ "$count" -gt 0 ]; then
    icon=$(printf '\U000f009a')  # 󰂚
    printf '%s  %s notification' "$icon" "$count"
    [ "$count" -gt 1 ] && printf 's'
    echo
fi
