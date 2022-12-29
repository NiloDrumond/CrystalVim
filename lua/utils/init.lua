local M = {}
local Job = require 'plenary.job'

M.add_whitespaces = function(number)
  return string.rep(" ", number)
end

M.open_package = function()
  local result = nil
  Job:new({
    command = "fd",
    args = { [[package\.json|Cargo\.toml]] },
    on_stdout = function(_, data)
      if data ~= nil and result == nil then
        result = data
      end
    end
  }):sync()
  if result ~= nil then
    vim.cmd('e ' .. result)
  end
end


local function deep_copy(object)
  if type(object) ~= 'table' then return object end

  local result = {}
  for key, value in pairs(object) do
    result[key] = deep_copy(value)
  end
  return result
end

local function spread(template, override)
  if not override then
    return function(override)
      spread(template, override)
    end
  end

  local mt = getmetatable(template)
  local result = {}
  setmetatable(result, mt)

  for key, value in pairs(template) do
    result[key] = deep_copy(value)
  end

  -- No longer wrapped up inside a function
  for key, value in pairs(override) do
    result[key] = value
  end

  return result
end

M.spread = spread

return M
