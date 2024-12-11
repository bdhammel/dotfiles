return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = {
    -- Lazy load when buffer open existing or non-existent file.
    "BufReadPre",
    "BufNewFile"
  },
  build = function()
    require("nvim-treesitter.install").update({ with_sync = true })()
  end,
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = {
        "cpp", "json", "markdown", "markdown_inline", "yaml", "diff", "git_rebase",
        "gitcommit", "bash", "javascript", "python", "lua", "html", "css",
      },
      sync_install = false,
      auto_install = true,
      highlight = {
        enable = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "vs",
          node_incremental = "vn",
          scope_incremental = "vs",
          node_decremental = "vb",
        },
      },
    })
  end,
}
