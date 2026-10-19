-- https://wezterm.org/config/files.html

local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.hide_tab_bar_if_only_one_tab = true

config.window_background_opacity = 0.96

config.mouse_bindings = {
	-- CTRL-Click to open hyperlinks https://wezterm.org/recipes/hyperlinks.html#optional-configuration
	-- Disable the 'Down' event when setting the 'Up' event to avoid weird program behaviors
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.Nop,
	},
	-- disable default hyperlink open on regular left click
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	},
}

-- https://github.com/wezterm/wezterm/issues/3803
-- tests:
-- https://en.wikipedia.org/wiki/Class_(set_theory)
-- [text](https://example.com)
-- (follow this link: https://example.com)
-- URL in quotes: "https://example.com"
-- URL with parentheses in quotes: "https://en.wikipedia.org/wiki/Class_(set_theory)"
-- URL in parentheses: (https://example.com)
-- URL in brackets: [https://example.com]
-- URL in curly braces: {https://example.com}
-- URL in angle brackets: <https://example.com>
-- email address: test@example.com
config.hyperlink_rules = {
	{
		regex = [[\b\w+://(?:[^\s()<>"'`]|\((?:[^\s()<>]|\([^\s()<>]*\))*\))*(?:[\w/#=&%~+-]|\((?:[^\s()<>]|\([^\s()<>]*\))*\))]],
		format = "$0",
	},
	{
		regex = [[\b[\w.+-]+@[\w-]+(\.[\w-]+)+\b(?!:)]],
		format = "mailto:$0",
	},
}

config.font = wezterm.font("Hack Nerd Font Mono")
if wezterm.target_triple:find("darwin") then
	config.font_size = 12
else
	config.font_size = 9
end
-- config.color_scheme = "Atom"
-- config.color_scheme = "Bamboo"
-- config.color_scheme = "carbonfox"
-- config.color_scheme = "catppuccin-mocha"
-- config.color_scheme = "Dracula"
-- config.color_scheme = "GruvboxDarkHard"
-- config.color_scheme = "Gooey (Gogh)"
-- config.color_scheme = "nord"
config.color_scheme = "Tokyo Night"
-- config.color_scheme = "Tomorrow Night Burns"
-- config.color_scheme = "UltraViolent"
-- config.color_scheme = "Unikitty Dark (base16)"

config.visual_bell = {
	fade_in_function = "EaseIn",
	fade_in_duration_ms = 150,
	fade_out_function = "EaseOut",
	fade_out_duration_ms = 150,
}
config.colors = {
	visual_bell = "#160813",
}
-- bg = "#1a1b26",
--   bg_dark = "#16161e",
--   bg_dark1 = "#0C0E14",
config.audible_bell = "Disabled"

return config
