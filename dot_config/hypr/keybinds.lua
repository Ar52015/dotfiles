-- Keybind Config

return function(progs)

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(progs.terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(progs.fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(progs.menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())       -- dwindle
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(progs.nvim))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Cycle workspaces with Tab (Super+H/L/arrows are taken by movefocus)
hl.bind(mainMod .. " + Tab",         hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }))

-- Screenshot
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd([[grim -g "$(slurp -d)" - | wl-copy]]))
hl.bind("Print",               hl.dsp.exec_cmd("grim - | wl-copy"))

-- Shift Focus (Vim-Style)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Move Window (Vim-Style)
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Resize Window (Vim-Style), hold to keep resizing
hl.bind(mainMod .. " + CTRL + H", hl.dsp.window.resize({ x = -20, y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + L", hl.dsp.window.resize({ x = 20,  y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + K", hl.dsp.window.resize({ x = 0,   y = -20, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + J", hl.dsp.window.resize({ x = 0,   y = 20,  relative = true }), { repeating = true })

-- Fullscreen
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen({ mode = "fullscreen" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Pin Window
hl.bind(mainMod .. " + W", hl.dsp.window.pin())

-- Lid closing behaviour
-- Only fires on close (`switch:on:`), and does not lock inline: hypridle's
-- before_sleep_cmd locks the session under a systemd sleep inhibitor.
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("echo 0 > /tmp/hypr-notif-count; systemctl suspend"), { locked = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",      hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Color picker
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("hyprpicker -a -n"))

-- Emoji picker
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd([[BEMOJI_PICKER_CMD="wofi -p Emoji -i --show dmenu -D use_search_box=false" bemoji -t -c]]))

-- Calculator keybind
hl.bind("XF86Calculator", hl.dsp.exec_cmd("qalculate-gtk"))

-- Powerbutton behaviour
-- Hibernate normally, but suspend instead when >12G is in use (hibernating a
-- large working set is slow). Locking is left to hypridle's before_sleep_cmd.
hl.bind("XF86PowerOff", hl.dsp.exec_cmd([[
used=$(awk '/MemTotal/{t=$2} /MemAvailable/{a=$2} END {print int((t-a)/1024)}' /proc/meminfo)
echo 0 > /tmp/hypr-notif-count
if [ "$used" -gt 12000 ]; then systemctl suspend; else systemctl hibernate; fi
]]), { locked = true })

end
