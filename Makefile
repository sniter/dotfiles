arch:
	sudo pacman -S \
	gnome wl-clipboard chromium \
	zsh alacritty kitty neovim \
	stow git openssh \
	aria2 bat eza fd fzf jq htop less ripgrep starship tmux \
	noto-fonts-emoji ttc-iosevka ttf-iosevkaterm-nerd ttf-font-awesome ttf-firacode-nerd \
	jdk21-openjdk openjdk21-src

zsh4humans:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/romkatv/zsh4humans/v5/install)"

linux: arch zsh4humans
