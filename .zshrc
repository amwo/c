export LC_ALL=en_US.UTF-8
PROMPT="%n %~ "

autoload -Uz colors
colors

autoload -Uz compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

setopt no_beep
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt auto_pushd

alias v='vim -u ~/.config/vim/.vimrc'
alias so='source'
alias t='tmux'
alias vsn='v ~/.config/plugged/vim-snippets/snippets/'
alias vrc='v ~/.config/vim/.vimrc'
