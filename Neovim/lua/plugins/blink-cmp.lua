return {
	"saghen/blink.cmp",
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		completion = {
			menu = {
				draw = {
					columns = {
						{ "label", gap = 10 }, -- the actual name
						{ "kind_icon", gap = 1 }, --kind is like snippets,etc and its icon
						{ "kind" },
						{ "label_description" }, --extra info like module or signature
					},
					gap = 1,
					treesitter = { "lsp" },
				},
			},
			list = {
				selection = { preselect = false, auto_insert = true },
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 100,
				window = {
					border = "rounded",
				},
			},
			ghost_text = { -- inline suggestions as we type , you type fu it will show function()
				enabled = true,
			},
		},
		keymap = {
			["<C-j>"] = { "select_next" },
			["<C-k>"] = { "select_prev" },
		},
		appearance = {
			nerd_font_variant = "mono",
		},
		sources = { --from where it will fetch the completion data
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" }, -- if another plugin wants to add its own sources this let it do so
}
