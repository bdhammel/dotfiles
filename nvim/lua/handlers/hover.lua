local M = {}

local function is_blank_line(line)
  return line:match("^%s*$") ~= nil
end

local function is_separator_line(line)
  return line:match("^%-%-%-$") ~= nil
end

local function collapse_blank_lines(contents)
  local collapsed = {}
  local l = 1
  while l <= #contents do
    local line = contents[l]
    if is_blank_line(line) then
      while l + 1 <= #contents and is_blank_line(contents[l + 1]) do
        l = l + 1
      end
    end
    table.insert(collapsed, line)
    l = l + 1
  end
  return collapsed
end

local function replace_separators(contents, divider)
  local trimmed = {}
  local l = 1
  while l <= #contents do
    local line = contents[l]
    if is_separator_line(line) then
      if l > 1 and is_blank_line(contents[l - 1]) then
        table.remove(trimmed)
      end
      table.insert(trimmed, divider)
      if l + 1 <= #contents and is_blank_line(contents[l + 1]) then
        l = l + 1
      end
    else
      table.insert(trimmed, line)
    end
    l = l + 1
  end
  return trimmed
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
      contents = vim.split(table.concat(contents, '\n'):gsub('\r', ''), '\n', { trimempty = true })

      -- 2. Successive empty lines are collapsed into a single empty line
      contents = collapse_blank_lines(contents)

      -- 3. Thematic breaks are expanded to the given width
      local divider = string.rep('─', config.width or 80)
      contents = replace_separators(contents, divider)

      vim.bo[buf].filetype = 'markdown'
      api.nvim_buf_set_lines(buf, 0, -1, false, contents)
      vim.treesitter.start(buf)
    else
      -- Clean up input: trim empty lines
      contents = vim.split(table.concat(contents, '\n'), '\n', { trimempty = true })

      if format then
        vim.bo[buf].syntax = format
      end
      api.nvim_buf_set_lines(buf, 0, -1, true, contents)
    end
    api.nvim_win_set_buf(0, buf)
  end
end

return M
