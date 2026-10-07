return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  config = function()
    -- calling `setup` is optional for customization
    require('fzf-lua').setup({'fzf-vim'})

    -- Function to determine the Git root directory
    local function get_git_root()
      local handle = io.popen("git rev-parse --show-toplevel 2>/dev/null")
      local result = handle and handle:read("*a") or ""
      if handle then handle:close() end
      result = result:gsub("\n", "") -- Trim newline
      return result ~= "" and result or "~/dev"
    end

    vim.keymap.set("n", "<c-P>", function()
      vim.cmd('tabnew') -- Open a new tab
      local software_home = get_git_root() -- Determine software_home dynamically
      require('fzf-lua').files({ cwd = software_home })
    end, { desc = "Fzf Files" })
  end
}
