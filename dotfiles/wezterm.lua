local wezterm = require("wezterm")

return {
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 14.0,
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	window_padding = { left = 8, right = 8, top = 8, bottom = 8 },
	window_background_opacity = 0.95,
	enable_kitty_graphics = true,

	-- Transmet Ctrl+/ à Neovim au lieu de l'intercepter
	keys = {
		{ key = "\\", mods = "CTRL", action = wezterm.action.SendKey({ key = "\\", mods = "CTRL" }) },
		{ key = "s", mods = "CTRL", action = wezterm.action.SendKey({ key = "s", mods = "CTRL" }) },
		-- Passer les Ctrl+flèches à tmux
		{ key = "UpArrow", mods = "CTRL", action = wezterm.action.SendKey({ key = "UpArrow", mods = "CTRL" }) },
		{ key = "DownArrow", mods = "CTRL", action = wezterm.action.SendKey({ key = "DownArrow", mods = "CTRL" }) },
		{ key = "LeftArrow", mods = "CTRL", action = wezterm.action.SendKey({ key = "LeftArrow", mods = "CTRL" }) },
		{ key = "RightArrow", mods = "CTRL", action = wezterm.action.SendKey({ key = "RightArrow", mods = "CTRL" }) },
		{ key = "b", mods = "CTRL", action = wezterm.action.SendKey({ key = "b", mods = "CTRL" }) },
		-- Opt+flèches : navigation par mot
		{ key = "LeftArrow", mods = "OPT", action = wezterm.action.SendKey({ key = "b", mods = "ALT" }) },
		{ key = "RightArrow", mods = "OPT", action = wezterm.action.SendKey({ key = "f", mods = "ALT" }) },
		-- Opt+Shift+flèches : sélection par mot
		{
			key = "RightArrow",
			mods = "OPT|SHIFT",
			action = wezterm.action.SendKey({ key = "RightArrow", mods = "ALT|SHIFT" }),
		},
		{
			key = "LeftArrow",
			mods = "OPT|SHIFT",
			action = wezterm.action.SendKey({ key = "LeftArrow", mods = "ALT|SHIFT" }),
		},
	},
}
