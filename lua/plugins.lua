return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- manage itself
    use { 'scrooloose/nerdcommenter' }
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
    use { 'kyazdani42/nvim-web-devicons' }
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config = function()
            require("config_lualine")
        end
    }
    use { 'editorconfig/editorconfig-vim' }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function()
            require("plugin_setup").setupTelescope()
        end
    }
    use {
        'akinsho/bufferline.nvim',
        branch = 'main',
        config = function()
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
        config = function()
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
            {
                -- show context
                "nvim-treesitter/nvim-treesitter-context",
                after = "nvim-treesitter",
                config = function()
                    require 'treesitter-context'.setup {
                        enable = true
                    }
                end,
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
        "EdenEast/nightfox.nvim",
        config = function()
            require('nightfox').setup({
                options = {
                    transparent = true,
                    dim_inactive = true,
                },
            })
            vim.cmd [[colorscheme duskfox]]
        end,
        run = function()
            require('nightfox').setup({
                options = {
                    transparent = true,
                    dim_inactive = true,
                },
            })
            require('nightfox').compile()
        end
    }
    use { 'airblade/vim-gitgutter' }
    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                triggers = "auto",
            }
        end
    }
    use {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    }
    use {
        "junegunn/vim-slash",
    }
    use {
        "gerw/vim-latex-suite"
    }
    use {
        'VonHeikemen/lsp-zero.nvim',
        config = function()
            local lsp = require('lsp-zero')
            lsp.preset('recommended')
            lsp.ensure_installed({
                'rust_analyzer',
                'sumneko_lua',
                'clangd',
            })
            lsp.set_preferences({
                suggest_lsp_servers = true
            })
            local cmp = require('cmp')
            local cmp_mappings = lsp.defaults.cmp_mappings {
                ['<C-Space>'] = cmp.mapping.complete(),
            }
            lsp.setup_nvim_cmp {
                mapping = cmp_mappings
            }
            lsp.setup()
        end,
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
        }
    }
    use {
        'christoomey/vim-tmux-navigator',
    }
end)
