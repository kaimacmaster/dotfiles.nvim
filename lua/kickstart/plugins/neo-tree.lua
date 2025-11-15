-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

-- Use backtick on macOS, backslash on other systems
local tree_key = vim.fn.has('mac') == 1 and '`' or '\\'

-- Define keys table with conditional § key for macOS
local keys = {
  { tree_key, ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
}

-- Add § key for macOS
if vim.fn.has('mac') == 1 then
  table.insert(keys, { '§', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true })
end

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = keys,
  opts = {
    default_component_configs = {
      icon = {
        folder_closed = '+',
        folder_open = '-',
        folder_empty = '+',
        folder_empty_open = '-',
        default = ' ',
      },
      git_status = {
        symbols = {
          added = 'A',
          deleted = 'D',
          modified = 'M',
          renamed = 'R',
          untracked = '?',
          ignored = 'I',
          unstaged = 'U',
          staged = 'S',
          conflict = 'C',
        },
      },
    },
    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          'node_modules',
          '.DS_Store',
        },
        always_show = { -- remains visible even if other settings would normally hide it
          '.gitignore',
        },
        always_show_by_pattern = { -- uses glob style patterns
          '.env*',
        },
      },
      window = {
        mappings = vim.tbl_extend('force', {
          [tree_key] = 'close_window',
          ['l'] = 'open',
          ['h'] = 'close_node',
        }, vim.fn.has('mac') == 1 and { ['§'] = 'close_window' } or {}),
      },
    },
  },
}
