if vim.loader then
  vim.loader.enable()
end

_G.dd = function(...)
  require("util.debug").dump(...)
end
vim.print = _G.dd

require("config.lazy")
-- Set bold markdown to red
vim.api.nvim_set_hl(0, "@markup.strong.markdown", { fg = "#ff0000", bold = true })
