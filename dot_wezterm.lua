-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 15
config.color_scheme = "GitHub Dark"
config.font = wezterm.font({
	family = "DroidSansM Nerd Font",
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
})

-- tmux-like bindings for windows
-- config.leader = { key = "q", mods = "CTRL", timeout_millisecond = "2000" }
-- config.keys = {
-- 	{
-- 		mods = "LEADER",
-- 		key = "c",
-- 		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "x",
-- 		action = wezterm.action.CloseCurrentPane({ confirm = true }),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "b",
-- 		action = wezterm.action.ActivateTabRelative(-1),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "n",
-- 		action = wezterm.action.ActivateTabRelative(1),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "\\",
-- 		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "-",
-- 		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "h",
-- 		action = wezterm.action.ActivatePaneDirection("Left"),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "j",
-- 		action = wezterm.action.ActivatePaneDirection("Down"),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "k",
-- 		action = wezterm.action.ActivatePaneDirection("Up"),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "l",
-- 		action = wezterm.action.ActivatePaneDirection("Right"),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "LeftArrow",
-- 		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "RightArrow",
-- 		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "DownArrow",
-- 		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
-- 	},
-- 	{
-- 		mods = "LEADER",
-- 		key = "UpArrow",
-- 		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
-- 	},
-- 	{ key = "k", mods = "SHIFT|CTRL", action = wezterm.action.ScrollByPage(-0.5) },
-- 	{ key = "j", mods = "SHIFT|CTRL", action = wezterm.action.ScrollByPage(0.5) },
-- }

-- Scrolling behavior
-- How many lines of scrollback you want to retain per tab
config.scrollback_lines = 3500

-- Finally, return the configuration to wezterm:
return config
