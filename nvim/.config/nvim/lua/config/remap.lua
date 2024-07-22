local bufnr = vim.api.nvim_get_current_buf()
local opts = { buffer = bufnr, remap = false }
local autocmd = vim.api.nvim_create_autocmd
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("", "<up>", "<nop>")
vim.keymap.set("", "<down>", "<nop>")
vim.keymap.set("", "<left>", "<nop>")
vim.keymap.set("", "<right>", "<nop>")

vim.keymap.set({ "n", "v", "i" }, "<C-s>", ":w<CR>", { noremap = true })

-- fugitive

vim.keymap.set("n", "<leader>p", function()
  vim.cmd.Git("push")
end, opts)
vim.keymap.set("n", "<leader>P", function()
  vim.cmd.Git({ "pull", "--rebase" })
end, opts)
vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)

--gitsigns

vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>")
-- harpoon

vim.keymap.set("n", "<leader>a", function()
  require("harpoon"):list():append()
end)
vim.keymap.set("n", "<C-a>", function()
  require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end)
vim.keymap.set("n", "<C-1>", function()
  require("harpoon"):list():select(1)
end)
vim.keymap.set("n", "<C-2>", function()
  require("harpoon"):list():select(2)
end)
vim.keymap.set("n", "<C-3>", function()
  require("harpoon"):list():select(3)
end)
vim.keymap.set("n", "<C-4>", function()
  require("harpoon"):list():select(4)
end)
-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function()
  require("harpoon"):list():prev()
end)
vim.keymap.set("n", "<C-S-N>", function()
  require("harpoon"):list():next()
end)
-- telescope
vim.keymap.set("n", "<leader>pf", function() require("telescope.builtin").find_files() end)
vim.keymap.set("n", "<leader>pg", function() require("telescope.builtin").git_files() end)
vim.keymap.set("n", "<leader>pws", function()
  local word = vim.fn.expand("<cword>")
  require("telescope.builtin").grep_string({ search = word })
end)
vim.keymap.set("n", "<leader>pWs", function()
  local word = vim.fn.expand("<cWORD>")
  require("telescope.builtin").grep_string({ search = word })
end)
vim.keymap.set("n", "<leader>ps", function()
  require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set("n", "<leader>vh", function() require("telescope.builtin").help_tags() end)
--undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
--lsp
autocmd("LspAttach", {
  callback = function(e)
    opts = { buffer = e.buf }
    vim.keymap.set("n", "gd", function()
      vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover()
    end, opts)
    vim.keymap.set("n", "<leader>vws", function()
      vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "<leader>ca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>rr", function()
      vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "<leader>rn", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
      vim.lsp.buf.signature_help()
    end, opts)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_prev()
    end, opts)
  end,
})

-- Obsidian
vim.keymap.set("n", "<leader>oc", "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
  { desc = "Obsidian Check Checkbox" })
vim.keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
vim.keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
vim.keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
vim.keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
vim.keymap.set("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
vim.keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
vim.keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })
vim.keymap.set("n", "<leader>ont", "<cmd>ObsidianToday<CR>", { desc = "New Daily Note Today" })
vim.keymap.set("n", "<leader>ony", "<cmd>ObsidianYesterday<CR>", { desc = "New Daily Note Yesterday" })

vim.keymap.set("n", "<C-e>", ":NvimTreeFindFileToggle<CR>", { noremap = true })
vim.keymap.set({ "n", "v", "i" }, "<C-x>", ":bd<CR>", { noremap = true })
vim.keymap.set({ "n", "v", "i" }, "<S-h>", ":bprev<CR>", { noremap = true })
vim.keymap.set({ "n", "v", "i" }, "<S-l>", ":bnext<CR>", { noremap = true })
