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
			build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
		},
	},
	config = function()
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
		vim.keymap.set("n", "<leader>fp", builtin.git_files, { desc = "Telescope find in git files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
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

		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown({
						-- even more opts
					}),

					-- pseudo code / specification for writing custom displays, like the one
					-- for "codeactions"
					-- specific_opts = {
					--   [kind] = {
					--     make_indexed = function(items) -> indexed_items, width,
					--     make_displayer = function(widths) -> displayer
					--     make_display = function(displayer) -> function(e)
					--     make_ordinal = function(e) -> string
					--   },
					--   -- for example to disable the custom builtin "codeactions" display
					--      do the following
					--   codeactions = false,
					-- }
				},
				fzf = {},
			},
		})
		-- To get ui-select loaded and working with telescope, you need to call
		-- load_extension, somewhere after setup function:
		require("telescope").load_extension("ui-select")
		require("telescope").load_extension("vstask")
		require("telescope").load_extension("fzf")
	end,
}
