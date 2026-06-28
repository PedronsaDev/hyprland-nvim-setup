----------------
---- MONITORS ----
----------------

-- See https://wiki.hypr.land/Configuring/Monitors/

-- SET PRIMARY
hl.monitor({
    output   = "DP-2",
    mode     = "1920x1080@144.00",
    position = "0x0",
    scale    = 1,
})

-- SET VERTICAL
hl.monitor({
    output    = "DP-4",
    mode      = "1920x1080@60.00",
    position  = "-1080x-550",
    scale     = 1,
    transform = 1,
})

-- SET TERCIARY
hl.monitor({
    output   = "DP-3",
    mode     = "1920x1080@60.00",
    position = "auto-right",
    scale    = 1,
})
