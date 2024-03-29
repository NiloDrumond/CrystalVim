local keymap = vim.keymap.set
local silent = { silent = true, noremap = true }
local utils = require("utils")


--  ╭──────────────────────────────────────────────────────────╮
--  │ Movement                                                 │
--  ╰──────────────────────────────────────────────────────────╯

-- Window movement
keymap("n", "<C-h>", "<C-w>h", silent)
keymap("n", "<C-j>", "<C-w>j", silent)
keymap("n", "<C-k>", "<C-w>k", silent)
keymap("n", "<C-l>", "<C-w>l", silent)
keymap("n", "<C-c>", "<C-w>c", silent)

-- H to move to the first non-blank character of the line
-- keymap("n", "H", "^", silent)

-- Move selected line / block of text in visual mode
keymap("x", "<S-k>", ":move '<-2<CR>gv-gv", silent)
keymap("x", "<S-j>", ":move '>+1<CR>gv-gv", silent)


-- Navigation around the syntax-tree
keymap({ "n", "v", "o" }, 'Z', "<cmd>lua require('tree-climber').goto_parent()<CR>", silent)
keymap({ "n", "v", "o" }, 'X', "<cmd>lua require('tree-climber').goto_child()<CR>", silent)
keymap({ "n", "v", "o" }, 'L', "<cmd>lua require('tree-climber').goto_next()<CR>", silent)
keymap({ "n", "v", "o" }, 'H', "<cmd>lua require('tree-climber').goto_prev()<CR>", silent)
keymap({ 'v', 'o' }, 'M', "<cmd>lua require('tree-climber').select_node()<CR>", silent)

-- SpiderMotions
keymap({"n", "o", "x"}, "w", "<cmd>lua require('spider').motion('w')<CR>", { desc = "Spider-w" })
keymap({"n", "o", "x"}, "e", "<cmd>lua require('spider').motion('e')<CR>", { desc = "Spider-e" })
keymap({"n", "o", "x"}, "b", "<cmd>lua require('spider').motion('b')<CR>", { desc = "Spider-b" })
keymap({"n", "o", "x"}, "ge", "<cmd>lua require('spider').motion('ge')<CR>", { desc = "Spider-ge" })

--  ╭──────────────────────────────────────────────────────────╮
--  │ Editing                                                  │
--  ╰──────────────────────────────────────────────────────────╯

-- Case change in visual mode
keymap("v", "`", "u", silent)
keymap("v", "<A-`>", "U", silent)

