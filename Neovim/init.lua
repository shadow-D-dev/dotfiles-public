-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" -- sets lazypath to the preferred dir
if not (vim.uv or vim.loop).fs_stat(lazypath) then -- checks if lazy.nvim in that dir or not 
	local lazyrepo = "https://github.com/folke/lazy.nvim.git" -- if not it clones it 
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then -- if got any error  then this will throw error
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath) -- adds lazypath to neovims runtime path

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
    {import="plugins"} -- imports all the files inside the lua/plugins skipping manual imports 
	},

  ui = {
    custom_keys = {
      ["<localleader>d"] = function(plugin)
        dd(plugin)
      end,
    },

    border = "rounded",
    wrap = true,
    size = {
      width = 0.8,
      height = 0.8,
    },
    backdrop = 40,
    pills = true,
  },
	-- automatically check for plugin updates
	checker = { enabled = true },
})
require("config.options") --manual imports for the config folder files
require("config.keymaps")
