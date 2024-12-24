return {
	-- for neovim config
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
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
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["clangd"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.clangd.setup({
							capabilities = capabilities,
							cmd = { "clangd", "--offset-encoding=utf-16" },
						})
					end,
				},
			})
			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("blink.cmp").get_lsp_capabilities()
			)

			-- This is where you enable features that only work
			-- if there is a language server active in the file
			vim.api.nvim_create_autocmd("LspAttach", {
				desc = "LSP actions",
				callback = function(event)
					local opts = { buffer = event.buf }

					vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
					vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
					vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
					vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
					vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
					vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
					vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
					vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
					vim.keymap.set(
						"n",
						"<Leader>lr",
						"<cmd>lua vim.lsp.buf.rename()<cr>",
						{ desc = "Rename", buffer = event.buf }
					)
					-- replaced by conform
					-- vim.keymap.set('n', '<Leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
					vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
					vim.keymap.set("n", "<Leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", {
						desc = "Code action",
						buffer = event.buf,
					})
					vim.keymap.set("n", "<Leader>ld", "<cmd>lua vim.diagnostic.open_float()<cr>", {
						desc = "Open diagnostics",
						buffer = event.buf,
					})

					local builtin = require("telescope.builtin")
					vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols, {
						desc = "Search document symbols",
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
	-- copilot
	{
		"zbirenbaum/copilot.lua",
		opts = {},
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})

			vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<cr>")
		end,
	},
	{

		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			-- "zbirenbaum/copilot-cmp",
			"zbirenbaum/copilot.lua",
			"nvim-lua/plenary.nvim",
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {},
		config = function()
			require("CopilotChat").setup()
			vim.keymap.set("n", "<leader>cc", "<cmd>CopilotChat<cr>")
		end,
	},
	-- autopair
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
}
