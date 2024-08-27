let g:local_history_path = $HOME . '/.local-history'
let g:local_history_new_change_delay = 60
let g:local_history_max_changes = 20
let g:local_history_exclude = [ '**/node_modules/**', '*.txt', '**/vendor/**' ]
let g:airline_powerline_fonts = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:python_host_prog = '~/.config/nvim-py/bin/python3'
let g:python3_host_prog = '~/.config/nvim-py3/bin/python3'
let g:airline_gui_colors = 1
let g:airline_powerline_fonts = 1
let g:NERDCreateDefaultMappings = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_signs = 1
let g:gitgutter_grep = 'rg'
let g:gitgutter_highlight_linenrs = 1
let g:neoformat_try_node_exe = 1
let g:CtrlSpaceDefaultMappingKey = "<C-space>"

call plug#begin('~/.config/nvim/plugged')
Plug 'donhardman/vim-obsidian-theme'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'Pocco81/auto-save.nvim'

" autocomplete and LSP
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'windwp/nvim-ts-autotag'
Plug 'hedyhli/outline.nvim'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'Joorem/vim-haproxy'
Plug 'danymat/neogen'
Plug 'sbdchd/neoformat'
Plug 'supermaven-inc/supermaven-nvim'
Plug 'donhardman/assist.nvim'

" file manager
Plug 'mikavilpas/yazi.nvim'
"Plug 'luukvbaal/nnn.nvim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'

" Searching panel
Plug 'nvim-lua/plenary.nvim'
Plug 'donhardman/nvim-spectre', { 'do': './build.sh' }

" Statusline
"Plug 'donhardman/eleline.vim'
Plug 'donhardman/lualine.nvim'

" Extra
"Plug 'tpope/vim-surround'
Plug 'itchyny/vim-cursorword'
Plug 'brenoprata10/nvim-highlight-colors'
"Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-commentary'
Plug 'dinhhuy258/vim-local-history', {'branch': 'master', 'do': ':UpdateRemotePlugins'}
Plug 'mistricky/codesnap.nvim', { 'do': 'make' }
Plug 'michaelb/sniprun', {'do': 'sh ./install.sh'}
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-startify'
Plug 'lukas-reineke/indent-blankline.nvim'
"Plug 'junegunn/vim-slash'
Plug 'airblade/vim-gitgutter'
Plug 'dstein64/vim-startuptime'
call plug#end()

lua require('init')
