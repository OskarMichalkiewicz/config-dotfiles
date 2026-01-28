return {
	filetypes = {
		"html",
		"css",
		"scss",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"svelte",
	},
	settings = {
		tailwindCSS = {
			experimental = {
				classRegex = {
					{ "([\"'`][^\"'`]*.*?[\"'`])", "[\"'`]([^\"'`]*).*?[\"'`]" },
					-- Matches: base: "bg-red-500 text-white"
					{ "base:%s*[\"']([^\"']+)[\"']", 1 },

					-- Matches: variants: { size: "text-sm" }
					{ "variants:%s*{[^}]*[\"']([^\"']+)[\"']", 1 },

					-- Matches: compoundVariants: [{ class: "bg-red-500" }]
					{ "class:%s*[\"']([^\"']+)[\"']", 1 },
				},
			},
		},
	},
}
