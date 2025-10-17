vim.g.mapleader = " "

local map = vim.keymap.set

vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")
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
map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
map("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
map("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- lazy package manager
map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Open Lazy.nvim" })

-- custom keympas from LINKARZU
vim.keymap.set("i", "kj", "<ESC>", { desc = "[P]Exit insert mode with kj" })
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "[P]Go to the beginning line" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "[P]go to the end of the line" })
vim.keymap.set("v", "gl", "$h", { desc = "[P]Go to the end of the line" })

-- save all
vim.keymap.set("n", "<leader>a", "gg<S-v>Gy")

-- Map Kitty’s custom sequences
vim.keymap.set("n", "<Esc>[74;9u", ":m .+1<CR>==", { noremap = true, silent = true }) -- Right Alt+j move line down
vim.keymap.set("n", "<Esc>[75;9u", ":m .-2<CR>==", { noremap = true, silent = true }) -- Right Alt+k move line up

-- Previous & Next buffer (like LazyVim H,L)
vim.keymap.set("n", "H", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "L", "<cmd>bnext<CR>", { desc = "Next buffer" })
