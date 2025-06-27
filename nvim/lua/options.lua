local opt = vim.opt

-- Line number.
opt.number = true
opt.relativenumber = true
opt.numberwidth = 2

opt.signcolumn = "yes"

-- Only status line in the last window.
opt.laststatus = 3

-- Do not display mode on the last line.
opt.showmode = false

opt.clipboard = "unnamedplus"

-- Highlight cursor line.
opt.cursorline = true

-- Do not show line and column number of the cursor position.
opt.ruler = false

-- Indent.
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

-- Use space to fill empty lines at the end of a buffer (eob).
opt.fillchars = { eob = " " }

opt.mouse = "a"

opt.splitbelow = true
opt.splitright = true

-- Time in milliseconds to wait for a mapped sequence to complete.
opt.timeoutlen = 1000

-- If this many milliseconds nothing is typed the swap file will be written to disk.
opt.updatetime = 250

-- Save undo history to an undo file when writing a buffer to a file,
-- and restores undo history from the same file on buffer read.
opt.undofile = true

-- Always display the line with tab page labels.
opt.showtabline = 2

opt.termguicolors = true

opt.guicursor = "n-v-sm:block,i-ci-ve-c:ver25,r-cr-o:hor20"

local nvim_ver_str = tostring(vim.version())
local is_ver_ge_0_11 = nvim_ver_str >= "0.11.0" and true or false

if is_ver_ge_0_11 then
	opt.guicursor = "n-v-sm:block,i-ci-ve-c-t:ver25,r-cr-o:hor20"
end

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 8

opt.ignorecase = true

opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
