linux/arch: \
	linux/arch/packages \
	linux/arch/kde \
	linux/bluetooth/enable \
	zsh/antidote \
	linux/zsh/default \
	linux/dotfiles \
	ssh/github

linux/arch/packages:
	sudo pacman -S \
	wl-clipboard firefox bitwarden \
	zsh alacritty ghostty \
	emacs-nox neovim \
	stow git lazygit openssh \
	aria2 bat eza fd fzf jq htop less ripgrep starship tmux \
	noto-fonts-emoji ttc-iosevka ttf-iosevkaterm-nerd ttf-font-awesome ttf-firacode-nerd ttf-ibmplex-mono-nerd\
	jdk21-openjdk openjdk21-src

linux/arch/gnome:
	sudo pacman -S gnome
	dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:caps_toggle','terminate:ctrl_alt_bksp']"
	sudo systemctl enable gdm.service
	# sudo systemctl start gdm.service

linux/arch/kde:
	sudo pacman -S plasma-desktop
	sudo systemctl enable sddm.service
	sudo systemctl start sddm.service

linux/bluetooth/enable:
	sudo systemctl enable bluetooth.service
	sudo systemctl start bluetooth.service

linux/dotfiles:
	mkdir enabled 
	stow -d available -t enabled \
		alacritty bat ghostty \
		git lazygit lazyvim \
		ssh tmux vim zsh4humans
	stow --dotfiles enabled

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

linux/zsh/default:
	@ZSH_PATH=$$(which zsh) && \
	echo "Changing shell to $$ZSH_PATH" && \
	chsh -s $$ZSH_PATH

zsh/antidote:
	git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
