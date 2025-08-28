return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
  init = function()
    local function apply_markdown_highlights()
      -- Headline backgrounds
      local color1_bg = "#5b4996 "
      local color2_bg = "#21925b"
      local color3_bg = "#027d95"
      local color4_bg = "#585c89"
      local color5_bg = "#0f857c"
      local color6_bg = "#396592"
      -- glossy optional
      -- local color1_bg = "#987afb"
      -- local color2_bg = "#37f499"
      -- local color3_bg = "#04d1f9"
      -- local color4_bg = "#949ae5"
      -- local color5_bg = "#19dfcf"
      -- local color6_bg = "#1682ef"
      local color_fg = "#000000"

      vim.cmd(string.format("highlight Headline1Bg guifg=%s guibg=%s", color_fg, color1_bg))
      vim.cmd(string.format("highlight Headline2Bg guifg=%s guibg=%s", color_fg, color2_bg))
      vim.cmd(string.format("highlight Headline3Bg guifg=%s guibg=%s", color_fg, color3_bg))
      vim.cmd(string.format("highlight Headline4Bg guifg=%s guibg=%s", color_fg, color4_bg))
      vim.cmd(string.format("highlight Headline5Bg guifg=%s guibg=%s", color_fg, color5_bg))
      vim.cmd(string.format("highlight Headline6Bg guifg=%s guibg=%s", color_fg, color6_bg))

      vim.cmd("highlight Headline1Fg cterm=bold gui=bold guifg=" .. color1_bg)
      vim.cmd("highlight Headline2Fg cterm=bold gui=bold guifg=" .. color2_bg)
      vim.cmd("highlight Headline3Fg cterm=bold gui=bold guifg=" .. color3_bg)
      vim.cmd("highlight Headline4Fg cterm=bold gui=bold guifg=" .. color4_bg)
      vim.cmd("highlight Headline5Fg cterm=bold gui=bold guifg=" .. color5_bg)
      vim.cmd("highlight Headline6Fg cterm=bold gui=bold guifg=" .. color6_bg)

      vim.api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { fg = "#d4a72c", bg = "NONE" })

      -- Bold text highlights
      local bold_color = "#d4a72c"
      local bold_opts = { fg = bold_color, bold = true }
      for _, group in ipairs({
        "@markup.strong.markdown",
        "@markup.strong",
        "@text.strong",
        "markdownBold",
        "Bold",
      }) do
        vim.api.nvim_set_hl(0, group, bold_opts)
      end
    end

    -- Apply now (in case theme is already loaded)
    apply_markdown_highlights()

    -- Re-apply after every colorscheme change (essential for tokyonight)
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = apply_markdown_highlights,
    })
  end,
  opts = {
    bullet = { enabled = true },
    code = {
      style = "language",
      width = "block",
      right_pad = 0,
      line_padding = false,
    },
    checkbox = {
      enabled = true,
      position = "inline",
      unchecked = {
        icon = "   󰄱 ",
        highlight = "RenderMarkdownUnchecked",
        scope_highlight = nil,
      },
      checked = {
        icon = "   󰱒 ",
        highlight = "RenderMarkdownChecked",
        scope_highlight = nil,
      },
    },
    html = {
      enabled = true,
      comment = { conceal = false },
    },
    heading = {
      sign = false,
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      backgrounds = {
        "Headline1Bg",
        "Headline2Bg",
        "Headline3Bg",
        "Headline4Bg",
        "Headline5Bg",
        "Headline6Bg",
      },
      foregrounds = {
        "Headline1Fg",
        "Headline2Fg",
        "Headline3Fg",
        "Headline4Fg",
        "Headline5Fg",
        "Headline6Fg",
      },
    },
  },
}
