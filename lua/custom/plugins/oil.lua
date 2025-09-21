return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false, -- important, so Oil loads at startup
  config = function()
    -- git status helpers
    local function parse_output(proc)
      local result = proc:wait()
      if type(result) == 'number' then
        result = proc:result()
      end
      local ret = {}
      if result.code == 0 and result.stdout then
        for line in vim.gsplit(result.stdout, '\n', { plain = true, trimempty = true }) do
          line = line:gsub('/$', '')
          ret[line] = true
        end
      end
      return ret
    end

    local function new_git_status()
      return setmetatable({}, {
        __index = function(self, key)
          local ignore_proc = vim.system({
            'git',
            'ls-files',
            '--ignored',
            '--exclude-standard',
            '--others',
            '--directory',
          }, { cwd = key, text = true })

          local tracked_proc = vim.system({
            'git',
            'ls-tree',
            'HEAD',
            '--name-only',
          }, { cwd = key, text = true })

          local ret = {
            ignored = parse_output(ignore_proc),
            tracked = parse_output(tracked_proc),
          }
          rawset(self, key, ret)
          return ret
        end,
      })
    end

    local git_status = new_git_status()

    -- wrap Oil.refresh to clear cache
    local oil = require 'oil'
    local orig_refresh = oil.refresh
    oil.refresh = function(...)
      git_status = new_git_status()
      return orig_refresh(...)
    end

    local detail = false
    require('oil').setup {
      keymaps = {
        ['gi'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
            else
              require('oil').set_columns { 'icon' }
            end
          end,
        },
      },
    }

    -- setup Oil
    oil.setup {
      view_options = {
        is_hidden_file = function(name, bufnr)
          local dir = oil.get_current_dir(bufnr)
          local is_dotfile = vim.startswith(name, '.') and name ~= '..'
          if not dir then
            return is_dotfile
          end
          if is_dotfile then
            return not git_status[dir].tracked[name]
          else
            return git_status[dir].ignored[name]
          end
        end,
      },
      keymaps = {
        ['<BS>'] = { 'actions.parent', mode = 'n' },
      },
    }

    -- keymap to toggle Oil
    vim.keymap.set('n', '<leader>e', function()
      oil.toggle_float()
    end, { desc = 'Toggle Oil file explorer' })
  end,
}
