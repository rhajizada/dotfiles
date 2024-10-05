# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Automatically updating 'omz'
zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' frequency 13

# Plugins
plugins=(alias-finder aliases brew dotenv git gitignore golang python)

# Sourcing 'omz'
source $ZSH/oh-my-zsh.sh

# Sourcing 'p10k'
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Start tmux automatically
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux
fi

# Configuration for 'alias-finder' plugin
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' cheaper yes

# User configuration
export COLORTERM="truecolor"
export LANG=en_US.UTF-8
export LESSOPEN="|pygmentize -g %s"
export TERM="xterm-256color"

export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Configuration for 'python' plugin
export PYTHON_VENV_NAME=".venv"
export PYTHON_AUTO_VRUN=true

# User aliases
alias dev='cd ~/Dev'
alias fm='frogmouth'
alias ld='lazydocker'
alias lg='lazygit'
alias ohmyzsh="mate ~/.oh-my-zshi"
alias pi='ssh hajizar@pi.local'
alias starman='ssh hajizar@starman.local'
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias tl='tmux list-sessions'
alias ts='tmux new-session -s'alias venv='source .venv/bin/activate'
alias vim='nvim'
alias vz='vim ~/.zshrc'
alias zshconfig="mate ~/.zshrc"
alias zshrc='source ~/.zshrc'

# User function aliases
dpurge() {
  sudo docker stop $(sudo docker ps -q)
  sudo docker rm $(sudo docker ps -aq)
}

