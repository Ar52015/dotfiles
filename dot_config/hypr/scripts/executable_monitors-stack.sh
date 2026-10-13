#!/usr/bin/env bash
# Temporary 3-monitor vertical stack:
#
#   top     DP-1      MSI MP273U 2560x1440      workspaces 8 9 10
#   middle  HDMI-A-1  MSI MP273U 3840x2160@1.5x workspaces 1 2 3
#   bottom  eDP-1     laptop 1920x1080          workspaces 4 5 6 7
#
# Runtime-only on purpose. hyprland.lua, keybinds.lua and waybar/config.jsonc are
# never modified; layout, workspace rules and binds go in through `hyprctl eval`,
# and waybar runs off a generated throwaway config under $XDG_RUNTIME_DIR.
# `reset` (or any config reload / Hyprland restart) undoes the whole thing.
#
#   monitors-stack.sh apply
#   monitors-stack.sh reset
#
# NOTE: this config is Lua, so `hyprctl keyword` is unavailable ("keyword can't
# work with non-legacy parsers. Use eval.") and `hyprctl dispatch` takes a Lua
# expression, not the legacy "dispatcher args" string. Everything below uses the
# hl.* Lua API accordingly.
#
# Monitors are matched by serial, so it works whichever connector each lands on.
set -euo pipefail

TOP_SERIAL=PB4HD66400291 # MSI MP273U, 2560x1440
MID_SERIAL=PB4HE65800464 # MSI MP273U, 3840x2160, run at 1.5x -> 2560x1440 logical

# Workspaces per screen, in stack order. First entry of each list becomes that
# monitor's `default = true` rule (see hyprwm/Hyprland#14610).
TOP_WS="8 9 10"
MID_WS="5 6 7"
BOTTOM_WS="1 2 3 4"

# Wallpaper for the two externals only; the laptop keeps its own.
MONITOR_WALLPAPER=$HOME/Wallpapers/term-bgs/third-impact-after.jpg

WAYBAR_SRC=$HOME/.config/waybar/config.jsonc
WAYBAR_STYLE=$HOME/.config/waybar/style.css
GEN_DIR=${XDG_RUNTIME_DIR:-/tmp}/monitors-stack
GEN_CONFIG=$GEN_DIR/waybar.jsonc
GEN_CYCLE=$GEN_DIR/ws-cycle.sh

