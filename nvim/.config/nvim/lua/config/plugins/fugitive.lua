return {
  "tpope/vim-fugitive",
  config = function()
    vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
    local autocmd = vim.api.nvim_create_autocmd
    autocmd("BufWinEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.ft ~= "fugitive" then
          return
        end
      end,
    })
  end,
}
