return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- manage itself
    use { 'tpope/vim-fugitive' }
    use { 'scrooloose/nerdcommenter' }
    use { 'psliwka/vim-smoothie' }
    use { 'vifm/vifm.vim' }
    use { 'gko/vim-coloresque' }
    use { 'lambdalisue/fern.vim' }
    use { 'Chiel92/vim-autoformat' }
    use { 'neovim/nvim-lspconfig' }
    use { 'glepnir/lspsaga.nvim' }
    use { 'tjdevries/lsp_extensions.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'onsails/lspkind-nvim' }
    use { 'tpope/vim-rhubarb' } -- github plugin
    use { 'nvim-lua/popup.nvim' }
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim' }
    use { 'glepnir/galaxyline.nvim' }
    use { 'Avimitin/nerd-galaxyline' }
    use { 'Pocco81/Catppuccino.nvim' }
    use { 'editorconfig/editorconfig-vim' }
    use { 'ms-jpq/coq_nvim', { branch = 'coq'} }
    use { 'ms-jpq/coq.artifacts', { branch = 'artifacts'} }
    use { 'mfussenegger/nvim-dap' }
    use { 'simrat39/symbols-outline.nvim' }
    use {'akinsho/bufferline.nvim' }
    use {'nvim-treesitter/nvim-treesitter'}
end )
