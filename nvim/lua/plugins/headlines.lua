return {
  "lukas-reineke/headlines.nvim",
  enabled = true,
  ft = { "markdown", "norg", "rmd", "org" },
  opts = function()
    return {
      markdown = {
        -- Apply these highlights per heading level
        headline_highlights = {
          "Headline1Bg",
          "Headline2Bg",
          "Headline3Bg",
          "Headline4Bg",
          "Headline5Bg",
          "Headline6Bg",
        },
        -- Optional bullet styling
        bullets = { "#", "##", "###", "####" },
        bullet_highlight = "HeadlineBullet",
        dash_highlight = "HeadlineDash",
        fat_headlines = false,
        codeblock_highlight = false, -- Disable code block highlighting
      },
    }
  end,
  init = function()
    vim.cmd([[
      highlight CodeBlock guibg=#1e1e2e
      highlight CodeBlockBorder guifg=#5c6370
    ]])

    -- Headline colors
    local color1_bg = "#5b4996"
    local color2_bg = "#21925b"
    local color3_bg = "#027d95"
    local color4_bg = "#585c89"
    local color5_bg = "#0f857c"
    local color6_bg = "#396592"
    local color_fg = "#000000"

    -- Backgrounds for each heading level
    vim.cmd(string.format([[highlight Headline1Bg guibg=%s guifg=%s]], color1_bg, color_fg))
    vim.cmd(string.format([[highlight Headline2Bg guibg=%s guifg=%s]], color2_bg, color_fg))
    vim.cmd(string.format([[highlight Headline3Bg guibg=%s guifg=%s]], color3_bg, color_fg))
    vim.cmd(string.format([[highlight Headline4Bg guibg=%s guifg=%s]], color4_bg, color_fg))
    vim.cmd(string.format([[highlight Headline5Bg guibg=%s guifg=%s]], color5_bg, color_fg))
    vim.cmd(string.format([[highlight Headline6Bg guibg=%s guifg=%s]], color6_bg, color_fg))

    -- Optional: color for list bullets
    vim.cmd([[highlight HeadlineBullet guifg=#FFD580]])
    -- Optional: color for horizontal rules (---)
    vim.cmd([[highlight HeadlineDash guifg=#AAAAAA]])
    -- Remove CodeBlock highlight to prevent overriding transparency
    vim.cmd([[highlight clear CodeBlock]])
  end,
}
