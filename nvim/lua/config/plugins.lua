-- Plugin Manager (Lazy.nvim)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    'tpope/vim-sensible',
    'altercation/vim-colors-solarized',
    'itchyny/lightline.vim',
    'christoomey/vim-tmux-navigator',
    'junegunn/fzf.vim',
    { 'ojroques/vim-oscyank', branch = 'main' },
    'tpope/vim-surround',
    'chrisbra/vim-diff-enhanced',
    'somini/pydoc.vim',
    'stephpy/vim-yaml',
    'rust-lang/rust.vim',
    'gabrielelana/vim-markdown',
    'vim-scripts/indentpython.vim',
    'dense-analysis/ale',
    { 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate" },
    -- 'github/copilot.vim',
})
