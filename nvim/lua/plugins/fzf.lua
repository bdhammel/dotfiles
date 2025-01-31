return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup(
      { "fzf-native" },
      { defaults = { file_icons = false } }
    )
    vim.keymap.set("n", "<c-P>", function()
      vim.cmd('tabnew') -- Open a new tab
      local software_home = os.getenv("SOFTWARE_HOME")
      if not software_home or software_home == "" then
        software_home = "~/Documents" -- default location
      end
      require('fzf-lua').files({ cwd=software_home })
    end, { desc = "Fzf Files" })
  end
}
