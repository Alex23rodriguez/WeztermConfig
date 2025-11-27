local wezterm = require('wezterm')
local resurrect = wezterm.plugin.require('https://github.com/MLFlexer/resurrect.wezterm')

local module = {}

function module.apply_to_config(config)
  config.keys = {
    -- {
    --   key = "w",
    --   mods = "ALT",
    --   action = wezterm.action_callback(function(win, pane)
    --       resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
    --     end),
    -- },
    -- {
    --   key = "W",
    --   mods = "ALT",
    --   action = resurrect.window_state.save_window_action(),
    -- },
    -- {
    --   key = "T",
    --   mods = "ALT",
    --   action = resurrect.tab_state.save_tab_action(),
    -- },
    -- SAVE STATE
    {
      key = 'S',
      mods = 'CMD',
      action = wezterm.action.PromptInputLine({
        description = 'Enter session name',
        action = wezterm.action_callback(function(window, pane, name)
          resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state(), name)
          resurrect.window_state.save_window_action()
        end),
      }),
    },
    -- RESTORE STATE
    {
      key = 'R',
      mods = 'CMD',
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
          local type = string.match(id, '^([^/]+)') -- match before '/'
          id = string.match(id, '([^/]+)$') -- match after '/'
          id = string.match(id, '(.+)%..+$') -- remove file extention
          local opts = {
            relative = true,
            restore_text = true,
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
          }
          if type == 'workspace' then
            local state = resurrect.state_manager.load_state(id, 'workspace')
            resurrect.workspace_state.restore_workspace(state, opts)
          elseif type == 'window' then
            local state = resurrect.state_manager.load_state(id, 'window')
            resurrect.window_state.restore_window(pane:window(), state, opts)
          elseif type == 'tab' then
            local state = resurrect.state_manager.load_state(id, 'tab')
            resurrect.tab_state.restore_tab(pane:tab(), state, opts)
          end
        end)
      end),
    },
    -- DELETE STATE
    {
      key = 'D',
      mods = 'CMD',
      action = wezterm.action_callback(function(win, pane)
        resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
          resurrect.state_manager.delete_state(id)
        end, {
          title = 'Delete State',
          description = 'Select State to Delete and press Enter = accept, Esc = cancel, / = filter',
          fuzzy_description = 'Search Session to Delete: ',
          is_fuzzy = true,
        })
      end),
    },
  }
end

return module
