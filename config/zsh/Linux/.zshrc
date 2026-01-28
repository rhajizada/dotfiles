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
plugins=(alias-finder aliases archlinux brew dotenv git gitignore golang python)

# Sourcing 'omz'
source $ZSH/oh-my-zsh.sh

# Sourcing 'p10k'
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Configuration for 'alias-finder' plugin
zstyle ':omz:plugins:alias-finder' autoload yes
zstyle ':omz:plugins:alias-finder' cheaper yes

# User configuration
export COLORTERM="truecolor"
export EDITOR=nvim
export LANG=en_US.UTF-8
export TERM="xterm-256color"
export VISUAL=nvim

export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:/var/lib/snapd/snap/bin"

# Configuration for 'python' plugin
export PYTHON_VENV_NAME=".venv"
export PYTHON_AUTO_VRUN=true

# User aliases
alias dev='cd ~/Dev'
alias fzf='fzf --tmux'
alias ld='lazydocker'
alias lg='lazygit'
alias pbcopy='xclip -selection clipboard'
alias pi='ssh hajizar@pi.local'
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias tf='terraform'
alias tkss='tmux kill-session -t'
alias tksv='tmux kill-server'
alias tl='tmux list-sessions'
alias tms='transmission-cli'
alias ts='tmux new-session -s'
alias vim='nvim'

# Shell integration / auto-completion
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

if command -v cradle &> /dev/null; then
  eval "$(cradle completion zsh)"
fi

if command -v docker &> /dev/null; then
  fpath=($HOME/.docker/completions $fpath)
  autoload -Uz compinit
  compinit
fi

if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

if command -v task &> /dev/null; then
  eval "$(task --completion zsh)"
fi

