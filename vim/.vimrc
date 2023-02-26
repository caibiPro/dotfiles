set nocompatible                 " get rid of Vi compatibility mode. SET FIRST!

" =============================================================================
"   PLUGINS
" =============================================================================
call plug#begin('~/.dotfiles/vim/.vim/plugged')

" Colorschemes
Plug 'morhetz/gruvbox'

" GUI enhancements
Plug 'vim-airline/vim-airline'  " better status bar

call plug#end()

" =============================================================================
"  EDITOR SETTINGS
" =============================================================================

" Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256                    " enable 256-color mode
set background=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'

" Spaces & Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent                  " auto-indent
set smartindent                 " intelligent-indent
set tabstop=4                   " tab spacing
set shiftwidth=4                " indent/outdent by 4 columns
set softtabstop=4               " unify
set smarttab                    " use tabs at the start of a line, spaces elsewhere
set expandtab                   " use spaces instead of tabs

" UI Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number                      " show line numbers
set relativenumber              " show relative numbering
set ruler                       " show the ruler
set nowrap                      " don't wrap text
set showmatch                   " highlight parentheses for matching
set noshowmode                  " --INSERT-- is unncessary because of plug-in
set cursorline                  " highlight current line
    
" Searching
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch                    " continue to highlight searched phrases
set incsearch                   " but do highlight as$^ you type your search
set ignorecase                  " make searches case-insensitive
set smartcase                   " override ignorecase option if the search pattern contains upper case characters
vnoremap <C-h> :nohlsearch<cr>  " turn off search highlight in visual mode <C-h>
nnoremap <C-h> :nohlsearch<cr>  " turn off search highlight in nomal mode <C-h>

" Browse & Scroll
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=5                 " minimal number of screen lines to keep above and below the cursor

" Others
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable                   " enable syntax highlighting (previously syntax on)
filetype plugin indent on       " filetype detection[ON] plugin[ON] indent[ON]
set mouse+=a                    " a necessary evil, mouse support
set noerrorbells visualbell t_vb=       " disable annoying error noises
set hidden                      " allow buffer switching without saving
set noswapfile                  " loaded without creating a swapfile
set wildmenu                    " command-line completion operates in an enhanced mode           
set wildmode=longest:list,full  " completion mode that is used for the character specified with wildchar
set wildignore+=*/.git/*,*/tmp/*,*.swp  " ignore files for completion