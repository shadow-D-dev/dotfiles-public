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

-- lazy package manager
map("n", "<Leader>l", "<Cmd>Lazy<CR>", { desc = "Open Lazy.nvim" })
-- map("n", "<Leader>e", "<Cmd>Explore<CR>", { desc = "Open netrw" })

-- custom keympas from LINKARZU
map("i", "kj", "<ESC>", { desc = "[P]Exit insert mode with kj" })
map({ "n", "v" }, "gh", "^", { desc = "[P]Go to the beginning line" })
map({ "n", "v" }, "gl", "$", { desc = "[P]go to the end of the line" })
map("v", "gl", "$h", { desc = "[P]Go to the end of the line" })

-- When jumping with ctrl+d and u the cursors stays in the middle
map("n", "<C-d>", "<C-d>zz")
map("n", "<c-u>", "<c-u>zz")
