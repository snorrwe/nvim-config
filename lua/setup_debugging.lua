return function()
    local dap, dapui = require("dap"), require("dapui")

    dapui.setup()
    require("nvim-dap-virtual-text").setup()
    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end
    vim.keymap.set('n', '<F5>', '<cmd>lua require"dap".continue()<CR>');
    vim.keymap.set('n', '<F10>', '<cmd>lua require"dap".step_over()<CR>');
    vim.keymap.set('n', '<F11>', '<cmd>lua require"dap".step_into()<CR>');
    vim.keymap.set('n', '<F9>', '<cmd>lua require"dap".step_out()<CR>');
    vim.keymap.set('n', '<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<CR>');
    vim.keymap.set('n', '<leader>B', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>');

    dap.adapters.cppdbg = {
        type = 'server',
        port = '${port}',
        executable = {
            command = 'codelldb',
            args = { '--port', '${port}' },
        },
    }

    dap.configurations.cpp = {
        {
            name = 'Launch file',
            type = 'cppdbg',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
        },
        {
            name = 'Launch file with args',
            type = 'cppdbg',
            request = 'launch',
            program = function()
                return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = true,
            args = function()
                local args = vim.fn.input('Args: ')
                local result = {}
                for arg in string.gmatch(args, "[^%s]+") do
                    table.insert(result, arg)
                end
                return result
            end
        },
        {
            name = 'Launch lpc',
            type = 'cppdbg',
            request = 'launch',
            program = function()
                return vim.fn.getcwd() .. '/build/pc_postprocess'
            end,
            cwd = '${workspaceFolder}',
            stopAtEntry = false,
            args =
                function()
                    local result = {
                        "-p",
                        "./data/191/processing/database/",
                        "-m",
                        "./data/191/outputs/segmentation_masks/",
                        "--images",
                        "./data/191/raw/images/",
                        "-o",
                        "result",
                    }
                    return result
                end
        },
    }
end
