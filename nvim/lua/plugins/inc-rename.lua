-- Let's you replace the words faster, the current keymap is Leadger+r+n
-- return {
--   "smjonas/inc-rename.nvim",
--   cmd = "IncRename",
--   config = true,
-- }

return {
  "smjonas/inc-rename.nvim",
  event = "LspAttach",
  config = function()
    require("inc_rename").setup({
      input_buffer_type = "dressing", -- nicer UI if you use dressing.nvim; otherwise remove
    })

    vim.keymap.set("n", "<leader>rn", function()
      return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true })
  end,
}
