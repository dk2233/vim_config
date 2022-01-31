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
    "echo "gui is started"
    if has("win32") || has("win16")

    set guifont=Lucida_Console:h10:cEASTEUROPE:qDRAFT
    "set guifont=Arial_monospaced_for_SAP:h10:cEASTEUROPE:qDRAFT
else
    set guifont=Ubuntu\ Mono\ 12 
endif
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

        nnoremap <C-v> :normal "+gP<CR>
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


function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
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
"
"---------------------------------------------------
"some General settings
"---------------------------------------------------
set rtp+=$HOME\.vim\after
"this is to add Vundle!
set rtp+=$HOME/.vim/bundle/Vundle.vim
set directory+=$HOME/tmp
set encoding=utf8

set colorcolumn=110
"highlight ColorColumn ctermbg=darkgray
set tabstop=4
set shiftwidth=4
set number             "this is for line number enabling
set linebreak
set nobackup
set nowritebackup
set cindent
set smartindent
set expandtab
set tags=./tags;/,tags;/
set mouse=a
set hlsearch
set shiftwidth=4
set cmdheight=3
set shortmess+=c
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

if g:is_gui_here==1

    colorscheme termschool 
else
    colorscheme atom
endif 
"deus
"carbonized-dark
"blue
"
set relativenumber    "this shows line number relative to curent line

set exrc
set secure
set nocompatible              " be iMproved, required
filetype off                  " required

let mapLeader = "\\" 

syntax enable
filetype plugin indent on    " required
" set the runtime path to include Vundle and initialize
call vundle#begin()

"---------------------------------------------------
"Plugins 
"---------------------------------------------------
"{{{
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'scrooloose/nerdtree'
" All of your Plugins must be added before the following line
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'taglist.vim'
Plugin 'CRefVim'
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/fzf'
Plugin 'c.vim'
Plugin 'gyim/vim-boxdraw'
Plugin 'rust-lang/rust.vim'
Plugin 'racer-rust/vim-racer'
"Plugin 'https://github.com/vim-syntastic/syntastic.git'
Plugin 'DrawIt'
Plugin 'git://github.com/rafi/awesome-vim-colorschemes'
Plugin 'neoclide/coc.nvim'

call vundle#end()            " required

" To ignore plugin indent changes, instead use:
filetype plugin on
"
"if I will need to automatically start Tlist then uncomment below line
"autocmd VimENter * Tlist
""tlist will be second 
augroup vim_start
    if &diff == 0
        "I do not want Nerd to be started automatically
        "autocmd VimENter * NERDTree
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
    iab tc333 make TC333_BoschCG90x_SMI8_Vector
    iab tc364 make TC334_BoschCG90x_Dual_SMI8_Vector
    "C settings
    nnoremap C :!gcc -Wall -Wpedantic % -o %:r

    nnoremap <F9> :r !make

augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""
"Practice files - Trace32 scripts
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
"cscope update database
nnoremap rc :call GenCscope()<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""
"cscope settings
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <Leader>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nmap <C-\>a :cs find a <C-R>=expand("<cword>")<CR><CR>
"autocmd FileType c set omnifunc=ccomplete#Complete

""""""""""""""""""""""""""""""""""""""""""""""""""
"    Rust settings  
"---------------------------------------------------"
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

"set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=\ 


augroup xml
    autocmd!
    autocmd FileType xml nnoremap rf :%s/<FLAG .*">//g<CR>
    autocmd FileType xml nnoremap rF :%s/<\/\a*>//g<CR>
augroup END


"plugin Syntastic
"
"
"
"
"let g:syntastic_check_on_open = 1
"
"
"Rust
"let g:syntastic_rust_checkers = ['cargo']
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_mode_map = {
"            \ "mode": "active",
"            \ "active_filetypes": ["rust", "h"],
"            \ "passive_filetypes": ["python" ] }
" C C++
"let g:syntastic_c_no_default_include_dirs = 1
"let g:syntastic_c_check_header = 1
"let g:syntastic_c_no_include_search = 1
"let g:syntastic_c_compiler='gcc'
"let g:syntastic_c_checkers=['gcc', 'clang_check','gcc']
"let g:syntastic_c_checker='gcc'

"let g:syntastic_c_checker='gcc'
"let g:syntastic_c_compiler_options="-Wall -std=c99"
"let g:syntastic_c_config_file='.syntastic_c_config'
"let g:syntastic_disabled_filetypes = ['c']

"---------------------------------------------------"
"Create additional tab
autocmd VimENter * tabNext
if g:is_this_windows == 1
    "has("win32") || has("win16")
    "echo "I am started on Windows env"
else
    "echo "I am on linux or Robot"
endif

if g:is_gui_here == 1  && &diff==0 
    " only on GUI I am staring command line
    "echom "Starting Cmd"
    if g:is_this_windows==1
        autocmd VimENter * terminal cmd 
    else
        autocmd VimENter * terminal        
    endif

endif
autocmd VimENter * tabfirst


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

"---------------------------------------------------
"Plugin NerdTree
"---------------------------------------------------"
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


    :nnoremap <Leader>tn :tabnew<CR>
    :nnoremap <Leader>b :buffers<CR>

augroup END

"onoremap " i"
"echo "Hi >^.^<"

autocmd VimENter * tabfirst
"---------------------------------------------------
"this will make backup and ~swap file to be created in one .vim folder 
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//









"---------------------------------------------------
" COC nvim settings
"---------------------------------------------------
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-space> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"



" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end



" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>

" coc-git
nnoremap <silent> gc :CocCommand git.chunkInfo<CR>
"nmap <C-\>g <Plug>
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
