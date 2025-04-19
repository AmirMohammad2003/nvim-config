local map = vim.keymap.set
return {
	-- copilot
	{
		"zbirenbaum/copilot.lua",
		opts = {},
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})

			map("n", "<leader>cp", "<cmd>Copilot panel<cr>")
		end,
	},
	{

		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"zbirenbaum/copilot.lua",
			"nvim-lua/plenary.nvim",
			"MeanderingProgrammer/render-markdown.nvim",
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			highlight_headers = false,
			separator = "---",
			error_header = "> [!ERROR] Error",
		},
		config = function()
			require("CopilotChat").setup()
			map("n", "<leader>cc", "<cmd>CopilotChat<cr>")
		end,
	},
}
