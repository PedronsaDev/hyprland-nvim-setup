# Hyprland Configuration

This is a modular and organized Hyprland window manager configuration made by pedronsadev.

## Directory Structure

```
~/.config/hypr/
├── hyprland.conf           # Main configuration file (entry point)
├── config/
│   ├── monitors.conf       # Monitor/display configuration
│   ├── variables.conf      # Environment variables and aliases
│   ├── autostart.conf      # Programs to start automatically
│   ├── environment.conf    # Environment variables
│   ├── visuals.conf        # Visual settings (colors, animations, etc.)
│   ├── permissions.conf    # Portal permissions
│   ├── keybinds/           # Keybinding configurations
│   │   ├── applications.conf   # App launcher shortcuts
│   │   ├── windows.conf        # Window management bindings
│   │   ├── workspaces.conf     # Workspace navigation bindings
│   │   └── media.conf          # Media control & brightness bindings
│   └── rules/              # Input and window rules
│       ├── input.conf      # Input device settings
│       └── window-rules.conf   # Window-specific rules
└── utilities/              # Utility configurations
    ├── hypridle.conf       # Idle timeout and lock settings
    ├── hyprlock.conf       # Lock screen styling
    └── hyprpaper.conf      # Wallpaper configuration
```

## Configuration Files

### Core Files

- **hyprland.conf**: Main entry point that sources all configuration files
- **config/monitors.conf**: Monitor setup, resolution, refresh rate, positioning
- **config/variables.conf**: Application variables ($terminal, $browser, $menu, etc.)
- **config/autostart.conf**: Programs that launch on startup
- **config/environment.conf**: Environment variables
- **config/visuals.conf**: Animations, colors, decorations, gaps, etc.
- **config/permissions.conf**: XDG portal permissions

### Keybindings

Keybindings are organized by function for easy management:

- **applications.conf**: Terminal, file manager, browser, launcher shortcuts
- **windows.conf**: Focus movement, window manipulation, floating, fullscreen
- **workspaces.conf**: Workspace switching and window movement between workspaces
- **media.conf**: Volume, brightness, and media player controls

### Rules

- **input.conf**: Keyboard layout, mouse sensitivity, touchpad settings, per-device configs
- **window-rules.conf**: Window-specific rules, floating rules, workspace assignments

### Utilities

- **hypridle.conf**: Idle timeout before lock screen activation
- **hyprlock.conf**: Lock screen appearance and styling
- **hyprpaper.conf**: Wallpaper configuration

## Key Bindings

### Applications ($mainMod = Super/Windows Key)

- `Super + Q` - Terminal
- `Super + E` - File Manager
- `Super + Space` - Application Launcher
- `Super + B` - Web Browser
- `Super + D` - Communications App
- `Super + R` - Reload Waybar
- `Super + Shift + S` - Screenshot
- `Super + Y` - File Manager (alternative)
- `Super + V` - Clipboard History

### Window Management

- `Super + C` - Kill active window
- `Super + M` - Exit/Shutdown
- `Super + Return` - Fullscreen
- `Super + P` - Pseudo tiling
- `Super + J` - Cycle layout
- `Super + F` - Toggle floating
- `Super + Arrow Keys` - Move focus
- `Super + Shift + Arrow Keys` - Move window

### Workspaces

- `Super + 1-9` - Switch to workspace
- `Super + 0` - Switch to workspace 10
- `Super + Shift + 1-9` - Move window to workspace
- `Super + W` - Toggle scratchpad
- `Super + Mouse Wheel` - Cycle workspaces

### Media

- `XF86AudioRaiseVolume` / `XF86AudioLowerVolume` - Volume control
- `XF86AudioMute` - Mute/unmute
- `XF86MonBrightnessUp` / `XF86MonBrightnessDown` - Brightness
- `XF86AudioPlay` / `XF86AudioNext` / `XF86AudioPrev` - Media control

## Customization

### Adding New Keybindings

1. Edit the appropriate file in `config/keybinds/`
2. Follow the existing syntax and add your binding
3. Reload Hyprland with `hyprctl reload`

### Modifying Window Rules

Edit `config/rules/window-rules.conf` to add rules for specific applications.

### Changing Visual Settings

Edit `config/visuals.conf` for colors, animations, gaps, borders, etc.

### Adding Auto-start Programs

Add new programs to `config/autostart.conf` with the exec directive.

### Wallpaper Configuration

Edit `utilities/hyprpaper.conf` to change wallpaper settings.

## Requirements

- Hyprland window manager
- wpctl (for volume control)
- brightnessctl (for brightness control)
- playerctl (for media control)
- wofi (for application launcher)
- cliphist (for clipboard history)

Optional:
- Waybar (for taskbar)
- hyprlock (for lock screen)
- hypridle (for idle management)
- hyprpaper (for wallpaper)

## Tips

1. **Reload Configuration**: Use `hyprctl reload` to reload all settings
2. **Test Changes**: Use `hyprctl dispatch` to test keybindings before reloading
3. **Monitor Details**: Check `hyprctl monitors` to see monitor information
4. **Window Info**: Use `hyprctl activewindow` to get active window class for rules
5. **Documentation**: Check [Hyprland Wiki](https://wiki.hypr.land) for detailed configuration options

## Debugging

If something isn't working:

1. Check the Hyprland logs: `journalctl --user -u hyprland -f`
2. Verify syntax in modified files
3. Test individual commands with `hyprctl dispatch`
4. Check that all sourced files exist and are readable

## Resources

- [Hyprland Wiki](https://wiki.hypr.land)
- [Hyprland GitHub](https://github.com/hyprwm/Hyprland)
- [Configuration Reference](https://wiki.hypr.land/Configuring/Keywords/)

---

Made with ❤️ by pedronsadev