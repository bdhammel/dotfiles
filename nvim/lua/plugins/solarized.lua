return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1000,
  ---@type solarized.config
  config = function(_, opts)
    vim.o.termguicolors = true
    vim.o.background = 'dark'
    require('solarized').setup({
      variant = 'autumn',
      on_colors = function(colors, color)
        return {
           base03 = '#000000', -- background tone dark (main)
           base02 = '#2e2e2e', -- background tone (highlight/menu/LineNr)
        }
      end,
    })
  end,
}
