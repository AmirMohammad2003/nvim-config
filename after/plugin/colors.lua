function SetColorScheme(color)
	-- color = color or "base16-gruvbox-dark-medium"
	vim.cmd.colorscheme(color)
	vim.cmd([[hi EndOfBuffer guifg=#f6db05]])
	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

	-- vim.cmd("hi CursorLineNr guifg=#ff0000")
	-- vim.opt.cursorline = true
	-- vim.opt.cursorlineopt = "number"
end

SetColorScheme("base16-gruvbox-dark-medium")
