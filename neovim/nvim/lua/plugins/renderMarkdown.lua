return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    enables = true,
  },

  config = function()
    -- Manually define background colors (adjust as needed)
    local bg_colors = {
      "#073642", -- Dark cyan (H1)
      "#586e75", -- Grayish blue (H2)
      "#657b83", -- Soft gray (H3)
      "#839496", -- Light gray-blue (H4)
      "#93a1a1", -- Very light gray (H5)
      "#eee8d5", -- Beige (H6)
    }

    -- Force text color to black and set custom background colors
    for i = 1, 6 do
      vim.cmd(string.format("highlight Headline%dBg guifg=#000000 guibg=%s", i, bg_colors[i]))
    end
  end,

  require("blink.cmp").setup({
    sources = {
      default = { "lsp", "path", "snippets", "buffer", "markdown" },
      providers = {
        markdown = {
          name = "RenderMarkdown",
          module = "render-markdown.integ.blink",
          fallbacks = { "lsp" },
        },
      },
    },
  }),
}
