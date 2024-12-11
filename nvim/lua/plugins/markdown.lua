return {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter'},
    config = function()
      require('render-markdown').setup({
        sign = { enabled = false },
        heading = {
          icons = { '▶︎ ', '▷ ', '► ', '▻ ', '▸ ', '▹ ' },
        },
        checkbox = {
          unchecked = {icon = '☐'},
          checked = {icon = '✘'}
        },
      })
    end,
}
