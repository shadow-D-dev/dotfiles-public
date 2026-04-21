-- ============================================================================
--  Markdown
-- ============================================================================

-----------------Select text inside codeblocks lamw26wmal----------------------

-- Select everything between the opening ```<lang> and the closing ``` fences
vim.keymap.set("n", "vio", function()
  -- Find opening fence above cursor
  local cur = vim.fn.line(".")
  local open = nil
  for l = cur, 1, -1 do
    if vim.fn.getline(l):match("^%s*```%S+") then
      open = l
      break
    end
  end
  if not open then
    print("No opening ```<lang> fence found")
    return
  end
  -- Find closing fence below the opening one
  local close = nil
  for l = open + 1, vim.fn.line("$") do
    if vim.fn.getline(l):match("^%s*```%s*$") then
      close = l
      break
    end
  end
  if not close then
    print("No closing ``` fence found")
    return
  end
  if close - open <= 1 then
    print("Code-block is empty")
    return
  end
  -- Visual-select lines open+1 .. close-1
  vim.cmd(("normal! %dGV%dG"):format(open + 1, close - 1))
end, { desc = "[P]Select inside fenced code-block" })
-- Mappings for creating new groups that don't exist
-- When I press leader, I want to modify the name of the options shown
-- "m" is for "markdown" and "t" is for "todo"
local wk = require("which-key")
wk.add({
  {
    mode = { "n" },
    { "<leader>t", group = "[P]todo" },
  },
  {
    mode = { "n", "v" },
    { "<leader>m", group = "[P]markdown" },
    { "<leader>mp", group = "[P]fold" },
    { "<leader>mh", group = "[P]headings increase/decrease" },
    { "<leader>ml", group = "[P]links" },
    { "<leader>ms", group = "[P]spell" },
    { "<leader>msl", group = "[P]language" },
  },
})

