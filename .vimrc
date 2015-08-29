" force vim, required
set nocompatible

" required
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins
" -------

" add .editorconfig support
Plugin 'editorconfig/editorconfig-vim'

" add handlebars support
Plugin 'mustache/vim-mustache-handlebars'

" add vim-snipmate
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'

" add typescript-vim (support for .ts files)
Plugin 'leafgarland/typescript-vim'

" add vim-less (support for .less files)
Plugin 'groenewege/vim-less'

" add vim-indent-guides (displaying indent levels in Vim)
Plugin 'nathanaelkane/vim-indent-guides'

" add applescript support
Plugin 'vim-scripts/applescript.vim'

" add .jade support
Plugin 'digitaltoad/vim-jade'

" add jdaddy.vim: JSON manipulation and pretty printing
Plugin 'tpope/vim-jdaddy'

" add vim-surround: Operations on '', "", [], etc.
Plugin 'tpope/vim-surround'

" add commentary.vim: Comment stuff with gcc
Plugin 'tpope/vim-commentary'

" add vim-javascript
Plugin 'pangloss/vim-javascript'

" add :Remove, :Move, :Rename, :Mkdir, :SudoWrite, :SudoRead
Plugin 'tpope/vim-eunuch'

" add gf to jump between node requires
Plugin 'moll/vim-node'

" support for .jsx
Plugin 'mxw/vim-jsx'

" syntastic (syntax highlighting, yay!)
Plugin 'scrooloose/syntastic'

" ctrlp
Plugin 'ctrlpvim/ctrlp.vim'

" Cool status line (100% viml)
Plugin 'bling/vim-airline'

" Dim inactive windows
Plugin 'blueyed/vim-diminactive'

" All of your Plugins must be added before the following line
call vundle#end()
filetype plugin indent on

" Leader options
" --------------
" change the mapleader from \ to ,
let mapleader=","

" reduce : 2 keystrokes with -
nnoremap - :

" Tabs, Spaces and Indent
" -----------------------

set expandtab
set autoindent                      " always set autoindenting on
set copyindent                      " copy the previous indentation on autoindenting
set tabstop=4                       " a tab is four spaces
set backspace=indent,eol,start      " allow backspacing over everything in insert mode
set smarttab                        " insert tabs on the start of a line according to shiftwidth, not tabstop
set shiftwidth=4                    " number of spaces to use for autoindenting
set shiftround                      " use multiple of shiftwidth when indenting with '<' and '>'

" Always show at least one line above/below the cursor
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Indent guides plugin
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" Custom tab options for different languages
" ------------------------------------------

filetype plugin on

filetype indent on

autocmd filetype python             set expandtab shiftwidth=4 tabstop=4
autocmd filetype java               set expandtab shiftwidth=4 tabstop=4
autocmd filetype html               set expandtab shiftwidth=2 tabstop=2
autocmd filetype coffee             set expandtab shiftwidth=2 tabstop=2
autocmd filetype less               set expandtab shiftwidth=2 tabstop=2

" js settings
" ------------
autocmd filetype javascript         set expandtab shiftwidth=2 tabstop=2
au BufNewFile,BufRead *.ejs setlocal syntax=html
au BufNewFile,BufRead .jshintrc setlocal syntax=javascript

" Fallback to eslint when .eslintrc is present
autocmd FileType javascript let b:syntastic_checkers = findfile('.eslintrc', '.;') != '' ? ['eslint'] : ['jshint']


" .md settings
" -------------
autocmd filetype markdown           set expandtab shiftwidth=2 tabstop=2
" set textwidth and reformat when reaching 79 columns
autocmd filetype markdown           set tw=79 formatoptions+=t


" Search
" ------
set showmatch                       " set show matching parenthesis
set ignorecase                      " ignore case when searching
set smartcase                       " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch                        " highlight search terms
set incsearch                       " show search matches as you type

" Misc
" ----

" Use system clipboard by default
set clipboard=unnamed

" set guifont=Inconsolata:h13
set guifont=Consolas:h11

" Ignore files located in project paths
set wildignore=*.swp,*.bak,*.pyc,*.class,node_modules,dist,bower_components,coverage

set history=1000                    " remember more commands and search history
set undolevels=1000                 " use many muchos levels of undo
set title                           " change the terminal's title
set visualbell                      " don't beep
set noerrorbells                    " don't beep
set exrc                            " If .vimrc file found in project directory should override the default

set nobackup
set noswapfile

set hidden

syntax enable

set mouse=a

" pressing down jumps to the next row in the editor (much more natural when wrap is enabled)
nnoremap <Down> gj
nnoremap <Up> gk

" Save buffer when FocusLost (like IntelliJ)
:au FocusLost * silent! wa
:set autowriteall
:set autoread

autocmd QuickFixCmdPost *grep* cwindow

" When saving a .vim or the .vimrc file automagicially source it
autocmd BufWritePost *.vim,.vimrc silent source <sfile>

"set listchars=nbsp:¬,eol:¶,tab:>-,extends:»,precedes:«,trail:•
set listchars=nbsp:¬,tab:>-,extends:»,precedes:«,trail:•
set list

"highlights cursor line
set cursorline
"highlights cursor column
set cursorcolumn

" set number for easier jump
set number

" show status bar
set laststatus=2

" Mac OS X
" --------

" Close tab when Cmd+w
map <D-w> :bdelete

" F1, F2, F3...
" -------------
nmap <silent> <F2><up>              :split<CR><C-W><C-W>
nmap <silent> <F2><down>            :split<CR><C-W><C-W>
nmap <silent> <F2><left>            :vsplit<CR><C-W><C-W>
nmap <silent> <F2><right>           :vsplit<CR><C-W><C-W>

" CtrlP Mapping
" -------------
let g:ctrlp_map = '<leader>t'

colorscheme jellybeans
