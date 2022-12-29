local wk = require('which-key')
local utils = require('utils')

--  ╭──────────────────────────────────────────────────────────╮
--  │ Configs                                                  │
--  ╰──────────────────────────────────────────────────────────╯

wk.setup {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    presets = { operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false, -- adds help for motions text_objects = false, -- help for text objects triggered after entering an operator
      windows = false, -- default bindings on <c-w>
      nav = false, -- misc bindings to work with windows
      z = false, -- bindings for folds, spelling and others prefixed with z
      g = false, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "rounded", -- none, single, double, shadow, rounded
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 4, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  -- triggers = "auto", -- automatically setup triggers
  triggers = { "<leader>" }, -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}


local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local visual_opts = {
  mode = "v", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}


--  ╭──────────────────────────────────────────────────────────╮
--  │ Mappings                                                 │
--  ╰──────────────────────────────────────────────────────────╯

local normal_mode_mappings = {
  -- ignore
  ["1"] = "which_key_ignore",
  ["2"] = "which_key_ignore",
  ["3"] = "which_key_ignore",
  ["4"] = "which_key_ignore",
  ["5"] = "which_key_ignore",
  ["6"] = "which_key_ignore",
  ["7"] = "which_key_ignore",
  ["8"] = "which_key_ignore",
  ["9"] = "which_key_ignore",

  -- single
  ["="] = { '<cmd>vertical resize +5<CR>', 'resize +5' },
  ["-"] = { '<cmd>vertical resize -5<CR>', 'resize +5' },
  ["v"] = { '<C-W>v', 'split right' },
  ["V"] = { '<C-W>s', 'split below' },

  ["/"] = {
    name = "CrystalVim",
    i = { '<cmd>PackerInstall<CR>', 'install plugins' },
    c = { '<cmd>e $XDG_CONFIG_HOME/nvim/lua/plugins.lua<CR>', 'open config' },
    d = { '<cmd>e ~/.config/.zshrc<CR>', 'open dotfiles' },
    u = { '<cmd>PackerSync<CR>', 'update plugins' },
    s = { '<cmd>lua require("plugins.telescope.pickers.edit_nvim")()<CR>', 'search config' },
    q = { '<cmd>qa<CR>', 'quit' }
  },

  a = {
    name = "Actions",
    n = { '<cmd>enew<CR>', "new buffer" },
    u = { '<cmd>set nonumber!<CR>', 'line numbers' },
    r = { '<cmd>set norelativenumber!<CR>', 'relative number' },
  },

  b = {
    name = "Buffer",
    b = { '<cmd>BufferMovePrevious<CR>', 'Move back' },
    c = { '<cmd>BufferCloseAllButCurrent<CR>', 'Close but current' },
    d = { '<cmd>BufferOrderByDirectory<CR>', 'Order by directory' },
    f = { '<cmd>bfirst<CR>', 'First buffer' },
    l = { '<cmd>BufferCloseBuffersLeft<CR>', 'Close Left' },
    r = { '<cmd>BufferCloseBuffersRight<CR>', 'Close Right' },
    n = { '<cmd>BufferMoveNext<CR>', 'Move next' },
    p = { '<cmd>BufferPick<CR>', 'Pick Buffer' },
  },



  g = {
    name = "Git",
    b = { "blame line" },
    B = { '<cmd>Telescope git_branches<CR>', 'branches' },
    c = {
      name = 'Conflict',
      b = { '<cmd>GitConflictChooseBoth<CR>', 'choose both' },
      n = { '<cmd>GitConflictNextConflict<CR>', 'move to next conflict' },
      o = { '<cmd>GitConflictChooseOurs<CR>', 'choose ours' },
      p = { '<cmd>GitConflictPrevConflict<CR>', 'move to prev conflict' },
      t = { '<cmd>GitConflictChooseTheirs<CR>', 'choose theirs' },
      r = { '<cmd>GitConflictRefresh<CR>', 'refresh' },
      f = { '<cmd>GitConflictListQf<CR>', 'quick fix' }
    },
    -- d = { '<cmd>lua require("plugins.git.diffview").toggle_file_history()<CR>', 'diff file' },
    f = { '<cmd>Telescope git_files<CR>', 'git files' },
    g = { '<cmd>LazyGit<CR>', 'lazygit' },
    s = { '<cmd>Telescope git_status<CR>', 'status' },
    h = {
      name = "Hunk",
      d = "diff hunk",
      p = "preview",
      R = "reset buffer",
      r = "reset hunk",
      s = "stage hunk",
      S = "stage buffer",
      t = "toggle deleted",
      u = "undo stage",
    },
    l = {
      name = "Log",
      A = { "<cmd>lua require('plugins.telescope.pickers.git-commits').my_git_commits()<CR>", "commits (Telescope)" },
      a = { "<cmd>LazyGitFilter<CR>", "commits" },
      C = { "<cmd>lua require('plugins.telescope.pickers.git-commits').my_git_bcommits()<CR>",
        "buffer commits (Telescope)" },
      c = { "<cmd>LazyGitFilterCurrentFile<CR>", "buffer commits" },
    },
    -- s = { '<cmd>lua require("plugins.git.diffview").toggle_status()<CR>', 'status' },
  },

  p = {
    name = "Project",
    f = { "<CMD>lua require('plugins.telescope.pickers.project_files')({ default_text = vim.fn.expand('<cword>'), initial_mode = 'normal' })<CR>",
      'file' },
    w = { "<CMD>lua require('telescope.builtin').grep_string({ initial_mode = 'normal' })<CR>", 'word' },
    -- l = { "<cmd>lua require'telescope'.extensions.repo.cached_list{file_ignore_patterns={'/%.cache/', '/%.cargo/', '/%.local/', '/%timeshift/', '/usr/', '/srv/', '/%.oh%-my%-zsh', '/Library/', '/%.cocoapods/'}}<CR>",
    --   'list' },
    r = { 'refactor' },
    -- s = { "<cmd>SessionManager save_current_session<CR>", 'save session' },
    t = { "<cmd>TodoTrouble<CR>", 'todo' },
  },

  s = {
    name = "Search",
    a = { '<cmd>lua require"telescope.builtin".find_files({ hidden = true })<CR>', 'all files' },
    c = { '<cmd>Telescope colorscheme<CR>', 'color schemes' },
    h = { '<cmd>Telescope oldfiles hidden=true<CR>', 'file history' },
    H = { '<cmd>lua require("plugins.telescope.pickers.command_history")()<CR>', 'command history' },
    s = { '<cmd>Telescope search_history theme=dropdown<CR>', 'search history' },
    f = { '<cmd>lua require("plugins.telescope.pickers.live_grep_in_folder")()<CR>', 'inside folder' },
    n = { "<cmd>Snip<CR>", 'snippets' }
  },

  u = { '<cmd>UndotreeToggle<CR>', 'undo tree' },

  [" "] = { '<cmd>:lua vim.lsp.buf.format()<CR>', 'format' },
}

local visual_mode_mappings = {
  -- single
  ["s"] = { "<cmd>'<,'>sort<CR>", 'sort' },

  a = {
    name = "Actions",
    c = { 'comment box' },
  },

  -- g = {
  --   name = "Git",
  --   h = {
  --     name = "Hunk",
  --     r = "reset hunk",
  --     s = "stage hunk",
  --   },
  -- },

  p = {
    name = "Project",
    r = { 'refactor' },
  },

  -- t = {
  --   name = "Table Mode",
  --   t = { 'tableize' },
  -- },
}

-- ╭──────────────────────────────────────────────────────────╮
-- │ Register                                                 │
-- ╰──────────────────────────────────────────────────────────╯

wk.register(normal_mode_mappings, opts)
wk.register(visual_mode_mappings, visual_opts)

--  ╭──────────────────────────────────────────────────────────╮
--  │ Attachables                                              │
--  ╰──────────────────────────────────────────────────────────╯

local M = {};

local default_opts = {
  prefix = "<leader>",
  silent = true,
  noremap = true,
  nowait = false,
}

local common_lsp_keys = {
  name = "LSP",
  a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'code action' },
  d = { '<cmd>TroubleToggle<CR>', 'local diagnostics' },
  D = { '<cmd>Telescope diagnostics wrap_results=true<CR>', 'workspace diagnostics' },
  f = { "<cmd>lua vim.lsp.buf.format()<CR>", 'format' },
  l = { "<cmd>lua vim.diagnostic.open_float({ border = 'rounded', max_width = 100 })<CR>", 'line diagnostics' },
  r = { "<cmd>lua vim.lsp.buf.rename()<CR>", 'rename' },
  t = { '<cmd>LspToggleAutoFormat<CR>', 'toggle format on save' },
}

