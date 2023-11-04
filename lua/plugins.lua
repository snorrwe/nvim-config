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
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require 'nvim-tree'.setup {
                update_cwd = true,
            }

            vim.keymap.set('n', '<leader>n', '<cmd>NvimTreeToggle<CR>')
            vim.keymap.set('n', '<leader>f', '<cmd>NvimTreeFindFile<CR>')
        end
    },
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = 'Oil',
        config = function()
            require("oil").setup()
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            -- lualine should only run config after nightfox has been setup
            'EdenEast/nightfox.nvim',
        },
        config = function()
            require("config_lualine")
        end
    },
    {
        'editorconfig/editorconfig-vim',
        event = "InsertEnter",
    },
    {
        'nvim-telescope/telescope.nvim',
        event = "VeryLazy",
        dependencies = { {
            'nvim-lua/plenary.nvim',
            lazy = true,
        } },
        config = require("setup_telescope")
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
        config = require("setup_treesitter"),
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-textobjects',
            },
            {
                -- show context
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                    require 'treesitter-context'.setup {
                        enable = true,
                        max_lines = 8,
                        multiline_threshold = 4,
                    }
                end,
            },
        },
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
    {
        'airblade/vim-gitgutter',
        event = "VeryLazy",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup {
                triggers = "auto",
            }
        end
    },
    {
        "junegunn/vim-slash",
        event = "VeryLazy",
    },
    {
        "gerw/vim-latex-suite",
        ft = "tex"
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        event = "VeryLazy",
        config = require("setup_lsp"),
        branch = 'v3.x',
        lazy = true,
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'p00f/clangd_extensions.nvim' },
            {
                "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
                config = function()
                    require("lsp_lines").setup()
                    -- Disable virtual_text since it's redundant due to lsp_lines.
                    vim.diagnostic.config({
                        virtual_text = false,
                    })
                end,
            },

            -- Autocompletion
            {
                'hrsh7th/nvim-cmp',
                dependencies = {
                    { 'hrsh7th/cmp-buffer' },
                    { 'hrsh7th/cmp-path' },
                    { 'saadparwaiz1/cmp_luasnip' },
                    { 'hrsh7th/cmp-nvim-lsp' },
                    -- Snippets
                    {
                        'L3MON4D3/LuaSnip',
                        version = "v2.*"
                    },
                }
            },
        }
    },
    {
        'christoomey/vim-tmux-navigator',
    },
    -- Debugger
    {
        'mfussenegger/nvim-dap',
        event = "VeryLazy",
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
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            {
                "S",
                mode = { "n", "x", "o" },
                function() require("flash").treesitter() end,
                desc =
                "Flash Treesitter"
            },
            {
                "r",
                mode = "o",
                function() require("flash").remote() end,
                desc =
                "Remote Flash"
            },
            {
                "R",
                mode = { "o", "x" },
                function() require("flash").treesitter_search() end,
                desc =
                "Treesitter Search"
            },
        },
    },
    {
        'stevearc/conform.nvim',
        event = "VeryLazy",
        opts = {},
        config = function()
            local conform = require("conform");
            -- Use a sub-list to run only the first available formatter
            local prettier = { { "prettierd", "prettier" } }
            conform.setup({
                formatters_by_ft = {
                    -- Specify a list of formatters to run
                    lua = { "stylua" },
                    python = { "black" },
                    rust = { "rustfmt" },
                    go = { "gofmt" },
                    javascript = prettier,
                    typescript = prettier,
                    json = prettier,
                    html = prettier,
                    css = prettier,
                },
            })
            local formatcmd = function()
                conform.format({ lsp_fallback = 'always', timeout_ms = 500 })
            end
            vim.keymap.set({ 'n', 'v' }, '<leader>a', formatcmd)
        end
    }
}
