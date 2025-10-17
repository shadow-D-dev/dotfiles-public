vim.g.mapleader = " "

local opt = vim.opt
-- Basic settings
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.winborder = "rounded"

--search settings
opt.ignorecase = true
opt.smartcase = true

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position
-- this is for things like links will show only name i.e. [link] and some more in markdown and only for mode nc (normal,command)
opt.conceallevel = 2
opt.concealcursor = "nc"

opt.wrap = true
opt.linebreak = true
opt.breakindent = true
-- vim.o.showbreak = "↪ " this will show the sign wherever there is linebreak
vim.opt.breakindentopt = { "shift:2" }
-- sign column
vim.opt.signcolumn = "yes"
