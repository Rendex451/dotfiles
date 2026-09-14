-- ~/.config/hypr/hyprland.lua
-- Converted from the old hyprland.conf (hyprlang) syntax to Lua.
-- Hyprland switched the config format to Lua in 0.55; you're on 0.56.2, so this
-- is the format that will actually load — the old general{}/bind=.../windowrule=...
-- syntax is no longer parsed at all.
--
-- ONE THING STILL NEEDS YOUR INPUT, marked with "TODO" below:
--   SUPER+P was bound twice in your old config (once to `pin`, once to
--   `exec, hyprpicker -an`) — in hyprlang the later bind wins, so I kept
--   that behavior (hyprpicker fires, pin is dead code). Pick a different
--   key for one of them if that's not what you intended.
--
-- colors.conf is now colors.lua (put it next to this file, in
-- ~/.config/hypr/colors.lua) and is pulled in via require() below, the way
-- the upstream example config recommends for splitting config files.
local colors = require("colors")

------------------
---- MONITORS ----
------------------
local MON1 = "eDP-1"
local MON2 = "HDMI-A-2"

hl.monitor({ output = MON1, mode = "1920x1080@60", position = "0x1440", scale = 1 })
hl.monitor({ output = MON2, mode = "2560x1440@60", position = "0x0",    scale = 1 })

---------------------
---- MY PROGRAMS ----
---------------------
local fileManager = "thunar"
local mainMod      = "SUPER"
local menu         = "rofi -show drun"
local terminal     = "alacritty"

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("nm-applet")
    hl.exec_cmd("awww img ~/.config/hypr/current_background.jpg")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        allow_tearing = false,
        border_size = 5,
        col = {
            active_border   = colors.border_active,
            inactive_border = colors.border_inactive,
        },
        gaps_in = 0,
        gaps_out = 0,
        layout = "dwindle",
        resize_on_border = true,
    },

    -- Disable notifications after update
    ecosystem = {
        no_update_news = true,
    },

    decoration = {
        rounding = 14, -- Скругление окон

        blur = {
            enabled = false, -- Выключаем размытие для минимализма
        },

        -- Легкая тень для объема
        shadow = {
            enabled = true,
            range = 10,
            render_power = 3,
            color = 0x80000000, -- rgba(00000080)
        },

        active_opacity = 1.0,
        inactive_opacity = 1.0,
    },

    animations = {
        enabled = true,
    },

    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
    },
})

-- Быстрая кривая ускорения
hl.curve("rapid", { type = "bezier", points = { {0.05, 0.7}, {0.1, 1} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 3, bezier = "rapid",   style = "slide" }) -- Окна вылетают быстро
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "rapid",   style = "slide" })
hl.animation({ leaf = "border",     enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "fade",       enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "rapid",   style = "slide" }) -- Переключение воркспейсов мгновенное

---------------------
---- GESTURES ----
---------------------

-- 3 finger swipe gesture for workspace switching
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.config({
    gestures = {
        workspace_swipe_forever = true,
        workspace_swipe_invert  = true,
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout  = "us,ru",
        kb_options = "grp:win_space_toggle",

        -- touchpad
        touchpad = {
            disable_while_typing = false,
            natural_scroll = true,
            scroll_factor = 1,
            tap_and_drag = true,
        },
    },
})

-----------------
---- LAYOUTS ----
-----------------

-- DWM-like window layout
hl.config({
    master = {
        mfact = 0.5,
        new_on_top = true,
        new_status = "slave",
    },
})

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

---------------------------
---- WORKSPACE GAPS ----
---------------------------
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })

---------------------
---- KEYBINDINGS ----
---------------------
-- Main keybinds
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W",      hl.dsp.window.close())
hl.bind(mainMod .. " + R",      hl.dsp.exit())
hl.bind(mainMod .. " + N",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + F",      hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + D",      hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P",      hl.dsp.window.pin({ action = "toggle" })) -- see TODO at top: overridden below
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd("pkill -SIGUSR2 waybar"))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + H",      hl.dsp.exec_cmd("wlogout"))
hl.bind(mainMod .. " + P",      hl.dsp.exec_cmd("hyprpicker -an")) -- wins over the pin bind above (same key)
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd("swaync-client -t"))
hl.bind("Print",                hl.dsp.exec_cmd("grimblast --notify --freeze copysave area"))

-- Program binds
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.exec_cmd("code"))
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("Telegram"))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("google-chrome-stable"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("env QT_QPA_PLATFORM=xcb AmneziaVPN"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.exec_cmd("zeditor"))

-- Move focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Swap window
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))

-- Resize window                                     X    Y
hl.bind(mainMod .. " + CTRL + left",  hl.dsp.window.resize({ x = -60, y = 0,   relative = true }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.resize({ x = 60,  y = 0,   relative = true }))
hl.bind(mainMod .. " + CTRL + up",    hl.dsp.window.resize({ x = 0,   y = -60, relative = true }))
hl.bind(mainMod .. " + CTRL + down",  hl.dsp.window.resize({ x = 0,   y = 60,  relative = true }))

-- Switch to workspace / move window to workspace (silent)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + Prior", hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + Next",  hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + SHIFT + Prior", hl.dsp.window.move({ workspace = "r-1" }))
hl.bind(mainMod .. " + SHIFT + Next",  hl.dsp.window.move({ workspace = "r+1" }))

-- Magic workspace
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Volume management
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { locked = true, repeating = true })

-- Brightness management
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl s 10%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl s 10%-"), { locked = true, repeating = true })

-- Multimedia binds
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- Move with LMB, resize with RMB
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("XDG_SCREENSHOTS_DIR", "$HOME/screens")

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- Floating by default
hl.window_rule({ match = { class = "blueman-manager" }, float = true })

-- Distribution of monitors among workspaces
hl.workspace_rule({ workspace = "1", monitor = MON1, default = true })
hl.workspace_rule({ workspace = "2", monitor = MON1 })
hl.workspace_rule({ workspace = "3", monitor = MON1 })
hl.workspace_rule({ workspace = "4", monitor = MON1 })
hl.workspace_rule({ workspace = "5", monitor = MON2, default = true })
hl.workspace_rule({ workspace = "6", monitor = MON2 })
hl.workspace_rule({ workspace = "7", monitor = MON2 })
hl.workspace_rule({ workspace = "8", monitor = MON2 })
hl.workspace_rule({ workspace = "9", monitor = MON2 })
hl.workspace_rule({ workspace = "9", monitor = MON2 })
