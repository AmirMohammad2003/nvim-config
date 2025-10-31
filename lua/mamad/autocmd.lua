local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

if vim.g.vscode then return {} end

local numbertogglegroup = augroup("numbertoggle", { clear = true })

autocmd({ "BufEnter", "FocusGained", "InsertLeave" }, {
	pattern = "*",
	callback = function()
		-- make sure we are not in terminal mode
		local type = vim.bo.buftype
		local filetype = vim.bo.filetype
		if type ~= "terminal" and filetype ~= "copilot-chat" then
			vim.opt.relativenumber = true
		end
	end,
	group = numbertogglegroup,
})
autocmd({ "BufLeave", "FocusLost", "InsertEnter" }, {
	pattern = "*",
	callback = function()
		local type = vim.bo.buftype
		local filetype = vim.bo.filetype
		if type ~= "terminal" and filetype ~= "copilot-chat" then
			vim.opt.relativenumber = false
		end
	end,
	group = numbertogglegroup,
})

autocmd("FileType", {
	desc = "Set filetype specific options",
	group = augroup("filetype", { clear = true }),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.spell = true
		vim.opt_local.spelllang = { "en_us" }
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
	end,
})

autocmd("FileType", {
	desc = "Disable line numbers in copilot-chat",
	group = augroup("copilot-chat", { clear = true }),
	pattern = { "copilot-chat" },
	callback = function()
		vim.opt_local.relativenumber = false
		vim.opt_local.number = false
	end,
})
