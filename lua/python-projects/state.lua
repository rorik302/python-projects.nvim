---@class State
---@field project_root_path string | nil
---@field package_manager PackageManager | nil

---@type State
local state = {
	project_root_path = nil,
	package_manager = nil,
}

return state
