> This project has two homes.
> It is ok to work in github, still, for a better decentralized web
> please consider contributing (issues, PR, etc...) throught:
>
> https://gitlab.esy.fun/yogsototh/vimrc

---


This is my vim configuration. I cleaned it up most of the stuff.

The `vimrc` file should be easy to understand and contains almost everything.

# Install

        git clone https://gitlab.esy.fun/yogsototh/vimrc.git .vim
        ln -s .vim/vimrc .vimrc
        vim +PlugInstall +qall
        cd ~/.vim/plugged/vimproc.vim && make

for Haskell

        cabal install ghc-mod

And you're done.
