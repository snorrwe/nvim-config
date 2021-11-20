return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- manage itself
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
    use {
        'nvim-telescope/telescope.nvim',
        config=function()
            require("plugin_setup").setupTelescope()
        end
    }
    use { 'glepnir/galaxyline.nvim' }
    use { 'Avimitin/nerd-galaxyline' }
    use { 'editorconfig/editorconfig-vim' }
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        requires = { { 'ms-jpq/coq.artifacts', { branch = 'artifacts'} }},
        config = function()
            require("plugin_setup").setupLsp()
        end
    }
    use {
        'mfussenegger/nvim-dap',
        config = function()
            require("plugin_setup").setupDap()
        end
    }
    use { 'simrat39/symbols-outline.nvim' }
    use {
        'akinsho/bufferline.nvim',
        config=function()
            require("plugin_setup").setupBufferline()
        end
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        config=function()
            require("plugin_setup").setupTS()
        end
    }
    use {'kdheepak/lazygit.nvim'}
    use {
        'ayu-theme/ayu-vim',
        config = function()
            vim.cmd('colorscheme ayu')
        end
    }
end )
