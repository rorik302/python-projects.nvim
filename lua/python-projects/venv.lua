local state = require("python-projects.state")
local fs = require("python-projects.fs")

local M = {}

local function find_venv_path()
	if state.package_manager == "poetry" then
		local handle = io.popen("cd " .. state.project_root_path .. " && poetry env info -p")
		if handle then
			local poetry_venv_path = handle:read("*a")
			handle:close()

			if poetry_venv_path and poetry_venv_path ~= "" then
				local venv_path = poetry_venv_path:gsub("%s+", "")
				if fs.dir_exists(venv_path) then
					return venv_path
				end
			end
		end
	end

	for name, type in vim.fs.dir(state.project_root_path) do
		if type == "directory" then
			local dir_path = vim.fs.joinpath(state.project_root_path, name)

			if fs.file_exists(vim.fs.joinpath(dir_path, "pyvenv.cfg")) then
				return dir_path
			end
		end
	end
end

local function get_venv_python(venv_path)
	if not venv_path then
		return
	end

	local python_path = vim.fs.joinpath(venv_path, "bin", "python")
	if fs.file_exists(python_path) then
		return python_path
	end
end

local function activate_venv()
	if vim.env.VIRTUAL_ENV then
		vim.notify("Virtual environment already activated.", vim.log.levels.INFO)
		return
	end

	if state.package_manager == nil or state.package_manager == nil then
		vim.notify(
			"Virtual environment not activated. Project root path or package manager not set.",
			vim.log.levels.ERROR
		)
		return
	end

	local venv_path = find_venv_path()

	if venv_path == nil then
		vim.notify("Virtual environment not found.", vim.log.levels.ERROR)
		return
	end

	local activate_script_path = vim.fs.joinpath(venv_path, "bin", "activate")
	if fs.file_exists(activate_script_path) then
		state.original_path = vim.env.PATH

		vim.env.VIRTUAL_ENV = venv_path
		vim.env.PATH = vim.fs.joinpath(venv_path, "bin:", vim.env.PATH)
		vim.g.python3_host_prog = get_venv_python(venv_path)

		state.venv_path = venv_path
		vim.notify("Virtual environment activated: " .. venv_path, vim.log.levels.INFO)
	end
end

local function deactivate_venv()
	if not vim.env.VIRTUAL_ENV then
		vim.notify("Virtual environment not activated.", vim.log.levels.ERROR)
		return
	end

	vim.env.VIRTUAL_ENV = nil
	vim.env.PATH = state.original_path
	state.original_path = nil
	vim.g.python3_host_prog = nil

	vim.notify("Virtual environment deactivated.", vim.log.levels.INFO)
end

M.activate_venv = activate_venv
M.deactivate_venv = deactivate_venv

return M
