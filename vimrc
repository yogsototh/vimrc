" Yann Esposito
" http://yannesposito.com
" @yogsototh
"
" --- Plugins ---
" To install plugin the first time:
" > vim +BundleInstall +qall
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
" writing pandoc documents
Bundle 'vim-pandoc/vim-pandoc'
" show which line changed using git
Bundle 'airblade/vim-gitgutter' 
" Haskell mode
Bundle 'lukerandall/haskellmode-vim'
" neocomplcache plugin for Haskell
" IMPORTANT you need to 'cabal install ghc-mod'
Bundle 'ujihisa/neco-ghc'   
" Yesod templates
Bundle 'pbrisbin/html-template-syntax'
filetype on


" ###################
" ### Plugin conf ###
" ###################

" -- vim-gitgutter
highlight clear SignColumn

" NERDTree
let NERDTreeIgnore=['\.o$','\~$','\.hi$']

"  neocomplcache (advanced completion)
let g:neocomplcache_enable_at_startup = 1

" -- Haskell
au Bufenter *.hs compiler ghc
au Bufenter *.lhs compiler ghc
let g:haddock_browser="/usr/bin/firefox"

" -- vim-gitgutter
highlight clear SignColumn

" -- show the column 81
if (exists('+colorcolumn'))
    highlight ColorColumn ctermbg=7
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
let g:necoghc_enable_detailed_browse=1
let $PATH=$PATH.':'.expand("~/.cabal/bin")

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
