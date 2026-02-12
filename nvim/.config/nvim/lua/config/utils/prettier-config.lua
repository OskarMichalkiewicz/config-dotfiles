local M = {}

local prettier_files = {
	"prettier.config.js",
	"prettier.config.cjs",
	"prettier.config.mjs",
	".prettierrc",
	".prettierrc.js",
	".prettierrc.cjs",
	".prettierrc.json",
	".prettierrc.yaml",
	".prettierrc.yml",
}

local function get_workspace_root(filename)
	return vim.fs.root(filename, { "pnpm-workspace.yaml", ".git" })
end

local function get_package_root(filename)
	return vim.fs.root(filename, { "package.json" })
end

local function resolve_package_symlink_config(filename, workspace_root)
	local package_root = get_package_root(filename)
	if not package_root then
		return nil
	end

	local ok, json = pcall(function()
		return vim.json.decode(table.concat(vim.fn.readfile(workspace_root .. "/package.json"), "\n"))
	end)

	if not ok then
		return nil
	end

	local node_modules = package_root .. "/node_modules/" .. json["name"]:match("([^/]+)")
	if vim.fn.isdirectory(node_modules) == 0 then
		return nil
	end

	local matches = vim.fs.find(prettier_files, { path = node_modules, limit = 10, type = "file", follow = true })

	return matches and matches[1] or nil
end

function M.resolve()
	local filename = vim.api.nvim_buf_get_name(0)
	if filename == "" then
		return nil
	end

	local workspace_root = get_workspace_root(filename)

	local symlinked = resolve_package_symlink_config(filename, workspace_root)
	if symlinked then
		return symlinked
	end

	return nil
end

return M
