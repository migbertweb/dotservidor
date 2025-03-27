 call plug#begin()

" List your plugins here
Plug 'tpope/vim-sensible'

" syntax
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
"Plug 'norcalli/nvim-colorizer.lua'

" status bar
Plug 'dense-analysis/ale'       " Dependency: linter
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Themes
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/sonokai'

" Tree
Plug 'scrooloose/nerdtree'

" typing
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-surround'

" autocomplete
Plug 'sirver/ultisnips'

" IDE
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'yggdroot/indentline'
Plug 'scrooloose/nerdcommenter'

call plug#end()

