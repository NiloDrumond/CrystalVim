require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'typescript', 'tsx', 'javascript', 'rust', 'toml', 'json' },
  highlight = true,

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
}
