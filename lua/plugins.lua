local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local compile_path = install_path .. "/plugin/packer_compiled.lua"
local packer_bootstrap = nil

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

return require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'

    -- Pre-requisites
    use { 'lewis6991/impatient.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'MunifTanjim/nui.nvim' }

    -- Glamour
    use { 'folke/tokyonight.nvim', config = "require('theme')" }
    use { 'NvChad/nvim-colorizer.lua', config = "require('plugins.glamour.colorizer')" }
    use { 'lukas-reineke/indent-blankline.nvim', config = "require('plugins.glamour.indent')" }
    use { 'danilamihailov/beacon.nvim' }
    use { 'EdenEast/nightfox.nvim', config = "require('plugins.glamour.nightfox')" }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = "require('plugins.syntax.treesitter')" }
    use { 'windwp/nvim-ts-autotag', after = { 'nvim-treesitter' } }
    use { 'p00f/nvim-ts-rainbow', after = { 'nvim-treesitter' } }
    use { 'nvim-treesitter/playground', after = { 'nvim-treesitter' } }
    use { 'm-demare/hlargs.nvim', config = function() require('hlargs').setup({ color = "#F7768E" }) end }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } }
    use { 'RRethy/nvim-treesitter-textsubjects', after = { 'nvim-treesitter' } }
    use { 'nvim-treesitter/nvim-treesitter-context', after = { 'nvim-treesitter' } }
    use { 'drybalka/tree-climber.nvim', after = { 'nvim-treesitter' } }

    -- Syntax
    use { 'windwp/nvim-autopairs', after = { 'nvim-treesitter', }, config = "require('plugins.syntax.autopairs')" }
    use { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' }
    use { 'numToStr/Comment.nvim', config = "require('plugins.syntax.comment')", after = "nvim-ts-context-commentstring" }
    use { 'LudoPinelli/comment-box.nvim' }
    use { 'L3MON4D3/LuaSnip', requires = { 'rafamadriz/friendly-snippets' }, after = 'cmp_luasnip' }

    -- UI
    use { 'folke/which-key.nvim', config = "require('plugins.ui.which-key')", event = "BufWinEnter" }
    use { 'kyazdani42/nvim-tree.lua', config = "require('plugins.ui.tree')" }
    use { 'romgrk/barbar.nvim', wants = 'nvim-web-devicons', config = "require('plugins.ui.barbar')" }
    use { 'stevearc/dressing.nvim', config = "require('plugins.ui.dressing')" }
    use { 'akinsho/nvim-toggleterm.lua', tag = '*', config = "require('plugins.ui.toggleterm')" }

    -- LSP Base
    use { 'williamboman/mason.nvim', config = "require('plugins.lsp.mason')" }
    use { 'williamboman/mason-lspconfig.nvim' }
    use { 'neovim/nvim-lspconfig' }

    -- LSP addons
    use { 'jose-elias-alvarez/typescript.nvim' }
    use { 'folke/lsp-trouble.nvim', config = "require('plugins.lsp.trouble')" }
    use { 'onsails/lspkind-nvim' }

    -- CMP
    use { 'hrsh7th/nvim-cmp', event = 'InsertEnter', config = "require('plugins.lsp.cmp')" }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }
    use { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }


    -- Refactor
    use { 'nvim-pack/nvim-spectre' }

    -- Movement
    use { 'gbprod/stay-in-place.nvim', config = function() require('stay-in-place').setup({}) end }
    use { 'mg979/vim-visual-multi' }
    use { 'karb94/neoscroll.nvim', config = "require('plugins.movement.neoscroll')" }

    -- General
    use { 'AndrewRadev/splitjoin.vim' }
    use { 'kylechui/nvim-surround', config = function() require("nvim-surround").setup({}) end }
    -- NOTE: table may be useful someday
    -- use { 'dhruvasagar/vim-table-mode' }
    use { 'nacro90/numb.nvim', config = "require('plugins.numb')" }
    use { 'folke/todo-comments.nvim', config = "require('plugins.todo-comments')" }
    use { 'folke/zen-mode.nvim', config = "require('plugins.glamour.zen')" }
    use { 'folke/twilight.nvim', config = "require('plugins.glamour.twilight')" }
    use { 'mbbill/undotree' }
    use { 'tpope/vim-abolish' }
    use { 'airblade/vim-rooter', config = "require('plugins.rooter')" }


    -- Git
    use { 'kdheepak/lazygit.nvim' }
    use { 'akinsho/git-conflict.nvim', tag = "*", config = "require('plugins.git.conflict')" }
    use { 'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = "require('plugins.git.signs')",
      event = "BufRead"
    }

    -- TODO: Testing
    -- use {
    --   'rcarriga/neotest',
    --   requires = {
    --     'nvim-lua/plenary.nvim',
    --     'nvim-treesitter/nvim-treesitter',
    --     'antoinemadec/FixCursorHold.nvim',
    --     'haydenmeade/neotest-jest'
    --   },
    --   config = "require('plugins.neotest')"
    -- }


    -- TODO: Debugger
    -- use { 'mfussenegger/nvim-dap', config = "require('plugins.dap')" }
    -- use { 'theHamsta/nvim-dap-virtual-text' }
    -- use { 'rcarriga/nvim-dap-ui' }


    if packer_bootstrap then
      require('packer').sync()
    end
  end,
  config = {
    compile_path = compile_path,
    disable_commands = true,
    max_jobs = 50,
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end
    }
  }
})
