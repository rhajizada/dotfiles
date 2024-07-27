XDG_CONFIG_HOME ?= $(HOME)/.config
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
CONFIG_DIR := $(DOTFILES_DIR)/config
UNAME := "$(shell uname)"

NAME := "dotenv"

.PHONY: alacritty
## alacritty: Setup symlink for alacritty
alacritty:
	@rm -rf $(XDG_CONFIG_HOME)/alacritty
	@ln -sf "$(CONFIG_DIR)/alacritty" "$(XDG_CONFIG_HOME)/alacritty"

.PHONY: bashrc
## bashrc: Setup symlink for .bashrc
bashrc:
	@rm -f $(HOME)/.bashrc.conf
	@ln -sf "$(CONFIG_DIR)/bash/.bashrc" "$(HOME)/.bashrc"

.PHONY: gitconfig
## gitconfig: Setup symlink for gitconfig
gitconfig:
	@rm -f $(HOME)/.gitconfig
	@ln -sf "$(CONFIG_DIR)/git/.gitconfig" "$(HOME)/.gitconfig"

.PHONY: nvim
## nvim: Setup symlink for nvim configuration
nvim:
	@rm -rf $(XDG_CONFIG_HOME)/nvim
	@ln -sf "$(CONFIG_DIR)/nvim" "$(XDG_CONFIG_HOME)/nvim"

.PHONY: tmux
## tmux: Setup symlink for tmux configuration
tmux:
	@rm -f $(HOME)/.tmux.conf
	@ln -sf "$(CONFIG_DIR)/tmux/.tmux.conf" "$(HOME)/.tmux.conf"

.PHONY: ulauncher
## ulauncher: Setup symlink for ulauncher configuration
ulauncher:
	@rm -rf $(XDG_CONFIG_HOME)/ulauncher
	@ln -sf "$(CONFIG_DIR)/ulauncher" "$(XDG_CONFIG_HOME)/ulauncher"

.PHONY: macos-config
## macos-config: Setup user configuration for macOS
macos-config: gitconfig nvim tmux

.PHONY: test
## test: Test target
test:
	@echo $(UNAME)

.PHONY: help
all: help
# help: show help message
help: Makefile
	@echo
	@echo " Choose a command to run in "$(NAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo
