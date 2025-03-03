-- Do not start in folded mode
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  command = "normal zR",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = 'python',
  callback = function()
    vim.opt.wrap = false
    vim.opt.textwidth = 100
    vim.opt.colorcolumn = table.concat(vim.fn.range(100,999), ",")
    vim.cmd("highlight ColorColumn ctermbg=DarkGrey")
  end
})
