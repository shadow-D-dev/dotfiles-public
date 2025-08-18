return {
	{
		"neovim/nvim-lspconfig",
		opts = function()
			-- Diagnostic configuration
			vim.diagnostic.config({
				underline = true,
				severity_sort = true,
				virtual_text = {
					spacing = 4, -- space before message
					source = "if_many", -- show source if multiple
					prefix = "●", -- could also use "▎" or "■"
				},
				float = {
					border = "rounded",
					source = "always",
				},
			})
		end,
	},
}
