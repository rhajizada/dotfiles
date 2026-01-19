.DEFAULT_GOAL := help
NAME := "dotfiles"
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
CONFIG_DIR := $(DOTFILES_DIR)/config
UNAME := "$(shell uname)"
XDG_CONFIG_HOME ?= $(HOME)/.config
BACKUP_DIR := $(HOME)/.dotfiles.backup.$(shell date +%Y%m%d_%H%M%S)

ifeq ($(OS),Windows_NT)
$(error Windows is not supported)
endif

.PHONY: alacritty
## alacritty: 🖥️ Setup symlink for alacritty configuration
alacritty:
	@echo "🖥️  Setting up alacritty configuration..."
	@rm -rf $(XDG_CONFIG_HOME)/alacritty
	@ln -sf "$(CONFIG_DIR)/alacritty/$(UNAME)/alacritty.toml" "$(CONFIG_DIR)/alacritty/alacritty.toml"; \
	ln -sf "$(CONFIG_DIR)/alacritty" "$(XDG_CONFIG_HOME)/alacritty"
	@echo "✅ Alacritty configured!"

.PHONY: bashrc
## bashrc: 🐚 Setup symlink for .bashrc
bashrc:
	@echo "🐚 Setting up bash configuration..."
	@if [ ! -d "$(HOME)/.oh-my-bash" ]; then \
		echo "📥 Installing oh-my-bash..."; \
		git clone https://github.com/ohmybash/oh-my-bash.git $(HOME)/.oh-my-bash; \
	fi
	@rm -f $(HOME)/.bashrc.conf
	@ln -sf "$(CONFIG_DIR)/bash/.bashrc" "$(HOME)/.bashrc"
	@echo "✅ Bash configured!"

.PHONY: cradle
## cradle: 👶 Setup symlink for cradle configuration
cradle:
	@echo "👶 Setting up cradle configuration..."
	@rm -rf "$(XDG_CONFIG_HOME)/cradle"
	@ln -sf "$(CONFIG_DIR)/cradle" "$(XDG_CONFIG_HOME)/cradle"
	@echo "✅ Cradle configured!"


.PHONY: brew
## brew: 🍺 Install brew and brew packages
brew:
	@echo "🍺 Setting up Homebrew..."
	@which brew >/dev/null 2>&1 || { \
		echo "📥 Installing Homebrew..."; \
		/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; \
	}
	@if [ "$(UNAME)" = "Darwin" ]; then \
		export PATH="/opt/homebrew/bin:$(PATH)"; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"; \
	fi; \
	brewfile="requirements/$(UNAME)/Brewfile"; \
	brew bundle --file $${brewfile}
	@echo "✅ Homebrew setup complete!"

.PHONY: config
## config: ⚙️ Setup user configuration
config:
	@echo "⚙️ Setting up user configuration..."
	@if [ "$(UNAME)" = "Linux" ]; then \
		$(MAKE) alacritty bashrc cradle gitconfig nvim tmux ulauncher zshrc; \
	elif [ "$(UNAME)" = "Darwin" ]; then \
		$(MAKE) cradle ghostty gitconfig nvim tmux zshrc; \
	fi
	@echo "✅ Configuration complete!"

.PHONY: codex
## codex: 🧭 Setup symlink for codex configuration
codex:
	@echo "🧭 Setting up codex configuration..."
	@rm -rf "$(XDG_CONFIG_HOME)/codex"
	@ln -sf "$(CONFIG_DIR)/codex" "$(XDG_CONFIG_HOME)/codex"
	@echo "✅ codex configured!"

.PHONY: opencode
## opencode: 🧭 Setup symlink for opencode configuration
opencode:
	@echo "🧭 Setting up opencode configuration..."
	@rm -rf "$(XDG_CONFIG_HOME)/opencode"
	@ln -sf "$(CONFIG_DIR)/opencode" "$(XDG_CONFIG_HOME)/opencode"
	@echo "✅ opencode configured!"

