return {
	{
		"mason-org/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = { "mason-org/mason.nvim" },
		opts = {
			-- list of lsp for mason to install
			ensure_installed = {
				"lua_ls",
				"clangd",
				"ruff",
				"pylsp",
				"cmake",
			},
		},
	},
}
