require("config.keymaps")
require("config.options")
require("config.lazy")
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
})
--If you want the automatic import try to make that file return table if you can't do so you have to manually import them
