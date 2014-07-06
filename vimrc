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
set shell=/bin/sh
set nocompatible
set rtp+=~/.vim/vundle/vundleinit/
" set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
" the vundle plugin to install vim plugin
" Bundle 'gmarik/vundle'
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
" GIT
Bundle 'tpope/vim-fugitive'
" show which line changed using git
Bundle 'airblade/vim-gitgutter'
" Align code
Bundle 'junegunn/vim-easy-align'
" --- Haskell
Bundle 'zenzike/vim-haskell'
Bundle 'dan-t/vim-hsimport'
" Bundle 'haskell.vim'
Bundle 'kana/vim-filetype-haskell'
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
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'guns/vim-clojure-static'
Bundle 'paredit.vim'
Bundle 'tpope/vim-fireplace'
" <<< vim-fireplace dependencie
Bundle 'tpope/vim-classpath'

" Bundle 'jpalardy/vim-slime'
" -- ag
Bundle "rking/ag.vim"
" --- elm-lang
Bundle 'lambdatoast/elm.vim'
" --- Idris
Bundle 'idris-hackers/idris-vim'

" -- reload browser on change
Bundle 'Bogdanp/browser-connect.vim'

Bundle 'maksimr/vim-jsbeautify'
Bundle 'einars/js-beautify'

filetype on

" ###################
" ### Plugin conf ###
" ###################

" NERDTree
" let NERDTreeIgnore=['\.o$','\~$','\.hi$']

" -- Haskell
au Bufenter *.hs,*.lhs compiler ghc
let g:haddock_browser="/usr/bin/firefox"

"  neocomplcache (advanced completion)
autocmd BufEnter *.hs,*.lhs let g:neocomplcache_enable_at_startup = 1
function! SetToCabalBuild()
    if glob("*.cabal") != ''
        set makeprg=cabal\ build
    endif
endfunction
autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()


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

" -- solarized theme
set background=dark
try
    colorscheme solarized
catch
endtry

" -- neco-ghc
" let g:necoghc_enable_detailed_browse=1
let $PATH=$PATH.':'.expand("~/.cabal/bin")

" -- Unite
let g:unite_source_history_yank_enable = 1
try
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
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

" .ymd file type
autocmd BufEnter *.ymd set filetype=markdown
autocmd BufEnter *.cljs,*.cljs.hl set filetype=clojure
autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesActivate
autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadRound
autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadSquare
autocmd BufEnter *.cljs,*.clj,*.cljs.hl RainbowParenthesesLoadBraces
" Fix I don't know why
autocmd BufEnter *.cljs,*.clj,*.cljs.hl setlocal iskeyword+=?,-,*,!,+,/,=,<,>,.,:
" -- Rainbow parenthesis options
let g:rbpt_colorpairs = [
	\ ['darkyellow',  'RoyalBlue3'],
	\ ['darkgreen',   'SeaGreen3'],
	\ ['darkcyan',    'DarkOrchid3'],
	\ ['Darkblue',    'firebrick3'],
	\ ['DarkMagenta', 'RoyalBlue3'],
	\ ['darkred',     'SeaGreen3'],
	\ ['darkyellow',  'DarkOrchid3'],
	\ ['darkgreen',   'firebrick3'],
	\ ['darkcyan',    'RoyalBlue3'],
	\ ['Darkblue',    'SeaGreen3'],
	\ ['DarkMagenta', 'DarkOrchid3'],
	\ ['Darkblue',    'firebrick3'],
	\ ['darkcyan',    'SeaGreen3'],
	\ ['darkgreen',   'RoyalBlue3'],
	\ ['darkyellow',  'DarkOrchid3'],
	\ ['darkred',     'firebrick3'],
	\ ]
" -- Reload browser on cljs save
"  don't forget to put <script src="http://localhost:9001/ws"></script>
"  in your HTML
au BufWritePost *.cljs :BCReloadPage
au BufWritePost *.cljs.hl :BCReloadPage

" ========
" Personal
" ========

" Easier anti-quote
imap éé `

" -- show the column 81
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" --- type ° to search the word in all files in the current dir
nmap ° :Ag <c-r>=expand("<cword>")<cr><cr>

" -- js beautifer
autocmd FileType javascript noremap <buffer> <c-f> :call JsBeautify()<cr>
autocmd FileType html noremap <buffer> <c-f> :call JsBeautify()<cr>
autocmd FileType css noremap <buffer> <c-f> :call JsBeautify()<cr>

" set noswapfile
