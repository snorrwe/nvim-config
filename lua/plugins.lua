return {
    {
        'scrooloose/nerdcommenter',
        config = function()
            -- NERDcommenter
            vim.g.NERDSpaceDelims = 1

            -- Use compact syntax for prettified multi-line comments
            vim.g.NERDCompactSexyComs = 1

            -- Align line-wise comment delimiters flush left instead of following code indentation
            vim.g.NERDDefaultAlign = 'left'

            -- Allow commenting and inverting empty lines (useful when commenting a region)
            vim.g.NERDCommentEmptyLines = 1

            -- Enable trimming of trailing whitespace when uncommenting
            vim.g.NERDTrimTrailingWhitespace = 1
        end
    },
    {
        'kyazdani42/nvim-tree.lua',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("plugin_setup").setupTree()
        end
    },
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup()
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("config_lualine")
        end
    },
    {
        'editorconfig/editorconfig-vim',
        event = "BufRead",
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = { {
            'nvim-lua/plenary.nvim',
            lazy = true,
        } },
        config = function()
            require("setup_telescope")()
        end
    },
    {
        'akinsho/bufferline.nvim',
        event = "BufRead",
        branch = 'main',
        config = function()
            require("plugin_setup").setupBufferline()
        end
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ":TSUpdate",
        event = { "BufRead", "BufEnter" },
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
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            {
                -- show context
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                    require 'treesitter-context'.setup {
                        enable = true
                    }
                end,
            },
        },
    },
    {
        'voldikss/vim-floaterm',
        config = function()
            require("plugin_setup").setupFloaterm()
        end
    },
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require('nightfox').setup({
                options = {
                    transparent = false,
                    dim_inactive = true,
                    colorblind = {
                        enable = true,
                        severity = {
                            protan = 0.6
                        }
                    }
                },
            })
            vim.cmd [[colorscheme terafox]]
        end,
        build = function()
            require('nightfox').setup({
                options = {
                    transparent = true,
                    dim_inactive = true,
                },
            })
            require('nightfox').compile()
        end
    },
    { 'airblade/vim-gitgutter' },
    {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {
                triggers = "auto",
            }
        end
    },
    {
        "junegunn/vim-slash",
        event = "BufEnter",
    },
    {
        "gerw/vim-latex-suite",
        ft = "tex"
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        event = { 'BufEnter', 'BufReadPre', 'BufNewFile' },
        config = require("setup_lsp"),
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'p00f/clangd_extensions.nvim' },
            { 'simrat39/rust-tools.nvim' },
            {
                "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
                config = function()
                    require("lsp_lines").setup()
                end,
            },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },

            -- formatting
            {
                "jose-elias-alvarez/null-ls.nvim",
                event = "BufRead",
                config = function()
                    require "plugin_setup".setupAutoformat()
                end,
            },
        }
    },
    {
        'christoomey/vim-tmux-navigator',
    },
    -- Debugger
    {
        'mfussenegger/nvim-dap',
        config = function()
            local suc, res = pcall(require("setup_debugging"))
            if not suc then
                print("Failed to setup dap: ", res)
            end
        end,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            'nvim-telescope/telescope-dap.nvim',
            'theHamsta/nvim-dap-virtual-text',
        }
    },
}
