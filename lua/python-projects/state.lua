---@class State
---@field project_root_path string | nil
---@field package_manager PackageManager | nil
---@field venv_path string | nil
---@field original_path string | nil

---@type State
local state = {
	project_root_path = nil,
	package_manager = nil,
	venv_path = nil,
	original_path = nil,
}

return state
