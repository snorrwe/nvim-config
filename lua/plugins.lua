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
                    transparent = true,
                    dim_inactive = true,
                },
            })
            vim.cmd [[colorscheme duskfox]]
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
        event = { 'BufReadPre', 'BufNewFile' },
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
                ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
            }
            lsp.setup_nvim_cmp {
                mapping = cmp_mappings,
                preselect = cmp.PreselectMode.None,
                formatting = {
                    format = function(_, vim_item)
                        vim_item.menu = nil;
                        local label = vim_item.abbr
                        local truncated_label = vim.fn.strcharpart(label, 0, 100)
                        if truncated_label ~= label then
                            vim_item.abbr = truncated_label .. '..'
                        end
                        return vim_item
                    end,
                },
            }
            lsp.setup()
            local clangd_lsp = lsp.build_options('clangd', {})
            local has_native_hints = vim.fn.has("nvim-0.10") == 1;
            clangd_extensions.setup {
                extensions = {
                    autoSetHints = not has_native_hints,
                },
                server = clangd_lsp,
            }

            local rust_lsp = lsp.build_options('rust_analyzer', {})
            rust_rools.setup {
                server = rust_lsp,
                tools = {
                    inlay_hints = {
                        auto = not has_native_hints
                    }
                }
            }
        end,
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
