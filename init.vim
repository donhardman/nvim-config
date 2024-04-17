" Set line numbers
set number
set relativenumber
set wrap
set noexpandtab
set shiftwidth=2
set tabstop=2
set termguicolors
set guifont=FiraCode\ Nerd\ Font\ Mono:h14
set encoding=utf-8
set clipboard=unnamedplus

" Move between windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <silent> q :q<CR>
tnoremap <Esc> <C-\><C-n>:q<CR>
"tnoremap q <C-\><C-n>:q<CR>
tnoremap <C-k><C-b> <C-\><C-n>:q<CR>

vnoremap > >gv
vnoremap < <gv

" Terminal like movements in insert mode
inoremap <C-x> <C-o>x
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-u> <C-o>d^<C-o>x
inoremap <C-k> <C-o>d$
inoremap <M-b> <C-o>B
inoremap <M-BS> <C-o>B
inoremap <M-f> <C-o>w
nnoremap <C-/> :Spectre<CR>

" Comment
nnoremap <M-/> :call nerdcommenter#Comment('n', 'toggle')<CR>
vnoremap <M-/> :call nerdcommenter#Comment('v', 'toggle')<CR>

" Buffer shortcuts
nnoremap <Tab> :BufferNext<CR>
nnoremap <S-Tab> :BufferPrevious<CR>
nnoremap <C-w> :BufferClose<CR>
nnoremap <M-1> <Cmd>BufferGoto 1<CR>
nnoremap <M-2> <Cmd>BufferGoto 2<CR>
nnoremap <M-3> <Cmd>BufferGoto 3<CR>
nnoremap <M-4> <Cmd>BufferGoto 4<CR>
nnoremap <M-5> <Cmd>BufferGoto 5<CR>
nnoremap <M-6> <Cmd>BufferGoto 6<CR>
nnoremap <M-7> <Cmd>BufferGoto 7<CR>
nnoremap <M-8> <Cmd>BufferGoto 8<CR>
nnoremap <M-9> <Cmd>BufferGoto 9<CR>
nnoremap <M-0> <Cmd>BufferLast<CR>
nnoremap <C-t> :enew<CR>
nnoremap <C-S-t> <Cmd>BufferRestore<CR>
nnoremap <M-p> <Cmd>BufferPick<CR>

" Editor improvements
vnoremap <C-c> "+y
vnoremap <C-x> "+d
nnoremap <C-v> "+p
inoremap <C-v> <esc>"+pA
inoremap <C-CR> <C-o>o
inoremap <C-z> <C-o>u
nnoremap <esc> :noh<CR>
nnoremap <S-e> ea

" Configure autocomplete smart tab
inoremap <silent><expr> <S-Tab>
	\ pumvisible() ? "\<C-p>" :
	\ CheckBackspace() ? "\<S-Tab>" :
	\ coc#refresh()
inoremap <silent><expr> <Tab>
	\ pumvisible() ? "\<C-n>" :
	\ CheckBackspace() ? "\<Tab>" :
	\ coc#refresh()

" File manager and fuzzy search
nnoremap <C-k><C-b> :NnnExplorer %:p:h<CR>
nnoremap <C-p> :NnnPicker %:p:h<CR>
command! -nargs=1 Duplicate execute 'write ' . expand('%:h') . '/' . <q-args> | execute 'edit ' . expand('%:h') . '/' . <q-args>

let g:local_history_path = $HOME . '/.local-history'
let g:local_history_new_change_delay = 60
let g:local_history_max_changes = 20
let g:local_history_exclude = [ '**/node_modules/**', '*.txt', '**/vendor/**' ]

let g:python_host_prog = '~/.config/nvim-py/bin/python3'
let g:python3_host_prog = '~/.config/nvim-py3/bin/python3'
let g:coc_config_home = '~/.nvim'
let g:coc_data_home = '~/.nvim/coc'
let g:airline_gui_colors = 1
let g:airline_powerline_fonts = 1
let g:NERDCreateDefaultMappings = 0

call plug#begin('~/.nvim/plugged')
Plug 'donhardman/vim-obsidian-theme'

" Tabs
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'romgrk/barbar.nvim'

" autocomplete and LSP
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" file manager
Plug 'luukvbaal/nnn.nvim'

" Searching panel
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-pack/nvim-spectre', { 'do': './build.sh' }

" Statusline
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'

" Folding/unfolding blocks
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'

" Extra
Plug 'brenoprata10/nvim-highlight-colors'
Plug 'preservim/nerdcommenter'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'dinhhuy258/vim-local-history', {'branch': 'master', 'do': ':UpdateRemotePlugins'}
call plug#end()

colorscheme obsidian

lua package.path = package.path .. ';/Users/dk/.nvim/?.lua'
lua require('init')

" Initialize custom syntax
runtime! syntax/rec.vim
autocmd BufNewFile,BufRead *.rec,*.rep set filetype=rec

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
