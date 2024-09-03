local wezterm = require('wezterm')

local keymaps = require('keymaps')

-- wezterm.log_info("THIS IS A LOG!!")
-- WEZTERM_LOG=info wezterm

local config = {
  -- appearence
  color_scheme = 'tokyonight_storm',
  -- color_scheme = "tokyonight_night",

  -- enable_tab_bar = false,
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,

  font = wezterm.font('Hack Nerd Font'),

  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.5,
    -- hue = 0.8,
  },
  -- inactive_pane_opacity = 0.5,
  window_background_opacity = 1,

  window_decorations = 'RESIZE',

  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },

  keys = {}, -- defined in modules
}

keymaps.apply_to_config(config)

return config
