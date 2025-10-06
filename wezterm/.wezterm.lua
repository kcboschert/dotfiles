local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true
config.font = wezterm.font("Hack Nerd Font Mono")
config.font_size = 10
-- config.color_scheme = "Atom"
-- config.color_scheme = "catppuccin-mocha"
-- config.color_scheme = "Dracula"
-- config.color_scheme = "GruvboxDarkHard"
-- config.color_scheme = "Gooey (Gogh)"
-- config.color_scheme = "nord"
config.color_scheme = "tokyonight_night"
-- config.color_scheme = "Tomorrow Night Burns"
-- config.color_scheme = "UltraViolent"
-- config.color_scheme = "Unikitty Dark (base16)"

config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}
config.colors = {
  visual_bell = '#160813'
}
-- bg = "#1a1b26",
--   bg_dark = "#16161e",
--   bg_dark1 = "#0C0E14",
config.audible_bell = "Disabled"

return config
