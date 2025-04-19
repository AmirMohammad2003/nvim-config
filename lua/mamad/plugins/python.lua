return {
	"amirmohammad2003/venv-selector.nvim",
	dependencies = {
		"neovim/nvim-lspconfig",
		-- "mfussenegger/nvim-dap",
		-- "mfussenegger/nvim-dap-python",
		"nvim-telescope/telescope.nvim",
	},
	opts = {},
	branch = "regexp",
	keys = {
		{ "<leader>vs", "<cmd>VenvSelect<cr>" },
		{ "<leader>vc", "<cmd>VenvSelectCached<cr>" },
	},
}
