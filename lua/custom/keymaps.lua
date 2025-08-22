-- Basic keymaps
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Window navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Move lines up/down with Alt+j/k (works on Linux and Windows)
vim.keymap.set({ 'n', 'v' }, '<M-j>', ':m .+1<CR>==', { desc = 'Move line down', silent = true })
vim.keymap.set({ 'n', 'v' }, '<M-k:>', ':m .-2<CR>==', { desc = 'Move line up', silent = true })
vim.keymap.set('i', '<M-j>', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down', silent = true })
vim.keymap.set('i', '<M-k>', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up', silent = true })

-- Move lines up/down with Alt+j/k (works on macOS)
vim.keymap.set({ 'n', 'v' }, '∆', ':m .+1<CR>==', { desc = 'Move line down', silent = true })
vim.keymap.set({ 'n', 'v' }, '˚', ':m .-2<CR>==', { desc = 'Move line up', silent = true })
vim.keymap.set('i', '∆', '<Esc>:m .+1<CR>==gi', { desc = 'Move line down', silent = true })
vim.keymap.set('i', '˚', '<Esc>:m .-2<CR>==gi', { desc = 'Move line up', silent = true })

-- System clipboard keybindings
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to system clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from system clipboard' })
vim.keymap.set('n', '<leader>my', function()
  vim.fn.setreg('+', vim.fn.execute('messages'))
end, { desc = 'Yank messages to system clipboard' })

-- Window resizing with arrow keys
vim.keymap.set('n', '<Left>', '<C-w><', { desc = 'Decrease window width', silent = true })
vim.keymap.set('n', '<Right>', '<C-w>>', { desc = 'Increase window width', silent = true })
