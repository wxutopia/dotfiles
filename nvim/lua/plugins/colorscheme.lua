return {
	"navarasu/onedark.nvim",
	priority = 1000,
	config = function()
		require("onedark").setup({
			style = "dark",
		})
		require("onedark").load()
	end,
}
