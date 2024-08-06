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

        -- vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
        --   if err or not result or not result.contents then
        --     print('No hover information available')
        --     return
        --   end

        --   -- Open a new split window
        --   vim.cmd('split')
        --   local buf = vim.api.nvim_create_buf(false, true)

        --   local format = 'markdown'
        --   local contents ---@type string[]
        --   if type(result.contents) == 'table' and result.contents.kind == 'plaintext' then
        --     format = 'plaintext'
        --     contents = vim.split(result.contents.value or '', '\n', { trimempty = true })
        --   else
        --     contents = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        --   end
        --   if vim.tbl_isempty(contents) then
        --     if config.silent ~= true then
        --       vim.notify('No information available')
        --     end
        --     return
        --   end

        --   markdown_lines = vim.lsp.util.stylize_markdown(buf, contents)
        --   vim.api.nvim_buf_set_lines(buf, 0, -1, false, markdown_lines)
        --   vim.api.nvim_win_set_buf(0, buf)
        --   vim.api.nvim_buf_set_option(buf, 'modifiable', false)
        -- end
        require('handlers.hover').setup()


        -- lsp_attach is where you enable features that only work
        -- if there is a language server active in the file
        local lsp_attach = function(client, bufnr)
          local opts = {buffer = bufnr}

          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
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

        require('mason-lspconfig').setup({
          ensure_installed = {},
          handlers = {
            -- this first function is the "default handler"
            -- it applies to every language server without a "custom handler"
            function(server_name)
              require('lspconfig')[server_name].setup({})
            end,
          }
        })
      end
    }
  }
}
