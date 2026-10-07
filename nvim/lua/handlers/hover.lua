local M = {}

local vim = vim 

local html_entities = {
    ["&nbsp;"] = " ",
    ["&lt;"] = "<",
    ["&gt;"] = ">",
    ["&amp;"] = "&",
    ["&quot;"] = "\"",
    ["&apos;"] = "'",
}

-- Function to replace HTML entities
local function replace_html_entities(str)
    return (str:gsub("(&%w+;)", html_entities))
end


M.setup = function()
  vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    config = config or {}  -- Ensure config is not nil
    local api = vim.api

    if api.nvim_get_current_buf() ~= ctx.bufnr then
      -- Ignore result since buffer changed. This happens for slow language servers.
      return
    end

    if not (result and result.contents) then
      if config.silent ~= true then
        vim.notify('No information available')
      end
      return
    end

    local format = 'markdown'
    local contents ---@type string[]
    if type(result.contents) == 'table' and result.contents.kind == 'plaintext' then
      format = 'plaintext'
      contents = vim.split(result.contents.value or '', '\n', { trimempty = true })
    else
      contents = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
      contents = vim.lsp.util.trim_empty_lines(contents)
    end

    if vim.tbl_isempty(contents) then
      if config.silent ~= true then
        vim.notify('No information available')
      end
      return
    end

    -- Open a new split window
    vim.cmd('split')

    local buf = api.nvim_create_buf(false, true)

    -- Set up the contents, using treesitter for markdown
    local do_stylize = format == 'markdown' and vim.g.syntax_on ~= nil
    if do_stylize then
      -- Original line with added HTML entity substitution
      contents = vim.split(table.concat(contents, '\n'):gsub('\r', ''):gsub("(&%w+;)", replace_html_entities), '\n', { trimempty = true })

      vim.bo[buf].filetype = 'markdown'
      api.nvim_buf_set_lines(buf, 0, -1, false, contents)
      vim.treesitter.start(buf, 'markdown')
    else
      -- Clean up input: trim empty lines
      contents = vim.split(table.concat(contents, '\n'), '\n', { trimempty = true })

      if format then
        vim.bo[buf].syntax = format
      end
      api.nvim_buf_set_lines(buf, 0, -1, true, contents)
    end
    api.nvim_win_set_buf(0, buf)

    -- Set buffer options
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = 'wipe'
  end

end

return M
