local state = require("python-projects.state")

local M = {}

function M.setup_project_root()
	vim.ui.input({ prompt = "Input project root: ", default = vim.fn.getcwd() }, function(input)
		if input == "" then
			vim.notify("Project root not set")
			return
		end
		state.set("project_root", input)
		vim.notify("Project root set to: " .. state.get("project_root"))
	end)
end

return M
