#!/bin/bash

# Battery
bat_cap=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -1)
bat_status=$(cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -1)
if [ "$bat_status" = "Charging" ]; then
    bat_icon=$(printf '\U000f0084')  # 󰂄
elif [ "$bat_cap" -ge 80 ] 2>/dev/null; then
    bat_icon=$(printf '\U000f0079')  # 󰁹
elif [ "$bat_cap" -ge 60 ] 2>/dev/null; then
    bat_icon=$(printf '\U000f0082')  # 󰂂
elif [ "$bat_cap" -ge 40 ] 2>/dev/null; then
    bat_icon=$(printf '\U000f007e')  # 󰁾
elif [ "$bat_cap" -ge 20 ] 2>/dev/null; then
    bat_icon=$(printf '\U000f007a')  # 󰁺
else
    bat_icon=$(printf '\U000f0083')  # 󰂃
fi

# CPU usage
cpu=$(awk '/^cpu /{u=$2+$4; t=$2+$3+$4+$5+$6+$7+$8; printf "%.0f", u*100/t}' /proc/stat)

# RAM
ram=$(awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END{printf "%.1f / %.1f GiB", (t-a)/1048576, t/1048576}' /proc/meminfo)
ram_pct=$(awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END{printf "%.0f", (t-a)*100/t}' /proc/meminfo)

# Disk
disk=$(df -h / | awk 'NR==2{printf "%s / %s (%s)", $3, $2, $5}')

# WiFi
wifi_name=$(iwctl station wlan0 show 2>/dev/null | awk '/Connected network/{print $NF}')
[ -z "$wifi_name" ] && wifi_name=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | awk -F: '/^yes/{print $2}')
wifi_signal=$(awk 'NR==3{printf "%.0f%%", $3*100/70}' /proc/net/wireless 2>/dev/null)

# Uptime
uptime_str=$(uptime -p | sed 's/up //')

# User
user=$(whoami)

# Workspaces
workspaces=$(hyprctl workspaces -j 2>/dev/null | grep -c '"id"')

cpu_icon=$(printf '\U000f0318')    # 󰌘
ram_icon=$(printf '\U000f035b')    # 󰍛
disk_icon=$(printf '\U000f02ca')   # 󰋊
wifi_icon=$(printf '\U000f05a9')   # 󰖩
up_icon=$(printf '\U000f0150')     # 󰅐
user_icon=$(printf '\U000f0004')   # 󰀄
ws_icon=$(printf '\U000f0bdb')     # 󰯛

printf '%s  %s%%\n' "$bat_icon" "$bat_cap"
printf '%s  %s%%\n' "$cpu_icon" "$cpu"
printf '%s  %s (%s%%)\n' "$ram_icon" "$ram" "$ram_pct"
printf '%s  %s\n' "$disk_icon" "$disk"
printf '%s  %s %s\n' "$wifi_icon" "$wifi_name" "$wifi_signal"
printf '%s  %s\n' "$up_icon" "$uptime_str"
printf '%s  %s\n' "$user_icon" "$user"
printf '%s  %s\n' "$ws_icon" "$workspaces"
