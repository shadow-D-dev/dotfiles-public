return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("solarized-osaka").setup({
				transparent = true, -- keep transparency if you want
				terminal_colors = true,
				lualine_bold = true, -- important for statusline sections
				styles = {
					comments = { italic = true },
					keywords = { italic = false },
					functions = { bold = true },
					variables = {},
					sidebars = "transparent",
					floats = "transparent",
				},
				-- if you want to tweak, do it lightly:
				on_colors = function(colors)
					-- for example, just make search highlights pop
					colors.bg_search = "#b58900"
				end,
			})
			vim.cmd("colorscheme solarized-osaka")
		end,
	},
}
