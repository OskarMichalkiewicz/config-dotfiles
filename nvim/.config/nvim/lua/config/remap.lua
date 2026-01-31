local bufnr = vim.api.nvim_get_current_buf()
local opts = { buffer = bufnr, remap = false }
local km = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
vim.g.mapleader = " "

km("v", "J", ":m '>+1<CR>gv=gv")
-- km("v", "K", ":m '<-2<CR>gv=gv")

-- add centering to motions
km("n", "J", "mzJ`z")
km("n", "<C-d>", "<C-d>zz")
km("n", "<C-u>", "<C-u>zz")
km("n", "n", "nzzzv")
km("n", "N", "Nzzzv")

km("x", "<leader>p", [["_dP]])

km({ "n", "v" }, "<leader>y", [["+y]])
km("n", "<leader>Y", [["+Y]])

km({ "n", "v" }, "<leader>d", [["_d]])

km("n", "Q", "<nop>")
km("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
km("n", "<leader>f", vim.lsp.buf.format)

km("n", "<C-k>", "<cmd>cnext<CR>zz")
km("n", "<C-j>", "<cmd>cprev<CR>zz")
km("n", "<leader>k", "<cmd>lnext<CR>zz")
km("n", "<leader>j", "<cmd>lprev<CR>zz")

km("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Find and replace" })
km("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Give execution privileges" })

km("", "<up>", "<nop>")
km("", "<down>", "<nop>")
km("", "<left>", "<nop>")
km("", "<right>", "<nop>")

km("n", "<C-s>", ":w<CR>", { noremap = true })

-- fugitive

km("n", "<leader>p", function()
	vim.cmd.Git("push")
end, opts)
km("n", "<leader>P", function()
	vim.cmd.Git({ "pull", "--rebase" })
end, opts)
km("n", "<leader>t", ":Git push -u origin ", opts)

--gitsigns

km("n", "<leader>gp", ":Gitsigns preview_hunk<CR>")
km("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>")
-- harpoon

km("n", "<leader>a", function()
	require("harpoon"):list():append()
end)
km("n", "<C-a>", function()
	require("harpoon").ui:toggle_quick_menu(require("harpoon"):list())
end)
km("n", "<C-1>", function()
	require("harpoon"):list():select(1)
end)
km("n", "<C-2>", function()
	require("harpoon"):list():select(2)
end)
km("n", "<C-3>", function()
	require("harpoon"):list():select(3)
end)
km("n", "<C-4>", function()
	require("harpoon"):list():select(4)
end)
-- Toggle previous & next buffers stored within Harpoon list
km("n", "<C-S-P>", function()
	require("harpoon"):list():prev()
end)
km("n", "<C-S-N>", function()
	require("harpoon"):list():next()
end)
-- telescope
km("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end)
-- km("n", "<leader>fws", function()
-- 	local word = vim.fn.expand("<cword>")
-- 	require("telescope.builtin").grep_string({ search = word })
-- end)
-- km("n", "<leader>fWs", function()
-- 	local word = vim.fn.expand("<cWORD>")
-- 	require("telescope.builtin").grep_string({ search = word })
-- end)
-- km("n", "<leader>fs", function()
-- 	require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
-- end)
km("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end)
--undotree
km("n", "<leader>u", vim.cmd.UndotreeToggle)
--lsp
autocmd("LspAttach", {
	callback = function(e)
		opts = { buffer = e.buf }
		km("n", "gd", function()
			vim.lsp.buf.definition()
		end, opts)
		km("n", "K", function()
			vim.lsp.buf.hover()
		end, opts)
		km("n", "<leader>vws", function()
			vim.lsp.buf.workspace_symbol()
		end, opts)
		km("n", "<leader>vd", function()
			vim.diagnostic.open_float()
		end, opts)
		km("n", "<leader>ca", function()
			vim.lsp.buf.code_action()
		end, opts)
		km("n", "<leader>rr", function()
			vim.lsp.buf.references()
		end, opts)
		km("n", "<leader>rn", function()
			vim.lsp.buf.rename()
		end, opts)
		km("i", "<C-h>", function()
			vim.lsp.buf.signature_help()
		end, opts)
		km("n", "[d", function()
			vim.diagnostic.get_next()
		end, opts)
		km("n", "]d", function()
			vim.diagnostic.get_prev()
		end, opts)
	end,
})

-- Obsidian
-- km(
-- 	"n",
-- 	"<leader>oc",
-- 	"<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
-- 	{ desc = "Obsidian Check Checkbox" }
-- )
-- km("n", "<leader>ot", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template" })
-- km("n", "<leader>oo", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
-- km("n", "<leader>ob", "<cmd>ObsidianBacklinks<CR>", { desc = "Show ObsidianBacklinks" })
-- km("n", "<leader>ol", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
-- km("n", "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
-- km("n", "<leader>os", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
-- km("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })
-- km("n", "<leader>ont", "<cmd>ObsidianToday<CR>", { desc = "New Daily Note Today" })
-- km("n", "<leader>ony", "<cmd>ObsidianYesterday<CR>", { desc = "New Daily Note Yesterday" })

-- km("n", "<C-e>", ":NvimTreeFindFileToggle<CR>", { noremap = true })
km("n", "<C-x>", ":bd<CR>")
km("n", "<leader>bd", ":%bd|e#|bd#<CR>")
km("n", "<S-h>", ":bprev<CR>")
km("n", "<S-l>", ":bnext<CR>")

-- floating todo
km("n", "<leader>td", ":Td<CR>", { noremap = true })

-- vimwiki
km("n", "<leader>tt", ":VimwikiToggleListItem<CR>", { noremap = true })

-- oil.nvim
km("n", "<C-e>", "<CMD>Oil<CR>", { desc = "Open parent direcory" })
