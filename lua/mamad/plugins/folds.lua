return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			"luukvbaal/statuscol.nvim",
		},
		event = "BufReadPost",
		init = function()
			vim.o.foldenable = true
			vim.o.foldlevelstart = 99
			vim.o.foldlevel = 99
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.o.foldcolumn = "1"
		end,
		config = function()
			-- straight out of the documentation
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end

			---@diagnostic disable-next-line: missing-fields
			require("ufo").setup({
				fold_virt_text_handler = handler,
			})
		end,
	},

	{
		"luukvbaal/statuscol.nvim",
		config = function()
			local builtin = require("statuscol.builtin")
			require("statuscol").setup({
				setopt = true,
				thousands = false,
				relculright = false,
				-- Builtin 'statuscolumn' options
				ft_ignore = nil, -- lua table with 'filetype' values for which 'statuscolumn' will be unset
				bt_ignore = nil, -- lua table with 'buftype' values for which 'statuscolumn' will be unset
				segments = {
					{
						text = { builtin.foldfunc, " " },
						click = "v:lua.ScFa",
					},
					{
						text = { builtin.lnumfunc, " " },
						condition = { true, builtin.not_empty },
						click = "v:lua.ScLa",
					},
					{
						text = { "%s" },
						click = "v:lua.ScSa",
						colwidth = 1,
						maxwidth = 1,
					},
				},
				clickmod = "c", -- modifier used for certain actions in the builtin clickhandlers:
				-- "a" for Alt, "c" for Ctrl and "m" for Meta.
				clickhandlers = {
					Lnum = builtin.lnum_click,
					FoldClose = builtin.foldclose_click,
					FoldOpen = builtin.foldopen_click,
					FoldOther = builtin.foldother_click,
					DapBreakpointRejected = builtin.toggle_breakpoint,
					DapBreakpoint = builtin.toggle_breakpoint,
					DapBreakpointCondition = builtin.toggle_breakpoint,
					["diagnostic/signs"] = builtin.diagnostic_click,
					gitsigns = builtin.gitsigns_click,
				},
			})
		end,
	},
}
