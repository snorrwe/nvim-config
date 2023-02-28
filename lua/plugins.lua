return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- manage itself
    use { 'scrooloose/nerdcommenter' }
    use { 'gko/vim-coloresque' }
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons', -- for file icon
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
                'nvim-treesitter/nvim-treesitter-textobjects',
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
            local clangd_extensions = require('clangd_extensions')
            local rust_rools = require('rust-tools')
            lsp.preset('recommended')
            lsp.ensure_installed({
                'rust_analyzer',
                'clangd',
            })
            lsp.set_preferences({
                suggest_lsp_servers = true,
                set_lsp_keymaps = {
                    omit = { '<C-k>', 'gr' },
                }
            })
            -- clangd is set up by clangd_extensions
            -- rust_analyzer is set up by rust-tools
            lsp.skip_server_setup({ 'clangd', 'rust_analyzer' })

            local cmp = require('cmp')
            local cmp_mappings = lsp.defaults.cmp_mappings {
                ['<C-Space>'] = cmp.mapping.complete(),
            }
            lsp.setup_nvim_cmp {
                mapping = cmp_mappings,
                preselect = cmp.PreselectMode.None
            }
            lsp.setup()
            local clangd_lsp = lsp.build_options('clangd', {})
            clangd_extensions.setup { server = clangd_lsp }

            local rust_lsp = lsp.build_options('rust_analyzer', {})
            rust_rools.setup { server = rust_lsp }
        end,
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'p00f/clangd_extensions.nvim' },
            { 'simrat39/rust-tools.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },

            -- Debugging
            { 'nvim-lua/plenary.nvim' },
            { 'mfussenegger/nvim-dap' },
        }
    }
    use {
        'christoomey/vim-tmux-navigator',
    }
    -- Debugger
    use {
        'mfussenegger/nvim-dap',
        config = function()
            local suc, res = pcall(require("plugin_setup").setupDebugging)
            if not suc then
                print("Failed to setup dap: ", res)
            end
        end,
        requires = {
            { "rcarriga/nvim-dap-ui" },
            { 'nvim-telescope/telescope-dap.nvim' },
            { 'theHamsta/nvim-dap-virtual-text' },
        }
    }
end)
