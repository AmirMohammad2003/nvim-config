return {
	"nvim-treesitter/nvim-treesitter",
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
	end,
}
