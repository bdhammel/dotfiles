return {
  'nvim-treesitter/nvim-treesitter',
  lazy = true,
  event = {
    -- Lazy load when buffer open existing or non-existent file.
    "BufReadPre",
    "BufNewFile"
  },
  build = ":TSUpdate",

  -- Neovim 0.12 compatibility shim. Delete this once nvim-treesitter moves to
  -- its `main` branch; the `master` branch README says 0.12 is not supported.
  --
  -- Query predicate and directive handlers used to receive one TSNode per
  -- capture. Neovim 0.11 changed that to a list of nodes and added an
  -- `all = false` opt-out. Neovim 0.12 removed the opt-out, so handlers always
  -- get TSNode[]. nvim-treesitter master still registers six handlers with
  -- `all = false` and calls node:range() on the result, which errors on a list.
  --
  -- Markdown hits it on every fenced code block through
  -- `#set-lang-from-info-string!` in queries/markdown/injections.scm.
  --
  -- Fix: intercept registration, and hand any handler that asked for
  -- `all = false` the last node per capture, which is what Neovim used to do.
  init = function()
    local tsq = vim.treesitter.query

    local function unwrap(handler)
      return function(match, ...)
        local single = {}
        for id, nodes in pairs(match) do
          single[id] = type(nodes) == 'table' and nodes[#nodes] or nodes
        end
        return handler(single, ...)
      end
    end

    for _, register in ipairs({ 'add_predicate', 'add_directive' }) do
      local orig = tsq[register]
      tsq[register] = function(name, handler, opts)
        if type(opts) == 'table' and opts.all == false then
          handler = unwrap(handler)
        end
        return orig(name, handler, opts)
      end
    end
  end,

  opts = {
    ensure_installed = {
      "cpp", "json", "markdown", "markdown_inline", "yaml", "diff", "git_rebase",
      "gitcommit", "bash", "javascript", "python", "lua", "html", "css",
    },
    sync_install = false,
    auto_install = true,
  },
}
