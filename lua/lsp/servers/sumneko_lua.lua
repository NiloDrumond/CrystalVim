local M = {}

M.settings = {
  Lua = {
    runtime = {
      version = 'LuaJIT',
    },
    diagnostics = {
      enable = true,
      globals = { 'vim', 'use' },
    },
    workspace = {
      library = vim.api.nvim_get_runtime_file('', true),
      maxPreload = 10000,
      preloadFileSize = 10000,
    },
    telemetry = { enable = false },
  },
}


return M
