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
    use { 'kyazdani42/nvim-web-devicons' }


    -- Glamour
    use { 'folke/tokyonight.nvim', config = "require('theme')" }

    -- Treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = "require('plugins.treesitter')" }
    use { 'windwp/nvim-ts-autotag', after = { 'nvim-treesitter' } }
    use { 'p00f/nvim-ts-rainbow', after = { 'nvim-treesitter' } }
    use { 'nvim-treesitter/playground', after = { 'nvim-treesitter' } }
    use { 'm-demare/hlargs.nvim', config = function() require('hlargs').setup({ color = "#F7768E" }) end }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after = { 'nvim-treesitter' } }
    use { 'RRethy/nvim-treesitter-textsubjects', after = { 'nvim-treesitter' } }

    -- UI
    use { 'folke/which-key.nvim', config = "require('plugins.which-key')", event = "BufWinEnter" }

    -- LSP Base
    use { 'williamboman/mason.nvim' }
    use { 'williamboman/mason-lspconfig.nvim' }
    use { 'neovim/nvim-lspconfig' }

    -- LSP addons
    use { 'jose-elias-alvarez/typescript.nvim' }


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
