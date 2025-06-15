local commands = require("python-projects.commands")
local state = require("python-projects.state")

local M = {}

M.config = {}

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", M.config, opts or {})

	commands.setup_start_commands()

	if state.get("project_root") == nil then
		return
	end
end

return M
