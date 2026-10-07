return {
  "EdenEast/nightfox.nvim",

  config = function()
    local palettes = {
      -- Everything defined under `all` will be applied to each style.
      all = {
        bg1 = "#000000", -- Black background
        -- fg1 = "#000000" -- "#c7c7c7", -- grey
        white = "#c7c7c7"
      },
      duskfox = {
        -- bg1 = "#000000", -- Black background
        -- fg1 = "#000000", -- Black background
        -- bg0 = "#1d1d2b", -- Alt backgrounds (floats, statusline, ...)
        -- bg3 = "#121820", -- 55% darkened from stock
        -- sel0 = "#131b24", -- 55% darkened from stock
      },
    }

    local specs = {
      -- As with palettes, the values defined under `all` will be applied to every style.
      all = {
        syntax = {
          -- variable = "#FFA07A",
        }
      }
    }

    require("nightfox").setup({ palettes = palettes, specs = specs })

    vim.g.lightline = { colorscheme = "nightfox" }
  end,
}
