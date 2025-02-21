set number
set relativenumber
" We do not need swap cuz we use autosave
set noswapfile
" set nowrap
set wrap
set linebreak
set showbreak=↪\  " The symbol to show at the start of wrapped lines
set breakindent   " Preserve indentation in wrapped text
set breakindentopt=shift:2  " Shift wrapped lines by 2 spaces
set textwidth=0
set wrapmargin=0
set formatoptions-=t
set formatoptions-=c
set formatoptions-=r
set formatoptions-=o
set formatoptions-=a
set cc=+1
set cmdheight=0
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
set updatetime=1250
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldcolumn=1
set foldlevel=99
set foldlevelstart=99
set foldenable
set title
set titlelen=0
set titlestring=%{expand('%:f')}
set backup
set backupdir=~/.config/nvim/cache/backup
set nowritebackup
set noshowmode
set termguicolors
set guifont=FiraCode\ Nerd\ Font\ Mono:h14
set encoding=utf-8
set clipboard=unnamedplus

