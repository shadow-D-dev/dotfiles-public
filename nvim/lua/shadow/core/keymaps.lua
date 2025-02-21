vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab
--Duplicate the line
keymap.set("n", "<leader>du", "yyp", { desc = "Duplicate current line below" })
-- Move line down with Alt-j
keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move Line Down", silent = true })
keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move Line Down", silent = true })
keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Line Down", silent = true })

-- Move line up with Alt-k
keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move Line Up", silent = true })
keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move Line Up", silent = true })
keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Line Up", silent = true })
-- Move cursor left with Alt-h in Insert mode
keymap.set("i", "<A-h>", "<Left>", { desc = "Move Cursor Left", silent = true })

-- Move cursor down with Alt-j in Insert mode
keymap.set("i", "<A-j>", "<Down>", { desc = "Move Cursor Down", silent = true })

-- Move cursor up with Alt-k in Insert mode
keymap.set("i", "<A-k>", "<Up>", { desc = "Move Cursor Up", silent = true })

-- Move cursor right with Alt-l in Insert mode
keymap.set("i", "<A-l>", "<Right>", { desc = "Move Cursor Right", silent = true })
keymap.set("n", "<leader>gr", vim.lsp.buf.references, { desc = "Find references" })

--keymap to replace the word throughout the file with option to choose manually
vim.keymap.set("n", "<leader>sw", function()
  local word = vim.fn.expand("<cword>") -- Get the word under the cursor
  local replacement = vim.fn.input("Replace with: ") -- Prompt for replacement word
  if replacement ~= "" then -- Check if input is not empty
    vim.cmd(":%s/\\<" .. word .. "\\>/" .. replacement .. "/gc")
  end
end, { desc = "Substitute all occurrences of word under cursor" })

-- Search UP for a markdown header
-- Make sure to follow proper markdown convention, and you have a single H1
-- heading at the very top of the file
-- This will only search for H2 headings and above
vim.keymap.set("n", "gk", function()
  -- `?` - Start a search backwards from the current cursor position.
  -- `^` - Match the beginning of a line.
  -- `##` - Match 2 ## symbols
  -- `\\+` - Match one or more occurrences of prev element (#)
  -- `\\s` - Match exactly one whitespace character following the hashes
  -- `.*` - Match any characters (except newline) following the space
  -- `$` - Match extends to end of line
  vim.cmd("silent! ?^##\\+\\s.*$")
  -- Clear the search highlight
  vim.cmd("nohlsearch")
end, { desc = "Go to previous markdown header" })

-- Search DOWN for a markdown header
-- Make sure to follow proper markdown convention, and you have a single H1
-- heading at the very top of the file
-- This will only search for H2 headings and above
vim.keymap.set("n", "gj", function()
  -- `/` - Start a search forwards from the current cursor position.
  -- `^` - Match the beginning of a line.
  -- `##` - Match 2 ## symbols
  -- `\\+` - Match one or more occurrences of prev element (#)
  -- `\\s` - Match exactly one whitespace character following the hashes
  -- `.*` - Match any characters (except newline) following the space
  -- `$` - Match extends to end of line
  vim.cmd("silent! /^##\\+\\s.*$")
  -- Clear the search highlight
  vim.cmd("nohlsearch")
end, { desc = "Go to next markdown header" })
