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
export COLORTERM="truecolor"
export EDITOR=nvim
export LANG=en_US.UTF-8
export TERM="xterm-256color"
export VISUAL=nvim

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
export PATH="$PATH:/snap/bin"
export PATH="$PATH:/var/lib/snapd/snap/bin"

# User aliases
alias dev='cd ~/Dev'
alias fm='frogmouth'
alias kubectl='microk8s kubectl'
alias ld='lazydocker'
alias lg='lazygit'
alias mkvenv='virtualenv .venv'
alias ohmyzsh="mate ~/.oh-my-zshi"
alias pbcopy='xclip -selection clipboard'
alias pi='ssh hajizar@pi.local'
alias requirements='pip install -r requirements.txt'
alias rmvenv='rm -rf .venv'
alias tkill='tmux kill-session -t'
alias tls='tmux ls'
alias tselect='tmux attach-session -t'
alias tms='transmission-cli'
alias venv='source .venv/bin/activate'
alias vim='nvim'
alias vz='vim ~/.zshrc'
alias zshconfig="mate ~/.zshrc"
alias zshrc='source ~/.zshrc'

# User function aliases
dpurge() {
  sudo docker stop $(sudo docker ps -q)
  sudo docker rm $(sudo docker ps -aq)
}

