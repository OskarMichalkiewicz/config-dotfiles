return {
  "nvim-lualine/lualine.nvim",
  config = function()
    require('lualine').setup({
      options = {
        disabled_filetypes = { 'NvimTree' },
        theme = "auto",
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_x = {
          {
            --           require("noice").api.statusline.mode.get,
            --          cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ffffff" },
          }
        },
      }
    })
  end
}
