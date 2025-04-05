linux/arch: \
	linux/arch/packages \
	linux/gnome/keyboard \
	linux/gdm/enable \
	linux/bluetooth/enable \
	zsh/antidote \
	zsh/default \
	tmux/tpm \
	linux/dotfiles

linux/arch/packages:
	sudo pacman -S \
	wl-clipboard chromium bitwarden \
	zsh ghostty \
	emacs-nox neovim \
	stow git lazygit openssh \
	aria2 bat eza fd fzf jq htop less ripgrep starship tmux \
	noto-fonts-emoji ttc-iosevka ttf-iosevkaterm-nerd ttf-font-awesome ttf-firacode-nerd \
	jdk21-openjdk openjdk21-src

linux/dotfiles:
	stow \
	ghostty \
	emacs nvim vim \
	git lazygit \
	ssh starship tmux zsh-linux

linux/gnome/keyboard:
	dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:caps_toggle','terminate:ctrl_alt_bksp']"

linux/gdm/enable:
	sudo systemctl enable gdm.service
	sudo systemctl start gdm.service

linux/bluetooth/enable:
	sudo systemctl enable bluetooth.service
	sudo systemctl start bluetooth.service

mac/brew: \
	mac/brew/packages \
	zsh/antidote \
	zsh/default \
	tmux/tpm \
	mac/dotfiles

mac/ports: \
	mac/ports/packages \
	zsh/antidote \
	zsh/default \
	tmux/tpm \
	mac/dotfiles

mac/brew/packages:
	brew install \
		neovim \
		stow lazygit \
		aria2 bat eza fd fzf jq ripgrep starship tmux \
		rust opam haskell-stack coursier \
		font-fira-mono-nerd-font
	brew install --cask ghostty
	brew install --cask oracle-jdk
	# Emacs
	brew tap d12frosted/emacs-plus
	brew install emacs-plus \
	    --with-native-comp \
	    --with-savchenkovaleriy-big-sur-3d-icon

mac/ports/packages:
	sudo port install \
		alacritty \
		neovim \
		aria2 bat eza fd fzf jq ripgrep starship tmux \
		rust tust-src opam stack openjdk21-oracle 

ssh/github:
	mkdir -p ~/.ssh/github.com/git
	ssh-keygen -t ed25519 -C "sniter@gmail.com" -f ~/.ssh/github.com/git/id_ed25519

tmux/tpm: 
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

zsh/default:
	@ZSH_PATH=$$(which zsh) && \
	echo "Changing shell to $$ZSH_PATH" && \
	chsh -s $$ZSH_PATH

zsh/antidote:
	git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote


