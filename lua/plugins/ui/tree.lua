local utils = require('utils')
local nvim_tree_events = require('nvim-tree.events')
local bufferline_api = require('bufferline.api')

local TREE_WIDTH = 35

local git_icons = {
  unstaged = "",
  staged = "",
  unmerged = "",
  renamed = "➜",
  untracked = "",
  deleted = "",
  ignored = "◌"
}

local function grep_in(node)
  if not node then
    return
  end
  local path = node.absolute_path or uv.cwd()
  if node.type ~= 'directory' and node.parent then
    path = node.parent.absolute_path
  end
  require('telescope.builtin').live_grep({
    search_dirs = { path },
    prompt_title = string.format('Grep in [%s]', vim.fs.basename(path)),
  })
end


local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end


  -- Default mappings not inserted as:
  --  remove_keymaps = true
  --  OR
  --  view.mappings.custom_only = true


  -- Mappings migrated from view.mappings.list
  --
  -- You will need to insert "your code goes here" for any mappings with a custom action_cb
  vim.keymap.set('n', '<CR>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer, opts('Open: In Place'))
  vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts('Open: No Window Picker'))
  vim.keymap.set('n', '<2-RightMouse>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<C-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
  vim.keymap.set('n', '<C-t>', api.node.open.tab, opts('Open: New Tab'))
  vim.keymap.set('n', '<', api.node.navigate.sibling.prev, opts('Previous Sibling'))
  vim.keymap.set('n', '>', api.node.navigate.sibling.next, opts('Next Sibling'))
  vim.keymap.set('n', 'P', api.node.navigate.parent, opts('Parent Directory'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '<Tab>', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', 'K', api.node.navigate.sibling.first, opts('First Sibling'))
  vim.keymap.set('n', 'J', api.node.navigate.sibling.last, opts('Last Sibling'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Git Ignore'))
  vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'R', api.tree.reload, opts('Refresh'))
  vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'd', api.fs.remove, opts('Delete'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', '<C-r>', api.fs.rename_sub, opts('Rename: Omit Filename'))
  vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'c', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'y', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'gy', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts('Prev Git'))
  vim.keymap.set('n', ']c', api.node.navigate.git.next, opts('Next Git'))
  vim.keymap.set('n', '-', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'o', api.node.run.system, opts('Run System'))
  vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'W', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'gs', function()
    local node = api.tree.get_node_under_cursor()
    -- your code goes here
  end, opts(''))


end

require 'nvim-tree'.setup {
  on_attach = on_attach,
  -- disables netrw completely
  disable_netrw                      = false,
  -- hijack netrw window on startup
  hijack_netrw                       = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab                        = false,
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor                      = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd                         = true,
  -- opens in place of the unnamed buffer if it's empty
  hijack_unnamed_buffer_when_opening = false,
  --false by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree
  respect_buf_cwd                    = true,
  -- show lsp diagnostics in the signcolumn
  diagnostics                        = {
    enable = true,
    icons  = {
      hint    = "",
      info    = "",
      warning = "",
      error   = "",
    }
  },
  renderer                           = {
    add_trailing = false,
    group_empty = false,
    highlight_git = true,
    highlight_opened_files = "none",
    root_folder_modifier = ":~",
    full_name = true,
    indent_markers = {
      enable = false,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      show = {
        folder_arrow = false
      },
      glyphs = {
        git = git_icons
      }
    }
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file                = {
    -- enables the feature
    enable      = true,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = true,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open                        = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = "",
    -- the command arguments as a list
    args = {}
  },
  filters                            = {
    dotfiles = false,
    custom = {}
  },
  git                                = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  actions                            = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      -- if true the tree will resize itself after opening a file
      resize_window = true,
      window_picker = {
        enable = true,
        chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        exclude = {
          filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
          buftype = { "nofile", "terminal", "help" },
        },
      },
    },
  },
  view                               = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = TREE_WIDTH,
    hide_root_folder = false,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = true,
      -- list of mappings to set on the tree manually
    },
    number = false,
    relativenumber = false
  },
  trash                              = {
    cmd = "trash",
    require_confirm = true
  }
}

vim.api.nvim_set_keymap("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>f", "<cmd>NvimTreeFindFile<CR>", { noremap = true, silent = true })

-- https://github.com/nvim-tree/nvim-tree.lua/discussions/1517
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  callback = function(args)
    if vim.fn.expand "%:p" ~= "" then
      vim.api.nvim_del_autocmd(args.id)
      vim.cmd "noautocmd NvimTreeOpen"
      vim.cmd "noautocmd wincmd p"
    end
  end,
})


nvim_tree_events.subscribe('TreeOpen', function()
  bufferline_api.set_offset(TREE_WIDTH + 1, utils.add_whitespaces(13) .. '             ')
end)

nvim_tree_events.subscribe('TreeClose', function()
  bufferline_api.set_offset(0)
end)
