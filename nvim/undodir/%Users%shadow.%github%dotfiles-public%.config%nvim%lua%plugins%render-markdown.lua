Vim�UnDo� n4���z���D�x
,x�?�78v����          	                           g�(�    _�                             ����                                                                                                                                                                                                                                                                                                                                                             g�"R     �                   �               5��                                          �      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             g�"S     �          	      {5��                                                  5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             g�"[    �       	   	      return{   0    'MeanderingProgrammer/render-markdown.nvim',   t    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite   |    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins   ~    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons        ---@module 'render-markdown'   !    ---@type render.md.UserConfig       opts = {},5��                               �      �      5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             g�&�     �      
   	    5��                          �                     �                          �                     5�_�                    	        ����                                                                                                                                                                                                                                                                                                                                                             g�&�     �         
       �   	   
   
    5��                          �              2      5�_�                    	        ����                                                                                                                                                                                                                                                                                                                                                             g�&�    �      
         require("blink.cmp").setup({�                     }5��                          !                     �                          �                     5�_�                             ����                                                                                                                                                                                                                                                                                                                                                 v���    g�(�    �                  return {   .  "MeanderingProgrammer/render-markdown.nvim",   r  dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite   z  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins   |  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons     ---@module 'render-markdown'     ---@type render.md.UserConfig     opts = {},     require("blink.cmp").setup({       sources = {   D      default = { "lsp", "path", "snippets", "buffer", "markdown" },         providers = {           markdown = {   "          name = "RenderMarkdown",   1          module = "render-markdown.integ.blink",              fallbacks = { "lsp" },   
        },         },       },     }),   }5��                                  $              5��