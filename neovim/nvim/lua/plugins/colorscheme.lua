return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("solarized-osaka").setup({
				transparent = true,
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
			vim.cmd("colorscheme solarized-osaka")
		end,
	},
}
