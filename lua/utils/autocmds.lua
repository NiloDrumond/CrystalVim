-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost",
  { callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 100 }) end })
-- Disable diagnostics in node_modules (0 is current buffer only)
vim.api.nvim_create_autocmd("BufRead", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
vim.api.nvim_create_autocmd("BufNewFile", { pattern = "*/node_modules/*", command = "lua vim.diagnostic.disable(0)" })
-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md", "*.tex" },
  command = "setlocal spell" })

-- Attach specific keybindings in which-key for specific filetypes
local present, _ = pcall(require, "which-key")
if not present then return end
local _, pwk = pcall(require, "plugins.ui.which-key")

-- Spectre
vim.api.nvim_create_autocmd("FileType", { pattern = "spectre_panel",
  callback = function() pwk.attach_spectre(0) end })

-- Zen
vim.api.nvim_create_autocmd("FileType",
  { pattern = "*",
    callback = function()
      if vim.bo.filetype ~= "alpha" then
        pwk.attach_zen(0)
      end
    end
  })
