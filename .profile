# ~/.profile
# PS1='\[\033[1;38;5;208m\]\u \[\033[1;34m\]$(pwd | sed "s|^$HOME|~|" | awk -F/ "{print \$NF}")\[\033[1;32m\]$(git branch 2>/dev/null | sed -n "s/^\* \(.*\)/  \1/p") \[\033[1;32m\]❯\[\033[0m\] '
PS1='\[\033[1;34m\]$(pwd | sed "s|^$HOME|~|" | awk -F/ "{print \$NF}")\[\033[1;32m\]$(git branch 2>/dev/null | sed -n "s/^\* \(.*\)/  \1/p") \[\033[1;38;5;208m\]❯\[\033[0m\] '

export ENV="$HOME/.profile"
export PATH=$PATH:$HOME/bin
export EDITOR=nvim
export FLYCTL_INSTALL="/home/ruvido/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
alias bc="bc -l"
alias vi=nvim
alias web="python -m http.server 8080"
alias c="cd $HOME/.config; cp $HOME/.profile .; git add .;git commit -a -m 'bum'; git push"
alias vps="mosh 139.162.133.217"
alias apps="ssh -p 9911 vps"
alias ss="echo source .profile && source $HOME/.profile"
alias dp="git pull && git add . && git commit -a -m 'commit'&& git push"
alias hdp="git submodule update --remote --merge && git add . && git commit -a -m 'commit'&& git push"
alias pp="cd /run/media/ruvido/P4_SD/ && yazi"
