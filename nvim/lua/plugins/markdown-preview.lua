return {
  "iamcco/markdown-preview.nvim",
  ft = { "markdown" }, -- load only for markdown files
  cmd = { "MarkdownPreview", "MarkdownPreviewToggle", "MarkdownPreviewStop" },
  build = function()
    vim.fn["mkdp#util#install"]()
  end,
  init = function()
    -- Limit plugin to markdown files only
    vim.g.mkdp_filetypes = { "markdown" }

    -- Uncomment this line if you want the preview to auto-start
    -- when you open a markdown file
    -- vim.g.mkdp_auto_start = 1

    -- Uncomment to auto-close preview when you leave the buffer
    -- vim.g.mkdp_auto_close = 1
  end,
  keys = {
    {
      "<leader>tp",
      "<cmd>MarkdownPreviewToggle<CR>",
      desc = "Toggle Markdown Preview",
      ft = "markdown",
    },
  },
}