# Connector name of the monitor whose description/serial contains $1.
connector_for() {
    local found
    found=$(hyprctl monitors all | awk -v pat="$1" '
        /^Monitor /    { name = $2 }
        index($0, pat) { print name; exit }')
    if [ -z "$found" ]; then
        echo "monitors-stack: no connected monitor matches '$1'" >&2
        exit 1
    fi
    printf '%s' "$found"
}

# hyprctl eval, but loud about Lua errors instead of swallowing them.
lua() {
    local out
    out=$(hyprctl eval "$1" 2>&1)
    if [ "$out" != "ok" ]; then
        echo "monitors-stack: hyprctl eval failed:" >&2
        printf '%s\n' "$out" >&2
        exit 1
    fi
}

# Emit `hl.workspace_rule` lines pinning $2.. to monitor $1.
workspace_rules() {
    local monitor=$1 first=1 ws
    shift
    for ws in "$@"; do
        if [ "$first" = 1 ]; then
            # Only the first rule per monitor carries default=true; it makes this
            # monitor the fallback home for new workspaces.
            printf 'hl.workspace_rule({ workspace = "%s", monitor = "%s", default = true })\n' "$ws" "$monitor"
            first=0
        else
            printf 'hl.workspace_rule({ workspace = "%s", monitor = "%s" })\n' "$ws" "$monitor"
        fi
    done
}

start_waybar() {
    setsid waybar "$@" >/dev/null 2>&1 &
    disown 2>/dev/null || true
}

# awww only holds a wallpaper for outputs that existed when it was set, so
# monitors plugged in later come up as a flat colour ("color: 000000" in
# `awww query`). Paint the two externals; the laptop keeps whatever it has.
sync_wallpaper() {
    if [ ! -f "$MONITOR_WALLPAPER" ]; then
        echo "monitors-stack: $MONITOR_WALLPAPER not found, leaving wallpapers alone" >&2
        return
    fi
    awww img -o "$1,$2" "$MONITOR_WALLPAPER" >/dev/null 2>&1 || true
}

apply() {
    local top mid bottom ws occurrences

    top=$(connector_for "$TOP_SERIAL")
    mid=$(connector_for "$MID_SERIAL")
    bottom=$(connector_for eDP)

    # Both MSIs are 2560x1440 *logical* (the 4K one at scale 1.5) so they stack
    # flush; the 1920-wide laptop is centred under them at x=(2560-1920)/2=320.
    lua "
        hl.monitor({ output = '$top',    mode = '2560x1440@59.951', position = '0x0',      scale = 1 })
        hl.monitor({ output = '$mid',    mode = '3840x2160@60',     position = '0x1440',   scale = 1.5 })
        hl.monitor({ output = '$bottom', mode = '1920x1080@165',    position = '320x2880', scale = 1 })"

    # After the geometry, so awww sizes the image to the final dimensions.
    sync_wallpaper "$top" "$mid"

    lua "$(
        workspace_rules "$top" $TOP_WS
        workspace_rules "$mid" $MID_WS
        workspace_rules "$bottom" $BOTTOM_WS
    )"

    # Rules only place *new* workspaces, so send the existing ones home too.
    for ws in $(hyprctl workspaces | awk '/^workspace ID/ { print $3 }'); do
        case " $TOP_WS " in *" $ws "*) lua "hl.dispatch(hl.dsp.workspace.move({ workspace = $ws, monitor = '$top' }))" ;; esac
        case " $MID_WS " in *" $ws "*) lua "hl.dispatch(hl.dsp.workspace.move({ workspace = $ws, monitor = '$mid' }))" ;; esac
        case " $BOTTOM_WS " in *" $ws "*) lua "hl.dispatch(hl.dsp.workspace.move({ workspace = $ws, monitor = '$bottom' }))" ;; esac
    done

    # Keep Super+H/J/K/L (and the SHIFT move variants) inside the current
    # monitor. Those binds are directional, and stacking the screens gave "u"/"d"
    # somewhere to fall through to; this turns that fallback off, so directional
    # focus/move stops at the monitor edge instead of spilling onto the next one.
    lua 'hl.config({ binds = { window_direction_monitor_fallback = false } })'

    # Cycle within the focused monitor. keybinds.lua uses "e+1"/"e-1", which walks
    # onto another screen once workspaces are pinned; "m+-1" stays put.
    lua '
        hl.unbind("SUPER + Tab")
        hl.unbind("SUPER + SHIFT + Tab")
        hl.unbind("SUPER + mouse_down")
        hl.unbind("SUPER + mouse_up")
        hl.bind("SUPER + Tab",         hl.dsp.focus({ workspace = "m+1" }))
        hl.bind("SUPER + SHIFT + Tab", hl.dsp.focus({ workspace = "m-1" }))
        hl.bind("SUPER + mouse_down",  hl.dsp.focus({ workspace = "m+1" }))
        hl.bind("SUPER + mouse_up",    hl.dsp.focus({ workspace = "m-1" }))'

    # Waybar: swap the blanket `"*": 10` for explicit per-output workspace lists so
    # each bar shows only its own monitor's numbers. Bail loudly if the source
    # config no longer looks the way we expect.
    occurrences=$(grep -c '"\*": 10' "$WAYBAR_SRC" || true)
    if [ "$occurrences" -ne 2 ]; then
        echo "monitors-stack: expected 2 '\"*\": 10' lines in $WAYBAR_SRC, found $occurrences." >&2
        echo "                Waybar left alone; monitors and workspaces were still applied." >&2
        exit 1
    fi

    mkdir -p "$GEN_DIR"

    # Waybar's scroll handlers shell out, and the Lua dispatch expression is a
    # quoting minefield inside JSON -- so route them through a helper. (The
    # existing "hyprctl dispatch workspace e+1" handlers are dead under a Lua
    # config; they error with exit 7.)
    cat >"$GEN_CYCLE" <<'EOF'
#!/usr/bin/env bash
# Scroll handler for the generated waybar config: cycle workspaces within the
# monitor under the cursor. $1 is "+1" or "-1".
exec hyprctl dispatch "hl.dsp.focus({ workspace = 'm$1' })"
EOF
    chmod +x "$GEN_CYCLE"

    sed -e "s|\"\\*\": 10|\"$mid\": [$(echo $MID_WS | tr ' ' ,)], \"$bottom\": [$(echo $BOTTOM_WS | tr ' ' ,)], \"$top\": [$(echo $TOP_WS | tr ' ' ,)]|g" \
        -e "s|hyprctl dispatch workspace e+1|$GEN_CYCLE +1|g" \
        -e "s|hyprctl dispatch workspace e-1|$GEN_CYCLE -1|g" \
        "$WAYBAR_SRC" >"$GEN_CONFIG"

    pkill -x waybar 2>/dev/null || true
    start_waybar -c "$GEN_CONFIG" -s "$WAYBAR_STYLE"

    printf '\nstacked top-down:\n'
    printf '  %-9s %s  ws %s\n' "$top" "(top)" "$TOP_WS"
    printf '  %-9s %s  ws %s\n' "$mid" "(mid)" "$MID_WS"
    printf '  %-9s %s  ws %s\n' "$bottom" "(bot)" "$BOTTOM_WS"
    printf 'waybar: %s\n' "$GEN_CONFIG"
}

reset() {
    # Reloading re-reads hyprland.lua from disk, dropping every runtime change in
    # one go -- monitor layout, workspace rules and binds alike.
    hyprctl reload >/dev/null
    pkill -x waybar 2>/dev/null || true
    rm -f "$GEN_CONFIG" "$GEN_CYCLE"
    start_waybar
    echo "reset: hyprland.lua reloaded, waybar back on its own config"
}

case "${1-}" in
apply) apply ;;
reset) reset ;;
*)
    echo "usage: ${0##*/} {apply|reset}" >&2
    exit 2
    ;;
esac