.PHONY: fonts
## fonts: 🔤 Setup nerd fonts
fonts:
	@echo "🔤 Installing Nerd Fonts..."
	@if [ "$(UNAME)" = "Darwin" ]; then \
		FONTS_DIR="$(HOME)/Library/Fonts"; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		FONTS_DIR="$(HOME)/.local/share/fonts"; \
	else \
		echo "Unsupported OS: $(UNAME)"; exit 1; \
	fi; \
	cd /tmp && { \
		for FONT in CascadiaMono JetBrainsMono Meslo; do \
			if ls "$${FONTS_DIR}/"*$${FONT}*.ttf >/dev/null 2>&1; then \
				echo "✅ $${FONT} already installed; skipping."; \
				continue; \
			fi; \
			if command -v wget >/dev/null 2>&1; then \
				wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$${FONT}.zip; \
			else \
				curl -fL -o $${FONT}.zip https://github.com/ryanoasis/nerd-fonts/releases/latest/download/$${FONT}.zip; \
			fi; \
			unzip $${FONT}.zip -d $${FONT} && \
			cp $${FONT}/*.ttf $${FONTS_DIR}/ && \
			rm -rf $${FONT}.zip $${FONT}; \
		done; \
		if [ "$(UNAME)" = "Linux" ]; then \
			echo "🔄 Refreshing font cache..."; \
			fc-cache -fv; \
		fi; \
	}
	@echo "✅ Fonts installed!"

.PHONY: gitconfig
## gitconfig: ⚙️ Setup symlink for gitconfig
gitconfig:
	@echo "⚙️  Setting up git configuration..."
	@rm -f $(HOME)/.gitconfig
	@ln -sf "$(CONFIG_DIR)/git/.gitconfig" "$(HOME)/.gitconfig"
	@echo "✅ Git configured!"

.PHONY: ghostty
## ghostty: 👻 Setup symlink for ghostty configuration
ghostty:
	@echo "👻 Setting up ghostty configuration..."
	@rm -rf $(XDG_CONFIG_HOME)/ghostty
	@mkdir -p "$(XDG_CONFIG_HOME)/ghostty"
	@ln -sf "$(CONFIG_DIR)/ghostty/$(UNAME)/config" "$(XDG_CONFIG_HOME)/ghostty/config"
	@ln -sf "$(CONFIG_DIR)/ghostty/themes" "$(XDG_CONFIG_HOME)/ghostty/themes"
	@echo "✅ Ghostty configured!"

.PHONY: nvim
## nvim: 📝 Setup and install neovim configuration
nvim:
	@echo "📝 Setting up neovim configuration..."
	@rm -rf $(XDG_CONFIG_HOME)/nvim
	@rm -rf $(HOME)/.local/share/nvim
	@ln -sf "$(CONFIG_DIR)/nvim" "$(XDG_CONFIG_HOME)/nvim"
	@nvim --headless +"Lazy! sync" +qa
	@echo "✅ Neovim configured!"

.PHONY: tmux
## tmux: 🖼️ Setup symlink for tmux configuration
tmux:
	@echo "🖼️ Setting up tmux configuration..."
	@if [ ! -d "$(HOME)/.tmux/plugins/tpm" ]; then \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
	fi
	@rm -f $(HOME)/.tmux.conf
	@ln -sf "$(CONFIG_DIR)/tmux/$(UNAME)/.tmux.conf" "$(HOME)/.tmux.conf"
	@echo "✅ Tmux configured!"

.PHONY: ulauncher
## ulauncher: 🚀 Setup symlink for ulauncher configuration
ulauncher:
	@echo "🚀 Setting up ulauncher configuration..."
	@rm -rf $(XDG_CONFIG_HOME)/ulauncher
	@ln -sf "$(CONFIG_DIR)/ulauncher" "$(XDG_CONFIG_HOME)/ulauncher"
	@if [ ! -d "$(CONFIG_DIR)/ulauncher/user-themes/Ulauncher-Essential-Dark-Theme" ]; then \
		echo "🎨 Installing 'Ulauncher-Essential-Dark-Theme' theme..."; \
		git clone https://github.com/GiorgioReale/Ulauncher-Essential-Dark-Theme.git $(CONFIG_DIR)/ulauncher/user-themes/Ulauncher-Essential-Dark-Theme; \
	fi
	@echo "✅ Ulauncher configured!"

.PHONY: zshrc
## zshrc: 🐚 Setup symlink for zsh configuration
zshrc:
	@echo "🐚 Setting up zsh configuration..."
	@if [ ! -d "$(HOME)/.oh-my-zsh" ]; then \
		git clone https://github.com/ohmyzsh/ohmyzsh.git $(HOME)/.oh-my-zsh; \
	fi
	@if [ ! -d $(HOME)/.oh-my-zsh/themes/powerlevel10k ]; then \
		git clone https://github.com/romkatv/powerlevel10k.git $(HOME)/.oh-my-zsh/themes/powerlevel10k; \
	fi
	@rm -rf $(HOME)/.zshrc
	@rm -rf $(HOME)/.p10k.zsh
	@ln -sf "$(CONFIG_DIR)/zsh/$(UNAME)/.zshrc" "$(HOME)/.zshrc"
	@ln -sf "$(CONFIG_DIR)/zsh/$(UNAME)/.p10k.zsh" "$(HOME)/.p10k.zsh"

.PHONY: update
## update: 🔄 Update brew packages and plugin managers
update:
	@echo "📦 Updating Homebrew packages..."
	@brew update && brew upgrade
	@if [ "$(UNAME)" = "Darwin" ]; then \
		echo "🔧 Updating oh-my-zsh..."; \
		[ -d "$(HOME)/.oh-my-zsh" ] && cd $(HOME)/.oh-my-zsh && git pull || true; \
		echo "🎨 Updating powerlevel10k..."; \
		[ -d "$(HOME)/.oh-my-zsh/custom/themes/powerlevel10k" ] && \
			cd $(HOME)/.oh-my-zsh/custom/themes/powerlevel10k && git pull || true; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		echo "🔧 Updating oh-my-bash..."; \
		[ -d "$(HOME)/.oh-my-bash" ] && cd $(HOME)/.oh-my-bash && git pull || true; \
	fi
	@echo "🔌 Updating tmux plugin manager..."
	@[ -d "$(HOME)/.tmux/plugins/tpm" ] && cd $(HOME)/.tmux/plugins/tpm && git pull || true
	@echo "✅ Updates complete!"

.PHONY: doctor
## doctor: 🔍 Check if required tools are installed
doctor:
	@echo "🔍 Checking system dependencies..."
	@echo "\n📦 Homebrew packages:"
	@brewfile="requirements/$(UNAME)/Brewfile"; \
	if [ -f "$${brewfile}" ]; then \
		grep '^brew ' $${brewfile} | sed 's/brew "\(.*\)"/\1/' | while read -r pkg; do \
			pkg_name=$$(echo $$pkg | sed 's/.*\///'); \
			brew list $$pkg_name >/dev/null 2>&1 && echo "  ✅ $$pkg_name" || echo "  ❌ $$pkg_name"; \
		done; \
	else \
		echo "  ⚠️  Brewfile not found for $(UNAME)"; \
	fi
	@echo "\n🔧 Shell configurations:"
	@if [ "$(UNAME)" = "Darwin" ]; then \
		[ -d "$(HOME)/.oh-my-zsh" ] && echo "  ✅ oh-my-zsh" || echo "  ❌ oh-my-zsh"; \
		[ -d "$(HOME)/.oh-my-zsh/custom/themes/powerlevel10k" ] && echo "  ✅ powerlevel10k" || echo "  ❌ powerlevel10k"; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		[ -d "$(HOME)/.oh-my-bash" ] && echo "  ✅ oh-my-bash" || echo "  ❌ oh-my-bash"; \
	fi
	@[ -d "$(HOME)/.tmux/plugins/tpm" ] && echo "  ✅ tmux plugin manager" || echo "  ❌ tmux plugin manager"
	@echo "\n🔗 Symlink status:"
	@if [ "$(UNAME)" = "Darwin" ]; then \
		ls -la $(HOME)/.zshrc 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ .zshrc" || echo "  ❌ .zshrc"; \
		ls -la $(HOME)/.p10k.zsh 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ .p10k.zsh" || echo "  ❌ .p10k.zsh"; \
		ls -la $(XDG_CONFIG_HOME)/ghostty 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ ghostty" || echo "  ❌ ghostty"; \
	elif [ "$(UNAME)" = "Linux" ]; then \
		ls -la $(HOME)/.bashrc 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ .bashrc" || echo "  ❌ .bashrc"; \
	fi
	@ls -la $(HOME)/.gitconfig 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ .gitconfig" || echo "  ❌ .gitconfig"
	@ls -la $(HOME)/.tmux.conf 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ .tmux.conf" || echo "  ❌ .tmux.conf"
	@ls -la $(XDG_CONFIG_HOME)/nvim 2>/dev/null | grep -q "$(CONFIG_DIR)" && echo "  ✅ nvim" || echo "  ❌ nvim"

.PHONY: docker
## docker: 🐳 Build Docker image with environment setup
docker:
	@echo "🐳 Building Docker image..."
	@docker build --build-arg USERNAME=$$USER -t dotfiles . --platform linux/amd64
	@echo "✅ Docker image built!"

.PHONY: shell
## shell: 🐚 Launch shell inside built docker container
shell: docker
	@echo "🐚 Launching container shell..."
	@docker run -it -v dotfiles:/home/$$USER dotfiles

.PHONY: help
## help: Show help message
help: Makefile
	@echo " List of available targets for \"$(NAME)\":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo
