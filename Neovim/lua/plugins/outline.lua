-- This lets you view the file as an index with chapters & topics
return {
	"hedyhli/outline.nvim",
	config = function()
		vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>", { desc = "Toggle Outline" })
		require("outline").setup({})
	end,
}
