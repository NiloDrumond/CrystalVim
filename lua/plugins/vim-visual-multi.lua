vim.g.VM_theme_set_by_colorscheme = true

vim.cmd([[
    aug VMlens
        au!
        au User visual_multi_start lua require('plugins.vmlens').start()
        au User visual_multi_exit lua require('plugins.vmlens').exit()
    aug END
]])
