return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = {
    -- Lazy load when buffer open existing or non-existent file.
    "BufReadPre",
    "BufNewFile"
  },
  build = ":TSUpdate",
  opts = {
    ensure_installed = {
      "cpp", "json", "markdown", "markdown_inline", "yaml", "diff", "git_rebase",
      "gitcommit", "bash", "javascript", "python", "lua", "html", "css",
    },
    sync_install = false,
    auto_install = true,
  },
}
