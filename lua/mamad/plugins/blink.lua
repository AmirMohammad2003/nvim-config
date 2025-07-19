return {
	{
		"saghen/blink.cmp",
		dependencies = {
			"rafamadriz/friendly-snippets",
			{
				"saghen/blink.compat",
				optional = true,
				opts = {},
				version = "*",
			},
			{
				"giuxtaposition/blink-cmp-copilot",
			},
		},
		event = "InsertEnter",
		version = "*",
		opts_extend = {
			"sources.completion.enabled_providers",
			"sources.compat",
			"sources.default",
		},
		---@module 'blink.cmp'
		---@diagnostic disable-next-line: missing-fields
		opts = {
			keymap = {
				preset = "enter",
				["<C-y>"] = { "select_and_accept" },
			},
			appearance = {
				use_nvim_cmp_as_default = false,
				nerd_font_variant = "mono",
			},
			completion = {
				menu = {
					draw = {
						treesitter = { "lsp" },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
				ghost_text = {
					enabled = vim.g.ai_cmp,
				},
			},
			sources = {
				default = {
					"lsp",
					"easy-dotnet",
					"path",
					"snippets",
					"buffer",
					"lazydev",
					"copilot",
					"cmdline",
					"omni",
				},
				compat = {},
				providers = {
					copilot = {
						name = "copilot",
						module = "blink-cmp-copilot",
						score_offset = 100,
						async = true,
					},
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						score_offset = 100, -- show at a higher priority than lsp
					},
					["easy-dotnet"] = {
						name = "easy-dotnet",
						enabled = true,
						module = "easy-dotnet.completion.blink",
						score_offset = 10000,
						async = true,
					},
				},
			},
		},
		config = function(_, opts)
			local enabled = opts.sources.default
			for _, source in ipairs(opts.sources.compat or {}) do
				opts.sources.providers[source] = vim.tbl_deep_extend(
					"force",
					{ name = source, module = "blink.compat.source" },
					opts.sources.providers[source] or {}
				)
				if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
					table.insert(enabled, source)
				end
			end
			opts.sources.compat = nil
			for _, provider in pairs(opts.sources.providers or {}) do
				if provider.kind then
					local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
					local kind_idx = #CompletionItemKind + 1

					CompletionItemKind[kind_idx] = provider.kind
					---@diagnostic disable-next-line: no-unknown
					CompletionItemKind[provider.kind] = kind_idx

					local transform_items = provider.transform_items
					provider.transform_items = function(ctx, items)
						items = transform_items and transform_items(ctx, items) or items
						for _, item in ipairs(items) do
							item.kind = kind_idx or item.kind
						end
						return items
					end

					-- Unset custom prop to pass blink.cmp validation
					provider.kind = nil
				end
			end

			require("blink.cmp").setup(opts)
		end,
	},
}
