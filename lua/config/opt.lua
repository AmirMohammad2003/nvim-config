vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.laststatus = 3

vim.opt.mouse = "a"

vim.opt.showtabline = 1

vim.opt.showmode = false

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = "split"

vim.opt.cursorline = false

vim.opt.scrolloff = 10

vim.opt.undofile = true

vim.opt.guicursor = ""

vim.opt.virtualedit = "block"

if vim.fn.has("nvim-0.10") == 0 then
	vim.opt.termguicolors = true
end

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
