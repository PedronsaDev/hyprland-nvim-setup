--===========================================================
-- 
-- CONFIG MADE BY PEDRONSADEV
-- EDIT THIS CONFIG ACCORDING TO YOUR TASTE :)
-- (Migrated to Lua Syntax)
--
--===========================================================

-- This is an example Hyprland lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/

-- We add the `lua` folder to the package path so require can find the modules easily
package.path = package.path .. ";/home/pedronsa/.config/hypr/lua/?.lua"

--===========================================================

-- Variables (must be loaded first for `_G.mainMod`, `_G.colors`, etc. to exist)
require("variables")
require("colors")

-- Core Configuration
require("monitors")
require("autostart")
require("environment")
require("visuals")

-- Rules & Input
require("rules.input")
require("rules.window-rules")
require("permissions")

-- Keybindings (organized by category)
require("keybinds.applications")
require("keybinds.windows")
require("keybinds.workspaces")
require("keybinds.media")

-- XWayland Settings
hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})

--===========================================================
