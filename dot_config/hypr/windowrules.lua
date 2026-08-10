--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/ for more
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/ for workspace rules

-- Example windowrules that are useful

hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Float pavucontrol
hl.window_rule({
    name  = "float-pavucontrol",
    match = { class = "^(pavucontrol)$" },

    float = true,
    size  = { 800, 500 },
})

-- Float Calculator
hl.window_rule({
    name  = "float-calculator",
    match = { class = "^(qalculate-gtk)$" },

    float = true,
})

-- Float browser auth/popup windows
hl.window_rule({
    name  = "float-browser-popus",
    match = { title = "^(Extension:.*)$" },

    float = true,
})

hl.window_rule({
    name  = "float-browser-auth",
    match = { title = "^(Sign in|Log in|Login|Bitwarden|Authorization|Authenticate)" },

    float = true,
})
