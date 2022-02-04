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
    -- autoformat
    use {
      "jose-elias-alvarez/null-ls.nvim",
      event = "BufRead",
      config = function()
        require "plugin_setup".setupAutoformat()
      end,
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
        'hrsh7th/nvim-cmp',
        requires = { 
            'hrsh7th/cmp-nvim-lsp'
            , 'hrsh7th/cmp-buffer'
            , 'hrsh7th/cmp-path'
            , 'hrsh7th/cmp-cmdline'
            , 'dcampos/nvim-snippy'
            , 'dcampos/cmp-snippy'
            , "lukas-reineke/cmp-rg"
        },
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
        run = ":TSUpdate",
        event = "BufRead",
        cmd = {
          "TSInstall",
          "TSInstallInfo",
          "TSInstallSync",
          "TSUninstall",
          "TSUpdate",
          "TSUpdateSync",
          "TSDisableAll",
          "TSEnableAll",
        },
        config=function()
            require("plugin_setup").setupTS()
        end,
        requires = {
          {
            -- Parenthesis highlighting
            "p00f/nvim-ts-rainbow",
            after = "nvim-treesitter",
          },
          {
            -- Autoclose tags
            "windwp/nvim-ts-autotag",
            after = "nvim-treesitter",
          },
          {
            -- Context based commenting
            "JoosepAlviste/nvim-ts-context-commentstring",
            after = "nvim-treesitter",
          },
        },
    }
    use {
        'voldikss/vim-floaterm',
        config = function()
            require("plugin_setup").setupFloaterm()
        end
    }
    use {
        "themercorp/themer.lua",
        config = function()
            require("themer").setup({
                colorscheme = "doom_one",
                plugins = {
                    treesitter=true,
                    lualine=true,
                    telescope=true,
                    lsp=true,
                    cmp=true
                }
            })
        end
    }
end )
