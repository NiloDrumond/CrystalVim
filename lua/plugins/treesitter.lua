require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'typescript', 'tsx', 'javascript', 'rust', 'toml', 'json' },
  highlight = {
    enable = true,
  },

  indent = {
    enable = true
  },

  --  ╭──────────────────────────────────────────────────────────╮
  --  │   Plugins                                                │
  --  ╰──────────────────────────────────────────────────────────╯

  autotag = {
    enable = true
  },

  rainbow = {
    enable = true,
    extended_mode = true
  },

  playground = {
    enable = true
  },

  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]]"] = "@block.inner",
        ["]f"] = "@function.outer",
        ["]m"] = "@class.outer",
        ["<C-Down>"] = "@parameter.inner"
      },
      goto_next_end = {
        ["]["] = "@block.inner",
        ["]F"] = "@function.outer",
        ["]M"] = "@class.outer",
        ["<C-Up>"] = "@parameter.inner"
      },
      goto_previous_start = {
        ["[["] = "@block.inner",
        ["[f"] = "@function.outer",
        ["[m"] = "@class.outer",
        ["<C-Right>"] = "@parameter.inner"
      },
      goto_previous_end = {
        ["[]"] = "@block.inner",
        ["[F"] = "@function.outer",
        ["[M"] = "@class.outer",
        ["<C-Left>"] = "@parameter.inner"
      },
    },
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["~"] = "@parameter.inner",
      },
    },
  },

  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },

}
