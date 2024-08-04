vim.opt.background = 'dark'

vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 1
vim.cmd('colorscheme solarized')

vim.cmd('syntax on')

vim.opt.number = true
vim.opt.cmdheight = 2
vim.opt.showmode = true

vim.g.lightline = {
  colorscheme = 'solarized',
  active = {
    left = { {'mode', 'paste'}, {'gitbranch', 'readonly', 'absolutepath', 'modified'} }
  },
  component_function = {
    gitbranch = 'fugitive#head'
  }
}

-- VIM colors to match tmux status bar
vim.cmd('hi TabLine      gui=bold ctermfg=231 ctermbg=234 cterm=bold')
vim.cmd('hi TabLineSel   gui=none ctermfg=254 ctermbg=238 cterm=none')
vim.cmd('hi TabLineFill  gui=bold ctermfg=231 ctermbg=234 cterm=bold')
vim.cmd('hi CursorLineNR   gui=none ctermfg=238 ctermbg=232 cterm=none')
vim.cmd('hi StatusLine      gui=none ctermfg=231 ctermbg=234 cterm=bold')
vim.cmd('hi StatusLineNC    gui=bold ctermfg=231 ctermbg=234 cterm=none')
