source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


set encoding=utf8

set colorcolumn=110
highlight ColorColumn ctermbg=darkgray
set tabstop=4
set shiftwidth=4
set number
set linebreak
set nobackup
set cindent
set smartindent
set expandtab

set tags=./tags;/,tags;/
set mouse=a
set hlsearch
set shiftwidth=4


autocmd FileType make setlocal noexpandtab
autocmd FileType c setlocal expandtab cindent  
set exrc
set secure
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=$HOME/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" plugin on GitHub repo
   Plugin 'tpope/vim-fugitive'
   " plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'scrooloose/nerdtree'
" All of your Plugins must be added before the following line
Plugin 'taglist.vim'
Plugin 'CRefVim'
Plugin 'c.vim'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
autocmd VimENter * NERDTree
autocmd VimENter * Tlist
nnoremap <F9> :r !make
autocmd VimENter * tabnew
autocmd VimENter * tabfirst
let Tlist_Display_Prototype=1
colorscheme desert
nnoremap C !gcc -Wall -Wpedantic % -o %:r

