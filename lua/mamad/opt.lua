local set = vim.opt

set.number = true
set.relativenumber = true

set.laststatus = 3

set.mouse = "a"

set.showtabline = 1

set.showmode = false

set.ignorecase = true
set.smartcase = true

set.signcolumn = "yes"

set.updatetime = 250

set.splitright = true
set.splitbelow = true

set.inccommand = "split"

set.cursorline = false

set.scrolloff = 10

set.undofile = true

set.guicursor = ""

set.virtualedit = "block"

if vim.fn.has("nvim-0.10") == 0 then
	set.termguicolors = true
end

vim.schedule(function()
	set.clipboard = "unnamedplus"
	set.tabstop = 4
	set.shiftwidth = 4
	set.expandtab = true
end)
