local state = require("python-projects.state")

---@class Project
---@field set_project_root_path fun()

local function set_project_root_path()
	vim.ui.input({ prompt = "Set project root path: ", default = vim.fn.getcwd() }, function(input)
		if input == "" or input == nil then
			vim.notify("Project root path not set.", vim.log.levels.ERROR)
			return
		else
			state.project_root_path = input
			vim.notify("Project root path set to: " .. input, vim.log.levels.INFO)
		end
	end)
end

local function get_project_info()
	vim.notify(vim.inspect(state), vim.log.levels.INFO)
end

---@type Project
local M = {
	set_project_root_path = set_project_root_path,
	get_project_info = get_project_info,
}

return M
