Vim�UnDo� �,$[��lk�1�/�i������Ǭ���k�   P                                   g�   
 _�                             ����                                                                                                                                                                                                                                                                                                                                                             g��     �                   �               5��                   5                      �      5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             g��    �          6          return {5��                                                  5�_�                    2        ����                                                                                                                                                                                                                                                                                                                                                             g�~    �   1   2          '      vim.cmd("colorscheme tokyonight")5��    1                      �      (               5�_�                    1        ����                                                                                                                                                                                                                                                                                                                                                             g�     �   1   3   4    5��    1                      �                     �    1                      �                     5�_�                    2        ����                                                                                                                                                                                                                                                                                                                                                             g�     �   2   4   5    �   2   3   5    5��    2                      �              -       5�_�                    3        ����                                                                                                                                                                                                                                                                                                                                                             g�    �   2   4   6      ,vim.cmd("hi Folded guibg=NONE ctermbg=NONE")5��    2                      �                     5�_�                    2        ����                                                                                                                                                                                                                                                                                                                                                             g�Y     �   1   3   6       5��    1                   )   �              )       �    1   (                 �                    5�_�      	              2   5    ����                                                                                                                                                                                                                                                                                                                                                             g�f     �   1   3   6      5-- this is the options added for manual no background5��    1   4                  �                     �    1   3                  �                     �    1   2                  �                     �    1   1                  �                     �    1   0                  �                     �    1   /                  �                     �    1   .                  �                     �    1   -                  �                     �    1   ,                  �                     �    1   +              	   �             	       �    1   3                  �                     �    1   2                  �                     �    1   1                  �                     �    1   0                  �                     �    1   /                 �                    �    1   C                  �                     �    1   B                  �                     �    1   A                  �                     �    1   @                 �                    5�_�      
           	   2   L    ����                                                                                                                                                                                                                                                                                                                                                             g�v    �   1   3   6      M-- this is the options added for manual no green background for makdown folds5��    1                      �                     5�_�   	              
   6        ����                                                                                                                                                                                                                                                                                                                                                             g�^     �   6            5��    6                      -                     5�_�   
                 7        ����                                                                                                                                                                                                                                                                                                                                                             g�_     �   7            �   7            5��    7               D       .              ]      5�_�                            ����                                                                                                                                                                                                                                                                                                                            6                      v        g�b    �       7   {   6   return {     {       "folke/tokyonight.nvim",       lazy = false,       priority = 1000,       config = function()   >      local transparent = true -- Set to true for transparency       '      -- Define TokyoNight color values         local bg = "#1a1b26"         local bg_dark = "#16161e"   $      local bg_highlight = "#292e42"   !      local bg_search = "#3d59a1"   !      local bg_visual = "#33467C"         local fg = "#c0caf5"         local fg_dark = "#a9b1d6"   !      local fg_gutter = "#3b4261"         local border = "#565f89"       #      require("tokyonight").setup({   D        style = "night", -- Options: "storm", "night", "moon", "day"   "        transparent = transparent,           terminal_colors = true,           styles = {   '          comments = { italic = true },   (          keywords = { italic = false },   &          functions = { bold = true },             variables = {},   =          sidebars = transparent and "transparent" or "dark",   ;          floats = transparent and "transparent" or "dark",   
        },   $        on_colors = function(colors)             colors.bg = bg   A          colors.bg_dark = transparent and colors.none or bg_dark   B          colors.bg_float = transparent and colors.none or bg_dark   ,          colors.bg_highlight = bg_highlight   #          colors.bg_popup = bg_dark   &          colors.bg_search = bg_search   D          colors.bg_sidebar = transparent and colors.none or bg_dark   G          colors.bg_statusline = transparent and colors.none or bg_dark   &          colors.bg_visual = bg_visual              colors.border = border             colors.fg = fg   "          colors.fg_dark = fg_dark             colors.fg_float = fg   &          colors.fg_gutter = fg_gutter   %          colors.fg_sidebar = fg_dark           end,         })   S      -- this is the options added for manual no green background for makdown folds   2      vim.cmd("hi Folded guibg=NONE ctermbg=NONE")       end,     },   }5��            6       6               -      �      5�_�                   {        ����                                                                                                                                                                                                                                                                                                                                       7           V        g�     �   {            5��    {                      +                     5�_�                    |        ����                                                                                                                                                                                                                                                                                                                                       7           V        g�     �   |            �   |            5��    |               H       ,              �      5�_�                    8        ����                                                                                                                                                                                                                                                                                                                            {           8           v        g�
     �   7   9   �   D   return {     "folke/tokyonight.nvim",     lazy = false,     priority = 1000,   
  opts = {   .    transparent = true, -- Enable transparency       terminal_colors = true,       styles = {   #      comments = { italic = true },   $      keywords = { italic = false },   "      functions = { bold = true },         variables = {},         sidebars = "transparent",         floats = "transparent",       },   "    custom_highlights = function()   +      -- Define Tokyo Night colors manually         local colors = {           bg = "#1a1b26",           bg_dark = "#16161e",   !        bg_highlight = "#292e42",           bg_search = "#3d59a1",           bg_visual = "#33467c",           fg = "#c0caf5",           fg_dark = "#a9b1d6",           fg_gutter = "#3b4261",           border = "#3b4261",           red = "#f7768e",           yellow = "#e0af68",           blue = "#7aa2f7",         }             return {   I        -- Matches Catppuccin highlight names but uses Tokyo Night colors       %        -- Highlight for selected tab   ,        TabLineSel = { bg = colors.yellow },       %        -- Selected buffer text color   :        BufferLineBufferSelected = { fg = colors.yellow },       #        -- Spectre highlight colors   =        DiffChange = { bg = colors.bg_visual, fg = "black" },   7        DiffDelete = { bg = colors.red, fg = "black" },       -        -- Visual mode highlighted text color   9        Visual = { bg = colors.bg_visual, fg = "white" },                -- Cursor line highlight   -        CursorLine = { bg = colors.bg_dark },       "        -- Color of repeated words   5        illuminatedWordText = { bg = colors.yellow },               -- Comments color tweak   ,        Comment = { fg = colors.fg_gutter },       $        -- Floating windows & popups   &        NormalFloat = { bg = "none" },   8        Pmenu = { bg = colors.bg_dark, fg = colors.fg },               -- Borders   :        FloatBorder = { fg = colors.border, bg = "none" },   .        WinSeparator = { fg = colors.border },         }       end,     },   }5��    7       C              �      \              5�_�                    8        ����                                                                                                                                                                                                                                                                                                                            8           8           v        g�    �   7   9   �              return {5��    7                      �                     5�_�                    ~        ����                                                                                                                                                                                                                                                                                                                            8           8           v        g�M     �   ~   �       5��    ~                      �                     �    ~                      �                     5�_�                           ����                                                                                                                                                                                                                                                                                                                            8           8           v        g�T     �      �   �    �      �   �    5��                          �              0       5�_�                            ����                                                                                                                                                                                                                                                                                                                            8           8           v        g�U    �   ~              5��    ~                      �                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                       6           V        g��     �              6   -- return {   --   {   --     "folke/tokyonight.nvim",   --     lazy = false,   --     priority = 1000,   --     config = function()   A--       local transparent = true -- Set to true for transparency   --   *--       -- Define TokyoNight color values   --       local bg = "#1a1b26"   "--       local bg_dark = "#16161e"   '--       local bg_highlight = "#292e42"   $--       local bg_search = "#3d59a1"   $--       local bg_visual = "#33467C"   --       local fg = "#c0caf5"   "--       local fg_dark = "#a9b1d6"   $--       local fg_gutter = "#3b4261"   !--       local border = "#565f89"   --   &--       require("tokyonight").setup({   G--         style = "night", -- Options: "storm", "night", "moon", "day"   %--         transparent = transparent,   "--         terminal_colors = true,   --         styles = {   *--           comments = { italic = true },   +--           keywords = { italic = false },   )--           functions = { bold = true },   --           variables = {},   @--           sidebars = transparent and "transparent" or "dark",   >--           floats = transparent and "transparent" or "dark",   --         },   '--         on_colors = function(colors)   --           colors.bg = bg   D--           colors.bg_dark = transparent and colors.none or bg_dark   E--           colors.bg_float = transparent and colors.none or bg_dark   /--           colors.bg_highlight = bg_highlight   &--           colors.bg_popup = bg_dark   )--           colors.bg_search = bg_search   G--           colors.bg_sidebar = transparent and colors.none or bg_dark   J--           colors.bg_statusline = transparent and colors.none or bg_dark   )--           colors.bg_visual = bg_visual   #--           colors.border = border   --           colors.fg = fg   %--           colors.fg_dark = fg_dark   !--           colors.fg_float = fg   )--           colors.fg_gutter = fg_gutter   (--           colors.fg_sidebar = fg_dark   --         end,   --       })   V--       -- this is the options added for manual no green background for makdown folds   5--       vim.cmd("hi Folded guibg=NONE ctermbg=NONE")   --     end,   --   },   -- }5��            6                       �              5�_�                            ����                                                                                                                                                                                                                                                                                                                                                  V        g��    �                  5��                                                  5�_�                    I        ����                                                                                                                                                                                                                                                                                                                                       I           V        g��     �   I            5��    I                      #                     5�_�                    J        ����                                                                                                                                                                                                                                                                                                                                       I           V        g��     �   J            �   J            5��    J               W       $              
      5�_�                            ����                                                                                                                                                                                                                                                                                                                            I                      V        g��     �              I   return {     "folke/tokyonight.nvim",     lazy = false,     priority = 1000,   
  opts = {   @    style = "night", -- Options: "storm", "night", "moon", "day"   .    transparent = true, -- Enable transparency       terminal_colors = true,       styles = {   #      comments = { italic = true },   $      keywords = { italic = false },   "      functions = { bold = true },         variables = {},         sidebars = "transparent",         floats = "transparent",       },   "    custom_highlights = function()   "      -- Define Tokyo Night colors         local colors = {           bg = "#1a1b26",           bg_dark = "#16161e",   !        bg_highlight = "#292e42",           bg_search = "#3d59a1",           bg_visual = "#33467C",           fg = "#c0caf5",           fg_dark = "#a9b1d6",           fg_gutter = "#3b4261",           border = "#565f89",           red = "#f7768e",           yellow = "#e0af68",           blue = "#7aa2f7",         }             return {   I        -- Matches Catppuccin highlight names but uses Tokyo Night colors       %        -- Highlight for selected tab   ,        TabLineSel = { bg = colors.yellow },       %        -- Selected buffer text color   :        BufferLineBufferSelected = { fg = colors.yellow },       #        -- Spectre highlight colors   =        DiffChange = { bg = colors.bg_visual, fg = "black" },   7        DiffDelete = { bg = colors.red, fg = "black" },       -        -- Visual mode highlighted text color   9        Visual = { bg = colors.bg_visual, fg = "white" },                -- Cursor line highlight   -        CursorLine = { bg = colors.bg_dark },       "        -- Color of repeated words   5        illuminatedWordText = { bg = colors.yellow },               -- Comments color tweak   ,        Comment = { fg = colors.fg_gutter },       $        -- Floating windows & popups   &        NormalFloat = { bg = "none" },   8        Pmenu = { bg = colors.bg_dark, fg = colors.fg },               -- Borders   :        FloatBorder = { fg = colors.border, bg = "none" },   .        WinSeparator = { fg = colors.border },       :        -- Remove background from folded markdown sections   !        Folded = { bg = "none" },         }       end,     },   /  vim.cmd("hi Folded guibg=NONE ctermbg=NONE"),   }5��            I                       #              5�_�                           ����                                                                                                                                                                                                                                                                                                                                                  V        g��   	 �          X          return {5��                                                  5�_�                     P        ����                                                                                                                                                                                                                                                                                                                            P           V           V        g�
   
 �   O   P            config = function()   G    -- Ensure Folded sections and general background remain transparent   0    vim.cmd("hi Normal guibg=NONE ctermbg=NONE")   2    vim.cmd("hi NormalNC guibg=NONE ctermbg=NONE")   0    vim.cmd("hi Folded guibg=NONE ctermbg=NONE")   5    vim.cmd("hi EndOfBuffer guibg=NONE ctermbg=NONE")     end,5��    O                      �      0              5�_�                            ����                                                                                                                                                                                                                                                                                                                            8           8           v        g�M     �      �   �    �      �   �       5��                          �                     5�_�                            ����                                                                                                                                                                                                                                                                                                                                       7           V        g��     �       8   {   7   return {     {       "folke/tokyonight.nvim",       lazy = false,       priority = 1000,       config = function()   >      local transparent = true -- Set to true for transparency       '      -- Define TokyoNight color values         local bg = "#1a1b26"         local bg_dark = "#16161e"   $      local bg_highlight = "#292e42"   !      local bg_search = "#3d59a1"   !      local bg_visual = "#33467C"         local fg = "#c0caf5"         local fg_dark = "#a9b1d6"   !      local fg_gutter = "#3b4261"         local border = "#565f89"       #      require("tokyonight").setup({   D        style = "night", -- Options: "storm", "night", "moon", "day"   "        transparent = transparent,           terminal_colors = true,           styles = {   '          comments = { italic = true },   (          keywords = { italic = false },   &          functions = { bold = true },             variables = {},   =          sidebars = transparent and "transparent" or "dark",   ;          floats = transparent and "transparent" or "dark",   
        },   $        on_colors = function(colors)             colors.bg = bg   A          colors.bg_dark = transparent and colors.none or bg_dark   B          colors.bg_float = transparent and colors.none or bg_dark   ,          colors.bg_highlight = bg_highlight   #          colors.bg_popup = bg_dark   &          colors.bg_search = bg_search   D          colors.bg_sidebar = transparent and colors.none or bg_dark   G          colors.bg_statusline = transparent and colors.none or bg_dark   &          colors.bg_visual = bg_visual              colors.border = border             colors.fg = fg   "          colors.fg_dark = fg_dark             colors.fg_float = fg   &          colors.fg_gutter = fg_gutter   %          colors.fg_sidebar = fg_dark           end,         })   S      -- this is the options added for manual no green background for makdown folds   2      vim.cmd("hi Folded guibg=NONE ctermbg=NONE")       end,     },   }    5��            7       7               �      .      5��