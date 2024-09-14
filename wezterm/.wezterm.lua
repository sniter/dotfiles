-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 13

-- config.enable_tab_bar = false

config.window_decorations = "TITLE | RESIZE"
-- config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Tokyo Night"

config.window_background_opacity = 0.8
config.macos_window_background_blur = 10

config.mouse_bindings = {
	-- Right click sends "woot" to the terminal
	-- {
	--   event = { Down = { streak = 1, button = 'Right' } },
	--   mods = 'NONE',
	--   action = act.SendString 'woot',
	-- },
	-- Change the default click behavior so that it only selects
	-- text and doesn't open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "NONE",
		action = act.CompleteSelection("ClipboardAndPrimarySelection"),
	},
	-- and make CTRL-Click open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
	-- NOTE that binding only the 'Up' event can give unexpected behaviors.
	-- Read more below on the gotcha of binding an 'Up' event only.
}

-- and finally, return the configuration to wezterm
return config
