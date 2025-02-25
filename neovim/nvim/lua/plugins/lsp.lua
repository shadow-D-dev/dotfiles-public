return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{
			"williamboman/mason.nvim",
			opts = function(_, opts)
				-- Ensure these tools are installed
				opts.ensure_installed = opts.ensure_installed or {}
				vim.list_extend(opts.ensure_installed, {
					"stylua",
					"selene",
					"luacheck",
					"shellcheck",
					"shfmt",
					"tailwindcss-language-server",
					"typescript-language-server",
					"css-lsp",
				})
			end,
		},
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		-- Load required modules
		local lspconfig = require("lspconfig")
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")

		-- Setup Mason (LSP installer)
		mason.setup()
		mason_lspconfig.setup({
			ensure_installed = { "typescript-language-server", "tailwindcss", "cssls" },
		})

		-- Function to apply keybindings when an LSP attaches
		local on_attach = function(_, bufnr)
			local opts = { buffer = bufnr, noremap = true, silent = true }
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
			vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		end

		-- Ensure Mason-installed LSPs are set up
		mason_lspconfig.setup_handlers({
			function(server_name)
				lspconfig[server_name].setup({
					on_attach = on_attach,
				})
			end,
		})
	end,
}
