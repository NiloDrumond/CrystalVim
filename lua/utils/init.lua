local M = {}
local job_ok, Job = pcall(require, 'plenary.job')

M.add_whitespaces = function(number)
  return string.rep(" ", number)
end

M.identify_sh = function(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 0)
  print(vim.inspect(lines))
end

M.open_package = function()
  -- TODO: definir package.json ou cargo de acordo com o tipo do arquivo
  local result = nil
  if (job_ok) then
    Job:new({
      command = "fd",
      args = { [[package\.json|Cargo\.toml]] },
      on_stdout = function(_, data)
        if data ~= nil and result == nil then
          result = data
        end
      end
    }):sync()
  end
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
