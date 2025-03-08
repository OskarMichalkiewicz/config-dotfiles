return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "tsakirist/telescope-lazy.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },

  config = function()
    local action_layout = require("telescope.actions.layout")
    require("telescope").setup({
      defaults = {
        file_ignore_patterns = {
          'node_modules',
          '.git',
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
        find_files = {
          find_command = { "rg", "--files", "--hidden", '--ignore', '-u' },
        },
        buffers = {
          ignore_current_buffer = true,
          sort_mru = true,
        },
        builtin = {
          include_extensions = true,
        },
      },
      border = {},
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      extensions = {
        file_browser = {
          initial_mode = "normal",
        },
        ["ui-select"] = {
          require("telescope.themes").get_cursor({}),
        },
      },
    })
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("file_browser")
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("lazy")
  end,
}
