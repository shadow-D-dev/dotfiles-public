return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		bullet = { enabled = true },
		code = {
			style = "language",
			width = "block",
			right_pad = 0,
			line_padding = false,
		},
		checkbox = {
			enabled = true,
			position = "inline",
			unchecked = {
				icon = "   󰄱 ",
				highlight = "RenderMarkdownUnchecked",
				scope_highlight = nil,
			},
			checked = {
				icon = "   󰱒 ",
				highlight = "RenderMarkdownChecked",
				scope_highlight = nil,
			},
		},
		html = {
			enabled = true,
			comment = { conceal = false },
		},
	},
}
