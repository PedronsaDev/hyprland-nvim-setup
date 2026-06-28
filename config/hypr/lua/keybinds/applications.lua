--------------------
--- APPLICATIONS ---
--------------------

-- See https://wiki.hypr.land/Configuring/Keywords/

-- Terminal
hl.bind(_G.mainMod .. " + Q", hl.dsp.exec_cmd(_G.terminal))

-- File Manager
hl.bind(_G.mainMod .. " + E", hl.dsp.exec_cmd(_G.fileManager))

-- Application Menu / Launcher
hl.bind(_G.mainMod .. " + SPACE", hl.dsp.exec_cmd(_G.menu))

-- Browser
hl.bind(_G.mainMod .. " + B", hl.dsp.exec_cmd(_G.browser))

-- Communications (Discord, Telegram, etc.)
hl.bind(_G.mainMod .. " + D", hl.dsp.exec_cmd(_G.comms))

-- Reload Waybar
hl.bind(_G.mainMod .. " + R", hl.dsp.exec_cmd(_G.reload_waybar))

-- Screenshot
hl.bind(_G.mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(_G.printSc))

-- File Manager (alternative)
hl.bind(_G.mainMod .. " + Y", hl.dsp.exec_cmd(_G.uFm))

-- Clipboard History
hl.bind(_G.mainMod .. " + V", hl.dsp.exec_cmd("sh -c 'cliphist list | wofi -dmenu | cliphist decode | wl-copy'"))

-- Force Close Application
hl.bind(_G.mainMod .. " + C", hl.dsp.window.close())

-- Open SDDM (or exit)
hl.bind(_G.mainMod .. " + M", hl.dsp.exit())
