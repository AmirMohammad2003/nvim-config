if vim.g.vscode then
	return {}
end

return {
	{ "tpope/vim-sleuth" },
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
	},
	-- {
	-- 	"ThePrimeagen/vim-be-good",
	-- 	event = "VeryLazy",
	-- },
	-- {
	-- 	"eandrju/cellular-automaton.nvim",
	-- 	event = "VeryLazy",
	-- },
}
