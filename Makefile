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

zsh/default:
	@ZSH_PATH=$$(which zsh) && \
	echo "Changing shell to $$ZSH_PATH" && \
	chsh -s $$ZSH_PATH

zsh/antidote:
	git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote

tmux/tpm: 
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

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


