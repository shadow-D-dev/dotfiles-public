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
-- return {
--   "MeanderingProgrammer/render-markdown.nvim",
--   enabled = true,
--   init = function()
--     -- Headline colors
--     local color1_bg = "#5b4996"
--     local color2_bg = "#21925b"
--     local color3_bg = "#027d95"
--     local color4_bg = "#585c89"
--     local color5_bg = "#0f857c"
--     local color6_bg = "#396592"
--     local color_fg = "#000000"
--
--     vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], color_fg, color1_bg))
--     vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], color_fg, color2_bg))
--     vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], color_fg, color3_bg))
--     vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], color_fg, color4_bg))
--     vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], color_fg, color5_bg))
--     vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], color_fg, color6_bg))
--
--     vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color1_bg))
--     vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color2_bg))
--     vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color3_bg))
--     vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color4_bg))
--     vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color5_bg))
--     vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color6_bg))
--
--     vim.api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { fg = "#d4a72c", bg = "NONE" })
--
--     -- Make bold markdown text red (for all likely Treesitter + legacy highlight groups)
--     vim.api.nvim_set_hl(0, "@markup.strong.markdown", { fg = "#d4a72c", bold = true })
--     vim.api.nvim_set_hl(0, "@markup.strong", { fg = "#d4a72c", bold = true })
--     vim.api.nvim_set_hl(0, "@text.strong", { fg = "#d4a72c", bold = true })
--     vim.api.nvim_set_hl(0, "markdownBold", { fg = "#d4a72c", bold = true })
--     vim.api.nvim_set_hl(0, "Bold", { fg = "#d4a72c", bold = true })
--
--     -- Ensure highlights persist after colorscheme changes
--     vim.api.nvim_create_autocmd("ColorScheme", {
--       callback = function()
--         vim.api.nvim_set_hl(0, "@markup.strong.markdown", { fg = "#d4a72c", bold = true })
--         vim.api.nvim_set_hl(0, "@markup.strong", { fg = "#d4a72c", bold = true })
--         vim.api.nvim_set_hl(0, "@text.strong", { fg = "#d4a72c", bold = true })
--         vim.api.nvim_set_hl(0, "markdownBold", { fg = "#d4a72c", bold = true })
--         vim.api.nvim_set_hl(0, "Bold", { fg = "#d4a72c", bold = true })
--       end,
--     })
--   end,
--   opts = {
--     bullet = { enabled = true },
--
--     code = {
--       style = "language", -- Options: "none", "normal", "language", "full"
--       width = "block", -- Options: "block", "full"
--       right_pad = 0,
--       line_padding = false,
--     },
--     checkbox = {
--       enabled = true,
--       position = "inline",
--       unchecked = {
--         icon = "   󰄱 ",
--         highlight = "RenderMarkdownUnchecked",
--         scope_highlight = nil,
--       },
--       checked = {
--         icon = "   󰱒 ",
--         highlight = "RenderMarkdownChecked",
--         scope_highlight = nil,
--       },
--     },
--     html = {
--       enabled = true,
--       comment = { conceal = false },
--     },
--     heading = {
--       sign = false,
--       icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
--       backgrounds = {
--         "Headline1Bg",
--         "Headline2Bg",
--         "Headline3Bg",
--         "Headline4Bg",
--         "Headline5Bg",
--         "Headline6Bg",
--       },
--       foregrounds = {
--         "Headline1Fg",
--         "Headline2Fg",
--         "Headline3Fg",
--         "Headline4Fg",
--         "Headline5Fg",
--         "Headline6Fg",
--       },
--     },
--   },
-- }
-- return {
--   "MeanderingProgrammer/render-markdown.nvim",
--   enabled = true,
--   init = function()
--     -- Headline colors
--     local color1_bg = "#5b4996"
--     local color2_bg = "#21925b"
--     local color3_bg = "#027d95"
--     local color4_bg = "#585c89"
--     local color5_bg = "#0f857c"
--     local color6_bg = "#396592"
--     local color_fg = "#000000"
--
--     vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], color_fg, color1_bg))
--     vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], color_fg, color2_bg))
--     vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], color_fg, color3_bg))
--     vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], color_fg, color4_bg))
--     vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], color_fg, color5_bg))
--     vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], color_fg, color6_bg))
--
--     vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color1_bg))
--     vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color2_bg))
--     vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color3_bg))
--     vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color4_bg))
--     vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color5_bg))
--     vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color6_bg))
--
--     vim.api.nvim_set_hl(0, "RenderMarkdownCodeBorder", { fg = "#FF0000", bg = "NONE" })
--   end,
--   opts = {
--     bullet = { enabled = true },
--
--     code = {
--       style = "language", -- Options: "none", "normal", "language", "full"
--       width = "block", -- Options: "block", "full"
--       right_pad = 0,
--       line_padding = false,
--     },
--     checkbox = {
--       enabled = true,
--       position = "inline",
--       unchecked = {
--         icon = "   󰄱 ",
--         highlight = "RenderMarkdownUnchecked",
--         scope_highlight = nil,
--       },
--       checked = {
--         icon = "   󰱒 ",
--         highlight = "RenderMarkdownChecked",
--         scope_highlight = nil,
--       },
--     },
--     html = {
--       enabled = true,
--       comment = { conceal = false },
--     },
--     heading = {
--       sign = false,
--       icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
--       backgrounds = {
--         "Headline1Bg",
--         "Headline2Bg",
--         "Headline3Bg",
--         "Headline4Bg",
--         "Headline5Bg",
--         "Headline6Bg",
--       },
--       foregrounds = {
--         "Headline1Fg",
--         "Headline2Fg",
--         "Headline3Fg",
--         "Headline4Fg",
--         "Headline5Fg",
--         "Headline6Fg",
--       },
--     },
--   },
-- }
-- -- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/render-markdown.lua
-- -- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/render-markdown.lua
--
-- -- https://github.com/MeanderingProgrammer/markdown.nvim
-- --
-- -- When I hover over markdown headings, this plugins goes away, so I need to
-- -- edit the default highlights
-- -- I tried adding this as an autocommand, in the options.lua
-- -- file, also in the markdownl.lua file, but the highlights kept being overriden
-- -- so the inly way is the only way I was able to make it work was loading it
-- -- after the config.lazy in the init.lua file lamw25wmal
--
-- -- Require the colors.lua module and access the colors directly without
-- -- additional file reads
--
-- return {
--   "MeanderingProgrammer/render-markdown.nvim",
--   enabled = true,
--   -- Moved highlight creation out of opts as suggested by plugin maintainer
--   -- There was no issue, but it was creating unnecessary noise when ran
--   -- :checkhealth render-markdown
--   -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/138#issuecomment-2295422741
--   init = function()
--     -- Define color variables
--     -- local color1_bg =
--     -- local color2_bg =
--     -- local color3_bg =
--     -- local color4_bg =
--     -- local color5_bg =
--     -- local color6_bg =
--     -- local color_fg =
--     -- local color_sign = "#ebfafa"
--
-- local color1_bg = "#5b4996"
-- local color2_bg = "#21925b"
-- local color3_bg = "#027d95"
-- local color4_bg = "#585c89"
-- local color5_bg = "#0f857c"
-- local color6_bg = "#396592"
-- local color_fg="#000000"
--     -- Heading colors (when not hovered over), extends through the entire line
--     vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], color_fg, color1_bg))
--     vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], color_fg, color2_bg))
--     vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], color_fg, color3_bg))
--     vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], color_fg, color4_bg))
--     vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], color_fg, color5_bg))
--     vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], color_fg, color6_bg))
--
--     -- Highlight for the heading and sign icons (symbol on the left)
--     -- I have the sign disabled for now, so this makes no effect
--     vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color1_bg))
--     vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color2_bg))
--     vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color3_bg))
--     vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color4_bg))
--     vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color5_bg))
--     vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color6_bg))
--   end,
--   opts = {
--     bullet = {
--       -- Turn on / off list bullet rendering
--       enabled = true,
--     },
--     checkbox = {
--       -- Turn on / off checkbox state rendering
--       enabled = true,
--       -- Determines how icons fill the available space:
--       --  inline:  underlying text is concealed resulting in a left aligned icon
--       --  overlay: result is left padded with spaces to hide any additional text
--       position = "inline",
--       unchecked = {
--         -- Replaces '[ ]' of 'task_list_marker_unchecked'
--         icon = "   󰄱 ",
--         -- Highlight for the unchecked icon
--         highlight = "RenderMarkdownUnchecked",
--         -- Highlight for item associated with unchecked checkbox
--         scope_highlight = nil,
--       },
--       checked = {
--         -- Replaces '[x]' of 'task_list_marker_checked'
--         icon = "   󰱒 ",
--         -- Highlight for the checked icon
--         highlight = "RenderMarkdownChecked",
--         -- Highlight for item associated with checked checkbox
--         scope_highlight = nil,
--       },
--     },
--     html = {
--       -- Turn on / off all HTML rendering
--       enabled = true,
--       comment = {
--         -- Turn on / off HTML comment concealing
--         conceal = false,
--       },
--     },
--     heading = {
--       sign = false,
--       icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
--       backgrounds = {
--         "Headline1Bg",
--         "Headline2Bg",
--         "Headline3Bg",
--         "Headline4Bg",
--         "Headline5Bg",
--         "Headline6Bg",
--       },
--       foregrounds = {
--         "Headline1Fg",
--         "Headline2Fg",
--         "Headline3Fg",
--         "Headline4Fg",
--         "Headline5Fg",
--         "Headline6Fg",
--       },
--     },
--   },
-- }
