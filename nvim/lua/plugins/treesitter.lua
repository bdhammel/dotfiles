return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
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
                "gitcommit", "bash", "javascript", "python", "lua",
            },
            sync_install = false,
            auto_install = true,
            indent = {
                enable = true,
            },
        })
    end,
}