-- Refactor with spectre
keymap("n", "<Leader>pr", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>", silent)
keymap("v", "<Leader>pr", "<cmd>lua require('spectre').open_visual()<CR>")

--  ╭──────────────────────────────────────────────────────────╮
--  │ Shortcuts                                                │
--  ╰──────────────────────────────────────────────────────────╯

-- Save file by CTRL-S
keymap("n", "<C-s>", ":w<CR>", silent)
keymap("i", "<C-s>", "<ESC> :w<CR>", silent)

-- Paste by CTRL-P
keymap("i", "<C-p>", "<C-r>+", silent)

-- Remove highlights
keymap("n", "<BS>", function()
  vim.cmd("noh")
  vim.api.nvim_input("<ESC>")
  local ok, hlslens = pcall(require, "hlslens")
  if ok then
    hlslens.stop()
  end
end, silent)

-- Insert Line with Enter
keymap("n", "<Enter>", ":call append(line('.'), '')<CR>", silent)
keymap("n", "<S-Enter>", ":call append(line('.') -1 , '')<CR>", silent)

-- Toggle Tagbar
keymap("n", "<F8>", "<cmd>:TagbarToggle<CR>", silent)

-- Toggle Ranger
keymap("n", "<F7>", "<cmd>:RnvimrToggle<CR>", silent)

-- Open links under cursor in browser with gx
if vim.fn.has('macunix') == 1 then
  keymap("n", "gx", "<cmd>silent execute '!open ' . shellescape('<cWORD>')<CR>", silent)
else
  keymap("n", "gx", "<cmd>silent execute '!xdg-open ' . shellescape('<cWORD>')<CR>", silent)
end

-- Comment Box
keymap("n", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", silent)
keymap("v", "<leader>ac", "<cmd>lua require('comment-box').lbox()<CR>", silent)

-- -- File explorer
-- keymap("n", "<leader>e", "<cmd>lua require'nvim-tree.api'.toggle()<CR>", silent)

-- Package (package.json / Cargo.toml)
keymap("n", "gp", utils.open_package, silent)

--  ╭──────────────────────────────────────────────────────────╮
--  │ Searching                                                │
--  ╰──────────────────────────────────────────────────────────╯

-- Telescope
keymap("n", "<C-p>", "<CMD>lua require('telescope.builtin').find_files()<CR>")
keymap("n", "<S-p>", "<CMD>lua require('plugins.telescope.pickers.custom_live_grep').live_grep()<CR>")

-- Open URLs with Firefox
keymap("n", 'gx', ":execute '!firefox ' . shellescape(expand('<cfile>'), 1)<CR>", silent)

--  ╭──────────────────────────────────────────────────────────╮
--  │ Buffers                                                  │
--  ╰──────────────────────────────────────────────────────────╯

-- Buffers
keymap("n", "<Tab>", ":BufferNext<CR>", silent)
keymap("n", "<S-Tab>", ":BufferPrevious<CR>", silent)
keymap("n", "<S-q>", ":BufferClose<CR>", silent)

-- Move between barbar buffers
keymap("n", "<Space>1", ":BufferGoto 1<CR>", silent)
keymap("n", "<Space>2", ":BufferGoto 2<CR>", silent)
keymap("n", "<Space>3", ":BufferGoto 3<CR>", silent)
keymap("n", "<Space>4", ":BufferGoto 4<CR>", silent)
keymap("n", "<Space>5", ":BufferGoto 5<CR>", silent)
keymap("n", "<Space>6", ":BufferGoto 6<CR>", silent)
keymap("n", "<Space>7", ":BufferGoto 7<CR>", silent)
keymap("n", "<Space>8", ":BufferGoto 8<CR>", silent)
keymap("n", "<Space>9", ":BufferGoto 9<CR>", silent)
keymap("n", "<A-1>", ":BufferGoto 1<CR>", silent)
keymap("n", "<A-2>", ":BufferGoto 2<CR>", silent)
keymap("n", "<A-3>", ":BufferGoto 3<CR>", silent)
keymap("n", "<A-4>", ":BufferGoto 4<CR>", silent)
keymap("n", "<A-5>", ":BufferGoto 5<CR>", silent)
keymap("n", "<A-6>", ":BufferGoto 6<CR>", silent)
keymap("n", "<A-7>", ":BufferGoto 7<CR>", silent)
keymap("n", "<A-8>", ":BufferGoto 8<CR>", silent)
keymap("n", "<A-9>", ":BufferGoto 9<CR>", silent)

--  ╭──────────────────────────────────────────────────────────╮
--  │ Yank                                                     │
--  ╰──────────────────────────────────────────────────────────╯

-- Don't yank on delete char
keymap("n", "x", '"_x', silent)
-- keymap("n", "X", '"_X', silent)
keymap("v", "x", '"_x', silent)
-- keymap("v", "X", '"_X', silent)

-- Don't yank on visual paste
keymap("v", "p", '"_dP', silent)

-- Copy whole file
keymap("n", "yA", "ggVGy", silent)

--  ╭──────────────────────────────────────────────────────────╮
--  │ LSP                                                      │
--  ╰──────────────────────────────────────────────────────────╯

keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", silent)
keymap("n", "gr", "<cmd>lua vim.lsp.buf.references({ includeDeclaration = false })<CR>", silent)
keymap("n", "<C-Space>", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
keymap("n", "M", "<cmd>lua vim.lsp.buf.signature_help()<CR>", silent)
keymap("n", "]g", "<cmd>lua vim.diagnostic.goto_next({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
keymap("n", "[g", "<cmd>lua vim.diagnostic.goto_prev({ float = { border = 'rounded', max_width = 100 }})<CR>", silent)
-- keymap("n", "m", "<cmd>lua vim.lsp.buf.hover()<CR>", silent)
keymap("n", "m", function()
  local winid = require('ufo').peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end)
-- keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent)
-- keymap("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", silent)
-- keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", silent)
-- keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.format()<CR>", silent)
-- keymap("n", "<leader>cl", "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", silent)
-- keymap("v", "<leader>cf", "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", silent)

keymap("n", "gt", "<cmd>TSHighlightCapturesUnderCursor<CR>", silent)
