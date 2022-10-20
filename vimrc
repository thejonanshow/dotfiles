:let mapleader = ","
nmap <leader>e :e **/
nmap <leader>v :vsp **/

:autocmd!
map <leader>d :NERDTreeToggle<CR>

autocmd! bufwritepost $MYVIMRC source $MYVIMRC
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'ajh17/Spacegray.vim'
Plug 'beigebrucewayne/Turtles'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-github-dashboard'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'wincent/command-t'
Plug 'Tarrasch/zsh-autoenv'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'universal-ctags/ctags'
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'
call plug#end()

silent! colorscheme spacegray

:let g:webdevicons_conceal_nerdtree_brackets = 1
:let NERDTreeHighlightCursorline = 0

set encoding=UTF-8
set t_Co=256
set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
set backspace=indent,eol,start
set number
set nowrap
set list
set listchars=tab:>-
set wildignore=node_modules/**,.git/**

syntax on
au BufRead /tmp/psql.edit.* set syntax=sql

" YAML settings
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

command! Q  q  " Bind :Q  to :q
command! W  w  " Bind :W  to :w
command! Wq wq " Bind :Wq to :wq
command! WQ wq " Bind :WQ to :wq
command! P set paste
command! NP set nopaste
" command! X  x  " Bind :X to :x

map <leader>rv       :so ~/.vimrc <CR>

set nocompatible
