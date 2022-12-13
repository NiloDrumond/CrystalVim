-- https://github.com/nvim-tree/nvim-tree.lua
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('settings')
require('plugins')
require('internal.packer_commands')
require('lsp.setup')
require('mappings')
