return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v2.x',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},     -- Required
    {'hrsh7th/cmp-nvim-lsp'}, -- Required
    {'L3MON4D3/LuaSnip'},     -- Required
  },
  config = function()
    local lsp = require('lsp-zero').preset({})
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp = require('cmp')

    mason.setup()

    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "pyright",
        'jsonls',
        'yamlls',
      },
    })

    cmp.setup({
      sources = {
        {name = 'nvim_lsp'},
      },
      snippet = {
        expand = function(args)
          vim.snippet.expand(args.body)
        end,
      },
      completion = {
        autocomplete = false
      },
      cmp.mapping.preset.insert({
        ['<C-Space>'] = cmp.mapping.complete(),
      }),
      window = {
        documentation = cmp.config.window.bordered(),
      },
    })

    lsp.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      lsp.default_keymaps({buffer = bufnr})
    end)

    -- (Optional) Configure lua language server for neovim
    require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

    lsp.setup()
  end
}
