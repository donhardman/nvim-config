augroup LspHover
	autocmd!
	autocmd CursorHoldI * silent! call ShowLspDoc()
augroup END

" Initialize custom syntax
runtime! syntax/rec.vim
augroup Syntax
	autocmd BufNewFile,BufRead *.rec,*.recb,*.rep set filetype=rec
	autocmd BufNewFile,BufRead *.tpl set filetype=html
	autocmd BufNewFile,BufRead *.ini.* set filetype=dosini
	autocmd BufNewFile,BufRead *.yml.* set filetype=yaml
	autocmd BufNewFile,BufRead *.toml.* set filetype=toml
	autocmd BufNewFile,BufRead *.cfg set filetype=haproxy
	autocmd BufNewFile,BufRead Dockerfile-* set filetype=dockerfile

	autocmd BufWinEnter * call MaybeRemapEnterForBuffer()
	autocmd BufWinEnter * call MaybeRemapEscForFloatingWindow()
	autocmd CmdwinEnter * call RemapEnterForCommandLineWindow()
augroup END

" Auto open README.md file when it exists on dir open
augroup OpenReadme
	autocmd!
	autocmd VimEnter * call OpenReadmeIfExists()
augroup END

autocmd FileType php setlocal indentexpr=
