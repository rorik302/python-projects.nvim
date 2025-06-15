local project = require("python-projects.project")

local M = {}

function M.setup_start_commands()
	vim.api.nvim_create_user_command("PythonProjectsInit", project.setup_project_root, {})
end

return M
