require("luasnip.loaders.from_vscode").lazy_load({ paths = { os.getenv('XDG_CONFIG_HOME') .. '/nvim/snippets' } })

vim.api.nvim_create_user_command(
    'Snip',
    function()
        require("luasnip.loaders").edit_snippet_files({
      edit = function(file)
        vim.cmd(":ene|e" .. file)
      end
    })
    end,
    { nargs = 0 }
)
