-- This plugin is for the chapter view of the current file like you get the headings only 
return{
  "hedyhli/outline.nvim",
  config = function()
    vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
      { desc = "Toggle Outline" })
    require("outline").setup {
    }
  end,
}
