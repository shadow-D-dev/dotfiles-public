--------------------------------------------------------------------
------------------------------MARKDOWN------------------------------
--------------------------------------------------------------------

----Markdown horizontal limit to 80 chars--------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append("t")

    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = 0,
      callback = function()
        local cursor = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[silent! execute "normal! gggqG"]])
        vim.api.nvim_win_set_cursor(0, cursor)
      end,
    })
  end,
})
