-- Do not start in folded mode
vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*",
  command = "normal zR",
})

-- Python specific settings
-- vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
--   pattern = '*.py',
--   callback = function()
--     vim.opt.tabstop = 4
--     vim.opt.softtabstop = 4
--     vim.opt.shiftwidth = 4
--     vim.opt.textwidth = 120
--     vim.opt.expandtab = true
--     vim.opt.autoindent = false
--     vim.opt.foldmethod = 'manual'
--     vim.opt.fileformat = 'unix'
--   end
-- })

vim.api.nvim_create_autocmd("FileType", {
  pattern = 'python',
  callback = function()
    vim.opt.wrap = false
    vim.opt.colorcolumn = table.concat(vim.fn.range(120,999), ",")
  end
})
