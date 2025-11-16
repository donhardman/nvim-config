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
				sources = { 'nvim_diagnostic', 'nvim_lsp' },

				-- Displays diagnostics for the defined severity types
				sections = { 'error', 'warn', 'info', 'hint' },

				diagnostics_color = {
					-- Same values as the general color option can be used here.
					error = 'DiagnosticError', -- Changes diagnostics' error color.
					warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
					info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
					hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
				},
				symbols = {error = ' ', warn = ' ', info = ' ', hint = '󰘥 '},
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

--local nnn = require("nnn")
--nnn.setup({
	--explorer = {
		--cmd = "NO_COLOR=1 nnn -G -o",
		--width = 24,        -- width of the vertical split
		--side = "topleft",  -- or "botright", location of the explorer window
		--session = "shared",      -- or "global" / "local" / "shared"
		--tabs = false,       -- separate nnn instance per tab
		--fullscreen = false, -- whether to fullscreen explorer window when current tab is empty
	--},
	--picker = {
		--cmd = "nnn -Po",
		--style = { border = "rounded" },
		--session = "shared", -- "global, "local" or "shared"
		--tabs = false,
	--},
	--auto_open = {
		--setup = nil
	--},
	--replace_netrw = nil,
	--mappings = {
		----{ "l", nnn.nvim_open_file },
	--},
	--windownav = {
		--left = "<C-h>",
		--right = "<C-l>",
		--next = "<C-w>w",
		--prev = "<C-W>W",
	--},
	--auto_close = true,
	--quitcd = nil,
	--offset = false
--})

require('nvim-highlight-colors').setup({})
-- This code executes on server in case of remote UI open
-- and let us to keep server running even when we close the nvim
vim.keymap.set('n', '<leader>q', function()
	for _, ui in pairs(vim.api.nvim_list_uis()) do
		if ui.chan and not ui.stdout_tty then
			vim.fn.chanclose(ui.chan)
		end
	end
end, { noremap = true })

require('spectre').setup({
	default = {
		find = {
			cmd = "rg",
		},
		replace = {
			cmd = "oxi"
		}
	},
	color_devicons = true,
	is_insert_mode = true,
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
		injected_languages = true,
	},
})

require('auto-save').setup({
	enabled = true,
	trigger_events = {"CursorHold", "CursorHoldI", "FocusLost", "InsertLeave"},
	debounce_delay = 1000,
})

require('neogen').setup()

