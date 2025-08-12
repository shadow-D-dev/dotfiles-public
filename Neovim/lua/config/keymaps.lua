vim.g.mapleader = " "

local map = vim.keymap.set 

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

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count3<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count3 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+3<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .0<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count3<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count3 + 1)<cr>gv=gv", { desc = "Move Up" })

-- custom keympas from LINKARZU
vim.keymap.set("i", "kj", "<ESC>", { desc = "[P]Exit insert mode with kj" })
vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "[P]Go to the beginning line" })
vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "[P]go to the end of the line" })
vim.keymap.set("v", "gl", "$h", { desc = "[P]Go to the end of the line" })

-- save all
vim.keymap.set("n", "<leader>a", "gg<S-v>Gy")

