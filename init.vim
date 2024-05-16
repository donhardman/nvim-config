let s:init_vim_path = expand('<sfile>:p:h')

set number
set relativenumber
set nowrap
set cc=+1
set textwidth=120
set concealcursor=c
set conceallevel=2
set autoindent
set smartindent
set smarttab
set noexpandtab
set shiftwidth=2
set tabstop=2
set hidden
set nocompatible
set showtabline=0
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldcolumn=1
set foldlevel=99
set foldlevelstart=99
set foldenable
set title
set titlelen=0
set titlestring=%{expand(\"%:p\")}
let &titlestring="nvim " . &titlestring
set backup
set backupdir=~/.config/nvim/cache/backup
set nowritebackup
set noshowmode
set termguicolors
set guifont=FiraCode\ Nerd\ Font\ Mono:h14
set encoding=utf-8
set clipboard=unnamedplus
" Terminal improvements
tnoremap <C-o> <C-\><C-n>

autocmd BufWinEnter * if &buftype == '' | nnoremap <buffer> <Esc> :noh<CR> | endif

" Move in insert mode
inoremap ∆ <Down>
inoremap ˚ <Up>
inoremap ˙ <Left>
inoremap ¬ <Right>
" Move between windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Show diagnostics
nnoremap <silent> <C-.> :lua vim.diagnostic.open_float()<CR>

" Code actions and quick fixes
nnoremap <silent> <C-;> :lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <C-,> :lua vim.lsp.buf.code_action({ apply = true })<CR>

" Rename symbol
nnoremap <silent> cir :lua vim.lsp.buf.rename()<CR>

" Go to definition, declaration, type definition, implementation, and references
nnoremap <silent> gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gy :lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent> gj <C-i>
nnoremap <silent> gJ <C-o>

" Navigate diagnostics
nnoremap <silent> gN :lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> gn :lua vim.diagnostic.goto_next()<CR>

" Configure GitGutter
nnoremap gh <Plug>(GitGutterNextHunk)
nnoremap gH <Plug>(GitGutterPrevHunk)

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		lua vim.lsp.buf.hover()
	endif
endfunction

" Keep visual mode on ident fixing
vnoremap > >gv
vnoremap < <gv

" Terminal like movements in insert mode
inoremap <C-x> <C-o>x
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-u> <Esc>d^xi
inoremap <C-k> <C-o>d$
inoremap <M-C-H> <Esc>dBxi

" Comments
" ÷ = <M-/>
nnoremap ÷ :call nerdcommenter#Comment('n', 'toggle')<CR>
vnoremap ÷ :call nerdcommenter#Comment('v', 'toggle')<CR>

" Disable space in normal mode
nnoremap <Space> <Nop>

function! WinZoomToggle() abort
	if ! exists('w:WinZoomIsZoomed')
		let w:WinZoomIsZoomed = 0
	endif
	if w:WinZoomIsZoomed == 0
		let w:WinZoomOldWidth = winwidth(0)
		let w:WinZoomOldHeight = winheight(0)
		wincmd _
		wincmd |
		let w:WinZoomIsZoomed = 1
	elseif w:WinZoomIsZoomed == 1
		execute "resize " . w:WinZoomOldHeight
		execute "vertical resize " . w:WinZoomOldWidth
		let w:WinZoomIsZoomed = 0
	endif
endfunction

" Pane control p for panel, s - sidebar, o - open, f - find etc
"nnoremap <Space>pe :NnnExplorer <C-r>=getcwd()<CR><CR>
nnoremap <Space>pe :lua require("yazi").yazi(nil, vim.fn.getcwd())<CR>
nnoremap <Space>pE :lua require("yazi").yazi(nil, vim.api.nvim_buf_get_name(0))<CR>
"nnoremap <Space>po :NnnPicker <C-r>=getcwd()<CR><CR>
"nnoremap <Space>pO :NnnPicker <C-r>=expand('%:h:p')<CR><CR>
nnoremap <Space>po :Files <C-r>=getcwd()<CR><CR>
nnoremap <Space>pO :Files <C-r>=expand('%:h:p')<CR><CR>
nnoremap <Space>pv :vsplit<CR>
nnoremap <Space>pV :Gvdiffsplit<CR>
nnoremap <Space>ph :split<CR>
nnoremap <Space>pH :Ghdiffsplit<CR>
nnoremap <Space>pq :q<CR>
nnoremap <Space>pQ :qa<CR>
nnoremap <Space>pl :BLines<CR>
nnoremap <Space>pL :Lines<CR>
nnoremap <Space>pf :Spectre<CR>
nnoremap <Space>pF :RG<CR>
nnoremap <C-/> :Spectre<CR>
nnoremap <Space>ps :w<CR>
nnoremap <Space>pS :wa<CR>
nnoremap <Space>pj :Jumps<CR>
nnoremap <Space>pJ :Marks<CR>
nnoremap <Space>pb :Buffers<CR>
nnoremap <Space>pz :call WinZoomToggle()<CR>
nnoremap <Space>pt :Outline<CR>

nnoremap <leader>a :Assist<space>
vnoremap <leader>a :Assist<space>
vnoremap <silent> <Space>ap :Assist Proofread the text, keep all original marks as is without altering, do not change other things than text, keep all unrelated symbols as is<CR>

" Buffer shortcuts
nnoremap <C-w> :call SmartClose()<CR>
vnoremap <C-w> :call SmartClose()<CR>
inoremap <C-w> <Esc>:call SmartClose()<CR>

nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
nnoremap <C-t> :enew<CR>

" Editor improvements
"vnoremap <C-c> "+y
vnoremap <C-x> "+d
"nnoremap <C-v> "+p
inoremap <C-v> <esc>"+pA
inoremap <C-CR> <C-o>o
inoremap <C-z> <C-o>u
nnoremap <S-e> ea
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" Bash-like keybindings for command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-b> <S-Left>
cnoremap <M-f> <S-Right>

" Custom commands
command! -nargs=1 Duplicate execute 'write ' . expand('%:h') . '/' . <q-args> | execute 'edit ' . expand('%:h') . '/' . <q-args>

" Improve jumping
function! s:JumpToSequencePrompt(forward) abort
	let l:sequence = input("Jump to sequence " . (a:forward ? "forward" : "backward") . ": ")
	if !empty(l:sequence)
		call JumpToSequence(l:sequence, a:forward)
	endif
endfunction

function! s:FindSequencePrompt(forward) abort
	let l:sequence = input("Sequence to find " . (a:forward ? "forward" : "backward") . ": ")
	if empty(l:sequence)
		echohl WarningMsg
		echo "No sequence provided."
		echohl None
		return
	endif

	" Save the current cursor position
	let l:curpos = getcurpos()

	" Search for the sequence
	let l:flags = 'W'  " Search whole words
	if a:forward
		let l:result = search(l:sequence, 'c' . l:flags)
	else
		let l:result = search(l:sequence, 'b' . l:flags)
	endif

	" If the search fails, restore the cursor position
	if l:result == 0
		call setpos('.', l:curpos)
		echohl WarningMsg
		echo "Sequence not found."
		echohl None
	endif
endfunction

nnoremap <silent> gt :<C-U>call <SID>JumpToSequencePrompt(v:true)<CR>
nnoremap <silent> gT :<C-U>call <SID>JumpToSequencePrompt(v:false)<CR>
nnoremap <silent> g/ :<C-U>call <SID>FindSequencePrompt(v:true)<CR>
nnoremap <silent> g? :<C-U>call <SID>FindSequencePrompt(v:false)<CR>

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

" Tabs
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
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
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
Plug 'preservim/nerdcommenter'
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

colorscheme obsidian

" Initialize custom syntax
runtime! syntax/rec.vim
autocmd BufNewFile,BufRead *.rec,*.recb,*.rep set filetype=rec
autocmd BufNewFile,BufRead *.tpl set filetype=html
autocmd BufNewFile,BufRead *.ini.tpl set filetype=dosini
autocmd BufNewFile,BufRead *.cfg set filetype=haproxy
autocmd BufNewFile,BufRead Dockerfile-* set filetype=dockerfile

" Helper functions
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! SmartClose()
	" Check if the current buffer is a normal buffer that presumably can be closed with :BufferClose
	if &buftype == ''
		execute 'bp|bd#'
	else
		execute ':q'
	endif
endfunction

" Check if the current window is a floating window
function! IsFloatingWindow() abort
	let l:win_config = nvim_win_get_config(0)
	if l:win_config['relative'] != ''
		return 1
	else
		return 0
	endif
endfunction

function! MaybeRemapEnterForBuffer()
	if &modifiable
		nnoremap <buffer> <Enter> O<Esc>j
		nnoremap <buffer> <BS> kJ^
	endif
endfunction

function! MaybeRemapEscForFloatingWindow()
	if IsFloatingWindow()
		tnoremap <buffer> <Esc> <C-\><C-n>:q<CR>
	endif
endfunction

autocmd BufWinEnter * call MaybeRemapEnterForBuffer()
autocmd BufWinEnter * call MaybeRemapEscForFloatingWindow()

function! JumpToSequence(sequence, forward)
	if a:forward == ''
		let a:forward = v:true
	endif
	let l:line = getline('.')
	if a:forward
		let l:pos = match(l:line, a:sequence)
	else
		let l:pos = matchend(l:line, a:sequence)
	endif
	if l:pos != -1
		call cursor(line('.'), l:pos + 1)
	else
		echohl ErrorMsg
		echomsg 'E486: Pattern not found: ' . a:sequence
		echohl None
	endif
endfunction

" Auto open README.md file when it exists on dir open
augroup OpenReadme
	autocmd!
	autocmd VimEnter * call s:OpenReadmeIfExists()
augroup END

function! s:OpenReadmeIfExists()
	if argc() == 0
		return
	endif

	let l:path = argv(0)
	if filereadable(l:path)
		execute 'edit ' . fnameescape(l:path)
		return
	endif

	let l:dir = l:path
	let l:readme_path = l:dir . '/README.md'
	if filereadable(l:readme_path)
		execute 'bp|bd#'
		execute 'edit ' . fnameescape(l:readme_path)
		return
	endif

	" Check if the current buffer is empty
	if empty(bufname('%'))
		" Close the empty buffer
		bdelete!
	endif

	call fzf#vim#files('.', {}, v:true)
endfunction

