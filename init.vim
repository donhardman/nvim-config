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

nnoremap <Esc> :noh<CR>

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

" Remap keys for gotos
nnoremap <silent> gd :call CocActionAsync('jumpDefinition')<CR>
nnoremap <silent> gD :call CocActionAsync('jumpDeclaration')<CR>
nnoremap <silent> gy :call CocActionAsync('jumpTypeDefinition')<CR>
nnoremap <silent> gi :call CocActionAsync('jumpImplementation')<CR>
nnoremap <silent> gr :call CocActionAsync('jumpReferences')<CR>
nnoremap <silent> <C-.> :CocDiagnostics<CR>
nnoremap <silent> <C-;> :call CocActionAsync('codeAction', '')<CR>
nnoremap <silent> <C-,> :call CocActionAsync('doQuickFix')<CR>
nnoremap <silent> cir :call CocActionAsync('rename')<CR>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g :call  CocActionAsync('diagnosticPrevious')
nmap <silent> ]g :call  CocActionAsync('diagnosticNext')

autocmd CursorHold * silent call CocActionAsync('highlight')

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		"call CocActionAsync('showSignatureHelp')
		call CocActionAsync('doHover')
	endif
endfunction

" Configure GitGutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)

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

" Pane control p for panel, s - sidebar, o - open, f - find etc
nnoremap <Space>ps :NnnExplorer %:h:p<CR>
nnoremap <Space>po :NnnPicker %:h:p<CR>
nnoremap <Space>pv :vsplit<CR>
nnoremap <Space>ph :split<CR>
nnoremap <Space>pq :q<CR>
nnoremap <Space>pf :Spectre<CR>
nnoremap <Space>pd :CocDiagnostics<CR>
nnoremap <C-/> :Spectre<CR>
nnoremap <Space>pp :BufferPick<CR>
nnoremap <Space>pz :call WinZoomToggle()<CR>

nnoremap <leader>a :Assist<space>
vnoremap <leader>a :Assist<space>

" Buffer shortcuts
nnoremap <C-w> :call SmartClose()<CR>
vnoremap <C-w> :call SmartClose()<CR>
inoremap <C-w> <Esc>:call SmartClose()<CR>

nnoremap <Tab> :BufferNext<CR>
nnoremap <S-Tab> :BufferPrevious<CR>
nnoremap <C-t> :enew<CR>
nnoremap <C-S-t> :BufferRestore<CR>
" π = <M-p>
nnoremap π :BufferPick<CR>

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

" Configure autocomplete smart tab
inoremap <silent><expr> <S-Tab>
			\ pumvisible() ? "\<C-p>" :
			\ CheckBackspace() ? "\<S-Tab>" :
			\ coc#refresh()
inoremap <silent><expr> <Tab>
			\ pumvisible() ? "\<C-n>" :
			\ CheckBackspace() ? "\<Tab>" :
			\ coc#refresh()

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
command! -nargs=0 ImportClass :call CocAction('runCommand', 'editor.action.organizeImport')

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
nnoremap <silent> gf :<C-U>call <SID>FindSequencePrompt(v:true)<CR>
nnoremap <silent> gF :<C-U>call <SID>FindSequencePrompt(v:false)<CR>

let g:local_history_path = $HOME . '/.local-history'
let g:local_history_new_change_delay = 60
let g:local_history_max_changes = 20
let g:local_history_exclude = [ '**/node_modules/**', '*.txt', '**/vendor/**' ]
let g:airline_powerline_fonts = 1

let g:python_host_prog = '~/.config/nvim-py/bin/python3'
let g:python3_host_prog = '~/.config/nvim-py3/bin/python3'
let g:coc_config_home = '~/.config/nvim'
let g:coc_data_home = '~/.config/nvim/coc'
let g:airline_gui_colors = 1
let g:airline_powerline_fonts = 1
let g:NERDCreateDefaultMappings = 0
let g:gitgutter_map_keys = 0
let g:gitgutter_signs = 1
let g:gitgutter_grep = 'rg'
let g:gitgutter_highlight_linenrs = 1

call plug#begin('~/.config/nvim/plugged')
Plug 'donhardman/vim-obsidian-theme'

" Tabs
Plug 'nvim-tree/nvim-web-devicons'
Plug 'lewis6991/gitsigns.nvim'
Plug 'romgrk/barbar.nvim'

" autocomplete and LSP
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'danymat/neogen'
Plug 'donhardman/assist.nvim'

" file manager
Plug 'luukvbaal/nnn.nvim'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'ctrlpvim/ctrlp.vim'

" Searching panel
Plug 'nvim-lua/plenary.nvim'
Plug 'donhardman/nvim-spectre', { 'do': './build.sh' }

" Statusline
"Plug 'donhardman/eleline.vim'
Plug 'donhardman/lualine.nvim'

" Folding/unfolding blocks
Plug 'kevinhwang91/promise-async'
Plug 'kevinhwang91/nvim-ufo'

" Extra
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
autocmd BufNewFile,BufRead *.ini.tpl set filetype=dosini

" Helper functions
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! SmartClose()
	" Check if the current buffer is a normal buffer that presumably can be closed with :BufferClose
	if &buftype == ''
		execute ':BufferClose'
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
"augroup nnn_explorer
"autocmd!
"autocmd VimEnter * silent! NnnExplorer
"augroup END

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

