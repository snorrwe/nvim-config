return function()
	require("telescope").setup({
		defaults = {
			vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
			},
			file_ignore_patterns = {},
			mappings = {
				n = {
					["K"] = false,
					["<C-k>"] = false,
					["ga"] = false,
				},
			},
		},
	})
	vim.keymap.set("n", "<space>f", "<cmd>lua require('telescope.builtin').find_files()<cr>")
	vim.keymap.set("n", "<space>g", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
	vim.keymap.set("n", "<space>G", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>")
	vim.keymap.set("n", "<space>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")
	vim.keymap.set("n", "<space>t", "<cmd>lua require('telescope.builtin').help_tags()<cr>")
	vim.keymap.set("n", "<space>l", "<cmd>lua require('telescope.builtin').diagnostics()<cr>")
	vim.keymap.set("n", "<space><space>", "<cmd>lua require('telescope.builtin').resume()<cr>")
end
