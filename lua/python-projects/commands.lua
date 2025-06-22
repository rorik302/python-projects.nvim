local project = require("python-projects.project")
local package_manager = require("python-projects.package-manager")

local prefix = "PythonProjects"

local function setup_commands()
	vim.api.nvim_create_user_command(prefix .. "SetProjectPath", project.set_project_root_path, {})

	vim.api.nvim_create_user_command(prefix .. "SelectPackageManager", package_manager.select_package_manager, {})

	vim.api.nvim_create_user_command(prefix .. "ProjectInfo", project.get_project_info, {})
end

local M = {
	setup_commands = setup_commands,
}

return M
