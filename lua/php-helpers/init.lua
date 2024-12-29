vim.api.nvim_create_user_command('PHPSplitArrayComment', function()
  local function split_array_comment()
    local start_line, end_line = vim.fn.line("'<"), vim.fn.line("'>")
    local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
    local result = {}

    for _, line in ipairs(lines) do
      if line:match("array{") then
        table.insert(result, line:gsub("array{(.*)}", "array{"))
        for item in line:gmatch("array{(.*)}")() :gmatch("[^,]+") do
          table.insert(result, "    " .. item:match("^%s*(.-)%s*$") .. ",")
        end
        table.insert(result, "}")
      else
        table.insert(result, line)
      end
    end

    vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, result)
  end

  split_array_comment()
end, { range = true })
