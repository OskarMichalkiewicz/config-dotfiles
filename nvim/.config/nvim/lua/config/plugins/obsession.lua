return {
  'rmagatti/auto-session',
  lazy = false,
  opts = {
    -- log_level = 'debug',
  },
  config = function()
    require('auto-session').setup({
      args_allow_files_auto_save = function()
        local supported = 0

        local buffers = vim.api.nvim_list_bufs()
        for _, buf in ipairs(buffers) do
          -- Check if the buffer is valid and loaded
          if vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_is_loaded(buf) then
            local path = vim.api.nvim_buf_get_name(buf)
            if vim.fn.filereadable(path) ~= 0 then supported = supported + 1 end
          end
        end

        -- If we have more 2 or more supported buffers, save the session
        return supported >= 2
      end,
    })
  end
}
