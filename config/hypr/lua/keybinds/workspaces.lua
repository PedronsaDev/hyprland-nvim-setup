-----------------------------
--- WORKSPACE KEYBINDINGS ---
-----------------------------

-- Switch workspaces with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(_G.mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(_G.mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad) with mainMod + W
hl.bind(_G.mainMod .. " + W", hl.dsp.workspace.toggle_special("magic"))
hl.bind(_G.mainMod .. " + SHIFT + W", hl.dsp.window.move({ workspace = "special:magic" }))

-- Cycle through workspaces with mouse wheel
hl.bind(_G.mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(_G.mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "r-1" }))

-- Navigate back and forward through workspaces on the same monitor
hl.bind(_G.mainMod .. " + CTRL + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(_G.mainMod .. " + CTRL + left", hl.dsp.focus({ workspace = "r-1" }))

-- Move windows back and forward through workspaces on the same monitor
hl.bind(_G.mainMod .. " + CTRL + SHIFT + right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(_G.mainMod .. " + CTRL + SHIFT + left", hl.dsp.window.move({ workspace = "r-1" }))

-- Quickly switch to the previously visited workspace (Alt-Tab style)
hl.bind(_G.mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

