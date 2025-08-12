local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	ui = {
		border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			import = "📦",
			keys = "🗝",
			lazy = "💤 ",
			loaded = "●",
			not_loaded = "○",
		},
		size = { width = 0.5, height = 0.5 },
	},
})
