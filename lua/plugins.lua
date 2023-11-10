local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup({
  function(use)
    use 'wbthomason/packer.nvim'

    -- Pre-requisites
    -- use_rocks 'jsregexp'
    use { 'lewis6991/impatient.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'MunifTanjim/nui.nvim' }

    -- Glamour
    use { 'folke/tokyonight.nvim' }
    use { 'NvChad/nvim-colorizer.lua', config = "require('plugins.glamour.colorizer')" }
    use { 'lukas-reineke/indent-blankline.nvim', config = "require('plugins.glamour.indent')" }
    use { 'danilamihailov/beacon.nvim' }
    -- use { 'EdenEast/nightfox.nvim', config = "require('plugins.glamour.nightfox')" }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', config = "require('plugins.syntax.treesitter')" }
    use { 'windwp/nvim-ts-autotag', after = { 'nvim-treesitter' } }
    use { 'hiphish/rainbow-delimiters.nvim', after = { 'nvim-treesitter', config = "require('plugins.syntax.rainbow')" } }
    use { 'nvim-treesitter/playground', after = { 'nvim-treesitter' } }
    use { 'm-demare/hlargs.nvim', config = function() require('hlargs').setup({ color = "#F7768E" }) end }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } }
    use { 'RRethy/nvim-treesitter-textsubjects', after = { 'nvim-treesitter' } }
    -- use { 'nvim-treesitter/nvim-treesitter-context', after = { 'nvim-treesitter' }, config = function()
    --   require('treesitter-context').setup({
    --     enable = true,      -- Enable this plugin (Can be enabled/disabled later via commands)
    --     max_lines = 2,      -- How many lines the window should span. Values <= 0 mean no limit.
    --     min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    --     line_numbers = true,
    --     multiline_threshold = 20, -- Maximum number of lines to show for a single context
    --     trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    --     mode = 'cursor',    -- Line used to calculate context. Choices: 'cursor', 'topline'
    --     -- Separator between context and content. Should be a single character string, like '-'.
    --     -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    --     separator = nil,
    --     zindex = 20, -- The Z-index of the context window
    --     on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
    --   })
    -- end }
    use { 'drybalka/tree-climber.nvim', after = { 'nvim-treesitter' } }

    -- Syntax
    use { 'windwp/nvim-autopairs', after = { 'nvim-treesitter', }, config = "require('plugins.syntax.autopairs')" }
    use { 'JoosepAlviste/nvim-ts-context-commentstring', after = 'nvim-treesitter' }
    use { 'numToStr/Comment.nvim', config = "require('plugins.syntax.comment')",
      after = "nvim-ts-context-commentstring" }
    use { 'LudoPinelli/comment-box.nvim' }
    use { 'L3MON4D3/LuaSnip', config = "require('plugins.syntax.luasnip')",
      run = "make install_jsregexp" }
    use { 'axelvc/template-string.nvim', config = "require('plugins.syntax.template-string')",
      after = 'nvim-treesitter' }
    use { 'sbdchd/neoformat' }
    use { 'dmmulroy/tsc.nvim', config = "require('plugins.syntax.tsc')" }

    -- UI
    use { 'folke/which-key.nvim', config = "require('plugins.which-key')", event = "BufWinEnter" }
    use { 'kyazdani42/nvim-tree.lua', config = "require('plugins.ui.tree')" }
    use { 'romgrk/barbar.nvim', wants = 'nvim-web-devicons', config = "require('plugins.ui.barbar')" }
    use { 'stevearc/dressing.nvim', config = "require('plugins.ui.dressing')" }
    use { 'akinsho/nvim-toggleterm.lua', tag = '*', config = "require('plugins.ui.toggleterm')" }
    use { 'nvim-pack/nvim-spectre' }
    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = "require('plugins.ui.lualine')",
      event = "BufWinEnter"
    }
    use { 'petertriho/nvim-scrollbar', config = "require('plugins.ui.scrollbar')" }
    use { 'kevinhwang91/nvim-hlslens', config = "require('plugins.ui.hlslens')", after = { 'nvim-scrollbar' } }
    use { 'rcarriga/nvim-notify', config = "require('plugins.ui.notify')" }
    use { 'goolord/alpha-nvim', config = "require('plugins.ui.alpha')" }
    use { "preservim/tagbar", config = "require('plugins.syntax.tagbar')" }

    -- LSP Base
    use { 'williamboman/mason.nvim', config = "require('plugins.lsp.mason')" }
    use { 'williamboman/mason-lspconfig.nvim' }
    use { 'neovim/nvim-lspconfig' }

    -- LSP addons
    use {
      "pmizio/typescript-tools.nvim",
      requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
      config = "require('plugins.lsp.typescript-tools')" }
    use { 'folke/lsp-trouble.nvim', config = "require('plugins.lsp.trouble')" }
    use { 'onsails/lspkind-nvim' }
    use { "SmiteshP/nvim-navic", requires = "neovim/nvim-lspconfig", config = "require('plugins.lsp.navic')" }
    use { 'vuki656/package-info.nvim', event = "BufEnter package.json",
      config = "require('plugins.lsp.package-info')" }
    use { 'simrat39/rust-tools.nvim', config = "require('plugins.lsp.rust-tools')",
      requires = { 'neovim/nvim-lspconfig' } }
    use { 'Saecki/crates.nvim', config = "require('plugins.lsp.crates')", event = "BufRead Cargo.toml" }
    use { 'lvimuser/lsp-inlayhints.nvim', config = function() require('lsp-inlayhints').setup() end }
    use { 'habamax/vim-godot' }

    -- CMP
    use { 'hrsh7th/nvim-cmp', event = 'BufEnter' }
    use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }
    use { 'saadparwaiz1/cmp_luasnip', after = { 'nvim-cmp', 'LuaSnip' }, config = "require('plugins.lsp.cmp')" }
    use { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-calc', after = 'nvim-cmp' }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' }
    use { 'David-Kunz/cmp-npm', after = { 'nvim-cmp', 'plenary.nvim' }, config = "require('plugins.lsp.cmp-npm')" }

    -- Motion
    use { 'gbprod/stay-in-place.nvim', config = function() require('stay-in-place').setup({}) end }
    use { 'mg979/vim-visual-multi', config = "require('plugins.vim-visual-multi')" }
    use { 'karb94/neoscroll.nvim', config = "require('plugins.movement.neoscroll')" }
    use { 'ggandor/leap.nvim', config = "require('plugins.movement.leap')", requires = { 'tpope/vim-repeat' } }
    use { 'ggandor/flit.nvim', config = "require('plugins.movement.flit')" }
    use { "chrisgrieser/nvim-spider" }

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
    use { 'gpanders/editorconfig.nvim' }
    use { 'kevinhwang91/nvim-bqf', ft = 'qf' }
    use { 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async' }
    use { 'kevinhwang91/rnvimr' }

    -- Git
    use { 'kdheepak/lazygit.nvim' }
    use { 'akinsho/git-conflict.nvim', tag = "*", config = "require('plugins.git.conflict')" }
    use { 'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = "require('plugins.git.signs')",
      event = "BufRead"
    }

    -- Telescope
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use { 'cljoly/telescope-repo.nvim' }
    use { 'nvim-telescope/telescope.nvim',
      config = "require('plugins.telescope')",
      after = { "telescope-fzf-native.nvim" },
      requires = {
        { 'nvim-lua/plenary.nvim' },
      }
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
    disable_commands = true,
    max_jobs = 50,
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'rounded' })
      end
    }
  }
})