M.attach_common_lsp = function(bufnr)
  wk.register({
    c = common_lsp_keys
  }, utils.spread({
    buffer = bufnr,
    mode = "n",
  }, default_opts))

  wk.register({
    c = {
      name = "LSP",
      a = { "<cmd>'<,'>lua vim.lsp.buf.range_code_action()<CR>", 'range code action' },
      f = { "<cmd>'<.'>lua vim.lsp.buf.range_formatting()<CR>", 'range format' },
    }
  },
    utils.spread({ buffer = bufnr, mode = "v" }, default_opts))

end

M.attach_typescript = function(bufnr)
  wk.register({
    c = utils.spread({
      i = { "<cmd>TypescriptAddMissingImports<CR>", 'add missing imports' }
    }, common_lsp_keys)
  },
    utils.spread({
      buffer = bufnr,
      mode = "n"
    }, default_opts)
  )
end

M.attach_spectre = function(bufnr)
  wk.register({
    ["R"] = { '[SPECTRE] Replace all' },
    ["o"] = { '[SPECTRE] Show options' },
    ["q"] = { '[SPECTRE] Send all to quicklist' },
    ["v"] = { '[SPECTRE] Change view mode' },
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

M.attach_zen = function(bufnr)
  wk.register({
    ["z"] = { '<cmd>ZenMode<CR>', 'zen' },
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

M.attach_npm = function(bufnr)
  wk.register({
    c = {
      name = "NPM",
      c = { '<cmd>lua require("package-info").change_version()<CR>', 'change version' },
      d = { '<cmd>lua require("package-info").delete()<CR>', 'delete package' },
      i = { '<cmd>lua require("package-info").install()<CR>', 'install new package' },
      t = { '<cmd>lua require("package-info").toggle()<CR>', 'toggle' },
      u = { '<cmd>lua require("package-info").update()<CR>', 'update package' },
    }
  }, {
    buffer = bufnr,
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  })
end

M.attach_cargo = function(bufnr)
  wk.register({
    c = {
      name = "crates",
      t = { '<cmd>lua require("crates").toggle()<CR>', 'toggle' },
      r = { '<cmd>lua require("crates").reload()<CR>', 'reload' },
      v = { '<cmd>lua require("crates").show_versions_popup()<CR>', 'versions popup' },
      f = { '<cmd>lua require("crates").show_features_popup()<CR>', 'features popup' },
      d = { '<cmd>lua require("crates").show_dependencies_popup()<CR>', 'dependencies popup' },
      u = { '<cmd>lua require("crates").update_crate()<CR>', 'update' },
      a = { '<cmd>lua require("crates").update_all_crates()<CR>', 'update all' },
      U = { '<cmd>lua require("crates").upgrade_crate()<CR>', 'upgrade' },
      A = { '<cmd>lua require("crates").upgrade_all_crates()<CR>', 'upgrade all' },
      H = { '<cmd>lua require("crates").open_homepage()<CR>', 'homepage' },
      R = { '<cmd>lua require("crates").open_repository()<CR>', 'repository' },
      D = { '<cmd>lua require("crates").open_documentation()<CR>', 'documentation' },
      C = { '<cmd>lua require("crates").open_crates_io()<CR>', 'crates io' },
    }
  },
    { buffer = bufnr, mode = "n", prefix = "<leader>", silent = true, noremap = true, nowait = false }
  )

  wk.register({
    c = {
      u = { '<cmd>lua require("crates").update_crates()<CR>', 'update selected' },
      U = { '<cmd>lua require("crates").upgrade_crates()<CR>', 'upgrade selected' },
    }
  }, {
    buffer = bufnr, mode = "v", prefix = "<leader>", silent = true, noremap = true, nowait = false
  })
end

return M;
