arch:
	sudo pacman -S \
	gnome wl-clipboard chromium \
	zsh alacritty kitty ghostty \
	emacs-nox neovim \
	stow git openssh \
	aria2 bat eza fd fzf jq htop less ripgrep starship tmux \
	noto-fonts-emoji ttc-iosevka ttf-iosevkaterm-nerd ttf-font-awesome ttf-firacode-nerd \
	jdk21-openjdk openjdk21-src

zsh/antidote:
	git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote

tmux/tpm: 
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

dotfiles/linux:
	stow \
	alacritty kitty ghostty\
	emacs nvim vim \
	git lazygit \
	ssh starship tmux zsh-linux

linux: arch zsh/antidote tmux/tpm dotfiles/linux
