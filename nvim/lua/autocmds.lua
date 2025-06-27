local autocmds = vim.api.nvim_create_autocmd
local auto_group_reshape_cursor = vim.api.nvim_create_augroup("ReshapeCursor", { clear = true })
local auto_group_newline_comment = vim.api.nvim_create_augroup("NewlineComment", { clear = true })

autocmds("VimLeave", {
	pattern = "*",
	command = "set guicursor=a:ver1",
	group = auto_group_reshape_cursor,
	desc = "Reshape cursor when exiting vim.",
})

autocmds("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
	group = auto_group_newline_comment,
	desc = "Do not comment newline when last line is commented.",
})
