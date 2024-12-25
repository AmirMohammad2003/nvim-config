return {
	"stevearc/oil.nvim",
	opts = {},
	dependencies = {
		{
			"echasnovski/mini.icons",
			opts = {},
			config = function()
				require("mini.icons").setup({})
			end,
		},
	},
	config = function()
		require("oil").setup()
		vim.keymap.set("n", "<Leader>e", function()
			vim.cmd(":Oil")
		end, { desc = "Toggle file explorer" })
	end,
}
