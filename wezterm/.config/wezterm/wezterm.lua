local wezterm = require("wezterm")

local function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Catppuccin Mocha"
	else
		return "Catppuccin Latte"
	end
end

return {
	font = wezterm.font("FiraCode Nerd Font"),
	font_size = 11.0,
	window_background_opacity = 1.0,
	enable_tab_bar = true,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
	leader = { key = ",", mods = "CTRL" },
	disable_default_key_bindings = true,
	keys = {
		{
			key = "v",
			mods = "LEADER",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "s",
			mods = "LEADER",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "z",
			mods = "LEADER",
			action = wezterm.action.TogglePaneZoomState,
		},
		{
			key = "h",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
		},
		{
			key = "l",
			mods = "LEADER",
			action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
		},

		{ key = "f", mods = "LEADER", action = wezterm.action.PaneSelect },

		{ key = "r", mods = "LEADER", action = wezterm.action.RotatePanes("Clockwise") },

		{ key = "h", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "j", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "k", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "LeftArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "RightArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "DownArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "UpArrow", mods = "CTRL", action = wezterm.action.ActivatePaneDirection("Up") },

		{ key = "/", mods = "CTRL", action = wezterm.action.SendKey({ key = "_", mods = "CTRL" }) },
	},
}
