return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local action_layout = require("telescope.actions.layout")
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = {
						"node_modules",
						".git",
					},
					layout_config = {
						horizontal = {
							prompt_position = "top",
						},
					},
					sorting_strategy = "ascending",
					mappings = {
						i = {
							["?"] = action_layout.toggle_preview,
						},
					},
					color_devicons = true,
					set_env = { ["COLORTERM"] = "truecolor" },
				},
				pickers = {
					buffers = {
						ignore_current_buffer = true,
						sort_mru = true,
					},
					builtin = {
						include_extensions = true,
					},
					find_files = {
						theme = "ivy",
						find_command = { "rg", "--files", "--hidden", "--smart-case", "--ignore", "-u" },
					},
					live_grep = {
						theme = "ivy",
					},
				},
				extensions = {
					fzf = {},
				},
			})

			require("telescope").load_extension("fzf")
			require("config.utils.telescope.multigrep").setup()
		end,
	},
}
