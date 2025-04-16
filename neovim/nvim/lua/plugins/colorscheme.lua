return {
	{
		"craftzdog/solarized-osaka.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			local transparent = true -- Set to true for transparency

			-- Define Solarized Osaka color values
			local bg = "#002b36"
			local bg_dark = "#073642"
			local bg_highlight = "#586e75"
			local bg_search = "#b58900"
			local bg_visual = "#657b83"
			local fg = "#839496"
			local fg_dark = "#93a1a1"
			local fg_gutter = "#586e75"
			local border = "#657b83"

			require("solarized-osaka").setup({
				transparent = transparent,
				terminal_colors = true,
				styles = {
					comments = { italic = true },
					keywords = { italic = false },
					functions = { bold = true },
					variables = {},
					sidebars = transparent and "transparent" or "dark",
					floats = transparent and "transparent" or "dark",
				},
				on_colors = function(colors)
					colors.bg = bg
					colors.bg_dark = transparent and colors.none or bg_dark
					colors.bg_float = transparent and colors.none or bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = transparent and colors.none or bg_dark
					colors.bg_statusline = transparent and colors.none or bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_gutter = fg_gutter
					colors.fg_sidebar = fg_dark
				end,
			})
			vim.cmd("colorscheme solarized-osaka")
		end,
	},
}

-- return {
-- 	{
-- 		"folke/tokyonight.nvim",
-- 		lazy = false,
-- 		priority = 1000,
-- 		config = function()
-- 			local transparent = true -- Set to true for transparency
--
-- 			-- Define TokyoNight color values
-- 			local bg = "#1a1b26"
-- 			local bg_dark = "#16161e"
-- 			local bg_highlight = "#292e42"
-- 			local bg_search = "#3d59a1"
-- 			local bg_visual = "#33467C"
-- 			local fg = "#c0caf5"
-- 			local fg_dark = "#a9b1d6"
-- 			local fg_gutter = "#3b4261"
-- 			local border = "#565f89"
--
-- 			require("tokyonight").setup({
-- 				style = "night", -- Options: "storm", "night", "moon", "day"
-- 				transparent = transparent,
-- 				terminal_colors = true,
-- 				styles = {
-- 					comments = { italic = true },
-- 					keywords = { italic = false },
-- 					functions = { bold = true },
-- 					variables = {},
-- 					sidebars = transparent and "transparent" or "dark",
-- 					floats = transparent and "transparent" or "dark",
-- 				},
-- 				on_colors = function(colors)
-- 					colors.bg = bg
-- 					colors.bg_dark = transparent and colors.none or bg_dark
-- 					colors.bg_float = transparent and colors.none or bg_dark
-- 					colors.bg_highlight = bg_highlight
-- 					colors.bg_popup = bg_dark
-- 					colors.bg_search = bg_search
-- 					colors.bg_sidebar = transparent and colors.none or bg_dark
-- 					colors.bg_statusline = transparent and colors.none or bg_dark
-- 					colors.bg_visual = bg_visual
-- 					colors.border = border
-- 					colors.fg = fg
-- 					colors.fg_dark = fg_dark
-- 					colors.fg_float = fg
-- 					colors.fg_gutter = fg_gutter
-- 					colors.fg_sidebar = fg_dark
-- 				end,
-- 			})
-- 			vim.cmd("colorscheme tokyonight")
-- 		end,
-- 	},
-- }
