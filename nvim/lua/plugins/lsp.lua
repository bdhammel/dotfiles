return {
  {
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v4.x',
      lazy = true,
      config = false,
    },
    {
      'williamboman/mason.nvim',
      lazy = false,
      config = true,
    },

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      event = 'InsertEnter',
      dependencies = {
        {'L3MON4D3/LuaSnip'},
      },
      config = function()
        local cmp = require('cmp')

        cmp.setup({
          sources = {
            {name = 'nvim_lsp'},
          },
          window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
          },
          completion = {
            autocomplete = false
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<CR>'] = cmp.mapping.confirm({select = false}),
          }),
          snippet = {
            expand = function(args)
              vim.snippet.expand(args.body)
            end,
          },
        })
      end
    },

    -- LSP
    {
      'neovim/nvim-lspconfig',
      cmd = {'LspInfo', 'LspInstall', 'LspStart'},
      event = {'BufReadPre', 'BufNewFile'},
      dependencies = {
        {'hrsh7th/cmp-nvim-lsp'},
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
      },
      config = function()
        local lsp_zero = require('lsp-zero')

        require('handlers.hover').setup()

        -- lsp_attach is where you enable features that only work
        -- if there is a language server active in the file
        local lsp_attach = function(client, bufnr)
          local opts = {buffer = bufnr}

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
        end

        lsp_zero.extend_lspconfig({
          sign_text = true,
          lsp_attach = lsp_attach,
          capabilities = require('cmp_nvim_lsp').default_capabilities()
        })

        require('mason').setup({})

        require('mason-lspconfig').setup({
          ensure_installed = {
            'basedpyright', 'ruff', 'pyright', 'bashls', 'lua_ls', 'yamlls', 'jsonls', 'rust_analyzer',
          }
        })

        require('mason-lspconfig').setup_handlers({

          require('lspconfig').bashls.setup({}),
          require('lspconfig').yamlls.setup({}),
          require('lspconfig').jsonls.setup({}),

          require('lspconfig').lua_ls.setup({
            settings = {
              Lua = {
                diagnostics = {
                  globals = { 'vim' }
                }
              }
            }
          }),

          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client == nil then
                return
              end
              if client.name == 'ruff' then
                -- Disable hover in favor of Pyright
                client.server_capabilities.hoverProvider = false
              end
            end,
            desc = 'LSP: Disable hover capability from Ruff',
          }),

          -- require('lspconfig').ruff.setup({
          --   init_options = {
          --     settings = {
          --       args = {},
          --     }
          --   }
          -- }),

          require('lspconfig').pyright.setup({
            settings = {
              pright = {
                disableOrganizeImports = true,
                disableTaggedHints = true,
              },
              python = {
                -- pythonPath = '/opt/sambanova/bin/python',
                analysis = {
                  -- Ignore all files for analysis to exclusively use Ruff for linting
                  typeCheckingMode = "basic",
                  diagnosticMode = "workspace",
                  diagnosticSeverityOverrides = {
                      reportUnusedImport = "none",
                      reportUnusedClass = "none",
                      reportUnusedFunction = "none",
                      reportUnusedVariable = "none",
                  }
                  -- diagnosticSeverityOverrides = {
                  --   reportUnusedVariable = "none",
                  -- }
                  -- ignore = { '*' },
                  -- autoSearchPaths = true,
                  -- -- typeCheckingMode = "off",
                  -- -- diagnosticMode = "workspace",
                  -- -- useLibraryCodeForTypes = true,
                  -- diagnosticSeverityOverrides = {
                  --     reportUnusedImport = "none",
                  --     reportUnusedClass = "none",
                  --     reportUnusedFunction = "none",
                  --     reportUnusedVariable = "none",
                  -- }
                },
              }
            }
          }),
        })
      end
    }
  }
}
