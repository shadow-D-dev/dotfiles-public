---@class ColorScheme
---@field bg string
---@field bg_dark string
---@field bg_float string
---@field bg_highlight string
---@field bg_popup string
---@field bg_search string
---@field bg_sidebar string
---@field bg_statusline string
---@field bg_visual string
---@field border string
---@field fg string
---@field fg_dark string
---@field fg_float string
---@field fg_gutter string
---@field fg_sidebar string

return {
  {
    "craftzdog/solarized-osaka.nvim",
    priority = 1000,
    config = function()
      local transparent = true

      local bg = "#002b36"
      local bg_dark = "#073642"
      local bg_highlight = "#586e75"
      local bg_search = "#b58900"
      local bg_visual = "#268bd2"
      local fg = "#839496"
      local fg_dark = "#657b83"
      local fg_gutter = "#586e75"
      local border = "#93a1a1"

      require("solarized-osaka").setup({
        transparent = transparent,
        styles = {
          sidebars = transparent and "transparent" or "dark",
          floats = transparent and "transparent" or "dark",
        },
        on_colors = function(colors)
          ---@type ColorScheme
          colors.bg = bg
          colors.bg_dark = transparent and colors.none or bg_dark
          colors.bg_float = transparent and colors.none or bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = transparent and colors.none or bg_dark
          colors.bg_statusline = transparent and colors.none or bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
      })

      vim.cmd("colorscheme solarized-osaka")
    end,
  },
}
