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
