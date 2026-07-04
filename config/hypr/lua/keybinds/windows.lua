---------------
--- WINDOWS ---
---------------

-- Window operations
hl.bind(_G.mainMod .. " + RETURN", hl.dsp.window.fullscreen())
hl.bind(_G.mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(_G.mainMod .. " + J", hl.dsp.layout("orientationcycle"))
hl.bind(_G.mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))

-- Move focus with mainMod + arrow keys
hl.bind(_G.mainMod .. " + left", hl.dsp.focus({ direction = "l" }))
hl.bind(_G.mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(_G.mainMod .. " + up", hl.dsp.focus({ direction = "u" }))
hl.bind(_G.mainMod .. " + down", hl.dsp.focus({ direction = "d" }))

-- Move windows with mainMod + Shift + arrow keys
hl.bind(_G.mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(_G.mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(_G.mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(_G.mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "d" }))

-- Mouse window management
hl.bind(_G.mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(_G.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
