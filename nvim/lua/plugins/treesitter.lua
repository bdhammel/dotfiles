-- Parsers and queries from nvim-treesitter's main branch, which supports Neovim 0.12. The
-- branch does not lazy-load, and install() skips parsers that are already installed.
-- Neovim's markdown ftplugin starts treesitter highlighting, which render-markdown and
-- codecompanion read. Other filetypes keep Vim's syntax highlighting.
return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    require('nvim-treesitter').install({
      'bash', 'cpp', 'css', 'csv', 'diff', 'dockerfile', 'git_config', 'git_rebase',
      'gitattributes', 'gitcommit', 'gitignore', 'html', 'ini', 'javascript', 'jinja',
      'json', 'lua', 'make', 'markdown', 'markdown_inline', 'python', 'requirements',
      'sql', 'ssh_config', 'textproto', 'toml', 'tsx', 'typescript', 'vimdoc', 'yaml',
    })
  end,
}
