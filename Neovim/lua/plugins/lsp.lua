return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },

		config = function()
			local cfg = vim.lsp.config
			local extend = vim.tbl_deep_extend

			vim.diagnostic.config({
				virtual_text = { prefix = "●", spacing = 2 },
			})
			-- Lua LS
			vim.lsp.start(cfg.lua_ls) -- barebones

			-- TypeScript LS
			vim.lsp.start(cfg.ts_ls) -- barebones
		end,
	},
}
