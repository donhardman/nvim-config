local vim = vim

require('lualine').setup({
	options = {
    icons_enabled = true,
    theme = 'codedark',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = true,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
			'branch',
			{
				'diff',
				colored = true, -- Displays a colored diff status if set to true
				diff_color = {
					-- Same color values as the general color option can be used here.
					added    = 'GitGutterAdd',    -- Changes the diff's added color
					modified = 'GitGutterChange', -- Changes the diff's modified color
					removed  = 'GitGutterDelete', -- Changes the diff's removed color you
				},
				symbols = {added = '+', modified = '~', removed = '-'}, -- Changes the symbols used by the diff.
				source = nil, -- A function that works as a data source for diff.
				-- It must return a table as such:
				--   { added = add_count, modified = modified_count, removed = removed_count }
				-- or nil on failure. count <= 0 won't be displayed.
			}
		},
		lualine_c = {'filename', 'searchcount'},
    lualine_x = {
			{
				'diagnostics',

				-- Table of diagnostic sources, available sources are:
				--   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
				-- or a function that returns a table as such:
				--   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
				sources = { 'nvim_diagnostic', 'coc' },

				-- Displays diagnostics for the defined severity types
				sections = { 'error', 'warn', 'info', 'hint' },

				diagnostics_color = {
					-- Same values as the general color option can be used here.
					error = 'DiagnosticError', -- Changes diagnostics' error color.
					warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
					info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
					hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
				},
				symbols = {error = 'E', warn = 'W', info = 'I', hint = 'H'},
				colored = true,           -- Displays diagnostics status in color if set to true.
				update_in_insert = false, -- Update diagnostics in insert mode.
				always_visible = true,   -- Show diagnostics even if there are none.
			},
			'encoding',
			'fileformat',
			'filetype'
		},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})

local nnn = require("nnn")
nnn.setup({
	explorer = {
		cmd = "nnn -G -o",
    width = 24,        -- width of the vertical split
    side = "topleft",  -- or "botright", location of the explorer window
    session = "shared",      -- or "global" / "local" / "shared"
    tabs = false,       -- separate nnn instance per tab
    fullscreen = false, -- whether to fullscreen explorer window when current tab is empty
  },
	picker = {
		cmd = "nnn -Po",
		style = { border = "rounded" },
		session = "shared", -- "global, "local" or "shared"
		tabs = false,
	},
	auto_open = {
		setup = nil
	},
	replace_netrw = "picker",
	mappings = {
		--{ "l", nnn.nvim_open_file },
	},
	windownav = {
    left = "<C-h>",
    right = "<C-l>",
    next = "<C-w>w",
    prev = "<C-W>W",
  },
	auto_close = true,
	quitcd = nil,
	offset = false
})

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local ufo = require("ufo")
vim.keymap.set('n', 'zR', ufo.openAllFolds)
vim.keymap.set('n', 'zM', ufo.closeAllFolds)

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

require('codesnap').setup({
	mac_window_bar = true,
	-- title = "CodeSnap.nvim",
	code_font_family = "Fira Code Nerd Mono",
	watermark_font_family = "Pacifico",
	watermark = "donhardman.com",
	bg_theme = "default",
	breadcrumbs_separator = "/",
	has_breadcrumbs = false,
})

require('ibl').setup({
	indent = {
		char = '▏',
	},
	scope = {
		enabled = true,
		show_exact_scope = false,
		show_start = true,
		show_end = true,
	},
})
