-- Toggle paste
vim.api.nvim_set_keymap('n', '<Leader>p', ':set invpaste paste?<CR>', { noremap = true, silent = true })

-- Move mappings
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true, silent = true })

-- Find merge conflict markers
vim.api.nvim_set_keymap('n', '<Leader>mc', '/\\v^[<\\|=>]{7}( .\\*\\|$)<CR>', { noremap = true, silent = true })

-- Copy with OSCYank
vim.api.nvim_set_keymap('v', '<leader>c', '<Plug>OSCYankVisual', {})

-- FZF
vim.api.nvim_set_keymap('n', '<C-P>', ':FZF<CR>', { noremap = true, silent = true })

-- ALE Toggle
vim.api.nvim_set_keymap('n', '<leader>s', ':ALEToggle<CR>', { noremap = true, silent = true })
