-- require('base16-colorscheme').setup({
--   base00 = '#1a1b26', base01 = '#16161e', base02 = '#2f3549', base03 = '#444b6a',
--   base04 = '#787c99', base05 = '#a9b1d6', base06 = '#cbccd1', base07 = '#d5d6db',
--   base08 = '#c0caf5', base09 = '#a9b1d6', base0A = '#0db9d7', base0B = '#9ece6a',
--   base0C = '#b4f9f8', base0D = '#2ac3de', base0E = '#bb9af7', base0F = '#f7768e'
-- })

require('tokyonight').setup({
  style = "night",

  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value `:help attr-list`
    comments = "italic",
    keywords = "italic",
    functions = "NONE",
    variables = "NONE",
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  on_colors = function(colors)
    colors.magenta = "#DB48B9"
    colors.blue = "#667DFF"
    colors.blue1 = "#1FBBDE"
    colors.cyan = "#47BCFF"
    colors.border = "#1A1B26"
  end,

  --- You can override specific highlights to use other groups or a hex color
  --- fucntion will be called with a Highlights and ColorScheme table
  on_highlights = function(highlights, colors)


  end,
})

vim.cmd('colorscheme tokyonight')
