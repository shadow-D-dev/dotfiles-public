return {

  "developedbyed/marko.nvim",
  config = function()
    require("marko").setup({
      width = 100,
      height = 100,
      border = "rounded",
      title = " Marks ",
      default_keymap = false,
    })
  end,
  vim.keymap.set("n", '"', function()
    require("marko").show_marks()
  end, { desc = "Show marks popup" }),
}
-- to toggle the ui use '
