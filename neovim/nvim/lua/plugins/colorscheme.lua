vim.opt.termguicolors = true -- Ensure true colors are enabled

require("solarized-osaka").setup({
	transparent = true, -- Set true if you want a transparent background
	terminal_colors = true,
	styles = {
		comments = { italic = true },
		keywords = { italic = false },
		functions = { bold = true },
		variables = {},
		sidebars = "dark",
		floats = "dark",
	},
})

-- Set the colorscheme
vim.cmd("colorscheme solarized-osaka")
