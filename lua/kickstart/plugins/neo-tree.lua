-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    default_component_configs = {
      icon = {
        folder_closed = "+",
        folder_open = "-",
        folder_empty = "+",
        folder_empty_open = "-",
        default = " ",
      },
      git_status = {
        symbols = {
          added     = "A",
          deleted   = "D",
          modified  = "M",
          renamed   = "R",
          untracked = "?",
          ignored   = "I",
          unstaged  = "U",
          staged    = "S",
          conflict  = "C",
        }
      },
    },
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['l'] = 'open',
          ['h'] = 'close_node',
        },
      },
    },
  },
}
