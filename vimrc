:let mapleader = ","
nmap <leader>e :e **/
nmap <leader>v :vsp **/
:autocmd!
map <leader>d :NERDTreeToggle<CR>

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-github-dashboard'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'beigebrucewayne/Turtles'
Plug 'rking/ag.vim'
Plug 'vim-airline/vim-airline'
Plug 'ajh17/Spacegray.vim'
Plug 'wincent/command-t'

call plug#end()

colorscheme spacegray

set tabstop=4 softtabstop=0 expandtab shiftwidth=2 smarttab
set backspace=indent,eol,start
set number
set nowrap
imap <esc>           <esc>:w<CR>

command! Q  q  " Bind :Q  to :q
command! W  w  " Bind :W  to :w
command! Wq wq " Bind :Wq to :wq
command! WQ wq " Bind :WQ to :wq
" command! X  x  " Bind :X to :x

map <leader>rv       :so ~/.vimrc <CR>

autocmd vimenter * NERDTree
set nocompatible
