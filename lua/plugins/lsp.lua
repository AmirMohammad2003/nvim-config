return {
	-- for neovim config
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },

	-- lsp configuration
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"stevearc/conform.nvim",
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"j-hui/fidget.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			local cmp_lsp = require("cmp_nvim_lsp")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
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
					["lua_ls"] = function()
						local lspconfig = require("lspconfig")
						lspconfig.lua_ls.setup({
							capabilities = capabilities,
							settings = {
								Lua = {
									runtime = { version = "Lua 5.1" },
									diagnostics = {
										globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
									},
								},
							},
						})
					end,
				},
			})
			local lspconfig_defaults = require("lspconfig").util.default_config
			lspconfig_defaults.capabilities = vim.tbl_deep_extend(
				"force",
				lspconfig_defaults.capabilities,
				require("cmp_nvim_lsp").default_capabilities()
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

	-- autocomplete
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			-- "hrsh7th/cmp-cmdline",
			{
				"garymjr/nvim-snippets",
				opts = {
					friendly_snippets = true,
				},
				dependencies = { "rafamadriz/friendly-snippets" },
			},
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					-- Copilot Source
					{ name = "copilot" },
					-- Other Sources
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{
						name = "lazydev",
						group_index = 0,
					},
				},
				snippet = {
					expand = function(args)
						vim.snippet.expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<CR>"] = cmp.mapping.confirm({
						-- documentation says this is important.
						-- I don't know why.
						behavior = cmp.ConfirmBehavior.Replace,
						select = false,
					}),
					["<Tab>"] = cmp.mapping.select_next_item(),
					["<S-Tab>"] = cmp.mapping.select_prev_item(),

					["<C-Space>"] = cmp.mapping.complete({}),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if vim.snippet.active({ direction = 1 }) then
							vim.cmd("<cmd>lua vim.snippet.jump(1)<cr>")
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if vim.snippet.active({ direction = -1 }) then
							vim.cmd("<cmd>lua vim.snippet.jump(-1)<cr>")
						end
					end, { "i", "s" }),
				}),
				completion = { completeopt = "menu,menuone,noinsert" },
			})
		end,
	},
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
			},
		},
	},
	-- copilot
	{

		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			"zbirenbaum/copilot-cmp",
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

	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			{ "zbirenbaum/copilot.lua", opts = {} },
		},
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
			require("copilot_cmp").setup()

			vim.keymap.set("n", "<leader>cp", "<cmd>Copilot panel<cr>")
		end,
	},
}
