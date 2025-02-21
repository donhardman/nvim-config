function! ShowDocumentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call ShowLspDoc()
	endif
endfunction

function! ShowLspDoc()
	lua << EOF
	local status, _ = pcall(vim.lsp.buf.hover)
	if not status then
		-- Optionally, you can add some debug logging here
		-- vim.api.nvim_echo({{"No hover information available", "WarningMsg"}}, false, {})
		end
EOF
endfunction

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

" Improve jumping
function! JumpToSequencePrompt(forward) abort
	let l:sequence = input("Jump to sequence " . (a:forward ? "forward" : "backward") . ": ")
	if !empty(l:sequence)
		call JumpToSequence(l:sequence, a:forward)
	endif
endfunction

function! FindSequencePrompt(forward) abort
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

" Helper functions
function! CheckBackspace() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
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

function! RemapEnterForCommandLineWindow()
	nunmap <buffer> <Enter>
	nunmap <buffer> <BS>
endfunction

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

function! OpenReadmeIfExists()
	if argc() == 0
		return
	endif

	let l:path = argv(0)
	if !isdirectory(l:path) || filereadable(l:path)
		execute 'edit ' . fnameescape(l:path)
		return
	endif

	let l:dir = l:path
	let l:readme_path = l:dir . '/README.md'

	if filereadable(l:readme_path)
		execute 'bp|bd#'
		execute 'edit ' . fnameescape(l:readme_path)
		execute 'set filetype=markdown'
		return
	endif

	" Check if the current buffer is empty
	if empty(bufname('%'))
		" Close the empty buffer
		bdelete!
	endif

	call fzf#vim#files(l:dir, {}, v:true)
endfunction
