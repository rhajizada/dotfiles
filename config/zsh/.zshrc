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
plugins=(git)

# Sourcing 'omz'
source $ZSH/oh-my-zsh.sh

# Sourcing 'p10k'
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Start tmux automatically
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux
fi

# User configuration
export LANG=en_US.UTF-8
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export LESSOPEN="|pygmentize -g %s"

# User aliases
export TERM="xterm-256color"
export COLORTERM="truecolor"
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zshi"
alias zshrc='source ~/.zshrc'
alias dev='cd ~/Dev'
alias vim='nvim'
alias vz='vim ~/.zshrc'
alias tls='tmux ls'
alias tkill='tmux kill-session -t'
alias pi='ssh hajizar@pi.local'
alias starman='ssh hajizar@starman.local'
alias venv='source .venv/bin/activate'
alias mkvenv='virtualenv .venv'
alias rmvenv='rm -rf .venv'
alias tselect='tmux attach-session -t'
alias requirements='pip install -r requirements.txt'
alias lg='lazygit'
alias ld='lazydocker'


