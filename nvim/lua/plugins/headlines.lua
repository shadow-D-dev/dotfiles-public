local colors = require("config.colors")

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
    local color_fg = colors["linkarzu_color26"]
    vim.cmd([[
  highlight CodeBlock guibg=#1e1e2e
  highlight CodeBlockBorder guifg=#5c6370
]])
    -- Backgrounds for each heading level
    vim.cmd(string.format([[highlight Headline1Bg guibg=%s guifg=%s]], colors["linkarzu_color18"], color_fg))
    vim.cmd(string.format([[highlight Headline2Bg guibg=%s guifg=%s]], colors["linkarzu_color19"], color_fg))
    vim.cmd(string.format([[highlight Headline3Bg guibg=%s guifg=%s]], colors["linkarzu_color20"], color_fg))
    vim.cmd(string.format([[highlight Headline4Bg guibg=%s guifg=%s]], colors["linkarzu_color21"], color_fg))
    vim.cmd(string.format([[highlight Headline5Bg guibg=%s guifg=%s]], colors["linkarzu_color22"], color_fg))
    vim.cmd(string.format([[highlight Headline6Bg guibg=%s guifg=%s]], colors["linkarzu_color23"], color_fg))

    -- Optional: color for list bullets
    vim.cmd([[highlight HeadlineBullet guifg=#FFD580]])
    -- Optional: color for horizontal rules (---)
    vim.cmd([[highlight HeadlineDash guifg=#AAAAAA]])
    -- Remove CodeBlock highlight to prevent overriding transparency
    vim.cmd([[highlight clear CodeBlock]])
  end,
}
-- local colors = require("config.colors")
--
-- return {
--   "lukas-reineke/headlines.nvim",
--   enabled = true,
--   ft = { "markdown", "norg", "rmd", "org" },
--   opts = function()
--     return {
--       markdown = {
--         -- Apply these highlights per heading level
--         headline_highlights = {
--           "Headline1Bg",
--           "Headline2Bg",
--           "Headline3Bg",
--           "Headline4Bg",
--           "Headline5Bg",
--           "Headline6Bg",
--         },
--         -- Optional bullet styling
--         bullets = { "#", "##", "###", "####" },
--         bullet_highlight = "HeadlineBullet",
--         dash_highlight = "HeadlineDash",
--         fat_headlines = false,
--         codeblock_highlight = "CodeBlock",
--       },
--     }
--   end,
--   init = function()
--     local color_fg = colors["linkarzu_color26"]
--
--     -- Backgrounds for each heading level
--     vim.cmd(string.format([[highlight Headline1Bg guibg=%s guifg=%s]], colors["linkarzu_color18"], color_fg))
--     vim.cmd(string.format([[highlight Headline2Bg guibg=%s guifg=%s]], colors["linkarzu_color19"], color_fg))
--     vim.cmd(string.format([[highlight Headline3Bg guibg=%s guifg=%s]], colors["linkarzu_color20"], color_fg))
--     vim.cmd(string.format([[highlight Headline4Bg guibg=%s guifg=%s]], colors["linkarzu_color21"], color_fg))
--     vim.cmd(string.format([[highlight Headline5Bg guibg=%s guifg=%s]], colors["linkarzu_color22"], color_fg))
--     vim.cmd(string.format([[highlight Headline6Bg guibg=%s guifg=%s]], colors["linkarzu_color23"], color_fg))
--
--     -- Optional: color for list bullets
--     vim.cmd([[highlight HeadlineBullet guifg=#FFD580]])
--     -- Optional: color for horizontal rules (---)
--     vim.cmd([[highlight HeadlineDash guifg=#AAAAAA]])
--     -- Optional: highlight codeblocks differently
--     vim.cmd([[highlight CodeBlock guibg=#1e1e2e]])
--   end,
-- }