require('nvim-treesitter.configs').setup({
	ensure_installed = {
		'php', 'phpdoc', 'rust', 'c', 'cpp', 'css',
		'scss', 'go', 'vim', 'lua', 'json', 'tsx',
		'javascript', 'typescript', 'bash', 'regex',
		'html', 'python', 'toml', 'yaml', 'sql',
		'markdown', 'make', 'perl', 'graphql', 'gitcommit',
		'gitignore', 'diff', 'dart', 'csv', 'tmux', 'xml',
		'swift', 'scala', 'elixir', 'solidity', 'proto', 'svelte',
	},
	indent = {
		enable = true,
	},
	highlight = {
		enable = true,
	},
	autotag = {
		enable = true,
		filetypes = {
      'html', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'svelte', 'vue', 'tsx', 'jsx', 'rescript',
      'css', 'lua', 'xml', 'php', 'markdown'
    },
  },
})
require('treesitter-context').setup{
	enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
	max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
	min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
	line_numbers = true,
	multiline_threshold = 20, -- Maximum number of lines to show for a single context
	trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
	mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
	-- Separator between context and content. Should be a single character string, like '-'.
	-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
	separator = nil,
	zindex = 20, -- The Z-index of the context window
	on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

require('outline').setup({
	outline_window = {
		width = 20,
		position = "left",
		show_cursorline = true,
		hide_cursor = false,
	},
})

require('assist').setup()

require("supermaven-nvim").setup({
	-- keymaps = {
	-- 	accept_suggestion = "<C-e>",
	-- 	clear_suggestion = "<C-]>",
	-- },
	-- ignore_filetypes = { cpp = true },
	-- color = {
	-- 	suggestion_color = "#4e5a5f",
	-- 	cterm = 244,
	-- },
	disable_keymaps = true,
	disable_inline_completion = true,
})

local completionDelay = 150
local timer = nil
local cmp = require("cmp")

function _G.setAutoCompleteDelay(delay)
	completionDelay = delay
end

function _G.getAutoCompleteDelay()
	return completionDelay
end

vim.api.nvim_create_autocmd({ "TextChangedI", "CmdlineChanged" }, {
	pattern = "*",
	callback = function()
		if timer then
			vim.loop.timer_stop(timer)
			timer = nil
		end

		timer = vim.loop.new_timer()
		timer:start(
			_G.getAutoCompleteDelay(),
			0,
			vim.schedule_wrap(function()
				cmp.complete({ reason = cmp.ContextReason.Auto })
			end)
		)
	end,
})
require('snippet').register_cmp_source()
cmp.setup({
	completion = {
		autocomplete = false
	},
	snippet = {
		expand = function(args)
			vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
		end,
	},
	window = {
		-- completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace })
			else
				fallback()
			end
		end),
		--['<CR>'] = cmp.mapping.confirm({ select = true }),
		-- Remap C-e when we have cmp visible to close it before we execute supermaven completion
		-- ['<C-e>'] = cmp.mapping(function(fallback)
		-- 	if cmp.visible() then
		-- 		cmp.close()
		-- 	end
		-- 	fallback()
		-- end, { 'i', 's' }),
		['<Tab>'] = cmp.mapping(function(fallback)
			vim.schedule(function()
				if cmp.visible() then
					cmp.select_next_item()
				elseif vim.fn.call(vim.fn['vsnip#jumpable'], { 1 }) == 1 then
					vim.fn.call(vim.fn['vsnip#jump'], { 1 })
				else
					fallback()
				end
			end)
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			vim.schedule(function()
				if cmp.visible() then
					cmp.select_prev_item()
				elseif vim.snippet.active({ direction = -1 }) then
					vim.snippet.jump(-1)
				else
					fallback()
				end
			end)
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources(
		{
			{ name = 'supermaven' },
			{ name = 'nvim_lsp' },
			{ name = 'snp' },
		}, {
			{ name = 'buffer' },
		}
	),
	experimental = {
		ghost_text = {
			hl_group = 'CmpGhostText'
		},
	},
	view = {
		entries = {
			native = true,
		},
	},
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources(
		{
			{ name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
		}, {
			{ name = 'buffer' },
		}
	)
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources(
		{
			{ name = 'path' }
		}, {
			{ name = 'cmdline' }
		}
	),
	matching = { disallow_symbol_nonprefix_matching = false }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig').intelephense.setup({
	capabilities = capabilities,
	cmd = {"intelephense", "--stdio"},
	filetypes = {"php"},
	init_options = {
		storagePath = "/tmp/intelephense"
	},
	settings = {
		intelephense = {
			environment = {
				includePaths = {
					"app/vendor/**",
					"vendor/**"
				},
				phpVersion = "8.4.4"
			},
			enable = true,
			completion = {
				maxItems = 4,
				insertUseDeclaration = true,
				triggerParameterHints = true
			},
			telemetry = {
				enabled = false
			},
			phpdoc = {
				useFullyQualifiedNames = false,
				textFormat = "text"
			},
			client = {
				disableInlayHint = false
			},
			inlineParameters = {
				showDollarSign = false
			},
			stubs = {
				"aerospike",
				"amqp",
				"apache",
				"apcu",
				"ast",
				"bcmath",
				"blackfire",
				"bz2",
				"calendar",
				"cassandra",
				"com_dotnet",
				"Core",
				"couchbase",
				"crypto",
				"ctype",
				"cubrid",
				"curl",
				"date",
				"dba",
				"decimal",
				"dio",
				"dom",
				"ds",
				"simdjson",
				"trader",
				"eio",
				"elastic_apm",
				"enchant",
				"Ev",
				"event",
				"exif",
				"expect",
				"fann",
				"FFI",
				"ffmpeg",
				"fileinfo",
				"filter",
				"fpm",
				"ftp",
				"gd",
				"gearman",
				"geoip",
				"geos",
				"gettext",
				"gmagick",
				"gmp",
				"gnupg",
				"grpc",
				"hash",
				"http",
				"ibm_db2",
				"iconv",
				"igbinary",
				"imagick",
				"imap",
				"inotify",
				"interbase",
				"intl",
				"json",
				"judy",
				"ldap",
				"leveldb",
				"libevent",
				"libsodium",
				"libvirt-php",
				"libxml",
				"lua",
				"LuaSandbox",
				"lzf",
				"mailparse",
				"mapscript",
				"mbstring",
				"mcrypt",
				"memcache",
				"memcached",
				"meminfo",
				"meta",
				"ming",
				"mongo",
				"mongodb",
				"mosquitto-php",
				"mqseries",
				"msgpack",
				"mssql",
				"mysql",
				"mysql_xdevapi",
				"mysqli",
				"ncurses",
				"newrelic",
				"oauth",
				"oci8",
				"odbc",
				"openssl",
				"parallel",
				"Parle",
				"pcntl",
				"pcov",
				"pcre",
				"pdflib",
				"PDO",
				"pdo_ibm",
				"pdo_mysql",
				"pdo_pgsql",
				"pdo_sqlite",
				"pgsql",
				"Phar",
				"phpdbg",
				"posix",
				"pq",
				"pspell",
				"pthreads",
				"radius",
				"random",
				"rar",
				"rdkafka",
				"readline",
				"recode",
				"redis",
				"Reflection",
				"regex",
				"rpminfo",
				"rrd",
				"SaxonC",
				"session",
				"shmop",
				"simple_kafka_client",
				"SimpleXML",
				"snappy",
				"snmp",
				"soap",
				"sockets",
				"sodium",
				"solr",
				"SPL",
				"SplType",
				"SQLite",
				"sqlite3",
				"sqlsrv",
				"ssh2",
				"standard",
				"stats",
				"stomp",
				"suhosin",
				"superglobals",
				"svm",
				"svn",
				"swoole",
				"sybase",
				"sync",
				"sysvmsg",
				"sysvsem",
				"sysvshm",
				"tidy",
				"tokenizer",
				"uopz",
				"uploadprogress",
				"uuid",
				"uv",
				"v8js",
				"wddx",
				"win32service",
				"winbinder",
				"wincache",
				"wordpress",
				"xcache",
				"xdebug",
				"xdiff",
				"xhprof",
				"xlswriter",
				"xml",
				"xmlreader",
				"xmlrpc",
				"xmlwriter",
				"xsl",
				"xxtea",
				"yaf",
				"yaml",
				"yar",
				"zend",
				"Zend OPcache",
				"ZendCache",
				"ZendDebugger",
				"ZendUtils",
				"zip",
				"zlib",
				"zmq",
				"zookeeper",
				"zstd"
			}
		}
	}
})

require('lspconfig').rust_analyzer.setup({
	capabilities = capabilities
})

require('lspconfig').pyright.setup({
	capabilities = capabilities
})

require('lspconfig').gopls.setup({
	capabilities = capabilities
})


require('lspconfig').bashls.setup({
	capabilities = capabilities
})

require('lspconfig').lua_ls.setup({
	capabilities = capabilities,
	on_init = function(client)
		local path = client.workspace_folders[1].name
		if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
			return
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				-- Tell the language server which version of Lua you're using
				-- (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT'
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
					-- Depending on the usage, you might want to add additional paths here.
					-- "${3rd}/luv/library"
					-- "${3rd}/busted/library",
				}
				-- or pull in all of 'runtimepath'. NOTE: this is a lot slower
				-- library = vim.api.nvim_get_runtime_file("", true)
			}
		})
	end,
	settings = {
		Lua = {}
	}
})

