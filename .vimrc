set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax on
set showcmd
set ruler
set cursorline
set encoding=utf-8
set showmatch
set termguicolors
set sw=2
so ~/.vim/plugins.vim
so ~/.vim/maps.vim
"hjh
let g:airline_theme='sonokai'
highlight Normal ctermbg=NONE
set laststatus=2
set noshowmode


"" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Important!!
  if has('termguicolors')
    set termguicolors
  endif
" The configuration options should be placed before `colorscheme sonokai`.
let g:sonokai_style = 'andromeda'
let g:sonokai_better_performance = 1

colorscheme sonokai

