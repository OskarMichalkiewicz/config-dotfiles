local M = {}
local win = nil

local default_opts = {
	notes_dir = "~/notes/",
	border = "single",
	width = 0.8,
	height = 0.8,
	position = "center",
}

local function expand_path(path)
	if path:sub(1, 1) == "~" then
		path = os.getenv("HOME") .. path:sub(2)
	end
	-- Ensure the directory ends with a slash
	if path:sub(-1) ~= "/" then
		path = path .. "/"
	end
	return path
end

-- Improved helper to get Repo and Branch names
local function get_git_info()
	-- Get repo name
	local repo = vim.fn.system("basename `git rev-parse --show-toplevel` 2>/dev/null"):gsub("%s+", "")
	-- Get branch name and replace / with - (to avoid directory errors)
	local branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("%s+", ""):gsub("/", "-")

	if repo == "" or vim.v.shell_error ~= 0 then
		return nil, nil
	end
	return repo, branch
end

-- Helper to ensure the notes directory exists
local function ensure_dir(path)
	if vim.fn.isdirectory(path) == 0 then
		vim.fn.mkdir(path, "p")
	end
end

local function calculate_position(position)
	local posx, posy = 0.5, 0.5
	if type(position) == "table" then
		posx, posy = position[1], position[2]
	elseif position == "center" then
		posx, posy = 0.5, 0.5
	elseif position == "topleft" then
		posx, posy = 0, 0
	elseif position == "topright" then
		posx, posy = 1, 0
	elseif position == "bottomleft" then
		posx, posy = 0, 1
	elseif position == "bottomright" then
		posx, posy = 1, 1
	end
	return posx, posy
end

local function win_config(opts)
	local width = math.min(math.floor(vim.o.columns * opts.width), 64)
	local height = math.floor(vim.o.lines * opts.height)
	local posx, posy = calculate_position(opts.position)
	local col = math.floor((vim.o.columns - width) * posx)
	local row = math.floor((vim.o.lines - height) * posy)

	return {
		relative = "editor",
		width = width,
		height = height,
		col = col,
		row = row,
		border = opts.border,
	}
end

local function open_floating_file(opts)
	if win ~= nil and vim.api.nvim_win_is_valid(win) then
		vim.api.nvim_set_current_win(win)
		return
	end

	local repo_name, branch_name = get_git_info()
	local notes_dir = expand_path(opts.notes_dir)

	-- Ensure the notes directory (e.g. ~/notes/) actually exists
	ensure_dir(notes_dir)

	-- Construct filename: repo-branch.md or todo.md if not in git
	local filename = "todo.md"
	if repo_name and branch_name then
		filename = string.format("%s-%s.md", repo_name, branch_name)
	end

	local full_path = notes_dir .. filename

	-- Create file if it doesn't exist
	if vim.fn.filereadable(full_path) == 0 then
		local f = io.open(full_path, "w")
		if f then
			f:close()
		else
			vim.notify("Could not create file at: " .. full_path, vim.log.levels.ERROR)
			return
		end
	end

	-- Load the buffer
	local buf = vim.fn.bufadd(full_path)
	vim.fn.bufload(buf)

	vim.bo[buf].swapfile = false
	win = vim.api.nvim_open_win(buf, true, win_config(opts))

	-- Keymap for closing
	vim.api.nvim_buf_set_keymap(buf, "n", "q", "", {
		noremap = true,
		silent = true,
		callback = function()
			if vim.api.nvim_get_option_value("modified", { buf = buf }) then
				vim.notify("Save your changes first!", vim.log.levels.WARN)
			else
				vim.api.nvim_win_close(win, true)
				win = nil
			end
		end,
	})
end

M.setup = function(opts)
	local options = vim.tbl_deep_extend("force", default_opts, opts or {})
	vim.api.nvim_create_user_command("Td", function()
		open_floating_file(options)
	end, {})
end

return M
