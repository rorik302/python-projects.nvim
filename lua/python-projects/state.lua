---@alias StateKey "project_root"

local M = {}

---@class State
---@field project_root string
local state = {}

---@type fun(key: StateKey, value: any)
function M.set(key, value)
	state[key] = value
end

---@type fun(key: StateKey): any
function M.get(key)
	return state[key]
end

---@return State
function M.get_state()
	return state
end

return M
