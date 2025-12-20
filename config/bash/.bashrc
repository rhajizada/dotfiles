case $- in
*i*) ;;
*) return ;;
esac

# Path to your oh-my-bash installation.
export OSH="$HOME/.oh-my-bash"

# Docker segment for powerbash10k
function __pb10k_prompt_docker {
  # Check if running inside Docker
  if [[ -f /.dockerenv ]] || grep -q docker /proc/1/cgroup 2>/dev/null; then
    local color box info

    color=$_omb_prompt_bold_blue
    info=" "
    box=""

    printf "%s|%s|%s|%s" \
      "$color" \
      "$info" \
      "$_omb_prompt_bold_black" \
      "$box"
  fi
}

# OS segment for powerbash10k
function __pb10k_prompt_os {
  local color box info

  color=$_omb_prompt_bold_white
  box=""

  if [[ "$(uname)" == "Darwin" ]]; then
    info="macOS"
  else
    if [[ -r /etc/os-release ]]; then
      # shellcheck disable=SC1091
      . /etc/os-release
      info="${PRETTY_NAME:-$NAME}"
    else
      info="Linux"
    fi
  fi

  case "$info" in
  *Ubuntu*) info=" " ;;
  *Arch*) info=" " ;;
  *Debian*) info=" " ;;
  *Fedora*) info=" " ;;
  *macOS*) info=" " ;;
  *Rocky* | *Rocky\ Linux*) info=" " ;;
  *openSUSE*) info=" " ;;
  *) info=" " ;;
  esac

  printf "%s|%s|%s|%s" \
    "$color" \
    "$info" \
    "$_omb_prompt_bold_black" \
    "$box"
}

__PB10K_TOP_LEFT="os docker dir scm"

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-bash is loaded.
OSH_THEME="powerbash10k"

# To disable the uses of "sudo" by oh-my-bash, please set "false" to
# this variable.  The default behavior for the empty value is "true".
OMB_USE_SUDO=false

# To enable/disable display of Python virtualenv and condaenv
OMB_PROMPT_SHOW_PYTHON_VENV=true

# Which completions would you like to load? (completions can be found in ~/.oh-my-bash/completions/*)
# Custom completions may be added to ~/.oh-my-bash/custom/completions/
# Example format: completions=(ssh git bundler gem pip pip3)
# Add wisely, as too many completions slow down shell startup.
completions=(
  git
  composer
  ssh
)

# Which aliases would you like to load? (aliases can be found in ~/.oh-my-bash/aliases/*)
# Custom aliases may be added to ~/.oh-my-bash/custom/aliases/
# Example format: aliases=(vagrant composer git-avh)
# Add wisely, as too many aliases slow down shell startup.
aliases=(
  general
)

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bashmarks
  pyenv
)

# Which plugins would you like to conditionally load? (plugins can be found in ~/.oh-my-bash/plugins/*)
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
# Example format:
#  if [ "$DISPLAY" ] || [ "$SSH" ]; then
#      plugins+=(tmux-autoattach)
#  fi

source "$OSH"/oh-my-bash.sh

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-bash libs,
# plugins, and themes. Aliases can be placed here, though oh-my-bash
# users are encouraged to define aliases within the OSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias bashconfig="mate ~/.bashrc"
# alias ohmybash="mate ~/.oh-my-bash"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Open tmux by default
# if command -v tmux &>/dev/null && [ -n "$ps1" ] && [[ ! "$term" =~ screen ]] && [[ ! "$term" =~ tmux ]] && [ -z "$tmux" ]; then
#   exec tmux
# fi

# Default editor
export VISUAL=nvim
export EDITOR=nvim

# Shell integration for 'fzf'
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --bash)
fi

# Initializing nodenv
if command -v fzf >/dev/null 2>&1; then
  eval "$(nodenv init -)"
fi

# User aliases
alias bashrc='source ~/.bashrc'
alias dev='cd ~/Dev'
alias ld='lazydocker'
alias lg='lazygit'
alias pbcopy='xclip -selection clipboard'
alias vb='vim ~/.bashrc'
alias venv='source .venv/bin/activate'
alias vim='nvim'

# Sourcing local packages
export PATH="$HOME/.local/bin:$PATH"

# Homebrew packages
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

# Snap packages
export PATH="$PATH:/snap/bin"
export PATH="$PATH:/var/lib/snapd/snap/bin"

# NPM packages
export PATH="$(npm config get prefix)/bin:$PATH"
