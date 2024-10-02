-- Neovim settings

-- Turn off mouse support
vim.opt.mouse = ""

-- Make backspace behave more consistently across systems / ssh
vim.opt.backspace = {'indent', 'eol', 'start'}

-- Set the backup directory for swap files directory
vim.opt.swapfile = false

-- Reload files changed outside vim
vim.opt.autoread = true

-- Use system clipboard for copy-pasting
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}

vim.opt.clipboard:append({'unnamed', 'unnamedplus'})

-- Tab and indentation settings
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = false

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- keymaps
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
