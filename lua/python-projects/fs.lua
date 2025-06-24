---@param path string
local function dir_exists(path)
	local stat = vim.uv.fs_stat(path)
	return stat and stat.type == "directory"
end

---@param path string
local function file_exists(path)
	local stat = vim.uv.fs_stat(path)
	return stat and stat.type == "file"
end

local M = {}

M.dir_exists = dir_exists
M.file_exists = file_exists

return M
