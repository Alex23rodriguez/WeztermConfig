local wezterm = require('wezterm')

local act = wezterm.action

local module = {}

function module.apply_to_config(config)
  wezterm.on('update-right-status', function(window, pane)
    local name = window:active_key_table()
    if name then
      name = 'TABLE: ' .. name
    end
    window:set_right_status(name or '')
  end)

  config.keys = {
    {
      key = 's',
      mods = 'CMD',
      action = act.ActivateKeyTable({
        name = 'resize_mode',
        one_shot = false, -- stay after more than one keypress
        prevent_fallback = true, -- ignore unrecognized keys
      }),
    },

    table.unpack(config.keys),
  }

  config.key_tables = {
    resize_mode = {
      -- move
      { key = 'n', action = act.ActivatePaneDirection('Left') },
      { key = 'i', action = act.ActivatePaneDirection('Right') },
      { key = 'u', action = act.ActivatePaneDirection('Up') },
      { key = 'e', action = act.ActivatePaneDirection('Down') },

      -- resize
      { key = 'n', action = act.ActivatePaneDirection('Left') },
      { key = 'i', action = act.ActivatePaneDirection('Right') },
      { key = 'u', action = act.ActivatePaneDirection('Up') },
      { key = 'e', action = act.ActivatePaneDirection('Down') },

      -- split
      { key = 'h', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },
      { key = 'v', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },

      -- select
      { key = 's', action = act.PaneSelect({ mode = 'Activate' }) },
      { key = 'S', action = act.PaneSelect({ mode = 'SwapWithActive' }) },

      -- quit
      { key = 'q', action = act.CloseCurrentPane({ confirm = false }) },

      { key = 'Escape', action = 'PopKeyTable' },
    },
  }
end

return module
