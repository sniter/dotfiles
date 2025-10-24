linux/arch: \
	linux/arch/packages \
	linux/arch/package/xorg \
	linux/arch/bluetooth/enable \
	common/zsh/default \
	linux/arch/dotfiles \
	common/ssh/github

linux/arch/packages:
	sudo pacman -S \
		firefox bitwarden \
		zsh alacritty kitty ghostty \
		helix neovim vim \
		stow git lazygit openssh \
		atop btop htop \
		wget aria2 yt-dlp \
		bat eza fd fzf jq less ripgrep tmux zoxide \
		base-devel
		

linux/arch/package/java:
	sudo pacman -S \
		jdk21-openjdk openjdk21-src

linux/arch/package/xorg:
	sudo pacman -S \
		xorg xorg xorg-apps xorg-xinit \
		brightnessctl xbindkeys \
		ttf-ibmplex-mono-nerd ttf-ibm-plex \
		mesa xf86-video-intel vulkan-intel libva-intel-driver intel-media-driver mesa-utils vulkan-tools libva-utils

linux/arch/package/dwm:
	# TODO: Git glone for suckless projects
	sudo pacman -S \
		picom nsxiv imagemagick feh nitrogen python-pipx
	pipx install pywal16

linux/arch/package/yay:
	sudo pacman -S --needed git base-devel
 	git clone https://aur.archlinux.org/yay.git ~/apps/yay
	cd ~/apps/yay && makepkg -si

linux/arch/package/kew: linux/arch/package/yay
	yay -S kew
	sudo pacman -S libnotify dunst playerctl

linux/arch/X11:
	sudo rm /etc/X11/xorg.conf.d/00-keyboard.conf
	sudo stow -t / arch

linux/arch/gnome:
	sudo pacman -S gnome
	dconf write /org/gnome/desktop/input-sources/xkb-options "['grp:caps_toggle','terminate:ctrl_alt_bksp']"
	sudo systemctl enable gdm.service
	# sudo systemctl start gdm.service

linux/arch/kde:
	sudo pacman -S plasma-desktop
	sudo systemctl enable sddm.service
	sudo systemctl start sddm.service

linux/arch/bluetooth/enable:
	sudo pacman -S bluez bluez-tools
	sudo systemctl enable bluetooth.service
	sudo systemctl start bluetooth.service

linux/arch/lazyvim/enable:
	sudo pacman -S neovim lazygit unzip

linux/arch/fonts:
	sudo pacman -S \
		noto-fonts-emoji \
		ttc-iosevka \
		ttf-iosevkaterm-nerd \
		ttf-font-awesome \
		ttf-firacode-nerd \
		ttf-ibmplex-mono-nerd

linux/arch/sway/enable: \
	linux/arch/bluetooth/enable
	sudo pacman -S sway swaylock swayidle swaybg lemurs brightnessctl
	sudo systemctl enable lemurs.service
	sudo systemctl enable lemurs.service

# TODO: yay + kew
linux/arch/dotfiles: common/dotfiles/enabled
	stow -d available -t enabled \
		alacritty kitty ghostty bat \
		git lazygit lazyvim vim helix  \
		ssh tmux sesh x11-dwm wal picom \
		zsh-commons zsh-antidote
	stow --dotfiles enabled

########################################################################################
# 
# MAC OS
#
########################################################################################

mac/brew: \
	mac/brew/packages \
	common/zsh/default \
	mac/dotfiles

mac/ports: \
	mac/ports/packages \
	common/zsh/default \
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

########################################################################################
# 
# COMMON
#
########################################################################################
common/zsh/default:
	@ZSH_PATH=$$(which zsh) && \
	echo "Changing shell to $$ZSH_PATH" && \
	chsh -s $$ZSH_PATH

common/ssh/github:
	mkdir -p ~/.ssh/github.com/git
	ssh-keygen -t ed25519 -C "sniter@gmail.com" -f ~/.ssh/github.com/git/id_ed25519
	cat ~/.ssh/github.com/git/id_ed25519.pub

common/dotfiles/enabled:
	mkdir -p enabled
	
########################################################################################
# 
# Nixos
#
########################################################################################
nixos/hardware-configuration.nix:
	sudo rm /etc/nixos/configuration.nix
	sudo ln -snf nixos/configuration.nix /etc/nixos/configuration.nix
	sudo chown ilya: nixos/configuration.nix
	sudo cp /etc/nixos/hardware-configuration.nix nixos/
	sudo nixos-rebuild switch
	
nixos/dotfiles: common/dotfiles/enabled
	stow -d available -t enabled \
		alacritty ghostty kitty \
		bat \
		vim lazyvim helix \
		git lazygit \
		ssh tmux sesh \
		zsh-commons zsh-antidote
	stow --dotfiles enabled

nixos/25.05: \
	common/ssh/github \
	nixos/hardware-configuration.nix \
	nixos/dotfiles

########################################################################################
# 
# WSL
#
########################################################################################
wsl/tumbleweed/packages:
	sudo zypper install \
		 zsh stow tmux \
		 neovim helix vim \
		 git lazygit \
		 bat eza yazi \
		 fd fzf jq ripgrep \
		 curl wget aria2 \
		 binutils tar cmake make gcc

wsl/tumbleweed/dotfiles: common/dotfiles/enabled
	stow -d available -t enabled \
		alacritty bat \
		git lazygit lazyvim \
		ssh sway tmux vim \
		zsh-commons zsh-antidote
	stow --dotfiles enabled

wsl/tumbleweed: \
	ssh/github \
	wsl/tumbleweed/packages
