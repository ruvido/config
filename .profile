export ENV="$HOME/.profile"
export PATH=$PATH:$HOME/bin
export EDITOR=nvim
alias vi=nvim
alias web="python -m http.server 8080"
alias c="cd $HOME/.config; cp $HOME/.profile .; git add .;git commit -a -m 'bum'; git push"
