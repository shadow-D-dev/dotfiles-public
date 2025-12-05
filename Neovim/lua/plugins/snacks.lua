return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	layout = {
		root = true,
		type = "row",
		items = { ... },
	},
	opts = {
		animate = {
			enabled = true,
		},
		-- bigfile starts here
		bigfile = { enabled = false, size = 1.5 * 1024 * 1024, lines = 20000, notify = true },
		-- bigfile ends here
		-- bufdelete starts here
		bufdelete = { enabled = false },
		-- bufdelete ends here
		--indent starts here

		indent = {
			enabled = true,
			animate = {
				enabled = true,
				style = "out",
				easing = "linear",
				delay = 1,
				duration = 20,
			},
			scope = {
				enabled = true,
				highlight = "SnacksIndentScope",
			},
			highlight = "SnacksIndent",
			char = "│",
			show_first_indent_level = false,
			show_trailing_blankline_indent = false,
		},
		-- indent ends here
		-- input starts here
		input = {
			enabled = true,
			border = "rounded",
			title_pos = "center",
			relative = "editor",
			row = 0.5,
			col = 0.5,
			width = 40,
			win_options = {
				winblend = 0,
			},
			animate = {
				enabled = true,
				style = "slide",
				duration = 200,
			},
		},
		-- input ends here
		-- notifier starts here
		notifier = {
			enabled = true,
			timeout = 3000,
			animation = {
				enabled = true,
				style = "slide_in_slide_out",
				duration = 300,
			},
			history = {
				enabled = true,
				size = 50,
			},
		},

		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = {
			enabled = false,
		},

		statuscolumn = {
			enabled = true,
			relative = true,
			folds = {
				open = "",
				closed = "",
				auto = true,
				fillchars = true,
			},
			signs = {
				colwidth = 2,
				priority = 10,
			},
			numbers = {
				enabled = true,
				style = "relative",
			},
			click = {
				enabled = true,
				folds = true,
				signs = true,
				numbers = true,
			},
		},
		terminal = {
			enabled = false,
		},
		toggle = {},
		words = { enabled = true },
		styles = {
			notification = {},
		},

		explorer = { enabled = true },
		picker = {
			enabled = true,
			sources = {
				files = {
					hidden = true, -- include dotfiles
					ignored = false, -- include .gitignored files too (optional)
				},
			},
			layout = "ivy",
			hidden = true,
			ignored = true,
			layouts = {
				ivy = {
					layout = {
						box = "vertical",
						backdrop = true,
						row = -1,
						width = 0,
						height = 0.4,
						border = "top",
						title = " {title} {live} {flags}",
						title_pos = "left",
						{ win = "input", height = 1, border = "bottom" },
						{
							box = "horizontal",
							{ win = "list", border = "none" },
							{ win = "preview", title = "{preview}", width = 0.5, border = "left" },
						},
					},
				},
				vertical = {
					layout = {
						backdrop = false,
						width = 0.8,
						min_width = 80,
						height = 0.8,
						min_height = 30,
						box = "vertical",
						border = "rounded",
						title = "{title} {live} {flags}",
						title_pos = "center",
						{ win = "input", height = 1, border = "bottom" },
						{ win = "list", border = "none" },
						{ win = "preview", title = "{preview}", height = 0.4, border = "top" },
					},
				},
			},
		},

		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "Esc", desc = "Quit", action = ":qa" },
				},
				header = [[
 ███████╗██╗  ██╗ █████╗ ██████╗  ██████╗ ██╗    ██╗
 ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔═══██╗██║    ██║
 ███████╗███████║███████║██║  ██║██║   ██║██║ █╗ ██║
 ╚════██║██╔══██║██╔══██║██║  ██║██║   ██║██║███╗██║
 ███████║██║  ██║██║  ██║██████╔╝╚██████╔╝╚███╔███╔╝
 ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚══╝╚══╝
      ]],
			},
		},
	},
	keys = {
		{
			"<leader>,",
			function()
				Snacks.picker.buffers({
					layout = "select",
				})
			end,
			desc = "Buffers",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files({
					layout = "ivy",
				})
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fp",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},

		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		-- explorer keybinding
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
	},
}
