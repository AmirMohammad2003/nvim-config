if vim.g.vscode then
	return {}
end

return {
	"nvim-telescope/telescope.nvim",
	tag = "0.1.8",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fF", function()
			builtin.find_files({
				cwd = vim.fn.stdpath("config"),
			})
		end, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fp", builtin.git_files, { desc = "Telescope find in git files" })
		vim.keymap.set("n", "<leader>fs", function()
			builtin.grep_string({ search = vim.fn.input("Grep > ") })
		end, { desc = "Telescope grep string" })

		vim.keymap.set(
			"n",
			"<leader>fw",
			builtin.current_buffer_fuzzy_find,
			{ desc = "Telescope current buffer fuzzy find" }
		)

		vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

		require("mamad.plugins.telescope.multigrep").setup()

		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({}),
				},
				fzf = {},
			},
		})
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("vstask")
		require("telescope").load_extension("fzf")
	end,
}
