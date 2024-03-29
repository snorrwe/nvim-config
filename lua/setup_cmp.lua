return function()
	local cmp = require("cmp")
	cmp.setup({
		mapping = cmp.mapping.preset.insert({
			["<C-Space>"] = cmp.mapping.complete(),
			["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
		}),
		preselect = cmp.PreselectMode.Item,
		formatting = {
			format = function(_, vim_item)
				vim_item.menu = nil
				local label = vim_item.abbr
				local truncated_label = vim.fn.strcharpart(label, 0, 100)
				if truncated_label ~= label then
					vim_item.abbr = truncated_label .. ".."
				end
				return vim_item
			end,
		},
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "path" },
			{ name = "buffer" },
			{ name = "luasnip" },
		},
	})
end
