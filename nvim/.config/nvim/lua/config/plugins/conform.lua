local prettier_config = require("config.utils.prettier-config")
return {
	"stevearc/conform.nvim",
	lazy = true,
	event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier", stop_after_first = true },
				typescript = { "prettier", stop_after_first = true },
				javascriptreact = { "prettier", stop_after_first = true },
				typescriptreact = { "prettier", stop_after_first = true },
				svelte = { "prettier", stop_after_first = true },
				css = { "prettier", stop_after_first = true },
				html = { "prettier", stop_after_first = true },
				json = { "prettier", stop_after_first = true },
				yaml = { "prettier", stop_after_first = true },
				markdown = { "prettier", stop_after_first = true },
				graphql = { "prettier", stop_after_first = true },
				lua = { "stylua", stop_after_first = true },
				python = { "isort", "black" },
			},
			formatters = {
				prettier = {
					command = "prettier",
					args = function()
						local filename = vim.api.nvim_buf_get_name(0)
						local config = prettier_config.resolve()
						if config then
							return { "--config", config, "--stdin-filepath", filename, "--log-level warn --write" }
						end
						return { "--stdin-filepath", filename, "--log-level warn --write" }
					end,
				},
			},
			format_after_save = {
				lsp_fallback = true,
				async = true,
				timeout_ms = 2500,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>f", function()
			conform.format({
				lsp_fallback = true,
				async = true,
				timeout_ms = 2500,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
