function SetColorScheme(color)
	color = color or "rose-pine-moon"
	vim.cmd.colorscheme(color)

	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

	vim.cmd("hi CursorLineNr guifg=#ff0000")
	vim.opt.cursorline = true
	vim.opt.cursorlineopt = "number"
end

SetColorScheme()
