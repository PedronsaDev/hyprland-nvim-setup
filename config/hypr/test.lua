hl = {
    monitor = function() end,
    on = function() end,
    exec_cmd = function() return {} end,
    env = function() end,
    window_rule = function() end,
    bind = function() end,
    config = function() end,
    curve = function() end,
    animation = function() end,
    dsp = {
        exec_cmd = function() return {} end,
        window = {
            close = function() return {} end,
            fullscreen = function() return {} end,
            pseudo = function() return {} end,
            float = function() return {} end,
            move = function() return {} end,
            drag = function() return {} end,
            resize = function() return {} end
        },
        focus = function() return {} end,
        workspace = {
            toggle_special = function() return {} end,
            focus = function() return {} end
        }
    }
}
dofile("hyprland.lua.broken2")
print("SUCCESS")
