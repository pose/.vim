autocmd!

set nocompatible                    " This must be first, because it changes other options as side effect

" --------
" pathogen
" --------
call pathogen#helptags()
call pathogen#incubate()

" --------------
" Leader options
" --------------
let mapleader=","                   " change the mapleader from \ to ,
" change the leader :P
nnoremap - :

" -------
" Folding
" -------
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" -----------------------
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


" ------------------------------------------
" Custom tab options for different languages
" ------------------------------------------

filetype plugin on
autocmd filetype python             set expandtab shiftwidth=4 tabstop=4
autocmd filetype javascript         set expandtab shiftwidth=2 tabstop=2
autocmd filetype java               set expandtab shiftwidth=4 tabstop=4
autocmd filetype html               set expandtab shiftwidth=2 tabstop=2
autocmd filetype coffee             set expandtab shiftwidth=2 tabstop=2
autocmd filetype less               set expandtab shiftwidth=2 tabstop=2

au BufNewFile,BufRead *.ejs setlocal syntax=html

" ------
" Search
" ------
set showmatch                       " set show matching parenthesis
set ignorecase                      " ignore case when searching
set smartcase                       " ignore case if search pattern is all lowercase, case-sensitive otherwise
set hlsearch                        " highlight search terms
set incsearch                       " show search matches as you type

" ----
" Misc
" ----

set guifont=Inconsolata:h15

" Ignore files located in project paths
set wildignore=*.swp,*.bak,*.pyc,*.class,node_modules,dist,bower_components,coverage

set list
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

" Solarized
set background=dark
colorscheme solarized


" --------
" Mac OS X
" --------

" Close tab when Cmd+w
map <D-w> :q

" Cmd+Number jumps to tabs, Cmd+ShiftNumber jumps to next tabs
let s:windowmapnr = 0
let s:wins='1234567890!@#$%^&*()'
while (s:windowmapnr < strlen(s:wins))
    exe 'noremap <silent> <D-' . s:wins[s:windowmapnr] . '> ' . (s:windowmapnr + 1) . 'gt'
    exe 'inoremap <silent> <D-' . s:wins[s:windowmapnr] . '> <C-O>' . (s:windowmapnr + 1) . 'gt'
    exe 'cnoremap <silent> <D-' . s:wins[s:windowmapnr] . '> <C-C>' . (s:windowmapnr + 1) . 'gt'
    exe 'vnoremap <silent> <D-' . s:wins[s:windowmapnr] . '> <C-C>' . (s:windowmapnr + 1) . 'gt'
    let s:windowmapnr += 1
endwhile
unlet s:windowmapnr s:wins

" -----------------------
" Toggle quickfix with F4
" -----------------------
function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l             :call ToggleList("Location List", 'l')<CR>
nmap <silent> <D-S-up>              <C-W><up>
nmap <silent> <D-S-down>            <C-W><down>
nmap <silent> <D-S-left>            <C-W><left>
nmap <silent> <D-S-right>           <C-W><right>

" -------------------------------------
" Function keys mapping (F1, F2, F3...)
" -------------------------------------
nmap <silent> <F1>                  <leader>t
nmap <silent> <F2><up>              :split<CR>
nmap <silent> <F2><down>            :split<CR>
nmap <silent> <F2><left>            :vsplit<CR>
nmap <silent> <F2><right>           :vsplit<CR>
nmap <silent> <F3>                  :TagbarToggle<CR>
nmap <silent> <F4>                  :call ToggleList("Quickfix List", 'c')<CR>
nmap <silent> <F5>                  :set invfu<CR>
nmap <silent> <F6>                  :w<CR>:make<CR>
nmap <silent> <F7>                  :! gitx<CR>

" -------------
" CtrlP Mapping
" -------------
let g:ctrlp_map = '<leader>t'

" ------------------
" vim-project plugin
" ------------------
set rtp+=~/.vim/bundle/vim-project/
let g:project_enable_welcome = 0
let g:project_disable_tab_title = 1
call project#rc()


Project '~/Documents/javascript-editor'
Project '~/Documents/suggest'

