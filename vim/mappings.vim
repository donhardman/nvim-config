" Terminal improvements
tnoremap <C-o> <C-\><C-n>

" We do it in init.lua in autoway now
"autocmd BufWinEnter * if &buftype == '' | nnoremap <buffer> <Esc> :noh<CR> | endif

" Run command in visual mode and replace it with output
xnoremap ! :s/\%V.*\%V./\=system(input('Command: ', '', 'shellcmd'))/g<CR>

" Move in insert mode
inoremap ∆ <Down>
inoremap ˚ <Up>
inoremap ˙ <Left>
inoremap ¬ <Right>
"
" Move between windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Close windows from the current position
nnoremap <Space>xj :wincmd j<CR>:q<CR>:wincmd k<CR>
nnoremap <Space>xk :wincmd k<CR>:q<CR>:wincmd j<CR>
nnoremap <Space>xh :wincmd h<CR>:q<CR>:wincmd l<CR>
nnoremap <Space>xl :wincmd l<CR>:q<CR>:wincmd h<CR>

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
nnoremap <silent> gh <Plug>(GitGutterNextHunk)
nnoremap <silent> gH <Plug>(GitGutterPrevHunk)
nnoremap <silent> dh <Plug>(GitGutterUndoHunk)

" Use K to either doHover or show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

" Keep visual mode on ident fixing
vnoremap > >gv
vnoremap < <gv

" Terminal like movements in insert mode
inoremap <C-x> <C-o>x
inoremap <C-a> <C-o>^
inoremap <C-e> <C-o>$
inoremap <C-u> <Esc>"_d^xi
inoremap <C-k> <C-o>"_d$
inoremap <M-C-H> <Esc>dBxi

" Movements by words forward and backwards in insert mode
inoremap <C-h> <C-o>b
inoremap <C-l> <Esc>ea

" Comments
" ÷ = <M-/>
nnoremap ÷ <Plug>CommentaryLine<CR>
vnoremap ÷ <Plug>Commentary<CR>

" Wait for command when we click space
nnoremap <Space> <Nop>
nnoremap <Space>p <Nop>
nnoremap <Space>a <Nop>
nnoremap <Space>x <Nop>

" Pane control p for panel, s - sidebar, o - open, f - find etc
nnoremap <silent> <Space>pe :lua require("yazi").yazi(nil, vim.fn.getcwd())<CR>
nnoremap <silent> <Space>pE :lua require("yazi").yazi(nil, vim.api.nvim_buf_get_name(0))<CR>
nnoremap <silent> <Space>po :Files <C-r>=getcwd()<CR><CR>
nnoremap <silent> <Space>pO :Files <C-r>=expand('%:h:p')<CR><CR>
nnoremap <silent> <Space>pv :vsplit<CR>
nnoremap <silent> <Space>pV :Gvdiffsplit<CR>
nnoremap <silent> <Space>ph :split<CR>
nnoremap <silent> <Space>pH :Ghdiffsplit<CR>
nnoremap <silent> <Space>pq :q<CR>
nnoremap <silent> <Space>pQ :qa<CR>
nnoremap <silent> <Space>pl :BLines<CR>
nnoremap <silent> <Space>pL :Lines<CR>
nnoremap <silent> <Space>pf :Spectre<CR>
nnoremap <silent> <Space>pF :RG<CR>
nnoremap <silent> <C-/> :Spectre<CR>
nnoremap <silent> <C-\> :Octocode<CR>
nnoremap <silent> <Space>ps :w<CR>
nnoremap <silent> <Space>pS :wa<CR>
nnoremap <silent> <Space>pj :Jumps<CR>
nnoremap <silent> <Space>pJ :Marks<CR>
nnoremap <silent> <Space>pb :Buffers<CR>
nnoremap <silent> <Space>pz :call WinZoomToggle()<CR>
nnoremap <silent> <Space>pt :Outline<CR>

" Assist control, a for assist, a - ask, p - proofread, etc
nnoremap <leader>a :Assist<space>
vnoremap <leader>a :Assist<space>

nnoremap <Space>aa :Assist<space>
vnoremap <Space>aa :Assist<space>
vnoremap <silent> <Space>ap :Assist You are proofreader, use input AS TEXT TO PROOFREAD, make it sounds like a native speaker in the way like AI will never do. Respond exactly with fixed text without any explanation. Keep all original marks as is do not remove any marks, do not change other things than text, keep all unrelated symbols as is<CR>

" Buffer shortcuts
nunmap <C-W>d
nunmap <C-W><C-D>
nnoremap <C-w> :bd<CR>
vnoremap <C-w> :bd<CR>
inoremap <C-w> <Esc>:bd<CR>

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
nmap <silent> ga <Plug>(EasyAlign)
xmap <silent> ga <Plug>(EasyAlign)

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

nnoremap <silent> gt :<C-U>call <SID>JumpToSequencePrompt(v:true)<CR>
nnoremap <silent> gT :<C-U>call <SID>JumpToSequencePrompt(v:false)<CR>
nnoremap <silent> g/ :<C-U>call <SID>FindSequencePrompt(v:true)<CR>
nnoremap <silent> g? :<C-U>call <SID>FindSequencePrompt(v:false)<CR>
