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
				width = 0.7,
				height = 0.5,
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
				"html",
				"cssls",
				"tailwindcss",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"eslint",
				"marksman",
			},
		})

		mason_tool_installer.setup({ --Installs non-LSP tools (formatters, linters).
			ensure_installed = {
				"prettier",
				"stylua",
				"eslint_d",
				"markdownlint-cli2",
				"markdown-toc",
			},
		})
	end,
}
