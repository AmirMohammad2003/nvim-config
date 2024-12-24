local map = vim.keymap.set

map("n", "<Leader>w", vim.cmd.w, { desc = "Save file" })
map("n", "<Leader>q", vim.cmd.q, { desc = "Close file" })

map("n", "<Leader>F", function()
	---@diagnostic disable-next-line: undefined-field
	if vim.opt.scrolloff._value ~= 10 then
		vim.opt.scrolloff = 10
	else
		vim.opt.scrolloff = 999
	end
end, { desc = "Keep cursor in middle" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>")

map("i", "jk", "<esc>", { desc = "Exit insert mode" })
map("t", "jk", "<esc>", { desc = "Exit insert mode" })

map("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

map("n", "<C-S>", "<Cmd>silent! update | redraw<CR>", { desc = "Save" })
map({ "i", "x" }, "<C-S>", "<Esc><Cmd>silent! update | redraw<CR>", { desc = "Save and go to Normal mode" })

map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

map("n", "<CR>", '@="m`o<C-V><Esc>``"<CR>')
map("n", "<S-CR>", '@="m`O<C-V><Esc>``"<CR>')

map("n", "gO", "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>")
map("n", "go", "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>")

map("n", "<leader>x", ":.lua<cr>")
map("v", "<leader>x", ":lua<cr>")
map("n", "<leader><leader>x", ":source %<cr>")

map("n", "<leader><leader>l", ":lua ")

map("n", "<leader>tt", vim.cmd.tabnew, { desc = "New tab" })
map("n", "<leader>tn", vim.cmd.tabnext, { desc = "Next tab" })
map("n", "<leader>tp", vim.cmd.tabprev, { desc = "Prev tab" })
map("n", "<leader>td", vim.cmd.tabclose, { desc = "Delete tab" })

map("n", "<leader>bd", vim.cmd.bdelete, { desc = "Delete buffer" })

map("n", "<leader>|", vim.cmd.vnew)
map("n", "<leader>\\", vim.cmd.new)
