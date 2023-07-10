local HOME = vim.env.HOME .. '/.config/nvim'

vim.o.termguicolors = true
vim.g.mapleader = ','
vim.g.python3_host_prog = HOME .. '/python3/bin/python'

-- bootstrap lazy
--
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
-- FIXME: split plugin_setup to different modules
require 'plugin_setup'.initialize()

-- wgsl
local wgsl_group = vim.api.nvim_create_augroup("wgsl", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.wgsl" },
    group = wgsl_group,
    command = "set ft=wgsl"
})

if (vim.fn.has("nvim-0.10")==1) then
    -- enable inlay hints on lsp attach
    vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
    vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
            if not (args.data and args.data.client_id) then
                return
            end

            local bufnr = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if (client.server_capabilities.inlayHintProvider)
            then
                vim.lsp.inlay_hint(bufnr, true)
            end
        end,
    })
end
