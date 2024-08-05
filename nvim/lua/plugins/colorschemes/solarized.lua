return {
  'maxmx03/solarized.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('solarized').setup({
      transparent = false,
      palette = 'solarized',
      colors = function(colors, colorhelper)
        return {
          base03 = '#000000', -- background tone dark (main)
          base02 = '#2e2e2e', -- background tone (highlight/menu/LineNr)
        }
      end,
    })

    vim.o.background = 'dark'
    vim.cmd.colorscheme 'solarized'
    vim.g.lightline = {
      colorscheme = 'selenized_black'
    }

  end
}