-- Toggle bullet point at the beginning of the current line in normal mode
-- If in a multiline paragraph, make sure the cursor is on the line at the top
-- "d" is for "dash" lamw25wmal
vim.keymap.set("n", "<leader>md", function()
  -- Get the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_buffer = vim.api.nvim_get_current_buf()
  local start_row = cursor_pos[1] - 1
  local col = cursor_pos[2]
  -- Get the current line
  local line = vim.api.nvim_buf_get_lines(current_buffer, start_row, start_row + 1, false)[1]
  -- Check if the line already starts with a bullet point
  if line:match("^%s*%-") then
    -- Remove the bullet point from the start of the line
    line = line:gsub("^%s*%-", "")
    vim.api.nvim_buf_set_lines(current_buffer, start_row, start_row + 1, false, { line })
    return
  end
  -- Search for newline to the left of the cursor position
  local left_text = line:sub(1, col)
  local bullet_start = left_text:reverse():find("\n")
  if bullet_start then
    bullet_start = col - bullet_start
  end
  -- Search for newline to the right of the cursor position and in following lines
  local right_text = line:sub(col + 1)
  local bullet_end = right_text:find("\n")
  local end_row = start_row
  while not bullet_end and end_row < vim.api.nvim_buf_line_count(current_buffer) - 1 do
    end_row = end_row + 1
    local next_line = vim.api.nvim_buf_get_lines(current_buffer, end_row, end_row + 1, false)[1]
    if next_line == "" then
      break
    end
    right_text = right_text .. "\n" .. next_line
    bullet_end = right_text:find("\n")
  end
  if bullet_end then
    bullet_end = col + bullet_end
  end
  -- Extract lines
  local text_lines = vim.api.nvim_buf_get_lines(current_buffer, start_row, end_row + 1, false)
  local text = table.concat(text_lines, "\n")
  -- Add bullet point at the start of the text
  local new_text = "- " .. text
  local new_lines = vim.split(new_text, "\n")
  -- Set new lines in buffer
  vim.api.nvim_buf_set_lines(current_buffer, start_row, end_row + 1, false, new_lines)
end, { desc = "[P]Toggle bullet point (dash)" })
-- HACK: Manage Markdown tasks in Neovim similar to Obsidian | Telescope to List Completed and Pending Tasks
-- https://youtu.be/59hvZl077hM
--
-- If there is no `untoggled` or `done` label on an item, mark it as done
-- and move it to the "## completed tasks" markdown heading in the same file, if
-- the heading does not exist, it will be created, if it exists, items will be
-- appended to it at the top lamw25wmal
--
-- If an item is moved to that heading, it will be added the `done` label
vim.keymap.set("n", "<M-x>", function()
  -- Customizable variables
  -- NOTE: Customize the completion label
  local label_done = "done:"
  -- NOTE: Customize the timestamp format
  local timestamp = os.date("%y%m%d-%H%M")
  -- local timestamp = os.date("%y%m%d")
  -- NOTE: Customize the heading and its level
  local tasks_heading = "## Completed tasks"
  -- Save the view to preserve folds
  vim.cmd("mkview")
  local api = vim.api
  -- Retrieve buffer & lines
  local buf = api.nvim_get_current_buf()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local start_line = cursor_pos[1] - 1
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local total_lines = #lines
  -- If cursor is beyond last line, do nothing
  if start_line >= total_lines then
    vim.cmd("loadview")
    return
  end
  ------------------------------------------------------------------------------
  -- (A) Move upwards to find the bullet line (if user is somewhere in the chunk)
  ------------------------------------------------------------------------------
  while start_line > 0 do
    local line_text = lines[start_line + 1]
    -- Stop if we find a blank line or a bullet line
    if line_text == "" or line_text:match("^%s*%-") then
      break
    end
    start_line = start_line - 1
  end
  -- Now we might be on a blank line or a bullet line
  if lines[start_line + 1] == "" and start_line < (total_lines - 1) then
    start_line = start_line + 1
  end
  ------------------------------------------------------------------------------
  -- (B) Validate that it's actually a task bullet, i.e. '- [ ]' or '- [x]'
  ------------------------------------------------------------------------------
  local bullet_line = lines[start_line + 1]
  if not bullet_line:match("^%s*%- %[[x ]%]") then
    -- Not a task bullet => show a message and return
    print("Not a task bullet: no action taken.")
    vim.cmd("loadview")
    return
  end
  ------------------------------------------------------------------------------
  -- 1. Identify the chunk boundaries
  ------------------------------------------------------------------------------
  local chunk_start = start_line
  local chunk_end = start_line
  while chunk_end + 1 < total_lines do
    local next_line = lines[chunk_end + 2]
    if next_line == "" or next_line:match("^%s*%-") then
      break
    end
    chunk_end = chunk_end + 1
  end
  -- Collect the chunk lines
  local chunk = {}
  for i = chunk_start, chunk_end do
    table.insert(chunk, lines[i + 1])
  end
  ------------------------------------------------------------------------------
  -- 2. Check if chunk has [done: ...] or [untoggled], then transform them
  ------------------------------------------------------------------------------
  local has_done_index = nil
  local has_untoggled_index = nil
  for i, line in ipairs(chunk) do
    -- Replace `[done: ...]` -> `` `done: ...` ``
    chunk[i] = line:gsub("%[done:([^%]]+)%]", "`" .. label_done .. "%1`")
    -- Replace `[untoggled]` -> `` `untoggled` ``
    chunk[i] = chunk[i]:gsub("%[untoggled%]", "`untoggled`")
    if chunk[i]:match("`" .. label_done .. ".-`") then
      has_done_index = i
      break
    end
  end
  if not has_done_index then
    for i, line in ipairs(chunk) do
      if line:match("`untoggled`") then
        has_untoggled_index = i
        break
      end
    end
  end
  ------------------------------------------------------------------------------
  -- 3. Helpers to toggle bullet
  ------------------------------------------------------------------------------
  -- Convert '- [ ]' to '- [x]'
  local function bulletToX(line)
    return line:gsub("^(%s*%- )%[%s*%]", "%1[x]")
  end
  -- Convert '- [x]' to '- [ ]'
  local function bulletToBlank(line)
    return line:gsub("^(%s*%- )%[x%]", "%1[ ]")
  end
  ------------------------------------------------------------------------------
  -- 4. Insert or remove label *after* the bracket
  ------------------------------------------------------------------------------
  local function insertLabelAfterBracket(line, label)
    local prefix = line:match("^(%s*%- %[[x ]%])")
    if not prefix then
      return line
    end
    local rest = line:sub(#prefix + 1)
    return prefix .. " " .. label .. rest
  end
  local function removeLabel(line)
    -- If there's a label (like `` `done: ...` `` or `` `untoggled` ``) right after
    -- '- [x]' or '- [ ]', remove it
    return line:gsub("^(%s*%- %[[x ]%])%s+`.-`", "%1")
  end
  ------------------------------------------------------------------------------
  -- 5. Update the buffer with new chunk lines (in place)
  ------------------------------------------------------------------------------
  local function updateBufferWithChunk(new_chunk)
    for idx = chunk_start, chunk_end do
      lines[idx + 1] = new_chunk[idx - chunk_start + 1]
    end
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end
  ------------------------------------------------------------------------------
  -- 6. Main toggle logic
  ------------------------------------------------------------------------------
  if has_done_index then
    chunk[has_done_index] = removeLabel(chunk[has_done_index]):gsub("`" .. label_done .. ".-`", "`untoggled`")
    chunk[1] = bulletToBlank(chunk[1])
    chunk[1] = removeLabel(chunk[1])
    chunk[1] = insertLabelAfterBracket(chunk[1], "`untoggled`")
    updateBufferWithChunk(chunk)
    vim.notify("Untoggled", vim.log.levels.INFO)
  elseif has_untoggled_index then
    chunk[has_untoggled_index] =
      removeLabel(chunk[has_untoggled_index]):gsub("`untoggled`", "`" .. label_done .. " " .. timestamp .. "`")
    chunk[1] = bulletToX(chunk[1])
    chunk[1] = removeLabel(chunk[1])
    chunk[1] = insertLabelAfterBracket(chunk[1], "`" .. label_done .. " " .. timestamp .. "`")
    updateBufferWithChunk(chunk)
    vim.notify("Completed", vim.log.levels.INFO)
  else
    -- Save original window view before modifications
    local win = api.nvim_get_current_win()
    local view = api.nvim_win_call(win, function()
      return vim.fn.winsaveview()
    end)
    chunk[1] = bulletToX(chunk[1])
    chunk[1] = insertLabelAfterBracket(chunk[1], "`" .. label_done .. " " .. timestamp .. "`")
    -- Remove chunk from the original lines
    for i = chunk_end, chunk_start, -1 do
      table.remove(lines, i + 1)
    end
    -- Append chunk under 'tasks_heading'
    local heading_index = nil
    for i, line in ipairs(lines) do
      if line:match("^" .. tasks_heading) then
        heading_index = i
        break
      end
    end
    if heading_index then
      for _, cLine in ipairs(chunk) do
        table.insert(lines, heading_index + 1, cLine)
        heading_index = heading_index + 1
      end
      -- Remove any blank line right after newly inserted chunk
      local after_last_item = heading_index + 1
      if lines[after_last_item] == "" then
        table.remove(lines, after_last_item)
      end
    else
      table.insert(lines, tasks_heading)
      for _, cLine in ipairs(chunk) do
        table.insert(lines, cLine)
      end
      local after_last_item = #lines + 1
      if lines[after_last_item] == "" then
        table.remove(lines, after_last_item)
      end
    end
    -- Update buffer content
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.notify("Completed", vim.log.levels.INFO)
    -- Restore window view to preserve scroll position
    api.nvim_win_call(win, function()
      vim.fn.winrestview(view)
    end)
  end
  -- Write changes and restore view to preserve folds
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  vim.cmd("loadview")
end, { desc = "[P]Toggle task and move it to 'done'" })

-- This surrounds CURRENT WORD with inline code in NORMAL MODE lamw25wmal
vim.keymap.set("n", "gss", function()
  -- Use nvim_replace_termcodes to handle special characters like backticks
  local keys = vim.api.nvim_replace_termcodes("gsaiw`", true, false, true)
  -- Feed the keys in visual mode ('x' for visual mode)
  vim.api.nvim_feedkeys(keys, "x", false)
  -- I tried these 3, but they didn't work, I assume because of the backtick character
  -- vim.cmd("normal! gsa`")
  -- vim.cmd([[normal! gsa`]])
  -- vim.cmd("normal! gsa\\`")
end, { desc = "[P] Surround selection with backticks (inline code)" })
-- This surrounds with inline code, that I use a lot lamw25wmal
vim.keymap.set("v", "gss", function()
  -- Use nvim_replace_termcodes to handle special characters like backticks
  local keys = vim.api.nvim_replace_termcodes("gsa`", true, false, true)
  -- Feed the keys in visual mode ('x' for visual mode)
  vim.api.nvim_feedkeys(keys, "x", false)
  -- I tried these 3, but they didn't work, I assume because of the backtick character
  -- vim.cmd("normal! gsa`")
  -- vim.cmd([[normal! gsa`]])
  -- vim.cmd("normal! gsa\\`")
end, { desc = "[P] Surround selection with backticks (inline code)" })
-- In visual mode, check if the selected text is already striked through and show a message if it is
-- If not, surround it
vim.keymap.set("v", "<leader>mx", function()
  -- Get the selected text range
  local start_row, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
  local end_row, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
  -- Get the selected lines
  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  local selected_text = table.concat(lines, "\n"):sub(start_col, #lines == 1 and end_col or -1)
  if selected_text:match("^%~%~.*%~%~$") then
    vim.notify("Text already has strikethrough", vim.log.levels.INFO)
  else
    vim.cmd("normal 2gsa~")
  end
end, { desc = "[P]Strike through current selection" })

-- In visual mode, check if the selected text is already bold and show a message if it is
-- If not, surround it with double asterisks for bold
vim.keymap.set("v", "<leader>mb", function()
  -- Get the selected text range
  local start_row, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
  local end_row, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
  -- Get the selected lines
  local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
  local selected_text = table.concat(lines, "\n"):sub(start_col, #lines == 1 and end_col or -1)
  if selected_text:match("^%*%*.*%*%*$") then
    vim.notify("Text already bold", vim.log.levels.INFO)
  else
    vim.cmd("normal 2gsa*")
  end
end, { desc = "[P]BOLD current selection" })
-- -- Multiline unbold attempt
-- -- In normal mode, bold the current word under the cursor
-- -- If already bold, it will unbold the word under the cursor
-- -- If you're in a multiline bold, it will unbold it only if you're on the
-- -- first line
vim.keymap.set("n", "<leader>mb", function()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local current_buffer = vim.api.nvim_get_current_buf()
  local start_row = cursor_pos[1] - 1
  local col = cursor_pos[2]
  -- Get the current line
  local line = vim.api.nvim_buf_get_lines(current_buffer, start_row, start_row + 1, false)[1]
  -- Check if the cursor is on an asterisk
  if line:sub(col + 1, col + 1):match("%*") then
    vim.notify("Cursor is on an asterisk, run inside the bold text", vim.log.levels.WARN)
    return
  end
  -- Search for '**' to the left of the cursor position
  local left_text = line:sub(1, col)
  local bold_start = left_text:reverse():find("%*%*")
  if bold_start then
    bold_start = col - bold_start
  end
  -- Search for '**' to the right of the cursor position and in following lines
  local right_text = line:sub(col + 1)
  local bold_end = right_text:find("%*%*")
  local end_row = start_row
  while not bold_end and end_row < vim.api.nvim_buf_line_count(current_buffer) - 1 do
    end_row = end_row + 1
    local next_line = vim.api.nvim_buf_get_lines(current_buffer, end_row, end_row + 1, false)[1]
    if next_line == "" then
      break
    end
    right_text = right_text .. "\n" .. next_line
    bold_end = right_text:find("%*%*")
  end
  if bold_end then
    bold_end = col + bold_end
  end
  -- Remove '**' markers if found, otherwise bold the word
  if bold_start and bold_end then
    -- Extract lines
    local text_lines = vim.api.nvim_buf_get_lines(current_buffer, start_row, end_row + 1, false)
    local text = table.concat(text_lines, "\n")
    -- Calculate positions to correctly remove '**'
    -- vim.notify("bold_start: " .. bold_start .. ", bold_end: " .. bold_end)
    local new_text = text:sub(1, bold_start - 1) .. text:sub(bold_start + 2, bold_end - 1) .. text:sub(bold_end + 2)
    local new_lines = vim.split(new_text, "\n")
    -- Set new lines in buffer
    vim.api.nvim_buf_set_lines(current_buffer, start_row, end_row + 1, false, new_lines)
  -- vim.notify("Unbolded text", vim.log.levels.INFO)
  else
    -- Bold the word at the cursor position if no bold markers are found
    local before = line:sub(1, col)
    local after = line:sub(col + 1)
    local inside_surround = before:match("%*%*[^%*]*$") and after:match("^[^%*]*%*%*")
    if inside_surround then
      vim.cmd("normal gsd*.")
    else
      vim.cmd("normal viw")
      vim.cmd("normal 2gsa*")
    end
    vim.notify("Bolded current word", vim.log.levels.INFO)
  end
end, { desc = "[P]BOLD toggle bold markers" })

vim.keymap.set({ "n", "i" }, "<leader>mt", function()
  -- Get the current line/row/column
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, _ = cursor_pos[1], cursor_pos[2]
  local line = vim.api.nvim_get_current_line()
  -- 1) If line is empty => replace it with "- [ ] " and set cursor after the brackets
  if line:match("^%s*$") then
    local final_line = "- [ ] "
    vim.api.nvim_set_current_line(final_line)
    -- "- [ ] " is 6 characters, so cursor col = 6 places you *after* that space
    vim.api.nvim_win_set_cursor(0, { row, 6 })
    return
  end
  -- 2) Check if line already has a bullet with possible indentation: e.g. "  - Something"
  --    We'll capture "  -" (including trailing spaces) as `bullet` plus the rest as `text`.
  local bullet, text = line:match("^([%s]*[-*]%s+)(.*)$")
  if bullet then
    -- Convert bullet => bullet .. "[ ] " .. text
    local final_line = bullet .. "[ ] " .. text
    vim.api.nvim_set_current_line(final_line)
    -- Place the cursor right after "[ ] "
    -- bullet length + "[ ] " is bullet_len + 4 characters,
    -- but bullet has trailing spaces, so #bullet includes those.
    local bullet_len = #bullet
    -- We want to land after the brackets (four characters: `[ ] `),
    -- so col = bullet_len + 4 (0-based).
    vim.api.nvim_win_set_cursor(0, { row, bullet_len + 4 })
    return
  end
  -- 3) If there's text, but no bullet => prepend "- [ ] "
  --    and place cursor after the brackets
  local final_line = "- [ ] " .. line
  vim.api.nvim_set_current_line(final_line)
  -- "- [ ] " is 6 characters
  vim.api.nvim_win_set_cursor(0, { row, 6 })
end, { desc = "Convert bullet to a task or insert new task bullet" })

local function get_markdown_headings()
  local cursor_line = vim.fn.line(".")
  local parser = vim.treesitter.get_parser(0, "markdown")
  if not parser then
    vim.notify("Markdown parser not available", vim.log.levels.ERROR)
    return nil, nil, nil, nil, nil, nil
  end
  local tree = parser:parse()[1]
  local query = vim.treesitter.query.parse(
    "markdown",
    [[
    (atx_heading (atx_h1_marker) @h1)
    (atx_heading (atx_h2_marker) @h2)
    (atx_heading (atx_h3_marker) @h3)
    (atx_heading (atx_h4_marker) @h4)
    (atx_heading (atx_h5_marker) @h5)
    (atx_heading (atx_h6_marker) @h6)
  ]]
  )
  -- Collect and sort all headings
  local headings = {}
  for id, node in query:iter_captures(tree:root(), 0) do
    local start_line = node:start() + 1 -- Convert to 1-based
    table.insert(headings, { line = start_line, level = id })
  end
  table.sort(headings, function(a, b)
    return a.line < b.line
  end)
  -- Find current heading and track its index
  local current_heading, current_idx, next_heading, next_same_heading
  for idx, h in ipairs(headings) do
    if h.line <= cursor_line then
      current_heading = h
      current_idx = idx
    elseif not next_heading then
      next_heading = h -- First heading after cursor
    end
  end
  -- Find next same-level heading if current exists
  if current_heading then
    -- Look for next same-level after current index
    for i = current_idx + 1, #headings do
      local h = headings[i]
      if h.level == current_heading.level then
        next_same_heading = h
        break
      end
    end
  end
  -- Return all values (nil if not found)
  return current_heading and current_heading.line or nil,
    current_heading and current_heading.level or nil,
    next_heading and next_heading.line or nil,
    next_heading and next_heading.level or nil,
    next_same_heading and next_same_heading.line or nil,
    next_same_heading and next_same_heading.level or nil
end
-- Print details of current markdown heading, next heading and next same level heading
vim.keymap.set("n", "<leader>mT", function()
  local cl, clvl, nl, nlvl, nsl, nslvl = get_markdown_headings()
  local message_parts = {}
  if cl then
    table.insert(message_parts, string.format("Current: H%d (line %d)", clvl, cl))
  else
    table.insert(message_parts, "Not in a section")
  end
  if nl then
    table.insert(message_parts, string.format("Next: H%d (line %d)", nlvl, nl))
  end
  if nsl then
    table.insert(message_parts, string.format("Next H%d: line %d", nslvl, nsl))
  end
  vim.notify(table.concat(message_parts, " | "), vim.log.levels.INFO)
end, { desc = "Show current, next, and same-level Markdown headings" })
-------------------------------------------------------------------------------
------------------------------Markdown Heading Jumps---------------------------
-------------------------------------------------------------------------------
------------------------------For H1-------------------------------------------
-- -- helper to detect fenced code blocks (``` … ```)
-- local function in_code_block(lnum)
--   local lines = vim.api.nvim_buf_get_lines(0, 0, lnum, false)
--   local fences = 0
--   for _, line in ipairs(lines) do
--     if line:match("^```") then
--       fences = fences + 1
--     end
--   end
--   return fences % 2 == 1
-- end
--
-- -- Level-1 heading only: "# Title"
-- local heading_pattern = [[^#\s[^#].*$]]
--
-- local function PrevH1()
--   while true do
--     local lnum = vim.fn.search(heading_pattern, "bn") -- backward + wrap
--     if lnum == 0 then
--       return
--     end
--     if not in_code_block(lnum) then
--       vim.api.nvim_win_set_cursor(0, { lnum, 0 })
--       return
--     end
--   end
-- end
--
-- local function NextH1()
--   while true do
--     local lnum = vim.fn.search(heading_pattern, "n") -- forward + wrap
--     if lnum == 0 then
--       return
--     end
--     if not in_code_block(lnum) then
--       vim.api.nvim_win_set_cursor(0, { lnum, 0 })
--       return
--     end
--   end
-- end
--
-- vim.keymap.set({ "n", "v" }, "gk", function()
--   PrevH1()
--   vim.cmd("nohlsearch")
-- end, { desc = "Go to previous Markdown H1 header" })
--
-- vim.keymap.set({ "n", "v" }, "gj", function()
--   NextH1()
--   vim.cmd("nohlsearch")
-- end, { desc = "Go to next Markdown H1 header" })
-- Helper: detect if a line is inside a fenced code block (``` … ```)
------------------------------For H2-------------------------------------------
local function in_code_block(lnum)
  local lines = vim.api.nvim_buf_get_lines(0, 0, lnum, false)
  local fences = 0
  for _, line in ipairs(lines) do
    if line:match("^```") then
      fences = fences + 1
    end
  end
  return fences % 2 == 1
end

-- Jump to previous or next H2 markdown heading: "## Title"

local function goto_h2(direction)
  local pattern = [[^##\s\+[^#].*$]]
  local flags = (direction == "prev") and "bn" or "n"

  -- Capture starting position so we can detect if search is stuck
  local start_pos = vim.api.nvim_win_get_cursor(0)[1]

  while true do
    local lnum = vim.fn.search(pattern, flags)
    if lnum == 0 then
      return
    end

    if not in_code_block(lnum) then
      vim.api.nvim_win_set_cursor(0, { lnum, 0 })
      return
    end

    -- Move cursor off matched bad line so search progresses
    if direction == "prev" then
      vim.api.nvim_win_set_cursor(0, { lnum - 1, 0 })
    else
      vim.api.nvim_win_set_cursor(0, { lnum + 1, 0 })
    end

    -- Loop breaker: if we returned to start, stop to avoid freeze
    if vim.api.nvim_win_get_cursor(0)[1] == start_pos then
      return
    end
  end
end
vim.keymap.set({ "n", "v" }, "gk", function()
  goto_h2("prev")
  vim.cmd("nohlsearch")
end, { desc = "Go to previous Markdown H2 header" })

vim.keymap.set({ "n", "v" }, "gj", function()
  goto_h2("next")
  vim.cmd("nohlsearch")
end, { desc = "Go to next Markdown H2 header" })
---------------------- Markdown Heading movement ends here--------------------
------------------------------------------------------------------------------

--  This doesn't ask for confirmation and just increase all the headings
vim.keymap.set("n", "<leader>mhI", function()
  -- Save the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  -- I'm using [[ ]] to escape the special characters in a command
  vim.cmd([[:g/\(^$\n\s*#\+\s.*\n^$\)/ .+1 s/^#\+\s/#&/]])
  -- Restore the cursor position
  vim.api.nvim_win_set_cursor(0, cursor_pos)
  -- Clear search highlight
  vim.cmd("nohlsearch")
end, { desc = "[P]Increase headings without confirmation" })

vim.keymap.set("n", "<leader>mhD", function()
  -- Save the current cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  -- I'm using [[ ]] to escape the special characters in a command
  vim.cmd([[:g/^\s*#\{2,}\s/ s/^#\(#\+\s.*\)/\1/]])
  -- Restore the cursor position
  vim.api.nvim_win_set_cursor(0, cursor_pos)
  -- Clear search highlight
  vim.cmd("nohlsearch")
end, { desc = "[P]Decrease headings without confirmation" })
-- Increase markdown headings for text selected in visual mode
vim.keymap.set("v", "<leader>mhI", function()
  -- Save cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  -- Get visual selection bounds and ensure correct order
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local buf = vim.api.nvim_get_current_buf()
  -- Process each line in the selection
  for lnum = start_line, end_line do
    local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
    if line and line:match("^##+%s") then -- Match headings level 2+
      local new_line = "#" .. line
      vim.api.nvim_buf_set_lines(buf, lnum - 1, lnum, false, { new_line })
    end
  end
  -- Restore cursor and clear highlights
  vim.api.nvim_win_set_cursor(0, cursor_pos)
  vim.cmd("nohlsearch")
end, { desc = "Increase headings in visual selection" })

-- Decrease markdown headings for text selected in visual mode
vim.keymap.set("v", "<leader>mhD", function()
  -- Save cursor position
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  -- Get visual selection bounds and ensure correct order
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  local buf = vim.api.nvim_get_current_buf()
  -- Process each line in the selection
  for lnum = start_line, end_line do
    local line = vim.api.nvim_buf_get_lines(buf, lnum - 1, lnum, false)[1]
    if line and line:match("^##+%s") then -- Match headings level 2+
      -- Split into hashes and content, then remove one #
      local hashes, content = line:match("^(#+)(%s.+)$")
      if hashes and #hashes >= 2 then
        local new_hashes = hashes:sub(1, #hashes - 1)
        local new_line = new_hashes .. content
        vim.api.nvim_buf_set_lines(buf, lnum - 1, lnum, false, { new_line })
      end
    end
  end
  -- Restore cursor and clear highlights
  vim.api.nvim_win_set_cursor(0, cursor_pos)
  vim.cmd("nohlsearch")
end, { desc = "Decrease headings in visual selection" })

-- Marks keep coming back even after deleting them, this deletes them all
-- This deletes all marks in the current buffer, including lowercase, uppercase, and numbered marks
-- Fix should be applied on April 2024
-- https://github.com/chentoast/marks.nvim/issues/13
vim.keymap.set("n", "<leader>mZ", function()
  -- Delete all marks in the current buffer
  vim.cmd("delmarks!")
  print("All marks deleted.")
end, { desc = "[P]Delete all marks" })

-- Function to open current file in Finder or ForkLift
local function open_in_file_manager()
  local file_path = vim.fn.expand("%:p")
  if file_path ~= "" then
    -- -- Open in Finder or in ForkLift
    -- local command = "open -R " .. vim.fn.shellescape(file_path)
    local command = "open -a ForkLift " .. vim.fn.shellescape(file_path)
    vim.fn.system(command)
    print("Opened file in ForkLift: " .. file_path)
  else
    print("No file is currently open")
  end
end

vim.keymap.set({ "n", "v", "i" }, "<M-f>", open_in_file_manager, { desc = "[P]Open current file in file explorer" })
vim.keymap.set("n", "<leader>fO", open_in_file_manager, { desc = "[P]Open current file in file explorer" })
-------------------------------------------------------------------------
------------------- Github----------------------------------------
-------------------------------------------------------------------------
-- Function to get the GitHub URL of the current file
local function get_github_url_of_current_file()
  local file_path = vim.fn.expand("%:p")
  if file_path == "" then
    vim.notify("No file is currently open", vim.log.levels.WARN)
    return nil
  end

  local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  if not git_root or git_root == "" then
    vim.notify("Could not determine the root directory for the GitHub repository", vim.log.levels.WARN)
    return nil
  end

  local origin_url = vim.fn.systemlist("git config --get remote.origin.url")[1]
  if not origin_url or origin_url == "" then
    vim.notify("Could not determine the origin URL for the GitHub repository", vim.log.levels.WARN)
    return nil
  end

  local branch_name = vim.fn.systemlist("git rev-parse --abbrev-ref HEAD")[1]
  if not branch_name or branch_name == "" then
    vim.notify("Could not determine the current branch name", vim.log.levels.WARN)
    return nil
  end

  local repo_url = origin_url:gsub("git@github.com[^:]*:", "https://github.com/"):gsub("%.git$", "")
  local relative_path = file_path:sub(#git_root + 2)
  return repo_url .. "/blob/" .. branch_name .. "/" .. relative_path
end

-- Open current file's GitHub repo link lamw25wmal
vim.keymap.set("n", "<leader>fG", function()
  local github_url = get_github_url_of_current_file()
  if github_url then
    local command = "open " .. vim.fn.shellescape(github_url)
    vim.fn.system(command)
    print("Opened GitHub link: " .. github_url)
  end
end, { desc = "[P]Open current file's GitHub repo link" })

-- Keymap to copy current file's GitHub URL to clipboard
vim.keymap.set({ "n", "v", "i" }, "<M-C>", function()
  local github_url = get_github_url_of_current_file()
  if github_url then
    vim.fn.setreg("+", github_url)
    vim.notify(github_url, vim.log.levels.INFO)
    vim.notify("GitHub URL copied to clipboard", vim.log.levels.INFO)
  end
end, { desc = "[P]Copy GitHub URL of file to clipboard" })
-------------------------------------------------------------------------
------------------- Folds Section----------------------------------------
-------------------------------------------------------------------------

-- Safe foldexpr wrapper (similar to LazyVim's util)
function _G.treesitter_foldexpr()
  local ok = pcall(vim.treesitter.get_parser, 0)
  if ok then
    return vim.treesitter.foldexpr()
  else
    return "0"
  end
end

-- Set folding method using Treesitter
local function set_foldmethod_treesitter()
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.treesitter_foldexpr()"
  vim.opt.foldtext = ""
  vim.opt.foldlevel = 99
end

-- Fold headings of a specific level
local function fold_headings_of_level(level)
  local total_lines = vim.fn.line("$")
  for line = 1, total_lines do
    local text = vim.fn.getline(line)
    if text:match("^" .. string.rep("#", level) .. "%s") then
      vim.fn.cursor(line, 1)
      if vim.fn.foldlevel(line) > 0 then
        vim.cmd("normal! za")
      end
    end
  end
end

-- Fold markdown headings for specified levels
local function fold_markdown_headings(levels)
  set_foldmethod_treesitter()
  vim.cmd("normal! zx") -- Recalculate folds
  vim.cmd("redraw!") -- Update UI
  vim.defer_fn(function()
    local saved_view = vim.fn.winsaveview()
    for _, level in ipairs(levels) do
      fold_headings_of_level(level)
    end
    vim.fn.winrestview(saved_view)
  end, 10)
end

-- Toggle fold under cursor
vim.keymap.set("n", "<CR>", function()
  local line = vim.fn.line(".")
  if vim.fn.foldlevel(line) == 0 then
    vim.notify("No fold found", vim.log.levels.INFO)
  else
    vim.cmd("normal! za")
    vim.cmd("normal! zz")
  end
end, { desc = "[P] Toggle fold" })

-- Unfold all
vim.keymap.set("n", "zu", function()
  vim.cmd("silent update")
  vim.cmd("normal! zR")
  vim.cmd("normal! zz")
end, { desc = "[P] Unfold all headings" })

-- Fold current heading
vim.keymap.set("n", "zi", function()
  vim.cmd("silent update")
  vim.cmd("normal gk")
  vim.cmd("normal! za")
  vim.cmd("normal! zz")
end, { desc = "[P] Fold heading under cursor" })

-- Fold level 1+
vim.keymap.set("n", "zj", function()
  fold_markdown_headings({ 6, 5, 4, 3, 2, 1 })
end, { desc = "[P] Fold all headings level 1 or above" })

-- Fold level 2+
vim.keymap.set("n", "zk", function()
  fold_markdown_headings({ 6, 5, 4, 3, 2 })
end, { desc = "[P] Fold all headings level 2 or above" })

-- Fold level 3+
vim.keymap.set("n", "zl", function()
  fold_markdown_headings({ 6, 5, 4, 3 })
end, { desc = "[P] Fold all headings level 3 or above" })

-- Fold level 4+
vim.keymap.set("n", "z;", function()
  fold_markdown_headings({ 6, 5, 4 })
end, { desc = "[P] Fold all headings level 4 or above" })
----Markdown horizontal limit to 80 chars--------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("t")

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[silent! execute "normal! gggqG"]])
        vim.api.nvim_win_set_cursor(0, cursor)
      end,
    })
  end,
})
--------------------------------------------------------------------------------
------------------------------ToDo----------------------------------------------
--------------------------------------------------------------------------------
-- Make functions global
-- Mark TODO as done
function _G.mark_todo_done()
  local line = vim.api.nvim_get_current_line()
  if line:match("^%s*%- %[%s%]") then
    line = line:gsub("%[ %]", "[x]")
    vim.api.nvim_set_current_line(line)
    print("TODO marked done")
  else
    print("Already done or not a TODO")
  end
end

-- Unmark TODO
function _G.unmark_todo()
  local line = vim.api.nvim_get_current_line()
  if line:match("^%s*%- %[%s?x%s?%]") then
    line = line:gsub("%[x%]", "[ ]")
    vim.api.nvim_set_current_line(line)
    print("TODO unmarked")
  else
    print("Already unmarked or not a TODO")
  end
end
-- move to the nearrest heading irrespective of heading level
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.keymap.set({ "n", "x" }, "]v", function()
      vim.fn.search("^\\s*#\\+", "W")
    end, { buffer = true })

    vim.keymap.set({ "n", "x" }, "[v", function()
      vim.fn.search("^\\s*#\\+", "bW")
    end, { buffer = true })
  end,
})
-- you can already do this with [[,]] so no need to manually do this
-- Key mappings (normal mode)
-- th = mark done, tu = unmark
vim.api.nvim_set_keymap("n", "<leader>ti", ":lua mark_todo_done()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>tu", ":lua unmark_todo()<CR>", { noremap = true, silent = true })

--------------------------------------------------------------------------------
------------------------------Tresitter-----------------------------------------
--------------------------------------------------------------------------------
-- Transparent background for treesitter-context
vim.api.nvim_set_hl(0, "TreesitterContext", { bg = "none" })
vim.api.nvim_set_hl(0, "TreesitterContextLineNumber", { bg = "none" })
vim.api.nvim_set_hl(0, "TreesitterContextSeparator", { bg = "none" })
