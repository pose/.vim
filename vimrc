autocmd!

" This must be first, because it changes other options as side effect
set nocompatible

" Use pathogen to easily modify the runtime path to include all
" plugins under the ~/.vim/bundle directory
call pathogen#helptags()
call pathogen#incubate()

" change the mapleader from \ to ,
let mapleader=","

set list
set expandtab

set tabstop=4     " a tab is four spaces
set backspace=indent,eol,start
                  " allow backspacing over everything in insert mode
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class,node_modules,dist,bower_components
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

set nobackup
set noswapfile

filetype plugin on
autocmd filetype python set expandtab shiftwidth=4 tabstop=4
autocmd filetype javascript set expandtab shiftwidth=4 tabstop=4
autocmd filetype java set expandtab shiftwidth=4 tabstop=4
autocmd filetype html set expandtab shiftwidth=2 tabstop=2
autocmd filetype coffee set expandtab shiftwidth=2 tabstop=2
autocmd filetype less set expandtab shiftwidth=2 tabstop=2
" Adds C-_ key binding to close an open xml tag
autocmd filetype html,xml,xsl source ~/.vim/bundle/closetag/scripts/closetag.vim

set mouse=a

" change the leader :P
nnoremap - :

" If you like long lines with line wrapping enabled, this solves the problem that pressing down jumpes your cursor “over” the current line to the next line. It changes behaviour so that it jumps to the next row in the editor (much more natural):
nnoremap j gj
nnoremap k gk

" Easy window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Tired of useless F1
map <F1> <leader>t
map <F2><up> :split<CR>
map <F2><down> :split<CR>
map <F2><left> :vsplit<CR>
map <F2><right> :vsplit<CR>
map <F3> :TagbarToggle<CR> 
map <F5> :set invfu<CR>
map <F6> :w<CR>:make<CR>
map <F7> :! gitx<CR>

" Meta+1-0 jumps to tab 1-10, Shift+Meta+1-0 jumps to tab 11-20:
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

" Toggle quickfix
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

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <F4> :call ToggleList("Quickfix List", 'c')<CR>
nmap <silent> <D-S-up> <C-W><up>
nmap <silent> <D-S-down> <C-W><down>
nmap <silent> <D-S-left> <C-W><left>
nmap <silent> <D-S-right> <C-W><right>
nmap <silent> <D-F1> :call ChromeDebug()<CR>

" Save buffer when FocusLost (like IntelliJ)
:au FocusLost * silent! wa
:set autowriteall
:set autoread

" Tired of not being compatible with the rest of mac stuff
map <D-w> :q

" Tired of clearing highlighted searches by searching for “ldsfhjkhgakjks”? Use this:
nmap <silent> ,/ :nohlsearch<CR>

set hidden

let g:LustyJugglerSuppressRubyWarning = 1
autocmd QuickFixCmdPost *grep* cwindow

" Brunch build and error format (disabled for now)
" set makeprg=brunch\ build
" set efm=%*[^']'%f'%m.\ (%t%*[^)])\ at\ line\ %l\\,\ column\ %c 

" Call ChrimePing whenever a .js/hbs/less file was saved
"autocmd BufWritePost *.js,*.hbs,*.less,*.coffee,*.html,*.handlebars,*.css,*.json silent call ChromePing()

" When saving a .vim or the .vimrc file automagicially source it
autocmd BufWritePost *.vim,.vimrc silent source <sfile>

" Folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" Solarized
syntax enable
set background=dark
colorscheme solarized

set exrc

let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_guide_size=1

" vim-project plugin
" ------------------
set rtp+=~/.vim/bundle/vim-project/
call project#rc()

let g:project_enable_welcome = 0
