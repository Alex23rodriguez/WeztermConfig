local wezterm = require('wezterm')

local module = {}

local act = wezterm.action

local function if_nvim(win, pane, key_if_true, key_if_false)
  if pane:get_foreground_process_info()['name'] == 'nvim' then
    win:perform_action(key_if_true, pane)
  else
    win:perform_action(key_if_false, pane)
  end
end

function module.apply_to_config(config)
  -- keyboard
  config.leader = { key = 'b', mods = 'CMD', timeout_milliseconds = 2000 }
  -- https://wezfurlong.org/wezterm/config/keys.html#configuring-key-assignments
  -- https://wezfurlong.org/wezterm/config/lua/keyassignment/index.html
  -- https://wezfurlong.org/wezterm/config/lua/keyassignment/SendKey.html
  config.keys = {
    -- Send Alt-J when Alt-I is pressed
    { key = 'i', mods = 'OPT', action = act.SendKey({ key = 'j', mods = 'ALT' }) },

    -- Send Alt-Shift-J when Alt-Shift-I is pressed
    { key = 'I', mods = 'OPT', action = act.SendKey({ key = 'J', mods = 'ALT' }) },
    -- { key = "I", mods = "ALT|SHIFT", action = act.SendString("\x1BJ") },

    -- Send Ctrl-J when Ctrl-I is pressed
    { key = 'i', mods = 'CTRL', action = act.SendKey({ key = 'j', mods = 'CTRL' }) },

    -- LEADER
    { key = 'b', mods = 'LEADER|CMD', action = act.SendKey({ key = 'b', mods = 'CMD' }) },
    {
      key = 'v',
      mods = 'LEADER',
      action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },
    {
      key = 'h',
      mods = 'LEADER',
      action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    {
      key = 'q',
      mods = 'LEADER',
      action = act.CloseCurrentPane({ confirm = false }),
    },
    {
      key = 'g',
      mods = 'LEADER',
      action = act.ScrollToTop,
    },
    {
      key = 'G',
      mods = 'LEADER',
      action = act.ScrollToBottom,
    },
    {
      key = 's',
      mods = 'LEADER',
      action = act.PaneSelect({ mode = 'Activate' }),
    },
    {
      key = 'S',
      mods = 'LEADER',
      action = act.PaneSelect({ mode = 'SwapWithActive' }),
    },
    {
      key = 'n',
      mods = 'LEADER',
      action = act.AdjustPaneSize({ 'Left', 5 }),
    },
    {
      key = 'e',
      mods = 'LEADER',
      action = act.AdjustPaneSize({ 'Down', 5 }),
    },
    { key = 'u', mods = 'LEADER', action = act.AdjustPaneSize({ 'Up', 5 }) },
    {
      key = 'i',
      mods = 'LEADER',
      action = act.AdjustPaneSize({ 'Right', 5 }),
    },
    -- act.ActivatePaneDirection
    -- {
    --   key = 'I',
    --   mods = 'OPT',
    --   -- https://wezfurlong.org/wezterm/config/lua/pane/get_foreground_process_info.html?h=pane
    --   action = wezterm.action_callback(function(win, pane)
    --     if_nvim(win, pane, act.SendKey({ key = 'J', mods = 'ALT' }), act.AdjustPaneSize({ 'Right', 5 }))
    --   end),
    -- },
  }
end

return module
