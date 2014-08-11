" Fish Shell Integration (needs to go first) -----------------------------{{{
if &shell =~# 'fish$'
    set shell=sh
endif
" }}}

" NeoBundle Scripts {{{
" NeoBundle Init {{{
if has('vim_starting')
  set nocompatible               " Be iMproved
  set runtimepath+=/Users/julz/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('/Users/julz/.vim/bundle'))
NeoBundleFetch 'Shougo/neobundle.vim'
" }}}
" Colorschemes {{{
NeoBundle 'tomasr/molokai'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'endel/vim-github-colorscheme'
NeoBundle 'quanganhdo/grb256'
NeoBundle 'rking/vim-detailed'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jgdavey/vim-railscasts'
let g:solarized_termcolors=256
"}}}
" Plugins {{{
NeoBundle 'davidoc/taskpaper.vim'
NeoBundle 'vim-scripts/SyntaxRange'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-sensible'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-eunuch'
NeoBundle 'christoomey/vim-tmux-navigator'
NeoBundle 'ervandew/supertab'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'tpope/vim-endwise'
autocmd FileType go let b:dispatch = 'ginkgo %'
nnoremap <F9> :! rspec --color %<CR>
nnoremap <F10> :Focus bundle exec rspec %<CR>
nnoremap <F12> :Dispatch<CR>
NeoBundle 'scrooloose/syntastic'
let g:syntastic_always_populate_loc_list = 1
NeoBundle 'tpope/vim-surround'
NeoBundle 'rking/ag.vim'
NeoBundle 'tpope/vim-unimpaired'
NeoBundle 'Shougo/vimfiler.vim'
NeoBundle 'fatih/vim-go'
:let g:vimfiler_as_default_explorer = 1
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'windows' : 'tools\\update-dll-mingw',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make -f make_mac.mak',
			\     'unix' : 'make -f make_unix.mak',
			\    },
			\ }
NeoBundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
NeoBundle 'gregsexton/gitv'
NeoBundle 'bling/vim-airline'
"NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'AndrewRadev/splitjoin.vim'
let g:tmuxline_powerline_separators = 0

call neobundle#end()

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
filetype plugin indent on
NeoBundleCheck
" }}}
" }}}

" General Settings {{{
set backspace=indent,eol,start " let the backspace key work "normally"
set hidden " hide unsaved buffers
set incsearch " incremental search rules
set laststatus=2 " not strictly necessary but good for consistency
set tags=./tags;/,tags;/ " search tags files efficiently
set wildmenu " better command line completion, shows a list of matches
nnoremap gb :buffers<CR>:sb<Space> " Buffer navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
set background=dark " Tell Vim to use dark background
set history=10000 " Sets how many lines of history vim has to remember
set autoread " Set to auto read when a file is changed from the outside

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" listchar=trail is not as flexible, use the below to highlight trailing
" whitespace. Don't do it for unite windows or readonly files
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
augroup MyAutoCmd
  autocmd BufWinEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
  autocmd InsertEnter * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
  autocmd InsertLeave * if &modifiable && &ft!='unite' | match ExtraWhitespace /\s\+$/ | endif
  autocmd BufWinLeave * if &modifiable && &ft!='unite' | call clearmatches() | endif
augroup END

set scrolloff=10 " Minimal number of screen lines to keep above and below the cursor
set scrolljump=3 " How many lines to scroll at a time, make scrolling appears faster
set relativenumber
set numberwidth=1 " Min width of the number column to the left
set ruler
syntax on

" Reload vimrc when edited
autocmd MyAutoCmd BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc
      \ so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif

" Cursor settings. This makes terminal vim sooo much nicer!
" Tmux will only forward escape sequences to the terminal if surrounded by a DCS
" sequence
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Ctrl-Space: Show history
cnoremap <c-@> <c-f>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-f> <left>
cnoremap <c-g> <right>

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Leader is space
nmap <space> <leader>

" Colour scheme (default)
let g:rehash256 = 1


nmap <F8> :TagbarToggle<CR>

try
  source ~/.vimrc.local
catch
endtry

let g:airline_powerline_fonts = 1
let g:airline_theme = "sol"
let g:tmuxline_theme = "lightline_visual"
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" Vim clipboard = system clipboard
set clipboard=unnamed
