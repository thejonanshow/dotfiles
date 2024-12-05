:let mapleader = ","
nmap <leader>e :e **/
nmap <leader>v :vsp **/

set encoding=UTF-8
set t_Co=256
set autoindent tabstop=2 softtabstop=2 expandtab shiftwidth=2
set backspace=indent,eol,start
set number
set nowrap
set list
set listchars=tab:>-
set wildignore=node_modules/**,.git/**
set sessionoptions-=blank

:autocmd!
map <silent><leader>d :NERDTreeToggle<CR>

autocmd! bufwritepost $MYVIMRC source $MYVIMRC
au BufNewFile,BufRead *.go setlocal noet ts=4 sw=4 sts=4

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'hhff/SpacegrayEighties.vim'
Plug 'beigebrucewayne/Turtles'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-github-dashboard'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'Tarrasch/zsh-autoenv'
Plug 'ryanoasis/vim-devicons'
" changed from tiagofumo to johnstef99 to prevent 'E5248: Invalid character in
" group name' warnings in neovim
Plug 'johnstef99/vim-nerdtree-syntax-highlight'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'universal-ctags/ctags'
Plug 'sheerun/vim-polyglot'
Plug 'hashrocket/vim-macdown'
Plug 'prabirshrestha/vim-lsp'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

if !has('nvim')
  Plug 'rhysd/vim-healthcheck'
endif

if executable("rg")
  set grepprg=rg\ --vimgrep
endif

" 'on' empty defers loading of plugins: https://github.com/junegunn/vim-plug/wiki/tips#conditional-activation
" Plug 'Valloric/YouCompleteMe', { 'on': [] } " run ~/.vim/plugged/YouCompleteMe/install.py to recompile

Plug 'ryanoasis/vim-devicons' " leave this at the end
call plug#end()

silent! colorscheme SpaceGrayEighties
map <leader>f :FZF<CR>

:let g:webdevicons_conceal_nerdtree_brackets = 1
:let NERDTreeHighlightCursorline = 0
:let $FZF_DEFAULT_COMMAND = 'rg --files --color=never --glob "!.git/*"'

syntax on
au BufRead /tmp/psql.edit.* set syntax=sql

" YAML settings
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" MacDown settings
" execute commands on filetype save
autocmd BufWritePost *.md :MacDownPreview
" Enable closing MacDown when ':q' closes the current file, but doesn't
" exit vim from vim-macdown plugin
autocmd BufWinLeave *.md :MacDownClose
" Enable closing MacDown when ':q' exits vim from vim-macdown plugin
autocmd VimLeavePre *.md :MacDownExit

" Setup rust-analyzer
if executable('rust-analyzer')
  au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'cmd': {server_info->['rust-analyzer']},
        \   'whitelist': ['rust'],
        \   'initialization_options': {
        \     'cargo': {
        \       'buildScripts': {
        \         'enable': v:true,
        \       },
        \     },
        \     'procMacro': {
        \       'enable': v:true,
        \     },
        \   },
        \ })
endif

fun! s:ycm()
  call plug#load('YouCompleteMe')
endfun
command Y call s:ycm()

command! Q  q  " Bind :Q  to :q
command! W  w  " Bind :W  to :w
command! Wq wq " Bind :Wq to :wq
command! WQ wq " Bind :WQ to :wq
command! P set paste
command! NP set nopaste
" command! X  x  " Bind :X to :x

let @d = "orequire 'pry-byebug'; binding.pry:w"

map <leader>rv       :so ~/.vimrc <CR>

set nocompatible
