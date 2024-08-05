return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup(
      { "fzf-native" },
      { defaults = { file_icons = false } }
    )
    vim.keymap.set("n", "<C-P>", function()
      vim.cmd('tabnew') -- Open a new tab
      require('fzf-lua').files() -- Run fzf-lua file search
    end, { desc = "Open new tab and Fzf Files" })

  end
}
