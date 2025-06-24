local state = require("python-projects.state")
local fs = require("python-projects.fs")

local M = {}

---@param package_manager PackageManager | nil
local function find_venv_path(package_manager)
	if package_manager == nil then
		return
	end

	if package_manager == "poetry" then
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

	if package_manager == "uv" then
		local venv_path = state.project_root_path .. "/.venv"
		if fs.dir_exists(venv_path) then
			return venv_path
		end
	end

	if package_manager == "pip" then
		local venv_path = state.project_root_path .. "/.venv"
		if fs.dir_exists(venv_path) then
			return venv_path
		end
	end
end

---@param package_manager PackageManager
local function activate_venv(package_manager)
	if package_manager == nil then
		vim.notify("Virtual environment not activated. Package manager not set.", vim.log.levels.ERROR)
		return
	end

	local venv_path = find_venv_path(package_manager)

	if venv_path == nil then
		vim.notify("Virtual environment not found.", vim.log.levels.ERROR)
	end

	local activate_script_path = venv_path .. "/bin/activate"
	if fs.file_exists(activate_script_path) then
		vim.env.VIRTUAL_ENV = venv_path
		vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH

		state.venv_path = venv_path
		vim.notify("Virtual environment activated: " .. venv_path, vim.log.levels.INFO)
	end
end

M.activate_venv = activate_venv

return M
