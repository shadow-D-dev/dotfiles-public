local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.cmd([[
  augroup TransparentBackground
    autocmd!
    autocmd ColorScheme * highlight Normal guibg=NONE
    autocmd ColorScheme * highlight NormalFloat guibg=NONE
    autocmd ColorScheme * highlight Pmenu guibg=NONE
    autocmd ColorScheme * highlight StatusLine guibg=NONE
    autocmd ColorScheme * highlight WinSeparator guibg=NONE
  augroup END
]])
