return {
	"echasnovski/mini.files",

	opts = function(_, opts)
		opts.mappings = vim.tbl_deep_extend("force", opts.mappings or {}, {
			close = "q",
			go_in = "l",
			go_in_plus = "<CR>",
			go_out = "H",
			go_out_plus = "h",
			reset = "<BS>",
			reveal_cwd = ".",
			show_help = "g?",
			synchronize = "s",
			trim_left = "<",
			trim_right = ">",
		})

		opts.custom_keymaps = {
			copy_to_clipboard = "<space>yy",
			paste_from_clipboard = "<space>p",
		}

		opts.windows = vim.tbl_deep_extend("force", opts.windows or {}, {
			preview = true,
			width_focus = 30,
			width_preview = 80,
		})

		opts.options = vim.tbl_deep_extend("force", opts.options or {}, {
			use_as_default_explorer = true,
			permanent_delete = false,
		})

		return opts
	end,
	keys = {
		{
			"<leader>m",
			function()
				local buf = vim.api.nvim_buf_get_name(0)
				local dir = (buf ~= "" and vim.fn.fnamemodify(buf, ":p:h")) or vim.uv.cwd()

				if buf ~= "" and vim.fn.filereadable(buf) == 1 then
					require("mini.files").open(buf, true)
				elseif vim.fn.isdirectory(dir) == 1 then
					require("mini.files").open(dir, true)
				else
					require("mini.files").open(vim.uv.cwd(), true)
				end
			end,
			desc = "MiniFiles (reveal current file)",
		},
		{
			"<leader>M",
			function()
				require("mini.files").open(vim.uv.cwd(), true)
			end,
			desc = "MiniFiles (CWD)",
		},
	},
}
