export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS="--multi --reverse --border --inline-info --preview '([ -e {} ] && (head -20 {} || tree -C {} | head -20 ) || (echo {})) 2> /dev/null' --preview-window=right:40%:wrap"
export FZF_CTRL_R_OPTS="--no-preview"
export FZF_CTRL_T_OPTS="--bind 'ctrl-x:execute(subl -a {})'"

# fzf bindigs
bindkey '^P' fzf-file-widget

# fzf + fd
export FZF_DEFAULT_COMMAND="(fd --hidden --exclude .git --follow || git ls-tree -r --name-only HEAD || (find . -path \"*/\.*\" -prune -o -type f -print -o -type l -print | sed s/^..//)) 2> /dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

eval $(thefuck --alias)
eval $(thefuck --alias fk)

export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
