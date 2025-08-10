return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer", -- source for text in buffer
		"hrsh7th/cmp-path", -- source for file system paths
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
		"hrsh7th/cmp-cmdline",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim", -- vscode like pictograms
	},
	config = function()
		vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE" })

		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			preselect = "item",
			completion = {
				completeopt = "menu,menuone,noinsert",
			},
			formatting = {
				expandable_indicator = true,
				fields = {
					"kind",
					"abbr",
					"menu",
				},
				format = lspkind.cmp_format({
					-- mode = "symbol_text",
					mode = "symbol",
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- menu = function() return math.floor(0.45 * vim.o.columns) end,
						menu = 40, -- leading text (labelDetails)
						abbr = 30, -- actual suggestion item
					},
					ellipsis_char = "...",
					show_labelDetails = true,
					-- The function below will be called before any actual modifications from lspkind
					-- so that you can provide more controls on popup customization
					before = function(entry, vim_item)
						-- Clangd puts circular dot or space before a suggestion item
						-- if header file of the item is not inserted,
						-- which causes misalignment of suggestion items.
						-- Hence, if the first character of a suggestion item
						-- is a letter, number or underscore, put a space before it.
						if string.match(vim_item.abbr, "^[%w]") ~= nil then
							vim_item.abbr = " " .. vim_item.abbr
						end
						return vim_item
					end,
				}),
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
			}),
			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline({
					["<C-j>"] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }) },
					["<C-k>"] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }) },
					["<CR>"] = {
						c = cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						}),
					},
					["<A-.>"] = { c = cmp.mapping.abort() },
				}),
				sources = cmp.config.sources({
					{ name = "buffer" },
				}),
			}),
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-j>"] = { c = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }) },
					["<C-k>"] = { c = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }) },
					["<CR>"] = {
						c = cmp.mapping.confirm({
							behavior = cmp.ConfirmBehavior.Replace,
							select = true,
						}),
					},
					["<A-.>"] = { c = cmp.mapping.abort() },
				}),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			}),
		})
	end,
}
