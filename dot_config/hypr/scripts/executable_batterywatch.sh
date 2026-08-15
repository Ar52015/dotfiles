#!/bin/bash
bat="/sys/class/power_supply/BAT1"
thresholds=(5 2)
declare -A warned

while true; do
    capacity=$(< "$bat/capacity")
    status=$(< "$bat/status")

    if [ "$status" = "Discharging" ]; then
        for t in "${thresholds[@]}"; do
            if [ "$capacity" -le "$t" ] && [ -z "${warned[$t]}" ]; then
                warned[$t]=1
                notify-send -u critical -i battery-caution \
                    -h string:x-canonical-private-synchronous:battery \
                    "Battery at ${capacity}%" "Plug in now."
            fi
        done
    else
        warned=()
    fi

    sleep 30
done
