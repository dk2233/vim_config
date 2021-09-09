"---------------------------------------------------------------------------------
let g:is_this_windows = 0
let g:is_gui_here = 0
let g:line_border_length = 50
"---------------------------------------------------------------------------------
"|  ++  +--+     +-----+         +-------------------+
"|  ||  |  |     |     |         |                   |
"|  ||  |  |     |     |         | Functions.......  |
"|--++--+  +-----+     +---------+                   |
"+---------------------------------------------------+
"{{{
function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

function! GuiWasStarted()
    " set global variable if gui was started
    let g:is_gui_here = 1
    echom "gui is started"
"set guifont=Lucida_Console:h10:cEASTEUROPE:qDRAFT
set guifont=Arial_monospaced_for_SAP:h10:cEASTEUROPE:qDRAFT
endfunction

function! WinOrNoWin()
    if has("win32") || has("win16")
        " is this on windows VIM
        " {{{
        source $VIMRUNTIME/vimrc_example.vim
        source $VIMRUNTIME/mswin.vim

        set pythondll=c:\sw_tools\Python-2.7.17x64\App\Python\python27.dll

        "set pythonthreedll=c:\TESTUS\python\python-3.6.6.amd64\python36.dll 
        let g:is_this_windows = 1
    else 
        "this is for not windows
    endif
    "}}}
endfu

fu! GenCscope()
    cs kill 0
    !cscope -bq
    cs add cscope.out
endfunction

fu! DrawCommentline(size)
    exe "normal! i\"\<esc>"
    exe "normal! a\-\<esc>"
"    echo a:size
    exe "normal! ".a:size."\.\$\<cr>"
endfunction
"--------------------------------------------------{{{
"----------------------------------------------------------------------------------
"<esc"<esc>>
"---------------------------------------------------------------------------------
call WinOrNoWin()


" this is run too late and not function properly
augroup gui_settings
    "autocmd GUIEnter * call GuiWasStarted()  
    if has("gui_running")
        call GuiWasStarted()
    endif
augroup END


set rtp+=$HOME\.vim\after
"this is to add Vundle!
set rtp+=$HOME/.vim/bundle/Vundle.vim

set directory+=$HOME/tmp
set encoding=utf8

set colorcolumn=110
"highlight ColorColumn ctermbg=darkgray
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
if g:is_gui_here==1

    colorscheme termschool 
else
    colorscheme atom
endif 
"deus
"carbonized-dark
"blue
"
set relativenumber


set exrc
set secure
set nocompatible              " be iMproved, required
filetype off                  " required

let mapLeader = "\\" 

syntax enable
filetype plugin indent on    " required
" set the runtime path to include Vundle and initialize
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
"Plugin 'Valloric/YouCompleteMe'
Plugin 'taglist.vim'
Plugin 'CRefVim'
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
Plugin 'DrawIt'
Plugin 'git://github.com/rafi/awesome-vim-colorschemes'
"Plugin 'VFT--VIM-Form-Toolkit'
"Plugin 'marcweber/vim-addon-manager'
"Plugin 'luchermitte/lh-cpp'
"Plugin 'LucHermitte/lh-vim-lib'
"Plugin 'LucHermitte/lh-brackets'
"Plugin 'LucHermitte/lh-tags'
"Plugin 'LucHermitte/lh-dev'
"Plugin 'LucHermitte/lh-style'
"Bundle 'LucHermitte/searchInRuntime'
"Bundle 'LucHermitte/mu-template'
"Bundle 'tomtom/stakeholders_vim'
"Bundle 'LucHermitte/alternate-lite'
"Plugin 'LucHermitte/vim-refactor'
"Plugin 'apalmer1377/factorus'
call vundle#end()            " required

" To ignore plugin indent changes, instead use:
filetype plugin on
"autocmd VimENter * Tlist
""nerdtree first
""tlist will be second 
augroup vim_start
    if &diff == 0
        autocmd VimENter * NERDTree
    endif
    autocmd VimENter * tabnew
    autocmd VimENter * tabnew
    autocmd VimENter * tabfirst
