return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim", "nvim", "bit" } },
						completion = { callSnippet = "Replace" },
					},
				},
			},
			graphql = {
				filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
			},
			emmet_ls = {
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
			},
			eslint = {
				filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less" },
				root_dir = require("lspconfig.util").root_pattern(
					".eslintrc",
					".eslintrc.json",
					"package.json",
					".git"
				),
			},
			marksman = {
				filetypes = { "markdown", "markdown.mdx" },
			},
			ts_ls = {
				filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
				root_dir = require("lspconfig.util").root_pattern("package.json", "tsconfig.json", ".git"),
				single_file_support = false,
			},
		},
	},
	config = function(_, opts)
		local lspconfig = require("lspconfig")
		local Snacks = require("snacks")
		local keymap = vim.keymap

		-- ================================
		-- LSP Keymaps (on attach)
		-- ================================
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local buf = ev.buf
				local function map(mode, lhs, rhs, desc)
					keymap.set(mode, lhs, rhs, { buffer = buf, silent = true, desc = desc })
				end

				-- Navigation
				map("n", "gd", function()
					Snacks.picker.lsp_definitions()
				end, "Go to definition")
				map("n", "gD", function()
					Snacks.picker.lsp_declarations()
				end, "Go to declaration")
				map("n", "gi", function()
					Snacks.picker.lsp_implementations()
				end, "Go to implementations")
				map("n", "gr", function()
					Snacks.picker.lsp_references()
				end, "Show references")
				map("n", "gt", function()
					Snacks.picker.lsp_type_definitions()
				end, "Go to type definitions")
				map("n", "<leader>ss", function()
					Snacks.picker.lsp_symbols()
				end, "Show LSP symbols")
				map("n", "<leader>sS", function()
					Snacks.picker.lsp_workspace_symbols()
				end, "Show workspace symbols")

				-- Actions
				map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code actions")
				map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

				-- Diagnostics
				map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
				map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic")
				map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic")

				-- Misc
				map("n", "K", vim.lsp.buf.hover, "Hover documentation")
				map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")
			end,
		})

		-- ================================
		-- Capabilities (for cmp)
		-- ================================
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- ================================
		-- Diagnostics UI
		-- ================================
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- ================================
		-- LSP Server configurations
		-- ================================
		for name, server_opts in pairs(opts.servers) do
			server_opts.capabilities = capabilities
			lspconfig[name].setup(server_opts)
		end

		-- ================================
		-- Markdown formatting (async prettier)
		-- ================================
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.md", "*.markdown" },
			callback = function()
				vim.system({ "prettier", "--write", vim.api.nvim_buf_get_name(0) })
			end,
		})
	end,
}
