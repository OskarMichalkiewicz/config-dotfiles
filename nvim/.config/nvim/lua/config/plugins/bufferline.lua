return {
	"akinsho/bufferline.nvim",
	version = "*",
	config = function()
		local bufferline = require("bufferline")
		bufferline.setup({
			options = {
				show_tab_indicators = true,
				separator_style = "thick",
				style_preset = {
					bufferline.style_preset.minimal,
				},
				offsets = {
					{
						filetype = "NvimTree",
					},
				},
			},
		})
	end,
}
