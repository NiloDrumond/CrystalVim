-- Set barbar's options
require("bufferline").setup {
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = "",
        highlight = "Directory",
        separator = true -- use a "true" to enable the default, or set your own character
      }
    },
  }
}
