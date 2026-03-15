return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",
        icons_enabled = true,
        component_separators = "|",
        section_separators = "",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
      },
    })
    vim.defer_fn(function()
      vim.opt.laststatus = 0
      vim.opt.showmode = false
    end, 100)
  end,
}
