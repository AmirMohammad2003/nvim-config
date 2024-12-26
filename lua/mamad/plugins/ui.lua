return {
	{ "j-hui/fidget.nvim", opts = {} },
	{
		"RRethy/base16-nvim",
		config = function()
			require("base16-colorscheme").setup()
		end,
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
		rocks = {
			"magick",
		},
	},
	{
		"3rd/image.nvim",
		dependencies = { "vhyrro/luarocks.nvim" },
		opts = {
			backend = "kitty", --  this doesn't work with warp yet.
			processor = "magick_rock",
			hijack_file_patterns = {
				"*.png",
				"*.jpg",
				"*.jpeg",
				"*.gif",
				"*.svg",
				"*.bmp",
				"*.ico",
				"*.webp",
				"*.avif",
			},
		},
	},
}
