local map = vim.keymap.set

map("n", "<leader>h", "<C-w>h", { desc = "Switch window left." })
map("n", "<leader>l", "<C-w>l", { desc = "Switch window right." })
map("n", "<leader>j", "<C-w>j", { desc = "Switch window down." })
map("n", "<leader>k", "<C-w>k", { desc = "Switch window up." })
map("n", "<leader>u", "<C-w>c", { desc = "Close split." })

map("n", "<leader>[", "<cmd>split<CR>", { desc = "Split window horizontally." })
map("n", "<leader>]", "<cmd>vsplit<CR>", { desc = "Split window vertically." })

map("n", "<Esc>", "<cmd>noh<CR>", { desc = "General clear highlights." })

map("n", "j", "gj", { desc = "Down a visual line." })
map("n", "k", "gk", { desc = "Up a visual line." })

map({ "n", "v", "o" }, "H", "g^", { desc = "To begin of line." })
map({ "n", "v", "o" }, "L", "g$", { desc = "To end of line." })

map("n", "<leader>s", "<cmd>wa<CR>", { desc = "Save all files." })
map({ "n", "i" }, "<C-s>", "<cmd>wa<CR>", { desc = "Save all files." })
map("n", "<leader>q", "<cmd>qa<CR>", { desc = "Quit vim." })

map("n", "<leader>;", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer." })
map("n", "<leader>'", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer." })
map("n", "<leader>b", "<cmd>BufferLinePick<CR>", { desc = "Pick buffer." })
map("n", "<leader>w", function()
	Snacks.bufdelete()
end, { desc = "Close current buffer." })

map("t", "<C-j>", "<Down>", { desc = "Down in terminal." })
map("t", "<C-k>", "<Up>", { desc = "Up in terminal." })
