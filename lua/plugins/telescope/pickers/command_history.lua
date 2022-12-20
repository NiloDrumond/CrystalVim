local builtin = require('telescope.builtin')

return function()
  builtin.command_history(
    require('telescope.themes').get_dropdown({
      color_devicons = true,
      winblend       = 4,
      layout_config  = {
        width = function(_, max_columns, _)
          return math.min(max_columns, 150)
        end,

        height = function(_, _, max_lines)
          return math.min(max_lines, 15)
        end,
      },
    }))
end
