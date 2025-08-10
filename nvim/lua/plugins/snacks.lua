return {
	"folke/snacks.nvim",
	opts = {
		indent = {
			indent = {
				only_scope = true, -- only show indent guides of the scope
				only_current = true, -- only show indent guides in the current window
			},
		},
		explorer = {},
		picker = {},
		input = {},
	},
	keys = {
		{
			"<leader>e",
			function()
				Snacks.explorer()
			end,
			desc = "File explorer.",
		},
		{
			"<leader><leader>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart find files.",
		},
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Find existing buffers.",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Live grep.",
		},
		{
			"<leader>fo",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Live grep in open buffers.",
		},
		{
			"<leader>fw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Find current word.",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Find symbols.",
		},
		{
			"<leader>fs",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "Find symbols.",
		},
		{
			"<leader>fd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Find diagnostics.",
		},
	},
}
