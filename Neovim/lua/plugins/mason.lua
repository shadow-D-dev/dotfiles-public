return {
	"mason-org/mason.nvim",
	dependencies = {
		"mason-org/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")

		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				border = "rounded",
				width = 0.9,
				height = 0.9,
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({ --Auto-installs these LSP servers if missing.
			ensure_installed = {
				"ts_ls",
				"lua_ls",
				"html",
				"cssls",
				"tailwindcss",
				"graphql",
				"emmet_ls",
				"eslint",
			},
		})

		mason_tool_installer.setup({ --Installs non-LSP tools (formatters, linters).
			ensure_installed = {
				"prettier",
				"stylua",
				"eslint_d",
			},
		})
	end,
}
