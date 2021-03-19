" Some basic stuff
set encoding=utf-8
set cc=80


""" Tab Completion
" TODO - what does this do?
" set wildmode=list:longest " Setup Tab completion to work like in a shell

""" Search
set ignorecase   " case-insensitive search
set smartcase "TODO - what does this do
" but case-sensitive if expression contains a capital letter

""" Buffers - TODO - what does this do?
"set hidden       " Handle multiple buffers better
" You can abandon a buffer with unsaved changes without a warning

""" Terminal
set title        " show terminal title

""" Editor
set scrolloff=3  " show 3 lines of context around cursor
set list         " show invisible characters
let g:python_pep8_indent_hang_closing = 1

"""YAML indents the right way
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


""" Global Tabs and Spaces configurations
"set expandtab    " use spaces instead of tabs
"set tabstop=2    " global tab width
"set shiftwidth=2 " spaces to use when indenting

""" Line numbers are cool """
set number

" install the packages
packadd! auto-pairs
packadd! lightline
packadd! semshi
packadd! vim-python-pep8-indent
packadd! vim-commentary

" Flake8 config for ale, hopefully works in venv too
packadd! ale
let g:ale_python_flake8_executable = 'python'
let g:ale_python_flake8_options = '-m flake8'




""" colorscheme """
packadd! onedark
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost 
" $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more 
" information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif




syntax on
colorscheme onedark

" Update Remote Plugins
silent! UpdateRemotePlugins

" Get the helptags in
silent! helptags ALL

