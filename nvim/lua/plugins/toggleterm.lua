return {
	"akinsho/toggleterm.nvim",
	lazy = true,
	version = "*",
	config = function()
		local terminal_shell = vim.o.shell
		local is_win = vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1
		if is_win and vim.fn.executable("pwsh") then
			terminal_shell = "pwsh"
		end
		require("toggleterm").setup({
			open_mapping = [[<A-i>]],
			shading_factor = 2,
			direction = "float",
			shell = terminal_shell,
			float_opts = {
				border = "curved",
				width = function()
					return vim.fn.round(vim.o.columns * 0.75)
				end,
				height = function()
					return vim.fn.round(vim.o.lines * 0.75)
				end,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})
	end,
}
