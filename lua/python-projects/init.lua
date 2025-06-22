local commands = require("python-projects.commands")

local M = {}

function M.setup(opts)
	commands.setup_commands()
end

return M
