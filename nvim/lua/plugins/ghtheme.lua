return {
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins

  config = function()
    local palettes = {
      -- Everything defined under `all` will be applied to each style.
      all = {
        bg0 = "#000000", -- Black background
      }
    }
    require("github-theme").setup({ palettes = palettes })
  end,
}
