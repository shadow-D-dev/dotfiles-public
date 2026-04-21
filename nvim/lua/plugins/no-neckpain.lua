return {
  "shortcuts/no-neck-pain.nvim",
  version = "*",
  opts = {
    width = 100,
  },
  keys = {
    { "<leader>np", "<cmd>NoNeckPain<cr>", desc = "Toggle NoNeckPain" },
    { "<leader>n+", "<cmd>NoNeckPainWidthUp<cr>", desc = "Increase NoNeckPain Width" },
    { "<leader>n-", "<cmd>NoNeckPainWidthDown<cr>", desc = "Decrease NoNeckPain Width" },
  },
}