augroup END
let Tlist_Display_Prototype=1
let Tlist_Sort_Type="name"

augroup c,h
    autocmd FileType make setlocal noexpandtab
    autocmd FileType *.c setlocal expandtab cindent  
    autocmd FileType *.h setlocal expandtab cindent  
    iab <buffer> #i #include
    iab <buffer> #d #define
    iab tc334 make TC334_BoschCG90x_Dual_SMI8_Vector
    iab tc364 make TC334_BoschCG90x_Dual_SMI8_Vector
    "C settings
    nnoremap C :!gcc -Wall -Wpedantic % -o %:r

    nnoremap <F9> :r !make

augroup END

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

nnoremap rc :call GenCscope()<cr>
"""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
"cscope settings
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>
autocmd FileType c set omnifunc=ccomplete#Complete

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
"set statusline+=\ %#warningmsg#
"set statusline+=%*
set statusline=
set statusline+=%#PmenuSel#
"set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=\ \|Lines:[%L]
set statusline+=\|Bu:[%n] 
"set statusline+=%=
"set statusline+=\
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c

set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=\ 





"plugin Syntastic
"
"
"
"
"let g:syntastic_check_on_open = 1
"
"
"Rust
let g:syntastic_rust_checkers = ['cargo']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {
            \ "mode": "active",
            \ "active_filetypes": ["rust", "h"],
            \ "passive_filetypes": ["python" ] }
" C C++
let g:syntastic_c_no_default_include_dirs = 1
let g:syntastic_c_check_header = 1
"let g:syntastic_c_no_include_search = 1
let g:syntastic_c_compiler='gcc'
let g:syntastic_c_checkers=['gcc']
"['clang_check','gcc']
let g:syntastic_c_checker='gcc'
"let g:syntastic_c_compiler_options="-Wall -std=c99"
let g:syntastic_c_config_file='.syntastic_c_config'
"let g:syntastic_disabled_filetypes = ['c']


autocmd VimENter * tabNext
if g:is_this_windows == 1
    "has("win32") || has("win16")
    echom "I am started on Windows env"
else
    echom "I am on linux or Robot"
"    autocmd VimENter * term bash
endif

if g:is_gui_here == 1
    " only on GUI I am staring command line
    echom "Starting Cmd"
    if g:is_this_windows==1
        autocmd VimENter * terminal cmd 
    else
        autocmd VimENter * term bash       
    endif

endif
autocmd VimENter * tabfirst



" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")


" settings for FZF
let g:fzf_command_prefix = 'Fzf'
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

let g:fzf_layout = { 'down': '40%' }

set grepprg=rg\ --vimgrep\ --smart-case\ --follow
inoremap <expr> <c-x><c-l> fzf#vim#complete(fzf#wrap({
  \ 'prefix': '^.*$',
  \ 'source': 'rg -n ^ --color always',
  \ 'options': '--ansi --delimiter : --nth 3..',
  \ 'reducer': { lines -> join(split(lines[0], ':\zs')[2:], '') }}))


"Plugin NerdTree
ca nerdr NERDTreeRefresh
nnoremap nR :NERDTreeRefresh<CR>
nnoremap <Leader>nn :NERDTree<cr><c-w>l
"this will not work with nnoremap
"nnoremap il :exe "normal! i\-\<esc>80\."
"this is better (not best) version:
"nnoremap il :exe "normal! i\"\-"<esc>:exec "normal! 80\.\$"<cr>
"---------------------------------------------------------------------------------

nnoremap iL :call DrawCommentline(g:line_border_length)<cr> 
"---------------------------------------------------
augroup general
    ca xxd1 %!xxd -ps -c 1024 
    ca ct  :!ctags -R -L cscope.files<CR> 
    nnoremap dfp :diffput<CR>
    nnoremap dfg :diffget<CR>
    "this is to distinguish that we are in vim diff mode
    "and to enable additional keyboard mapping
    if &diff

        map dg :diffget<CR>
        map dp :diffput<CR>
        map dn ]c
    endif 
augroup END

onoremap " i"
echo "Hi >^.^<"

autocmd VimENter * tabfirst
