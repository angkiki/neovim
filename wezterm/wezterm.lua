local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_domain = 'WSL:Ubuntu'

-- Basic setup
config.font = wezterm.font_with_fallback({
    { family = 'JetBrains Mono', weight = 'Regular' },
    { family = 'Hack Nerd Font', weight = 'Regular' },
})
config.font_size = 11.0
config.line_height = 2.5 -- Equivalent to cell_height 200%
config.cursor_blink_rate = 0 -- Cursor blink interval 0

-- Set the initial window size (Columns x Rows)
config.initial_cols = 120
config.initial_rows = 15

-- For configuring "Shift Enter" to trigger new line
config.keys = {
  {
    key = 'Enter',
    mods = 'SHIFT',
    action = wezterm.action.SendString '\n',
  },
  -- Incremental scrollback scroll, mirroring vim's Ctrl+e / Ctrl+y.
  -- Bound to Ctrl+Shift (not plain Ctrl) so it doesn't shadow readline's
  -- Ctrl+E (end of line) / Ctrl+Y (yank) in the shell.
  {
    key = 'e',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ScrollByLine(3),
  },
  {
    key = 'y',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ScrollByLine(-3),
  },
}

return config
