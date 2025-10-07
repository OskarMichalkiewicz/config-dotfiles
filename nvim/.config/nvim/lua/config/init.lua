require("config.remap")
-- require("config.brackets")
-- require("config.autoclose")
require("config.set")
require("config.lazy_init")
vim.cmd [[colorscheme tokyonight]]
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".husky/*",
  command = "set filetype=sh"
})
