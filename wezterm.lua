local wezterm = require('wezterm')

local keymaps = require('keymaps')
local resize_keytable = require('resize_keytable')

-- PLUGINS
local plugins_config = require('plugins')
-- wezterm.log_info("THIS IS A LOG!!")
-- WEZTERM_LOG=info wezterm

local config = {
  -- appearence
  color_scheme = 'tokyonight_storm',
  -- color_scheme = "tokyonight_night",

  -- enable_tab_bar = false,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  font = wezterm.font('Hack Nerd Font', { weight = 'Bold' }),

  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.5,
    -- hue = 0.8,
  },
  -- inactive_pane_opacity = 0.5,
  -- window_background_opacity = 0.98,
  window_decorations = 'RESIZE',

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  -- term = 'wezterm',

  keys = {}, -- defined in modules
}

-- remember to call table.unpack(config.keys) at the end of new definition
keymaps.apply_to_config(config)
resize_keytable.apply_to_config(config)

plugins_config.apply_to_config(config)

return config
