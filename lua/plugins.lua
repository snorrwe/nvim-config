return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- manage itself
    use { 'scrooloose/nerdcommenter' }
    use { 'psliwka/vim-smoothie' }
    use { 'gko/vim-coloresque' }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
          'kyazdani42/nvim-web-devicons', -- optional, for file icon
        },
        config = function()
            require("plugin_setup").setupTree()
        end
    }
    use {
        'sbdchd/neoformat',
        config = function()
            require("plugin_setup").setupAutoformat()
        end
    }
    use { 'neovim/nvim-lspconfig' }
    use {
        'tami5/lspsaga.nvim',
        config = function()
            require("plugin_setup").setupLspSaga()
        end
    }
    use { 'tjdevries/lsp_extensions.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use {
        'onsails/lspkind-nvim',
        config = function()
            require("plugin_setup").setupLspKind()
        end
    }
    use {
      'nvim-lualine/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true},
      config = function()
          require("config_lualine")
      end
    }
    use { 'editorconfig/editorconfig-vim' }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{ 'nvim-lua/plenary.nvim' }},
        config=function()
            require("plugin_setup").setupTelescope()
        end
    }
    use {
        'ms-jpq/coq_nvim',
        branch = 'coq',
        run = function()
            vim.cmd[[COQdeps]]
        end,
        requires = {{ 'ms-jpq/coq.artifacts', { branch = 'artifacts'}}},
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
    use {
        'voldikss/vim-floaterm',
        config = function()
            require("plugin_setup").setupFloaterm()
        end
    }
    use {
        'ful1e5/onedark.nvim',
        config = function()
            require("onedark").setup{
                dark_sidebar = true,
                highlight_linenumber = true,
                dark_float = true,
                comment_style = "NONE",
                keyword_style = "NONE",
                function_style = "NONE",
                variable_style = "NONE"
            }
        end
    }
end )
