return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    style = "night", -- Options: "storm", "night", "moon", "day"
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
    on_colors = function(colors)
      -- Ensure transparency by setting background to none
      colors.bg = "NONE"
      colors.bg_dark = "NONE"
      colors.bg_sidebar = "NONE"
      colors.bg_statusline = "NONE"
      colors.bg_float = "NONE"
    end,
    custom_highlights = function()
      -- Define Tokyo Night colors
      local colors = {
        bg = "NONE",
        bg_dark = "NONE",
        bg_highlight = "#292e42",
        bg_search = "#3d59a1",
        bg_visual = "#33467C",
        fg = "#c0caf5",
        fg_dark = "#a9b1d6",
        fg_gutter = "#3b4261",
        border = "#565f89",
        red = "#f7768e",
        yellow = "#e0af68",
        blue = "#7aa2f7",
      }

      return {
        -- Matches Catppuccin highlight names but uses Tokyo Night colors

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
        CursorLine = { bg = "NONE" },

        -- Color of repeated words
        illuminatedWordText = { bg = colors.yellow },

        -- Comments color tweak
        Comment = { fg = colors.fg_gutter },

        -- Floating windows & popups
        NormalFloat = { bg = "NONE" },
        Pmenu = { bg = "NONE", fg = colors.fg },

        -- Borders
        FloatBorder = { fg = colors.border, bg = "NONE" },
        WinSeparator = { fg = colors.border },

        -- Remove background from folded markdown sections
        Folded = { bg = "NONE" },
      }
    end,
  },
}
