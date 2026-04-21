-- set leader key to space
vim.g.mapleader = " "

local map = vim.keymap.set -- for conciseness

map("n", "<leader>q", ":quit<CR>")
-- clear search highlights
map("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
map("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
map("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
map("n", "<leader>|", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
map("n", "<leader>-", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
map("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tab management
-- map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
-- map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
-- map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- lazy package manager
map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Open Lazy.nvim" })

-- Move Lines
-- map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
-- map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
-- map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
-- map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
-- map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
-- map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- custom keympas from LINKARZU
vim.keymap.set("i", "kj", "<ESC>", { desc = "[P]Exit insert mode with kj" })
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "[P]Go to the beginning line" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "[P]go to the end of the line" })
vim.keymap.set("v", "gl", "$h", { desc = "[P]Go to the end of the line" })

-- save all
vim.keymap.set("n", "<C-a>", "gg<S-v>G")
vim.keymap.set("n", "<leader>rn", ":IncRename ")

--mason
-- moving between markdown Headings faster

-- By default, CTRL-U and CTRL-D scroll by half a screen (50% of the window height)
-- Scroll by 35% of the window height and keep the cursor centered
local scroll_percentage = 0.35
-- Scroll by a percentage of the window height and keep the cursor centered
vim.keymap.set("n", "<C-d>", function()
  local lines = math.floor(vim.api.nvim_win_get_height(0) * scroll_percentage)
  vim.cmd("normal! " .. lines .. "jzz")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", function()
  local lines = math.floor(vim.api.nvim_win_get_height(0) * scroll_percentage)
  vim.cmd("normal! " .. lines .. "kzz")
end, { noremap = true, silent = true })

-- When jumping with ctrl+d and u the cursors stays in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

-- Quit or exit neovim, easier than to do <leader>qq
vim.keymap.set({ "n", "v", "i" }, "<M-q>", "<cmd>wqa<cr>", { desc = "[P]Quit All" })

-- Noice

vim.keymap.set({ "n", "v", "i" }, "<M-h>", function()
  -- require("noice").cmd("history")
  require("noice").cmd("all")
end, { desc = "[P]Noice History" })

-- Dismiss noice notifications
vim.keymap.set({ "n", "v", "i" }, "<M-d>", function()
  require("noice").cmd("dismiss")
end, { desc = "Dismiss All" })

-- -- yank selected text into system clipboard
-- -- Vim/Neovim has two clipboards: unnamed register (default) and system clipboard.
-- --
-- -- Yanking with `y` goes to the unnamed register, accessible only within Vim.
-- -- The system clipboard allows sharing data between Vim and other applications.
-- -- Yanking with `"+y` copies text to both the unnamed register and system clipboard.
-- -- The `"+` register represents the system clipboard.
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[P]Yank to system clipboard" })
-- pasting the link

vim.keymap.set({ "n", "v", "i" }, "<M-;>", function()
  -- Insert the text in the desired format
  vim.cmd("normal! a[]() ")
  vim.cmd("normal! F(pv2F/lyF[p")
  -- Leave me in normal mode or command mode
  vim.cmd("stopinsert")
end, { desc = "[P]Paste Github link" })
-- swaping the roles of u,w (u deletes lines , w deletes word) i dont generally
-- delete a line but a word is no go and ctrl+w is not ergnomic so this makes
-- sense atm.-- Swap Ctrl-w and Ctrl-u in insert mode
map("i", "<C-w>", "<C-u>")
map("i", "<C-u>", "<C-w>")
