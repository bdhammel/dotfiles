vim.cmd('syntax on')

vim.g.netrw_banner = 0

vim.opt.number = true
vim.opt.cmdheight = 2
vim.opt.textwidth = 0
vim.opt.wrapmargin = 0
vim.opt.wrap = true
vim.opt.linebreak = true

vim.opt.spelllang = 'en_us'
vim.opt.spell = true
-- Words added with zg go into this repo, not stdpath('data'), so they reach a new machine.
vim.opt.spellfile = vim.fn.stdpath('config') .. '/spell/en.utf-8.add'

vim.cmd.colorscheme 'visual_studio_code'
vim.g.lightline = {
  colorscheme = 'selenized_black'
}

-- vim.cmd.colorscheme 'github_dark_colorblind'
-- vim.cmd.colorscheme 'nightfox'

