FROM archlinux
ARG USERNAME
RUN pacman -Sy --noconfirm && \
  pacman -S --noconfirm base-devel git curl zsh sudo
RUN useradd -m -s /bin/zsh "${USERNAME}" && \
  echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME=/home/${USERNAME}
ENV XDG_CONFIG_HOME=${HOME}/.config
COPY config/nvim ${XDG_CONFIG_HOME}/nvim
COPY config/tmux/Linux/.tmux.conf ${HOME}/.tmux.conf
COPY config/zsh/Linux/.zshrc ${HOME}/.zshrc
COPY config/zsh/Linux/.p10k.zsh ${HOME}/.p10k.zsh
COPY config/git/.gitconfig ${HOME}/.gitconfig
RUN chown -R "${USERNAME}:${USERNAME}" "/home/${USERNAME}"
ENV NONINTERACTIVE=1
USER ${USERNAME}
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git ${HOME}/.oh-my-zsh && \
  git clone https://github.com/romkatv/powerlevel10k.git ${HOME}/.oh-my-zsh/themes/powerlevel10k && \
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"
COPY requirements/Linux/Brewfile /etc/dotfiles/Brewfile
RUN brew bundle --file=/etc/dotfiles/Brewfile
RUN nvim --headless +"Lazy! restore" +qa
VOLUME ["/home/${USERNAME}"]
CMD ["/bin/zsh"]

