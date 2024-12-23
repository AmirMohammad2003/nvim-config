return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<Leader>gs", vim.cmd.Git, { desc = "Git status" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		opts = {},
	},
}
