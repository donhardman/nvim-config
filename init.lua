local vim = vim

local nnn = require("nnn")
nnn.setup({
	explorer = {
		cmd = "nnn",
    width = 24,        -- width of the vertical split
    side = "topleft",  -- or "botright", location of the explorer window
    session = "shared",      -- or "global" / "local" / "shared"
    tabs = false,       -- separate nnn instance per tab
    fullscreen = false, -- whether to fullscreen explorer window when current tab is empty
  },
	picker = {
		cmd = "nnn -Po",
		style = { border = "rounded" },
		session = "shared",
		tabs = false,
	},
	auto_open = {
		setup = "explorer", 
		picker = "explorer",
	},
	replace_netrw = "picker",
	mappings = {
		{ "l", nnn.nvim_open_file },
	},
	windownav = {
    left = "<C-h>",
    right = "<C-l>",
    next = "<C-w>w",
    prev = "<C-W>W",
  },
})

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('ufo').setup()

require('nvim-highlight-colors').setup({})
-- This code executes on server in case of remote UI open
-- and let us to keep server runing even when we close the nvim
vim.keymap.set('n', '<leader>q', function()
	for _, ui in pairs(vim.api.nvim_list_uis()) do
		if ui.chan and not ui.stdout_tty then
			vim.fn.chanclose(ui.chan)
		end
	end
end, { noremap = true })

require('spectre').setup({
	default = {
		replace = {
			cmd = "oxi"
		}
	},
	is_insert_mode = true
})
