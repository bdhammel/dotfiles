-- Do not start in folded mode
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  command = "normal zR",
})

-- TextYankPost for OSCYank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
      vim.cmd('OSCYankRegister +')
    end
  end
})

-- FileType help opens in vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = 'help',
  command = 'wincmd L',
})

-- Set tab width for specific file types
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = {'*.js', '*.html', '*.css', '*.json', '*.yaml', '*.yml'},
  callback = function()
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.shiftwidth = 2
  end
})

-- Python specific settings
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = '*.py',
  callback = function()
    vim.opt.tabstop = 4
    vim.opt.softtabstop = 4
    vim.opt.shiftwidth = 4
    vim.opt.textwidth = 120
    vim.opt.expandtab = true
    vim.opt.autoindent = true
    vim.opt.foldmethod = 'manual'
    vim.opt.fileformat = 'unix'
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = 'python',
  callback = function()
    vim.opt.wrap = false
    vim.opt.colorcolumn = table.concat(vim.fn.range(120,999), ",")
  end
})