require('lspconfig').ts_ls.setup({
	capabilities = capabilities
})

-- Fix issue with ufo plugin with lsp yaml language server: https://github.com/redhat-developer/yaml-language-server/issues/912
local yamlCapabilities = capabilities
yamlCapabilities.textDocument.foldingRange = {
	dynamicRegistration = false,
	lineFoldingOnly = true,
}

require('lspconfig').yamlls.setup({
	capabilities = yamlCapabilities,
	settings = {
		yaml = {
			schemas = {
				["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
			},
		},
	},
})

require('lspconfig').sqlls.setup({
	capabilities = capabilities
})

require('lspconfig').vimls.setup({
	capabilities = capabilities
})

require('lspconfig').dockerls.setup({
	capabilities = capabilities
})

require('lspconfig').docker_compose_language_service.setup({
	capabilities = capabilities
})

require('lspconfig').markdown_oxide.setup({
	capabilities = capabilities
})

require('lspconfig').eslint.setup({
	capabilities = capabilities
})

require('lspconfig').html.setup({
	capabilities = capabilities
})

require('lspconfig').stylelint_lsp.setup({
	capabilities = capabilities
})

require('lspconfig').typos_lsp.setup({
	capabilities = capabilities
})

-- Auto clear hlsearch when cursor moves
vim.api.nvim_create_autocmd('CursorMoved', {
	group = vim.api.nvim_create_augroup('auto-hlsearch', { clear = true }),
	callback = function ()
		if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
			vim.schedule(function () vim.cmd.nohlsearch() end)
		end
	end
})

require('php-helpers');


--require('avante').setup({
--  ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
--  provider = "claude", -- The provider used in Aider mode or in the planning phase of Cursor Planning Mode
--  -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
--  -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
--  -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
--  auto_suggestions_provider = "claude",
--  cursor_applying_provider = nil, -- The provider used in the applying phase of Cursor Planning Mode, defaults to nil, when nil uses Config.provider as the provider for the applying phase
--  claude = {
--    endpoint = "https://api.anthropic.com",
--    model = "claude-3-7-sonnet-latest",
--    temperature = 0,
--    max_tokens = 8192,
--  },
--  ---Specify the special dual_boost mode
--  ---1. enabled: Whether to enable dual_boost mode. Default to false.
--  ---2. first_provider: The first provider to generate response. Default to "openai".
--  ---3. second_provider: The second provider to generate response. Default to "claude".
--  ---4. prompt: The prompt to generate response based on the two reference outputs.
--  ---5. timeout: Timeout in milliseconds. Default to 60000.
--  ---How it works:
--  --- When dual_boost is enabled, avante will generate two responses from the first_provider and second_provider respectively. Then use the response from the first_provider as provider1_output and the response from the second_provider as provider2_output. Finally, avante will generate a response based on the prompt and the two reference outputs, with the default Provider as normal.
--  ---Note: This is an experimental feature and may not work as expected.
--  dual_boost = {
--    enabled = false,
--    first_provider = "openai",
--    second_provider = "claude",
--    prompt = "Based on the two reference outputs below, generate a response that incorporates elements from both but reflects your own judgment and unique perspective. Do not provide any explanation, just give the response directly. Reference Output 1: [{{provider1_output}}], Reference Output 2: [{{provider2_output}}]",
--    timeout = 60000, -- Timeout in milliseconds
--  },
--  behaviour = {
--    auto_suggestions = false, -- Experimental stage
--    auto_set_highlight_group = true,
--    auto_set_keymaps = true,
--    auto_apply_diff_after_generation = false,
--    support_paste_from_clipboard = false,
--    minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
--    enable_token_counting = true, -- Whether to enable token counting. Default to true.
--    enable_cursor_planning_mode = false, -- Whether to enable Cursor Planning Mode. Default to false.
--    enable_claude_text_editor_tool_mode = false, -- Whether to enable Claude Text Editor Tool Mode.
--  },
--  mappings = {
--    --- @class AvanteConflictMappings
--    diff = {
--      ours = "co",
--      theirs = "ct",
--      all_theirs = "ca",
--      both = "cb",
--      cursor = "cc",
--      next = "]x",
--      prev = "[x",
--    },
--    suggestion = {
--      accept = "<M-l>",
--      next = "<M-]>",
--      prev = "<M-[>",
--      dismiss = "<C-]>",
--    },
--    jump = {
--      next = "]]",
--      prev = "[[",
--    },
--    submit = {
--      normal = "<CR>",
--      insert = "<C-s>",
--    },
--    cancel = {
--      normal = { "<C-c>", "<Esc>", "q" },
--      insert = { "<C-c>" },
--    },
--    sidebar = {
--      apply_all = "A",
--      apply_cursor = "a",
--      retry_user_request = "r",
--      edit_user_request = "e",
--      switch_windows = "<Tab>",
--      reverse_switch_windows = "<S-Tab>",
--      remove_file = "d",
--      add_file = "@",
--      close = { "<Esc>", "q" },
--      close_from_input = nil, -- e.g., { normal = "<Esc>", insert = "<C-d>" }
--    },
--  },
--  hints = { enabled = true },
--  windows = {
--    ---@type "right" | "left" | "top" | "bottom"
--    position = "right", -- the position of the sidebar
--    wrap = true, -- similar to vim.o.wrap
--    width = 30, -- default % based on available width
--    sidebar_header = {
--      enabled = true, -- true, false to enable/disable the header
--      align = "center", -- left, center, right for title
--      rounded = true,
--    },
--    input = {
--      prefix = "> ",
--      height = 8, -- Height of the input window in vertical layout
--    },
--    edit = {
--      border = "rounded",
--      start_insert = true, -- Start insert mode when opening the edit window
--    },
--    ask = {
--      floating = false, -- Open the 'AvanteAsk' prompt in a floating window
--      start_insert = true, -- Start insert mode when opening the ask window
--      border = "rounded",
--      ---@type "ours" | "theirs"
--      focus_on_apply = "ours", -- which diff to focus after applying
--    },
--  },
--  highlights = {
--    ---@type AvanteConflictHighlights
--    diff = {
--      current = "DiffText",
--      incoming = "DiffAdd",
--    },
--  },
--  --- @class AvanteConflictUserConfig
--  diff = {
--    autojump = true,
--    ---@type string | fun(): any
--    list_opener = "copen",
--    --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
--    --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
--    --- Disable by setting to -1.
--    override_timeoutlen = 500,
--  },
--  suggestion = {
--    debounce = 600,
--    throttle = 600,
--  },
--})
--
--

require('octocode').setup()

