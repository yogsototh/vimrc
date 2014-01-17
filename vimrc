" Yann Esposito
" http://yannesposito.com
" @yogsototh
"
" --- Plugins ---
" To install plugin the first time:
" > vim +BundleInstall +qall
" cd ~/.vim/bundle/vimproc.vim && make
" cabal install ghc-mod
" -----------
filetype off
set rtp+=~/.vim/vundle/vundleinit/
call vundle#rc()
" the vundle plugin to install vim plugin
Bundle 'gmarik/vundle'
" completion during typing
Bundle 'neocomplcache'
" solarized colorscheme
Bundle 'altercation/vim-colors-solarized'
" Right way to handle trailing-whitespace
Bundle 'bronson/vim-trailing-whitespace'
" NERDTree
" Bundle 'scrooloose/nerdtree'
" Unite
"   depend on vimproc
"   you have to go to .vim/plugin/vimproc.vim and do a ./make
Bundle 'Shougo/vimproc.vim'
Bundle 'Shougo/unite.vim'
" writing pandoc documents
Bundle 'vim-pandoc/vim-pandoc'
" show which line changed using git
Bundle 'airblade/vim-gitgutter'
" Align code
Bundle 'junegunn/vim-easy-align'
" --- Haskell
Bundle 'zenzike/vim-haskell'
Bundle 'dan-t/vim-hsimport'
" Bundle 'haskell.vim'
" Haskell mode
Bundle 'lukerandall/haskellmode-vim'
" neocomplcache plugin for Haskell
" IMPORTANT you need to 'cabal install ghc-mod'
Bundle 'ujihisa/neco-ghc'
" Yesod templates
Bundle 'pbrisbin/html-template-syntax'
" --- XML
Bundle 'othree/xml.vim'
" -- Clojure
Bundle 'yogsototh/rainbow_parentheses.vim'
Bundle 'guns/vim-clojure-static'
" Bundle 'jpalardy/vim-slime'
" -- ag
Bundle "rking/ag.vim"

filetype on

" ###################
" ### Plugin conf ###
" ###################

" NERDTree
" let NERDTreeIgnore=['\.o$','\~$','\.hi$']

"  neocomplcache (advanced completion)
autocmd BufEnter *.hs,*.lhs let g:neocomplcache_enable_at_startup = 1

" -- Haskell
au Bufenter *.hs,*.lhs compiler ghc
let g:haddock_browser="/usr/bin/firefox"

" -- vim-gitgutter
highlight clear SignColumn
highlight SignColumn ctermbg=0
nmap gn <Plug>GitGutterNextHunk
nmap gN <Plug>GitGutterPrevHunk
" GitGutterLineHighlightsEnable
" highlight GitGutterAddLine ctermbg=0
" highlight GitGutterChangeLine ctermbg=0
" highlight GitGutterDeleteLine ctermbg=0
" highlight GitGutterChangeDeleteLine ctermbg=0

" -- show the column 81
if (exists('+colorcolumn'))
    highlight ColorColumn ctermbg=0
    set colorcolumn=80
endif

" -- solarized theme
set background=light
" My terminal handle solarized theme correctly
" so solarized only for GUI
if has('gui_running')
   " color theme solarized both on gui and standard
   colorscheme solarized
endif

" -- neco-ghc
" let g:necoghc_enable_detailed_browse=1
let $PATH=$PATH.':'.expand("~/.cabal/bin")

" -- Unite
let g:unite_source_history_yank_enable = 1
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" search a file in the filetree
nnoremap <space><space> :split<cr> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed file_rec buffer bookmark<cr><c-u>a
au BufEnter *.lhs,*hs nmap <space><space> :split<cr> :<C-u>Unite -toggle -auto-resize -buffer-name=mixed -input=!.cabal*\ !dist/\ !*.hi\  file_rec buffer bookmark<cr><c-u>a
nnoremap <space>f :split<cr> :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<cr>
nnoremap <space>b :split<cr> :<C-u>Unite -no-split -buffer-name=files   -start-insert buffer<cr>
" make a grep on all files!
nnoremap <space>/ :split<cr> :<C-u>Unite grep:.<cr>
" see the yank history
nnoremap <space>y :split<cr>:<C-u>Unite history/yank<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)

" #####################
" ### Personal conf ###
" #####################

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set bs=2		        " allow backspacing over everything in insert mode
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
			            " than 50 lines of registers
set history=10000	    " keep 100000 lines of command line history
set ruler		        " show the cursor position all the time

syntax on " syntax highlighting
set hlsearch " highlight searches


" move between splits
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" -- sudo save
cmap w!! w !sudo tee >/dev/null %

" Tabulation management
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent
set cinoptions=(0,u0,U0

" Spellchecking
if has("spell") " if vim support spell checking
    " Download dictionaries automatically
    if !filewritable($HOME."/.vim/spell")
        call mkdir($HOME."/.vim/spell","p")
    endif
    set spellsuggest=10 " z= will show suggestions (10 at most)
    " spell checking for text, HTML, LaTeX, markdown and literate Haskell
    autocmd BufEnter *.txt,*.tex,*.html,*.md,*.ymd,*.lhs setlocal spell
    autocmd BufEnter *.txt,*.tex,*.html,*.md,*.ymd,*.lhs setlocal spelllang=fr,en
    " better error highlighting with solarized
    highlight clear SpellBad
    highlight SpellBad term=standout ctermfg=2 term=underline cterm=underline
    highlight clear SpellCap
    highlight SpellCap term=underline cterm=underline
    highlight clear SpellRare
    highlight SpellRare term=underline cterm=underline
    highlight clear SpellLocal
    highlight SpellLocal term=underline cterm=underline
endif

" Easy align interactive
vnoremap <silent> <Enter> :EasyAlign<cr>

" ========
" Personal
" ========

" .ymd file type
autocmd BufEnter *.ymd set filetype=markdown
autocmd BufEnter *.cljs set filetype=clojure
autocmd BufEnter *.cljs,*.clj RainbowParenthesesActivate
autocmd BufEnter *.cljs,*.clj RainbowParenthesesLoadRound
autocmd BufEnter *.cljs,*.clj RainbowParenthesesLoadSquare
autocmd BufEnter *.cljs,*.clj RainbowParenthesesLoadBraces
autocmd BufEnter *.cljs,*.clj inoremap {   {}<Left>
autocmd BufEnter *.cljs,*.clj inoremap (   ()<Left>
autocmd BufEnter *.cljs,*.clj inoremap [   []<Left>
autocmd BufEnter *.cljs,*.clj inoremap "   ""<Left>
autocmd BufEnter *.cljs,*.clj setlocal iskeyword+=?,-,*,!,+,/,=,<,>,.,:

" Easier anti-quote
imap éé `

