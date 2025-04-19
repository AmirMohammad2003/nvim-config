return {
	"echasnovski/mini.nvim",
	config = function()
		--  https://github.com/echasnovski/mini.nvim
		require("mini.ai").setup({ n_lines = 500 })
		-- require("mini.surround").setup()

		-- local statusline = require("mini.statusline")
		-- statusline.setup({ use_icons = vim.g.have_nerd_font })

		---@diagnostic disable-next-line: duplicate-set-field
		-- statusline.section_location = function()
		-- 	return "%2l:%-2v"
		-- end
		--
		-- require("mini.tabline").setup({
		-- 	show_icons = true,
		-- 	format = nil,
		-- 	set_vim_settings = false,
		-- 	tabpage_section = "left",
		-- })

		require("mini.cursorword").setup()
	end,
}
