local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

local numbertogglegroup = augroup("numbertoggle", { clear = true })

autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
	pattern = "*",
	callback = function()
		-- make sure we are not in terminal mode
		if vim.bo.buftype ~= "terminal" then
			vim.opt.relativenumber = true
		end
	end,
	group = numbertogglegroup,
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
	pattern = "*",
	callback = function()
		if vim.bo.buftype ~= "terminal" then
			vim.opt.relativenumber = false
		end
	end,
	group = numbertogglegroup,
})
