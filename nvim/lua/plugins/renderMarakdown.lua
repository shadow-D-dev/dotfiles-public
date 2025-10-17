return {
  "MeanderingProgrammer/render-markdown.nvim",
  enabled = true,
  init = function()
    local function apply_markdown_highlights()
      -- local color1_bg = "#268bd2" -- blue (original Solarized blue)
      -- local color2_bg = "#2aa198" -- cyan / teal
      -- local color3_bg = "#859900" -- green
      -- local color4_bg = "#b58900" -- yellow / gold
      -- local color5_bg = "#cb4b16" -- orange
      -- local color6_bg = "#5b4996" -- magenta
      -- glossy optional
      local color1_bg = "#5b4996 "
      local color2_bg = "#21925b"
      local color3_bg = "#027d95"
      local color4_bg = "#585c89"
      local color5_bg = "#0f857c"
      local color6_bg = "#396592"
      local color_fg = "#202020"
      vim.cmd(string.format("highlight Headline1Bg guifg=%s guibg=%s", color1_bg, color_fg))
      vim.cmd(string.format("highlight Headline2Bg guifg=%s guibg=%s", color2_bg, color_fg))
      vim.cmd(string.format("highlight Headline3Bg guifg=%s guibg=%s", color3_bg, color_fg))
      vim.cmd(string.format("highlight Headline4Bg guifg=%s guibg=%s", color4_bg, color_fg))
      vim.cmd(string.format("highlight Headline5Bg guifg=%s guibg=%s", color5_bg, color_fg))
      vim.cmd(string.format("highlight Headline6Bg guifg=%s guibg=%s", color6_bg, color_fg))

      vim.cmd("highlight Headline1Fg cterm=bold gui=bold guifg=" .. color1_bg)
      vim.cmd("highlight Headline2Fg cterm=bold gui=bold guifg=" .. color2_bg)
      vim.cmd("highlight Headline3Fg cterm=bold gui=bold guifg=" .. color3_bg)
      vim.cmd("highlight Headline4Fg cterm=bold gui=bold guifg=" .. color4_bg)
      vim.cmd("highlight Headline5Fg cterm=bold gui=bold guifg=" .. color5_bg)
      vim.cmd("highlight Headline6Fg cterm=bold gui=bold guifg=" .. color6_bg)
      -- Bullet highlights
      -- vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = "#2aa198" })

      -- TODO / Checkbox highlights
      -- vim.api.nvim_set_hl(0, "RenderMarkdownChecked", { fg = "#268bd2", bold = true })
      -- vim.api.nvim_set_hl(0, "RenderMarkdownUnchecked", { fg = "#268bd2" })
      vim.api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { bg = "#202020" })

      -- Bold text highlights
      local bold_color = "#b58900"
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
    apply_markdown_highlights()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = apply_markdown_highlights,
    })
  end,
  --
  opts = {
    -- render_modes = true,
    -- anti_conceal = { enabled = false },
    bullet = { enabled = true },
    code = {
      language = true,
      -- style = "none",
      style = "language",
      width = "block",
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
      sign = true,
      width = "block",
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
