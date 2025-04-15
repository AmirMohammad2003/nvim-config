return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = {},
		config = function()
			require("toggleterm").setup()
			vim.keymap.set("n", "<leader>tt", function()
				require("toggleterm").toggle()
			end, { desc = "Toggle terminal" })

			vim.keymap.set({ "n", "t" }, "<F7>", function()
				require("toggleterm").toggle()
			end, { desc = "Toggle terminal" })

			vim.keymap.set(
				"n",
				"<leader>tf",
				"<cmd>ToggleTerm direction=float<cr>",
				{ desc = "Open floating terminal" }
			)
			vim.keymap.set(
				"n",
				"<leader>tv",
				"<cmd>ToggleTerm direction=vertical<cr>",
				{ desc = "Open vertical terminal" }
			)
			vim.keymap.set(
				"n",
				"<leader>th",
				"<cmd>ToggleTerm direction=horizontal<cr>",
				{ desc = "Open horizontal terminal" }
			)
			vim.keymap.set("n", "<leader>tb", "<cmd>ToggleTerm direction=tab<cr>", { desc = "Open tab terminal" })

			-- vim.keymap.set("t", "<ESC>", "<C-\\><C-n>", { remap = true })
			-- this is much more convienient
			function _G.set_terminal_keymaps()
				local opts = { noremap = true }
				vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)

				vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
				vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
				-- this one interferes with the default behavior of the terminal
				-- which is "clear screen"
				-- vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)

				vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")
				vim.api.nvim_command("autocmd TermEnter * setlocal signcolumn=no")
			end

			vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
		end,
	},
	{
		"willothy/flatten.nvim",
		config = true,
		-- or pass configuration with
		-- opts = {  }
		-- Ensure that it runs first to minimize delay when opening file from terminal
		lazy = false,
		priority = 1001,
	},
}
