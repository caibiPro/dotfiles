set nocompatible                 " get rid of Vi compatibility mode. SET FIRST!

" =============================================================================
"   PLUGINS
" =============================================================================
call plug#begin('~/.dotfiles/vim/.vim/plugged')

" Colorschemes
Plug 'joshdick/onedark.vim'

" GUI enhancements
Plug 'itchyny/lightline.vim'    " light statusline plugin
Plug 'sheerun/vim-polyglot'     " improved syntax highlighting for various languages

call plug#end()

" =============================================================================
"  EDITOR SETTINGS
" =============================================================================

" Colorscheme
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('termguicolors')
    " Turns on true terminal colors
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

    " Turns on 24-bit RGB color support
    set termguicolors

    " Defines how many colors should be used. (maximum: 256, minimum: 0)
    set t_Co=256
endif


set background=dark
colorscheme onedark
let g:lightline = {'colorscheme' : 'onedark'}

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
set laststatus=2
    
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
