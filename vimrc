" Yann Esposito
" http://yannesposito.com
" @yogsototh
"
" ---------- VERY IMPORTANT -----------
" To install plugin the first time:
" > vim +BundleInstall +qall
" cd ~/.vim/bundle/vimproc.vim && make
" cabal install ghc-mod
" -------------------------------------


call plug#begin('~/.vim/plugged')

" #### set rtp+=~/.vim/vundle/Vundle.vim/
" set rtp+=~/.vim/bundle/vundle/
" ### call vundle#rc()
" the vundle plugin to install vim plugin
" Bundle 'gmarik/vundle'
" completion during typing
Plug 'neocomplcache'
" solarized colorscheme
Plug 'altercation/vim-colors-solarized'
" Right way to handle trailing-whitespace
Plug 'bronson/vim-trailing-whitespace'
" NERDTree
" Plug 'scrooloose/nerdtree'
" Unite
"   depend on vimproc
"   you have to go to .vim/plugin/vimproc.vim and do a ./make
Plug 'Shougo/vimproc.vim'
Plug 'Shougo/unite.vim'
" writing pandoc documents
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
" GIT
Plug 'tpope/vim-fugitive'
" show which line changed using git
Plug 'airblade/vim-gitgutter'
" Align code
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/syntastic'             " syntax checker
" --- Haskell
Plug 'yogsototh/haskell-vim'            " syntax indentation / highlight
Plug 'enomsg/vim-haskellConcealPlus'    " unicode for haskell operators
Plug 'eagletmt/ghcmod-vim'
Plug 'eagletmt/neco-ghc'
Plug 'Twinside/vim-hoogle'
Plug 'pbrisbin/html-template-syntax'    " Yesod templates
" --- XML
Plug 'othree/xml.vim'
" -- Clojure
Plug 'kien/rainbow_parentheses.vim'
Plug 'guns/vim-clojure-static'
Plug 'paredit.vim'
Plug 'tpope/vim-fireplace'
" <<< vim-fireplace dependencie
Plug 'tpope/vim-classpath'

" Plug 'jpalardy/vim-slime'
" -- ag
Plug 'rking/ag.vim'
" --- elm-lang
Plug 'lambdatoast/elm.vim'
" --- Idris
Plug 'idris-hackers/idris-vim'

" -- reload browser on change
Plug 'Bogdanp/browser-connect.vim'

Plug 'maksimr/vim-jsbeautify'
Plug 'einars/js-beautify'

call plug#end()

set nocompatible

" ###################
" ### Plugin conf ###
" ###################

" -------------------
"       Haskell
" -------------------
let mapleader="-"
let g:mapleader="-"
set tm=2000
nmap <silent> <leader>ht :GhcModType<CR>
nmap <silent> <leader>hh :GhcModTypeClear<CR>
nmap <silent> <leader>hT :GhcModTypeInsert<CR>
nmap <silent> <leader>hc :SyntasticCheck ghc_mod<CR>:lopen<CR>
let g:syntastic_mode_map={'mode': 'active', 'passive_filetypes': ['haskell']}
let g:syntastic_always_populate_loc_list = 1
nmap <silent> <leader>hl :SyntasticCheck hlint<CR>:lopen<CR>

" Auto-checking on writing
autocmd BufWritePost *.hs,*.lhs GhcModCheckAndLintAsync

"  neocomplcache (advanced completion)
autocmd BufEnter *.hs,*.lhs let g:neocomplcache_enable_at_startup = 1
function! SetToCabalBuild()
    if glob("*.cabal") != ''
        set makeprg=cabal\ build
    endif
endfunction
autocmd BufEnter *.hs,*.lhs :call SetToCabalBuild()

" -- neco-ghc
let $PATH=$PATH.':'.expand("~/.cabal/bin")

" -- Frege
autocmd BufEnter *.fr :filetype haskell

" ----------------
"       GIT
" ----------------

" -- vim-gitgutter
highlight clear SignColumn
highlight SignColumn ctermbg=0
nmap gn <Plug>GitGutterNextHunk
nmap gN <Plug>GitGutterPrevHunk

" -----------------
"       THEME
" -----------------

" -- solarized theme
set background=dark
try
    colorscheme solarized
catch
endtry

" ----------------------------
"       File Management
" ----------------------------
let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
nnoremap <space>f :split<cr> :<C-u>Unite file<cr>
nnoremap <space>g :split<cr> :<C-u>Unite -start-insert file_rec/git<cr>
" make a grep on all files!
nnoremap <space>/ :split<cr> :<C-u>Unite grep:.<cr>
" see the yank history
nnoremap <space>y :split<cr>:<C-u>Unite history/yank<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)

" ------------------
"       Clojure
" ------------------
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


set visualbell " no beep

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
" -- Reload browser on cljs save
"  don't forget to put <script src="http://localhost:9001/ws"></script>
"  in your HTML
" au BufWritePost *.cljs :BCReloadPage

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

" -- vim-pandoc folding
let g:pandoc#modules#disabled = ["folding"]
