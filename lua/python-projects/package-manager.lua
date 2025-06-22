local state = require("python-projects.state")

---@alias PackageManager "pip" | "poetry" | "uv"

---@type PackageManager[]
local package_managers = {
	"pip",
	"poetry",
	"uv",
}

local function select_package_manager()
	vim.ui.select(package_managers, {
		prompt = "Select package manager",
		format_item = function(item)
			return item
		end,
	}, function(selected)
		if selected == "" or selected == nil then
			vim.notify("No package manager selected.", vim.log.levels.ERROR)
			return
		end

		state.package_manager = selected
	end)
end

local M = {}

M.select_package_manager = select_package_manager

return M
