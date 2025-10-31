if vim.g.vscode then
	return {}
end

local map = vim.keymap.set
return {
	-- for neovim config
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	-- lsp configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"stevearc/conform.nvim",
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"j-hui/fidget.nvim",
			"saghen/blink.cmp",
		},
		config = function()
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("blink.cmp").get_lsp_capabilities()
			)

			require("mason").setup({})

			local ensure_installed = { "lua_ls", "stylua" }
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			---@diagnostic disable-next-line: missing-fields
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						vim.lsp.enable(server_name)
					end,
				},
			})
			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("blink.cmp").get_lsp_capabilities()
			)

			-- local hoverApi = vim.lsp.buf.hover
			-- local hoverFunc = function(opts)
			-- 	opts = opts or {}
			-- 	opts.border = opts.border or "rounded"
			-- 	return hoverApi(opts)
			-- end
			-- vim.lsp.buf.hover = hoverFunc

			-- This is where you enable features that only work
			-- if there is a language server active in the file
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					-- map("n", "K", vim.cmd("lua vim.lsp.buf.hover()<cr>"), opts)

					map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					map("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					map("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					map("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					map("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					map("n", "<Leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = "Rename", buffer = event.buf })
					-- replaced by conform
					-- map('n', '<Leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
					map("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
					map("n", "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", {
						desc = "Code action",
						buffer = event.buf,
					})
					map("n", "<Leader>ld", "<cmd>lua vim.diagnostic.open_float()<cr>", {
						desc = "Open diagnostics",
						buffer = event.buf,
					})

					local builtin = require("telescope.builtin")
					map("n", "<leader>ls", builtin.lsp_document_symbols, {
						desc = "Search document symbols",
						buffer = event.buf,
					})

					map("n", "<leader>le", builtin.diagnostics, {
						desc = "Search diagnostics",
						buffer = event.buf,
					})
				end,
			})
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		config = function()
			require("null-ls").setup({})
		end,
	},

	{ "nvimtools/none-ls.nvim", config = true },

	{ "williamboman/mason.nvim", config = true },
	-- Auto format
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>lf",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = {}
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					lsp_format_opt = "never"
				else
					lsp_format_opt = "fallback"
				end
				return {
					timeout_ms = 500,
					lsp_format = lsp_format_opt,
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				cpp = { "my_cpp_formatter" },
			},
			formatters = {
				my_cpp_formatter = {
					command = "clang-format",
					args = '--style="{IndentWidth: 4}"',
				},
			},
		},
	},
	-- autopair
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
