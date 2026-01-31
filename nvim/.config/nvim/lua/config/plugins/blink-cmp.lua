return {
	"saghen/blink.cmp",
	dependencies = { "rafamadriz/friendly-snippets" },

	version = "1.*",

	opts = {
		keymap = { preset = "default" },

		completion = {
			menu = {
				draw = {
					columns = {
						{ "label", "label_description" },
						{ "kind_icon", "kind" },
					},
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
			signature = {
				enables = true,
			},
		},
		appearance = {
			use_nvim_cmp_as_default = true,
		},

		fuzzy = { implementation = "prefer_rust_with_warning" },
		signature = { enabled = true },
	},
	opts_extend = { "sources.default" },
}
