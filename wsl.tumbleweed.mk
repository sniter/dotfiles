include config.mk
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

