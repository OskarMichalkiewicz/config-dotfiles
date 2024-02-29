return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
		"rafamadriz/friendly-snippets",
	},

	config = function()
		vim.diagnostic.config({
			underline = true,
			update_in_insert = false,
			severity_sort = true,
			virtual_text = true,
			-- For lsp_lines
			virtual_lines = true,
			float = {
				border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
				format = function(diagnostic)
					if diagnostic.source == "eslint" then
						return string.format(
							"%s [%s]",
							diagnostic.message,
							-- shows the name of the rule
							diagnostic.user_data.lsp.code
						)
					end
					return string.format("%s [%s]", diagnostic.message, diagnostic.source)
				end,
				severity_sort = true,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				max_width = 80,
			},
		})
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		require("luasnip.loaders.from_vscode").lazy_load()
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"tsserver",
				"unocss",
			},
			opts = {
				auto_install = true,
			},
			handlers = {
				function(server_name) -- default handler (optional)
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
								diagnostics = {
									globals = { "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab-k>"] = cmp.mapping.select_prev_item(cmp_select),
				["<Tab-j>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<Tab-Space>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "buffer" },
			}),
		})

		vim.diagnostic.config({
			-- update_in_insert = true,
			float = {
				focusable = false,
				style = "minimal",
				border = "rounded",
				source = "always",
				header = "",
				prefix = "",
			},
		})
	end,
}
