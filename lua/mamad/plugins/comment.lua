return {
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = false },
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			-- local api = require("Comment.api")
			vim.keymap.set("n", "<Leader>/", "gcc", { desc = "Comment it.", remap = true })
			vim.keymap.set("v", "<Leader>/", "gc", { desc = "Comment it.", remap = true })
		end,
	},
}
