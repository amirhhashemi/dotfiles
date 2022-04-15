local wezterm = require("wezterm")

return {
	font = wezterm.font("FiraCode NF"),
	font_size = 11.0,
	window_background_opacity = 1.0,
	enable_tab_bar = false,
	keys = {
		{ key = "/", mods = "CTRL", action = wezterm.action({ SendString = "\x1f" }) },
	},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	color_scheme = "tokyonight",
	color_schemes = {
		["tokyonight"] = {
			foreground = "#c0caf5",
			background = "#1a1b26",
			cursor_bg = "#c0caf5",
			cursor_border = "#c0caf5",
			cursor_fg = "#1a1b26",
			selection_bg = "#33467C",
			selection_fg = "#c0caf5",
			ansi = { "#15161E", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#a9b1d6" },
			brights = { "#414868", "#f7768e", "#9ece6a", "#e0af68", "#7aa2f7", "#bb9af7", "#7dcfff", "#c0caf5" },
		},
	},
}
