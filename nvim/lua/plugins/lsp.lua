return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		{
			"folke/lazydev.nvim",
			ft = "lua", -- only load on lua files
			opts = {
				library = {
					-- Load luvit types when the `vim.uv` word is found
					{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				},
			},
		},
		{ "mason-org/mason-lspconfig.nvim" },
	},
	config = function()
		-- Add cmp_nvim_lsp capabilities settings to lspconfig.
		-- This should be executed before you configure any language server
		-- local lspconfig_defaults = require("lspconfig").util.default_config
		-- lspconfig_defaults.capabilities = vim.tbl_deep_extend(
		-- 	"force",
		-- 	lspconfig_defaults.capabilities,
		-- 	require("cmp_nvim_lsp").default_capabilities()
		-- )

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- This is where you enable features that only work
		-- if there is a language server active in the file
		vim.api.nvim_create_autocmd("LspAttach", {
			desc = "LSP actions",
			callback = function(event)
				local opts = { buffer = event.buf }

				vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
				vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
				vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
				vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
				vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
				vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
				vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
				vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
				vim.keymap.set("n", "gf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
				vim.keymap.set("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
			end,
		})

		-- Disable server capabilities of hover provided by ruff lsp.
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client == nil then
					return
				end
				if client.name == "ruff" then
					client.server_capabilities.hoverProvider = false
				end
			end,
			desc = "LSP: Disable hover capability from Ruff",
		})

		local x = vim.diagnostic.severity
		vim.diagnostic.config({
			virtual_text = { prefix = "" },
			signs = {
				text = {
					-- [x.ERROR] = " ",
					-- [x.WARN] = " ",
					-- [x.HINT] = "󰠠 ",
					-- [x.INFO] = " ",
					[x.ERROR] = " ",
					[x.WARN] = " ",
					[x.HINT] = " ",
					[x.INFO] = " ",
				},
			},
			underline = true,

			-- do the following for lsp diagnostics:
			-- 1. disable prefix (e.g. number)
			-- 2. sort from the highest severity
			-- 3. include the source where the warn/error come from
			float = { prefix = "", header = "", severity_sort = true, source = true },
		})

		local is_win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
		local is_mac = vim.fn.has("mac") == 1
		local is_linux = vim.fn.has("linux") == 1
		local query_driver = ""
		if is_linux then
			query_driver = "--query-driver=/usr/bin/gcc,/usr/bin/g++"
		end
		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				-- Path to find compile_commands.json.
				"--compile-commands-dir=build",
				query_driver,
				-- All scopes completion.
				"--all-scopes-completion",
				-- Completion style where "bundled" means similar completion items
				-- (e.g. functiono overloads) are combined
				"--completion-style=bundled",
				-- No function parameter placeholders for function completion.
				"--function-arg-placeholders=0",
				-- Allow inserting header files.
				"--header-insertion=iwyu",
				-- Analyze files in the background.
				"--background-index",
				-- Enable clang tidy for static check.
				"--clang-tidy",
				-- Read user and project configuration from YAML file.
				"--enable-config",
				-- Number of async workers used by clangd.
				"-j=12",
				-- The location of PCH (PreCompiled header, used for accelerating compilation) files.
				-- Available values are disk and memory.
				"--pch-storage=disk",
				-- More detailed logs.
				"--log=verbose",
				-- Prettier output json file.
				"--pretty",
				"--fallback-style=Google",
			},
			root_markers = {
				"build",
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac", -- AutoTools
				".git",
			},
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim", "require", "Snacks" },
					},
				},
			},
		})

		vim.lsp.config("pylsp", {
			settings = {
				pylsp = {
					plugins = {
						-- Disable linting.
						-- Use linting of Ruff.
						pycodestyle = { enabled = false },
						pyflakes = { enabled = false },
					},
				},
			},
		})

		vim.lsp.config("ruff", {
			init_options = {
				settings = {
					logLevel = "debug",
				},
			},
			capabilities = {
				general = {
					positionEncodings = { "utf-16" },
				},
			},
		})
	end,
}
