Vim�UnDo� �`<C���
��t3��l���C��D3ͺ   V                 	       	   	   	    g���    _�                            ����                                                                                                                                                                                                                                                                                                                                      6          V       g͖q     �              6   <local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"   2if not (vim.uv or vim.loop).fs_stat(lazypath) then   ;  local lazyrepo = "https://github.com/folke/lazy.nvim.git"   l  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })      if vim.v.shell_error ~= 0 then       vim.api.nvim_echo({   5      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },         { out, "WarningMsg" },   '      { "\nPress any key to exit..." },       }, true, {})       vim.fn.getchar()       os.exit(1)     end   end   vim.opt.rtp:prepend(lazypath)       require("lazy").setup({   
  spec = {   )    -- add LazyVim and import its plugins   6    { "LazyVim/LazyVim", import = "lazyvim.plugins" },   (    -- import/override with your plugins       { import = "plugins" },     },     defaults = {   j    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.   x    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.       lazy = false,   g    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,   C    -- have outdated releases, which may break your Neovim install.   8    version = false, -- always use the latest git commit   a    -- version = "*", -- try installing the latest stable version for plugins that support semver     },   4  install = { colorscheme = { "solarized-osaka" } },     checker = {   <    enabled = true, -- check for plugin updates periodically   '    notify = false, -- notify on update   .  }, -- automatically check for plugin updates         performance = {       rtp = {   !      -- disable some rtp plugins         disabled_plugins = {           "gzip",           -- "matchit",           -- "matchparen",           -- "netrwPlugin",           "tarPlugin",           "tohtml",           "tutor",           "zipPlugin",         },       },     },   })5��            6                      ;             5�_�      	                      ����                                                                                                                                                                                                                                                                                                                                                V       g͖z     �       X           �              5��                   V                      �	      5�_�                 	           ����                                                                                                                                                                                                                                                                                                                                                V       g���    �          W          <local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"�         W      	vim.fn.system({   		"git",   
		"clone",   		"--filter=blob:none",   +		"https://github.com/folke/lazy.nvim.git",   -		"--branch=stable", -- latest stable release   		lazypath,   	})�      W   W   G   		spec = {   '		-- add LazyVim and import its plugins   		{   			"LazyVim/LazyVim",   			import = "lazyvim.plugins",   			opts = {   $				colorscheme = "solarized-osaka",   				news = {   					lazyvim = true,   					neovim = true,   				},   			},   		},   #		-- import any extras modules here   7		{ import = "lazyvim.plugins.extras.linting.eslint" },   <		{ import = "lazyvim.plugins.extras.formatting.prettier" },   8		{ import = "lazyvim.plugins.extras.lang.typescript" },   2		{ import = "lazyvim.plugins.extras.lang.json" },   9		-- { import = "lazyvim.plugins.extras.lang.markdown" },   2		{ import = "lazyvim.plugins.extras.lang.rust" },   6		{ import = "lazyvim.plugins.extras.lang.tailwind" },   4		-- { import = "lazyvim.plugins.extras.dap.core" },   2		-- { import = "lazyvim.plugins.extras.vscode" },   =		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },   5		-- { import = "lazyvim.plugins.extras.test.core" },   8		-- { import = "lazyvim.plugins.extras.coding.yanky" },   =		-- { import = "lazyvim.plugins.extras.editor.mini-files" },   8		-- { import = "lazyvim.plugins.extras.util.project" },   		{ import = "plugins" },   	},   	defaults = {   h		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.   v		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.   		lazy = false,   e		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,   A		-- have outdated releases, which may break your Neovim install.   6		version = false, -- always use the latest git commit   _		-- version = "*", -- try installing the latest stable version for plugins that support semver   	},   	dev = {   		path = "~/.ghq/github.com",   	},   H	checker = { enabled = true }, -- automatically check for plugin updates   	performance = {   		cache = {   			enabled = true,   			-- disable_events = {},   		},   			rtp = {   			-- disable some rtp plugins   			disabled_plugins = {   				"gzip",   				-- "matchit",   				-- "matchparen",   				"netrwPlugin",   				"rplugin",   				"tarPlugin",   				"tohtml",   				"tutor",   				"zipPlugin",   			},   		},   	},   	ui = {   		custom_keys = {   (			["<localleader>d"] = function(plugin)   				dd(plugin)   			end,   		},   	},   	debug = false,5��           F      F      G      �      /	      �                       e       �       �       �                                                  5�_�              	              ����                                                                                                                                                                                                                                                                                                                                                             g͖~    �      W   W   G   
  spec = {   )    -- add LazyVim and import its plugins       {         "LazyVim/LazyVim",   !      import = "lazyvim.plugins",         opts = {   (        colorscheme = "solarized-osaka",           news = {             lazyvim = true,             neovim = true,   
        },         },       },   %    -- import any extras modules here   9    { import = "lazyvim.plugins.extras.linting.eslint" },   >    { import = "lazyvim.plugins.extras.formatting.prettier" },   :    { import = "lazyvim.plugins.extras.lang.typescript" },   4    { import = "lazyvim.plugins.extras.lang.json" },   ;    -- { import = "lazyvim.plugins.extras.lang.markdown" },   4    { import = "lazyvim.plugins.extras.lang.rust" },   8    { import = "lazyvim.plugins.extras.lang.tailwind" },   6    -- { import = "lazyvim.plugins.extras.dap.core" },   4    -- { import = "lazyvim.plugins.extras.vscode" },   ?    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },   7    -- { import = "lazyvim.plugins.extras.test.core" },   :    -- { import = "lazyvim.plugins.extras.coding.yanky" },   ?    -- { import = "lazyvim.plugins.extras.editor.mini-files" },   :    -- { import = "lazyvim.plugins.extras.util.project" },       { import = "plugins" },     },     defaults = {   j    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.   x    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.       lazy = false,   g    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,   C    -- have outdated releases, which may break your Neovim install.   8    version = false, -- always use the latest git commit   a    -- version = "*", -- try installing the latest stable version for plugins that support semver     },   	  dev = {       path = "~/.ghq/github.com",     },   I  checker = { enabled = true }, -- automatically check for plugin updates     performance = {       cache = {         enabled = true,         -- disable_events = {},       },       rtp = {   !      -- disable some rtp plugins         disabled_plugins = {           "gzip",           -- "matchit",           -- "matchparen",           "netrwPlugin",           "rplugin",           "tarPlugin",           "tohtml",           "tutor",           "zipPlugin",         },       },     },     ui = {       custom_keys = {   +      ["<localleader>d"] = function(plugin)           dd(plugin)   
      end,       },     },     debug = false,�         W        vim.fn.system({   
    "git",       "clone",       "--filter=blob:none",   -    "https://github.com/folke/lazy.nvim.git",   /    "--branch=stable", -- latest stable release       lazypath,     })�          W      <local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"5��           F      F      G      �      /	      �                       e       �       �       �                                                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                       6           V        g�[�     �       7       6   ?-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"   5-- if not (vim.uv or vim.loop).fs_stat(lazypath) then   >--   local lazyrepo = "https://github.com/folke/lazy.nvim.git"   o--   local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })   #--   if vim.v.shell_error ~= 0 then   --     vim.api.nvim_echo({   8--       { "Failed to clone lazy.nvim:\n", "ErrorMsg" },   --       { out, "WarningMsg" },   *--       { "\nPress any key to exit..." },   --     }, true, {})   --     vim.fn.getchar()   --     os.exit(1)   --   end   -- end    -- vim.opt.rtp:prepend(lazypath)   --   -- require("lazy").setup({   --   spec = {   ,--     -- add LazyVim and import its plugins   9--     { "LazyVim/LazyVim", import = "lazyvim.plugins" },   +--     -- import/override with your plugins   --     { import = "plugins" },   --   },   --   defaults = {   m--     -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.   {--     -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.   --     lazy = false,   j--     -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,   F--     -- have outdated releases, which may break your Neovim install.   ;--     version = false, -- always use the latest git commit   d--     -- version = "*", -- try installing the latest stable version for plugins that support semver   --   },   7--   install = { colorscheme = { "solarized-osaka" } },   --   checker = {   ?--     enabled = true, -- check for plugin updates periodically   *--     notify = false, -- notify on update   1--   }, -- automatically check for plugin updates   --   --   performance = {   --     rtp = {   $--       -- disable some rtp plugins   --       disabled_plugins = {   --         "gzip",   --         -- "matchit",   --         -- "matchparen",   --         -- "netrwPlugin",   --         "tarPlugin",   --         "tohtml",   --         "tutor",   --         "zipPlugin",   --       },   	--     },   --   },   -- })5��            6       6               ;      �      5�_�                           ����                                                                                                                                                                                                                                                                                                                                       7           V        g�[�     �          6      -- �          7       5��                                                  �                                                �                                                �                                                  5�_�                            ����                                                                                                                                                                                                                                                                                                                            X           �           V        g�[�     �         7    �         7   V   <local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"   &if not vim.loop.fs_stat(lazypath) then   	vim.fn.system({   		"git",   
		"clone",   		"--filter=blob:none",   +		"https://github.com/folke/lazy.nvim.git",   -		"--branch=stable", -- latest stable release   		lazypath,   	})   end   vim.opt.rtp:prepend(lazypath)       require("lazy").setup({   		spec = {   '		-- add LazyVim and import its plugins   		{   			"LazyVim/LazyVim",   			import = "lazyvim.plugins",   			opts = {   $				colorscheme = "solarized-osaka",   				news = {   					lazyvim = true,   					neovim = true,   				},   			},   		},   #		-- import any extras modules here   7		{ import = "lazyvim.plugins.extras.linting.eslint" },   <		{ import = "lazyvim.plugins.extras.formatting.prettier" },   8		{ import = "lazyvim.plugins.extras.lang.typescript" },   2		{ import = "lazyvim.plugins.extras.lang.json" },   9		-- { import = "lazyvim.plugins.extras.lang.markdown" },   2		{ import = "lazyvim.plugins.extras.lang.rust" },   6		{ import = "lazyvim.plugins.extras.lang.tailwind" },   4		-- { import = "lazyvim.plugins.extras.dap.core" },   2		-- { import = "lazyvim.plugins.extras.vscode" },   =		{ import = "lazyvim.plugins.extras.util.mini-hipatterns" },   5		-- { import = "lazyvim.plugins.extras.test.core" },   8		-- { import = "lazyvim.plugins.extras.coding.yanky" },   =		-- { import = "lazyvim.plugins.extras.editor.mini-files" },   8		-- { import = "lazyvim.plugins.extras.util.project" },   		{ import = "plugins" },   	},   	defaults = {   h		-- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.   v		-- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.   		lazy = false,   e		-- It's recommended to leave version=false for now, since a lot the plugin that support versioning,   A		-- have outdated releases, which may break your Neovim install.   6		version = false, -- always use the latest git commit   _		-- version = "*", -- try installing the latest stable version for plugins that support semver   	},   	dev = {   		path = "~/.ghq/github.com",   	},   H	checker = { enabled = true }, -- automatically check for plugin updates   	performance = {   		cache = {   			enabled = true,   			-- disable_events = {},   		},   			rtp = {   			-- disable some rtp plugins   			disabled_plugins = {   				"gzip",   				-- "matchit",   				-- "matchparen",   				"netrwPlugin",   				"rplugin",   				"tarPlugin",   				"tohtml",   				"tutor",   				"zipPlugin",   			},   		},   	},   	ui = {   		custom_keys = {   (			["<localleader>d"] = function(plugin)   				dd(plugin)   			end,   		},   	},   	debug = false,   })5��                   V                      �	      5�_�                            ����                                                                                                                                                                                                                                                                                                                            W           �           V        g�[�    �      W   �   G   
  spec = {   )    -- add LazyVim and import its plugins       {         "LazyVim/LazyVim",   !      import = "lazyvim.plugins",         opts = {   (        colorscheme = "solarized-osaka",           news = {             lazyvim = true,             neovim = true,   
        },         },       },   %    -- import any extras modules here   9    { import = "lazyvim.plugins.extras.linting.eslint" },   >    { import = "lazyvim.plugins.extras.formatting.prettier" },   :    { import = "lazyvim.plugins.extras.lang.typescript" },   4    { import = "lazyvim.plugins.extras.lang.json" },   ;    -- { import = "lazyvim.plugins.extras.lang.markdown" },   4    { import = "lazyvim.plugins.extras.lang.rust" },   8    { import = "lazyvim.plugins.extras.lang.tailwind" },   6    -- { import = "lazyvim.plugins.extras.dap.core" },   4    -- { import = "lazyvim.plugins.extras.vscode" },   ?    { import = "lazyvim.plugins.extras.util.mini-hipatterns" },   7    -- { import = "lazyvim.plugins.extras.test.core" },   :    -- { import = "lazyvim.plugins.extras.coding.yanky" },   ?    -- { import = "lazyvim.plugins.extras.editor.mini-files" },   :    -- { import = "lazyvim.plugins.extras.util.project" },       { import = "plugins" },     },     defaults = {   j    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.   x    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.       lazy = false,   g    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,   C    -- have outdated releases, which may break your Neovim install.   8    version = false, -- always use the latest git commit   a    -- version = "*", -- try installing the latest stable version for plugins that support semver     },   	  dev = {       path = "~/.ghq/github.com",     },   I  checker = { enabled = true }, -- automatically check for plugin updates     performance = {       cache = {         enabled = true,         -- disable_events = {},       },       rtp = {   !      -- disable some rtp plugins         disabled_plugins = {           "gzip",           -- "matchit",           -- "matchparen",           "netrwPlugin",           "rplugin",           "tarPlugin",           "tohtml",           "tutor",           "zipPlugin",         },       },     },     ui = {       custom_keys = {   +      ["<localleader>d"] = function(plugin)           dd(plugin)   
      end,       },     },     debug = false,�         �        vim.fn.system({   
    "git",       "clone",       "--filter=blob:none",   -    "https://github.com/folke/lazy.nvim.git",   /    "--branch=stable", -- latest stable release       lazypath,     })�          �      <local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"5��           F      F      G      �      /	      �                       e       �       �       �                                                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                       7           V        g�[�     �         6      --5��                          @                      �                         B                      5��