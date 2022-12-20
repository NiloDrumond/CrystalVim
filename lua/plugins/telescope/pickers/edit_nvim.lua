local builtin = require('telescope.builtin')

return function()
  builtin.find_files(
    require('telescope.themes').get_dropdown({
      hidden = false,
      color_devicons   = true,
      cwd              = os.getenv('XDG_CONFIG_HOME') .. '/nvim',
      previewer        = false,
      prompt_title     = "CrystalVim Config",
      sorting_strategy = "ascending",
      winblend         = 4,
      layout_config    = {
        horizontal = {
          mirror = false,
        },
        vertical = {
          mirror = false,
        },
        prompt_position = "top",
      },
    }))
end
