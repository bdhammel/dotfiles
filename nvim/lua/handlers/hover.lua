local M = {}

-- Define a mapping for HTML entities
local html_entities = {
    ["&nbsp;"] = " ",
    ["&lt;"] = "<",
    ["&gt;"] = ">",
    ["&amp;"] = "&",
    ["&quot;"] = "\"",
    ["&apos;"] = "'",
}

-- Function to decode HTML entities
local function decode_html_entities(str)
    if type(str) ~= "string" then
        return str
    end
    return (str:gsub("(&[%w%#]+;)", function(entity)
        return html_entities[entity] or entity
    end))
end

M.setup = function()
  vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
    local api = vim.api
    local util = vim.lsp.util

    config = config or {}
    config.focus_id = ctx.method
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

    local contents ---@type string[]
    -- local format = 'markdown'
    -- if type(result.contents) == 'table' and result.contents.kind == 'plaintext' then
    --   format = 'plaintext'
    --   contents = vim.split(result.contents.value or '', '\n', { trimempty = true })
    -- else
    --   contents = util.convert_input_to_markdown_lines(result.contents)
    -- end
    -- contents = decode_html_entities(contents)

    format = 'plaintext'
    contents = vim.split(result.contents.value or '', '\n', { trimempty = true })

    if vim.tbl_isempty(contents) then
      if config.silent ~= true then
        vim.notify('No information available')
      end
      return
    end

    -- Open a new vertical split and set the contents
    vim.cmd('vsplit')
    local buf = api.nvim_create_buf(false, true)
    api.nvim_buf_set_lines(buf, 0, -1, false, contents)
    api.nvim_win_set_buf(0, buf)
    api.nvim_buf_set_option(buf, 'modifiable', false)

  end

end
return M
