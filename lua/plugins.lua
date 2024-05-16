return {
    {
        "scrooloose/nerdcommenter",
        config = function()
            -- NERDcommenter
            vim.g.NERDSpaceDelims = 1

            -- Use compact syntax for prettified multi-line comments
            vim.g.NERDCompactSexyComs = 1

            -- Align line-wise comment delimiters flush left instead of following code indentation
            vim.g.NERDDefaultAlign = "left"

            -- Allow commenting and inverting empty lines (useful when commenting a region)
            vim.g.NERDCommentEmptyLines = 1

            -- Enable trimming of trailing whitespace when uncommenting
            vim.g.NERDTrimTrailingWhitespace = 1
        end,
    },
    {
        "kyazdani42/nvim-tree.lua",
        event = "VeryLazy",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                update_cwd = true,
            })

            vim.keymap.set("n", "<leader>n", "<cmd>NvimTreeToggle<CR>")
            vim.keymap.set("n", "<leader>f", "<cmd>NvimTreeFindFile<CR>")
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        cmd = "Oil",
        config = function()
            require("oil").setup {
                default_file_explorer = true,
            }
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            -- lualine should only run config after nightfox has been setup
            "EdenEast/nightfox.nvim",
        },
        config = function()
            require("config_lualine")
        end,
    },
    {
        "editorconfig/editorconfig-vim",
        event = "InsertEnter",
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = { {
            "nvim-lua/plenary.nvim",
            lazy = true,
        } },
        config = require("setup_telescope"),
    },
    {
        "nvim-treesitter/nvim-treesitter",
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
                "nvim-treesitter/nvim-treesitter-textobjects",
            },
            {
                -- show context
                "nvim-treesitter/nvim-treesitter-context",
                config = function()
                    require("treesitter-context").setup({
                        enable = true,
                        max_lines = 8,
                        multiline_threshold = 4,
                    })
                end,
            },
        },
    },
    {
        "EdenEast/nightfox.nvim",
        config = function()
            require("nightfox").setup({
                options = {
                    transparent = false,
                    dim_inactive = true,
                    colorblind = {
                        enable = true,
                        severity = {
                            protan = 0.6,
                        },
                    },
                },
            })
            vim.cmd([[colorscheme terafox]])
        end,
        build = function()
            require("nightfox").setup({
                options = {
                    transparent = true,
                    dim_inactive = true,
                },
            })
            require("nightfox").compile()
        end,
    },
    {
        "airblade/vim-gitgutter",
        event = "VeryLazy",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            require("which-key").setup({
                triggers = "auto",
            })
        end,
    },
    {
        -- better in-buffer search
        "junegunn/vim-slash",
        event = "VeryLazy",
    },
    {
        "gerw/vim-latex-suite",
        ft = "tex",
    },
    {
        "neovim/nvim-lspconfig",
        config = require("setup_lsp"),
        event = "VeryLazy",
        dependencies = {
            -- LSP Support
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "p00f/clangd_extensions.nvim" },
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
            { "nvim-telescope/telescope.nvim" },

            -- Autocompletion
            {
                "hrsh7th/nvim-cmp",
                event = "InsertEnter",
                config = require("setup_cmp"),
                dependencies = {
                    { "hrsh7th/cmp-buffer" },
                    { "hrsh7th/cmp-path" },
                    { "hrsh7th/cmp-nvim-lsp" },
                    -- Snippets
                    { "saadparwaiz1/cmp_luasnip" },
                    {
                        "L3MON4D3/LuaSnip",
                        version = "v2.*",
                    },
                },
            },
        },
    },
    {
        "christoomey/vim-tmux-navigator",
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
        -- autoformat
        "stevearc/conform.nvim",
        event = "VeryLazy",
        opts = {},
        config = require('setup_conform'),
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', },
        opts = {
            signs = false,
            search = {
                command = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                },
                pattern = [[\b(KEYWORDS)]],
            },
        }
    },
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        config = require('setup_snippets')
    },
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory<cr>")
            vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<cr>")
            vim.keymap.set("n", "<leader>dr", "<cmd>DiffviewRefresh<cr>")
            vim.keymap.set("n", "<leader>do", "<cmd>DiffviewOpen<cr>")
        end
    },
    {
        "tpope/vim-dadbod",
        "kristijanhusak/vim-dadbod-completion",
        "kristijanhusak/vim-dadbod-ui",
    }
}
