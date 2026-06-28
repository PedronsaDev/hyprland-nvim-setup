# Hyprland Configuration - Quick Reference

## Common Tasks

### Reload Configuration
```bash
hyprctl reload
```

### View Active Keybindings
```bash
hyprctl binds
```

### Check Monitor Configuration
```bash
hyprctl monitors
```

### Get Active Window Information
```bash
hyprctl activewindow
```

### View All Workspaces
```bash
hyprctl workspaces
```

## Editing Configurations

### Edit Application Launcher Shortcuts
```bash
vim ~/.config/hypr/config/keybinds/applications.conf
```

### Edit Window Management Keys
```bash
vim ~/.config/hypr/config/keybinds/windows.conf
```

### Edit Workspace Navigation Keys
```bash
vim ~/.config/hypr/config/keybinds/workspaces.conf
```

### Edit Media Controls
```bash
vim ~/.config/hypr/config/keybinds/media.conf
```

### Edit Visual Settings
```bash
vim ~/.config/hypr/config/visuals.conf
```

### Edit Input Settings
```bash
vim ~/.config/hypr/config/rules/input.conf
```

### Edit Window Rules
```bash
vim ~/.config/hypr/config/rules/window-rules.conf
```

### Edit Auto-start Programs
```bash
vim ~/.config/hypr/config/autostart.conf
```

### Edit Wallpaper
```bash
vim ~/.config/hypr/utilities/hyprpaper.conf
```

### Edit Lock Screen
```bash
vim ~/.config/hypr/utilities/hyprlock.conf
```

### Edit Idle Settings
```bash
vim ~/.config/hypr/utilities/hypridle.conf
```

## Configuration Structure

### To Add a New Keybinding

1. Choose the appropriate file:
   - Applications: `config/keybinds/applications.conf`
   - Windows: `config/keybinds/windows.conf`
   - Workspaces: `config/keybinds/workspaces.conf`
   - Media: `config/keybinds/media.conf`

2. Add your keybinding:
   ```conf
   bind = $mainMod, KEY, exec, command
   ```

3. Reload: `hyprctl reload`

### To Add a Window Rule

1. Edit: `config/rules/window-rules.conf`

2. Add your rule:
   ```conf
   windowrule {
       name = my-rule
       match:class = MyApplication
       float = yes
   }
   ```

3. Reload: `hyprctl reload`

### To Change Colors/Visuals

1. Edit: `config/visuals.conf`
2. Modify color values (format: `rgb(rrggbb)`)
3. Reload: `hyprctl reload`

### To Change Application Variables

1. Edit: `config/variables.conf`
2. Update $terminal, $browser, $menu, etc.
3. Reload: `hyprctl reload`

## Useful Keybinding Syntax

```conf
# Basic binding
bind = MOD, KEY, action

# With flags (e, l = repeat, must be released)
bindel = MOD, KEY, action
bindl = MOD, KEY, action

# Mouse binding
bindm = MOD, mouse:BUTTON, action

# Remove a binding
unbind = MOD, KEY
```

## Variables Reference

```conf
$mainMod = SUPER        # Windows/Super key
$terminal = kitty       # Your terminal
$browser = firefox      # Your browser
$menu = wofi            # Application launcher
$fileManager = thunar   # File manager
```

## Color Format

Use RGB format without spaces:
- `rgb(ffffff)` - White
- `rgb(000000)` - Black
- `rgb(ff0000)` - Red
- `rgb(00ff00)` - Green
- `rgb(0000ff)` - Blue

## File Locations

| Config | Location |
|--------|----------|
| Main | `~/.config/hypr/hyprland.conf` |
| Monitors | `~/.config/hypr/config/monitors.conf` |
| Variables | `~/.config/hypr/config/variables.conf` |
| Keybinds | `~/.config/hypr/config/keybinds/*.conf` |
| Rules | `~/.config/hypr/config/rules/*.conf` |
| Wallpaper | `~/.config/hypr/utilities/hyprpaper.conf` |
| Lock Screen | `~/.config/hypr/utilities/hyprlock.conf` |
| Idle | `~/.config/hypr/utilities/hypridle.conf` |

## Troubleshooting

### Configuration Won't Load
- Check for syntax errors: `hyprctl -j getoption` 
- View logs: `journalctl --user -u hyprland -f`
- Verify file paths in source statements

### Keybinding Not Working
- Check if it's already bound: `hyprctl binds | grep KEY`
- Verify syntax is correct
- Check that applications exist in PATH
- Reload config: `hyprctl reload`

### Window Rules Not Applied
- Verify window class: `hyprctl activewindow`
- Check rule syntax in window-rules.conf
- Reload config: `hyprctl reload`

### Monitor Not Detected
- Check: `hyprctl monitors`
- Edit monitors.conf with correct output names
- Reload: `hyprctl reload`

## Useful Commands

| Command | Purpose |
|---------|---------|
| `hyprctl reload` | Reload all configs |
| `hyprctl dispatch exec command` | Execute command |
| `hyprctl dispatch movetoworkspace 1` | Move window to workspace |
| `hyprctl dispatch togglefloating` | Toggle floating mode |
| `hyprctl clients` | List all windows |
| `hyprctl keyword bind MOD KEY action` | Test keybinding |

## Tips & Tricks

1. **Test keybindings without reloading**: Use `hyprctl keyword bind $mainMod, k, exec, notify-send "test"`
2. **Find window class**: Run `hyprctl activewindow` to get info for window rules
3. **Organize configs**: Create new files in keybinds/ for better organization
4. **Comments**: Use `#` to add comments in any config file
5. **Variables**: Define custom variables in variables.conf for reuse