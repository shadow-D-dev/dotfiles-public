-- This plugin is for the fancy tabs kinda like vs code
return {
	"akinsho/bufferline.nvim",
	enable = false,
	event = "VeryLazy",
	keys = {
		{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
		{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
	},
	opts = {
		options = {
			mode = "tabs",
			show_buffer_close_icons = false,
			show_close_icon = false,
		},
	},
}
