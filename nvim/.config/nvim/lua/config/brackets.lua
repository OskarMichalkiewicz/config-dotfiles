local function add_brackets(char, close_char)
	return function()
    if vim.api.nvim_get_mode().mode == 'i' then
      vim.api.nvim_feedkeys(char .. close_char .. vim.api.nvim_replace_termcodes('<ESC>i', true, true, true), 'n', true)
      -- vim.keymap.set('i', '<CR>', '<CMD>lua handle_enter_key()<CR>')
   end
  end
end

function handle_enter_key()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  local next_char = vim.api.nvim_buf_get_lines(0, line-1, line, false)[1]:sub(col+2, col+2)
  if next_char == '}' then
    vim.api.nvim_feedkeys(char .. close_char .. vim.api.nvim_replace_termcodes('<ESC>i\n<ESC>O', true, true, true) 'n', true)
  end
  vim.keymap.set('i', '<CR>', '<CR>')
end



vim.keymap.set('i', '(', add_brackets('(', ')'))
vim.keymap.set('i', '[', add_brackets('[', ']'))
vim.keymap.set('i', '{', add_brackets('{', '}'))
vim.keymap.set('i', '"', add_brackets('"', '"'))
vim.keymap.set('i', "'", add_brackets("'", "'"))
