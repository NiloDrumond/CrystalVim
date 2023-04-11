require 'colorizer'.setup({
  filetypes = {
    '*',
    "!rust",
    "!gdscript"
  },
  user_default_options = {
    mode = "background",
    tailwind = false, -- Enable tailwind colors
  }
})
