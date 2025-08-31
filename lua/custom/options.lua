-- Basic Neovim options
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable nerd font icons
vim.g.have_nerd_font = false

-- Basic options
vim.o.number = true
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.confirm = true

-- Indentation settings
vim.o.expandtab = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smartindent = true

-- Check if clipboard-provider is executable
if vim.fn.executable 'clipboard-provider' then
  -- Set clipboard configuration
  vim.g.clipboard = {
    name = 'myClipboard',
    copy = {
      ['+'] = 'clipboard-provider copy',
      ['*'] = 'clipboard-provider copy',
    },
    paste = {
      ['+'] = 'clipboard-provider paste',
      ['*'] = 'clipboard-provider paste',
    },
  }
end

if vim.fn.has 'wsl' == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = function()
        return vim.fn.systemlist "powershell.exe -Command Get-Clipboard | tr -d '\r'"
      end,
      ['*'] = function()
        return vim.fn.systemlist "powershell.exe -Command Get-Clipboard | tr -d '\r'"
      end,
    },
    cache_enabled = 0,
  }
end
