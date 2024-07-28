XDG_CONFIG_HOME ?= $(HOME)/.config
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
CONFIG_DIR := $(DOTFILES_DIR)/config
UNAME := "$(shell uname)"

NAME := "dotenv"

.PHONY: alacritty
## alacritty: Setup symlink for alacritty
alacritty:
	@rm -rf $(XDG_CONFIG_HOME)/alacritty
	if [ "$(UNAME)" = "Linux" ]; then \
		ln -sf "$(CONFIG_DIR)/alacritty/linux/alacritty.toml" "$(CONFIG_DIR)/alacritty/alacritty.toml"; \
	elif [ "$(UNAME)" = "Darwin" ]; then \
		ln -sf "$(CONFIG_DIR)/alacritty/mac/alacritty.toml" "$(CONFIG_DIR)/alacritty/alacritty.toml"; \
	fi
	ln -sf "$(CONFIG_DIR)/alacritty" "$(XDG_CONFIG_HOME)/alacritty"

.PHONY: bashrc
## bashrc: Setup symlink for .bashrc
bashrc:
	@rm -f $(HOME)/.bashrc.conf
	@ln -sf "$(CONFIG_DIR)/bash/.bashrc" "$(HOME)/.bashrc"

.PHONY: config
## config: Setup user configuration
config:
	@if [ "$(UNAME)" = "Linux" ]; then \
			$(MAKE) config-linux; \
	elif [ "$(UNAME)" = "Darwin" ]; then \
			$(MAKE) config-mac; \
	fi

.PHONY: config-linux
config-linux: alacritty bashrc gitconfig nvim tmux ulauncher

.PHONY: config-mac
config-mac: gitconfig nvim tmux zsh

.PHONY: fonts
## fonts: Setup nerd fonts
fonts:
	@if [ "$(UNAME)" = "Linux" ]; then \
			$(MAKE) fonts-linux; \
	elif [ "$(UNAME)" = "Darwin" ]; thihen \
			$(MAKE) fonts-mac; \
	fi

.PHONY: fonts-linux
fonts-linux:
	@wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
	unzip CascadiaMono.zip -d CascadiaFont
	cp CascadiaFont/*.ttf $(HOME)/.local/share/fonts
	rm -rf CascadiaMono.zip CascadiaFont
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
	unzip JetBrainsMono.zip -d JetBrainsMono
	cp JetBrainsMono/*.ttf $(HOME)/.local/share/fonts
	rm -rf JetBrainsMono.zip JetBrainsMono
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
	unzip Meslo.zip -d Meslo
	cp Meslo/*ttf $(HOME)/.local/share/fonts
	rm -rf Meslo.zip Meslo
	fc-cache


.PHONY: fonts-mac
fonts-mac:
	@wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
	unzip CascadiaMono.zip -d CascadiaFont
	cp CascadiaFont/*.ttf $(HOME)/Library/Fonts/
	rm -rf CascadiaMono.zip CascadiaFont
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
	unzip JetBrainsMono.zip -d JetBrainsMono
	cp JetBrainsMono/*.ttf $(HOME)/Library/Fonts/
	rm -rf JetBrainsMono.zip JetBrainsMono
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip
	unzip Meslo.zip -d Meslo
	cp Meslo/*ttf $(HOME)/Library/Fonts/
	rm -rf Meslo.zip Meslo

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

.PHONY: zsh
## zsh: Setup symlink for zsh configuration
zsh:
	@rm -rf $(HOME)/.zshrc
	@rm -rf $(HOME)/.p10k.zsh
	@ln -sf "$(CONFIG_DIR)/zsh/.zshrc" "$(HOME)/.zshrc"
	@ln -sf "$(CONFIG_DIR)/zsh/.p10k.zsh" "$(HOME)/.p10k.zsh"

.PHONY: help
all: help
# help: show help message
help: Makefile
	@echo
	@echo " Choose a command to run in "$(NAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo
