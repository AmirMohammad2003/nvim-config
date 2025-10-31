if vim.g.vscode then return {} end

local M = {
	{ "j-hui/fidget.nvim", opts = {} },
	{
		"RRethy/base16-nvim",
		config = function()
			require("base16-colorscheme").setup()
		end,
	},
	-- {
	-- 	"vhyrro/luarocks.nvim",
	-- 	priority = 1000, -- Very high priority is required.
	-- 	config = true,
	-- 	rocks = {
	-- 		"magick",
	-- 	},
	-- },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
		-- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
		---@module 'render-markdown'
		opts = {
			file_types = { "markdown", "copilot-chat" },
		},
	},
}

if os.getenv("TMUX") == nil then
	-- table.insert(M, {
	-- 	{
	-- 		"3rd/image.nvim",
	-- 		dependencies = { "vhyrro/luarocks.nvim" },
	-- 		opts = {
	-- 			backend = "kitty",
	-- 			processor = "magick_rock",
	-- 			hijack_file_patterns = {
	-- 				"*.png",
	-- 				"*.jpg",
	-- 				"*.jpeg",
	-- 				"*.gif",
	-- 				"*.svg",
	-- 				"*.bmp",
	-- 				"*.ico",
	-- 				"*.webp",
	-- 				"*.avif",
	-- 			},
	-- 		},
	-- 	},
	-- })
end

return M
