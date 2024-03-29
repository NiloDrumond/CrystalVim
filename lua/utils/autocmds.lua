-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost",
  { callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 }) end })
-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.txt", "*.md", "*.tex" },
  command = "setlocal spell"
})

-- 2 spaces
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.lua", "*.ts", "*.tsx", ".js", ".jsx" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end
})
-- 4 spaces
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.cargo", "*.toml" },
  command = "setlocal spell"
})

-- tab
vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
  pattern = {"*.gd"},
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = false
  end
})

--  ╭──────────────────────────────────────────────────────────╮
--  │ WhickKey Attach                                          │
--  ╰──────────────────────────────────────────────────────────╯

local present, _ = pcall(require, "which-key")
if not present then return end
local _, pwk = pcall(require, "plugins.which-key")

-- LSP
vim.api.nvim_create_autocmd("BufEnter",
  {
    pattern = { "*.js", "*.jsx", "*.lua", "*.rs", "*.gd", "*.cpp" },
    callback = function()
      pwk.attach_common_lsp(0)
    end
  })

-- Typescript
vim.api.nvim_create_autocmd("BufEnter",
  {
    pattern = { "*.ts", "*.tsx", "*.svelte" },
    callback = function()
      pwk.attach_typescript(0)
    end
  })

-- Spectre
vim.api.nvim_create_autocmd("FileType", {
  pattern = "spectre_panel",
  callback = function() pwk.attach_spectre(0) end
})
-- Zen
vim.api.nvim_create_autocmd("FileType",
  {
    pattern = "*",
    callback = function()
      if vim.bo.filetype ~= "alpha" then
        pwk.attach_zen(0)
      end
    end
  })
-- NPM
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "package.json" },
  callback = function() pwk.attach_npm(0) end
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "Cargo.toml" },
  callback = function() pwk.attach_cargo(0) end
})
