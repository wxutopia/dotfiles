local wezterm = require("wezterm")

local function is_found(str, pattern)
	return string.find(str, pattern) ~= nil
end

local is_win = is_found(wezterm.target_triple, "windows")
local is_linux = is_found(wezterm.target_triple, "linux")
local is_mac = is_found(wezterm.target_triple, "apple")

local default_prog = "zsh"
if is_win then
	default_prog = "pwsh"
end

local config = {
	font_size = 10,
	font = wezterm.font("Maple Mono NF CN", { weight = "Bold" }),

	color_scheme = "Everforest Dark (Gogh)",

	initial_cols = 120,
	initial_rows = 30,

	enable_tab_bar = true,
	tab_bar_at_bottom = false,
	use_fancy_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = true,
	show_new_tab_button_in_tab_bar = false,

	window_decorations = "RESIZE",
	window_background_opacity = 0.9,
	adjust_window_size_when_changing_font_size = false,
	window_padding = {
		left = 15,
		right = 15,
		top = 15,
		bottom = 10,
	},

	inactive_pane_hsb = {
		saturation = 0.7,
		brightness = 0.5,
	},

	default_cursor_style = "BlinkingBar",
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	cursor_blink_rate = 500,

	default_prog = { default_prog },
}

wezterm.on("gui-startup", function(cmd) -- set startup Window position
	local main_screen = wezterm.gui.screens().main
	local position = {
		x = main_screen.width / 2,
		y = main_screen.height / 5,
		origin = "MainScreen",
	}
	cmd = cmd or { position = position }
	wezterm.mux.spawn_window(cmd)
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, configuration, hover, max_width)
	local background = "#333333"
	local foreground = "#808080"

	if tab.is_active then
		background = "#11111b"
		foreground = "#c0c0c0"
	elseif hover then
		background = "#3b3052"
		foreground = "#909090"
	end

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. (tab.tab_index + 1) .. ":" .. " " .. default_prog .. " " },
	}
end)

local function process_name(s)
	local a = string.gsub(s, "(.*[/\\])(.*)", "%2")
	return a:gsub("%.exe$", "")
end

local alt_or_cmd = "ALT"
if is_mac then
	alt_or_cmd = "CMD"
end

local act = wezterm.action
config.keys = {
	{
		key = "q",
		mods = alt_or_cmd,
		action = act.QuitApplication,
	},
	{
		key = "w",
		mods = alt_or_cmd,
		action = act.CloseCurrentTab({ confirm = true }),
	},
	{
		key = "t",
		mods = alt_or_cmd,
		action = act.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "y",
		mods = alt_or_cmd,
		action = act.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "m",
		mods = alt_or_cmd,
		action = act.Hide,
	},
	{
		key = "n",
		mods = alt_or_cmd,
		action = act.SpawnWindow,
	},
	{
		key = ";",
		mods = alt_or_cmd,
		action = act.ActivateTabRelative(1),
	},
	{
		key = "'",
		mods = alt_or_cmd,
		action = act.ActivateTabRelative(-1),
	},
	{
		key = "\\",
		mods = alt_or_cmd,
		action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "/",
		mods = alt_or_cmd,
		action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "UpArrow",
		mods = alt_or_cmd,
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = alt_or_cmd,
		action = act.ActivatePaneDirection("Down"),
	},
	{
		key = "LeftArrow",
		mods = alt_or_cmd,
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = alt_or_cmd,
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "c",
		mods = alt_or_cmd,
		action = act.CopyTo("Clipboard"),
	},
	{
		key = "v",
		mods = alt_or_cmd,
		action = act.PasteFrom("Clipboard"),
	},
	{
		key = "9", -- "UpArrow",
		mods = alt_or_cmd,
		action = act.ScrollByPage(-0.3),
	},
	{
		key = "0", -- "DownArrow",
		mods = alt_or_cmd,
		action = act.ScrollByPage(0.3),
	},
}

config.mouse_bindings = {
	{
		event = { Drag = { streak = 1, button = "Left" } },
		mods = alt_or_cmd,
		action = wezterm.action.StartWindowDrag,
	},
}

return config
