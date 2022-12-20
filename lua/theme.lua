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
    -- colors.blue = "#668DFF"
    colors.blue = "#7595ff"
    colors.blue1 = "#1FBBDE"
    colors.cyan = "#47BCFF"
    colors.border = "#1A1B26"
    colors.purple = "#a379ec"
  end,

  --- You can override specific highlights to use other groups or a hex color
  --- fucntion will be called with a Highlights and ColorScheme table
  on_highlights = function(hl, c)
    hl.NvimTreeRootFolder = {
      fg = c.orange
    }

    hl["@keyword"] = { fg = c.purple }
    hl["@function.macro"] = { fg = c.red }
    hl["@error.json"] = { bg = c.red }

    hl.VM_Extend = { bg = c.bg_search }
    hl.VM_Cursor = { bg = c.bg_search, underline = true }
    hl.VM_Mono = { fg = c.red, underline = true, bold = true }
    hl.VM_Insert = {sp = c.fg, underline = true }
    -- hl.VM_Mono = { fg = c.purple }

    hl.PackageInfoOutdatedVersion = { fg = c.red, }
    hl.PackageInfoUptodateVersion = { fg = c.green1, }
  end,
})

vim.cmd('colorscheme tokyonight')
