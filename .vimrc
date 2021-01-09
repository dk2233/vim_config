source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim

set directory+=$HOME/tmp

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
set guifont=DejaVu\ Sans\ Mono\ 9
colorscheme desert


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
"Plugin 'Valloric/YouCompleteMe'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
Plugin 'c.vim'
Plugin 'kendling/taghighlight'
Plugin 'git://github.com/xolox/vim-misc'
Plugin 'git://github.com/xolox/vim-shell'
Plugin 'gyim/vim-boxdraw'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
Plugin 'https://github.com/vim-syntastic/syntastic.git'
call vundle#end()            " required

syntax enable
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
autocmd VimENter * Tlist
""nerdtree first
""tlist will be second 
autocmd VimENter * NERDTree
autocmd VimENter * tabnew
autocmd VimENter * tabfirst
let Tlist_Display_Prototype=1
let Tlist_Sort_Type="name"

"C settings
nnoremap C :!gcc -Wall -Wpedantic % -o %:r

autocmd FileType make setlocal noexpandtab
autocmd FileType c setlocal expandtab cindent  
nnoremap <F9> :r !make



""""""""""""""""""""""""""""""""""""""""""""""""""
"Practice
augroup cmm
  au!
  autocmd BufNewFile,BufRead *.cmm   set syntax=practice
augroup END

augroup sx
    au!
    autocmd BufNewFile,BufRead *.sx set syntax=srec
augroup END

augroup dld
    au!
    autocmd BufNewFile,BufRead *.dld set syntax=ld
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""
"cscope
fu! GenCscope()
    cs kill 0
    !cscope -bq
    cs add cscope.out
endfunction

nnoremap rc :call GenCscope()<cr>
"""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
"cscope settings
nmap <unique> <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <unique> <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>


""""""""""""""""""""""""""""""""""""""""""""""""""
"    Rust settings  
augroup Racer
    autocmd!
    autocmd FileType rust nmap <buffer> gd         <Plug>(rust-def)
    autocmd FileType rust nmap <buffer> gs         <Plug>(rust-def-split)
    autocmd FileType rust nmap <buffer> gx         <Plug>(rust-def-vertical)
    autocmd FileType rust nmap <buffer> gt         <Plug>(rust-def-tab)
    autocmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
    autocmd FileType rust nmap <buffer> <leader>gD <Plug>(rust-doc-tab)
augroup END

nnoremap RR : !cargo run
""""""""""""""""""""""""""""""""""""""""""""""""""
"settings syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_rust_checkers = ['cargo']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


autocmd VimENter * tabNext
if has("win32") || has("win16")
    autocmd VimENter * terminal cmd
else
    autocmd VimENter * term bash
endif
autocmd VimENter * tabfirst

