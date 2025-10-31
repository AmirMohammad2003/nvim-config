if vim.g.vscode then return {} end

return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "nvim-treesitter/nvim-treesitter-context" },
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		---@diagnostic disable-next-line: missing-fields
		configs.setup({
			ensure_installed = {
				"c",
				"cpp",
				"python",
				"lua",
				"vim",
				"javascript",
				"html",
				"css",
				"markdown",
				"git_config",
				"gitcommit",
				"gitignore",
				"json",
				"make",
				"nginx",
				"toml",
				"yaml",
				"bash",
			},
			sync_install = false,
			auto_intsall = true,
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false, -- don't need this ever
			},
			indent = { enable = true },
		})

		-- these are default values
		require("treesitter-context").setup({
			enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			multiwindow = false, -- Enable multiwindow support.
			max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			line_numbers = true,
			multiline_threshold = 20, -- Maximum number of lines to show for a single context
			trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
			-- Separator between context and content. Should be a single character string, like '-'.
			-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			separator = nil,
			zindex = 20, -- The Z-index of the context window
			on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
		})
	end,
}
