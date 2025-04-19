return {
	"echasnovski/mini.nvim",
	config = function()
		--  https://github.com/echasnovski/mini.nvim
		require("mini.ai").setup({ n_lines = 500 })
		require("mini.cursorword").setup()
	end,
}
