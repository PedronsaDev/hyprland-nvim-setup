-- ###################
-- ### VARIABLES (generated)
-- ###################

-- Load centralized theme
local theme_path = os.getenv("HOME") .. "/.config/theme.lua"
local f = loadfile(theme_path)
if f then
    local theme = f()
    _G.colors = {
        background = theme.background,
        foreground = theme.foreground,
        accent = theme.accent,
        muted_accent = theme.muted,
        alert = theme.red
    }
else
    -- Fallback
    _G.colors = {
        background = "rgba(2b3339ff)",
        foreground = "rgba(d3c6aaff)",
        accent = "rgba(a7c080ff)",
        muted_accent = "rgba(4b565cff)",
        alert = "rgba(e67e80ff)"
    }
end
