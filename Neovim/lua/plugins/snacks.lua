return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	layout = {
		root = true, -- this is essential
		type = "row",
		items = { ... },
	},
	opts = {
		bigfile = { enabled = false },
		explorer = { enabled = true },
		indent = {
			enabled = true,
		},
		input = { enabled = false },
		notifier = {
			enabled = false,
			timeout = 3000,
		},
		picker = {
			enabled = true,
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
		quickfile = { enabled = false },
		scope = { enabled = false },
		scroll = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = false },
		styles = {
			notification = {
				-- wo = { wrap = true } -- Wrap notifications
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
		-- explorer keybinding
		{
			"<leader><space>",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
	},
}
