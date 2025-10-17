
return {
  "arnamak/stay-centered.nvim",
  config = function()
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        require("stay-centered").setup()
      end,
    })
  end,
}
