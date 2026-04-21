return {
  "lukas-reineke/headlines.nvim",
  enabled = false,
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
        bullets = { "#", "##", "###", "####", "#####", "######" },
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

    local color1_bg = "#268bd2" -- blue (original Solarized blue)
    local color2_bg = "#2aa198" -- cyan / teal
    local color3_bg = "#859900" -- green
    local color4_bg = "#b58900" -- yellow / gold
    local color5_bg = "#cb4b16" -- orange
    local color6_bg = "#5b4996" -- magenta
    -- local color1_bg = "#5b4996"
    -- local color2_bg = "#21925b"
    -- local color3_bg = "#027d95"
    -- local color4_bg = "#585c89"
    -- local color5_bg = "#0f857c"
    -- local color6_bg = "#396592"
    local color_fg = "#000000"

    -- Backgrounds for each heading level
    vim.cmd(string.format([[highlight Headline1Bg guibg=%s guifg=%s]], color_fg, color1_bg))
    vim.cmd(string.format([[highlight Headline2Bg guibg=%s guifg=%s]], color_fg, color2_bg))
    vim.cmd(string.format([[highlight Headline3Bg guibg=%s guifg=%s]], color_fg, color3_bg))
    vim.cmd(string.format([[highlight Headline4Bg guibg=%s guifg=%s]], color_fg, color4_bg))
    vim.cmd(string.format([[highlight Headline5Bg guibg=%s guifg=%s]], color_fg, color5_bg))
    vim.cmd(string.format([[highlight Headline6Bg guibg=%s guifg=%s]], color_fg, color6_bg))

    -- Optional: color for list bullets
    vim.cmd([[highlight HeadlineBullet guifg=#FFD580]])
    -- Optional: color for horizontal rules (---)
    vim.cmd([[highlight HeadlineDash guifg=#AAAAAA]])
    -- Remove CodeBlock highlight to prevent overriding transparency
    vim.cmd([[highlight clear CodeBlock]])
  end,
}
