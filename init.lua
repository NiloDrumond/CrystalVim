pcall(require, 'impatient')

-- https://github.com/nvim-tree/nvim-tree.lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('internal.packer_commands')
require('settings')
require('lsp.setup')
require('lsp.functions')
require('mappings')
require('utils.autocmds')
require('theme')
