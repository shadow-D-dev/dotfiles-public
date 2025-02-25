return {
	"mbbill/undotree",
	event = { "BufReadPre", "BufNewFile" }, -- Load when a buffer is opened
	config = function()
		-- Configure persistent undo
		vim.opt.undofile = true -- Enable undo files

		-- Ensure the undodir is a string
		local undodir = vim.fn.expand("~/.config/neovim/nvim/undodir")
		vim.opt.undodir = undodir -- Assign string directly to undodir

		-- Create the undo directory if it doesn't exist
		if vim.fn.isdirectory(undodir) == 0 then
			vim.fn.mkdir(undodir, "p")
		end

		-- Set keybinding for toggling the undotree
		vim.keymap.set(
			"n",
			"<S-M-u>",
			":UndotreeToggle<CR>",
			{ noremap = true, silent = true, desc = "Toggle UndoTree" }
		)
	end,
}
