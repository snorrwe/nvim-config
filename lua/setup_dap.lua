return function()
	local dap = require("dap")
	local dapui = require("dapui")
	local mason_dap = require("mason-nvim-dap")
	require("nvim-dap-virtual-text").setup()
	mason_dap.setup()
	dapui.setup()

	vim.keymap.set("n", "<leader>dbg", '<cmd>lua require("dapui").open()')
	vim.keymap.set("n", "<F5>", '<cmd>lua require"dap".continue()<CR>')
	vim.keymap.set("n", "<F10>", '<cmd>lua require"dap".step_over()<CR>')
	vim.keymap.set("n", "<F11>", '<cmd>lua require"dap".step_into()<CR>')
	vim.keymap.set("n", "<F9>", '<cmd>lua require"dap".step_out()<CR>')
	vim.keymap.set("n", "<leader>b", '<cmd>lua require"dap".toggle_breakpoint()<CR>')
	vim.keymap.set("n", "<leader>B", '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>')

	dap.listeners.before.attach.dapui_config = dapui.open
	dap.listeners.before.launch.dapui_config = dapui.open
	dap.listeners.before.event_terminated.dapui_config = dapui.close
	dap.listeners.before.event_exited.dapui_config = dapui.close

	dap.adapters.cppdbg = {
		type = "server",
		port = "${port}",
		executable = {
			command = "codelldb",
			args = { "--port", "${port}" },
		},
	}
	dap.configurations.rust = {
		{
			type = "cppdbg",
			request = "launch",
			name = "Launch file",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
		},
	}
	dap.configurations.cpp = {
		{
			name = "Launch file",
			type = "cppdbg",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopAtEntry = true,
		},
		{
			name = "Launch file with args",
			type = "cppdbg",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopAtEntry = true,
			args = function()
				local args = vim.fn.input("Args: ")
				local result = {}
				for arg in string.gmatch(args, "[^%s]+") do
					table.insert(result, arg)
				end
				return result
			end,
		},
	}
end
