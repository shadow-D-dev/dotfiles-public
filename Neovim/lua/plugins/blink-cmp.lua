return {
	"saghen/blink.cmp",
	enabled = true,
	event = "InsertEnter",
	version = "*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		completion = {
			menu = {
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None",
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
			["<S-k>"] = { "scroll_documentation_up", "fallback" },
			["<S-j>"] = { "scroll_documentation_down", "fallback" },
			["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
			["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		sources = { --from where it will fetch the completion data
			default = { "snippets", "lsp", "path", "buffer" },
		},
		snippets = {
			preset = "luasnip", -- Choose LuaSnip as the snippet engine
		},
	},
}
