let s:init_vim_path = expand('<sfile>:p:h')

let s:vim_config_path = s:init_vim_path . '/vim'

execute 'source ' . s:vim_config_path . '/settings.vim'
execute 'source ' . s:vim_config_path . '/plugins.vim'
execute 'source ' . s:vim_config_path . '/functions.vim'
execute 'source ' . s:vim_config_path . '/mappings.vim'
execute 'source ' . s:vim_config_path . '/autocommands.vim'
execute 'source ' . s:vim_config_path . '/commands.vim'

colorscheme obsidian

