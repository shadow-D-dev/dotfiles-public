vim.g.mapleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.ignorecase = true
opt.smartcase = true
opt.cursorline = true
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
opt.backspace = "indent,eol,start"

opt.winborder = "rounded"
-- this is currently working setup the commented setup below does used to work before but then it suddenly stopped for zj,zk,.. so this is the current option will fix both later
local function set_foldmethod_expr()
	if vim.fn.has("nvim-0.10") == 1 then
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
		vim.opt.foldtext = ""
	else
		vim.opt.foldmethod = "indent"
		vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
	end
	vim.opt.foldlevel = 99
end

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

local function fold_markdown_headings(levels)
	set_foldmethod_expr()
	vim.cmd("normal! zx") -- Recalculate folds from expr
	vim.cmd("redraw!") -- Ensure UI updates
	vim.defer_fn(function()
		local saved_view = vim.fn.winsaveview()
		for _, level in ipairs(levels) do
			fold_headings_of_level(level)
		end
		vim.fn.winrestview(saved_view)
	end, 10) -- Small delay to ensure folds are applied first
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
end, { desc = "[P]Toggle fold" })

-- Unfold all
vim.keymap.set("n", "zu", function()
	vim.cmd("silent update")
	vim.cmd("normal! zR")
	vim.cmd("normal! zz")
end, { desc = "[P]Unfold all headings" })

-- Fold current heading
vim.keymap.set("n", "zi", function()
	vim.cmd("silent update")
	vim.cmd("normal gk")
	vim.cmd("normal! za")
	vim.cmd("normal! zz")
end, { desc = "[P]Fold heading under cursor" })

-- Fold level 1+
vim.keymap.set("n", "zj", function()
	fold_markdown_headings({ 6, 5, 4, 3, 2, 1 })
end, { desc = "[P]Fold all headings level 1 or above" })

-- Fold level 2+
vim.keymap.set("n", "zk", function()
	fold_markdown_headings({ 6, 5, 4, 3, 2 })
end, { desc = "[P]Fold all headings level 2 or above" })

-- Fold level 3+
vim.keymap.set("n", "zl", function()
	fold_markdown_headings({ 6, 5, 4, 3 })
end, { desc = "[P]Fold all headings level 3 or above" })

-- Fold level 4+
vim.keymap.set("n", "z;", function()
	fold_markdown_headings({ 6, 5, 4 })
end, { desc = "[P]Fold all headings level 4 or above" })
