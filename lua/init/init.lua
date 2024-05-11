
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

local nnn = require("nnn")
nnn.setup({
	explorer = {
		cmd = "NO_COLOR=1 nnn -G -o",
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

--local ufo = require("ufo")
--vim.keymap.set('n', 'zR', ufo.openAllFolds)
--vim.keymap.set('n', 'zM', ufo.closeAllFolds)

--ufo.setup()

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
	},
})
require('auto-save').setup({
	enabled = true,
	trigger_events = {"InsertLeave", "TextChanged"},
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
		'swift', 'scala', 'elixir', 'solidity', 'proto',
	},
	indent = {
		enable = true,
	},
	highlight = {
		enable = true,
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
})

require('assist').setup()

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
		['<C-e>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end, { 'i', 's' }),
	}),
	sources = cmp.config.sources({
		{ name = 'cmp_tabnine' },
		{ name = 'nvim_lsp' },
		}, {
			{ name = 'buffer' },
	}),
	experimental = {
		ghost_text = true, -- Show ghost text for completion candidates
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
				phpVersion = "8.3.4"
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
				useFullyQualifiedNames = true,
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
--require('lspsaga').setup({})

