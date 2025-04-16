return {
  "craftzdog/solarized-osaka.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true, -- Enable transparency
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = false },
      functions = { bold = true },
      variables = {},
      sidebars = "transparent",
      floats = "transparent",
    },
    custom_highlights = function()
      -- Define Solarized Osaka colors manually
      local colors = {
        bg = "#002b36",
        bg_dark = "#073642",
        bg_highlight = "#586e75",
        bg_search = "#b58900",
        bg_visual = "#657b83",
        fg = "#839496",
        fg_dark = "#93a1a1",
        fg_gutter = "#586e75",
        border = "#657b83",
        red = "#dc322f",
        yellow = "#b58900",
        blue = "#268bd2",
      }

      return {
        -- Matches Catppuccin highlight names but uses Solarized Osaka colors

        -- Highlight for selected tab
        TabLineSel = { bg = colors.yellow },

        -- Selected buffer text color
        BufferLineBufferSelected = { fg = colors.yellow },

        -- Spectre highlight colors
        DiffChange = { bg = colors.bg_visual, fg = "black" },
        DiffDelete = { bg = colors.red, fg = "black" },

        -- Visual mode highlighted text color
        Visual = { bg = colors.bg_visual, fg = "white" },

        -- Cursor line highlight
        CursorLine = { bg = colors.bg_dark },

        -- Color of repeated words
        illuminatedWordText = { bg = colors.yellow },

        -- Comments color tweak
        Comment = { fg = colors.fg_gutter },

        -- Floating windows & popups
        NormalFloat = { bg = "none" },
        Pmenu = { bg = colors.bg_dark, fg = colors.fg },

        -- Borders
        FloatBorder = { fg = colors.border, bg = "none" },
        WinSeparator = { fg = colors.border },
      }
    end,
  },
  vim.cmd("hi Folded guibg=NONE ctermbg=NONE"),
}
