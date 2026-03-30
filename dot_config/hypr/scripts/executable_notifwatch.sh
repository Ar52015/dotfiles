#!/bin/bash
countfile="/tmp/hypr-notif-count"
echo 0 > "$countfile"

dbus-monitor "interface='org.freedesktop.Notifications',member='Notify'" 2>/dev/null | while read -r line; do
    if echo "$line" | grep -q "member=Notify"; then
        count=$(($(cat "$countfile") + 1))
        echo "$count" > "$countfile"
    fi
done
