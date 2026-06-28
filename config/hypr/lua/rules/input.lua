-------------
--- INPUT ---
-------------

-- https://wiki.hypr.land/Configuring/Variables/#input
hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",

        repeat_rate = 35,
        repeat_delay = 300,

        follow_mouse = 1,
        mouse_refocus = false,

        sensitivity = -0.95,

        touchpad = {
            natural_scroll = false
        }
    },

    cursor = {
        inactive_timeout = 30
    },

})
